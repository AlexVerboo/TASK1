terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.12.0"
    }
  }
}

provider "google" {
  # Configuration options
  project="alex-verboonen-2022-run-5"
}