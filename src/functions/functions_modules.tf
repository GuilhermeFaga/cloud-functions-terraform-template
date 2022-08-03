
variable "project" {}
variable "artifact_bucket" {}

resource "random_uuid" "bucket_suffix" {}

module "tf_test_function" {

  source = "./tf_test"

  project         = var.project
  artifact_bucket = var.artifact_bucket
}

