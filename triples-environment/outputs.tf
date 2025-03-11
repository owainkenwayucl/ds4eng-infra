output primary_ips {
  value = harvester_virtualmachine.vm[*].network_interface[0].ip_address
}

output primary_ids {
  value = harvester_virtualmachine.vm.*.id
}
