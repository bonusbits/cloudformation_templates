# Wordpress on Nginx

## Purpose

Create an EC2 Instance with Wordpress on Nginx

<table width="100%">
    <tr>
        <th align="left" colspan="2"><h4><a href="https://github.com/bonusbits/cloudformation_templates/blob/master/labs/wordpress/wordpress-nginx.yml">Wordpress on Nginx</a></h4></th>
    </tr>
    <tr>
        <td width="100%" valign="top">
            <p>Create S3 Backup Bucket</p>
            <h6>Prerequisites</h6>
            <ol>
             <li>VPC</li>
             <li>Public Subnet</li>
             <li>Internal Access Security Group</li>
             <li>RDS Security Group</li>
             <li>EFS Security Group</li>
            </ol>
            <h6>Create Details</h6>
            <ol>
             <li>Single Amazon Linux EC2 Instance</li>
             <li>Create Web Access Security Group</li>
             <li>Create IAM Instance Profile Role</li>
             <li>Create CloudWatch Logs Group</li>
             <li>No External IP</li>
            </ol>
            <h6>Deploy Details</h6>
            <ol>
             <li>Installs Nginx</li>
             <li>Installs PHP-FPM 7.0</li>
             <li>Installs MySQL 5.6 Client</li>
             <li>Installs Latest Wordpress</li>
             <li>Installs Creates Nginx Config for Wordpress</li>
             <li>Assumes RDS Backend</li>
             <li>Assumes EFS Shared Content Mount</li>
            </ol>
        </td>
        <td nowrap width="200" valign="top">
            <table>
                <tr>
                    <th align="left">Launch</th>
                </tr>
                <tr>
                    <td>
                        <a href="https://console.aws.amazon.com/cloudformation/home?#/stacks/new?&templateURL=https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/github/wordpress-nginx.yml" target="_blank"><img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"></a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
