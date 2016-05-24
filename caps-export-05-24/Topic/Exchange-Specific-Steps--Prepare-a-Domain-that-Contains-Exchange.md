---
title: Exchange-Specific Steps: Prepare a Domain that Contains Exchange
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d2d47d22-85bb-47e9-b66d-6843cf681d83
author: Femila
---
# Exchange-Specific Steps: Prepare a Domain that Contains Exchange
    
> [!IMPORTANT]  
>  You can use this procedure to prepare a domain that contains Exchange for a domain rename operation. The Windows Server 2008 domain rename operation is not supported in an Active Directory forest that contains Exchange Server 2003, Exchange Server 2003 Service Pack 2 \(SP2\), Exchange Server 2007, or Exchange Server 2007 Service Pack 1 \(SP1\).  
  
 If your forest contains Exchange 2003 Service Pack 1 \(SP1\) servers, you can run the Windows Server 2008 domain rename operation, but you must also use the Exchange Domain Rename Fix\-up Tool to update Exchange attributes. For more information, see Microsoft Exchange Server Domain Rename Fixup \(XDR\-Fixup\) [http:\/\/go.microsoft.com\/fwlink\/?LinkID\=122982](http://go.microsoft.com/fwlink/?LinkID=122982)\). This document describes preliminary steps and instructions for running the Exchange Domain Rename Fix\-up Tool. As part of the preliminary steps, you must move Exchange off all domain controllers and discontinue Exchange configuration changes.  
  
  