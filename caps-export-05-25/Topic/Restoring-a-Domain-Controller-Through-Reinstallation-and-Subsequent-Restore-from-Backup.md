---
title: Restoring a Domain Controller Through Reinstallation and Subsequent Restore from Backup
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: e9b9b009-dc3a-4f2e-96e7-b242e9850e51
author: Femila
---
# Restoring a Domain Controller Through Reinstallation and Subsequent Restore from Backup
  If you cannot restart a domain controller in Directory Services Restore Mode \(DSRM\), you can restore it through reinstallation of the operating system and subsequent restore of Active Directory Domain Services \(AD DS\) from backup.  
  
 After you reinstall [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], perform a nonauthoritative restore of a system state or critical\-volumes backup. You must have a previous backup for the failed domain controller, and the backup cannot be older than the tombstone lifetime for the forest.  
  
 You do not have to join the computer to the domain before you perform the restore procedure. During the restore, the computer account is reestablished automatically.  
  
> [!NOTE]  
>  You must perform the restore procedure by using the same backup tool with which the backup was made. Procedures in this task describe using Windows Server Backup to restore AD DS, but you must use the tool that you used to create the backup file if it is not Windows Server Backup.  
  
 **Task requirements**  
  
 To perform the domain controller restore procedure, you must have the following information about the failed domain controller:  
  
-   Disk configuration. You need a record of the volumes and sizes of the disks and partitions. In the case of a complete disk failure, use this information to recreate the disk configuration. [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] must be reinstalled to the same drive letter and with at least the same amount of physical drive space as for the original installation. Before you restore the system state, you must recreate all disk configurations. Failure to recreate all disk configurations can cause the restore process to fail, and it can prevent you from starting the domain controller after the restore.  
  
-   Computer name. You need the computer name to restore a domain controller of the same name and avoid changing client configuration settings.  
  
-   DSRM Administrator password. You must know the DSRM Administrator password that was in use when the backup was created.  
  
 The following tools are required to perform the procedures for this task:  
  
-   Remote Desktop Connection \(optional\)  
  
-   Bcdedit.exe \(optional\)  
  
-   Wbadmin.exe  
  
 To complete this task, perform the following procedures:  
  
1.  After you configure the disks appropriately, install [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
    > [!NOTE]  
    >  This guide does not provide information about installing [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. For information about installing [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], see Installing [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=111104](http://go.microsoft.com/fwlink/?LinkID=111104)\).  
  
2.  Restart the server in DSRM by using one of the following methods:  
  
    > [!NOTE]  
    >  Restarting a member server in DSRM is not possible in Windows Server 2003, but it is possible in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
     [Restart the Domain Controller in Directory Services Restore Mode Locally](../Topic/Restart-the-Domain-Controller-in-Directory-Services-Restore-Mode-Locally.md)  
  
     Or  
  
     [Restart the Domain Controller in Directory Services Restore Mode Remotely](../Topic/Restart-the-Domain-Controller-in-Directory-Services-Restore-Mode-Remotely.md)  
  
3.  [Restore AD DS from Backup &#40;Nonauthoritative Restore&#41;](../Topic/Restore-AD-DS-from-Backup--Nonauthoritative-Restore-.md)  
  
4.  [Verify AD DS restore](../Topic/Verify-AD-DS-restore.md)  
  
  