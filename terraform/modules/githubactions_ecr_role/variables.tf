variable "region" {
  type = string
}

variable "region_code" {
  type = string
}

variable "workload_code" {
  type = string
}

variable "repository_access_list" {
  type = list(any)
}

variable "ecr_registry" {
  type = list(any)
}

variable "tags" {
  type = map(string)
}