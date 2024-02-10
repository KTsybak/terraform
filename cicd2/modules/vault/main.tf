provider "vault" {

address = "http://192.168.31.108:8200"
skip_tls_verify = true
token = var.access_token
}

data "vault_generic_secret" "srekv1" {
  path = "secrets/database"
}

output "user" {
value = "${data.vault_generic_secret.srekv1.data["user"]}"
sensitive = true
}
output "pass" {
value = "${data.vault_generic_secret.srekv1.data["pass"]}"
sensitive = true
}
