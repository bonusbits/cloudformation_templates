# Jenkins Lab

### !! WIP !!

## Jump to Launchers
* [Core](#core)

## Purpose
This repository contains a comprehensive solution to deliver an automated on-demand Jenkins stack creation in AWS by leveraging CloudFormation and Chef Zero.

## Create Details
1. Create EC2 Instance as ECS Cluster an Amazon Linux AMI
2. Install and Configure ECS Agent
3. Register ECS Cluster
4. Create Master ELB
5. Create Master Autoscaling Group of one
6. Spin up Master Instance
7. TODO: ...

## Prerequisites
* AWS Account with access to selected account. # TODO: add more details on permisions needed

## Usage
1. Create CloudFormation Stack
    1. Option 1: ([Launch Link](#launchers))
        1. Login to the AWS Console
        2. Browse to a pre-configured AWS Account under Accounts Section below
        3. Click the Launch Stack button for the desired AWS Account with the correct region
            * Note: It will open in the same tab. So, if we want it to open in another tab we must right-click and select open in new tab. It's a Github/Markdown limitation.
        4. Select Next on the CloudFormation create stack window that should be opened by the link.
        5. Fill out the minimum required information
        6. Select Next, Next, Create
        7. Select the Output Tab on the CloudFormation Stack
        8. Browse for Master URL
        9. Use the Master URL in a Web Browser
        10. If default admin account was setup (default) then login
            * username: jenkinsadmin
            * password: Password!
    2. Option 2: ([cfn_launcher.sh](https://github.com/bonusbits/cloudformation_templates/blob/master/extras/cfn_launcher_script/cfn_launcher.sh))
    3. Option 3: ([AWS CLI](https://github.com/bonusbits/cloudformation_templates/blob/master/extras/aws_clid_examples/))
2. Fetch Master URL
    1. Open CloudFormation Web Console
    2. Select the new Stack
    3. Select the Outputs Tab
    4. Browse for Master URL
    5. Use the Master URL in a Web Browser
3. Login to the Jenkins Master Web Console
    1. If default admin account was setup (default) then login
        * username: jenkinsadmin
        * password: Password!
4. TODO: Configure Jobs ...        

## Launchers

**us-east-1**<br>
[![Core us-east-1](https://s3.amazonaws.com/bonusbits-public/media/images/buttons/cloudformation-launch-stack-button.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?&templateURL=https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/github/jenkins-ec2master-ecsworkers.template)
  
**us-west-2**<br>
[![Core us-west-2](https://s3.amazonaws.com/bonusbits-public/media/images/buttons/cloudformation-launch-stack-button.png)](https://console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/new?&templateURL=https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/github/jenkins-ec2master-ecsworkers.template)

[Back to Top](#federated-jenkins-launcher)
