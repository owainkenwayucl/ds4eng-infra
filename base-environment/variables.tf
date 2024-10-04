variable img_display_name {
  type = string
  default = "almalinux-9.4-20240805"
}

variable namespace {
  type = string
#  default = "ds4eng-ns"
}

variable network_name {
  type = string
#  default = "ds4eng-ns/ds4eng"
}

variable username {
  type = string
#  default = ""
}

variable keyname {
  type = string
#  default = ""
}

variable vm_count {
  type    = number
  default = 1
}
