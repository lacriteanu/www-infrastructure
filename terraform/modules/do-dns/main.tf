variable "name" {
  type        = string
  description = "Name of the domain to be created"
}

resource "digitalocean_domain" "default" {
  name       = var.name
}
