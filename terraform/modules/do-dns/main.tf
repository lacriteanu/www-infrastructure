variable "name" {
  type        = string
  description = "Name of the domain to be created"
}

# create  domain
resource digitalocean_domain "default" {
  name       = var.name
}

locals {
  domain_name = digitalocean_domain.default.name
}

output "domain_name" {
  value = local.domain_name
}

# Add a record to the domain
resource "digitalocean_record" "root" {
  domain = digitalocean_domain.default.name
  type   = "A"
  name   = "@"
  value  = "34.89.255.252"
}

# Output the FQDN for the record
output "fqdn_root" {
  value = digitalocean_record.root.fqdn
}

locals {
  www_name = "www"
}

# Add a record to the domain
resource "digitalocean_record" "www" {
  domain = digitalocean_domain.default.name
  type   = "CNAME"
  name   = "${local.www_name}."
  value  = "${digitalocean_domain.default.name}."
}

# Output the FQDN for the record
output "fqdn_www" {
  value = digitalocean_record.www.fqdn
}
