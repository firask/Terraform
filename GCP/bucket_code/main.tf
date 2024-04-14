variable "bucket_name" { default = "firask019181" }
variable "location" { default = "us-central1-c" }
variable "storage" { default = "REGIONAL" }
resource "google_storage_bucket" "bucket" {
    count = 1
    name = "${var.bucket_name}"
    location = "${var.location}"
    storage_class = "${var.storage}"

  
}
