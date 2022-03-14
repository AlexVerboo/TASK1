terraform {
  backend "gcs" {
    bucket  = "bucket-final-alexv"
    prefix  = "terraform/state"
  }
}