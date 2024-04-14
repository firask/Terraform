
resource "google_compute_instance" "default" {
count = "${length(var.name_count)}"
name = "list-${count.index+1}"
machine_type = "${var.machine_type["dev"]}"
zone = "us-central1-c"


 

boot_disk {
    initialize_params {
        image = "${var.image}"
        size = "20"
    }
}


network_interface {
    network = "default"
}



service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
}
}

output "machine_type" {value = "${google_compute_instance.default.*.machine_type}"}

output "name" {value = "${google_compute_instance.default.*.name}"}
output "zone" {value = "${google_compute_instance.default.*.zone}"}

