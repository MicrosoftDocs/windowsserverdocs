---
title: Guarded fabric and shielded VMs
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 5c7ada81-2d97-41d4-87cf-1a7ccf06cd20
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
---

# Guarded fabric and shielded VMs

>Applies To: Windows Server 2016

One of the most important goals of providing a hosted environment is to guarantee the security of the virtual machines running in the environment. As a cloud service provider or enterprise private cloud administrator, you can use a guarded fabric to provide a more secure environment for VMs. A guarded fabric consists of one Host Guardian Service (HGS)—typically, a cluster of three nodes—plus one or more guarded hosts, and a set of shielded virtual machines (VMs).

>**Important**&nbsp;&nbsp;Shielded VMs should be deployed only in non-production environments until an update is available.

## Learn more about guarded fabrics and shielded VMs

- [Guarded fabric and shielded VMs overview](Guarded-Fabric-and-Shielded-VMs.md)

- [Deploying the Host Guardian Service for guarded hosts and shielded VMs](guarded-fabric-deploying-hgs-overview.md)
    - [Prerequisites for deploying Host Guardian Service and guarded hosts](guarded-fabric-deployment-prerequisites.md)
    - [Setting up the Host Guardian Service - HGS](guarded-fabric-setting-up-the-host-guardian-service-hgs.md)
    - [Appendix A - Configure Nano server as TPM attested guarded host](guarded-fabric-configure-nano-server-as-tpm-guarded-host.md)<br>

- [Configuration scenarios for shielded VMs in a guarded fabric](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md)
    - [Scenario 1 - Deploy guarded hosts and shielded virtual machines in VMM](https://technet.microsoft.com/system-center-docs/vmm/scenario/guarded-overview)
    - [Shielded VMs - Hosting service provider creates a shielded VM template](guarded-fabric-create-a-shielded-vm-template.md)
    - [Shielded VMs - Hosting service provider prepares a VM Shielding Helper VHD](guarded-fabric-vm-shielding-helper-vhd.md)
    - [Shielded VMs - Tenant creates shielding data to define a shielded VM](guarded-fabric-tenant-creates-shielding-data.md)
    - [Scenario 2 - Deploy a shielded VM by using Windows Azure Pack](guarded-fabric-shielded-vm-windows-azure-pack.md)
    - [Shielded VMs - Generate an answer file by using the New-ShieldingDataAnswerFile function](guarded-fabric-sample-unattend-xml-file.md)
    - [Shielded VMs - Create a new shielded VM on-premises and move it to a guarded fabric](guarded-fabric-create-vm-move-to-guarded-fabric.md)

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
