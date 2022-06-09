# Module outputs to be used by other modules

output "website_hostname" {
  value = aws_lb.app-lb.dns_name
}
