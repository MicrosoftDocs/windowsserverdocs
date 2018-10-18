---
title: Guarded fabric and shielded VMs
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 5c7ada81-2d97-41d4-87cf-1a7ccf06cd20
manager: dongill
author: rpsqrd
ms.author: justinha
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Guarded fabric and shielded VMs

>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

One of the most important goals of providing a hosted environment is to guarantee the security of the virtual machines running in the environment. As a cloud service provider or enterprise private cloud administrator, you can use a guarded fabric to provide a more secure environment for VMs. A guarded fabric consists of one Host Guardian Service (HGS) - typically, a cluster of three nodes - plus one or more guarded hosts, and a set of shielded virtual machines (VMs).

> [!IMPORTANT]
> Ensure that you have installed the latest cumulative update before you deploy shielded virtual machines in production.

## Videos, blog, and overview topic about guarded fabrics and shielded VMs

- Video: [How to protect your virtualization fabric from insider threats with Windows Server 2019](https://myignite.techcommunity.microsoft.com/sessions/64690)
- Video: [Introduction to Shielded Virtual Machines in Windows Server 2016](https://channel9.msdn.com/Shows/Mechanics/Introduction-to-Shielded-Virtual-Machines-in-Windows-Server-2016)
- Video: [Dive into Shielded VMs with Windows Server 2016 Hyper-V](https://channel9.msdn.com/events/Ignite/2016/BRK3124)
- Video: [Deploying Shielded VMs and a Guarded Fabric with Windows Server 2016](https://mva.microsoft.com/en-US/training-courses/deploying-shielded-vms-and-a-guarded-fabric-with-windows-server-2016-17131?l=WFLef7vUD_4604300474)
- Blog: [Datacenter and Private Cloud Security Blog](https://blogs.technet.microsoft.com/datacentersecurity/)
- Overview: [Guarded fabric and shielded VMs overview](Guarded-Fabric-and-Shielded-VMs.md)

## Planning topics

- [Planning guide for hosters](guarded-fabric-planning-for-hosters.md)
- [Planning guide for tenants](guarded-fabric-shielded-vm-planning-for-tenants.md)

## Deployment topics

- [Deployment Guide](guarded-fabric-deploying-hgs-overview.md)
    - [Quick start](guarded-fabric-deployment-overview.md)
    - [Deploy HGS](guarded-fabric-setting-up-the-host-guardian-service-hgs.md)
    - [Deploy guarded hosts](guarded-fabric-configure-hgs-with-authorized-hyper-v-hosts.md)
        - [Configuring the fabric DNS for hosts that will become guarded hosts](guarded-fabric-configuring-fabric-dns.md)
        - [Deploy a guarded host using AD mode](guarded-fabric-admin-trusted-attestation-creating-a-security-group.md)
        - [Deploy a guarded host using TPM mode](guarded-fabric-tpm-trusted-attestation-capturing-hardware.md)
        - [Confirm guarded hosts can attest](guarded-fabric-confirm-hosts-can-attest-successfully.md)
        - [Shielded VMs - Hosting service provider deploys guarded hosts in VMM](https://technet.microsoft.com/system-center-docs/vmm/scenario/guarded-hosts)
    - [Deploy shielded VMs](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md)
        - [Create a shielded VM template](guarded-fabric-create-a-shielded-vm-template.md)
        - [Prepare a VM Shielding helper VHD](guarded-fabric-vm-shielding-helper-vhd.md)
        - [Set up Windows Azure Pack](guarded-fabric-hoster-sets-up-windows-azure-pack.md)
        - [Create a shielding data file](guarded-fabric-tenant-creates-shielding-data.md)
        - [Deploy a shielded VM by using Windows Azure Pack](guarded-fabric-shielded-vm-windows-azure-pack.md)
        - [Deploy a shielded VM by using Virtual Machine Manager](guarded-fabric-tenant-deploys-shielded-vm-using-vmm.md)

## Operations and management topic

- [Managing the Host Guardian Service](guarded-fabric-manage-hgs.md)
