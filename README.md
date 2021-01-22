# openwrt-buildbot-workers-terraform
OpenWrt buildbot workers managed by Terraform

## About

* Hetzner Cloud VPS servers 
  * using CPX41 variant 8 vCPUs (AMD EPYC) with 16GB RAM and 240GB SDD storage
  * builds phase1 images in about 40 minutes, phase2 packages in about 4 hours
* S3 (minio) based initial sources update for faster builds

## Configuration

### Secrets

| File | Content |
| -------------- | --------- |
secrets/buildworker_password | buildbot worker password |
secrets/hcloud_token | Hetzner Cloud Read/Write API Token |
secrets/minio_access_key | AccessKey for minio/S3 based storage |
secrets/minio_secret_key | AccessKey for minio/S3 based storage |

## Usage
### Add 42 instances to the stable phase1 builds

```shell
grep instances stable-phase1.tfvars
hcloud_server_instances   = 42

terraform init
terraform workspace new stable-phase1
terraform apply -var-file=stable-phase1.tfvars

hcloud server list -o noheader | grep stable-p1 | wc -l
42
```
