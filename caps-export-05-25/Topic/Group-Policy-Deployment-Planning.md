---
title: Group Policy Deployment Planning
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d60b4c69-0fb8-4c43-8fab-ab8ba226d89a
author: coreyp
---
# Group Policy Deployment Planning
Before you deploy Group Policy, you must plan the membership and exception groups.  
  
## Planning the membership and exception groups  
There is one membership group for each set of GPOs that contain configuration data for your client computers and users. Adding a user or computer account to the group enables that user or computer to read and apply all of the GPOs associated with the group.  
  
To limit the user or computer to only one GPO of the several that might be associated with the membership group, create and assign WMI filters to each GPO. A WMI filter is evaluated to determine if a GPO should be applied to the user or computer. For example, the WMI filters described in this guide contain information about the version of the Windows operating system. For more information about creating WMI filters, see WMI Filtering Using GPMC \([http:\/\/go.microsoft.com\/fwlink\/?linkid\=93188](http://go.microsoft.com/fwlink/?linkid=93188)\).  
  
If there are some computers in the membership group that should not apply the GPO, then you can create an exception group that is denied permission to apply the GPO. Because deny permissions override allow permissions, a user or computer that is a member of both groups will not apply the GPO.  
  
## Planning domain access  
To log on to the domain, the computer must be a domain member computer and the user account must be created in AD DS before the logon attempt.  
  
For more information, see the "Joining Computers to the Domain and Logging On" topic in the [Core Network Guide](assetId:///fc238dce-9289-4e8f-af04-0aa06e664e85).  
  
