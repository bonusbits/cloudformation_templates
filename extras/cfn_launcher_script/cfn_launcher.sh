#!/bin/bash

# !! WIP !!

# TODO: Add Properties YAML file read for variables

# User Variables
stack_name=bonusbits-dev-jenkins-test
profile_name=bonusbits
template_url=https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/github/jenkins-ec2master-ecsworkers.template
template_local=../labs/jenkins/jenkins-ec2master-ecsworkers.template
parameters_file_path=../parameter_examples/jenkins-ec2master-ecsworkers.json
iam_access=false
create_stack=true
#update_stack=false
delete_create_failures=true
successful=false
use_s3_template=false
log_file=./cfn_launcher.log

# Static Variables
# date_time=$(date +%Y%m%d-%H%M)
script_version=1.0.2_10-18-2016
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
if [ $create_stack ]; then
  task_type=create-stack
else
  task_type=update-stack
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
-l Log File         :  Default: ($HOME/cfn_launcher.log)
"
    echo "$usagemessage";
}

function message() {
  DATETIME=$(date +%Y-%m-%d_%H:%M:%S)
  echo "[$DATETIME] $*" | tee -a ${log_file}
}
# TODO: Combine these two functions and use arg to switch modes
function message_nofile() {
  DATETIME=$(date +%Y-%m-%d_%H:%M:%S)
  echo "[$DATETIME] $*"
}

#function show_message {
#	printf "$1\n"
#	# printf "$1\n" | tee -a ${log_file}
#}

function show_header {
  if [ "$use_s3_template" == "true" ]; then
    template_used=${template_url}
  else
    template_used=${template_local}
  fi

  HEADER="
-----------------------------------------------------------------------------------------------------------------------
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-----------------------------------------------------------------------------------------------------------------------
CloudFormation Launcher
$script_version
-----------------------------------------------------------------------------------------------------------------------
PARAMETERS
-----------------------------------------------------------------------------------------------------------------------
STACK NAME:       $stack_name
PROFILE:          $profile_name
TEMPLATE:         $template_used
PARAMETERS FILE:  $parameters_file_path
ENABLE IAM:       $iam_access
TASK TYPE:        $task_type
Log File:         $log_file
-----------------------------------------------------------------------------------------------------------------------
  "
	echo "$HEADER" | tee -a ${log_file};
}

# function get_args {
#   while [ "$1" != "" ]; do
#     case $1 in
#       -n | --stack-name ) shift
#         stack_name=$1
#         ;;
#       * )
#         message "$1 is not a valid parameter"
#         exit 1
#     esac
#     shift
#   done
# }

# function validate_args {
#   if [[ "$stack_name" == "" ]]; then
#     message 'A stack name is required!'
#     message './deploy -n <stack_name>'
#     exit 1
#   fi
# }

function exit_check {
	if [ $1 -eq 0 ]
	then
		message "REPORT: Success $2" | tee -a ${log_file}
	else
		message "ERROR: Exit Code $1 for $2" | tee -a ${log_file}
		exit $1
	fi
}
# TODO: Combine these two functions and have arg switch mode
function exit_check_nolog {
	if [ $1 -eq 0 ]
	then
		message_nofile "REPORT: Success $2"
	else
		message_nofile "ERROR: Exit Code $1 for $2"
		exit $1
	fi
}

function run_stack_command {
  show_header
  if [ "$use_s3_template" == "true" ]; then
    aws cloudformation ${task_type} --profile ${profile_name} \
                                    --stack-name ${stack_name}${capability_iam} \
                                    --template-url "${template_url}"  \
                                    --parameters file://${parameters_file_path}
  else
    aws cloudformation ${task_type} --profile ${profile_name} \
                                    --stack-name ${stack_name}${capability_iam} \
                                    --template-body file://${template_local}  \
                                    --parameters file://${parameters_file_path}
  fi
  exit_check $? "Started Stack Command"
}

