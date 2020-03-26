---
title: "Configure Server Storage"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ef7ddcdd-3a74-40ca-9487-c3a6fc5155a5
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Configure Server Storage

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

## Sample hard disk configurations  
 The following table suggests sample hard disk configurations. The estimates are based on typical usage and functionality, but they do not address issues that affect optimal performance. You can use any type of supported hard disks for these configurations (such as SATA or SCSI), based on the preferences and needs of your customer.  
  
> [!IMPORTANT]
>   Windows Server Essentials must be installed as C: volume, and the volume size must be at least 60 GB. It is recommended that you create two partitions on your operating system disk, and not use the C: (system partition) to store any business data.  
  
|Server level|Disk configuration|  
|------------------|------------------------|  
|Entry|- Two physical disks<br /><br /> - Configured as a RAID 1 mirrored set that contains the following:<br /><br /> - C: volume  ? 60 GB<br /><br /> - D: volume  ? 1000 GB|  
|Medium|- Three physical disks<br /><br /> - Configured as a RAID 5 set that contains the following:<br /><br /> - C: volume  ? 60 GB<br /><br /> - D: volume  ? 1500 GB|  
|High|- Five or more total physical disks<br /><br /> - Two disks in a RAID 1 mirrored set that contains the C: volume  ? 100 GB<br /><br /> - All remaining disks in a RAID 5 set that contains the following:<br /><br /> - D: volume  ? 1500 GB<br /><br /> - E: volume  ? 1500 GB|  
  
 These recommendations take into account the size of the installed operating system, the average size of the data storage that the server uses, and the expected data storage growth over the lifetime of the server. The volumes can be partitions on a single physical disk or they can be placed on separate physical disks. Because the server stores important data for your customer, it is recommended that you use multiple physical disks and help protect your customer's data by using hardware RAID or Storage Spaces.  
  
## Configuring your server backup  
 In addition to the internal hard disks on the server, customers should consider using external USB hard disks for backups. Ideally, the customer would have at least two external hard disks with enough capacity to back up all of the data on the server. If external hard disks are used, the customer can take one disk off-site each night to further protect the data.  
  
## Partition configuration  
 During Initial Configuration for the server, a set of default server folders that include shared folders and the client computer backup folder are created in the largest data partition on Disk 0.  
  
## See Also  

 [Getting Started with the Windows Server Essentials ADK](Getting-Started-with-the-Windows-Server-Essentials-ADK.md)   
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)

 [Getting Started with the Windows Server Essentials ADK](../install/Getting-Started-with-the-Windows-Server-Essentials-ADK.md)   
 [Creating and Customizing the Image](../install/Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](../install/Additional-Customizations.md)   
 [Preparing the Image for Deployment](../install/Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](../install/Testing-the-Customer-Experience.md)

