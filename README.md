# test_app_poc


## Prereq for local
1. Terraform
1. Docker
1. (Suggested) tfenv

## Deploy locally using Terraform
Before deploying locally ensure;
1. You've are using Terraform version 0.13.2
1. You have set the following AWS env variables in your shell;
    1. TF_STATE_BUCKET
    1. AWS_ACCESS_KEY_ID
    1. AWS_SECRET_ACCESS_KEY
    
<br />

To deploy from your local machine, change into the terraform directory.

Run the following commands on your first build;
```
terraform init
```
After that, and on all subsequent runs just use the commands;
```
terraform plan
terraform apply
```

Review the planned changes that are reported by Terraform, if they seem alright, run apply and enter yes when prompted. 


## Deploy using BitOps

Run the command below in the ops_dir folder; 
```
docker run \
-e ENVIRONMENT="test" \
-e TF_STATE_BUCKET=$TF_STATE_BUCKET \
-e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
-e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
-e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
-e TF_VAR_aws_default_region=$AWS_DEFAULT_REGION \
-e TF_VAR_aws_access_key_id=$AWS_ACCESS_KEY_ID \
-e TF_VAR_aws_secret_access_key=$AWS_SECRET_ACCESS_KEY \
-v $(pwd):/opt/bitops_deployment \
bitovi/bitops:latest
```
