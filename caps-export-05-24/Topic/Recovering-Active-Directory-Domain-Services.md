---
title: Recovering Active Directory Domain Services
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 474cd3ea-2060-4cb3-9ae4-51b753ccd68d
author: Femila
---
# Recovering Active Directory Domain Services
  You can use the information in this section to recover Active Directory Domain Services \(AD DS\) when directory services are disrupted as a result of problems with hardware, software, the network environment, or human error. To guard against damage from these types of disruptions, make sure that you are always prepared to restore AD DS with a timely backup of the volumes and servers that are critical to successful operation of your forest.  
  
 When recovery of AD DS by restoration from a backup is necessary, the most common cause is either administrative error or hardware failure. The best defense against these problems is prevention. Be sure to take steps to protect Active Directory data from accidental deletion. You can also manage hardware replacement in a timely fashion, before it leads to failure and loss of Active Directory data.  
  
## Causes of disruptions  
 Disruptions to directory services can be caused by many conditions on a domain controller, in a domain or forest, and with service clients and applications that use AD DS. The following are some of the conditions that can disrupt directory services:  
  
-   Reordering or changes to drive letters that cause the operating system, the directory service file, and logs to be unavailable in their expected locations  
  
-   Excessive permissions on objects in AD DS, the file system, or the registry, or explicitly defined and assigned in Group Policy  
  
-   Disk failure, which prevents access to or causes damage to the following sets of files: operating system, directory service and log, SYSVOL, and registry or other critical system files  
  
-   Inability to restart AD DS in normal mode, for example, after an unscheduled power outage or software update  
  
-   Antivirus utilities and other utilities, such as disk optimization utilities, which prevent unfettered access to the directory service file and logs  
  
-   Inability of a domain controller to respond to Lightweight Directory Access Protocol \(LDAP\) requests, logon requests, or replication requests  
  
-   Inability to boot from AD DS, for example, after an unscheduled power outage or software update  
  
-   Physical site disaster, such as natural disasters or virus attacks or other security attacks  
  
-   Accidental deletions in AD DS, the file system, or the registry  
  
-   Rollback to a known good point in time  
  
-   Corruption that is localized to a domain controller  
  
-   Corruption that has replicated \(the worst\-case scenario\)  
  
## Keys to protecting against disruptions  
 The keys to protecting your network from disruptions are preparation and prevention.  
  
 To make sure that you are always able to recover from disruption, prepare by scheduling backups as follows:  
  
-   Back up the volumes that are required to recover AD DS and the entire domain controller.  
  
-   Back up all critical domain controllers, as described in [Backing Up Active Directory Domain Services](../Topic/Backing-Up-Active-Directory-Domain-Services.md).  
  
-   Back up on a daily schedule and when significant changes are made to the registry or the directory.  
  
 Before you introduce configuration changes on domain controllers in production, test your configuration changes in a lab or on a test computer that mirrors the production environment in the same way that you test hardware configuration, service pack and software update revisions, performance load, and so on. Some configuration changes have immediate implications; some are apparent when a single event or operation occurs \(such as a reboot or service startup\); and some have chained implications \(for example, if X and Y both occur, then Z occurs\). Other changes have time\-based or threshold\-based implications. Be sure that you are aware of all the effects of a configuration change before you implement it in production.  
  
 For more information about backup recommendations, see [Backing Up Active Directory Domain Services](../Topic/Backing-Up-Active-Directory-Domain-Services.md).  
  
 The most common causes of directory service disruption requiring recovery are administrative error and hardware failure. The best defense against these problems is prevention. You can prevent disruptions by taking steps to protect against easily avoidable problems:  
  
-   Use the **Protect object from accidental deletion** option in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] to prevent inadvertent deletions of critical data. For more information, see “Preventing unwanted deletions” in this topic.  
  
-   Monitor all critical services.  
  
