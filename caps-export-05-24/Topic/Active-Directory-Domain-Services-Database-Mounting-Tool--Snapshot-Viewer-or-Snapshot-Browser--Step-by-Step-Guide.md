---
title: Active Directory Domain Services Database Mounting Tool (Snapshot Viewer or Snapshot Browser) Step-by-Step Guide
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 4503d762-0adf-494f-a08b-cf502ecb7602
author: Femila
---
# Active Directory Domain Services Database Mounting Tool (Snapshot Viewer or Snapshot Browser) Step-by-Step Guide
  This guide shows how you can use an improved version of Ntdsutil and a new Active Directory® database mounting tool in [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)] to create and view snapshots of data that is stored in Active Directory Domain Services \(AD DS\) or Active Directory Lightweight Directory Services \(AD LDS\), without restarting the domain controller or AD LDS server. A snapshot is a shadow copy—created by the Volume Shadow Copy Service \(VSS\)—of the volumes that contain the Active Directory database and log files.  
  
> [!NOTE]  
>  During product development, this feature has also been known by other names, including Snapshot Viewer, Snapshot Browser, and Active Directory data mining tool.  
  
 The Active Directory database mounting tool \(Dsamain.exe\) can improve recovery processes for your organization by providing a means to compare data as it exists in snapshots that are taken at different times so that you can better decide which data to restore after data loss. This eliminates the need to restore multiple backups to compare the Active Directory data that they contain.  
  
 This guide provides step\-by\-step instructions for using the Active Directory database mounting tool, including creating, listing, and mounting snapshots of AD DS; preparing them for viewing as a Lightweight Directory Access Protocol \(LDAP\) server; and viewing the data itself.  
  
 For more information about VSS snapshots, see Shadow Copies and Shadow Copy Sets \(VSS\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=90631](http://go.microsoft.com/fwlink/?LinkId=90631)\).  
  
## In this guide  
 [End-to-End Scenario That Uses the Active Directory Database Mounting Tool](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md)  
  
## Who should use this guide?  
 The following individuals should review this information about the Active Directory database mounting tool:  
  
-   Information technology \(IT\) planners and analysts who are technically evaluating the product  
  
-   Enterprise IT planners and designers for organizations  
  
-   Administrators, operators, and managers who are responsible for IT operations, including recovery of deleted Active Directory data  
  
## Scenarios for using the Active Directory database mounting tool  
 This section describes common scenarios in which you can use the Active Directory database mounting tool.  
  
### Simplifying the forest recovery process  
 For organizations that have domain controllers running Windows Server 2003, the forest recovery process requires a determination of which backup is best to use for recovery. In general, you must consider whether to restore a recent backup of your data or an older backup that you believe may be safer. Choosing a more recent backup recovers more useful data, but it might increase the risk of reintroducing dangerous data into the restored forest.  
  
 To determine which backup is best, you must restore it to a domain controller to view its contents. Each restore operation requires that you restart the domain controller in Directory Services Restore Mode \(DSRM\).  
  
 For some organizations, the loss of productivity caused by the time required for such restore operations is great. These organizations often must keep detailed logs about the Active Directory health state on a daily basis so that, in case of a failure throughout the forest, the approximate time of failure can be identified.  
  
 In a forest recovery scenario, the ability to precisely determine which backup contains the best data to recover can drastically reduce downtime.  
  
### Auditing modified and deleted objects  
 Dsamain.exe helps you examine any changes that are made to Active Directory data. For example, if an object is accidentally modified, you can use this tool to examine the changes and to help you better decide how to correct them if necessary.  
  
 By scheduling a task to regularly create snapshots of the AD DS database, you can keep detailed records of AD DS data as it changes over time. You can create AD DS snapshots without devoting as much time and storage space as Windows Server Backup requires for critical\-volume backups.  
  
## Requirements for using the Active Directory database mounting tool  
 You do not need any additional software to use the Active Directory database mounting tool. All the tools that are required to use this feature are built into [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and are available if you have the AD DS or the AD LDS server role installed. These tools include the following:  
  
-   A new **ntdsutil snapshot** operation that you can use to create, list, mount, and unmount snapshots of AD DS or AD LDS data  
  
    > [!NOTE]  
    >  You are not required to run the **ntdsutil snapshot** operation to use Dsamain.exe. You can instead use a backup of the AD DS or AD LDS database or another domain controller or AD LDS server. The **ntdsutil snapshot** operation simply provides a convenient data input for Dsamain.exe.  
  
-   Dsamain.exe, which you can use to expose the snapshot data as an LDAP server  
  
-   Existing LDAP tools, such as Ldp.exe and Active Directory Users and Computers  
  
 By default, only members of the Domain Admins group and the Enterprise Admins group are allowed to view the snapshots because they contain sensitive AD DS data. If you want to access snapshot data from an old domain or forest that has been deleted, you can allow nonadministrators to access the data when you run Dsamain.exe.  
  
 All permissions that apply to the data in the snapshot are enforced when you view the data. For example, suppose that members of the Domain Admins groups are explicitly denied Read permission for an object in AD DS. If you supply credentials for a member of that group when you try to view the snapshot data for that object, access is denied.  
  
 Moreover, you cannot change the existing permission to grant Read access in the snapshot that you are viewing because the Active Directory data is read\-only. Any add, modify, or delete operations will fail.  
  
 However, a malicious user might be able to copy sensitive data that might be stored in AD DS snapshots to another forest and then use privileged credentials from that forest to examine the data. Therefore, you should protect them in a manner that is similar to how you protect domain controller backups. Use encryption or other data security precautions with AD DS snapshots to help mitigate the chance of unauthorized access to them.  
  
## Steps for using the Active Directory database mounting tool  
 You are not required to use the **ntdsutil snapshot**operation to create the snapshots. You can use any backup of an AD DS or AD LDS database that uses VSS, including non\-Microsoft backup solutions. The database must be in a consistent state; that is, the logs must be replayed. If you use Ntdsutil.exe or Windows Server Backup on a server running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], the resulting snapshot or backup will be consistent.  
  
> [!NOTE]  
>  A domain controller backup contains more data than an AD DS snapshot because it also includes files that are needed to restore the operating system.  
  
 You can use either Ntdsutil.exe to mount the snapshot or use Windows Server Backup to restore the backup to an alternative location or to another computer. Then, you can use a tool such as Ldp.exe to view the data.  
  
 You can use the following process to use the Active Directory database mounting tool:  
  
1.  Although it is not a requirement, you can schedule a task that regularly runs Ntdsutil.exe to take snapshots of the volume that contains the AD DS or AD LDS database.  
  
2.  Run Ntdsutil.exe to list the snapshots that are available and then mount the snapshot that you want to view.  
  
3.  Run Dsamain.exe to expose the snapshot volume as an LDAP server.  
  
     Dsamain.exe takes the following arguments:  
  
    -   AD DS or AD LDS database \(Ntds.dit\) full file path. By default this file is opened as read\-only. Only ASCII paths are supported. Network share paths are not supported.  
  
    -   Log path. This can be a temporary path, but you must have write access. This parameter is optional. If you do not specify the log path, logs and a temporary database are created in the Temp folder.  
  
    -   Four port numbers for LDAP, LDAP\-SSL, Global Catalog, and Global Catalog–SSL. Only the LDAP port is required. If the other ports are not specified, they will use LDAP\+1, LDAP\+2, and LDAP\+3, respectively. For example, if you specify LDAP port 41389 without specifying other port values, the LDAP\-SSL port will use port 41390 by default, and so on.  
  
     You can stop Dsamain by pressing CTRL\+C in the Command Prompt window or, if you are running the command remotely, by setting the **stopservice** attribute on the rootDSE object.  
  
4.  Run and attach Ldp.exe to the snapshot’s LDAP port that you specified when you exposed the snapshot as an LDAP server in the previous step.  
  
     You can also try using the Active Directory Users and Computers snap\-in that is installed by default on a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain controller, as described in the procedure later in this guide.  
  
5.  Browse the snapshot just as you would with any live domain controller.  
  
 If you specify different ports for each snapshot when you run Dsamain.exe, you can browse multiple snapshot instances on the same domain controller \(or on the same workstation if you are browsing a restored backup\) at the same time and easily compare their data.  
  
 If you have some idea which organizational unit \(OU\) or objects were deleted, you can look up the deleted objects in the snapshots and record the attributes and back\-links that belonged to the deleted objects. You can reanimate these objects by using the tombstone reanimation feature on a domain controller in your production environment. Then, you must manually repopulate these objects with the stripped attributes and back\-links as identified in the snapshots. For more information about tombstone reanimation, see Reanimating Active Directory Tombstone Objects \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=116204](http://go.microsoft.com/fwlink/?LinkID=116204)\).  
  
 Although you must manually re\-create the stripped attributes and back links, the Active Directory database mounting tool makes it possible for you to re\-create deleted objects and their back\-links without rebooting the domain controller into Directory Services Restore Mode. You can also use the tool to look up previous configurations of AD DS as well, including permissions that were in effect.  
  
### Step 1: Create, mount, and list snapshots  
 To create a snapshot, you must be a member of the Enterprise Admins groups or the Domain Admins group or you must have been delegated the appropriate permissions. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
##### To create an AD DS or AD LDS snapshot  
  
1.  Log on to a domain controller as a member of the Enterprise Admins groups or the Domain Admins group.  
  
2.  Click **Start**, right\-click **Command Prompt**, and then click **Run as administrator**.  
  
3.  [!INCLUDE[uac_appears](../Token/uac_appears_md.md)]  
  
4.  At the elevated command prompt, type the following command, and then press ENTER:  
  
     **ntdsutil**  
  
5.  At the ntdsutil prompt, type the following command, and then press ENTER:  
  
     **snapshot**  
  
6.  At the snapshot prompt, type the following command, and then press ENTER:  
  
     **activate instance ntds**  
  
7.  At the snapshot prompt, type the following command, and then press ENTER:  
  
     **create**  
  
     The command returns the following output:  
  
    ```  
    Snapshot set {GUID} generated successfully.  
    ```  
  
     Where *GUID* is the globally unique identifier \(GUID\) for the snapshot.  
  
8.  At the snapshot prompt, type the following command, and then press ENTER:  
  
     **mount {** *GUID* **}**  
  
9. As an option, to see a list of all mounted snapshots, you can type the following command, and then press ENTER:  
  
     **list mounted**  
  
     The output lists each mounted snapshot and a corresponding index number. You can use the index number instead of the GUID to subsequently mount, unmount, or delete the snapshot.  
  
10. To unmount the snapshot after you have finished viewing the data, type either of the following commands, and then press ENTER:  
  
     **unmount**  *index \#*  
  
     \-or\-  
  
     **unmount {** *GUID* **}**  
  
11. Delete old snapshots that you are no longer using because they consume disk space. To delete a snapshot, type either of the following commands, and then press ENTER:  
  
     **delete**  *index \#*  
  
     \-or\-  
  
     **delete {** *GUID* **}**  
  
12. After you are done with snapshot operations, type **quit** to return to the **ntdsutil** menu, and then type **quit** again to return to the command prompt.  
  
 After you create and mount a snapshot, you can run Dsamain.exe to expose the AD DS or AD LDS data in the snapshot as an LDAP server.  
  
### Step 2 \(Optional\): Schedule a task that creates AD DS snapshots  
 You have the option to schedule a task that runs Ntdsutil.exe regularly to create snapshots.  
  
 To schedule a task to create AD DS or AD LDS snapshots, you must be a member of the Enterprise Admins group or the Domain Admins group. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
##### To schedule a task to create AD DS or AD LDS snapshots  
  
1.  Log on to a domain controller as a member of the Enterprise Admins group or the Domain Admins group.  
  
2.  Click **Start**, click **Administrative Tools**, and then click **Task Scheduler**.  
  
3.  [!INCLUDE[uac_appears](../Token/uac_appears_md.md)]  
  
4.  Click **Action**, and then click **Create task**.  
  
5.  On the **General** tab, type a name for your task, and then select the appropriate security options to run the task.  
  
6.  On the **Triggers** tab, click **New**.  
  
7.  In **New Trigger**, select the appropriate settings for the task, and then click **OK**.  
  
8.  On the **Action** tab, click **New**.  
  
9. In **New Action**, type the name or browse to the file path that contains Ntdsutil.exe and in **Add arguments \(optional\)**, type the following command, and then press ENTER:  
  
     **ntdsutil "activate instance ntds" snapshot create quit quit**  
  
10. On the **Conditions** tab and the **Settings** tab, select any additional settings that you want to apply to the task, and then click **OK**.  
  
11. If you are prompted, enter the password for a member of the Enterprise Admins group or the Domain Admins group, and then click **OK**.  
  
### Step 3: Expose an AD DS or AD LDS snapshot as an LDAP server  
 By default, you must be a member of the Enterprise Admins groups or the Domain Admins group to run Dsamain.exe and to access the Active Directory data that it exposes. If the snapshot is taken from a domain that no longer exits, you can specify the **\/allowNonAdminAccess** parameter. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
##### To expose an AD DS or AD LDS snapshot as an LDAP server  
  
1.  Log on to a domain controller as a member Enterprise Admins groups or the Domain Admins group.  
  
2.  Click **Start**, right\-click **Command Prompt**, and then click **Run as administrator**.  
  
3.  [!INCLUDE[uac_appears](../Token/uac_appears_md.md)]  
  
4.  At the elevated command prompt, type the following command, and then press ENTER. Be sure to include a space between the name of the parameter and the value that you specify.  
  
     **dsamain \/dbpath \<path\_to\_database\_file\> \/ldapport \<port\_\#\>**  
  
     If you plan to view the snapshot data on a domain controller, specify ports that are different from the ports that the domain controller will use. For example, type:  
  
     **dsamain \/dbpath** E:\\$SNAP\_200704181137\_VOLUMED$\\WINDOWS\\NTDS\\ntds.dit **\/ldapport** 51389  
  
     A message indicates that Active Directory Domain Services startup is complete.  
  
 Allow Dsamain.exe to continue running in the command prompt window while you use an LDAP tool such as Ldp.exe or Active Directory Users and Computers to view the AD DS or AD LDS data in the snapshot.  
  
### Step 4: Access Active Directory data that is stored in snapshots  
 To use Ldp.exe or Active Directory Users and Computers to access the AD DS or AD LDS data, you must be a member of the Enterprise Admins groups or the Domain Admins group or you must have been delegated permission. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
##### To use Ldp.exe to access AD DS or AD LDS data that is stored in snapshots  
  
1.  Click **Start**, click **Run**, type **ldp**, and then click **OK**.  
  
2.  Click **Connection**, and then click **Connect**.  
  
3.  In **Server**, type the name of the server, or type **localhost** and, in **Port**, type a port number that you specified previously with **dsamain**. For example, type 51389. Click **OK**.  
  
4.  Click **Connection**, and then click **Bind**.  
  
5.  In **Bind type**, click **Bind as currently logged on user** or click **Bind with credentials** and type a name, password, and domain for a user account that has permission to access the Active Directory data. Click **OK**.  
  
6.  Click **View**, and then click **Tree**.  
  
7.  In **BaseDN**, type the distinguished name of the parent container for the data that you want to view, and then click **OK**. For example, to view all objects in the Contoso domain, type:  
  
     **dc\=contoso,dc\=com**  
  
8.  Double\-click the appropriate containers for the object that you want to view, and then double\-click that object to view its properties.  
  
##### To use Active Directory Users and Computers to access Active Directory data that is stored in snapshots  
  
1.  Click **Start**, click **Administrative Tools**, and then click **Active Directory Users and Computers**.  
  
2.  [!INCLUDE[uac_appears](../Token/uac_appears_md.md)]  
  
3.  In the console tree, right**\-**click **Active Directory Users and Computers \[***FQDN***\]**, and then click **Change Domain Controller**.  
  
4.  Click **\<Type a Domain Controller name or an IP Address here\>**, type the following, and then press ENTER:  
  
     *hostname*:*port*  
  
     where *hostname* is the name of the server where the snapshots are stored and *port* is the LDAP port number that you specified previously with **dsamain**. For example, type the following, and then click **OK**:  
  
     **DC1:51389**  
  
5.  Double\-click the appropriate containers for the object that you want to view, and then double\-click that object to view its properties.  
  
  