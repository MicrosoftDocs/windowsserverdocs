---
title: Fixing Replication Lingering Object Problems (Event IDs 1388, 1988, 2042)
H1: na
ms.custom: 
  - x
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: 53ea71ae-4ecb-475a-935b-cd6a9afff02e
---
# Fixing Replication Lingering Object Problems (Event IDs 1388, 1988, 2042)
If a domain controller does not replicate for a period of time that is longer than the tombstone lifetime and the domain controller is then reconnected to the replication topology, objects that were deleted from Active Directory Domain Services \(AD DS\) while the domain controller was offline can remain on the domain controller as lingering objects.  
  
 A lingering object can be reintroduced into AD DS if it is allowed to replicate to another domain controller that has deleted the object and has also deleted \(garbage\-collected\) the tombstone for the deleted object. This topic explains the criteria for when and how such replication can occur. Because domain controllers that are running Windows 2000 Server are capable of replicating lingering objects and because the upgrade path from Windows 2000 Server to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] can result in a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain controller that retains this capability, it is important to be aware of these conditions and correct them if you are upgrading a Windows 2000 Server forest to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
 **In this topic**  
  
-   [Tombstone lifetime and replication of deletions](#BKMK_TSL_Deletions)  
  
-   [How lingering objects occur](#BKMK_How)  
  
-   [Causes of long disconnections](#BKMK_Causes)  
  
-   [Indications that a domain controller could have lingering objects](#BKMK_Indications)  
  
-   [Symptoms associated with lingering objects](#BKMK_Symptoms)  
  
-   [Registry setting that determines whether lingering objects are replicated](#BKMK_Registry)  
  
-   [Default settings for strict replication consistency](#BKMK_Default)  
  
-   [Enabling strict replication consistency](#BKMK_Enabling)  
  
-   [Tool for removing lingering objects](#BKMK_Tool)  
  
##  <a name="BKMK_TSL_Deletions"></a> Tombstone lifetime and replication of deletions  
 When an object is deleted, AD DS replicates the deletion as a tombstone object, which consists of a small subset of the attributes of the deleted object. By inbound\-replicating this object, other domain controllers in the domain and forest become aware of the deletion. The tombstone is retained in AD DS for a specified period, called the tombstone lifetime. At the end of the tombstone lifetime, the tombstone is deleted from the directory permanently.  
  
 The default value of the tombstone lifetime depends on the version of the operating system that is running on the first domain controller that is installed in a forest, as follows:  
  
-   Windows 2000 Server or Windows Server 2003: The default value is 60 days.  
  
-   Windows Server 2003 with Service Pack 1 \(SP1\), Windows Server 2003 with Service Pack 2 \(SP2\), Windows Server 2003 R2, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]: The default value is 180 days.  
  
> [!NOTE]  
>  The tombstone lifetime value is a forest\-wide setting that you can change administratively. The tombstone lifetime value that is in effect when a domain controller is upgraded from a version of Windows 2000 Server or Windows Server 2003 without SP1 is not changed in the upgrade. The existing value is maintained until you change it manually.  
  
 After the tombstone is removed permanently, the object deletion can no longer be replicated. Therefore, the tombstone lifetime determines how long domain controllers in the forest retain a record of a deleted object. Therefore, the tombstone lifetime determines the time during which a unique deletion must be received by all direct and transitive replication partners of the originating domain controller.  
  
##  <a name="BKMK_How"></a> How lingering objects occur  
 When conditions beyond your control cause a domain controller to be disconnected from the replication topology for a period that is longer than the tombstone lifetime, one or more objects that are deleted from AD DS on all other domain controllers might remain on the disconnected domain controller. Such objects are called lingering objects. Because the domain controller is disconnected from the replication topology during the entire time that the tombstone exists in the directory, the domain controller never receives replication of the tombstone.  
  
 When it is reconnected to the replication topology, this domain controller acts as a source replication partner that has an object that its destination replication partner does not have.  
  
 Replication problems occur when the object on the source domain controller is updated. In this case, when the destination domain controller attempts to inbound\-replicate the update, one of the following occurs:  
  
-   If the destination domain controller has strict replication consistency enabled, it recognizes that it cannot update the object \(because the object does not exist\), and it locally halts inbound replication of the directory partition from that source domain controller.  
  
-   If the destination domain controller has strict replication consistency disabled, it requests the full replica of the updated object. In this case, the object is reintroduced into the directory.  
  
 Lingering objects can reside in writable or read\-only directory partitions that are potentially replicated between domain controllers in the same domain or in different domains in the same forest.  
  
##  <a name="BKMK_Causes"></a> Causes of long disconnections  
 Unexpectedly long disconnections can be caused by the following conditions:  
  
-   A domain controller is left in a storage room and forgotten, or shipment of a prestaged domain controller to its remote location takes longer than a tombstone lifetime.  
  
-   Replication fails and monitoring is not in place. Failures can occur as follows:  
  
    -   A domain controller is started and connected to the corporate intranet, but the domain controller experiences inbound replication failure as a result of an underlying network connectivity failure, name resolution failure, or authentication failure that prevents replication from occurring.  
  
    -   A bridgehead server is overloaded, and replication becomes backlogged. Excessively high replication load on a global catalog server, in combination with a short intersite replication interval, can result in updates not being replicated.  
  
> [!NOTE]  
>  Global catalog servers replicate read\-only replicas of all domain directory partitions in the forest. The replication of read\-only replicas has a lower priority than the replication of writable replicas. In addition, global catalog servers are often bridgehead servers, which adds to the replication load. If the replication load on global catalog servers acting as bridgehead servers is too high as a result of an extremely short replication interval, excessive numbers of concurrent outbound replication partners, or a combination of both, the replication queue can become backlogged. If the condition persists, read\-only replicas can remain in the queue indefinitely. These conditions can result in lingering objects on a global catalog server.  
  
-   Wide area network \(WAN\) connections are unavailable for long periods. For example, a domain controller onboard a cruise ship might be unable to replicate because the ship is at sea for longer than the tombstone lifetime.  
  
-   The reported event is a false positive because an administrator shortened the tombstone lifetime to force tombstone deletion \(garbage collection\).  
  
-   The reported event is a false positive because the system clock on the source or destination domain controller is improperly rolled forward or back in time. Clock skews are most common following a system reboot and can have the following causes:  
  
    -   There are system clock battery or motherboard problems.  
  
    -   The time source for a computer is improperly configured, including a time source server that is configured with Windows Time service \(W32time\), non\-Microsoft time servers, and network routers.  
  
    -   The system clock is advanced or rolled back by an administrator who is attempting to extend the useful life of a system state backup or accelerate the garbage collection of deleted objects. Make sure that the system clock reflects the actual time and that event logs do not contain events from the future or the invalid past.  
  
##  <a name="BKMK_Indications"></a> Indications that a domain controller could have lingering objects  
 An outdated domain controller can store lingering objects with no noticeable effect as long as an administrator, application, or service does not update the lingering object or attempt to create an object with the same name in the domain or with the same user principal name \(UPN\) in the forest. However, the existence of lingering objects can cause problems, especially if the object is a security principal.  
  
###  <a name="BKMK_Symptoms"></a> Symptoms associated with lingering objects  
 The following symptoms indicate that a domain controller could have lingering objects:  
  
-   A deleted user or group account remains in the global address list \(GAL\) on Exchange servers. Therefore, although the account name appears in the GAL, attempts to send e\-mail messages result in errors.  
  
-   Multiple copies of an object appear in the object picker or GAL for an object that should be unique in the forest. Duplicate objects sometimes appear with altered names, causing confusion on directory searches. For example, if the relative distinguished name of two objects cannot be resolved, conflict resolution appends "\*CNF:*GUID*" to the name, where \* represents a reserved character, CNF is a constant that indicates a conflict resolution, and *GUID* represents the **objectGUID** attribute value.  
  
-   E\-mail messages are not delivered to a user whose Active Directory account appears to be current. After an outdated domain controller or global catalog server becomes reconnected, both instances of the user object appear in the global catalog. Because both objects have the same e\-mail address, e\-mail messages cannot be delivered.  
  
-   A universal group that no longer exists continues to appear in a user’s access token. Although the group no longer exists, if a user account still has the group in its security token, the user might have access to a resource that you intended to be unavailable to that user.  
  
-   A new object or Exchange mailbox cannot be created, but you do not see the object in AD DS. An error message reports that the object already exists.  
  
-   Searches that use attributes of an existing object incorrectly find multiple copies of an object of the same name. One object has been deleted from the domain, but it remains in an isolated global catalog server.  
  
 If an attempt is made to update a lingering object that resides in a writable directory partition, events are logged on the destination domain controller. However, if the only version of a lingering object exists in a read\-only directory partition on a global catalog server, the object cannot be updated and this type of event will never be triggered.  
  
###  <a name="BKMK_Registry"></a> Registry setting that determines whether lingering objects are replicated  
 If a writable lingering object exists in your environment and an attempt is made to update the object, the value in the **strict replication consistency** registry entry \(type **REG\_DWORD**\) in **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\NTDS\\Parameters** determines whether replication proceeds or is stopped, as follows:  
  
-   **1** \(enabled\): Inbound replication of the specified directory partition from the source is stopped on the destination.  
  
-   **0** \(disabled\): The destination requests the full object from the source domain controller, and the lingering object is revived in the directory as a new object.  
  
####  <a name="BKMK_Default"></a> Default settings for strict replication consistency  
 The default value for the **strict replication consistency** registry entry on a domain controller is determined by the conditions under which the domain controller is installed into the forest.  
  
> [!NOTE]  
>  Raising the domain or forest functional level does not change the replication consistency setting on any domain controller.  
  
 **Strict replication consistency enabled**  
  
 The default value of **strict replication consistency** is ENABLED \(**1**\) on domain controllers that are installed into a forest under the following conditions:  
  
-   The forest root domain of a new forest was created by installing AD DS on a server running one of the following operating systems:  
  
    -   [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]  
  
    -   Windows Server 2003  
  
-   The forest root domain of a new forest was created by upgrading a Windows NT 4.0 primary domain controller \(PDC\) to Windows Server 2003 by using the Windows Server 2003 version of Winnt32.exe.  
  
 **Strict replication consistency disabled**  
  
 The default value of **strict replication consistency** is DISABLED \(**0**\) on domain controllers under the following conditions:  
  
-   A domain controller running Windows 2000 Server is upgraded to Windows Server 2003.  
  
     The same domain controller is upgraded to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
-   A new domain controller is created by installing Active Directory on a member server running Windows 2000 Server.  
  
     The same domain controller is upgraded to Windows Server 2003.  
  
-   A member server running Windows 2000 Server is upgraded to Windows Server 2003, and Active Directory is subsequently installed.  
  
     The same domain controller is upgraded to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
 For more information about strict replication consistency, see "How the Active Directory Replication Model Works" in the Windows Server 2003 Technical Reference \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=27636](http://go.microsoft.com/fwlink/?LinkId=27636)\).  
  
##  <a name="BKMK_Enabling"></a> Enabling strict replication consistency  
 In scenarios in which strict replication consistency is disabled, you can enable strict replication manually in the following ways:  
  
-   Single domain controller: Use Repadmin or Regedit to change the setting on the domain controller.  
  
    > [!NOTE]  
    >  The Repadmin commands for setting replication consistency are available on domain controllers that are running at least Windows Server 2003 with SP1. For earlier versions, you must use Regedit.  
  
-   All domain controllers in the forest: Use Repadmin to change the setting on all domain controllers in the forest.  
  
-   All future domain controllers that are created in the forest: Use Ldifde.exe to create the operational GUID in the configuration directory partition that enables strict replication consistency on any new domain controller that is added to the forest.  
  
 For instructions to enable strict replication consistency, see [Event ID 1388 or 1988: A lingering object is detected](../Topic/Event%20ID%201388%20or%201988:%20A%20lingering%20object%20is%20detected.md).  
  
##  <a name="BKMK_Tool"></a> Tool for removing lingering objects  
 On domain controllers running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Repadmin is installed by default. On domain controllers running Windows Server 2003 or Windows Server 2003 with SP1, use Repadmin.exe \(in Windows Support Tools\) to remove the lingering object or objects. Windows Support Tools are available on the operating system CD in the Support\\Tools folder or from the Microsoft Download Center \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=100114](http://go.microsoft.com/fwlink/?LinkId=100114)\). The version of Repadmin that ships with Windows Server 2003 provides the option **\/removelingeringobjects**, which safely removes instances of lingering objects from both writable directory partitions and read\-only directory partitions.  
  
 The **repadmin \/removelingeringobjects** command does the following:  
  
1.  Compares the directory database objects on a reference domain controller with the objects on the target domain controller, which contains \(or is suspected to contain\) lingering objects. There must be connectivity between the reference domain controller and the target domain controller.  
  
2.  Either removes the lingering objects or logs the potential deletions to the Directory Service event log, as follows:  
  
    -   If you use the **\/advisory\_mode** parameter, events are logged in the Directory Service event log for the objects that are found.  
  
    -   If you do not use the **\/advisory\_mode** parameter, the found objects are deleted without replicating the deletions. That is, the deletions occur only on the target domain controller.  
  
 From the following list, choose the problem that best describes your situation, and then complete the procedures for the suggested fix:  
  
-   [Event ID 1388 or 1988: A lingering object is detected](../Topic/Event%20ID%201388%20or%201988:%20A%20lingering%20object%20is%20detected.md)  
  
-   [A deleted account remains in the Address Book, e\-mail is not received, or a duplicate account exists](../../identity/ad-ds/A-deleted-account-remains-in-the-Address-Book--e-mail-is-not-received--or-a-duplicate-account-exists.md)  
  
-   [Event ID 2042: It has been too long since this machine replicated](../Topic/Event%20ID%202042:%20It%20has%20been%20too%20long%20since%20this%20machine%20replicated.md)