-   Manage hardware replacement in a timely fashion.  
  
 When you consider recovery options, the objective is to use the fastest method that results in the least intrusive and most complete recovery. Options for recovery can range from repair of individual elements to restoration of a single domain controller. In the worst\-case scenario, the only option might be to recover all domain controllers in a domain or forest.  
  
## Preventing unwanted deletions  
 Most large\-scale deletions are accidental. In many cases, you may have to perform a recovery operation to recover objects that have been deleted from AD DS.  
  
 In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], the Active Directory Users and Computers snap\-in provides the **Protect object from accidental deletion** option. When enabled, **Protect object from accidental deletion** implements the **Deny delete subtree** permission. This option is available in Active Directory Users and Computers on the domain controller and when viewed through Remote Server Administration Tools \(RSAT\) on computers running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and Windows Vista. When you enable **Advanced Features** on the **View** menu, the **Protect object from accidental deletion** option is available on the **Object** tab. You can open the **Properties** page for each container in the domain and enable this option.  
  
> [!NOTE]  
>  CN\=Users,DC\=*DomainName* and CN\=Computers,DC\=*DomainName* are protected from deletion by system flags on the objects.  
  
 Use this option to protect all other containers up to the domain level. Good candidates for protection are containers that store Group Policy objects \(GPOs\) and Active Directory–integrated Domain Name System \(DNS\) zones. When you enable the **Protect object from accidental deletion** option, neither the container nor any child object can be deleted by any administrator or other user. An administrator with the right to log on locally to a domain controller and the right to open Active Directory Users and Computers can enable or disable the setting.  
  
 Pay particular attention to protecting organizational units \(OUs\) that might have been created in an earlier version of Windows. When you create an OU by using Active Directory Users and Computers in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], the **Protect container from accidental deletion** check box is selected by default. On domain controllers that are running earlier versions of Windows, you must apply the **Deny access control entries \(ACEs\)** permission on the **Security** tab of the properties page of the containers to implement protection from accidental deletion. For information about how to apply these access control entries \(ACEs\) manually, see Guarding Against Accidental Bulk Deletions in Active Directory \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=116365](http://go.microsoft.com/fwlink/?LinkId=116365)\).  
  
## Recovery solutions  
 When you are faced with unacceptable directory service conditions that cannot be resolved reliably by manual updates, your recovery solutions depend on data issues, hardware issues, time constraints, and the backups that are available.  
  
### Solutions for configuration errors—nonauthoritative restore  
 To undo errors in configuration so that AD DS returns to a previous healthy state and is then brought up to date through replication, perform a nonauthoritative restore from backup. This process overwrites the current version of AD DS with the version in the backup. After replication, the directory is current with the rest of the domain.  
  
 You can restore AD DS by using a system state backup, a critical\-volumes backup, or a full server backup. If a system state backup is available, use the system state backup to recover from registry or directory service configuration errors. You can use a critical\-volumes backup as well, but it contains more than Active Directory data and it is not required for restoring AD DS only. Use full\-server recovery for more serious problems, as described in “Solutions for hardware failure or file corruption” later in this topic.  
  
> [!NOTE]  
>  Nonauthoritative restore from backup requires that the domain controller is running in Directory Services Restore Mode \(DSRM\). You cannot perform this procedure by stopping AD DS.  
  
### Solutions for data loss—authoritative restore  
 Accidental deletions can occur in any writable directory partition. Such deletions are most common in the domain directory partition, but they can also occur in the configuration directory partition. Objects in the schema directory partition are protected against deletion. The method for recovering deleted objects is authoritative restore.  
  
 If you have data loss and you can identify the source and quantity of the loss, you can recover the lost data by performing an authoritative restore. If you lose domain data, you must perform recovery by restoring a domain controller that hosts a writable copy of the domain directory partition where the data loss occurred. If objects are deleted from the configuration directory partition, you can recover these objects by restoring any domain controller in the forest. There are special considerations if the deleted objects have a forward link\-back link relationship with each other. This relationship exists for security groups and distribution groups.  
  
 **Restoring group memberships**  
  
 Security principals are objects that can have group memberships. Recovering deleted security principals requires not only restoring the object itself but also restoring the group memberships of each restored security principal. You use files that are generated by Ntdsutil during authoritative restore to recover group memberships. Group membership is defined by linked attributes on the group object and on the group member object: the **member** attribute of the group object is a forward link attribute that links to the **memberOf** attribute \(the back link\) of the group member, which can be a user, a computer, or another group.  
  
 If you perform the restore on a domain controller that is not a global catalog server, only group memberships for groups that are stored in the domain are restored. If you perform the restore on a global catalog server, group memberships in universal groups that are stored in other domains in the forest are also restored. However, restoring memberships in domain local groups that are stored in other domains requires additional steps that involve using the files that Ntdsutil generates during authoritative restore.  
  
 When you authoritatively restore security principals on a domain controller that is running a version of Windows Server later than Windows Server 2003 \(that is, Windows Server 2003 with Service Pack 1 \(SP1\), Windows Server 2003 Service Pack 2 \(SP2\), Windows Server 2003 R2, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]\), the Ntdsutil command\-line tool recovers group memberships automatically \(restores the **memberOf** value on the restored security principal object\) for all groups that were created or updated at a forest functional level of at least either Windows Server 2003 or Windows Server 2003 interim. However, replication order can undo the restored memberships in the recovery domain. For this reason, it is best to perform the additional steps to recover group memberships in the recovery domain as well. For more information about restoring group memberships, see [Performing Authoritative Restore of Active Directory Objects](../Topic/Performing-Authoritative-Restore-of-Active-Directory-Objects.md).  
  
 **Methods of authoritative restore**  
  
 Depending on replication conditions in the domain of the deletions, you can use the following methods to perform an authoritative restore:  
  
