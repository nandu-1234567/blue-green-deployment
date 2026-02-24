resource "random_password" "db_password" {
  length  = 16
  special = true
}

resource "random_password" "app_keys" {
  length  = 32
  special = false
}

resource "random_password" "api_token_salt" {
  length  = 32
  special = false
}

resource "random_password" "admin_jwt_secret" {
  length  = 32
  special = false
}

resource "random_password" "jwt_secret" {
  length  = 32
  special = false
}