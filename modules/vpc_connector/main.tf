# VPC Access Connector
# Managed by BCIM — do not edit manually

resource "google_vpc_access_connector" "connector" {
  name          = var.connector_name
  region        = var.region
  network       = var.network
  ip_cidr_range = var.ip_cidr_range
  machine_type  = var.machine_type

  min_throughput = var.min_throughput
  max_throughput = var.max_throughput
}
