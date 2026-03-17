# VPC Network
# Managed by BCIM — do not edit manually

resource "google_compute_network" "network" {
  name                    = var.network_name
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
}

resource "google_compute_subnetwork" "subnet" {
  for_each = { for s in var.subnets : s.name => s }

  name                     = each.value.name
  ip_cidr_range            = lookup(each.value, "cidr", lookup(each.value, "ip_cidr_range", ""))
  region                   = lookup(each.value, "region", var.region)
  network                  = google_compute_network.network.id
  private_ip_google_access = lookup(each.value, "private_google_access", false)
}

# Private service connection (for Cloud SQL private IP, etc.)
resource "google_compute_global_address" "private_ip" {
  count = var.private_service_connection != null ? 1 : 0

  name          = "${var.service_name}-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = var.private_service_connection.address
  prefix_length = var.private_service_connection.prefix_length
  network       = google_compute_network.network.id
}

resource "google_service_networking_connection" "private" {
  count = var.private_service_connection != null ? 1 : 0

  network                 = google_compute_network.network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip[0].name]
}

# Cloud NAT
resource "google_compute_router" "router" {
  count = var.nat != null ? 1 : 0

  name    = lookup(var.nat, "router_name", "${var.service_name}-router")
  region  = var.region
  network = google_compute_network.network.id
}

resource "google_compute_router_nat" "nat" {
  count = var.nat != null ? 1 : 0

  name                               = var.nat.name
  router                             = google_compute_router.router[0].name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

# Firewall rules
resource "google_compute_firewall" "rule" {
  for_each = { for idx, r in var.firewall_rules : r.name => r }

  name      = each.value.name
  network   = google_compute_network.network.name
  direction = lookup(each.value, "direction", null)
  priority  = lookup(each.value, "priority", null)

  source_ranges = lookup(each.value, "source_ranges", null)

  dynamic "allow" {
    for_each = lookup(each.value, "allow", null) != null ? (
      can(each.value.allow.protocol) ? [each.value.allow] : each.value.allow
    ) : []
    content {
      protocol = allow.value.protocol
      ports    = lookup(allow.value, "ports", null)
    }
  }

  dynamic "deny" {
    for_each = lookup(each.value, "deny", null) != null ? (
      can(each.value.deny.protocol) ? [each.value.deny] : each.value.deny
    ) : []
    content {
      protocol = deny.value.protocol
      ports    = lookup(deny.value, "ports", null)
    }
  }
}
