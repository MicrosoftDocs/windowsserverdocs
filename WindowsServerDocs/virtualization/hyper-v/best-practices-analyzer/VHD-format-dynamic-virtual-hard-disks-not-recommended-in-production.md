---
title: VHD-format dynamic virtual hard disks are not recommended for virtual machines that run server workloads in a production environment
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 324a60a0-1d15-4ef2-9f17-23cbd2eb42ce
author: KBDAzure
ms.date: 8/16/2016
---
# VHD-format dynamic virtual hard disks are not recommended for virtual machines that run server workloads in a production environment

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](https://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.
  
## **Issue**  
*One or more virtual machines use VHD-format dynamically expanding virtual hard disks.*  
  
## **Impact**  
*VHD-format dynamic virtual hard disks could experience consistency issues if a power failure occurs. Consistency issues can happen if the physical disk performs an incomplete or incorrect update to a sector in a .vhd file that is being modified when a power failure occurs. This affects the following virtual machines:*  
  
\<list of virtual machines>  
  
## **Resolution**  
*Shut down the virtual machine and convert the VHD-format dynamic virtual hard disk to a VHDX-format virtual hard disk or to a fixed virtual hard disk. (The VHDX format has reliability mechanisms that help protect the disk from corruptions due to system power failures.) However, do not convert the virtual hard disk if it is likely to be attached to an earlier release of Windows at some point. Windows releases earlier than  Windows Server 2012  do not support the VHDX format.*  
  


