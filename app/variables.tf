# Required variables

variable "tags" {
  type = object({
    all_tags              = map(string)
    all_tags_without_Name = map(string)
    short_name            = string
  })
  description = "Output from the tags module"
}

variable "public_subnet_ids" {
  type = list(string)
}
