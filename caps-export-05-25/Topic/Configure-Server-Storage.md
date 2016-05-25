---
title: Configure Server Storage
ms.custom: na
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ef7ddcdd-3a74-40ca-9487-c3a6fc5155a5
author: cfreemanwa
---
# Configure Server Storage
  
## Sample hard disk configurations  
The following table suggests sample hard disk configurations. The estimates are based on typical usage and functionality, but they do not address issues that affect optimal performance. You can use any type of supported hard disks for these configurations \(such as SATA or SCSI\), based on the preferences and needs of your customer.  
  
> [!IMPORTANT]  
> [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] must be installed as C: volume, and the volume size must be at least 60 GB. It is recommended that you create two partitions on your operating system disk, and not use the C: \(system partition\) to store any business data.  
  
|Server level|Disk configuration|  
|----------------|----------------------|  
|Entry|<ul><li>Two physical disks</li><li>Configured as a RAID 1 mirrored set that contains the following:<br /><br /><ul><li>C: volume — 60 GB</li><li>D: volume — 1000 GB</li></ul></li></ul>|  
|Medium|<ul><li>Three physical disks</li><li>Configured as a RAID 5 set that contains the following:<br /><br /><ul><li>C: volume — 60 GB</li><li>D: volume — 1500 GB</li></ul></li></ul>|  
|High|<ul><li>Five or more total physical disks</li><li>Two disks in a RAID 1 mirrored set that contains the C: volume — 100 GB</li><li>All remaining disks in a RAID 5 set that contains the following:<br /><br /><ul><li>D: volume — 1500 GB</li><li>E: volume — 1500 GB</li></ul></li></ul>|  
  
These recommendations take into account the size of the installed operating system, the average size of the data storage that the server uses, and the expected data storage growth over the lifetime of the server. The volumes can be partitions on a single physical disk or they can be placed on separate physical disks. Because the server stores important data for your customer, it is recommended that you use multiple physical disks and help protect your customer’s data by using hardware RAID or Storage Spaces.  
  
## Configuring your server backup  
In addition to the internal hard disks on the server, customers should consider using external USB hard disks for backups. Ideally, the customer would have at least two external hard disks with enough capacity to back up all of the data on the server. If external hard disks are used, the customer can take one disk off\-site each night to further protect the data.  
  
## Partition configuration  
During Initial Configuration for the server, a set of default server folders that include shared folders and the client computer backup folder are created in the largest data partition on Disk 0.  
  
## See Also  
[Getting Started with the Windows Server 2012 Essentials ADK](../Topic/Getting-Started-with-the-Windows-Server-2012-Essentials-ADK.md)  
[Creating and Customizing the Image](../Topic/Creating-and-Customizing-the-Image.md)  
[Additional Customizations](../Topic/Additional-Customizations.md)  
[Preparing the Image for Deployment](../Topic/Preparing-the-Image-for-Deployment.md)  
[Testing the Customer Experience](../Topic/Testing-the-Customer-Experience.md)  
  
