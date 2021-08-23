#!/bin/bash 
echo "Creating Terraform Bucket"
echo $AWS_DEFAULT_REGION
aws s3api create-bucket --bucket $TF_STATE_BUCKET --region $AWS_DEFAULT_REGION --create-bucket-configuration LocationConstraint=$AWS_DEFAULT_REGION

if [ $? -eq 0 ];then
    exit 0
else
    echo "Bucket was not created."
fi
