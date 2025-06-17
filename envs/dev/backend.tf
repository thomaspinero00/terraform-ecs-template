terraform {
  backend "s3" {
    bucket         = "${var.project_name}-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "${var.project_name}-terraform-lock"
    encrypt        = true
  }
}
