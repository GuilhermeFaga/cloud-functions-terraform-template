
variable "project" {
  default = "{projectId}"
}

variable "provider_region" {
  default = "us-central1"
}

variable "artifact_bucket" {
  default = "{bucket_name}"
}

provider "google" {
  project = var.project
  region  = var.provider_region
}

module "cloudfunction" {
  project = var.project
  source  = "../../src/functions"

  artifact_bucket = var.artifact_bucket
}