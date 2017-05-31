---
ms.assetid: f964d056-11bf-4d9b-b5ab-dceaad8bfbc3
title: Windows Server 2016 Functional Levels
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Windows Server 2016 Functional Levels

>Applies To: Windows Server 
 
With the end of life of Windows 2003, Windows 2003 domain controllers need to be updated to Windows Server 2008, 2012 or 2016. As a result, any domain controller that runs Windows Server 2003 should be removed from the domain. The domain and forest functional level should be raised to at least Windows Server 2008 to prevent a domain controller that runs an earlier version of Windows Server from being added to the environment.  
  
We recommend that customers update their domain functional level (DFL) and forest functional level (FFL) as part of this, since the 2003 DFL and FFL have been deprecated in Windows Server 2016 and they will no longer be supported in future releases.   
  
For customers who need additional time to evaluate moving their DFL & FFL from 2003, the 2003 DFL and FFL will continue to be supported with Windows 10 and Windows Server 2016 provided all domain controllers in the domain and forest are either on Windows Server 2008, 2012 or 2016."  
   
At the Windows Server 2008 and higher domain functional levels, Distributed File Service (DFS) Replication is used to replicate SYSVOL folder contents between domain controllers. If you create a new domain at the Windows Server 2008 domain functional level or higher, DFS Replication is automatically used to replicate SYSVOL. If you created the domain at a lower functional level, you will need to migrate from using FRS to DFS replication for SYSVOL. For migration steps, you can either follow the [procedures on TechNet](https://technet.microsoft.com/library/dd640019(v=WS.10).aspx) or you can refer to the [streamlined set of steps on the Storage Team File Cabinet blog](http://blogs.technet.com/b/filecab/archive/2014/06/25/streamlined-migration-of-frs-to-dfsr-sysvol.aspx).  
  
The Windows Server 2003 domain and forest functional levels continue to be supported, but organizations should raise the functional level to Windows Server 2008 (or higher if possible) to ensure SYSVOL replication compatibility and support in the future. In addition, there are many other benefits and features available at the higher functional levels higher. See the following resources for more information:  
  
-   [Understanding Active Directory Domain Services (AD DS) Functional Levels](https://technet.microsoft.com/library/understanding-active-directory-functional-levels(WS.10).aspx)  
  
-   [Raise the Domain Functional Level](https://technet.microsoft.com/library/cc753104.aspx)  
  
-   [Raise the Forest Functional Level](https://technet.microsoft.com/library/cc730985.aspx)


