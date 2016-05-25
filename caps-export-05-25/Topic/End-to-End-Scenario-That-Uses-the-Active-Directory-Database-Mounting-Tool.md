---
title: End-to-End Scenario That Uses the Active Directory Database Mounting Tool
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 5e07686c-c0e8-469a-b230-42b116670e24
author: Femila
---
# End-to-End Scenario That Uses the Active Directory Database Mounting Tool
  The previous section of this guide explains how to use the Active Directory database mounting tool to take a snapshot of your current Active Directory environment and then expose the data that the snapshot contains. This section describes an end\-to\-end scenario that uses the Active Directory database mounting tool and demonstrates its effectiveness in the recovery of data that might be accidentally deleted from the Active Directory database.  
  
## Scenario overview  
 A user object in the Fabrikam.com domain was accidentally deleted from Active Directory Domain Services \(AD DS\). As the domain administrator for Fabrikam.com, you have been asked to:  
  
-   Reanimate this user object to the exact state that it was in before it was deleted from the directory.  
  
-   Place the user object in its proper container \(the container that the user object was part of before it was deleted\).  
  
-   Add the user object to any group that it was a member of before the delete operation occurred.  
  
### Testing environment  
 The testing environment consists of a one\-domain forest, Fabrikam.com. This forest has the following Active Directory infrastructure:  
  
-   One Windows Server 2008 domain controller \(DC1\)  
  
-   One [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller \(DC2\)  
  
    > [!IMPORTANT]  
    >  You must have a domain controller running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] if you are planning to use cmdlets in the Active Directory module for Windows PowerShell™ to complete this scenario. If you do not plan to use [!INCLUDE[nextref_ad_powershell](../Token/nextref_ad_powershell_md.md)] cmdlets, you can complete the tasks in this section using just the domain controller running Windows Server 2008 \(DC1\).  
    >   
    >  For more information about cmdlets and using the [!INCLUDE[nextref_ad_powershell](../Token/nextref_ad_powershell_md.md)], see What's New in AD DS: [!INCLUDE[nextref_ad_powershell](../Token/nextref_ad_powershell_md.md)] for Windows PowerShell \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=140056](http://go.microsoft.com/fwlink/?LinkID=140056)\).  
  
### Account credentials  
 To complete the procedures for this scenario, the account that you use must be a member of the Enterprise Admins or Domain Admins groups.  
  
## Steps for completing an end\-to\-end scenario that uses the Active Directory database mounting tool  
 The following steps demonstrate an end\-to\-end scenario that uses the Active Directory database mounting tool:  
  
