#!/bin/bash

# User Variables
template_url=https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/github/bitbucket.template


# Static Variables
date_time=$(date +%Y%m%d-%H%M)
version=1.0.0_10-11-2016
author=levon_becker
unset stack_name
read -s -p "Enter Stack Name: " stack_name

function log() {
  DATETIME=$(date +%Y-%m-%d_%H:%M:%S)
  echo "[$DATETIME] $*"
}

function get_args {
  while [ "$1" != "" ]; do
    case $1 in
      -n | --stack-name ) shift
        stack_name=$1
        ;;
      * )
        log "$1 is not a valid parameter"
        exit 1
    esac
    shift
  done
}

function validate_args {
  if [[ "$stack_name" == "" ]]; then
    log 'A stack name is required!'
    log './deploy -n <stack_name>'
    exit 1
  fi
}

aws cloudformation create-stack --profile <profile name> --stack-name <stack name> --capabilities CAPABILITY_IAM --template-url "${template_url}"  --parameters file:////Users/username/aws/cloudformation_parameters/aws_account/my-lab-bitbucket.json

# Poll for Status
WAIT_TIME=30
MAX_WAITS=15
COUNT=1
while :
do
  STATUS=$(aws cloudformation describe-stacks --stack-name "$stack_name" --output text --query 'Stacks[*].StackStatus')
  log "Stack Status: ${STATUS}"
  if [[ "$STATUS" != "CREATE_COMPLETE" && $COUNT -lt $MAX_WAITS ]]; then
      log "Create stack is not complete!"
      log "Attempt $COUNT of $MAX_WAITS."
      log "Polling again in ${WAIT_TIME} seconds..."
      echo -e ''
      sleep $WAIT_TIME
      COUNT=$(( COUNT + 1 ))
  elif [ "$STATUS" == "CREATE_COMPLETE" ]; then
      log 'STATUS: Create Completed!'
  else
      log 'The stack has not created.  This probably means something went wrong.'
      break
  fi
done