terraform {
  backend "gcs" {
    bucket  = "bucketalexdemo"
    prefix  = "terraform/state"
  }
}