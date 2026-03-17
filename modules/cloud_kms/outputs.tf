output "keyring_id" {
  description = "KMS key ring ID"
  value       = google_kms_key_ring.keyring.id
}

output "crypto_key_id" {
  description = "KMS crypto key ID"
  value       = google_kms_crypto_key.key.id
}
