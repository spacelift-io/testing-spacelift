variable "spacelift_account_name" {
  type = string
}

variable "spacelift_stack_id" {
  type = string
}

variable "spacelift_token" {
  type = string
}

variable "spacelift_run_id" {
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
    session_name = join(".", [
      var.spacelift_account_name,
      var.spacelift_stack_id,
      var.spacelift_run_id,
    ])
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
