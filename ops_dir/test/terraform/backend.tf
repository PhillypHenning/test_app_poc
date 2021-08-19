// shared/backend.tf
terraform {
 backend "s3" {
   bucket         = "phil-h-learning-bucket2"
   key            = "state"
   region         = "us-east-2"
   encrypt        = true
   //dynamodb_table = "dev-lock-table"
 }
}