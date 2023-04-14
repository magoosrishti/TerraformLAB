variable "env-tag" {
  type = string
  description = "Value of env tag"
  default = "Prod"
}

variable "vnet-address_space" {
  type    = list
  description = "CIDR value of VNET"
  default = ["10.0.0.0/16"]
}
