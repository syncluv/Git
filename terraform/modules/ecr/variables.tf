variable "accounts_with_access" {
  type = list(string)
}
variable "account_number" {
  type = string
}

variable "project_name" {
  type = string
}

variable "application_name" {
  type = string
}

variable "tags" {
  type = map(string)
}