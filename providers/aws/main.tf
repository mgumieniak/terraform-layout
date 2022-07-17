variable "aws_region" {}
variable "shared_credentials_files" {}
variable "shared_config_files" {}

provider "aws" {
  region  = var.aws_region
  shared_credentials_files = var.shared_credentials_files
  shared_config_files      = var.shared_config_files
}

# Add modules below

module "AMI-cleanup" {
  source = "../../modules/aws/AMI-Cleanup"
}
