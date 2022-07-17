variable "aws_region" { default = "eu-west-1" }
variable "shared_credentials_files" { default = "~/aws/terraform_cred/credentials" }
variable "shared_config_files" { default = "~/aws/terraform_cred/config" }

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.21.0"
    }
  }

  backend "s3" {
    profile        = "admin"
    bucket         = "terraform-tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-tflock"
    encrypt        = true
    key            = "aws/terraform.tfstate"
  }
}

module "lock-setup" {
  source = "./lockSetup"
}

# Add your providers below

module "prod-eu-west-1" {
  source  = "../../providers/aws"
  aws_region = var.aws_region
  shared_credentials_files = var.shared_credentials_files
  shared_config_files      = var.shared_config_files
}
