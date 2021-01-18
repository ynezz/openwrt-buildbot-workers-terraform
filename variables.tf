data "local_file" "hcloud_token" {
  filename = "${path.module}/secrets/hcloud_token"
}

data "local_file" "minio_access_key" {
  filename = "${path.module}/secrets/minio_access_key"
}

data "local_file" "minio_secret_key" {
  filename = "${path.module}/secrets/minio_secret_key"
}

data "local_file" "buildworker_password" {
  filename = "${path.module}/secrets/buildworker_password"
}

/*
data "template_cloudinit_config" "buildworker_cloudinit" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = templatefile("${path.module}/files/buildworker_cloudinit.yml", { index = "8" })
  }
}
*/

variable "hcloud_server_name_suffix" {
  type = string
}

variable "hcloud_server_instances" {
  type    = number
  default = 1
}

variable "hcloud_server_type" {
  type    = string
  default = "cx11"
}

variable "hcloud_server_image" {
  type    = string
  default = "debian-10"
}

variable "hcloud_server_location" {
  type    = string
  default = "nbg1"
}

variable "hcloud_server_ssh_keys" {
  type    = list(string)
  default = ["ynezz@yubikey5"]
}

variable "buildmaster_hostname" {
  type    = string
  default = "buildbot.openwrt.org"
}

variable "buildmaster_port" {
  type    = number
  default = 19992
}

variable "buildworker_docker_image" {
  type    = string
  default = "openwrtorg/buildslave@sha256:e3adca41985b9d3c2e3bac2fe90ad879dce84569535e717f0ae35b8bb24e4a4e"
}
