#resource "google_storage_bucket" "static-site" {
#  name          = "bucket-alexv-2"
#  location      = "EU"
#  force_destroy = true
#

#  uniform_bucket_level_access = false
#
#  website {
#    main_page_suffix = "index.html"
#    not_found_page   = "404.html"
#  }
#  cors {
#    origin          = ["http://image-store.com"]
#    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
#    response_header = ["*"]
#    max_age_seconds = 3600
#  }
#}
#resource "google_storage_bucket" "primer-bucket" {
#  name          = "first-bucket-alex"
#  location      = "US"
#  force_destroy = false
#  uniform_bucket_level_access = false
#}