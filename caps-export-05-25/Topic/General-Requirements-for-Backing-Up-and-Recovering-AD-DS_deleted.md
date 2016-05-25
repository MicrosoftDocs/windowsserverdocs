---
title: General Requirements for Backing Up and Recovering AD DS_deleted
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 19a85e49-8146-41f1-8322-acb6cf05f5f7
author: femila
---
# General Requirements for Backing Up and Recovering AD DS_deleted
Prerequisites for using Windows Server Backup include the following:  
  
-   Operating system: [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]  
  
-   Installation media: To access Windows RE, you must have a Windows Recovery Disc or the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] DVD or CD installation media for the build that you are restoring.  
  
-   Administrative credentials: The administrative credentials that are required for backing up and recovering Active Directory Domain Services \(AD DS\) are as follows:  
  
    -   To perform unscheduled backups, you must be a member of the Administrators group or the Backup Operators group.  
  
    -   To schedule backups of AD DS, you must be a member of the Administrators group.  
  
    -   To restore a domain controller, you need the Directory Services Restore Mode \(DSRM\) password.  
  
-   Backup media: Store backups on one of the following types of media:  
  
    -   A fixed or removable hard drive  
  
    -   DVDs  
  
    -   A network shared folder \(Use a network shared folder for unscheduled backups only. You cannot store a system state backup on a network share.\)  
  
-   **wbadmin start systemstaterecovery**: Use the **wbadmin start systemstaterecovery** command to restore the system state for a domain controller. For more information, see [Performing a Nonauthoritative Restore of AD DS_deleted](../Topic/Performing-a-Nonauthoritative-Restore-of-AD-DS_deleted.md).  
  
To use the Windows Server Backup graphical user interface \(GUI\) for managing backup and restore operations on a server that is running a Server Core installation of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you must connect remotely from a server that is running a full installation of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
