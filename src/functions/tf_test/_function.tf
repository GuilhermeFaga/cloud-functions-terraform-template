
variable "project" {}
variable "artifact_bucket" {}

locals {
  timestamp     = formatdate("YYMMDDhhmmss", timestamp())
  root_dir      = abspath("../../")
  function_name = basename(path.module)

  # google_cloudfunctions_function config
  description   = "Node function template"
  runtime       = "nodejs16" # https://cloud.google.com/functions/docs/concepts/execution-environment#runtimes
  entry_point   = "main" # CF function entry name
  topic_name    = "daily_at_5" # pubsub topic name
}

data "archive_file" "zip" {
  type        = "zip"
  source_dir  = "${local.root_dir}/src/functions/${local.function_name}"
  output_path = "${local.root_dir}/assets/function-${local.function_name}-${local.timestamp}.zip"
}

resource "google_storage_bucket_object" "source" {
  name   = "functions-${local.function_name}-source.zip#${data.archive_file.zip.output_md5}"
  bucket = var.artifact_bucket
  source = data.archive_file.zip.output_path
}

resource "google_cloudfunctions_function" "function" {
  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function#argument-reference

  name        = local.function_name
  description = local.description
  runtime     = local.runtime

  available_memory_mb   = "128"
  source_archive_bucket = var.artifact_bucket
  source_archive_object = google_storage_bucket_object.source.name
  entry_point           = local.entry_point

  environment_variables = {
  }

  # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function#event_type
  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = "projects/${var.project}/topics/${local.topic_name}"
  }
}