-   Nonauthoritative restore from backup, followed by authoritative restore: Unless you can isolate a domain controller that has not received the deletions, authoritative restore must be preceded by a nonauthoritative restore from backup to restore the directory to a former state that contained the deleted objects. With the deleted objects restored, you can mark them as authoritative so that replication does not overwrite them with the delete condition that still exists on the other domain controllers in the domain.  
  
-   Authoritative restore only: If you identify the data loss quickly and you can isolate a global catalog server in the domain where the deletion occurred that has not received replication of the deletions, you can mark the objects as authoritative on the global catalog server and avoid performing an initial restore from a backup \(nonauthoritative restore\). This option depends on your ability to stop inbound replication on the global catalog server before replication of the deletions is received. Global catalog servers often have longer replication latency than other domain controllers. Global catalog servers are preferred as recovery domain controllers because they store more group information. However, any latent domain controller in the domain of the deletions that has not received replication of the deletions can serve as the recovery domain controller if you want to avoid restoring from backup. For more information about performing authoritative restore without restoring from backup, see [Performing Authoritative Restore of Active Directory Objects](../Topic/Performing-Authoritative-Restore-of-Active-Directory-Objects.md).  
  
### Recovery options with no available backup  
 If you have data loss but you do not have a backup, you must recreate the deleted objects. As an alternative, where data loss is minimal, you might be able to recover lost data by using the undelete capability that recovers objects by reanimating the object tombstone \(the retained record of the object deletion\). The Windows Server 2003 and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] directory database supports an LDAP application programming interface \(API\) that reanimates the tombstone of a single object \(that is, it “undeletes” the object\). This API is available for developing applications to restore the attributes that are preserved on tombstones, which include the object security identifier \(SID\), globally unique identifier \(GUID\), and security descriptor, as well as any indexed attributes. On domain controllers that are running Windows Server 2003 with SP1, Windows Server 2003 with SP2, Windows Server R2, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], the **sIDHistory** attribute is also retained. All other attributes must be recreated. In the case of a deleted user object, you must repopulate attributes to re\-establish group memberships, profile path, home directory, and contact information. You must also reset passwords and communicate the password to the users so they can log on to the domain.  
  
 For information about reanimating tombstones, see Reanimating Active Directory Tombstone Objects \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=116204](http://go.microsoft.com/fwlink/?LinkId=116204)\).  
  
### Solutions for hardware failure or file corruption  
 If you have hardware issues that require the replacement of the hard drive on a domain controller, you must either recover the full server to the new hardware or reinstall the operating system. If you have widespread corruption in the file system, your best solution is also full server recovery or reinstallation. To decide whether or not to perform a full server recovery, consider the following conditions:  
  
-   A full server recovery reformats and repartitions all disks that are attached to the server.  
  
-   A full server recovery might be more time consuming than reinstalling the operating system.  
  
-   Reinstallation requires a cleanup of server metadata on the failed domain controller.  
  
-   Reinstallation results in data loss. All servers have roles and features installed. Each role has configuration state in AD DS, the file system, and the registry, and a role frequently has its own data store. For example, the server might be configured for DNS, Dynamic Host Configuration Protocol \(DHCP\), Windows Internet Name Service \(WINS\), administration tools, and registry settings for maximum transmission unit \(MTU\), **maxPacketSize**, and security. If you have to reinstall, you must either export and import all these settings or recreate them. This method is certain to be time consuming and error prone.  
  
 **Reinstalling and restoring criteria**  
  
 In general, use the following criteria to the decide whether to reinstall or restore a domain controller from backup:  
  
-   Reinstall the operating system under the following conditions:  
  
    -   You do not have an available backup.  
  
    -   You must have the domain controller back online as soon as possible and reinstallation is faster than restoring.  
  
    -   You have exhausted all known avenues of troubleshooting a fault or error condition, and continued troubleshooting is not likely to succeed or will result in diminishing returns with more time spent.  
  
-   Perform a full server restore of the domain controller under the following conditions:  
  
    -   Reinstalling will result in an unacceptable loss of data.  
  
    -   You want to recover from localized or replicated corruption.  
  
    -   The domain controller is running other server services, such as Exchange, or it contains other data that you must restore from a backup.  
  
 **Restoring AD DS after reinstalling the operating system**  
  
 If you reinstall the operating system, you can restore AD DS in one of the following ways:  
  
-   Use Dcpromo to reinstall AD DS and allow replication from another, healthy domain controller in the domain to update the domain controller.  
  
-   Restore AD DS from backup \(nonauthoritative restore\). Then, allow replication from another, healthy domain controller in the domain to update the domain controller. This method requires less replication than reinstalling AD DS.  
  
-   Install AD DS from installation media. This method, called install from media \(IFM\), requires that you have created installation media that can be used to install AD DS. You use Ntdsutil to create the media on a healthy domain controller in the domain. In this case, recovery is faster because Active Directory replication is not required. For more information about installing from media, see [Installing an Additional Domain Controller by Using IFM](../Topic/Installing-an-Additional-Domain-Controller-by-Using-IFM.md).  
  
## Recovery tasks  
 This section includes the following tasks for recovering AD DS:  
  
-   [Performing Nonauthoritative Restore of Active Directory Domain Services](../Topic/Performing-Nonauthoritative-Restore-of-Active-Directory-Domain-Services.md)  
  
-   [Performing Authoritative Restore of Active Directory Objects](../Topic/Performing-Authoritative-Restore-of-Active-Directory-Objects.md)  
  
-   [Performing Authoritative Restore of an Application Directory Partition](../Topic/Performing-Authoritative-Restore-of-an-Application-Directory-Partition.md)  
  
-   [Performing a Full Server Recovery of a Domain Controller](http://go.microsoft.com/fwlink/?LinkId=116206)  
  
-   [Restoring a Domain Controller Through Reinstallation and Subsequent Restore from Backup](../Topic/Restoring-a-Domain-Controller-Through-Reinstallation-and-Subsequent-Restore-from-Backup.md)  
  
-   [Restoring a Domain Controller Through Reinstallation](../Topic/Restoring-a-Domain-Controller-Through-Reinstallation.md)  
  
  