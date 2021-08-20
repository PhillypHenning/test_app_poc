docker run \
-e ENVIRONMENT="test" \
-e TF_VAR_AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
-e TF_VAR_AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
-e TF_VAR_AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
-e TF_STATE_BUCKET=$TF_STATE_BUCKET \
-e TERRAFORM_DESTROY=true \
-v $(pwd):/opt/bitops_deployment \
-v $BITOPS_HOME:/opt/bitops \
bitovi/bitops:latest

export TF_LOG=DEBUG;
export TF_VAR_aws_default_region=$AWS_DEFAULT_REGION; export TF_VAR_aws_secret_access_key=$AWS_SECRET_ACCESS_KEY; export TF_VAR_aws_access_key_id=$AWS_ACCESS_KEY_ID