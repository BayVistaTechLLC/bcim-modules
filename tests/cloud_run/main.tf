# Test root module for cloud_run
# Validates the module with terraform validate

terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "test-project"
  region  = "us-central1"
}

module "cloud_run" {
  source = "../../modules/cloud_run"

  service_name = "test-service"
  project      = "test-project"
  region       = "us-central1"
  image        = "gcr.io/test-project/test-image:latest"
  environment  = "development"
}

output "service_url" {
  value = module.cloud_run.service_url
}
