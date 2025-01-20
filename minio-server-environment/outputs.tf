output vm_ips {
  value = harvester_virtualmachine.vm[*].network_interface[0].ip_address
}

output vm_ids {
  value = harvester_virtualmachine.vm.*.id
}