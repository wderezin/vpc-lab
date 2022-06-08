# All Optional Variables
# Optional Variables should have a good default value

variable "business-product" {
  type = string
  default = null
  description = "Will default to name if not set."
}