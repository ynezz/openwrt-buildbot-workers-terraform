output "buildworkers_ipv4_addresses" {
  value = hcloud_server.buildworker[*].ipv4_address
}

/*
output "user_data" {
  value = data.template_cloudinit_config.buildworker_cloudinit
}

output "test" {
  value = hcloud_server.buildworker[*].user_data
}
*/
