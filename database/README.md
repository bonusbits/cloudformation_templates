# [Create RDS From Snapshot](https://github.com/bonusbits/cloudformation_templates/blob/master/database/create-rds-from-snapshot.yml)

## Purpose
Create an new RDS from an RDS Snapshot. Can be great for Blue/Green or pull Prd DB to Nonprod for testing.

## Prerequisites
* RDS Snapshot in Same Region
* 2+ Subnets if Enabling Multi AZ

## Summary
1. Create RDS Instance from Snapshot
2. Create Subnet Group
3. Create Access Security Group
4. Optionally Configure DNS Record in Route53

## Notes
Because it's a restore several options are not available. Such as:
* Can't set Master User and Password
* Can't select what DB Engine
* Can't set allocated storage

## Launcher
[![](../images/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?#/stacks/new?&templateURL=https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/github/create-rds-from-snapshot.yml)<br>

Click this button to open AWS CloudFormation web console to enter parameters and create the stack.


## CloudFormation Template Details
The [CloudFormation Template](https://github.com/bonusbits/cloudformation_templates/blob/master/database/create-rds-from-snapshot.yml) does the following:

1. Create RDS from Snapshot ...


## View in Designer
[![](../images/designer_thumbs/create-rds-from-snapshot.jpg)](https://console.aws.amazon.com/cloudformation/designer/home?templateURL=https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/github/create-rds-from-snapshot.yml)

# [MySQL RDS](https://github.com/bonusbits/cloudformation_templates/blob/master/database/mysql-rds.yml)

## Purpose
Create an new MySQL RDS Instance.

## Prerequisites
* [VPC](https://github.com/bonusbits/cloudformation_templates/blob/master/infrastructure/vpc.yml)
    * 3 Private Subnets
    * 3 Public Subnets
    * Internal AccessSecurity Group
    * RemoteSecurityGroup

## Notes
Because it's a restore several options are not available. Such as:
* Can't set Master User and Password
* Can't select what DB Engine
* Can't set allocated storage

## Launcher
[![](../images/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?#/stacks/new?&templateURL=https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/github/mysql-rds.yml)<br>

Click this button to open AWS CloudFormation web console to enter parameters and create the stack.


## CloudFormation Template Details
The [CloudFormation Template](https://github.com/bonusbits/cloudformation_templates/blob/master/database/mysql-rds.yml) does the following:

1. Create DB Instance
2. Create DB Subnet Group
3. Create Security Group
4. Create Cloud Watch Alarms
5. Set Route 53 Record Set (Optional)


## View in Designer
[![](../images/designer_thumbs/mysql-rds.jpg)](https://console.aws.amazon.com/cloudformation/designer/home?templateURL=https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/github/mysql-rds.yml)
    