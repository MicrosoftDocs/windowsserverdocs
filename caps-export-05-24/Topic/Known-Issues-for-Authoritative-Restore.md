---
title: Known Issues for Authoritative Restore
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 6d337b92-96ea-4231-a94c-dc49a486d3f5
author: Femila
---
# Known Issues for Authoritative Restore
  Review the following known issues before you perform an authoritative restore on domain controllers running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] in forests that have the forest functional level of Windows Server 2003, Windows Server 2003 interim, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]:  
  
-   Order of replication and dropped group memberships  
  
-   Members added back to groups from which they were deleted  
  
-   Incorrect assignment of Exchange mailboxes  
  
##  <a name="BKMK_ord_repl"></a> Order of replication and dropped group memberships  
 When groups that are being restored were created or updated when the forest had a forest functional level of Windows Server 2003, Windows Server 2003 interim, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] \(that is, when linked\-value replication \(LVR\) was in effect\), the version of Ntdsutil on domain controllers that are running Windows Server 2003 with Service Pack 1 \(SP1\), Windows Server 2003 with Service Pack 2 \(SP2\), Windows Server 2003 R2, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] automatically restores group memberships during the authoritative restore procedure by restoring back\-links to group objects. To restore back\-links for pre\-LVR groups, Ntdsutil generates an LDAP Data Interchange Format \(LDIF\) file \(.ldf\) that you must process by using the Ldifde.exe tool to manually restore the back\-link values. However—of particular importance where group memberships are concerned—the order of replication can undo the benefits of authoritative restore in some cases. For this reason, we recommend always processing the .ldf file that is produced by Ntdsutil during authoritative restore to update group memberships, even if the group or groups being restored were created or updated when LVR was in effect. For information about LVR and its effects on the authoritative restore process, see [Performing Authoritative Restore of Active Directory Objects](../Topic/Performing-Authoritative-Restore-of-Active-Directory-Objects.md).  
  
 Updated, authoritatively marked objects replicate in a “store\-and\-forward” manner that might lead to the objects being received on one domain controller and forwarded to one or more other domain controllers. Regardless of the order in which replication is initiated, the order in which replicated updates are received cannot be guaranteed. For this reason, it is possible for authoritatively restored group objects to replicate ahead of authoritatively restored objects that are group members, which can result in dropped memberships.  
  
 For example, suppose group A and its member User X are both deleted. And suppose User X and Group A are authoritatively restored and, during the authoritative restore procedure, Ntdsutil updates the **member** attribute of Group A to include authoritatively restored User X, and the **memberOf** attribute of User X to include Group A. If replication of Group A is received before replication of User X, User X is currently a deleted object on the recipient domain controller. In this case, the User X link value is dropped from the **member** attribute of Group A. When replication of the authoritatively restored User X is received, perhaps only seconds later, the **member** attribute of the group is not updated. If replication of User X is received before Group A, the membership on Group A is retained.  
  
 Use the following steps to ensure that group memberships for authoritatively restored groups and their restored members are always retained during replication after authoritative restore:  
  
1.  Ensure that all authoritatively restored objects have replicated and exist on all domain controllers in the domain.  
  
2.  Run the .ldf file on the recovery domain controller.  
  
3.  Force replication on the recovery domain controller.  
  
##  <a name="BKMK_mem_back"></a> Members added back to groups from which they were deleted  
 To recover memberships in groups in the recovery domain and in other domains in which a restored security principal might have group memberships, you process an .ldf file to restore the memberships. It is possible for the .ldf file to include memberships in groups from which a restored user object was removed before the backup that is used for the preliminary nonauthoritative restore. In this case, after authoritative restore, a user might have membership in a group from which the user was formerly removed. For more information, see article 951320 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=122656](http://go.microsoft.com/fwlink/?LinkId=122656)\).  
  
##  <a name="BKMK_ex_box"></a> Incorrect assignment of Exchange mailboxes  
 Authoritative restore of deleted user accounts that have mailboxes in Microsoft Exchange 2003 can result in incorrect mailbox assignments after replication. For information about avoiding this issue, see article 948997 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=116275](http://go.microsoft.com/fwlink/?LinkId=116275)\).  
  
  