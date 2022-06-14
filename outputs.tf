
output "website-1" {
  value = "http://${module.app-1.website_hostname}"
}

output "website-2" {
  value = "http://${module.app-2.website_hostname}"
}
