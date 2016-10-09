---
title: Configuration scenarios for shielded VMs in a guarded fabric
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 5d1a06c9-24e1-4e14-9c9a-efb2adbfeddd
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
---

# Configuration scenarios for shielded VMs in a guarded fabric

>Applies To: Windows Server 2016

The following topics describe configuration scenarios for shielded VMs in a guarded fabric that has already been configured. For information about configuring the guarded fabric, see [Deploying the Host Guardian Service for guarded hosts and shielded VMs](guarded-fabric-deploying-hgs-overview.md).

<!-- The "swim lanes" diagram will be nice, when it's available -- link to it. -->

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th>Scenario or option</th>
<th>Technologies used</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>**Scenario 1** - [Deploy guarded hosts and shielded virtual machines in VMM](https://technet.microsoft.com/system-center-docs/vmm/scenario/guarded-overview)</p></td>
<td><p>System Center Virtual Machine Manager (VMM)</p></td>
</tr>
<tr class="even">
<td><ul><li><p>**Continuation of Scenario 1**: [Shielded VMs - Tenant creates shielding data to define a shielded VM](guarded-fabric-tenant-creates-shielding-data.md)</p></li></ul></td>
<td><p>Windows PowerShell, plus the Shielding Data File Wizard, which is included in **Remote Server Administration Tools &gt; Feature Administration Tools &gt; Shielded VM Tools**.</p>
<p>This topic also includes information about how to use VMM to create a shielded VM, after you create shielding data.</p></td>
</tr>
<tr class="odd">
<td><ul><li><p>**Continuation of Scenario 1**: [Shielded VMs - Hosting service provider prepares a VM Shielding Helper VHD](guarded-fabric-vm-shielding-helper-vhd.md)</p></li></ul></td>
<td><p>A Windows PowerShell cmdlet included in **Remote Server Administration Tools &gt; Feature Administration Tools &gt; Shielded VM Tools**. With the cmdlet, a hosting service provider can create a VM Shielding Helper VHD to use when converting existing VMs to shielded VMs.</p></td>
</tr>
<tr class="even">
<td><p>**Scenario 2** - [Deploy a shielded VM by using Windows Azure Pack](guarded-fabric-shielded-vm-windows-azure-pack.md)</p></td>
<td><p>System Center 2016 - Service Provider Foundation (SPF) and Windows Azure Pack.</p>
<p>In addition, this scenario depends on infrastructure like that described in **Scenario 1**, which uses VMM.</p></td>
</tr>
<tr class="odd">
<td><p>[Shielded VMs - Generate an answer file by using the New-ShieldingDataAnswerFile function](guarded-fabric-sample-unattend-xml-file.md)</p></td>
<td><p>The **New-ShieldingDataAnswerFile** function, which can be downloaded from the PowerShell Gallery, as described in the topic.</p>
<p>This topic also provides some steps for using VMM in a way that works with specific options in the answer file you create.</p></td>
</tr>
<tr class="even">
<td><p>[Shielded VMs - Create a new shielded VM on-premises and move it to a guarded fabric](guarded-fabric-create-vm-move-to-guarded-fabric.md)</p></td>
<td><p>Windows PowerShell cmdlets, plus the Hyper-V Role and **Remote Server Administration Tools &gt; Feature Administration Tools &gt; Shielded VM Tools**.</p></td>
</tr>
</tbody>
</table>

 ## See also
 
 - [Guarded fabric and shielded VMs](guarded-fabric-and-shielded-vms-top-node.md)
