---
title: Configure virtual machines to use SR-IOV only when supported by the guest operating system
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: timlt
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 33cf5b68-e43e-47ef-adbc-6b266c1d4dce
author: KBDAzure
---
# Configure virtual machines to use SR-IOV only when supported by the guest operating system
[This information is preliminary and subject to change.]  
  
For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|||  
|-|-|  
|**Operating System**|Windows Server 2016 Technical Preview|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*One or more virtual machines are configured to use single-root I/O virtualization (SR-IOV), but the guest operating system does not support SR-IOV*  
  
## Impact  
*SR-IOV virtual functions will not be allocated to the following virtual machines:*  
  
\<list of virtual machines>  
  
## Resolution  
*Disable SR-IOV on all virtual machines that run guest operating systems which do not support SR-IOV.*  
  
SR-IOV is supported only in some 64-bit Windows guests. For details, see [Hyper-V feature compatibility by generation and guest](../Hyper-V-feature-compatibility-by-generation-and-guest.md).  
  

