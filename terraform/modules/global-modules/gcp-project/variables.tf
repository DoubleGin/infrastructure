variable "name" {
  type = string
}

variable "environment" {
  type = string
}

variable "apis" {
  type = set(string)
}
