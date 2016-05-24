---
title: Step 2: Restore a Deleted Active Directory Object
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 5644271e-2ad8-4dbc-94e6-a59ccc986cf2
author: Femila
---
# Step 2: Restore a Deleted Active Directory Object
This step provides instructions for completing the following tasks with Active Directory Recycle Bin:  
  
-   [Displaying the Deleted Objects container](#BKMK_1)  
  
-   [Restoring a deleted Active Directory object using Ldp.exe](#BKMK_2)  
  
-   [Restoring a deleted Active Directory object using the Get\-ADObject and Restore\-ADObject cmdlets](#BKMK_3)  
  
-   [Restoring multiple, deleted Active Directory objects](#BKMK_4)  
  
## <a name="BKMK_1"></a>Displaying the Deleted Objects container  
When Active Directory objects are deleted, they are placed in the Deleted Objects container. By default, the CN\=Deleted Objects container is not displayed. You can use the Ldp.exe administration tool in Active Directory Domain Services \(AD DS\) to display the Deleted Objects container.  
  
Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To display the Deleted Objects container  
  
1.  To open Ldp.exe, click **Start**, click **Run**, and then type **ldp.exe**.  
  
2.  On the **Options** menu, click **Controls**.  
  
3.  In the **Controls** dialog box, expand the **Load Predefined** pull\-down menu, click **Return deleted objects**, and then click **OK**.  
  
4.  To verify that the Deleted Objects container is displayed:  
  
    1.  To connect and bind to the server that hosts the forest root domain of your AD DS environment, under **Connections**, click **Connect**, and then **Bind**.  
  
    2.  Click **View**, click **Tree**, and in **BaseDN**, type **DC\=<mydomain>,DC\=<com>**, where **<mydomain>** and **<com>** represent the appropriate forest root domain name of your AD DS environment.  
  
    3.  In the console tree, double\-click the root distinguished name \(also known as DN\) and locate the **CN\=Deleted Objects, DC\=<mydomain>,DC\=<com>** container, where **<mydomain>** and **<com>** represent the appropriate forest root domain name of your AD DS environment.  
  
## <a name="BKMK_2"></a>Restoring a deleted Active Directory object using Ldp.exe  
You can use Ldp.exe to restore a single, deleted Active Directory object.  
  
> [!IMPORTANT]  
> You have to run Ldp.exe from an elevated command prompt to restore a deleted object.  
  
Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To restore a deleted Active Directory object using Ldp.exe  
  
1.  Open Ldp.exe from an elevated command prompt. [!INCLUDE[cmd_admin](../Token/cmd_admin_md.md)]  
  
2.  To connect and bind to the server that hosts the forest root domain of your AD DS environment, under **Connections**, click **Connect**, and then click **Bind**.  
  
3.  On the **Options** menu, click **Controls**.  
  
4.  In the Controls dialog box, expand the **Load Predefined** drop\-down list, click **Return Deleted Objects**, and then click **OK**.  
  
5.  In the console tree, navigate to the **CN\=Deleted Objects** container.  
  
6.  Locate and right\-click the deleted Active Directory object that you want to restore, and then click **Modify**.  
  
7.  In the **Modify** dialog box:  
  
    1.  In **Edit Entry Attribute**, type **isDeleted**.  
  
    2.  Leave the **Values** box empty.  
  
    3.  Under **Operation**, click **Delete**, and then click **Enter**.  
  
    4.  In **Edit Entry Attribute**, type **distinguishedName**.  
  
    5.  In **Values**, type the original distinguished name \(also known as DN\) of this Active Directory object.  
  
    6.  Under **Operation**, click **Replace**.  
  
    7.  Make sure that the **Extended** check box is selected, click **Enter**, and then click **Run**.  
  
> [!NOTE]  
> When you delete or recover an Active Directory object with link\-valued attributes, AD DS must process the object’s link value table to maintain referential integrity on the linked attribute’s values. Because deleting or recovering an Active Directory object results in modifications to the object’s link value table, if you attempt to delete or recover an object during its ongoing link\-value\-table processing time, the operation will be blocked. For example, if you use the Active Directory Recycle Bin to recover a deleted object with a large number of link\-valued attributes \(for example, a group object with 10 million users\) immediately after it was deleted \(or anytime throughout the duration of its link\-value\-table processing\), the object recovery will be blocked. \(If you are using Ldp.exe to perform the recovery, you might see the following error message: "Error 0x2093 The operation cannot continue because the object is in the process of being removed."\)  
  
## <a name="BKMK_3"></a>Restoring a deleted Active Directory object using the Get\-ADObject and Restore\-ADObject cmdlets  
You can also restore a deleted Active Directory object by using the **Get\-ADObject** and **Restore\-ADObject** [!INCLUDE[firstref_ad_powershell](../Token/firstref_ad_powershell_md.md)] cmdlets. The recommended approach is to use the **Get\-ADObject** cmdlet to retrieve the deleted object and then pass that object through the pipeline to the **Restore\-ADObject** cmdlet.  
  
#### To restore a single, deleted Active Directory object using the Get\-ADObject and Restore\-ADObject cmdlets  
  
1.  Click **Start**, click **Administrative Tools**, right\-click [!INCLUDE[shortcut_ad_powershell](../Token/shortcut_ad_powershell_md.md)], and then click **Run as administrator**.  
  
2.  At the `Active Directory module for Windows PowerShell` command prompt, type the following command, and then press ENTER:  
  
    `Get-ADObject -Filter {String} -IncludeDeletedObjects | Restore-ADObject`  
  
    For example, if you want to restore an accidentally deleted user object with the display name Mary, type the following command, and then press ENTER:  
  
    `Get-ADObject -Filter {displayName -eq "Mary"} -IncludeDeletedObjects | Restore-ADObject`  
  
For more information about the **Get\-ADObject** and **Restore\-ADObject** cmdlets, at the `Active Directory module for Windows PowerShell` command prompt, type **Get\-Help Get\-ADObject** or **Get\-Help Restore\-ADObject**, and then press ENTER.  
  
## <a name="BKMK_4"></a>Restoring multiple, deleted Active Directory objects  
Consider the following scenario: An administrator at Contoso.com accidentally deletes a nested organizational unit \(OU\) called Finance\_Department, which contains user accounts for employees in the Finance department. The administrator deletes another OU called Admins, which contains user accounts for administrative assistants that work for the Finance department. Brian and Mary are user accounts in the Finance\_Department OU. Tom is a user account in the Admins OU. The following illustration shows the Finance\_Department OU.  
  
![](../Image/OU_FinanceDepartment.gif)  
  
When the Finance\_Department OU is deleted, all its objects \(a total of five objects\) are moved to the Deleted Objects container, with their distinguished names mangled. The Deleted Objects container displays all logically deleted objects in a flat hierarchy as its direct children. The recommended approach to restoring a nested OU to its original state is to use the **Get\-ADObject** [!INCLUDE[nextref_ad_powershell](../Token/nextref_ad_powershell_md.md)] cmdlet to retrieve the deleted objects one hierarchy level at a time and then to pass those objects through the pipeline to the **Restore\-ADObject** cmdlet. If the administrator is not familiar with the original hierarchy of the Finance\_Department OU, the administrator must first use the **Get\-ADOBject** cmdlet to perform several investigation steps:  
  
-   For example, the administrator decides to search for the user account Mary with the **Get\-ADOBject** cmdlet, using the **msDS\-lastKnownRDN** attribute in the **ldapFilter** parameter and constructing the command so that the **lastKnownParent** attribute of Mary is returned, as follows:  
  
    `Get-ADObject -SearchBase "CN=Deleted Objects,DC=contoso,DC=com" -ldapFilter:"(msDs-lastKnownRDN=Mary)" –IncludeDeletedObjects –Properties lastKnownParent`  
  
    In the output that the **Get\-ADObject** cmdlet returns, the administrator notices that the value for **lastKnownParent** of Mary is **Finance\_Department**. The administrator also notices that the distinguished name of the Finance\_Department OU is mangled, which indicates that the Finance\_Department OU object itself is deleted. \(An example of a mangled distinguished name is OU\=Finance\_Department\\0ADEL:e954edda\-db8c\-41be\-bbbd\-599bef5a5f2a,CN\=Deleted Objects,DC\=contoso,DC\=com.\)  
  
-   The administrator then decides to search for all the objects in the Deleted Objects container whose **lastKnownParent** value is **Finance\_Department**, using the following command:  
  
    `Get-ADObject –SearchBase "CN=Deleted Objects,DC=contoso,DC=com" -Filter {lastKnownParent -eq 'OU=Finance_Department\\0ADEL:e954edda-db8c-41be-bbbd-599bef5a5f2a,CN=Deleted Objects,DC=contoso,DC=com'} -IncludeDeletedObjects -Properties lastKnownParent | ft`  
  
    > [!NOTE]  
    > Make sure that you escape the slash \(\\\) in the mangled distinguished name that is used in the **Get\-ADObject** cmdlet with another slash.  
  
    In the output that the **Get\-ADObject** cmdlet returns, the administrator notices that **Admins** is an OU itself.  
  
-   The administer further searches for all the deleted objects with a **lastKnownParent** attribute equal to **Admins**, using the following command:  
  
    `Get-ADObject –SearchBase "CN=Deleted Objects,DC=contoso,DC=com" -Filter {lastKnownParent -eq 'OU=Admins\\0ADEL:6b405c87-027c-4135-95af-36c31002be5a,CN=Deleted Objects,DC=contoso,DC=com'} -IncludeDeletedObjects -Properties lastKnownParent | ft`  
  
    > [!NOTE]  
    > Make sure that you escape the slash \(\\\) in the mangled distinguished name that is used in the **Get\-ADObject** cmdlet with another slash.  
  
    In the output that the **Get\-ADObject** cmdlet returns, the administrator finds the user account **Tom**.  
  
-   In [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], deleted nested objects must be restored from the highest level of their hierarchy to a live parent. Therefore, the Finance\_Department OU object must be restored first. Because all previous investigation steps were performed using the **lastKnownParent** attribute, which points to the direct parent of the object and does not indicate whether the next parent object is also deleted, as a check the administrator can verify that the value of **lastKnownParent** for Finance\_Department is indeed a live OU by running the following command:  
  
    `Get-ADObject -SearchBase "CN=Deleted Objects,DC=contoso,DC=com" -ldapFilter:"(msDs-lastKnownRDN=Finance_Department)" –IncludeDeletedObjects –Properties lastKnownParent`  
  
    This concludes the investigation and the administrator is ready to restore the Finance\_Department OU to its original hierarchy and state.  
  
> [!IMPORTANT]  
> It is critical to begin restoring objects from the highest level of the hierarchy because deleted objects must be restored to a live parent.  
  
To restore the Finance\_Department OU, the administrator can perform the following procedure.  
  
#### To restore the Finance\_Department OU  
  
1.  Click **Start**, click **Administrative Tools**, right\-click [!INCLUDE[shortcut_ad_powershell](../Token/shortcut_ad_powershell_md.md)], and then click **Run as administrator**.  
  
2.  Restore the Finance\_Department OU by running the following command at the [!INCLUDE[shortcut_ad_powershell](../Token/shortcut_ad_powershell_md.md)] prompt:  
  
    `Get-ADObject -ldapFilter:"(msDS-LastKnownRDN=Finance_Department)" –IncludeDeletedObjects | Restore-ADObject`  
  
3.  Restore the user accounts Brian and Mary and the Admins OU \(the direct children of the Finance\_Department OU whose distinguished name was restored to OU\=Finance\_Department,DC\=contoso,DC\=com in the previous step\) by running the following command at the [!INCLUDE[shortcut_ad_powershell](../Token/shortcut_ad_powershell_md.md)] prompt:  
  
    `Get-ADObject -SearchBase "CN=Deleted Objects,DC=contoso,DC=com" -Filter {lastKnownParent -eq "OU=Finance_Department,DC=contoso,DC=com"} -IncludeDeletedObjects | Restore-ADObject`  
  
4.  Restore the user account Tom \(the direct child of the Admins OU whose distinguished name was restored to OU\=Admins,OU\=Finance\_Department,DC\=contoso,DC\=com in the previous step\) by running the following command at the [!INCLUDE[shortcut_ad_powershell](../Token/shortcut_ad_powershell_md.md)] prompt:  
  
    `Get-ADObject -SearchBase "CN=Deleted Objects,DC=contoso,DC=com" -Filter {lastKnownParent -eq "OU=Admins,OU=Finance_Department,DC=contoso,DC=com"} -IncludeDeletedObjects | Restore-ADObject`  
  
For more information about the **Get\-ADObject** and **Restore\-ADObject** cmdlets, at the [!INCLUDE[shortcut_ad_powershell](../Token/shortcut_ad_powershell_md.md)] command prompt, type **Get\-Help Get\-ADObject** or **Get\-Help Restore\-ADObject**.  
  
For a sample Windows PowerShell script that you can use to restore a deleted tree of Active Directory objects, see [Appendix B: Restore Multiple, Deleted Active Directory Objects &#40;Sample Script&#41;](../Topic/Appendix-B--Restore-Multiple,-Deleted-Active-Directory-Objects--Sample-Script-.md).  
  
