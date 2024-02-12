---
title: Deploying the Host Guardian Service
description: "Learn more about: Deploying the Host Guardian Service"
ms.topic: article
ms.assetid: 310b63d9-5ac7-4961-98ef-103af45d706a
manager: dongill
author: IngridAtMicrosoft
ms.author: inhenkel
ms.date: 01/14/2020
---

# Deploying the Host Guardian Service

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

One of the most important goals of providing a hosted environment is to guarantee the security of the virtual machines running in the environment. As a cloud service provider or enterprise private cloud administrator, you can use a guarded fabric to provide a more secure environment for VMs. A guarded fabric consists of one Host Guardian Service (HGS) - typically, a cluster of three nodes - plus one or more guarded hosts, and a set of shielded virtual machines (VMs).

## Video: Deploying a guarded fabric

> [!VIDEO https://www.microsoft.com/videoplayer/embed/dcd8e99f-36f1-4bc8-b3d2-9576da38d9f1?autoplay=false]

## Deployment tasks for guarded fabrics and shielded VMs

The following table breaks down the tasks to deploy a guarded fabric and create shielded VMs according to different administrator roles. Note that when the HGS admin configures HGS with authorized Hyper-V hosts, a fabric admin will collect and provide identifying information about the hosts at the same time.

| Step and link to content | Image |
|--|--|--|
| 1 - [Verify HGS prerequisites](guarded-fabric-prepare-for-hgs.md) | ![Step 1, verify prerequisites](../media/Guarded-Fabric-Shielded-VM/guarded-host-verify.png) |
| 2 - [Configure first HGS node](guarded-fabric-choose-where-to-install-hgs.md) | ![Step 2, configure the first HGS node](../media/Guarded-Fabric-Shielded-VM/guarded-host-configure-first-hgs-node.png) |
| 3 - [Configure additional HGS nodes](guarded-fabric-configure-additional-hgs-nodes.md) | ![Step 3, configure additional HGS nodes](../media/Guarded-Fabric-Shielded-VM/guarded-host-configure-secondary-hgs-nodes.png) |
| 4 - [Configure fabric DNS](guarded-fabric-configuring-fabric-dns.md) | ![Step 4, configure fabric DNS](../media/Guarded-Fabric-Shielded-VM/guarded-host-configure-fabric-dns.png) |
| 5 - [Verify host prerequisites (Key)](guarded-fabric-guarded-host-prerequisites.md#host-key-attestation) and [Verify host prerequisites (TPM)](guarded-fabric-guarded-host-prerequisites.md#tpm-trusted-attestation) | ![Step 5, verify host prerequisite key and host prerequisite TPM](../media/Guarded-Fabric-Shielded-VM/guarded-host-verify.png) |
| 6 - [Create host key (Key)](guarded-fabric-create-host-key.md) and[Collect host information (TPM)](guarded-fabric-tpm-trusted-attestation-capturing-hardware.md) | ![Step 6, create host key and collect host info](../media/Guarded-Fabric-Shielded-VM/guarded-host-collect-info-from-hosts.png) |
| 7 - [Configure HGS with host information](guarded-fabric-add-host-information-to-hgs.md) | ![Step 7, add host info to HGS](../media/Guarded-Fabric-Shielded-VM/guarded-host-configure-hgs-with-host-info.png) |
| 8 -  [Confirm hosts can attest](guarded-fabric-confirm-hosts-can-attest-successfully.md) | ![Step 8, confirm host can attest](../media/Guarded-Fabric-Shielded-VM/guarded-host-confirm-hosts-attest.png) |
| 9 - [Configure VMM (optional)](/system-center/vmm/deploy-guarded-host-fabric) | ![Step 9, configure VMM (optional)](../media/Guarded-Fabric-Shielded-VM/guarded-host-configure-vmm.png) |
| 10 - [Create template disks](guarded-fabric-create-a-shielded-vm-template.md) | ![Step 10, create template disks](../media/Guarded-Fabric-Shielded-VM/guarded-host-create-template-disk.png) |
| 11 - [Create a VM shielding helper disk for VMM (optional)](guarded-fabric-vm-shielding-helper-vhd.md) | ![Step 11, create a VM shielding help disk for VMM](../media/Guarded-Fabric-Shielded-VM/guarded-host-create-helper-disk.png) |
| 12 - [Set up Windows Azure Pack (optional)](guarded-fabric-shielded-vm-windows-azure-pack.md) | ![Step 12, set up Windows Azure Pack (optional)](../media/Guarded-Fabric-Shielded-VM/guarded-host-windows-azure-pack.png) |
| 13 - [Create shielding data file](guarded-fabric-tenant-creates-shielding-data.md) | ![Step 13, create a shielding data file](../media/Guarded-Fabric-Shielded-VM/guarded-host-shielding-data-file.png) |
| 14 - [Create shielded VMs using Windows Azure Pack](guarded-fabric-shielded-vm-windows-azure-pack.md) | ![Step 14, create shielded VMs using Windows Azure Pack](../media/Guarded-Fabric-Shielded-VM/guarded-host-shielded-vms.png) |
| 15 - [Create shielded VMs using VMM](/system-center/vmm/guarded-deploy-vm) | ![Step 15, create shielded VMs using VMM](../media/Guarded-Fabric-Shielded-VM/guarded-host-shielded-vms.png) |

## Additional References

- [Guarded fabric and shielded VMs](guarded-fabric-and-shielded-vms-top-node.md)
