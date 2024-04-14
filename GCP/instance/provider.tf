variable "path" {default = "D:/Terraform/credentials"}

provider "google" {
  project = "gcp-exam-3012"
  region = "us-central1-c"
  credentials = "${file(
      "${var.path}/secrets.json")}"
}
