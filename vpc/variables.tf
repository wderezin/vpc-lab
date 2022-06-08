# Required variables

variable "tags" {
  type = object({
    all_tags = map(string)
    all_tags_without_Name = map(string)
  })
  description = "Output from the tags module"
}