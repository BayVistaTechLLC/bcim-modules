# Cloud KMS
# Managed by BCIM — do not edit manually

resource "google_kms_key_ring" "keyring" {
  name     = var.keyring_name
  location = var.region
}

resource "google_kms_crypto_key" "key" {
  name     = var.crypto_key_name != "" ? var.crypto_key_name : "${var.keyring_name}-key"
  key_ring = google_kms_key_ring.keyring.id
  purpose  = var.purpose

  rotation_period            = var.rotation_period
  destroy_scheduled_duration = var.destroy_scheduled_duration

  version_template {
    protection_level = var.protection_level
    algorithm        = var.purpose == "ENCRYPT_DECRYPT" ? "GOOGLE_SYMMETRIC_ENCRYPTION" : "RSA_SIGN_PKCS1_2048_SHA256"
  }

  labels = merge(var.labels, {
    managed-by  = "bcim"
    environment = var.environment
  })
}
