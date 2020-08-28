provider "spacelift" {}

terraform {
  required_providers {
    spacelift = {
      source = "registry.spacelift.io/spacelift-io/spacelift"
    }
  }
}

resource "spacelift_stack" "kaboom" {
  name           = "kaboom"
  branch         = "master"
  repository     = "demo"
  # worker_pool_id = "01EGJJ0HNKQW51GSJY2F8Q077Z"
}
