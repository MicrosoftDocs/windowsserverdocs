---
title: Hyper-V Support for Large Sector Disks Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3e97f1a6-3840-439a-a9e7-6ae946268f7a
author: cwatsonmsft
---
# Hyper-V Support for Large Sector Disks Overview
Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces support for large sector size disks to help ensure compatibility with emerging innovations in storage hardware.  
  
The data storage industry is transitioning the physical format of hard disk drives from 512\-byte sectors to 4096\-byte sectors \(also known as 4K or 4 KB sectors\). This transition is driven by several factors, including increases in storage density and reliability.  
  
However, most of the software industry has depended on disk sectors of 512 bytes in length. A change in sector size introduces compatibility issues in many applications. To minimize the impact on the industry, hard drive vendors are introducing transitional 512\-byte emulation \(512e\) drives. These drives offer some of the advantages offered by 4 KB native drives \(such as improved format efficiency and an improved scheme for error correction codes \(ECC\)\), but with fewer compatibility issues than by exposing a 4 KB sector size at the disk interface.  
  
## Key benefits  
The storage industry is introducing 4 KB physical format drives to provide increased capacity. This new format is expected to be widely adopted by customers. Updates to the virtualization stack in Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] ensure compatibility for storage configurations where the underlying physical hard disk uses the new 4 KB format.  
  
## Requirements  
This feature requires physical disk drives that use either the 512e or native 4 KB format.  
  
## Technical overview  
Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides the following:  
  
### Support for improved performance of VHDs on 512e disks  
512e disks can perform write operations only in terms of a physical sector—that is, it cannot directly write a 512\-byte sector write issued to it. The internal process in the disk that makes this write possible consists of the following steps:  
  
1.  The disk reads the 4 KB physical sector into its internal cache, which contains the 512\-byte logical sector referred to in the write.  
  
2.  Data in the 4 KB buffer is modified to include the updated 512\-byte sector.  
  
3.  The disk performs a write of the updated 4 KB buffer back to its physical sector on the disk.  
  
This process is called a Read\-Modify\-Write \(RMW\). This RMW process causes performance degradation in virtual hard disks \(VHDs\) because to the following reasons:  
  
1.  Dynamic and differencing VHDs have a 512\-byte sector bitmap in front of their data payload. In addition, footer\/header\/Parent Locators all align to a 512\-byte sector. Therefore, it is common for the VHD driver to issue 512\-byte writes to update these structures, which results in the RMW behavior described above.  
  
2.  It is common for applications to issue reads and writes in multiples of 4 KB sizes \(the default cluster size of NTFS\). Because there is a 512\-byte sector bitmap in front of the data payload block of dynamic and differencing VHDs, the 4 KB blocks are not aligned to the physical 4 KB boundary. Each 4 KB write issued by the current parser to update the payload data results in two reads for two blocks on the disk, which are then updated and subsequently written back to the two disk blocks.  
  
The overall performance impact to the workloads was in the range of 30% to 80% and was even higher at times.  
  
Hyper\-V mitigates the performance impact of 512e disks on the VHD stack by padding the previously mentioned structures to be aligned to 4 KB boundaries in the VHD format. This mitigates the RMW impact when accessing the data within the VHD file, as well as when updating the VHD metadata structures.  
  
### Support for hosting VHDs on native 4 KB disks  
The current VHD driver assumes a physical sector size of 512 bytes and issues 512\-byte I\/Os, which makes it incompatible with these disks. As a result, the current VHD driver cannot open VHD files on physical 4 KB sector disks. Hyper\-V makes it possible to store VHDs on 4 KB disks by implementing a software RMW algorithm in the VHD layer to convert the 512\-byte access and update request to the VHD file to corresponding 4 KB accesses and updates.  
  
## See Also  
[Hyper\-V Virtual Hard Disk Format Overview](assetId:///248806ae-6797-46d1-b1be-24cbf1bafba4)  
  
