---
title: Back Up Domain Controllers
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: eb358221-3fa2-4568-a268-723213eaf089
author: Femila
---
# Back Up Domain Controllers
  You can use this procedure to back up domain controllers after a domain rename operation. As a result of the domain rename operation, the content of the Active Directory database, system registry, and Group Policy objects \(GPOs\) on the domain controllers change. Therefore, the existing backups that you have taken for the domain controllers are no longer valid.  
  
-   **Back up system state**  
  
     Perform a full system state backup of all domain controllers in the forest so that you have a recoverable backup state. For more information, see the Step\-by\-Step Guide for Windows Server 2008 Active Directory Domain Services Backup and Recovery \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93077](http://go.microsoft.com/fwlink/?LinkId=93077)\).  
  
-   **Back up GPOs**  
  
     If you use Group Policy, consider installing the Group Policy Management Console \(GPMC\). For more information, see GPMC \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=123307](http://go.microsoft.com/fwlink/?LinkID=123307)\). GPMC makes Group Policy easier to use, and it adds functional improvements such as the ability to back up GPOs independently of the rest of Active Directory Domain Services \(AD DS\). GPOs that you back up with GPMC before the domain rename operation cannot be restored after domain rename. Therefore, we recommend that after a domain rename operation, you use GPMC to back up all the GPOs again.  
  
    > [!NOTE]  
    >  Saved GPMCs for a domain will no longer work after you rename a domain. If you want to use saved GPMCs, you have to re\-create them after the domain rename operation.  
  
  