-   [Step 1: Create the initial Active Directory environment](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#create_the_initial_AD_environment)  
  
-   [Step 2: Use Ntdsutil to create a snapshot of the data that is stored in AD DS](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#use_ntdsutil_create_snapsho_stored_AD)  
  
-   [Step 3: Delete a user object from AD DS](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#del_user_ADDS)  
  
-   [Step 4: Expose the data in the AD DS snapshot](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#expose_data_in_ad_ds_snapshot)  
  
-   [Step 5: Restore a deleted Active Directory object](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#restore_del_ad_obj)  
  
##  <a name="create_the_initial_AD_environment"></a> Step 1: Create the initial Active Directory environment  
 This step provides tasks and procedures for creating the initial Active Directory environment. To complete this step, perform the following tasks:  
  
-   [Create an organizational unit](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#create_OU)  
  
-   [Create a user](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#create_a_user)  
  
-   [Create a group](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#create_group)  
  
###  <a name="create_OU"></a> Create an organizational unit  
 In this procedure, you create the Finance organizational unit \(OU\). This OU is the container that you use to store the two user objects and the group object that you will create later in this step.  
  
##### To create the Finance OU  
  
1.  Log on to the domain controller DC1 with Enterprise Admin or Domain Admin credentials.  
  
2.  Open the Active Directory Users and Computers snap\-in. To open Active Directory Users and Computers, click **Start**, click **Run**, and then type **dsa.msc.**  
  
3.  To create an OU, in the console tree, right\-click the domain object, **Fabrikam.com**, browse to **New**, and then click **Organizational Unit**.  
  
4.  In **Name**, type **Finance**, and then click **OK**.  
  
###  <a name="create_a_user"></a> Create a user  
 In the following procedure, you create a user, Arlene Huff.  
  
##### To create a user  
  
1.  Log on to the Windows Server 2008 domain controller DC1 with Enterprise Admin or Domain Admin credentials.  
  
2.  Open the Active Directory Users and Computers snap\-in. To open Active Directory Users and Computers, click **Start**, click **Run**, and then type **dsa.msc**.  
  
3.  In the console tree, right\-click the **Finance** OU, navigate to **New**, and then click **User**.  
  
4.  In **First Name**, type **Arlene**.  
  
     In **Last Name**, type **Huff**.  
  
     In **User logon name**, type **ahuff**, and then click **Next**.  
  
5.  In **Password**, type **p@ssword1**, type the same text in **Confirm password**, click **Next**, and then click **Finish**.  
  
###  <a name="create_group"></a> Create a group  
 In this procedure, you create a group object, G1, by using the Active Directory Users and Computers snap\-in. You also add a user, Arlene Huff, to the group.  
  
##### To create a group  
  
1.  Log on to the Windows Server 2008 domain controller DC1 with Enterprise Admin or Domain Admin credentials.  
  
2.  Open the Active Directory Users and Computers snap\-in. To open Active Directory Users and Computers, click **Start**, click **Run**, and then type **dsa.msc**.  
  
3.  In the console tree, right\-click the **Finance** OU, navigate to **New**, and then click **Group**.  
  
4.  In **Group name**, type **G1**, and then click **OK**.  
  
5.  Double\-click the group **G1**, and then click the **Members** tab.  
  
6.  Click **Add**. In **Enter the object names to select**, type **Arlene Huff**, and then click **OK** twice.  
  
##  <a name="use_ntdsutil_create_snapsho_stored_AD"></a> Step 2: Use Ntdsutil to create a snapshot of the data that is stored in AD DS  
 In this step you use the **ntdsutil** command to create a snapshot of the current data that is stored in AD DS. This snapshot contains the OU **Finance**; the two user objects **Ben Smith** and **Arlene Huff**; as well as the one group object **G1**, in which Arlene Huff is a member. Later, you will use this snapshot to aide in the data\-recovery process.  
  
#### To create a snapshot of the data that is stored in AD DS by using ntdsutil  
  
1.  Log on to the Windows Server 2008 domain controller DC1 with Enterprise Admin or Domain Admin credentials.  
  
2.  Click **Start**, right\-click **Command Prompt**, and then click **Run as administrator**.  
  
3.  If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
4.  At the elevated command prompt, type `ntdsutil`, and then press ENTER.  
  
5.  At the `ntdsutil` prompt, type `snapshot`, and then press ENTER.  
  
6.  At the `snapshot` prompt, type `activate instance ntds`, and then press ENTER.  
  
7.  At the `snapshot` prompt, type `create`, and then press ENTER.  
  
     The command returns the following output:  
  
     `Snapshot set {<GUID>} generated successfully.`  
  
8.  After you create the snapshot, type `quit` to return to the `ntdsutil` menu, and then type `quit` again to return to the command prompt.  
  
##  <a name="del_user_ADDS"></a> Step 3: Delete a user object from AD DS  
 In this procedure you delete the user Arlene Huff by using the Active Directory Users and Computers snap\-in.  
  
 Deleting a user with Active Directory Users and Computers does not completely delete the user from the Active Directory database. The user object becomes a tombstone object that is stripped of most of its attributes and back\-links. The object is not completely deleted until the tombstone lifetime is exceeded.  
  
 Later in this topic, you will restore the deleted user object and recover its group membership information.  
  
#### To delete a user object from AD DS  
  
1.  Log on to the Windows Server 2008 domain controller DC1 with Enterprise Admin or Domain Admin credentials.  
  
2.  Open the Active Directory Users and Computers snap\-in. To open Active Directory Users and Computers, click **Start**, click **Run**, type **dsa.msc**, and then click **OK**.  
  
3.  In the console tree, click the **Finance** OU, right\-click the name **Arlene Huff** in the details pane, and then click **Delete**.  
  
4.  When you see the message “Are you sure you want to delete the User named ‘Arlene Huff’,” click **Yes**.  
  
##  <a name="expose_data_in_ad_ds_snapshot"></a> Step 4: Expose the data in the AD DS snapshot  
 This step provides procedures for the following tasks:  
  
1.  [Mount the AD DS snapshot](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#mount_ad_ds_snapshot)  
  
2.  [Expose the AD DS snapshot as an LDAP server](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#expose_ad_ds_snapsho_LDAP_server)  
  
3.  [Access the Active Directory data that is stored in the snapshot](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#access_adds_data_in_snapshot)  
  
###  <a name="mount_ad_ds_snapshot"></a> Mount the AD DS snapshot  
 Before you restore a deleted user object in AD DS, you should do some investigational work to discover which container the user object is in as well as any associated back\-links, such as group membership.  
  
 To do this investigational work, you can mount and expose the data in the AD DS snapshot that you took in [Step 2: Use Ntdsutil to create a snapshot of the data that is stored in AD DS](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#use_ntdsutil_create_snapsho_stored_AD).  
  
 In the following procedure, you use the **ntdsutil** command to mount the snapshot so that you can later expose the data in the snapshot.  
  
##### To mount a snapshot of the data that is stored in AD DS by using ntdsutil  
  
1.  Log on to the Windows Server 2008 domain controller DC1 with Enterprise Admin or Domain Admin credentials.  
  
2.  Click **Start**, right\-click **Command Prompt**, and then click **Run as administrator**.  
  
3.  If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
4.  At the elevated command prompt, type `ntdsutil`, and then press ENTER.  
  
5.  At the `ntdsutil` prompt, type `snapshot`, and then press ENTER.  
  
6.  At the `snapshot` prompt, type `activate instance ntds`, and then press ENTER.  
  
7.  At the `snapshot` prompt, type `list all`, and then press ENTER.  
  
     This command lists the current snapshots of AD DS with a date and time stamp. For this exercise, you only see one snapshot in the list.  
  
8.  After you list the snapshot, at the `snapshot` prompt, type `mount 1`.  
  
     This mounts the snapshot as a virtual drive that you can now expose as a Lightweight Directory Access Protocol \(LDAP\) server.  
  
9. After you mount the snapshot, type `quit` to return to the `ntdsutil` menu, and then type `quit` again to return to the command prompt.  
  
###  <a name="expose_ad_ds_snapsho_LDAP_server"></a> Expose the AD DS snapshot as an LDAP server  
 In this task you expose the AD DS snapshot as an LDAP server. This makes it possible for you to view the data that is contained in the AD DS snapshot later.  
  
##### To expose the AD DS snapshot as an LDAP server  
  
1.  Log on to the Windows Server 2008 domain controller DC1 with Enterprise Admin or Domain Admin credentials.  
  
2.  Click **Start**, right\-click **Command Prompt**, and then click **Run as administrator**.  
  
3.  If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
4.  At the elevated command prompt, type the following command, and then press ENTER:  
  
     `dsamain <path_to_database_file> /ldapport <PortNumber>`  
  
     Because you are viewing the snapshot data on a domain controller, in `<PortNumber>` specify a port that is different from the port that the domain controller will use. For example, type the following, and then press ENTER:  
  
     `dsamain /dbpath C:\$SNAP_200902031438_VOLUMEC$\Windows\NTDS\ntds.dit /ldapport 51389`  
  
     You can obtain the value for the path to the database file `C:\$SNAP_200902031438_VOLUMEC$`, as shown in this example, by typing the `list all` command at the snapshot prompt after you mount the snapshot. You will append this value, `C:\$SNAP_200902031438_VOLUMEC$` with `Windows\NTDS\ntds.dit`. For more information about the `list all` command, see [Mount the AD DS snapshot](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#mount_ad_ds_snapshot).  
  
     A message indicates that the startup process for AD DS is complete.  
  
    > [!IMPORTANT]  
    >  Allow Dsamain.exe to continue running in the background to complete the next task, [Access the Active Directory data that is stored in the snapshot](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#access_adds_data_in_snapshot). If you close the command window in which Dsamain.exe is running, the next task will fail.  
  
###  <a name="access_adds_data_in_snapshot"></a> Access the Active Directory data that is stored in the snapshot  
 In this task you use the Active Directory Users and Computers snap\-in to view the Active Directory data that is stored in the snapshot. This opens a read\-only copy of the data that is stored in AD DS so that you can view the state of your Active Directory environment when the snapshot was taken.  
  
##### To access the Active Directory data that is stored in the snapshot  
  
1.  Log on to the Windows Server 2008 domain controller DC1 with Enterprise Admin or Domain Admin credentials.  
  
2.  Open the Active Directory Users and Computers snap\-in. To open Active Directory Users and Computers, click **Start**, click **Run**, and then type **dsa.msc**.  
  
3.  In the console tree, right\-click **Active Directory Users and Computers**, and then click **Change Domain Controller**.  
  
4.  Click **\<Type a Directory Server name\[:port\] here\>**, type **DC1:51389**, press ENTER, and then click **OK**.  
  
     **DC1** represents the name of the domain controller, and **51389** is the port that you used to expose the Active Directory data that is stored in the snapshot.  
  
5.  Expand **Fabrikam.com**, and then click the **Finance** OU.  
  
6.  Double\-click the user object **Arlene Huff**, and then click the **Member Of** tab.  
  
     By opening the **Member Of** property of the user **Arlene Huff**, you can see that the object was a member of the **Domain Users** and **G1** groups before it was deleted in [Step 3: Delete a user object from AD DS](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#del_user_ADDS). By default, user objects, including restored objects, are added to the Domain Users group. You must take note of any other groups that the user belonged to before the delete operation occurred so that you can add the user back to its appropriate group or groups. In this case, you note that the user object Arlene Huff is a member of the Domain Users group as well as the group G1. You can now add the user object Arlene Huff back to its group G1 after you restore the user object in AD DS.  
  
##  <a name="restore_del_ad_obj"></a> Step 5: Restore a deleted Active Directory object  
 This step provides procedures for the following tasks:  
  
1.  [Restore a deleted object by using LDP](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#restore_deleted_object_LDP)  
  
2.  [Restore a deleted object by using the Active Directory module](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#restore_deleted_obj_using_ADmodule)  
  
3.  [Add the user object to its appropriate group in AD DS](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#add_user_appr_ADDS_group)  
  
 In this procedure you use the LDP snap\-in \(Ldp.exe\) to search for and restore the deleted user object **Arlene Huff** to its original state, minus its group membership information.  
  
###  <a name="restore_deleted_object_LDP"></a> Restore a deleted object by using LDP  
 When Active Directory objects are deleted, they are placed in the Deleted Objects container. In the following procedure, you use the LDP snap\-in to restore the deleted object Arlene Huff from the Deleted Objects container to its original state, minus its group membership information.  
  
##### To use LDP to search for and restore a deleted Active Directory object  
  
1.  Log on to the Windows Server 2008 domain controller DC1 with Enterprise Admin or Domain Admin credentials.  
  
2.  Click **Start**, click **Run**, type **ldp.exe**, and then click **OK**.  
  
3.  Click **Connection**, and then click **Connect**.  
  
4.  Because you are logged on to the domain controller that hosts the forest root domain, click **OK**.  
  
5.  Click **Connection** again, and then click **Bind**.  
  
6.  Under **Bind type**, ensure that **Bind as currently logged on user** is selected, and then click **OK**.  
  
7.  Click **View**, and then click **Tree**. In **BaseDN**, type **DC\=Fabrikam,DC\=com**, and then click **OK**.  
  
8.  Click **Options**, and then click **Controls**. In the **Load Predefined** menu, click **Return Deleted Objects**, click **Check Out**, click **Check In**, and then click **OK**.  
  
9. In the console tree, expand **DC\=Fabrikam,DC\=com**, double\-click **CN\=Deleted Objects,DC\=Fabrikam,DC\=com**, and then double\-click **CN\=Arlene Huff\\0ADEL:{***objectGUID***},CN\=Deleted Objects,DC\=Fabrikam,DC\=com** to open the object properties.  
  
10. Right\-click **CN\=Arlene Huff\\0ADEL:***objectGUID***,CN\=Deleted Objects,DC\=Fabrikam,DC\=com**, and then click **Modify**.  
  
11. In the **Modify** dialog box, do the following:  
  
    1.  In **Edit Entry Attribute**, type **isDeleted**.  
  
    2.  Under **Operation**, click **Delete**, and then click **Enter**.  
  
    3.  Return to **Edit Entry Attribute**, and then type **distinguishedName**. \(If the text **isDeleted** is still present in the box, remove it.\)  
  
    4.  In the details pane, under **Dn: CN\=Arlene Huff\\0ADEL:***objectGUID***,CN\=Deleted Objects,DC\=Fabrikam,DC\=com**, copy the value for the **lastknownParent** attribute, and then paste it in **Values**. Amend this text with the **CN** of Arlene Huff, minus the mangled portion \(**\\0ADEL:***objectGUID*\) of the distinguished name, for example:  
  
         **CN\=Arlene Huff,OU\=Finance,DC\=Fabrikam,DC\=com**  
  
12. Under **Operation**, click **Replace**, click **Enter**, ensure that the **Extended** check box is selected, and then click **Run**. You will see a confirmation message.  
  
13. Click **Close** to close the **Modify** dialog box, and then minimize LDP.  
  
14. Open the Active Directory Users and Computers snap\-in. To open Active Directory Users and Computers, click **Start**, click **Run**, type **dsa.msc**, and then click **OK**.  
  
15. Click the **Finance** OU, and ensure that the user **Arlene Huff** is present.  
  
###  <a name="restore_deleted_obj_using_ADmodule"></a> Restore a deleted object by using the Active Directory module  
 In this procedure you use the [!INCLUDE[firstref_ad_powershell](../Token/firstref_ad_powershell_md.md)] to search for and restore the deleted object Arlene Huff from the Deleted Objects container to its original state, minus its group membership information.  
  
##### To restore a deleted object by using the Active Directory module  
  
1.  Log on to the Windows Server 2008 R2 domain controller DC2 with Enterprise Admin or Domain Admin credentials.  
  
2.  Click **Start**, **Administrative Tools**, and then click **Active Directory PowerShell**.  
  
3.  At the command prompt, type the following command, and then press ENTER:  
  
     `Get-ADObject –SearchBase “CN=Deleted Objects,DC=Fabrikam,DC=com” –Filter {lastKnownParent –eq “OU=Finance,DC=Fabrikam,DC=com”} –IncludeDeletedObjects | ft distinguishedName`  
  
     This command returns the distinguished name of all the objects in the Deleted Objects container whose **lastKnownParent** attribute is the **Finance** OU. You know the last known parent of Arlene Huff is the Finance OU as you mounted, exposed, and discovered this information when you did the investigative work to determine which container and group Arlene Huff belonged to.  
  
     In the command output, you can see that this portion, CN\=Arlene Huff\\0ADEL:4923acaa\-ce5f\-461c\-9f53\-944295713baa of the **distinguishedName** attribute for the user Arlene Huff is mangled:  
  
     `CN=Arlene Huff\0ADEL:4923acaa-ce5f-461c-9f53-944295713baa,CN=Deleted Objects,DC=Fabrikam,DC=com`  
  
     This indicates that the user object Arlene Huff is a deleted object.  
  
4.  To restore the object to its original state before the deletion occurred, type the following command at the command prompt:  
  
     `Get-ADObject -SearchBase "CN=Deleted Objects,DC=Fabrikam,DC=com" -filter {lastKnownParent -eq "OU=Finance,DC=Fabrikam,DC=com"} -IncludeDeletedObjects | Restore-ADObject -NewName "Arlene Huff" -TargetPath "OU=Finance,DC=Fabrikam,dc=com"`  
  
     When you run this command, `0ADEL:4923acaa-ce5f-461c-9f53-944295713baa`—the mangled portion of the distinguished name for the user object Arlene Huff, is removed and the object is now restored to its original state before it was deleted, minus its group membership information.  
  
###  <a name="add_user_appr_ADDS_group"></a> Add the user object to its appropriate group in AD DS  
 When you restore a tombstone object, the back\-links to that object, such as group membership, are stripped. In [Step 4: Expose the data in the AD DS snapshot](../Topic/End-to-End-Scenario-That-Uses-the-Active-Directory-Database-Mounting-Tool.md#expose_data_in_ad_ds_snapshot), you observed that the **memberOf** attribute of the user **Arlene Huff** indicates that she is member of the group **G1**.  
  
 In this procedure you add the user object **Arlene Huff** to the group **G1**, in which this user object was a member before it was deleted from AD DS.  
  
##### To add the user object to its appropriate group in AD DS  
  
1.  Log on to the Windows Server 2008 domain controller DC1 with Enterprise Admin or Domain Admin credentials.  
  
2.  Open the Active Directory Users and Computers snap\-in. To open Active Directory Users and Computers, click **Start**, click **Run**, and then type **dsa.msc**.  
  
3.  Expand **Fabrikam.com**, and then double\-click the **Finance** OU.  
  
4.  Double\-click the user object **Arlene Huff**, click the **Member of** tab, and then click **Add**.  
  
5.  In the **Select Groups** dialog box, type **G1** under **Enter the object names to select \(examples\)**, click **OK**, and then click **OK** again to exit the **Arlene Huff Properties** dialog box.  
  
  