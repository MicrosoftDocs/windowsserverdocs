---
title: Scenario Overviews for Backing Up and Recovering AD DS_deleted
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b59e3760-880d-47b9-9af0-6cb64dd74efd
author: femila
---
# Scenario Overviews for Backing Up and Recovering AD DS_deleted
The following scenarios are covered in this guide:  
  
-   [Scheduled Active Directory backup](#BKMK_Scheduled)  
  
-   [Full server backup of a domain controller](#BKMK_FullBackup)  
  
-   [System state backup vs. critical\-volumes backup of a domain controller](#BKMK_CriticalVolumes)  
  
-   [Full server recovery of a domain controller](#BKMK_FullRecovery)  
  
-   [Nonauthoritative restore of AD DS](#BKMK_NonAuth)  
  
-   [Authoritative restore of deleted Active Directory objects](#BKMK_Auth)  
  
-   [Using the Ntdsutil ifm subcommand to optimize backups for installing additional domain controllers](#BKMK_IFM)  
  
## <a name="BKMK_Scheduled"></a>Scheduled Active Directory backup  
You can schedule full server backups and critical\-volume backups by using Windows Server Backup or Wbadmin.exe. You cannot schedule system state backups by using Wbadmin.exe, but you can create a task to run a system state backup by using Task Scheduler.  
  
Weigh the following criteria to determine an appropriate frequency for backup of Active Directory Domain Services \(AD DS\):  
  
-   Frequency of changes to critical Active Directory data  
  
-   Significance of changes to AD DS  
  
    Significant changes can include changes to the schema, group membership, Active Directory replication or site topology, and policies. They can also include upgrades to operating systems, renaming domain controllers or domains, and migration or creation of new security principals.  
  
-   Impact to business operations if data in AD DS or SYSVOL is lost  
  
    Lost data can include updates to passwords for user accounts, computer accounts, and trusts. It can also include updates to group membership, policies, and the replication topology and its schedules.  
  
We recommend that you perform backups nightly during times of decreased traffic. When you schedule backups in Windows Server Backup, the default start time is at 17:00. You can change this time so that the backup begins at any half\-hour interval throughout the day.  
  
For fault tolerance, schedule at least two trusted backups for each domain. You can start by scheduling the backups daily and then adjusting the frequency of your backups, depending on the previously specified criteria.  
  
To define a different time to start a backup for different days of the week, you can use Task Scheduler to schedule a task that runs Wbadmin.exe at the appropriate date and time.  
  
For procedures to schedule routine backups by using the command line, see [Scheduling Regular Full Server Backups of a Domain Controller_deleted](../Topic/Scheduling-Regular-Full-Server-Backups-of-a-Domain-Controller_deleted.md).  
  
## <a name="BKMK_FullBackup"></a>Full server backup of a domain controller  
A full server backup captures all the volumes on the server except the volume where the backup job is stored.  
  
Although you can use this type of backup to recover from hard drive failures or file corruption on the same hardware with the same operating system installation, it can produce unpredictable results. If you want to a recover a domain controller from hard drive failures or file corruption, first try to run the Active Directory Domain Services Installation Wizard \(dcpromo.exe\) to remove and reinstall AD DS to resolve the problem. If that does not succeed, next try to restore a backup of a domain controller to an alternate location and then try to install AD DS by using the install from media \(IFM\) option. For more information about IFM, see [Using the Ntdsutil ifm subcommand to optimize backups for installing additional domain controllers](../Topic/Scenario-Overviews-for-Backing-Up-and-Recovering-AD-DS_deleted.md#BKMK_IFM).  
  
Universal Serial Bus \(USB\) drives are included in a full server backup unless they are used as the backup target.  
  
For the procedure to perform a full server backup by using Windows Server Backup, see [Perform a Full Server Backup of a Domain Controller by Using the GUI &#40;Windows Server Backup&#41;](../Topic/Perform-a-Full-Server-Backup-of-a-Domain-Controller-by-Using-the-GUI--Windows-Server-Backup-.md).  
  
For the procedure to perform a full server backup by using the command line, see [Scheduling Regular Full Server Backups of a Domain Controller_deleted](../Topic/Scheduling-Regular-Full-Server-Backups-of-a-Domain-Controller_deleted.md) and [Perform a Full Server Backup of a Domain Controller by Using the Command Line &#40;Wbadmin&#41;](../Topic/Perform-a-Full-Server-Backup-of-a-Domain-Controller-by-Using-the-Command-Line--Wbadmin-.md).  
  
## <a name="BKMK_CriticalVolumes"></a>System state backup vs. critical\-volumes backup of a domain controller  
The recommended method for backing up a domain controller is to use the **wbadmin start systemstatebackup** command.  
  
You can also use the **wbadmin start backup** command to perform a critical\-volumes backup of a domain controller. A critical\-volumes backup includes all files on the volumes that are required to recover AD DS.  
  
You can use either type of backup to restore the domain controller.  
  
For more information about the differences between a system state backup and critical\-volumes backup and procedures for each, see [Performing an Unscheduled Backup of a Domain Controller_deleted](../Topic/Performing-an-Unscheduled-Backup-of-a-Domain-Controller_deleted.md).  
  
You can also copy critical\-volume backups to removable media to install a new domain controller in the same domain. However, in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you should instead use the new **ntdsutil ifm** subcommand to create installation media for installing additional domain controllers. For more information about installing a domain controller from restored backup media, see [Using the Ntdsutil ifm subcommand to optimize backups for installing additional domain controllers](#BKMK_IFM).  
  
## <a name="BKMK_FullRecovery"></a>Full server recovery of a domain controller  
A full server recovery recovers every volume on the server. Use this type of recovery to recover from hard drive failures or file corruption on the same hardware with the same operating system installed.  
  
A full server recovery reformats and repartitions all disks that are attached to the server. Use this scenario if you want to recover onto new hardware or if all other attempts to recover the server on the existing hardware have failed.  
  
Before you perform a full server recovery, be aware that any existing data that is not included in the backup will be deleted when you complete this operation. This includes any volumes that are currently used by the server but not included in the backup.  
  
For example, suppose you back up drives C, D, and E and disk 1, and the server also includes application data on disk 2. When you use that backup to perform a full server recovery, all the application data on disk 2 is lost.  
  
If you recover to a dynamic disk that is not included in the backup, the partition—and the data that is stored on it—are deleted and then re\-created without the data.  
  
For procedures to perform a full server recovery by using the Windows Server Backup snap\-in and Wbadmin.exe commands from the command line, see [Performing a Full Server Recovery of a Domain Controller](../Topic/Performing-a-Full-Server-Recovery-of-a-Domain-Controller.md).  
  
## <a name="BKMK_NonAuth"></a>Nonauthoritative restore of AD DS  
You can use a critical\-volumes backup or a system state backup to perform a nonauthoritative restore of a domain controller. A nonauthoritative restore returns the directory service to its state at the time that the backup was created. After the restore operation completes, Active Directory replication updates the domain controller with changes that have occurred since the time that the backup was created. In this way, the domain controller is recovered to a current state.  
  
You must restart the domain controller in Directory Services Restore Mode \(DSRM\) to perform a nonauthoritative restore. Then, use the **wbadmin start systemstaterecovery** command to perform the nonauthoritative restore.  
  
For procedures to perform nonauthoritative restore of AD DS, see [Performing a Nonauthoritative Restore of AD DS_deleted](../Topic/Performing-a-Nonauthoritative-Restore-of-AD-DS_deleted.md).  
  
## <a name="BKMK_Auth"></a>Authoritative restore of deleted Active Directory objects  
Authoritative restore provides a method of recovering objects and containers that have been deleted from AD DS. Authoritative restore is a four\-step process:  
  
1.  Start the domain controller in DSRM.  
  
2.  Restore the desired backup, which is typically the most recent backup.  
  
3.  Use Ntdsutil.exe to mark desired objects, containers, or partitions as authoritative.  
  
4.  Restart in normal mode to propagate the changes.  
  
> [!NOTE]  
> Some objects, such as users and security groups, have forward links and back links that identify the group memberships of the objects. To restore group memberships reliably, these objects might require that you either perform an authoritative restore twice or that you restore the deleted user or group accounts, and then use Ldifde.exe to restore memberships for security groups. For more information about restoring deleted users, groups, and group memberships and for procedures to perform authoritative restore, see Performing an Authoritative Restore of Active Directory Objects \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=68564](http://go.microsoft.com/fwlink/?LinkId=68564)\).  
  
## <a name="BKMK_IFM"></a>Using the Ntdsutil ifm subcommand to optimize backups for installing additional domain controllers  
[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] has two methods of creating installation media for additional domain controllers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. You can use critical\-volume backups to prepare installation media for the Install from Media \(IFM\) method of AD DS installation, but this is an older method that is not always efficient. The recommended method of creating installation media for a domain controller that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] is using the **ntdsutil ifm** subcommand.  
  
While Windows Server Backup requires a backup of at least the set of critical volumes, the **ntdsutil ifm** subcommand captures the minimum data that is needed to perform the IFM operation \(that is, only the volumes that contain system state data\). In addition, there is no need to restore media that you create by using **ntdsutil ifm**. If you use Windows Server Backup, you must restore the backup before you can use it to create installation media for an additional domain controller.  
  
Also, the **ntdsutil ifm** subcommand removes secrets, such as passwords, from read\-only domain controller \(RODC\) installation media. This makes transportation of the installation media more secure. Even if an RODC installation medium falls into the hands of a malicious user, that user cannot extract secrets from the media.  
  
If you use critical\-volume backups to prepare installation media, you can restore a critical\-volume backup to a local volume or network shared folder instead of restoring it to a volume that will be recovered. For the IFM operation, you can prepare the media in one of the following ways:  
  
-   Restore the backup directly to a network shared folder on the server that you are installing as a domain controller.  
  
-   Restore the backup to an alternate location on the local computer or on a remote computer on the network. Then, copy the restored files to removable media, such as a CD, DVD, or portable hard drive. The advantage of using this method is that you restore the backup only once; you can use the same media to install as many domain controllers as necessary.  
  
-   Copy the unrestored backup onto removable media. Transfer the media to the installation location. Then, restore the backup from the removable media to an alternate location on each server that you want to install.  
  
By using IFM, you can avoid source replication of the entire Active Directory database. Only changes that have occurred since the **ntdsutil ifm** subcommand completed \(and any partitions that are required for the additional domain controller but that are not available on the installation media\) must be replicated. IFM is ideal for installing domain controllers at remote sites.  
  
> [!IMPORTANT]  
> The installation media that you create is useful only for the duration that is defined by the tombstone lifetime for the forest, which has a default value of 180 days.  
  
For procedures to perform recovery of AD DS to an alternate location, see [Restoring a Critical-Volume Backup to an Alternate Location_deleted](../Topic/Restoring-a-Critical-Volume-Backup-to-an-Alternate-Location_deleted.md).  
  
