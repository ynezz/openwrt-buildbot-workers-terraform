# openwrt-buildbot-workers-terraform
OpenWrt buildbot workers managed by Terraform

## About

As you might know, [multiple flaws (7 CVEs)](https://openwrt.org/advisory/2021-01-19-1) has been found in the dnsmasq package and they looked quite serious, so we've decided to provide update ASAP to our users. We've used Terraform based dynamic wokers to speed up the release process this time.

The patched version of dnsmasq has been released at 13:00, [mitigations](https://forum.openwrt.org/t/security-advisory-2021-01-19-1-dnsmasq-multiple-vulnerabilities/85903/41) with [security advisory](https://openwrt.org/advisory/2021-01-19-1) provided at 13:45. We have made fixed firmware images available for development and 19.07 stable release around 14:30, all packages around 18.00 and finally relased fixed [19.07.6 release](https://lists.infradead.org/pipermail/openwrt-announce/2021-January/000010.html) at 23:56. Please note, that it usually takes several days to build and publish release.

### Architecture

* Hetzner Cloud VPS servers 
  * using CPX41 variant 8 vCPUs (AMD EPYC) with 16GB RAM and 240GB SDD storage
* S3 (minio) based initial sources update for faster builds

Note, that Hetzner limits you to 10 VPSes (every cloud provider does that) and you need to ask them for limit increase. They've increased my limit to 70 VPSes in matter of hours, so kudos to them.

## Costs

### Hetzner

| branch | phase | targets/architectures | time/target | costs/hour | total | 
| -------| :------:| :-------: | ---- | ---------- | ----- |
| master | images | 68 | 40 minutes | 0.045€ | 3.06€ |
| openwrt-19.07 | images | 70 | 40 minutes | 0.045€ | 3.15€ |
| master | packages | 31 | 4 hours | 0.045€ | 5.58€ |
| openwrt-19.07 | packages | 31 | 4 hours | 0.045€ | 5.58€ |

So the complete rebuild of master and one stable release takes approximately 6 hours with 70 buildbot workers and costs 17.37€.

## Configuration

### Secrets

You need to provide following secret contents.

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
