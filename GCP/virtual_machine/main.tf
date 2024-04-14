
resource "google_compute_instance" "default" {
count = "1"
name = "list-${count.index+1}"
machine_type = "${var.environment != "dev" ? var.machine_type : var.machine_type_dev}"
zone = "europe-west2-a"
can_ip_forward = "false"
description = "This is our Virtual Machine"

    tags = ["allow-http", "allow-https"]  # FIREWALL

boot_disk {
    initialize_params {
        image = "${var.image}"
        size  = "20"
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

output "machine_type" { value = "${google_compute_instance.default.machine_type}" }
output "name" { value = "${google_compute_instance.default.name}" }
output "zone" { value = "${google_compute_instance.default.zone}" }

#output "instance_id" { value = "${join(",",google_compute_instance.default.*.id)}"}