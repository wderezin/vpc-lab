# Module outputs to be used by other modules

output "all_tags" {
  value = local.all_tags
}

output "all_tags_without_Name" {
  value = local.all_tags_without_Name
}

output "environment" {
  value = local.environment
}

output "short_name" {
  value = local.short_name
}
