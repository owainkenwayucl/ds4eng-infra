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
  default = "dbuchan"
}

variable keyname {
  type = string
  default = "dbuchan"
}

variable vm_count {
  type    = number
  default = 3
}
