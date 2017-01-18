---
title: Hosting service provider configuration steps for guarded hosts and shielded VMs
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 5d1a06c9-24e1-4e14-9c9a-efb2adbfeddd
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 10/14/2016
---

# Hosting service provider configuration steps for guarded hosts and shielded VMs

>Applies To: Windows Server 2016

The following topics describe configuration scenarios for shielded VMs in a guarded fabric that has already been configured. For information about configuring the guarded fabric, see [Deploying the Host Guardian Service for guarded hosts and shielded VMs](guarded-fabric-deploying-hgs-overview.md).

| Subject and link | Technologies used |
|---|---|
| **VMM**:<br>Overview: [Scenario - Deploy guarded hosts and shielded virtual machines in VMM](https://technet.microsoft.com/system-center-docs/vmm/scenario/guarded-overview)<br><br>Procedures: [Shielded VMs - Hosting service provider deploys guarded hosts in VMM](https://technet.microsoft.com/system-center-docs/vmm/scenario/guarded-hosts) | - System Center Virtual Machine Manager (VMM) |
| **Shielded VM templates**:<br>[Shielded VMs - Hosting service provider creates a shielded VM template](guarded-fabric-create-a-shielded-vm-template.md) | - Windows PowerShell<br>- VMM (optional method for creating VM template)<br><br>Also, if hosting service provider creates the template disk:<br>- Tools for provisioning a VHDX, plus sysprep for generalizing the VHDX<br>- The Protected Template Disk Creation Wizard, which is included in **Remote Server Administration Tools &gt; Feature Administration Tools &gt; Shielded VM Tools** |
| **Windows Azure Pack**:<br>[Shielded VMs - Hosting service provider sets up Windows Azure Pack](guarded-fabric-hoster-sets-up-windows-azure-pack.md) | - VMM<br>- System Center 2016 - Service Provider Foundation (SPF)<br>- Windows Azure Pack |
| **Converting existing VMs to shielded**:<br>[Shielded VMs - Hosting service provider prepares a VM Shielding helper VHD](guarded-fabric-vm-shielding-helper-vhd.md) | - A Windows PowerShell cmdlet included in **Remote Server Administration Tools &gt; Feature Administration Tools &gt; Shielded VM Tools** |

## See also

- [Tenant configuration steps for shielded VMs](guarded-fabric-tenant-configuration-steps-for-shielded-vms.md) 
- [Guarded fabric and shielded VMs](guarded-fabric-and-shielded-vms-top-node.md)
