# Required variables

variable "lb_names" {
  type        = list(string)
  description = "Public DNS names for the cluster load baalancers"
}

variable "hostname" {
  type        = string
  description = "DNS hostname"
}

variable "zone_id" {
  type        = string
  description = "Route53 ZoneId"
}
