# Bitbucket Server Lab CloudFormation Template

<table>
    <tr>
        <th align="left" colspan="2"><h4><a href="https://github.com/bonusbits/cloudformation_templates/blob/master/labs/bitbucket/bitbucket.yml">Bitbucket Lab</a></h4></th>
    </tr>
    <tr>
        <td valign="top">
            <p>Creates a Bitbucket Server in a private or public subnet in an existing VPC.</p>
            <h6>Prerequisites</h6>
            <ol>
             <li>VPC</li>
              <ul>
                <li>Public or Private Subnet</li>
                <li>Internal Instance Access Security Group</li>
                <li>Either use an existing VPC Infrastructure or you can use the following <a href="https://github.com/bonusbits/cloudformation_templates/blob/master/infrastructure/vpc.yml" target="_blank">VPC Template</a> to create a one.</li>
              </ul>
              <li>Internet Access from the EC2 Instance or Yum access solution</li>
              <li>EC2 Key Pair</li>
              <li>Available EIP if Selected Public Facing</li>
              <li>IAM Role Creation Permissions</li>
            </ol>
            <h6>Supported Regions</h6>
             <ol>
               <li>cn-north-1</li>
               <li>us-east-1</li>
               <li>us-west-1</li>
               <li>us-west-2</li>
               <li>eu-west-1</li>
               <li>eu-central-1</li>
               <li>ap-northeast-1</li>
               <li>ap-northeast-2</li>
               <li>ap-southeast-1</li>
               <li>ap-southeast-2</li>
               <li>sa-east-1</li>
             </ol>
            <h6>Create Details</h6>
            <ol>
             <li>EC2 Instance (Amazon Linux)</li>
             <li>EIP (Optional)</li>
             <li>IAM Role</li>
             <li>IAM Instance Profile</li>
             <li>Security Group</li>
            </ol>
            <h6>Notes</h6>
            <ul>
             <li>It takes 5 to 10 minutes after instance is created to complete the Bitbucket setup</li>
            </ul>
        </td>
        <td  nowrap width="200" valign="top">
            <table>
                <tr>
                    <th align="left">Launch</th>
                </tr>
                <tr>
                    <td>
                        <a href="https://console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/new?&templateURL=https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/github/labs/bitbucket/bitbucket.yml" target="_blank"><img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"></a>
                        <p>us-west-2</p>
                        <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?&templateURL=https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/github/labs/bitbucket/bitbucket.yml" target="_blank"><img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"></a>
                        <p>us-east-1</p>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <th align="left">View in Designer</th>
                </tr>
                <tr>
                    <td>
                        <a href="https://console.aws.amazon.com/cloudformation/designer/home?region=us-west-2&templateURL=https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/github/labs/bitbucket/bitbucket.yml" target="_blank"><img src="https://s3.amazonaws.com/bonusbits-public/media/cloudformation-diagrams/bitbucket-200x200.jpg" width:100% alt="View in Designer"></a>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <th align="left">How To Video</th>
                </tr>
                <tr>
                    <td>
                        <img src="https://s3.amazonaws.com/bonusbits-public/media/images/screenshots/howto_bonusbits_youtube_144x81.jpg" width:100% alt="HowTo Video"></a>
                        <p>COMING SOON</p>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <table>
                <tr>
                    <th align="left">AWS CLI Example</th>
                </tr>
                <tr>
                    <td>
                        <h6>Base Command</h6>
                        <code>aws cloudformation create-stack --profile {AWS Profile Name} --stack-name {Stack Name} --capabilities CAPABILITY_IAM --template-url "https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/github/labs/bitbucket/bitbucket.yml"</code>
                    </td>
                </tr>
                <tr>
                    <td>
                        <h5>Parameters</h5>
                    </td>
                </tr>
                <tr>
                    <td>
                        <h6>Option 1 - Custom Parameters JSON File <a href="https://github.com/bonusbits/cloudformation_templates/blob/master/labs/bitbucket/bitbucket-parameters.json">(Example Here)</a></h6>
                        <code>--parameters file:///localpath/to/custom-parameters.json</code>
                    </td>
                </tr>
                <tr>
                    <td>
                        <h6>Option 2 - Pass Parameters on CLI</h6>
                    </td>
                </tr>
                <tr>
                    <td>
                        <code>--parameters ... COMING SOON</code>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>    
