---
title: Deploy IPAM VMM Integration
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ab8cc6c1-e565-4b1e-bfb2-24723f8e2e4a
---
# Deploy IPAM VMM Integration
IPAM integration with System Center Virtual Machine Manager \(VMM\) was introduced in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. You cannot integrate VMM with IPAM if the IPAM server is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
The **VIRTUALIZED IP ADDRESS SPACE** node in the upper navigation pane of the IPAM client console displays address space that is managed by VMM.  
  
For more information about VMM, see [Virtual Machine Manager](http://technet.microsoft.com/library/gg610610.aspx).  
  
## Deploy VMM integration  
IPAM can be integrated with VMM by adding and configuring the Microsoft Windows Server IP Address Management network service in VMM. On the IPAM server, you must also configure an account that is used by VMM to communicate with IPAM.  
  
To configure IPAM\-VMM integration, follow the procedures in [Configure IPAM VMM Integration](../Topic/Configure-IPAM-VMM-Integration.md).  
  
To synchronize virtualized IP address space in IPAM with logical networks in VMM, see [Synchronize IPAM and VMM](../Topic/Synchronize-IPAM-and-VMM.md).  
  
## See also  
[Managing Virtual IP Address Space](../Topic/Managing-Virtual-IP-Address-Space.md)  
  
[How to Add an IPAM Server in VMM in System Center 2012 R2](http://technet.microsoft.com/library/dn249418.aspx)  
  
