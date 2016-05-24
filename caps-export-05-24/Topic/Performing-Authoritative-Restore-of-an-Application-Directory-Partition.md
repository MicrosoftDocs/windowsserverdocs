---
title: Performing Authoritative Restore of an Application Directory Partition
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: fd27743b-70f4-40c9-b47b-6d6403f9f0af
author: Femila
---
# Performing Authoritative Restore of an Application Directory Partition
  A restore of an application directory partition marks all data that is present in the partition as authoritative for the replica set. The information that an application directory partition contains replicates to all domain controllers in the forest that were previously present in the replica set. You should have a current valid backup of the application directory partition before you begin the authoritative restore, in the event that particular object changes are lost because of changes since the backup was created.  
  
 If you deleted an entire application directory partition, you must perform the restore procedure on the domain naming operations master role holder.  
  
 Before you perform the procedures in this task, back up the domain controller that you are restoring. For information about creating backups, see [Backing Up Active Directory Domain Services](../Topic/Backing-Up-Active-Directory-Domain-Services.md).  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   Remote Desktop Connection \(optional\)  
  
-   Bcdedit.exe \(optional\)  
  
-   Ntdsutil.exe  
  
 To complete this task, perform the following procedures:  
  
1.  Restart the domain controller in Directory Services Restore Mode \(DSRM\), as follows:  
  
     [Restart the Domain Controller in Directory Services Restore Mode Locally](../Topic/Restart-the-Domain-Controller-in-Directory-Services-Restore-Mode-Locally.md)  
  
     Or  
  
     [Restart the Domain Controller in Directory Services Restore Mode Remotely](../Topic/Restart-the-Domain-Controller-in-Directory-Services-Restore-Mode-Remotely.md)  
  
2.  [Restore AD DS from Backup &#40;Nonauthoritative Restore&#41;](../Topic/Restore-AD-DS-from-Backup--Nonauthoritative-Restore-.md). Do not restart the domain controller.  
  
3.  [Mark an application directory partition as authoritative](../Topic/Mark-an-application-directory-partition-as-authoritative.md)  
  
4.  Restart the domain controller normally.  
  
  