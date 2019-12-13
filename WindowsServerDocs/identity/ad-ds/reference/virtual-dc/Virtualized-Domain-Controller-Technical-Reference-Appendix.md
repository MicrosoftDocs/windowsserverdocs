---
ms.assetid: 73a4deba-7da6-4eae-8fdd-2a4d369f9cbb
title: Virtualized Domain Controller Technical Reference Appendix
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Virtualized Domain Controller Technical Reference Appendix

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic covers:  
  
-   [Terminology](../../../ad-ds/reference/virtual-dc/../../../ad-ds/reference/virtual-dc/Virtualized-Domain-Controller-Technical-Reference-Appendix.md#BKMK_Terms)  
  
-   [FixVDCPermissions.ps1](../../../ad-ds/reference/virtual-dc/../../../ad-ds/reference/virtual-dc/Virtualized-Domain-Controller-Technical-Reference-Appendix.md#BKMK_FixPDCPerms)  
  
## <a name="BKMK_Terms"></a>Terminology  
  
-   **Snapshot** - The state of a virtual machine at a particular point in time. It is dependent on the chain of previous snapshots taken, on the hardware, and on the virtualization platform.  
  
-   **Clone** - A complete and separate copy of a virtual machine. It is dependent on the virtual hardware (hypervisor).  
  
-   **Full Clone** - A full clone is an independent copy of a virtual machine that shares no resources with the parent virtual machine after the cloning operation. Ongoing operation of a full clone is entirely separate from the parent virtual machine.  
  
-   **Differencing disk** - A copy of a virtual machine that shares virtual disks with the parent virtual machine in an ongoing manner. This usually conserves disk space and allows multiple virtual machines to use the same software installation.  
  
-   **VM Copy**- A file system copy of all the related files and folders of a virtual machine.  
  
-   **VHD File Copy** - A copy of a virtual machine's VHD  
  
-   **VM Generation ID** - a 128-bit integer given to the virtual machine by the hypervisor. This ID is stored in memory and reset every time a snapshot is applied. The design uses a hypervisor-agnostic mechanism for surfacing the VM-Generation ID in the virtual machine. The Hyper-V implementation exposes the ID in the ACPI table of the virtual machine.  
  
-   **Import/Export** - A Hyper-V feature that allows the user to save the entire virtual machine (VM files, VHD and the machine configuration). It then allows users to using that set of files to bring the machine back on the same machine as the same VM (Restore), on a different machine as the same VM (Move), or a new VM (copy)  
  
## <a name="BKMK_FixPDCPerms"></a>FixVDCPermissions.ps1  
  
```  
# Unsigned script, requires use of set-executionpolicy remotesigned -force  
# You must run the Windows PowerShell console as an elevated administrator  
  
# Load Active Directory Windows PowerShell Module and switch to AD DS drive  
import-module activedirectory  
cd ad:  
  
## Get Domain NC  
$domainNC = get-addomain  
  
## Get groups and obtain their SIDs   
$dcgroup = get-adgroup "Cloneable Domain Controllers"  
  
$sid1 = (get-adgroup $dcgroup).sid  
  
## Get the DACL of the domain  
$acl = get-acl $domainNC  
  
## The following object specific ACE grants extended right 'Allow a DC to create a clone of itself' for the CDC group to the Domain NC  
## 3e0f7e18-2c7a-4c10-ba82-4d926db99a3e is the schemaIDGuid for 'DS-Clone-Domain-Controller"  
  
$objectguid = new-object Guid 3e0f7e18-2c7a-4c10-ba82-4d926db99a3e  
$ace1 = new-object System.DirectoryServices.ActiveDirectoryAccessRule $sid1,"ExtendedRight","Allow",$objectguid  
  
## Add the ACE in the ACL and set the ACL on the object   
  
$acl.AddAccessRule($ace1)  
set-acl -aclobject $acl $domainNC  
write-host "Done writing new VDC permissions."  
cd c:   
```  
  


