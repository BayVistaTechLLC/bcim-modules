# Compute Engine Instance
# Managed by BCIM — do not edit manually

resource "google_compute_instance" "instance" {
  name         = var.service_name
  machine_type = var.machine_type
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = "projects/${var.image_project}/global/images/family/${var.image_family}"
      size  = var.disk_size_gb
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnet != "" ? var.subnet : null
  }

  tags = length(var.tags) > 0 ? var.tags : null

  metadata = var.startup_script != "" ? { startup-script = var.startup_script } : {}

  dynamic "service_account" {
    for_each = var.service_account != "" ? [1] : []
    content {
      email  = var.service_account
      scopes = ["cloud-platform"]
    }
  }

  labels = merge(var.labels, {
    managed-by  = "bcim"
    environment = var.environment
  })
}
