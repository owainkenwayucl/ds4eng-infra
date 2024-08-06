variable img_display_name {
  type = string
  default = "almalinux-9.4-20240507"
}

variable namespace {
  type = string
  default = ""
}

variable network_name {
  type = string
  default = ""
}

variable prefix {
  type = string
  default = ""
}

variable public_key {
  type = string
  default = ""
}

variable vm_count {
  type    = number
  default = 1
}
