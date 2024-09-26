output vm_ips {
  value = harvester_virtualmachine.vm[*].network_interface[0].ip_address
}

output vm_ids {
  value = harvester_virtualmachine.vm.*.id
}

output gw_vm_ips {
  value = harvester_virtualmachine.gateway-vm[*].network_interface[0].ip_address
}

output gw_vm_ids {
  value = harvester_virtualmachine.gateway-vm.*.id
}