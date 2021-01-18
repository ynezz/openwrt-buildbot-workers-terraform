provider "hcloud" {
  token = chomp(data.local_file.hcloud_token.content)
}

resource "hcloud_server" "buildworker" {
  count       = var.hcloud_server_instances
  name        = format("truecz-worker-%s-%02d", var.hcloud_server_name_suffix, count.index + 1)
  location    = var.hcloud_server_location
  image       = var.hcloud_server_image
  server_type = var.hcloud_server_type
  ssh_keys    = var.hcloud_server_ssh_keys

  labels = {
    project = "openwrt",
    type    = "worker"
  }

  user_data = templatefile("${path.module}/files/buildworker_cloudinit.yml",
    {
      image            = var.buildworker_docker_image,
      name             = format("truecz-worker-%02d", count.index + 1)
      password         = format("truecz-worker-%02d_%s", count.index + 1, chomp(data.local_file.buildworker_password.content))
      master           = "${var.buildmaster_hostname}:${var.buildmaster_port}"
      minio_access_key = chomp(data.local_file.minio_access_key.content)
      minio_secret_key = chomp(data.local_file.minio_secret_key.content)
    }
  )
}
