output worker_vm_ips {
  value = harvester_virtualmachine.workervm[*].network_interface[0].ip_address
}

output worker_vm_ids {
  value = harvester_virtualmachine.workervm.*.id
}
output login_vm_ips {
  value = harvester_virtualmachine.host[*].network_interface[0].ip_address
}

output login_vm_ids {
  value = harvester_virtualmachine.host.*.id
}
output mgmt_vm_ips {
  value = harvester_virtualmachine.storage[*].network_interface[0].ip_address
}

output mgmt_vm_ids {
  value = harvester_virtualmachine.storage.*.id
}
