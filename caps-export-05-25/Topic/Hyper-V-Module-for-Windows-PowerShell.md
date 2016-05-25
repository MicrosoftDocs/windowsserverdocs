---
title: Hyper-V Module for Windows PowerShell
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 33da2ca3-76a3-45b1-b5ae-f60ab64732ee
author: cwatsonmsft
---
# Hyper-V Module for Windows PowerShell
The Hyper\-V module for Windows PowerShell includes more than 160 Hyper\-V cmdlets. These cmdlets provide an easy way to automate Hyper\-V management tasks.  
  
For an alphabetical list of all Hyper\-V cmdlets [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], as well as links to reference content for each cmdlet \(including examples\), see [Hyper\-V Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/hh848559.aspx).  
  
> [!TIP]  
> The Hyper\-V module supports the Update\-Help cmdlet, which allows you to download the newest help files for Windows PowerShell modules and install the files on your computer. Your account must be a member of the Administrators group on the computer you want to update. To update Help for the Hyper\-V module, start Windows PowerShell with the "Run as administrator" option \(`Start-Process PowerShell -Verb RunAs`\) and run the following command: `PS C:\> Update-Help –Module Hyper-V`  
  
## Key benefits of the Hyper\-V cmdlets  
The new Hyper\-V cmdlets for Windows PowerShell provide IT pros with an easy way to enable automation of management tasks. With the extensive number of Hyper\-V cmdlets and the close integration with other parts of the operating system, administrators can now easily enable automation of Hyper\-V\-related tasks in their environment.  
  
### Task\-oriented interface.  
Hyper\-V cmdlets are designed so that it is easy for IT pros to go from thinking about the task to actually performing the task. The following table shows the task and the associated cmdlet syntax:  
  
|||  
|-|-|  
|**Task**|**Windows PowerShell command to perform the task**|  
|Create a new virtual machine named “test”|New\-VM –Name Test|  
|Get a list of all virtual machines|Get\-VM|  
|Create a new virtual hard disk at d:\\VHDs\\test.vhd|New\-VHD –Path D:\\VHDs\\test.vhd|  
|Start all virtual machines whose name begins with “web”|Start\-VM –Name web\*|  
|Connect the virtual network adapter on the “test” virtual machine to the “QA” switch.|Connect\-VMNetworkAdapter –VMName test –SwitchName QA|  
  
### Use of standard cmdlet verbs.  
Hyper\-V administrators often need to manage more than just Hyper\-V. By using the same verbs as other Windows cmdlets, the Hyper\-V cmdlets make easier for administrators to extend their existing knowledge of Windows PowerShell. For example, administrators who are familiar with managing services through Windows PowerShell can reuse the same verbs to perform the corresponding tasks on a virtual machine, as shown in the following table:  
  
||||  
|-|-|-|  
|**Task**|**Cmdlet for performing task on a service**|**Cmdlet for performing task on a virtual machine**|  
|Get|Get\-Service|Get\-VM|  
|Configure|Set\-Service|Set\-VM|  
|Create|New\-Service|New\-VM|  
|Start|Start\-Service|Start\-VM|  
|Stop|Stop\-Service|Stop\-VM|  
|Restart|Restart\-Service|Restart\-VM|  
|Suspend|Suspend\-Service|Suspend\-VM|  
|Resume|Resume\-Service|Resume\-VM|  
  
There are similar examples with other core Windows PowerShell cmdlets as well:  
  
|||  
|-|-|  
|**Core Windows PowerShell cmdlet**|**Hyper\-V cmdlet**|  
|Import\-Csv|Import\-VM|  
|Export\-Csv|Export\-VM|  
|Enable\-PSRemoting|Enable\-VMMigration|  
|Checkpoint\-Computer|Checkpoint\-VM|  
|Measure\-Command|Measure\-VM|  
  
### Consistent cmdlet nouns to simplify discoverability.  
The nouns of the Hyper\-V cmdlets are designed to make it easier for administrators to discover the cmdlets they need when they need them. All cmdlets in the Hyper\-V module use one of three following noun prefixes:  
  
|||  
|-|-|  
|**Prefix**|**Purpose**|  
|VM|Cmdlets for managing virtual machines|  
|VHD|Cmdlets for managing virtual hard disk files|  
|VFD|Cmdlets for managing virtual floppy disk files|  
  
## See Also  
[Hyper\-V Overview](assetId:///5aad349f-ef06-464a-b36f-366fbb040143)  
  
