
terraform {
  # Por enquanto é necessário ter criado pelo menos esse bucket manualmente.
  backend "gcs" {
    bucket = "{projectId}-dev-tfstate"
    prefix = "env/dev"
  }
}
