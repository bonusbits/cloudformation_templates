# Jenkins Stack Lab

## Purpose
This repository contains a comprehensive solution to deliver an automated on-demand Jenkins stack creation in AWS by leveraging CloudFormation and Chef Zero.    


<table width="100%">
    <tr>
        <th align="left" colspan="2"><h4><a href="https://github.com/bonusbits/cloudformation_templates/blob/master/labs/jenkins/jenkins-ec2master-ecsworkers.yml">Jenkins EC2 Master + ECS Worker Clusters</a></h4></th>
    </tr>
    <tr>
        <td width="100%" valign="top">
           <p>Creates Jenkins EC2 Master and ECS Worker Clusters.</p>
           <h6>Prerequisites</h6>
           <ol>
            <li>VPC</li>
            <ul>
              <li>Subnets with Internet Access (For ECS API Access)</li>
              <li>Either use an existing VPC Infrastructure or you can use the following <a href="https://github.com/bonusbits/cloudformation_templates/blob/master/infrastructure/vpc.yml" target="_blank">VPC Template</a> to create a one.</li>
            </ul>
            <li>S3 Bucket Setup with the following</li>
            <ol>
                <li>Jenkins RPM</li>
                <li>Plugin bundles</li>
                <li>Chef Cookbooks Bundle</li>
            </ol>
           </ol>
           <h6>Create Details</h6>
           <ol>
            <li>Create EC2 Instance as ECS Cluster an Amazon Linux AMI.</li>
             <ol>
              <li>Not using Pre-configured AMI</li>
              </ol>
            <li>Create Worker Autoscaling Group for EC2 Clusters</li>
            <li>Install and Configure ECS Agent using Chef Cookbook</li>
            <li>Register Workers to ECS Cluster</li>
            <li>Create Master ELB</li>
            <li>Create Master Autoscaling Group of 1</li>
            <li>Create Master EC2 Instance</li>
            <li>CloudWatch ASG Scaling Policy Alerts</li>
            <li>Route 53 Record Set (Optional)</li>
           </ol>
        </td>
        <td nowrap width="200" valign="top">
            <table>
                <tr>
                    <th align="left">Launch</th>
                </tr>
                <tr>
                    <td>
                        <a href="https://console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/new?&templateURL=https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/github/jenkins-ec2master-ecsworkers.yml" target="_blank"><img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"></a>
                        <p>us-west-2</p>
                        <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?&templateURL=https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/github/jenkins-ec2master-ecsworkers.yml" target="_blank"><img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"></a>
                        <p>us-east-1</p>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
