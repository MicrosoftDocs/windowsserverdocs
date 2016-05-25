---
title: Planning Forest Root Domain Controller Placement
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: 59631b0e-29bc-4587-9818-5a4a3a856542
author: Femila
---
# Planning Forest Root Domain Controller Placement
Forest root domain controllers are needed to create trust paths for clients that need to access resources in domains other than their own. Place forest root domain controllers in hub locations and at locations that host datacenters. If users in a given location need to access resources from other domains in the same location, and the network availability between the datacenter and the user location is unreliable, you can either add a forest root domain controller in the location or create a shortcut trust between the two domains. It is more cost efficient to create a shortcut trust between the domains unless you have other reasons to place a forest root domain controller in that location.  
  
Shortcut trusts help to optimize authentication requests made from users located in either domain. For more information about shortcut trusts between domains, see Understanding When to Create a Shortcut Trust \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=107061](http://go.microsoft.com/fwlink/?LinkId=107061)\).  
  
For a worksheet to assist you in documenting your forest root domain controller placement, see Job Aids for Windows Server 2003 Deployment Kit \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=102558](http://go.microsoft.com/fwlink/?LinkID=102558)\), download Job\_Aids\_Designing\_and\_Deploying\_Directory\_and\_Security\_Services.zip, and open "Domain Controller Placement" \(DSSTOPO\_4.doc\).  
  
You will need to refer to this information when you create the forest root domain. For more information about deploying the forest root domain, see [Deploying a Windows Server 2008 Forest Root Domain](Deploying-a-Windows-Server-2008-Forest-Root-Domain.md).  
  

