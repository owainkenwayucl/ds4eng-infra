output worker_vm_ips {
  value = harvester_virtualmachine.workervm[*].network_interface[0].ip_address
}

output worker_vm_ids {
  value = harvester_virtualmachine.workervm.*.id
}

output mgmt_vm_ips {
  value = harvester_virtualmachine.mgmtvm[*].network_interface[0].ip_address
}

output mgmt_vm_ids {
  value = harvester_virtualmachine.mgmtvm.*.id
}
