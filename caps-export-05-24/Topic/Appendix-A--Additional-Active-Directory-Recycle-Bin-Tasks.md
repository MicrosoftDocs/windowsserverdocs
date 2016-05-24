---
title: Appendix A: Additional Active Directory Recycle Bin Tasks
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: dcf3431a-c562-447f-a591-4742d2bcdbfa
author: Femila
---
# Appendix A: Additional Active Directory Recycle Bin Tasks
In addition to recovering a single deleted Active Directory object, there are several additional tasks that you can perform with Active Directory Recycle Bin in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]:  
  
-   [Modifying the tombstone lifetime and deleted object lifetime](#BKMK_1)  
  
-   [Delegating Active Directory Recycle Bin operations](#BKMK_3)  
  
-   [Manually recycling a deleted Active Directory object](#BKMK_4)  
  
-   [Using the auditing mechanism](#BKMK_5)  
  
## <a name="BKMK_1"></a>Modifying the tombstone lifetime and deleted object lifetime  
Depending on your system environment and business practices, you can increase or decrease the deleted object lifetime and the tombstone lifetime. If you want your deleted objects to be recoverable for longer than the default 180 days, you can increase the deleted object lifetime. If you want your recycled objects to be recoverable \(through authoritative restore\) for longer than the default 180 days, you can also increase the tombstone lifetime.  
  
The tombstone lifetime is determined by the value of the **tombstoneLifetime** attribute. The deleted object lifetime is determined by the value of the **msDS\-deletedObjectLifetime** attribute. By default, **tombstoneLifetime** is set to null. When **tombstoneLifetime** is set to null, the tombstone lifetime defaults to 60 days \(hard\-coded in the system\). By default, **msDS\-deletedObjectLifetime** is also set to null. When **msDS\-deletedObjectLifetime** is set to null, the deleted object lifetime is set to the value of the tombstone lifetime.  
  
> [!NOTE]  
> If the tombstoneLifetime value is empty, the tombstone lifetime is 60 days. If the value is not empty, the tombstone lifetime is the value specified. If the value is less than 3 days, the tombstone lifetime is 3 days.  
  
You can modify the values of the **tombstoneLifetime** and **msDS\-deletedObjectLifetime** attributes anytime by using the **Set\-ADObject** cmdlet in the [!INCLUDE[firstref_ad_powershell](../Token/firstref_ad_powershell_md.md)] \(the recommended method\) or by using the Ldp.exe administrative tool.  
  
Membership in **Enterprise Admins**, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To modify the tombstone lifetime by using the Set\-ADObject cmdlet  
  
1.  Click **Start**, click **Administrative Tools**, right\-click [!INCLUDE[shortcut_ad_powershell](../Token/shortcut_ad_powershell_md.md)], and then click **Run as administrator**.  
  
2.  At the `Active Directory module for Windows PowerShell` command prompt, type the following command, and then press ENTER:  
  
    `Set-ADObject -Identity “CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=<mydomain>,DC=<com>” –Partition “CN=Configuration,DC=<mydomain>,DC=<com>” –Replace:@{“tombstoneLifetime” = <value>}`  
  
    Replace `DC=<mydomain>,DC=<com>` with the appropriate forest root domain name of your Active Directory environment, and replace `<value>` with the new value for the tombstone lifetime.  
  
    For example, to set **tombstoneLifetime** to 365 days, run the following command:  
  
    `Set-ADObject -Identity “CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=contoso,DC=com” –Partition “CN=Configuration,DC=contoso,DC=com” –Replace:@{“tombstoneLifetime” = 365}`  
  
For more information about the **Set\-ADObject** cmdlet, at the `Active Directory module for Windows PowerShell` command prompt, type **Get\-Help Set\-AdObject**, and then press ENTER.  
  
#### To modify the tombstone lifetime by using Ldp.exe  
  
1.  To open Ldp.exe, click **Start**, click **Run**, and then type **ldp.exe**.  
  
2.  To connect and bind to the server that hosts the forest root domain of your Active Directory environment, under **Connections**, click **Connect**, and then click **Bind**.  
  
3.  In the console tree, right\-click the **CN\=Directory Service,CN\=Windows NT,CN\=Services,CN\=Configuration** container, and then click **Modify**.  
  
4.  In the **Modify** dialog box, in **Edit Entry Attribute**, type **tombstoneLifetime**.  
  
5.  In the **Modify** dialog box, in **Values**, type the number of days that you want to set for the tombstone lifetime value. \(The minimum is 3 days.\)  
  
6.  In the **Modify** dialog box, under **Operation** click **Replace**, click **Enter**, and then click **Run**.  
  
#### To modify the deleted object lifetime by using the Set\-ADObject cmdlet  
  
1.  Click **Start**, click **Administrative Tools**, right\-click [!INCLUDE[shortcut_ad_powershell](../Token/shortcut_ad_powershell_md.md)], and then click **Run as administrator**.  
  
2.  At the `Active Directory module for Windows PowerShell` command prompt, type the following command, and then press ENTER:  
  
    `Set-ADObject -Identity “CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=<mydomain>,DC=<com>” –Partition “CN=Configuration,DC=<mydomain>,DC=<com>” –Replace:@{“msDS-DeletedObjectLifetime” = <value>}`  
  
    Replace `DC=<mydomain>,DC=<com>` with the appropriate forest root domain name of your Active Directory environment, and replace `<value>` with the new value of the deleted object lifetime.  
  
    For example, to set the deleted object lifetime to 365 days, run the following command:  
  
    `Set-ADObject -Identity “CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=contoso,DC=com” –Partition “CN=Configuration,DC=contoso,DC=com” –Replace:@{“msDS-DeletedObjectLifetime” = 365}`  
  
For more information about the **Set\-ADObject** cmdlet, at the `Active Directory module for Windows PowerShell` command prompt, type **Get\-Help Set\-AdObject**, and then press ENTER.  
  
#### To modify the deleted object lifetime by using Ldp.exe  
  
1.  To open Ldp.exe, click **Start**, click **Run**, and then type **ldp.exe**.  
  
2.  To connect and bind to the server hosting the forest root domain of your Active Directory environment, under **Connections**, click **Connect**, and then click **Bind**.  
  
3.  In the console tree, right\-click the **CN\=Directory Service,CN\=Windows NT,CN\=Services,CN\=Configuration** container, and then click **Modify**.  
  
4.  In the **Modify** dialog box, in **Edit Entry Attribute**, type **msDS\-DeletedObjectLifeTime**.  
  
5.  In the **Modify** dialog box, in **Values**, type the number of days that you want to set for the tombstone lifetime value. \(The minimum is 3 days.\)  
  
6.  In the **Modify** dialog box, under **Operation** click **Replace**, click **Enter**, and then click **Run**.  
  
## <a name="BKMK_3"></a>Delegating Active Directory Recycle Bin operations  
In addition to using the Active Directory Recycle Bin themselves, administrators can delegate the following operations to selected users:  
  
-   Deleting an Active Directory object  
  
-   Viewing a deleted Active Directory object  
  
-   Viewing a deleted Active Directory object’s deactivated links  
  
-   Viewing tombstone Active Directory objects  
  
-   Recovering a deleted Active Directory object  
  
-   Manually recycling a deleted Active Directory object  
  
-   Managing optional Active Directory Recycle Bin features  
  
The following table outlines the access control mechanisms \(ACMs\) and the default permission levels that are required for each task that an administrator can delegate.  
  
|Task|Access control mechanism|Default permission level|  
|--------|----------------------------|----------------------------|  
|Deleting objects|Delete ACMs|Domain Administrators|  
|Viewing deleted objects|Read ACMs and showDeletedObjects Lightweight Directory Access Protocol \(LDAP\) control and List Content and Read Property rights on the Deleted Objects container **Note:** You might need to take ownership of the Deleted Objects container in order to grant these permissions. For example, to take ownership of the Deleted Objects container using dsacls.exe, type:`dsacls "CN=Deleted Objects,DC=Contoso,DC=com" /takeownership`To grant List Content and Read Property rights on the Deleted Objects container, type:`dsacls "CN=Deleted Objects,DC=Contoso,DC=com" /G CONTOSO\EricLang:LCRP`For more information, see [View or Set Permissions on a Directory Object](http://technet.microsoft.com/library/cc816824(WS.10).aspx).|Domain Users|  
|Viewing deactivated links|Read ACMs and showDeactivatedLinks LDAP control|Domain Users|  
|Viewing tombstones|Read ACMs and showTombstoneObjects LDAP control|Domain Users|  
|Recovering deleted objects|Write ACMs \(on the object\) and reanimate\-tombstone control access right \(CAR\) \(on the naming context \(NC\)\)|Domain Administrators|  
|Recycling deleted objects|Write ACMs \(on the object\) and reanimate\-tombstone CAR \(on the NC\)|Domain Administrators|  
|Managing optional features|Manage\-optional\-features CAR \(on the target object\)|Domain Administrators|  
  
For more information about how to delegate rights in an Active Directory environment, see the following:  
  
-   Best Practices for Delegating Active Directory Administration \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=125454](http://go.microsoft.com/fwlink/?LinkID=125454)\)  
  
-   Delegating Authority in Active Directory \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=125455](http://go.microsoft.com/fwlink/?LinkID=125455)\)  
  
-   Article 281146 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=125457](http://go.microsoft.com/fwlink/?LinkID=125457)\)  
  
## <a name="BKMK_4"></a>Manually recycling a deleted Active Directory object  
All deleted Active Directory objects are recycled automatically when their deleted object lifetimes expire. In addition, administrators can recycle deleted Active Directory objects manually.  
  
Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To manually recycle a deleted Active Directory object  
  
1.  To open Ldp.exe, click **Start**, click **Run**, and then type **ldp.exe**.  
  
2.  To connect and bind to the server that hosts the forest root domain of your AD DS environment, under **Connections**, click **Connect**, and then click **Bind**.  
  
3.  In the console tree, navigate to the **CN\=Deleted Objects** container.  
  
4.  Right\-click the deleted Active Directory object that you want to recycle, and then click **Delete**.  
  
5.  In the **Delete** dialog box, make sure that the **Extended** check box is checked, and then click **OK**.  
  
6.  To verify that the deleted Active Directory object is now recycled:  
  
    1.  In the **Controls** dialog box, on the **Load Predefined** menu, click **Return recycled objects**, and then click **OK**.  
  
    2.  In the console tree, navigate to the **CN\=Deleted Objects** container, and then double\-click the deleted Active Directory object that you recycled.  
  
    3.  In the details pane, verify that the **isRecycled** attribute on this object is set to **TRUE**.  
  
## <a name="BKMK_5"></a>Using the auditing mechanism  
In [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], as in Windows Server 2008, you can use the Active Directory Domain Services \(AD DS\) auditing mechanism with the **Directory Service Changes** audit policy to log old and new values when changes are made to Active Directory objects and their attributes. We recommend that you implement auditing in your Active Directory environment to track all object deletions, object deletion times, and the account names that perform these object deletions. For more information, see the AD DS Auditing Step\-by\-Step Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=125458](http://go.microsoft.com/fwlink/?LinkID=125458)\).  
  
