---
title: Deploying the Host Guardian Service for guarded hosts and shielded VMs
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 310b63d9-5ac7-4961-98ef-103af45d706a
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
---

# Deploying the Host Guardian Service for guarded hosts and shielded VMs

>Applies To: Windows Server 2016

One of the most important goals of providing a hosted environment is to guarantee the security of the virtual machines running in the environment.  As a cloud service provider or enterprise private cloud administrator, you can use a guarded fabric to provide a more secure environment for VMs. A guarded fabric consists of one Host Guardian Service (HGS)—typically, a cluster of three nodes—plus one or more guarded hosts, and a set of shielded virtual machines (VMs).

The following topics tell how to set up a guarded fabric.

- [Prerequisites for deploying Host Guardian Service and guarded hosts](guarded-fabric-deployment-prerequisites.md)
- [Setting up the Host Guardian Service - HGS](guarded-fabric-setting-up-the-host-guardian-service-hgs.md)
- [Appendix A - Configure Nano server as TPM attested guarded host](guarded-fabric-configure-nano-server-as-tpm-guarded-host.md)

## Deployment tasks for guarded fabrics and shielded VMs

The following table breaks down the tasks to deploy a guarded fabric and create shielded VMs according to different administrator roles. Note that when the HGS admin configures HGS with authorized Hyper-V hosts, a fabric admin will collect and provide identifying information about the hosts at the same time.    

|  Host Guardian Service (HGS) administrator tasks     |  Fabric administrator tasks    |   Tenant administrator tasks    |
|-------|-------|-------|
| [Verify HGS prerequisites](guarded-fabric-deployment-prerequisites.md#prerequisites-for-the-host-guardian-service)| [Verify guarded host prerequisites](guarded-fabric-deployment-prerequisites.md#prerequisites-for-hyper-v-hosts-that-will-become-guarded-hosts) | |
| [Configure the first HGS node](guarded-fabric-setting-up-the-host-guardian-service-hgs.md#configure-the-first-hgs-node)|  | |
|&nbsp; | [Configure fabric DNS](guarded-fabric-setting-up-the-host-guardian-service-hgs.md#configure-the-fabric-dns)|  |
| [Configure secondary HGS nodes](guarded-fabric-setting-up-the-host-guardian-service-hgs.md#configure-secondary-hgs-nodes)| | |
| [Configure HGS with authorized Hyper-V hosts](guarded-fabric-setting-up-the-host-guardian-service-hgs.md#configure-hgs-with-authorized-hyper-v-hosts) | [Collect identifying information from Hyper-V hosts](guarded-fabric-setting-up-the-host-guardian-service-hgs.md#tpm-trusted-attestation-capturing-hardware-and-software-information-that-hgs-uses-in-attestation) |  |
| [Verify HGS configuration](guarded-fabric-setting-up-the-host-guardian-service-hgs.md#verify-hgs-is-configured-properly) |    |  |
| &nbsp;| [Confirm hosts can attest](guarded-fabric-setting-up-the-host-guardian-service-hgs.md#confirm-hosts-can-attest-successfully)  | |
| &nbsp;| [Configure VMM (optional)](https://technet.microsoft.com/system-center-docs/vmm/scenario/guarded-overview) |   |
| &nbsp;| [Create template disks (optional)](guarded-fabric-create-a-shielded-vm-template.md) |  |
| &nbsp;| [Create a VM shielding helper disk for VMM (optional)](guarded-fabric-vm-shielding-helper-vhd.md) |  |
| &nbsp;| [Set up Windows Azure Pack (optional)](guarded-fabric-shielded-vm-windows-azure-pack.md) | |
| &nbsp;| &nbsp;| [Creating shielding data file(s)](guarded-fabric-tenant-creates-shielding-data.md)  |
| &nbsp;| &nbsp;| [Create shielded VMs using Windows Azure Pack](guarded-fabric-shielded-vm-windows-azure-pack.md#steps-tenants-take-to-create-shielded-vms-with-windows-azure-pack)<br>[Create shielded VMs using VMM](https://technet.microsoft.com/system-center-docs/vmm/scenario/guarded-vms) |

## See also

- [Guarded fabric and shielded VMs](guarded-fabric-and-shielded-vms-top-node.md)
