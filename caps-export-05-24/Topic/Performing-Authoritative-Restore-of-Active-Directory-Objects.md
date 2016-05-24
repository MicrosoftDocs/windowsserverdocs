---
title: Performing Authoritative Restore of Active Directory Objects
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: f0da0d60-b7fd-4be0-9b13-d131c64534a9
author: Femila
---
# Performing Authoritative Restore of Active Directory Objects
  An authoritative restore process returns a designated, deleted Active Directory object or container of objects to its predeletion state at the time when it was backed up. For example, you might have to perform an authoritative restore if an administrator inadvertently deletes an organizational unit \(OU\) that contains a large number of users. In most cases, there are two parts to the authoritative restore process: a nonauthoritative restore from backup, followed by an authoritative restore of the deleted objects. If you perform a nonauthoritative restore from backup only, the deleted OU is not restored because the restored domain controller is updated after the restore process to the current status of its replication partners, which have deleted the OU. To recover the deleted OU, after you perform nonauthoritative restore from backup and before allowing replication to occur, you must perform an authoritative restore procedure. During the authoritative restore procedure, you mark the OU as authoritative and let the replication process restore it to all the other domain controllers in the domain. After an authoritative restore, you also restore group memberships, if necessary.  
  
> [!NOTE]  
>  If you can isolate a domain controller in the domain that has not received replication of the deletion, the preliminary, nonauthoritative restore from backup is not necessary. For more information, see [Recovering deletions without restoring from backup](../Topic/Performing-Authoritative-Restore-of-Active-Directory-Objects.md#BKMK_RecoverWithoutRestore).  
  
 You can restore objects in domain directory partitions, application directory partitions, and the configuration directory partition, as follows:  
  
-   Domain directory partitions: You must restore the objects on a domain controller in the domain.  
  
-   Application directory partitions: You must restore the objects on a domain controller that hosts the application directory partition. If you delete an entire application directory partition, you must restore the domain naming operations master to recover the application directory partition.  
  
-   Configuration directory partitions: You can restore objects on any domain controller in the forest.  
  
> [!NOTE]  
>  You can also restore Group Policy objects \(GPOs\). For information about restoring GPOs, see “Back Up, Restore, Import, and Copy Group Policy Objects” in online Help for the Group Policy Management Console \(GPMC\).  
  
 When an Active Directory object is marked for authoritative restore, its version number is changed so that the number is higher than the existing version number of the deleted object, which replicates as a tombstone in the Active Directory replication system. The change in version number ensures that any object that you restore authoritatively is replicated from the restored domain controller to other domain controllers in the forest, updating the tombstone object to the restored object.  
  
 An authoritative restore is most commonly used to restore corrupt or deleted objects, often to recover unintentionally deleted user and group objects. An authoritative restore should not be used to restore an entire domain controller, nor should it be used as part of a change\-control infrastructure. Proper delegation of administration and change enforcement will help optimize data consistency, integrity, and security.  
  
## Determining objects to restore  
 Before you perform an authoritative restore operation, determine the objects that must be restored. On domain controllers that are running Windows Server 2008, you can use Ntdsutil to take a snapshot of the directory database. A snapshot is a shadow copy—created by the Volume Shadow Copy Service \(VSS\)—of the volumes that contain the Active Directory database and log files. You can use the Active Directory database mounting tool \(Dsamain.exe\) to mount these database snapshots and view the directory data in a Lightweight Directory Access Protocol \(LDAP\) tool such as Active Directory Users and Computers, ADSI Edit, or Ldp. The database mounting tool can improve recovery processes by providing a means to compare data as it exists in snapshots or backups that are taken at different times so that you can better decide which data to restore after data loss. This eliminates the need to restore multiple backups to compare the Active Directory data that they contain. When inadvertent deletions or modifications occur, you can use a snapshot to compare the data in the current directory against data in the snapshot. If you take regular snapshots, you can sometimes avoid having to restore AD DS if you can identify the differences in the data and return the affected objects to their correct state.  
  
 When a recovery operation is required, you can use a database snapshot to assess the differences and determine the objects that you want to authoritatively restore. For information about using VSS shadow copies and the Active Directory database mounting tool, see the Step\-by\-Step Guide for Using the Active Directory Database Mounting Tool in Windows Server 2008 \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=103333](http://go.microsoft.com/fwlink/?LinkID=103333)\).  
  
## Selecting objects to restore  
 When you are selecting objects that you want to replicate authoritatively, it is important to select the object that is lowest in the directory subtree as possible that you can still use to recover the deleted objects. In this way, you avoid reverting objects back in time that are not related to the deletion. Objects other than the deleted objects might have been modified after the backup was created.  
  
 When you restore an OU, any changes that are made up to the time that a backup is restored are rolled back to their values at the time of the backup. For any user accounts, computer accounts, and security groups in the restored OU that were not among the deletions being restored, this rollback might mean the loss of the most recent changes to passwords, home directory, profile path, location and container information, group membership, and any security descriptors that are defined on those objects and attributes.  
  
 For example, if an object with a password, such as a user or computer or trust account, is authoritatively restored, the password value of the restored object reverts to the password value at the time of the backup. In this case, user, computer, and service accounts that have a record of only the current password cannot log on because they have no record of the password that existed when the backup was created. In this way, group membership or other data can also be lost. Updates to the password are blocked because the restored value is authoritative during replication. To minimize the impact of rolling unrelated objects back in time, target as few objects as possible. If you have relatively few deletions to restore, you might be able to restore each object individually.  
  
 If you have a relatively large number of deleted objects to restore, use the container object that contains most of the deleted objects. Ideally, the container that you restore will contain all the objects that you need to recover.  
  
## Selecting application directory partitions to restore  
 If you are restoring an application directory partition, the selection process is different from the process that you use to select other Active Directory objects. To authoritatively restore an application directory partition, follow the procedures that are provided for this task but use the procedure in [Performing Authoritative Restore of an Application Directory Partition](../Topic/Performing-Authoritative-Restore-of-an-Application-Directory-Partition.md) to mark the application directory partition as authoritative, and do not perform the procedures for restoring group memberships.  
  
## Restoring group memberships after authoritative restore  
 When a user object is deleted inadvertently, you restore it by marking the user object as authoritative during an authoritative restore procedure. However, depending on the functional level of the forest at the time that any groups to which the user belongs were created \(or the forest functional level at the time that the user was added to the group, if they are different\), the user's group memberships might not be restored in the process. This condition is multiplied by hundreds or thousands of users when an OU is deleted. In this case, additional steps are required to restore the group memberships of user accounts that you restore.  
  
### LVR and restoration of group memberships  
 Restoration of group memberships for security principals that are deleted and restored authoritatively differs, depending on whether the group was created \(or its membership was updated\) before or after the implementation of Windows Server 2003 functionality called linked\-value replication \(LVR\). LVR is a feature that is available when the forest has a functional level of at least Windows Server 2003 interim or Windows Server 2003. In groups that are created before LVR is in effect, the **member** attribute of a group object is replicated as a single value. Therefore, any change to the group's membership results in replication of the entire **member** attribute. In groups that are created after LVR is in effect, or in groups that are created before LVR but that are updated after LVR is in effect, updates to the **member** attribute of a group object are replicated separately. In this case, group memberships are restored when you use the Ntdsutil command\-line tool to authoritatively restore a user, group, or computer object.  
  
> [!IMPORTANT]  
>  The **memberOf** attribute \(or any back\-link attribute\) exists only because of its link to the **member** attribute \(or any corresponding forward\-link attribute\). The back\-link is generated only when it is accessed, and it is not replicated. Only the forward\-link attribute value can be updated and replicated. For this reason, restoring the membership on a user object necessarily involves updating the **member** attribute on the group object to include the distinguished name of the restored user.  
  
 When you use the Ntdsutil command\-line tool to authoritatively restore a subtree or a single object, the ability of Ntdsutil to automatically restore the group memberships of an object that is authoritatively restored depends on whether the group was created before or after LVR was implemented. For example, if a user object is restored and the user belongs to group G1 that was created before LVR was implemented and the user belongs to group G2 that was created after LVR was implemented \(that is, after the functional level of the forest was raised to Windows Server 2003 interim or Windows Server 2003\), the **member** attribute of G2 is updated during authoritative restore \(and, therefore, the **memberOf** attribute of the restored user is updated\), but the **member** attribute of G1 is not updated.  
  
> [!NOTE]  
>  Although Ntdsutil restores back\-links for LVR groups, replication order can result in the memberships being dropped. For more information, see [Performing Authoritative Restore of Active Directory Objects](../Topic/Performing-Authoritative-Restore-of-Active-Directory-Objects.md).  
  
### Authoritative restore of pre\-LVR group memberships and groups in different domains  
 The version of Ntdsutil that is included with Windows Server 2003 Service Pack 1 \(SP1\), Windows Server 2003 with Service Pack 2 \(SP2\), Windows Server 2003 R2, and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] provides the ability to also restore the memberships of groups that were created before LVR was implemented and in groups that can have members from other domains. Ntdsutil creates a text file that identifies the authoritatively restored objects. In addition, Ntdsutil creates an LDAP Data Interchange Format \(LDIF\) file \(.ldf\) that identifies restored objects that have back\-links. You can use the .ldf file to regenerate **memberOf** back\-links on restored security principal objects \(users, groups, and computers\) in a forest where LVR was not in effect when the groups that are identified in the **memberOf** back\-links were created.  
  
 To restore group memberships in groups that are stored in other domains \(that is, for universal group or domain local group memberships\), additional steps are required. Use the .txt file that Ntdsutil generates during authoritative restore to generate an .ldf file in each additional domain that has groups in which restored security principals have memberships.  
  
 The updates to Ntdsutil that generate files that you can use to recover group memberships for pre\-LVR groups and groups in other domains were introduced in Windows Server 2003 with SP1. The steps that you perform are different if you are restoring the objects on a domain controller that is running an earlier version of Windows Server. If you are performing authoritative restore in a pre–Windows Server 2003 SP1 environment, see “Procedures for Domain Controllers Running Windows Server 2003 with No Service Pack Installed” in Performing an Authoritative Restore of Active Directory Objects\([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=68564](http://go.microsoft.com/fwlink/?LinkId=68564)\).  
  
### Files for recovering group memberships following authoritative restore  
 When you perform authoritative restore, Ntdsutil creates the following files that are used to recover group memberships:  
  
-   ar\_*YYYYMMDD\-HHMMSS*\_links\_*Domain*.ldf, which is an LDIF file that is generated for the domain in which you perform the authoritative restore procedure. This file contains back\-link information for the restored objects. If you perform the procedure on a global catalog server, a separate .ldf file is created for each domain in the forest. You can use this file with the Ldifde.exe command\-line tool to import the back\-links to recover universal and global group memberships in environments that include pre\-LVR groups. For environments that do not include pre\-LVR groups, the Ntdsutil tool recovers group memberships automatically in the recovery domain and in the forest \(for universal groups\) if the recovery domain controller is a global catalog server. If the restore includes security principals that can have memberships in domain local groups in other domains, you use the ar\_*YYYYMMDD\-HHMMSS*\_objects.txt text file that is generated during authoritative restore to create an .ldf file to restore the memberships in each additional domain.  
  
-   ar\_*YYYYMMDD\-HHMMSS*\_objects.txt, which is a text file that contains a list of the authoritatively restored objects. This file is generated for each individual object or container that you mark as authoritative. You can use this file to generate an .ldf file that you can use to recover memberships in domain local groups and universal groups \(if you are not restoring a global catalog server\) in other domains. This file is created on any domain controller that you authoritatively restore. Global catalog servers do not store the **member** attribute of domain local groups. Therefore, even if you perform the restore on a global catalog server, you must always use this file to generate an .ldf file in any domain where there are domain local groups of which restored security principals might be members. You must create a separate .ldf file for each object or container that you mark as authoritative.  
  
> [!NOTE]  
>  Although group memberships are restored automatically when you use Ntdsutil to recover membership in LVR groups, it is best to process the .ldf files to ensure recovery. In some cases, replication order can result in lost memberships. For more information, see [Known Issues for Authoritative Restore](../Topic/Known-Issues-for-Authoritative-Restore.md).  
  
## Using a global catalog server for authoritative restore  
 If possible, perform the authoritative restore on a global catalog server in the domain where the objects were deleted to recover security principals and group memberships. Global catalog servers store a single, writable domain and a partial, read\-only replica of all other domains in the forest. A partial replica means that the global catalog stores all objects, but with a limited set of attributes on each object. Check the properties of the NTDS Settings object of the server object in Active Directory Sites and Services to determine that a domain controller is a global catalog server.  
  
 **Global catalog and group memberships**  
  
 In relation to the three types of security groups—global groups, domain local groups, and universal groups—global catalog servers are best suited for recovering group memberships after an authoritative restore procedure because they store memberships of all universal groups in the forest and all global groups in the domain.  
  
 Security group memberships are restored on a global catalog server as follows:  
  
-   **Global groups**: Security principals \(users, groups, and computers\) can be members of only the global groups that are created in the same domain. Global catalog servers store a writable domain directory partition. Therefore, they can restore global group memberships for the recovery domain.  
  
-   **Universal groups:** Security principals can be members of universal groups that are created in any domain. However, the **member** attribute is among the attributes that are stored on the read\-only universal group objects in the global catalog. Therefore, a global catalog server can recover universal group memberships for all domains in the forest. A domain controller that is not a global catalog server stores only universal group objects that are created in its own domain.  
  
-   **Domain local groups**: Security principals can be members of domain local groups that are created in any domain. Memberships in domain local groups in the recovery domain are restored automatically during authoritative restore. However, the global catalog does not store the **member** attribute for read\-only domain local group objects. Therefore, for restored security principals that have memberships in domain local groups in other domains, you must recover these memberships by performing follow\-up procedures in each additional domain.  
  
##  <a name="BKMK_RecoverWithoutRestore"></a> Recovering deletions without restoring from backup  
 If you can isolate a global catalog server \(or any domain controller, but preferably a global catalog server\) in the domain where the deletion occurred before the server receives replication of the deletion, you might be able to avoid performing a preliminary restore from backup \(nonauthoritative restore\) and having to extend the restore process to other domains. Use the **repadmin \/showrepl** command to determine the date and time of the latest inbound replication of the domain directory partition where the deletions occurred.  
  
 Global catalog servers often have greater replication latency than ordinary domain controllers, and they are better restore candidates in general because they store universal group memberships. If you can stop inbound replication on a latent global catalog server, you can perform an authoritative restore on the global catalog server to recover the deleted memberships for all groups in the domain and for all universal groups in other domains.  
  
 If you want to use a latent global catalog server for restoring deleted objects, you must take steps to stop inbound replication immediately. You can use one of the following methods to stop replication:  
  
-   Use the Services snap\-in to stop AD DS. In this case, other services continue to operate.  
  
-   Take the global catalog service offline by restarting it in Directory Services Restore Mode \(DSRM\). In this case, all other directory\-related services are stopped in addition to AD DS.  
  
-   Use Repadmin.exe to stop inbound replication. In this case, the domain controller continues to operate but does not receive replication updates.  
  
## Retention \(merge\) of new group memberships or other attributes after authoritative restore  
 The authoritative restore procedure results in a merge of authoritatively restored objects and attributes and existing objects and attributes. For example, do not expect that users that have been added to a group \(after the backup that is used to restore the deleted group\) will be removed by an authoritative restore of the group object. Instead, new attributes of objects that are specified in the authoritative restore are preserved during replication. Therefore, authoritative restore does not remove group memberships that were added between the time of the backup that is used for authoritative restore and the time of the restore procedure.  
  
 Objects and attributes are preserved during authoritative restore as follows:  
  
-   If an object exists in the backup, before inbound replication the post\-restore directory partition contains the version of the object that exists in the restored backup.  
  
-   If an object was created after the backup was made and there are additional domain controllers that store the directory partition, after inbound replication the restored directory partition also includes the set of objects that were created after the backup.  
  
-   If an object contains new attributes that are not contained in the backup but that exist in the directory partition of an additional domain controller in the domain at the time of the restore, after inbound replication the version of the object and attributes as they existed in the backup—plus any new attributes that were added to the object after the backup—are preserved.  
  
 Authoritative restore affects only the objects and attributes that existed at the time of the backup. This functionality applies to objects with linked attributes and nonlinked attributes alike. For example, if you are restoring an object that has attribute A and attribute B in the backup version and has attributes A’, B’, and C in the current directory, attribute C is retained after authoritative restore. Therefore, a group object that has the **member** value of User1 in the backup and has both User1 and User2 in the current directory includes both of those memberships after authoritative restore of the group object. Any post\-backup **memberOf** or **member** attribute values that were added to a user or group, respectively, are not affected by replication updates after the restore procedure.  
  
 If you want to remove group memberships—or any other unwanted object attribute—complete the following steps:  
  
1.  Delete the object whose updates you do not want to retain.  
  
2.  Allow the deletion to replicate throughout the forest.  
  
3.  Back up a domain controller that has received the deletion.  
  
4.  Authoritatively restore the object that you deleted from the backup that does not contain the unwanted values.  
  
## Authoritative restore procedures  
 Procedures for this task restore deleted objects and back\-links for the restored objects in the domain of the deletions. If you are restoring security principals that might belong to groups in more than one domain or if you are restoring other objects that have back\-links to objects in another domain, additional steps are required.  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   Repadmin.exe  
  
-   Remote Desktop Connection \(optional\)  
  
-   Bcdedit.exe \(optional\)  
  
-   Ntdsutil.exe  
  
 To complete this task, perform procedures according to the conditions in your environment:  
  
-   [Procedures for restoring after deletions have replicated](../Topic/Performing-Authoritative-Restore-of-Active-Directory-Objects.md#BKMK_after_deletions)  
  
-   [Procedures for restoring before deletions have replicated](../Topic/Performing-Authoritative-Restore-of-Active-Directory-Objects.md#BKMK_before_deletions)  
  
-   [Procedures for recovering group memberships \(and any other back\-link attributes\) in other domains](../Topic/Performing-Authoritative-Restore-of-Active-Directory-Objects.md#BKMK_recover_groups)  
  
###  <a name="BKMK_after_deletions"></a> Procedures for restoring after deletions have replicated  
 If you are performing authoritative restore on a domain controller that has already received replication of the deletions, perform the following procedures on the recovery domain controller:  
  
1.  If you do not have a current backup of the recovery domain controller, [Perform a System State Backup of a Domain Controller by Using the Command Line &#40;Wbadmin&#41;](../Topic/Perform-a-System-State-Backup-of-a-Domain-Controller-by-Using-the-Command-Line--Wbadmin-.md). You can use this backup if your recovery is not successful and then try again.  
  
2.  [Restart the Domain Controller in Directory Services Restore Mode Locally](../Topic/Restart-the-Domain-Controller-in-Directory-Services-Restore-Mode-Locally.md)  
  
     Or  
  
     [Restart the Domain Controller in Directory Services Restore Mode Remotely](../Topic/Restart-the-Domain-Controller-in-Directory-Services-Restore-Mode-Remotely.md)  
  
     Restore from backup requires restarting the domain controller in DSRM. Taking the domain controller offline by stopping AD DS is not sufficient to run Ntdsutil procedures to restore from backup.  
  
3.  [Restore AD DS from Backup &#40;Nonauthoritative Restore&#41;](../Topic/Restore-AD-DS-from-Backup--Nonauthoritative-Restore-.md)  
  
     Use this procedure to return the domain controller to its state at the time of the backup so that any groups that are being restored—or whose members are being restored—are present in the directory with their predeletion membership intact. When Ntdsutil.exe generates the .ldf file during authoritative restore, it searches for **member** attributes that refer to objects that are contained in the text file, which contains the objects that are marked for authoritative restore.  
  
     To ensure that replication does not occur, do not restart the domain controller after the restore procedure.  
  
4.  [Mark an Object or Objects as Authoritative](../Topic/Mark-an-Object-or-Objects-as-Authoritative.md)  
  
     Mark the object or objects that you want to restore so that replication does not overwrite them when you restart the domain controller.  
  
5.  Restart the domain controller normally.  
  
6.  [Synchronize Replication with All Partners](../Topic/Synchronize-Replication-with-All-Partners.md)  
  
     For the newly restored object to become available and be instantiated in its restored form on all domain controllers, successful outbound replication must occur from the domain controller that originates the restored changes to its partners.  
  
     Make sure that all domain controllers in the domain and all global catalog servers in the forest have received the restored objects.  
  
7.  [Run an LDIF File to Recover Back-Links](../Topic/Run-an-LDIF-File-to-Recover-Back-Links.md) in this domain. This procedure updates the group memberships of a restored security principal object or container of objects in the recovery domain. Perform this procedure for each individual object or container that you marked as authoritative.  
  
8.  If the .ldf file shows back\-links for objects in other domains, perform the procedures in [Procedures for recovering group memberships \(and any other back\-link attributes\) in other domains](../Topic/Performing-Authoritative-Restore-of-Active-Directory-Objects.md#BKMK_recover_groups).  
  
###  <a name="BKMK_before_deletions"></a> Procedures for restoring before deletions have replicated  
 If you have identified a global catalog server or other domain controller that has not received replication of the deletions and for which you have a recent backup, you do not have to perform a preliminary restore from backup. You do not have to perform the authoritative restore procedure in DSRM. Instead, you can stop the AD DS service. Perform the following procedures on the recovery domain controller:  
  
1.  [Turn Off Inbound Replication](../Topic/Turn-Off-Inbound-Replication.md). Leave inbound replication turned off until you have finished marking objects that you want to replicate authoritatively.  
  
2.  If you do not have a current backup of the recovery domain controller, [Perform a System State Backup of a Domain Controller by Using the Command Line &#40;Wbadmin&#41;](../Topic/Perform-a-System-State-Backup-of-a-Domain-Controller-by-Using-the-Command-Line--Wbadmin-.md). You can use this backup if your recovery is not successful and then try again.  
  
3.  Use the Services snap\-in to stop AD DS.  
  
4.  [Mark an Object or Objects as Authoritative](../Topic/Mark-an-Object-or-Objects-as-Authoritative.md)  
  
     Mark the object or objects that you want to restore so that replication does not overwrite them when you restart the domain controller.  
  
5.  Use the Services snap\-in to restart AD DS.  
  
6.  [Synchronize Replication with All Partners](../Topic/Synchronize-Replication-with-All-Partners.md)  
  
     For the authoritatively marked objects to become available and be instantiated on all domain controllers, successful outbound replication must occur from the domain controller that originates the authoritative changes to its partners.  
  
     Make sure that all domain controllers in the domain and all global catalog servers in the forest have received replication of the authoritative objects.  
  
7.  [Run an LDIF File to Recover Back-Links](../Topic/Run-an-LDIF-File-to-Recover-Back-Links.md) in this domain. This procedure updates the group memberships of a restored security principal object or a container of objects in the recovery domain. Perform this procedure for each individual object or container that you marked as authoritative.  
  
8.  [Turn on Inbound Replication](../Topic/Turn-on-Inbound-Replication.md).  
  
9. Back up the recovered domain controller. See Perform a System State Backup of a Domain Controller by Using the Command Line \(Wbadmin\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=118357](http://go.microsoft.com/fwlink/?LinkId=118357)\) or Perform a Backup of Critical Volumes of a Domain Controller by Using the GUI \(Windows Server Backup\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=116312](http://go.microsoft.com/fwlink/?LinkId=116312)\).  
  
10. If the .ldf file shows back\-links for objects in other domains, complete the procedures in [Procedures for recovering group memberships \(and any other back\-link attributes\) in other domains](../Topic/Performing-Authoritative-Restore-of-Active-Directory-Objects.md#BKMK_recover_groups).  
  
###  <a name="BKMK_ProceduresForRecovering"></a> Procedures for recovering group memberships \(and any other back\-link attributes\) in other domains  
 You can recover group memberships in other domains either by adding the members manually to the respective groups or by using the text file from the original authoritative restore procedure to generate one or more .ldf files that you can use to recover back\-links in other domains. Be aware that restored objects might have back\-links other than group memberships.  
  
 If you have restored security principal objects or other objects that have back\-link attributes in a forest that has more than one domain and you do not want to restore the back\-links manually, perform the following steps on a domain controller in each additional domain:  
  
> [!NOTE]  
>  For restored security principals, these steps are required only if the restored security principals have memberships in domain local or universal groups in a different domain from the recovery domain. If you restored the security principals on a global catalog server, you need to recover only domain local group memberships in other domains. In some cases, these accounts might be few enough that you can manually recreate the memberships instead of following these procedures.  
  
1.  [Restart the Domain Controller in Directory Services Restore Mode Locally](../Topic/Restart-the-Domain-Controller-in-Directory-Services-Restore-Mode-Locally.md)  
  
     Or  
  
     [Restart the Domain Controller in Directory Services Restore Mode Remotely](../Topic/Restart-the-Domain-Controller-in-Directory-Services-Restore-Mode-Remotely.md)  
  
2.  [Restore AD DS from Backup &#40;Nonauthoritative Restore&#41;](../Topic/Restore-AD-DS-from-Backup--Nonauthoritative-Restore-.md)  
  
     When the group members were deleted, the **member** attribute \(forward link\) on any group of which they were members was removed from the group object. This procedure is required to restore the **member** attribute on group objects for those group members that were deleted. This attribute is required to regenerate the **memberOf** attribute value on the restored group members.  
  
3.  While still in DSRM, use Ntdsutil to [Create an LDIF File for Recovering Back-Links for Authoritatively Restored Objects](../Topic/Create-an-LDIF-File-for-Recovering-Back-Links-for-Authoritatively-Restored-Objects.md).  
  
     In this procedure, you must specify the location of the .txt file that was generated by Ntdsutil during the authoritative restore procedure.  
  
4.  Restart the domain controller normally.  
  
5.  [Run an LDIF File to Recover Back-Links](../Topic/Run-an-LDIF-File-to-Recover-Back-Links.md) in this domain on a domain controller other than the domain controller that you restored from backup and on which you created the LDIF file. Because you have just restored the domain controller on which you created the LDIF file from backup, perform this procedure on a different domain controller to be sure that the group objects you update are current. This procedure updates the group memberships of a restored security principal object or container of objects. Perform this procedure for each individual object or container that you marked as authoritative.  
  
## Additional references  
  
-   [Known Issues for Authoritative Restore](../Topic/Known-Issues-for-Authoritative-Restore.md)  
  
-   [Best Practices for Authoritative Restore](../Topic/Best-Practices-for-Authoritative-Restore.md)  
  
  