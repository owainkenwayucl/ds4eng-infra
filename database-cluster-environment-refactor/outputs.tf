output primary_ips {
  value = harvester_virtualmachine.primary[*].network_interface[0].ip_address
}

output primary_ids {
  value = harvester_virtualmachine.primary.*.id
}

output replica_ips {
  value = harvester_virtualmachine.replica[*].network_interface[0].ip_address
}

output replica_ids {
  value = harvester_virtualmachine.replica.*.id
}