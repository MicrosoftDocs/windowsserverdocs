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

<!-- The "swim lanes" diagram will be nice, when it's available - link to it. -->

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<thead>
<tr class="header">
<th>Scenario or option<br>Who performs this?</th>
<th>Technologies used</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>**Scenario 1** - [Deploy guarded hosts and shielded virtual machines in VMM](https://technet.microsoft.com/system-center-docs/vmm/scenario/guarded-overview)</p>
<p>Hosting service provider</p></td>
<td><p>System Center Virtual Machine Manager (VMM)</p></td>
</tr>
<tr class="even">
<td><ul><li><p>**Continuation of Scenario 1**: [Shielded VMs - Hosting service provider creates a shielded VM template](guarded-fabric-create-a-shielded-vm-template.md)</p><p>Hosting service provider</p></li></ul></td>
<td><ul>
<li><p>Tools for provisioning a VHDX, plus sysprep (for generalizing the VHDX)</p></li>
<li><p>The Protected Template Disk Creation Wizard, which is included in **Remote Server Administration Tools &gt; Feature Administration Tools &gt; Shielded VM Tools**</p></li>
<li><p>Windows PowerShell</p></li>
<li><p>VMM</p>
<p>The procedures that use VMM in this topic describe how to copy a disk to the VMM library and how to create a shielded VM template.</p>
</li>
</ul></td>
</tr>
<tr class="odd">
<td><ul><li><p>**Continuation of Scenario 1**: [Shielded VMs - Hosting service provider prepares a VM Shielding Helper VHD](guarded-fabric-vm-shielding-helper-vhd.md)</p><p>Hosting service provider</p></li></ul></td>
<td><p>A Windows PowerShell cmdlet included in **Remote Server Administration Tools &gt; Feature Administration Tools &gt; Shielded VM Tools**. With the cmdlet, a hosting service provider can create a VM Shielding Helper VHD to use when converting existing VMs to shielded VMs.</p></td>
</tr>
<tr class="even">
<td><ul><li><p>**Continuation of Scenario 1**: [Shielded VMs - Tenant creates shielding data to define a shielded VM](guarded-fabric-tenant-creates-shielding-data.md)</p><p>Tenant</p></li></ul></td>
<td><ul>
<li><p>Windows PowerShell, plus the Shielding Data File Wizard, which is included in **Remote Server Administration Tools &gt; Feature Administration Tools &gt; Shielded VM Tools**</p></li>
<li><p>VMM</p>
<p>The procedure that uses VMM in this topic describes how to create a shielded VM.</p></li>
</ul></td>
</tr>
<tr class="odd">
<td><p>**Scenario 2** - [Deploy a shielded VM by using Windows Azure Pack](guarded-fabric-shielded-vm-windows-azure-pack.md)</p><p>Hosting service provider and tenant</p></td>
<td><ul>
<li><p>System Center 2016 - Service Provider Foundation (SPF)</p></li>
<li><p>Windows Azure Pack</p></li>
</ul>
<p>In addition, this scenario depends on infrastructure like that described in **Scenario 1**, which uses VMM.</p></td>
</tr>
<tr class="even">
<td><p>[Shielded VMs - Generate an answer file by using the New-ShieldingDataAnswerFile function](guarded-fabric-sample-unattend-xml-file.md) (optional)</p><p>Tenant (in coordination with hosting service provider)</p></td>
<td><p>The **New-ShieldingDataAnswerFile** function, which can be downloaded from the PowerShell Gallery, as described in the topic.</p>
<p>This topic also provides some steps for using VMM in a way that works with specific options in the answer file you create.</p></td>
</tr>
<tr class="odd">
<td><p>[Shielded VMs - Create a new shielded VM on-premises and move it to a guarded fabric](guarded-fabric-create-vm-move-to-guarded-fabric.md) (optional)</p><p>Tenant (in coordination with hosting service provider)</p></td>
<td><ul>
<li><p>Windows PowerShell cmdlets</p></li>
<li><p>Hyper-V Role</p></li>
<li><p>**Remote Server Administration Tools &gt; Feature Administration Tools &gt; Shielded VM Tools**</p></li>
</ul></td>
</tr>
</tbody>
</table>

 ## See also
 
 - [Guarded fabric and shielded VMs](guarded-fabric-and-shielded-vms-top-node.md)
