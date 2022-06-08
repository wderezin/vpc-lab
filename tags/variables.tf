# Required variables

variable "name" {
  type        = string
  description = "name of the resource"
}

variable "owner" {
  type = string
}

variable "cost-center" {
  type = string
}

variable "environment" {
  type = string
}

variable "compliance" {
  type = string

  validation {
    condition     = contains(["pic", "sox", "no-compliance"], var.compliance)
    error_message = "The compliance value must be pic, sox, no-compliance"
  }
}

variable "data-sensitivity" {
  type = string
}

variable "exposure" {
  type = string

  validation {
    condition     = contains(["public", "private"], var.exposure)
    error_message = "The exposure value must be public or private"
  }
}
