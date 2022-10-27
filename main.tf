variable "spacelift_account_name" {
  type = string
}

variable "spacelift_stack_id" {
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

    google = {
      source = "hashicorp/google"
    }
  }
}

provider "aws" {
  region = "eu-west-1"

  assume_role_with_web_identity {
    role_arn = "arn:aws:iam::039653571618:role/marcinw-oidc-experiment"

    web_identity_token_file = "/mnt/workspace/spacelift.oidc"

    session_name = join(".", [
      var.spacelift_account_name,
      var.spacelift_stack_id,
      var.spacelift_run_id,
    ])
  }
}

provider "google" {
  project = "marcinw-oidc-experiment"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_storage_bucket" "test" {
  name     = "marcinw-oidc-test"
  location = "US"
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
