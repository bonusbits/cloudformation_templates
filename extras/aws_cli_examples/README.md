# CloudFormation Templates Parameters Examples
### !! WIP !!

## Usage
### Jenkins Lab Example
#### Base Create Command
```
aws cloudformation create-stack --profile {AWS Profile Name} --stack-name {Stack Name} --template-url "https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/github/jenkins-ec2master-ecsworkers.template"
```

#### Parameters
##### Option 1 (Recommended) - Customer Parameters JSON File ([Example Here](https://github.com/bonusbits/cloudformation_templates/blob/master/labs/jenkins/parameter_examples/jenkins-ec2master-ecsworkers.json))
```
--parameters file:///localpath/to/custom-parameters.json
```

##### Option 2 - Pass Parameters on CLI
```
--parameters ParameterKey=TagOwner,ParameterValue="First Last" ParameterKey=TagProject,ParameterValue="Jenkins Lab" ParameterKey=TagDeleteAfter,ParameterValue="11/01/2016" ParameterKey=VpcId,ParameterValue="vpc-00000000" ...
```

