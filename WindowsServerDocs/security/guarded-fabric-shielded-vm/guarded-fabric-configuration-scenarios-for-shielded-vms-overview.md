---
title: Configuration scenarios for shielded VMs in a guarded fabric
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 5d1a06c9-24e1-4e14-9c9a-efb2adbfeddd
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 10/14/2016
---

# Configuration scenarios for shielded VMs in a guarded fabric

>Applies To: Windows Server 2016

The following topics describe configuration scenarios for shielded VMs in a guarded fabric that has already been configured. For information about configuring the guarded fabric, see [Deploying the Host Guardian Service for guarded hosts and shielded VMs](guarded-fabric-deploying-hgs-overview.md).

| Scenario or option<br>Who performs this? | Technologies used |
|---|---|
| **Scenario 1** - [Deploy guarded hosts and shielded virtual machines in VMM](https://technet.microsoft.com/system-center-docs/vmm/scenario/guarded-overview)<br><br>Hosting service provider | System Center Virtual Machine Manager (VMM) |
| \*&nbsp;&nbsp;**Continuation of Scenario 1**: [Shielded VMs - Hosting service provider creates a shielded VM template](guarded-fabric-create-a-shielded-vm-template.md)<br><br>&nbsp;&nbsp;Hosting service provider | Tools for provisioning a VHDX, plus sysprep (for generalizing the VHDX)<br><br>The Protected Template Disk Creation Wizard, which is included in **Remote Server Administration Tools &gt; Feature Administration Tools &gt; Shielded VM Tools**<br><br>Windows PowerShell<br><br>VMM - The procedures that use VMM in this topic describe how to copy a disk to the VMM library and how to create a shielded VM template. |
| \*&nbsp;&nbsp;**Continuation of Scenario 1**: [Shielded VMs - Hosting service provider prepares a VM Shielding Helper VHD](guarded-fabric-vm-shielding-helper-vhd.md)<br><br>&nbsp;&nbsp;Hosting service provider | A Windows PowerShell cmdlet included in **Remote Server Administration Tools &gt; Feature Administration Tools &gt; Shielded VM Tools**. With the cmdlet, a hosting service provider can create a VM Shielding Helper VHD to use when converting existing VMs to shielded VMs. |
| \*&nbsp;&nbsp;**Continuation of Scenario 1**: [Shielded VMs - Tenant creates shielding data to define a shielded VM](guarded-fabric-tenant-creates-shielding-data.md)<br><br>&nbsp;&nbsp;Tenant | Windows PowerShell, plus the Shielding Data File Wizard, which is included in **Remote Server Administration Tools &gt; Feature Administration Tools &gt; Shielded VM Tools**<br><br>VMM - The procedure that uses VMM in this topic describes how to create a shielded VM. |
| **Scenario 2** - [Deploy a shielded VM by using Windows Azure Pack](guarded-fabric-shielded-vm-windows-azure-pack.md)<br><br>Hosting service provider and tenant | System Center 2016 - Service Provider Foundation (SPF)<br><br>Windows Azure Pack<br><br>In addition, this scenario depends on infrastructure like that described in **Scenario 1**, which uses VMM. |
| [Shielded VMs - Generate an answer file by using the New-ShieldingDataAnswerFile function](guarded-fabric-sample-unattend-xml-file.md) (optional)<br><br>Tenant (in coordination with hosting service provider) | The **New-ShieldingDataAnswerFile** function, which can be downloaded from the PowerShell Gallery, as described in the topic.<br><br>This topic also provides some steps for using VMM in a way that works with specific options in the answer file you create. |
| [Shielded VMs - Create a new shielded VM on-premises and move it to a guarded fabric](guarded-fabric-create-vm-move-to-guarded-fabric.md) (optional)<br><br>Tenant (in coordination with hosting service provider) | Windows PowerShell cmdlets<br><br>Hyper-V Role<br><br>**Remote Server Administration Tools &gt; Feature Administration Tools &gt; Shielded VM Tools** |


 ## See also
 
 - [Guarded fabric and shielded VMs](guarded-fabric-and-shielded-vms-top-node.md)