function delete_stack_command {
  message 'ACTION: Deleting Stack'
  aws cloudformation delete-stack --profile ${profile_name} --stack-name ${stack_name}
  exit_check $? "Deleting Stack Command"
}

function monitor_stack_status {
  # Poll for Status
  # wait_time 5, max_waits 180 = 15 minutes

  if [ "$task_type" == "create-stack" ]; then
    ACTION=CREATE
  elif [ "$task_type" == "update-stack" ]; then
    ACTION=UPDATE
  else
    ACTION=CREATE
  fi

  wait_time=5
  max_waits=180
  count=1
  delete_triggered=false
  while :
  do
    STATUS=$(aws cloudformation describe-stacks --stack-name "$stack_name" --output text --query 'Stacks[*].StackStatus')
    exit_check $? "Loaded Status Check into Variable"
    message "REPORT: Status (${STATUS})"

    if [[ "$STATUS" == "${ACTION}_IN_PROGRESS" && $count -lt $max_waits ]]; then
      message "REPORT: ${ACTION} stack is not complete!"
      message "REPORT: Attempt $count of $max_waits."
      message "REPORT: Polling again in ${wait_time} seconds..."
      echo '' | tee -a ${log_file}
      sleep $wait_time
      count=$(( count + 1 ))
    elif [ "$STATUS" == "${ACTION}_COMPLETE" ]; then
      message 'REPORT: ${ACTION} Completed!'
      successful=true
      break
    elif [ "$STATUS" == "${ACTION}_FAILED" ]; then
      message 'ERROR: ${ACTION} Failed!'
      successful=false
    elif [ "$STATUS" == "ROLLBACK_IN_PROGRESS" ]; then
      if [[ "$task_type" == "create-stack" && "$delete_create_failures" == "true" ]]; then
        message 'ERROR: Failed and Rolling Back!'
#        aws cloudformation describe-stack-events --stack-name ${stack_name}
        aws cloudformation describe-stack-events --stack-name ${stack_name} --query 'StackEvents[?ResourceStatus==`CREATE_FAILED`]'
        # aws cloudformation describe-stack-events --stack-name ${stack_name} --query 'StackEvents[?ResourceStatus==`CREATE_FAILED`]' --query 'StackEvents[*].{Timestamp:Timestamp,Error:ResourceStatusReason}'
        delete_stack_command
        successful=false
      else
        # So don't delete on update-stack
        aws cloudformation describe-stack-events --stack-name ${stack_name} --query 'StackEvents[?ResourceStatus==`CREATE_FAILED`]'
        message 'ERROR: Failed and Rolling Back!'
        message "REPORT: Rollback not complete!"
        message "REPORT: Attempt $count of $max_waits."
        message "Polling again in ${wait_time} seconds..."
        echo '' | tee -a ${log_file}
        sleep $wait_time
        count=$(( count + 1 ))
        successful=false
      fi
    elif [ "$STATUS" == "DELETE_IN_PROGRESS" ]; then
      message "REPORT: Delete not complete!"
      message "REPORT: Attempt $count of $max_waits."
      message "Polling again in ${wait_time} seconds..."
      echo '' | tee -a ${log_file}
      sleep $wait_time
      count=$(( count + 1 ))
      successful=false
      break
    elif [ "$STATUS" == "ROLLBACK_COMPLETE" ]; then
      message "REPORT: Rollback complete!"
      echo '' | tee -a ${log_file}
      successful=false
      break
    else
      message 'ERROR: The stack has not create or update has failed.'
      successful=false
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

# Results
echo '' | tee -a ${log_file}
message "ENDTIME: ($(date))"
elapsed=$(( (${end_time} - ${start_time}) / 60 ))
message "RUNTIME: ${elapsed} minutes"
echo '' | tee -a ${log_file}

if [ "$successful" == "true" ]; then
  message "REPORT: SUCCESS!"
  exit 0
else
  message "ERROR: FAILED!"
  exit $1
fi
