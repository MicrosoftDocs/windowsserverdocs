---
title: Avoid enabling storage Quality of Service when using a differencing virtual hard disk when the parent and child virtual hard disks are on different volumes
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: timlt
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.author: kathydav
ms.topic: article
ms.assetid: aa9ed408-65cf-40dc-aad2-118b54c70179
author: KBDAzure
---
# Avoid enabling storage Quality of Service when using a differencing virtual hard disk when the parent and child virtual hard disks are on different volumes

>Applies To: Windows Server Technical Preview

[This information is preliminary and subject to change.]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016 Technical Preview|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.
  
## **Issue**  
*A differencing virtual hard disk with the parent and child virtual hard disks on different volumes has storage Quality of Service enabled.*  
  
## **Impact**  
*This configuration may result in unexpected storage Quality of Service behavior for the differencing virtual hard disk, as well as other virtual hard disks on the parent and child volumes. This impacts the following the virtual hard disks:*  
  
\<list of virtual hard disks>  
  
## **Resolution**  
*Disable storage Quality of Service on the referenced virtual hard disks, or perform a storage migration to move the parent and the child virtual hard disk to the same volume.*  
  


