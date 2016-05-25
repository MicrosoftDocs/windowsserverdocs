---
title: Backing Up Active Directory Domain Services
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 0547c896-066f-46d0-86f3-cb5c77e65b22
author: Femila
---
# Backing Up Active Directory Domain Services
  This section describes the different types of backups that you can perform to ensure that you can recover Active Directory Domain Services \(AD DS\) if Active Directory data quality or consistency is jeopardized by human error, hardware breakdown, or software issues. You can perform regular, scheduled backups—which are essential for dependable operations—and you can perform immediate, ad hoc backups when necessary or as an alternative to scheduling regular backups, although scheduling is preferred.  
  
 Backup tools and processes are improved in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] to provide easier methods for backing up the data that is required to recover AD DS and the full server.  
  
## Windows Server backup tools  
 To back up AD DS in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you use the Windows Server Backup tool. Windows Server Backup replaces the Backup or Restore Wizard \(Ntbackup\), the tool that is used in earlier versions of the Windows Server operating system. You cannot use Ntbackup to back up servers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
 To use Windows Server Backup tools, you must install **Windows Server Backup Features** in Server Manager. For information about how to install Windows Server Backup Features, see Installing Windows Server Backup \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=96495](http://go.microsoft.com/fwlink/?LinkId=96495)\).  
  
 In the features list in Server Manager, **Windows Server Backup Features** has two parts:  
  
-   **Windows Server Backup \(Wbadmin.msc\)**, a graphical user interface \(GUI\) snap\-in that is available on the **Administrative Tools** menu  
  
     You can use the Windows Server Backup GUI to perform critical\-volumes backups and full server backups.  
  
    > [!NOTE]  
    >  You can perform a system state backup only by using the Wbadmin.exe command\-line tool.  
  
-   **Command\-line Tools**, which is required to install the Wbadmin.exe command\-line tool for Windows Server Backup. “Command\-line Tools” refers to a set of Windows PowerShell tools. When you select **Command\-line Tools**, you are prompted to install the required Windows PowerShell feature.  
  
     You can use the Windows Server Backup command\-line tool, Wbadmin.exe, to perform all types of backup, including system state backup.  
  
 You can use the Windows Server Backup snap\-in to back up entire volumes only, as follows: those volumes that contain system state files \(critical\-volumes backup\) or all volumes \(full server backup\). The Windows Server Backup snap\-in has two wizard options: a Backup Schedule Wizard and a Backup Once Wizard.  
  
 To use one of the wizards for backing up critical volumes, you must know which volumes to select, or you can allow the wizard to select them when you specify that you want to enable system recovery. When you use the command\-line tool for backing up critical volumes, the tool selects the correct volumes automatically.  
  
 To back up system state, you must use the Wbadmin.exe command\-line tool.  
  
## Windows Server backup types  
 In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you can use Windows Server Backup tools to back up three categories of domain controller data, all of which can be used to recover AD DS. Each backup type backs up a different set of data.  
  
### Contents of Windows Server backup types  
 The following list describes the backup types and the data that they contain:  
  
-   **System state**, which includes all the files that are required to recover AD DS. System state includes at least the following data, plus additional data, depending on the server roles that are installed:  
  
    -   Registry  
  
    -   COM\+ Class Registration database  
  
    -   Boot files  
  
    -   Active Directory Certificate Services \(AD CS\) database  
  
    -   Active Directory database \(Ntds.dit\) file and log files  
  
    -   SYSVOL directory  
  
    -   Cluster service information  
  
    -   Microsoft Internet Information Services \(IIS\) metadirectory  
  
    -   System files that are under Windows Resource Protection  
  
-   **Critical volumes**, which includes all volumes that contain system state files:  
  
    -   The volume that hosts the boot files, which consist of the Bootmgr file and the Boot Configuration Data \(BCD\) store  
  
    -   The volume that hosts the Windows operating system and the registry  
  
    -   The volume that hosts the SYSVOL tree  
  
    -   The volume that hosts the Active Directory database  
  
    -   The volume that hosts the Active Directory database log files  
  
-   **Full server**, which includes all volumes on the server, including Universal Serial Bus \(USB\) drives. The backup does not include the volume where the backup is stored.  
  
### Criteria for using backup types  
 The following table shows the qualities and restrictions that apply to each backup type. Use this table to determine the backup type to use.  
  
|Feature|System state backup|Critical\-volumes backup|Full server backup|  
|-------------|-------------------------|------------------------------|------------------------|  
|Can be used to recover from registry or directory service configuration errors \(recover AD DS\)|Yes|Yes|Yes|  
|Can be used for full server \(bare\-metal\) recovery with Windows Recovery Environment \(Windows RE\)|No|Yes|Yes|  
|Can be used to recover from unbootable conditions|No|Yes|Yes|  
|Can be used to recover specific files and folders|No|Yes|Yes|  
|Can be created by using Windows Server Backup snap\-in \(GUI\)|No|Yes|Yes|  
|Can be created by using Wbadmin.exe command line tool|Yes|Yes|Yes|  
|Has incremental backup support|No\*|Yes|?|  
|Can be stored on a DVD or on a network share if the backup is performed manually \(is not a scheduled backup\)|No|Yes|Yes\*\*|  
|Can use any of the volumes that are included in the backup as the target volume|Yes\*\*\*|No|No|  
|Can be scheduled by using the Windows Server Backup snap\-in|No|Yes|Yes|  
  
 \* Each consecutive backup requires as much space as the first. To help manage the number of versions of system state backups that you store, you can use the **wbadmin delete systemstatebackup** command to remove old versions. For more information, see Wbadmin delete systemstatebackup \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111836](http://go.microsoft.com/fwlink/?LinkId=111836)\).  
  
 \*\* Must be stored on a different hard disk from the source volumes, including external disks or DVDs. External storage devices must be connected to the backup computer.  
  
 \*\*\* No, by default, but you can override the default by making a change in the registry. To store the system state backup on a volume that is included in the backup, you must add the **AllowSSBToAnyVolume** registry entry to the server that you are backing up. However, there are some known issues with storing system state backup on a volume that is included in the backup. For more information, see [Known Issues for Backing Up Active Directory Domain Services](../Topic/Known-Issues-for-Backing-Up-Active-Directory-Domain-Services.md).  
  
## Backup guidelines  
 The following guidelines for backup include the performance of backups to ensure redundancy of Active Directory data:  
  
-   Create daily backups of all unique data, including all domain directory partitions on global catalog servers.  
  
-   Create daily backups of critical volumes on at least two unique domain controllers, if possible. When you have environments with single\-domain\-controller forests, single\-domain\-controller domains, or empty root domains, take special care to back up more often.  
  
-   Ensure that backups are available in sites where they are needed. Do not rely on copying a backup from a different site, which is very time consuming and can significantly delay recovery.  
  
-   Where domains exist in only one site, store additional backup files offsite in a secure location so that no backup file of a unique domain exists in only one physical site at any point in time. This precaution provides an extra level of redundancy in case of physical disaster or theft.  
  
-   Make sure that your backups are stored in a secure location at all times.  
  
-   Back up volumes that store Domain Name System \(DNS\) zones that are not Active Directory–integrated. You must be aware of the location of DNS zones and back up DNS servers accordingly. If you use Active Directory–integrated DNS, DNS zone data is captured as part of system state and critical\-volume backups on domain controllers that are also DNS servers.  
  
     If you do not use Active Directory–integrated DNS, you must back up the zone volumes on a representative set of DNS servers for each DNS zone to ensure fault tolerance for the zone.  
  
> [!NOTE]  
>  The DNS server stores settings in the registry. Therefore, system state or critical\-volume backup is required for DNS, regardless of whether the zone data is Active Directory–integrated or stored in the file system.  
  
-   If you have application directory partitions in your forest, make sure that you make a backup of the domain controllers that replicate those application directory partitions.  
  
-   Create additional backups of domains in every geographic location where:  
  
    -   Large populations of users exist.  
  
    -   Critical populations of users exist, such as those who support company executives or operate critical business units.  
  
    -   Mission\-critical work is performed.  
  
    -   A wide area network \(WAN\) outage would disrupt business.  
  
    -   The elapsed time that it takes to perform either of the following tasks would be cost prohibitive because of slow link speeds, the size of the directory database, or both:  
  
         To create a domain controller in its intended domain over the network.  
  
         Or  
  
         To copy or transport installation media from a site where a backup exists to a site that has no backup for the purpose of performing an installation from media \(IFM\).  
  
> [!NOTE]  
>  You can use a system state or critical\-volumes backup to restore only the domain controller on which the backup was generated or to create a new additional domain controller in the same domain by installing from restored backup media. You cannot use a system state or critical\-volumes backup to restore a different domain controller or to restore a domain controller onto different hardware. You can only use a full server backup to restore a domain controller onto different hardware.  
  
## Scheduling regular backups  
 You can use the Backup Schedule Wizard to schedule regular, automatic critical\-volumes or full server backups of your domain controllers. You need a current, verified, and reliable backup to:  
  
-   Restore Active Directory data that becomes lost.  
  
-   Recover a domain controller that cannot start up or operate normally because of software failure, hardware failure, or administrative error. For example, an administrator might have set overly restrictive permissions, either explicitly or by using a security policy, that deny the operating system access to the Ntds.dit file and log files.  
  
-   Install AD DS from installation media that you create by using the **ntdsutil ifm** command. For information about installing a domain controller from installation media, see [Installing an Additional Domain Controller by Using IFM](../Topic/Installing-an-Additional-Domain-Controller-by-Using-IFM.md).  
  
-   Perform a forest recovery if forest\-wide failure occurs.  
  
 For information about scheduling backups of AD DS in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], see Scheduling Regular Full Server Backups of a Domain Controller \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=118008](http://go.microsoft.com/fwlink/?LinkId=118008)\).  
  
## Immediate \(unscheduled\) backup  
 In addition to scheduling regular backups, perform an immediate backup when certain events occur in your environment. You can use the Backup Once Wizard or the command line to back up AD DS when the following conditions arise:  
  
-   You have moved the Active Directory database, log files, or both to a different location on a disk.  
  
-   The operating system on a domain controller is upgraded.  
  
-   A Service Pack is installed on a domain controller.  
  
-   A hotfix is installed that makes changes to the Active Directory database.  
  
-   A current backup is required for installing from backup media for a new domain controller.  
  
-   The tombstone lifetime is changed administratively by changing the value in the **tombstoneLifetime** attribute of the object CN\=Directory Service,CN\=Windows NT,CN\=Services,CN\-Configuration,DC\=*ForestRootDomain*. The tombstone lifetime value in an Active Directory forest defines the number of days that a domain controller preserves information about deleted objects. For this reason, this value also defines the useful life of a backup that you use for disaster recovery or installation from backup media.  
  
## Backup frequency  
 The frequency of your backups depends on criteria that vary for individual Active Directory environments. In most Active Directory environments, users, computers, and administrators make daily changes to directory objects, such as group membership or Group Policy. For example, computer accounts, including domain controller accounts, change their passwords every 30 days by default. Therefore, every day a percentage of computer passwords changes for domain controllers and domain client computers. Rolling the computer password of a domain controller back to a former state affects authentication and replication. A percentage of user passwords might also expire on a daily basis, and if they are lost as a result of domain controller failure, they must be reset manually. Generally, no external record of these changes exists except in AD DS. Therefore, the more frequently you back up domain controllers, the fewer problems you will encounter if you need to restore this type of information.  
  
 The more Active Directory objects and domain controllers you have, the more frequent your backups should be. For example, in a large organization, to recover from the inadvertent deletion of a large organizational unit \(OU\) by restoring the domain from a backup that is days or weeks old, you might have to re\-create hundreds of accounts that were created in that OU since the backup was made. To avoid re\-creating accounts and potentially performing large numbers of manual password resets, ensure that recent system state backups are always available to recover recent Create, Modify, and Delete operations.  
  
### Backup frequency criteria  
 Use the following criteria to assess the frequency of your backups:  
  
-   Small environments with a single domain controller in the forest or domains that exist in a single physical location \(that is, domains that have a single point of failure\): create backups at least daily.  
  
-   Medium \(10 to 49 domain controllers\) and large environments \(50 to 1,000 or more domain controllers\): Create backups of each unique directory partition in the forest on two different computers at least daily with an emphasis on backing up application directory partitions, empty root domains, domains in a single geographic site, and sites that have large populations of users or that host mission\-critical work.  
  
 Make backups with increasing frequency until you are confident that if you lose the objects that were created or modified since the last backup, the loss would not create a disruption of your operations. Major changes to the environment should always be immediately followed by a new system state backup.  
  
> [!NOTE]  
>  We always recommend that you have at least two domain controllers in each domain of your Active Directory forest.  
  
### Backup latency interval  
 After you perform an initial Active Directory backup on a domain controller, Event ID 2089 provides warnings about the backup status of each directory partition that a domain controller stores, including application directory partitions. Specifically, Event ID 2089 is logged in the Directory Service event log when partitions in the Active Directory forest are not backed up with sufficient frequency, and it continues daily until a backup of the partition occurs. This event serves as a warning to administrators and monitoring applications to make sure that domain controllers are backed up well before the tombstone lifetime expires. By monitoring this event, you can ensure that backups occur with sufficient frequency. Sufficient frequency is determined by the backup latency interval.  
  
 The value for the backup latency interval is stored as a **REG\_DWORD** value in the **Backup Latency Threshold \(days\)** registry entry in **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\NTDS\\Parameters**. By default, the value of **Backup Latency Threshold \(days\)** is half the value of the tombstone lifetime of the forest. In a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] forest, half the tombstone lifetime is 90 days. However, we recommend that you make backups at a much higher frequency than the default value of **Backup Latency Threshold \(days\)**. By setting a minimum backup frequency, changing this setting to reflect that frequency, and monitoring Event ID 2089, you ensure the backup frequency that is established in your organization.  
  
 To set a different **Backup Latency Threshold \(days\)** value, use Registry Editor \(Regedit.exe\) to create the entry as a **REG\_DWORD** and provide the appropriate number of days.  
  
 More information about the Windows Server Backup tools and backing up AD DS is available in the Step\-by\-Step Guide for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] AD DS Backup and Recovery \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93077](http://go.microsoft.com/fwlink/?LinkId=93077)\), as follows:  
  
-   What’s New in AD DS Backup and Recovery? \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=118011](http://go.microsoft.com/fwlink/?LinkId=118011)\)  
  
-   Known Issues for AD DS Backup and Recovery \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=117940](http://go.microsoft.com/fwlink/?LinkID=117940)\)  
  
-   Best Practices for AD DS Backup and Recovery \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=118012](http://go.microsoft.com/fwlink/?LinkId=118012)\)  
  
-   General Requirements for Backup Up and Recovering AD DS \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=118013](http://go.microsoft.com/fwlink/?LinkId=118013)\)  
  
-   Scenario Overviews for Backing Up and Recovering AD DS \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=118014](http://go.microsoft.com/fwlink/?LinkId=118014)\)  
  
 **Task requirements**  
  
 Before you back up a domain controller, see Performing an Unscheduled Backup of a Domain Controller \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=118015](http://go.microsoft.com/fwlink/?LinkId=118015)\).  
  
 The following tools, media, and credentials are required to perform the procedures for this task:  
  
-   Windows Server Backup:  
  
    -   Windows Server Backup snap\-in \(Wbadmin.msc\)  
  
    -   Windows Server Backup command\-line tool \(Wbadmin.exe\)  
  
-   Backup media, as follows:  
  
    -   Internal or external hard disk drive  
  
    -   Shared network folder  
  
    -   Writable DVD  
  
-   Builtin Administrator credentials to schedule backups, or Backup Operator credentials to perform unscheduled backups  
  
 To complete this task, you can perform the procedures in the following topics, depending on your backup needs:  
  
-   [Perform a Backup of Critical Volumes of a Domain Controller by Using the GUI &#40;Windows Server Backup&#41;](../Topic/Perform-a-Backup-of-Critical-Volumes-of-a-Domain-Controller-by-Using-the-GUI--Windows-Server-Backup-.md)  
  
-   [Perform a System State Backup of a Domain Controller by Using the Command Line &#40;Wbadmin&#41;](../Topic/Perform-a-System-State-Backup-of-a-Domain-Controller-by-Using-the-Command-Line--Wbadmin-.md)  
  
-   [Perform a Full Server Backup of a Domain Controller by Using the GUI &#40;Windows Server Backup&#41;](../Topic/Perform-a-Full-Server-Backup-of-a-Domain-Controller-by-Using-the-GUI--Windows-Server-Backup-.md)  
  
-   [Perform a Full Server Backup of a Domain Controller by Using the Command Line &#40;Wbadmin&#41;](../Topic/Perform-a-Full-Server-Backup-of-a-Domain-Controller-by-Using-the-Command-Line--Wbadmin-.md)  
  
  