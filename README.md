# three-tier-app-tf
It creates load balanced 3 - tier  application architecture in a Private network  on AWS using Terraform


To setup Terraform project, please follow below instructions.

## Install Terraform
Refer below link to install Terraform on respective platforms
https://learn.hashicorp.com/terraform/getting-started/install.html

## Configure AWS credentials

```
$ aws configure --profile <PROFILE_NAME>
AWS Access Key ID [None]: <ACCESS KEY ID OF IAM USER FROM Step 4>
AWS Secret Access Key [None]: <SECRET ACCESS KEY ID OF IAM USER FROM Step 4>
Default region name [None]: <DEFAULT REGION NAME WHERE YOU WANT TO CREATE TF RESOURCES>
Default output format [None]: <ENTER>
```

## Update the Provider Configuration
Update provider configuration in example/provider.tf

```
provider "aws" {
  region = "${var.AWS_REGION}"
  profile = "< PROFILE NAME CREATED EARLIER >"
}
```

## Variable File
Make a copy of example/terraform.tfvars.example and rename it to terraform.tfvars.
Define the variable values as per need.

## Initialize terraform
Run ``` terraform init ``` to intialize terraform env.

## PLAN
Run ``` terraform plan ``` to review changes which will be created by TF.

## APPLY
Apply the changes
```
terraform apply
```
