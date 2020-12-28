locals {
  # baseline tags
  owner = "Paolo Filippelli"
  env   = "develop"
  app   = "HashiCorp Terraform Associate Exam"
}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Owner     = local.owner
    Environment = local.env
    Application = local.app
  }
}

locals {
  # Tags to be assigned to all worker nodes
  worker_tags = {
    NodeType = "worker"
  }
}

locals {
  # Tags to be assigned to all controller nodes
  controller_tags = {
    NodeType = "controllers"
  }
}
