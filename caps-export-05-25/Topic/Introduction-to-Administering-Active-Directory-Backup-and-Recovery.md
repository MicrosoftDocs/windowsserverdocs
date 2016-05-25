---
title: Introduction to Administering Active Directory Backup and Recovery
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 26fb81f6-0e25-48df-b175-6529313509c4
author: Femila
---
# Introduction to Administering Active Directory Backup and Recovery
  Backup of Active Directory Domain Services \(AD DS\) must be incorporated into your operations schedule for a set of domain controllers that you identify as critical and on which you perform routine, scheduled backup operations.  
  
 Recovering AD DS is not performed routinely as an operations task; it is performed only when it is made necessary by a failure or other condition from which a domain controller can recover only by restoring the directory to a previous state.  
  
> [!IMPORTANT]  
>  Restoring from a backup is not always the best or only option to recover AD DS. Do not perform a restore operation to recover a domain controller until you have performed tests to rule out other causes. Restoring from backup is almost always the right solution to recover deleted objects.  
  
## Backing up AD DS  
 Backup procedures have changed in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], as compared to previous versions of Windows Server. A new backup tool, Windows Server Backup, replaces NtBackup as the tool that you use to back up AD DS. You cannot use Ntbackup to back up servers running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
 In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you can perform three types of backup:  
  
-   System state backup, which includes all the files that are required to recover AD DS  
  
-   Critical\-volumes backup, which includes all the volumes that contain system state files  
  
-   Full server backup, which includes all volumes on the server  
  
 You can use the Windows Server Backup graphical user interface \(GUI\) to perform critical\-volumes backups and full server backups. You can use the Windows Server Backup command\-line tool, Wbadmin.exe, to perform all types of backup, including system state backup.  
  
 For more information about backing up domain controllers, see [Backing Up Active Directory Domain Services](../Topic/Backing-Up-Active-Directory-Domain-Services.md).  
  
## Recovering AD DS  
 You can recover from Active Directory corruption or inconsistency by performing a restore operation to return AD DS to its state at the time of the latest backup. Restoring from backup as a method of recovering AD DS should not be undertaken as the primary method of recovering from an error or failure condition, but as a last resort. Assuming that a restore operation is appropriate to recover the domain controller, requirements for recovering AD DS relate to the age of the backup, as follows:  
  
-   The primary requirement for recovering AD DS is that the backup you use must not be older than a tombstone lifetime, which is the number of days that deletions are retained in the directory. In forests that are created on servers running Windows Server 2003 with Service Pack 1 \(SP1\), Windows Server 2003 with SP2, Windows Server 2008 or Windows Server 2008 R2, the default value of the tombstone lifetime is set to 180 days. The default value is 60 days in forests that are created on servers running Windows 2000 Server or Windows Server 2003.  
  
    > [!IMPORTANT]  
    >  Always check the tombstone lifetime value before you use a backup to restore AD DS. Even if you are sure of the default value for your environment, the tombstone lifetime value might have been changed administratively in AD DS. Use ADSI Edit to view the value in the **tombstoneLifetime** attribute on the object CN\=Directory Service,CN\-Windows NT,CN\=Services,CN\=Configuration,DC\=*ForestRootDomain*. If the **tombstoneLifetime** attribute value is empty, the tombstone lifetime is 60 days. If the value is not empty, the tombstone lifetime is the value specified. If the value is less than 3 days, the tombstone lifetime is 3 days.  
  
-   Do not modify system clocks in an attempt to improperly extend the useful life of a system state backup. Skewed time can cause serious problems in cases where directory data is time sensitive.  
  
 You can recover AD DS by restoring a backup in the following ways:  
  
-   **Nonauthoritative restore**: Use this process to restore AD DS to its state at the time of the backup, and then allow Active Directory replication to update the restored domain controller to the current state of AD DS.  
  
-   **Authoritative restore**: Use this process to recover objects that have been deleted from AD DS. Authoritative restore does not allow replication to overwrite the restored deletions. Instead, the restored objects replicate authoritatively to the other domain controllers in the domain.  
  
    > [!NOTE]  
    >  Be aware that additions of data that are made between the time of the backup and the authoritative restore process are not removed during the restore process. Authoritative restore focuses only on the deleted objects. Additional data is merged during the restore process.  
  
 When recovering AD DS by restoring from backup is not possible, you must reinstall AD DS. Sometimes restoring from backup is possible but not feasible. For example, if a domain controller is needed quickly, it is sometimes faster to reinstall AD DS than to recover the domain controller. In cases of hardware failure or file corruption, you might have to reinstall the operating system and then either reinstall or restore AD DS.  
  
 For more information about rationales and methods for recovering domain controllers, see [Recovering Active Directory Domain Services](../Topic/Recovering-Active-Directory-Domain-Services.md).  
  
## Additional considerations  
  
-   [Backing Up Active Directory Domain Services](../Topic/Backing-Up-Active-Directory-Domain-Services.md)  
  
-   [Recovering Active Directory Domain Services](../Topic/Recovering-Active-Directory-Domain-Services.md)  
  
  