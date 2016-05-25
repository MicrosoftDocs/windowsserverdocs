---
title: Virtual Machine Storage Migration Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a23814c8-38db-48d8-8d99-201df33441d3
author: cwatsonmsft
---
# Virtual Machine Storage Migration Overview
In Windows Server 2008 R2, you can move a running instance of a virtual machine using live migration, but you are not able to move the virtual machine’s storage while the virtual machine is running.  
  
Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces support for moving virtual machine storage without downtime by making it possible to move the storage while the virtual machine remains running. You can perform this task by using a new wizard in Hyper\-V Manager or by using new Hyper\-V cmdlets for Windows PowerShell.  
  
You can add storage to either a stand\-alone computer or to a Hyper\-V cluster, and then move virtual machines to the new storage while the virtual machines continue to run.  
  
The most common reason for moving a virtual machine’s storage is to update the physical storage that is available to Hyper\-V. You can also move virtual machine storage between physical storage devices, at run time, to respond to reduced performance that results from bottlenecks in the storage throughput.  
  
## Key benefits  
Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] makes it possible to move virtual machine storage while a virtual machine is running.  
  
## Requirements  
You need the following to use the Hyper\-V functionality of moving virtual machine storage:  
  
-   One or more installations of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] with the Hyper\-V role installed.  
  
-   A server that is capable of running Hyper\-V. Specifically, it must have processor support for hardware virtualization.  
  
-   Virtual machines that are configured to use only virtual hard disks for storage.  
  
> [!NOTE]  
> You cannot move the storage of a virtual machine when any of its storage is directly attached to a physical disk.  
  
## Technical overview  
This new feature allows you to move the virtual hard disks of a virtual machine while those virtual hard disks remain available for use by the running virtual machine. When you move a running virtual machine’s virtual hard disks, Hyper\-V performs the following steps, as shown in Figure 1:  
  
![](../Image/1_Stor_Mig_HV_Rev_Guide.gif)  
  
**Figure 1  Moving virtual hard disks**  
  
1.  Throughout most of the move operation, disk reads and writes go to the source virtual hard disk.  
  
2.  While reads and writes occur on the source virtual hard disk, the disk contents are copied  to the new destination virtual hard disk.  
  
3.  After the initial disk copy is complete, disk writes are mirrored to both the source and destination virtual hard disks while outstanding disk changes are replicated.  
  
4.  After the source and destination virtual hard disks are completely synchronized, the virtual machine switches over to using the destination virtual hard disk.  
  
5.  The source virtual hard disk is deleted.  
  
## See Also  
[WS2012 Hyper\-V Live Migration and Live Storage Migration](http://channel9.msdn.com/events/TechEd/Australia/2012/VIR314)  
  
