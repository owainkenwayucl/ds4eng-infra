output primary_ips {
  value = harvester_virtualmachine.vm[*].network_interface[0].ip_address
}

output primary_ids {
  value = harvester_virtualmachine.vm.*.id
}

output s3_url {
  value = "${var.username}-trinos3.comp0235.condenser.arc.ucl.ac.uk"
}

output cons_url {
  value = "${var.username}-trinocons.comp0235.condenser.arc.ucl.ac.uk"
}