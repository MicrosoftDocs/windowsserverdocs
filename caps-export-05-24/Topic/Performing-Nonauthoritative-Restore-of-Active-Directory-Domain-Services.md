---
title: Performing Nonauthoritative Restore of Active Directory Domain Services
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 119f39da-e5d7-4959-a590-becd43075aba
author: Femila
---
# Performing Nonauthoritative Restore of Active Directory Domain Services
  A nonauthoritative restore is the method for restoring Active Directory Domain Services \(AD DS\) from a system state, critical\-volumes, or full server backup. A nonauthoritative restore returns the domain controller to its state at the time of backup and then allows normal replication to overwrite that state with any changes that occurred after the backup was taken. After you restore AD DS from backup, the domain controller queries its replication partners. Replication partners use the standard replication protocols to update AD DS and associated information, including the SYSVOL shared folder, on the restored domain controller.  
  
 You can use a nonauthoritative restore to restore the directory service on a domain controller without reintroducing or changing objects that have been modified since the backup. The most common use of a nonauthoritative restore is to reinstate a domain controller, often after catastrophic or debilitating hardware failures. In the case of data corruption, do not use nonauthoritative restore unless you have confirmed that the problem is with AD DS.  
  
> [!NOTE]  
>  If your objective is to recover objects that were deleted since the last backup, first perform a nonauthoritative restore from backup to reinstate the deleted objects and then perform an authoritative restore to mark the deleted objects as authoritative so that they are not overwritten during replication. When you are performing both a nonauthoritative restore and an authoritative restore, do not allow the domain controller to restart after the nonauthoritative restore. For information about performing authoritative restore, see [Performing Authoritative Restore of Active Directory Objects](../Topic/Performing-Authoritative-Restore-of-Active-Directory-Objects.md).  
  
## Nonauthoritative Restore Requirements  
 You can perform a nonauthoritative restore from backup on a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] system that is a stand\-alone server, member server, or domain controller.  
  
 On domain controllers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you can stop and restart AD DS as a service. Therefore, in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], performing offline defragmentation and other database management tasks does not require restarting the domain controller in Directory Services Restore Mode \(DSRM\). However, you cannot perform a nonauthoritative restore after simply stopping the AD DS service in regular startup mode. You must be able to start the domain controller in Directory Services Restore Mode \(DSRM\). If the domain controller cannot be started in DSRM, you must first reinstall the operating system. If you need to reinstall the operating system and then restore AD DS, see [Restoring a Domain Controller Through Reinstallation](../Topic/Restoring-a-Domain-Controller-Through-Reinstallation.md) or [Restoring a Domain Controller Through Reinstallation](../Topic/Restoring-a-Domain-Controller-Through-Reinstallation.md).  
  
 To perform a nonauthoritative restore, you need one of the following types of backup for your backup source:  
  
-   **System state backup**: Use this type of backup to restore AD DS. If you have reinstalled the operating system, you must use a critical\-volumes or full server backup. If you are restoring a system state backup, use the wbadmin start systemstaterecovery command.  
  
-   Critical\-volumes backup: A critical\-volumes backup includes all data on all volumes that contain operating system and registry files, boot files, SYSVOL files, or Active Directory files. Use this type of backup if you want to restore more than the system state. To restore a critical\-volumes backup, use the **wbadmin start recovery** command.  
  
-   **Full server backup**: Use this type of backup only if you cannot start the server or you do not have a system state or critical\-volumes backup. A full server backup is generally larger than a critical\-volumes backup. Restoring a full server backup not only rolls back data in AD DS to the time of backup, but it also rolls back all data in all other volumes. Rolling back this additional data is not necessary to achieve nonauthoritative restore of AD DS. For information about performing a full server backup for disaster recovery, see Performing a Full Server Recovery of a Domain Controller on the Microsoft Web site \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=116206](http://go.microsoft.com/fwlink/?LinkId=116206)\).  
  
## SYSVOL restore  
 SYSVOL is always restored nonauthoritatively during a restore of AD DS. Restoring SYSVOL requires no additional procedures. If you deleted file system policy and have a backup of policy that you created by using Group Policy Management Console, you can recover the policy by using that tool. For information about managing Group Policy, see Group Policy Management Console \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=101634\). If you deleted the Default Domain Policy or Default Domain Controllers Policy, you can use Dcgpofix.exe to rebuild the policy. For information about using Dcgpofix.exe, see Dcgpofix.exe on the Microsoft Web site \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=109291](http://go.microsoft.com/fwlink/?LinkId=109291)\).  
  
 When you use System Recovery Options in Windows Server Backup to restore a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain controller in an environment that has Distributed File System \(DFS\) Replication implemented, the SYSVOL restore is performed nonauthoritatively by default. To perform an authoritative restore of SYSVOL, include the **\-authsysvol** switch in your recovery command, as shown in the following example:  
  
 `wbadmin start systemstaterecovery <otheroptions> -authsysvol`  
  
 If you use File Replication Service \(FRS\), the restore operation sets the **BURFLAGS** registry entries for FRS, which affects all replica sets that are replicated by FRS.  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   Remote Desktop Connection \(optional\)  
  
-   Wbadmin.exe  
  
-   Bcdedit.exe  
  
 To complete this task, perform the following procedures:  
  
1.  Restart the domain controller in DSRM by using one of the following methods:  
  
     [Restart the Domain Controller in Directory Services Restore Mode Locally](../Topic/Restart-the-Domain-Controller-in-Directory-Services-Restore-Mode-Locally.md)  
  
     Or  
  
     [Restart the Domain Controller in Directory Services Restore Mode Remotely](../Topic/Restart-the-Domain-Controller-in-Directory-Services-Restore-Mode-Remotely.md)  
  
2.  [Restore AD DS from Backup &#40;Nonauthoritative Restore&#41;](../Topic/Restore-AD-DS-from-Backup--Nonauthoritative-Restore-.md)  
  
3.  [Verify AD DS restore](../Topic/Verify-AD-DS-restore.md)  
  
## Additional references  
  
-   [Performing Authoritative Restore of Active Directory Objects](../Topic/Performing-Authoritative-Restore-of-Active-Directory-Objects.md)  
  
-   [Enable Remote Desktop](../Topic/Enable-Remote-Desktop.md)  
  
-   [Create a Remote Desktop Connection](../Topic/Create-a-Remote-Desktop-Connection.md)  
  
  