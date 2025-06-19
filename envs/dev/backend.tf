terraform {
  backend "s3" {
    bucket         = "ecs-tf-template-dev-tf-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "ecs-tf-template-dev-tf-lock"
    encrypt        = true
  }
}
