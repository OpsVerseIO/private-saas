terraform {
  backend "gcs" {
    bucket = "<bucket-name>"
    prefix = "terraform/state"
  }
}

