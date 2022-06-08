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
}

variable "data-sensitivity" {
  type = string
}

variable "exposure" {
  type = string
}