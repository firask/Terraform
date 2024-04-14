
resource "google_compute_instance" "default" {
count = "1"
name = "list-${count.index+1}"
machine_type = "${var.machine_type}"
zone = "us-central1-c"
can_ip_forward = "false"
description = "This is our Virtual Machine"

    tags = ["allow-http", "allow-https", "allow-one", "allow-two"]  # FIREWALL

boot_disk {
    initialize_params {
        image = "${var.image}"
        size  = "10"
    }
 }

labels {
    name = "list-${count.index+1}"
    machine_type = "${var.environment != "dev" ? var.machine_type : var.machine_type_dev}"
}

network_interface {
    network = "default"
 }

metadata = {
    size = "20"
    foo = "bar"
}

metadata_startup_script = "echo hi > /test.txt"

service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
 }
  
}

resource "google_compute_disk" "default" {
    name = "test-desk"
    type = "pd-ssd"
    zone = "us-central1-c"
    size = "10"
}

resource "google_compute_attached_disk" "default" {
    disk = "${google_compute_disk.default.self_link}"
    instance = "${google_compute_instance.default.self_link}"
}
 
output "machine_type" { value = "${google_compute_instance.default.*.machine_type}" }
output "name" { value = "${google_compute_instance.default.*.name}" }
output "zone" { value = "${google_compute_instance.default.*.zone}" }

#output "instance_id" { value = "${join(",",google_compute_instance.default.*.id)}"}