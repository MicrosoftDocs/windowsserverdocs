---
title: Verify AD DS restore
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 9b5e7018-9c38-4cf8-88dd-7ae3ad66f3df
author: Femila
---
# Verify AD DS restore
  After you complete a restore of Active Directory Domain Services \(AD DS\), you can use this procedure to verify the restore.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To verify an Active Directory restorefrom backup  
  
1.  After the restore operation completes, restart the computer in Start Windows Normally mode. If you used Bcdedit.exe to configure startup in Directory Services Restore Mode \(DSRM\), see [Restart the Domain Controller in Directory Services Restore Mode Remotely](../Topic/Restart-the-Domain-Controller-in-Directory-Services-Restore-Mode-Remotely.md) or [Restart the Domain Controller in Directory Services Restore Mode Locally](../Topic/Restart-the-Domain-Controller-in-Directory-Services-Restore-Mode-Locally.md) for information about changing the configuration back to normal startup mode.  
  
2.  After you are able to log on to the system, perform the following verification steps:  
  
    -   At a command prompt, use the **repadmin \/showsig** command to verify that the invocation ID has changed. The invocation ID is the directory database globally unique identifier \(GUID\), which the Directory System Agent \(DSA\) uses to identify the version of the database. The invocation ID changes during the Active Directory restore process to ensure the consistency of the replication process. Verify that the previous entry appears in the retired signatures list.  
  
    -   At a command prompt, use the **repadmin \/showrepl** command to verify that there are no replication errors and all directory partitions are replicating properly with the required replication partners. You can determine the replication partners by selecting the NTDS Settings object for the restored server in Active Directory Sites and Services.  
  
    -   At a command prompt, use the **net share** command to verify that the NETLOGON and SYSVOL shares appear.  
  
    -   At a command prompt, use the **dcdiag** command to verify success of all tests on the domain controller.  
  
    -   Use Active Directory Users and Computers to verify that the deleted objects that you wanted to recover from the backup are restored. If you have a Volume Shadow Copy Service \(VSS\) snapshot of the database, you can use the Active Directory database mounting tool \(Dsamain.exe\) to mount the database and view it through Active Directory Users and Computers to compare the objects. For information about the Active Directory database mounting tool, see the Step\-by\-Step Guide for Using the Active Directory Database Mounting Tool in Windows Server 2008 \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=103333](http://go.microsoft.com/fwlink/?LinkId=103333)\).  
  
  