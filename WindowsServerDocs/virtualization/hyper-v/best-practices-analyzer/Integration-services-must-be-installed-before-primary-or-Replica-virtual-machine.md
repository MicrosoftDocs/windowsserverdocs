---
title: Integration services must be installed before primary or Replica virtual machines can use an alternate IP address after a failover
description: "Online version of the text for this Best Practices Analyzer rule, with links to more information."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: a7fdd185-d6c8-4f58-9b58-2df5827bb056
author: KBDAzure
ms.date: 8/16/2016
---
# Integration services must be installed before primary or Replica virtual machines can use an alternate IP address after a failover

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](https://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Error|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*Virtual machines participating in replication can be configured to use a specific IP address in the event of failover, but only if integration services are installed in the guest operating system of the virtual machine.*  
  
## Impact  
*In the event of a failover (planned, unplanned, or test), the Replica virtual machine will come online using the same IP address as the primary virtual machine. This configuration might cause connectivity issues. This impacts the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
*Use Virtual Machine Connection to install integration services in the virtual machine.*  
  
As of Windows Server 2016, integration services for Windows virtual machines are delivered through Windows Update. Ensure these virtual machines are configured to receive Windows updates to get the latest version of integration services. The Linux kernel now includes Linux integration services (LIS) and is updated for new releases, but Linux distributions based on older kernels may not have the latest enhancements or fixes. For details, see [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](../Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md).


