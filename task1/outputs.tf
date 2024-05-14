# https://storage.googleapis.com/iamagwe-task1/index.html
output "bucket_url" {
  value = "${var.google_bucket_url}${google_storage_bucket.task1.name}/index.html"
}
