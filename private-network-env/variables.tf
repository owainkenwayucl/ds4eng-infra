variable img_display_name {
  type = string
  default = "almalinux-9.4-20240805"
}

variable namespace {
  type = string
  default = "ds4eng-ns"
}

variable network_name {
  type = string
  default = "ds4eng-ns/ds4eng"
}

variable username {
  type = string
#  default = ""
}

variable vm_count {
  type    = number
  default = 2
}

variable ip_block {
  type    = string
  default = "192.168.51"
}

variable ip_offset {
  type    = number
  default = 1 # remember gateway is .1
}
