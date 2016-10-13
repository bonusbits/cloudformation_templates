#!/bin/bash

# WIP

# User Variables
stack_name=bonusbits-prd-bastion-test
profile_name=bonusbits
template_url=https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/github/bastion.template
parameters_file_path=/Users/levon/aws/cloudformation_parameters/bonusbits/bonusbits-prd-bastion-test.json
iam_access=true
create_stack=true
update_stack=false

# Static Variables
# date_time=$(date +%Y%m%d-%H%M)
script_version=1.0.0_10-12-2016
# unset stack_name
# read -p "Enter Stack Name: " stack_name

# Determine if IAM Capabilities are Required
if [ $iam_access ]
then
  capability_iam=" --capabilities CAPABILITY_IAM"
else
  capability_iam=""
fi

# Set Task Type
if [ $create_stack ]
then
  task_type=create-stack
elif [ $update_stack ]
then
  task_type=update-stack
else
  task_type=create-stack
fi

function usage () {
usagemessage="
usage: $0 -cui -s [stack_name] -p [profile_name] -t [template_url] -f [parameters_json_path]

-s Stack Name       :  (Required)
-p AWS Profile      :  (Required)
-t Template URL     :  (Required)
-f Parameters File  :  (Required)
-i IAM Access       :  Default: (false)
-c Create Stack     :  Default: (true)
-u Update Stack     :  Default: (false)
"
    echo "$usagemessage";
}

function log() {
  DATETIME=$(date +%Y-%m-%d_%H:%M:%S)
  echo "[$DATETIME] $*"
  # echo "[$DATETIME] $*" | tee -a ${log_file}
}

function show_message {
	printf "$1\n"
	# printf "$1\n" | tee -a ${log_file}
}

function show_header {
  HEADER="
-----------------------------------------------------------------------------------------------------------------------
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-----------------------------------------------------------------------------------------------------------------------
CloudFormation Launcher
$script_version
-----------------------------------------------------------------------------------------------------------------------
PARAMETERS
-----------------------------------------------------------------------------------------------------------------------
PROFILE:          $profile_name
TEMPLATE URL:     $template_url
PARAMETERS FILE:  $parameters_file_path
ENABLE IAM:       $iam_access
TASK TYPE:        $task_type
-----------------------------------------------------------------------------------------------------------------------
  "
	echo "$HEADER";
}

# function get_args {
#   while [ "$1" != "" ]; do
#     case $1 in
#       -n | --stack-name ) shift
#         stack_name=$1
#         ;;
#       * )
#         log "$1 is not a valid parameter"
#         exit 1
#     esac
#     shift
#   done
# }

# function validate_args {
#   if [[ "$stack_name" == "" ]]; then
#     log 'A stack name is required!'
#     log './deploy -n <stack_name>'
#     exit 1
#   fi
# }

function exit_check {
	if [ $1 -eq 0 ]
	then
		echo "SUCCESS: $2" | tee -a ${log_file}
	else
		echo "ERROR: Exit Code $1 for $2" | tee -a ${log_file}
		exit $1
	fi
}

function exit_check_nolog {
	if [ $1 -eq 0 ]
	then
		echo "SUCCESS: $2"
	else
		echo "ERROR: Exit Code $1 for $2"
		exit $1
	fi
}

function run_stack_command {
  # Start
  show_header
  aws cloudformation ${task_type} --profile ${profile_name} \
                                  --stack-name ${stack_name}${capability_iam} \
                                  --template-url "${template_url}"  \
                                  --parameters file://${parameters_file_path}
  exit_check_nolog $? "Started Stack Command"
}

function monitor_stack_status {
  # Poll for Status
  # wait_time 5, max_waits 180 = 15 minutes
  wait_time=5
  max_waits=180
  count=1
  while :
  do
    STATUS=$(aws cloudformation describe-stacks --stack-name "$stack_name" --output text --query 'Stacks[*].StackStatus')
    exit_check_nolog $? "Loaded Status Check into Variable"
    log "Stack Status: ${STATUS}"
    if [[ "$STATUS" != "CREATE_COMPLETE" && $count -lt $max_waits ]]; then
        log "Create stack is not complete!"
        log "Attempt $count of $max_waits."
        log "Polling again in ${wait_time} seconds..."
        echo -e ''
        sleep $wait_time
        count=$(( count + 1 ))
    elif [ "$STATUS" == "CREATE_COMPLETE" ]; then
        log 'STATUS: Create Completed!'
    else
        log 'The stack has not created.  This probably means something went wrong.'
        break
    fi
  done
}

# Start
start_time=$(date +%s)
run_stack_command
monitor_stack_status

# End Time
end_time=$(date +%s)
show_message ''
show_message "ENDTIME: ($(date))"

# Run Time
elapsed=$(( (${end_time} - ${start_time}) / 60 ))
show_message "RUNTIME: ${elapsed} minutes"
exit 0
