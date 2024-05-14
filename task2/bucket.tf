resource "google_storage_bucket" "task2" {
  name          = "${var.project_id}-task2"
  location      = var.location
  force_destroy = true
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
  # cors {
  #   origin          = ["http://image-store.com"]
  #   method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
  #   response_header = ["*"]
  #   max_age_seconds = 3600
  # }
  # uniform_bucket_level_access = false
}

# resource "google_storage_bucket_access_control" "public_rule" {
#   bucket = google_storage_bucket.task1.name
#   role   = "READER"
#   entity = "allUsers"
# }

# resource "google_storage_bucket_iam_binding" "public_access" {
#   bucket = google_storage_bucket.task1.name
#   role   = "roles/storage.objectViewer"

#   members = [
#     "allUsers",
#   ]
# }

# resource "google_storage_bucket_object" "default" {
#   name         = "startup.sh"
#   source       = "scripts/startup.sh"
#   content_type = "text/x-shellscript"
#   bucket       = google_storage_bucket.task2.id
# }
