variable "floating-ip-pool" {
  type    = "string"
  default = "internet"
}

variable "whitelist_ips" {
  type = "list"

  default = [
    "0.0.0.0/0",
  ]
}
