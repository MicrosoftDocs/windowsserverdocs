---
title: iSCSI Target Server Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a8807933-ef0b-4dd2-9920-4ac0f7199923
author: JasonGerend
---
# iSCSI Target Server Overview
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], iSCSI Target Server is available as a role service under the File and Storage Services role in Server Manager. If you are looking for ways to automate management tasks, a complete set of Windows PowerShell cmdlets are also available.  
  
|||  
|-|-|  
|![](b93f8edc-baa1-46ad-aed5-99c8690273c0)|Did you know that Microsoft Azure provides similar functionality in the cloud? Learn more about [Microsoft Azure storage solutions](http://aka.ms/y03tdi).<br /><br />Create a hybrid storage solution in Microsoft Azure:<br />\- [Learn about StorSimple hybrid cloud storage](http://aka.ms/fuxxdp)<br />\- [Use Azure StorSimple for hybrid cloud storage](http://aka.ms/x9a7wq)|  
  
iSCSI Target Server is ideal for the following:  
  
1.  **Network and diskless boot** By using boot\-capable network adapters or a software loader, you can deploy hundreds of diskless servers. With iSCSI Target Server, the deployment is fast. In Microsoft internal testing, 256 computers deployed in 34 minutes. By using differencing virtual hard disks, you can save up to 90% of the storage space that was used for operating system images. This is ideal for large deployments of identical operating system images, such as on virtual machines running Hyper\-V or in high\-performance computing \(HPC\) clusters.  
  
2.  **Server application storage** Some applications require block storage. iSCSI Target Server can provide these applications with continuously available block storage. Because the storage is remotely accessible, it can also consolidate block storage for central or branch office locations.  
  
3.  **Heterogeneous storage** iSCSI Target Server supports non\-Microsoft iSCSI initiators, making it easy to share storage on servers in a mixed software environment.  
  
4.  **Development, test, demonstration, and lab environments** When iSCSI Target Server is enabled, a computer running the Windows Server operating system becomes a network\-accessible block storage device. This is useful for testing applications prior to deployment in a storage area network \(SAN\).  
  
## Block storage requirements  
Enabling iSCSI Target Server to provide block storage leverages your existing Ethernet network. No additional hardware is needed. If high availability is an important criterion, consider setting up a high\-availability cluster. You need shared storage for a high\-availability cluster—either hardware for Fibre Channel storage or a serial attached SCSI \(SAS\) storage array.  
  
If you enable guest clustering, you need to provide block storage. Any servers running Windows Server software with iSCSI Target Server can provide block storage.  
  
## See Also  
[iSCSI Target Block Storage, How To](../Topic/iSCSI-Target-Block-Storage,-How-To.md)  
[What's New for iSCSI Target in Windows Server 2012 R2](assetId:///3858a8b3-4eb7-448b-a535-c1264449f378)  
  
