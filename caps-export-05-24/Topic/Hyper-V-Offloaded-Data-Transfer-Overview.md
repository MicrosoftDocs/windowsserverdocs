---
title: Hyper-V Offloaded Data Transfer Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 181704a3-dd79-47cf-965c-60cf0d98b8c6
author: cwatsonmsft
---
# Hyper-V Offloaded Data Transfer Overview
To take advantage of innovations in storage hardware that provide near\-instantaneous copying of large amounts of data, Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces Offloaded Data Transfer. With this new feature, Hyper\-V workloads use the offload semantics of the host hardware, as well as the virtual storage stack, to perform certain internal operations on virtual hard disks that require large amounts of data to be copied. Hyper\-V performs these operations faster than was previously possible.  
  
## Key benefits  
Hyper\-V Offloaded Data Transfer is a new hardware feature that allows for copying large amounts of data from one location to another. By providing support for offloaded data transfer in the Hyper\-V storage stack, this feature makes it possible to complete these operations in a fraction of the time it would have taken without the support. Allowing the virtualized workload to use the semantics for offloaded data transfer by passing from the workload to the host hardware helps the virtualized workload operate as efficiently as it would in a non\-virtualized environment.  
  
## Requirements  
Hyper\-V Offloaded Data Transfer requires the following:  
  
-   Offloaded Data Transfer–capable hardware to host the virtual hard disk files. The hardware needs to be connected to the virtual machine as virtual SCSI devices or directly attached physical disks \(sometimes referred to as pass\-through disks\).  
  
-   This optimization is also supported for natively attached, VHDX\-based virtual disks.  
  
-   VHD\-based or VHDX\-based virtual disks attached to a virtual IDE controller do not support this optimization because IDE devices lack support for Offloaded Data Transfer.  
  
## Technical overview  
Storage area network \(SAN\) vendors are working to provide near\-instantaneous copy operations of large amounts of data. This storage is designed to allow the system above the disks to specify the move of a specific data set from one location to another \(an “offloaded data transfer”\).  
  
Crucial maintenance tasks for virtual hard disks—such as merge, move, and compact—depend on copying large amounts of data. The current method of copying data requires data to be read in and written to different locations, which can be a time\-consuming process.  
  
The storage stack of Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] supports offloaded data transfer operations so that these operations can be passed from the guest operating system to the host hardware. This ensures that the workload can use storage enabled for offloaded data transfer as it would if it were running in a non\-virtualized environment. The Hyper\-V storage stack also issues offloaded data transfer operations during maintenance operations for virtual hard disks, such as merging disks and storage migration meta\-operations where large amounts of data are moved.  
  
## See Also  
[Windows Offloaded Data Transfers Overview](../Topic/Windows-Offloaded-Data-Transfers-Overview.md)  
  
