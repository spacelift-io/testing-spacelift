variable "spacelift_token" {
  type = string
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
  
  assume_role_with_web_identity {
    role_arn = "arn:aws:iam::039653571618:role/marcinw-oidc-experiment"
    web_identity_token = var.spacelift_token
  }
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}
