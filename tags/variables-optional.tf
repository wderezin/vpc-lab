# All Optional Variables
# Optional Variables should have a good default value

variable "short_name" {
  type        = string
  default     = ""
  description = "3 letter char name of the resource"

  validation {
    condition     = var.short_name == "" || length(var.short_name) == 3
    error_message = "The short_name value must be 3 character long"
  }
}

variable "business-product" {
  type        = string
  default     = null
  description = "Will default to name if not set."
}
