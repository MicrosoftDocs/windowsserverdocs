---
title: Grant the Allowed to Authenticate Permission on Computers in the Trusting Domain or Forest
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 440b5104-bb09-475d-b4fe-61a11f24312b
author: Femila
---
# Grant the Allowed to Authenticate Permission on Computers in the Trusting Domain or Forest
  For users in a trusted [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or Windows Server 2003 domain or forest to be able to access resources in a trusting [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or Windows Server 2003 domain or forest where the trust authentication setting has been set to selective authentication, each user must be explicitly granted the **Allowed to Authenticate** permission on the security descriptor of the computer objects \(resource computers\) that reside in the trusting domain or forest. For more information about how the **Allowed to Authenticate** permission works, see Security Considerations for Trusts in the Windows Server 2003 Technical Reference \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=35413](http://go.microsoft.com/fwlink/?LinkId=35413)\).  
  
> [!NOTE]  
>  The **Allowed to Authenticate** permission can be set on computer objects that represent member servers running Windows NT Server 4.0, Windows 2000 Server, Windows Server 2003, and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
 You can use this procedure and the Active Directory Users and Computers snap\-in from the trusting domain to enable access to resources over an external trust or forest trust that is set to selective authentication.  
  
 By default, members of Account Operators, Domain Admins, or Enterprise Admins in Active Directory Domain Services \(AD DS\) can perform this procedure. The minimum equivalent permission required to complete this procedure is having the **Modify Permission** permission on the computer object\(s\). For more information about permission, see [How Permissions Work](http://technet.microsoft.com/library/cc783530(v=ws.10).aspx).  
  
### To grant the Allowed to Authenticate permission on computers in the trusting domain or forest  
  
1.  Open Active Directory Users and Computers.  
  
2.  Under **View**, ensure that **Advanced Features** is selected.  
  
3.  In the console tree, click the **Computers** container or the container where your computer objects reside.  
  
4.  Right\-click the computer object that you want users in the trusted domain or forest to access, and then click **Properties**.  
  
5.  On the **Security** tab, do one of the following:  
  
    -   In **Group or user names**, click the user names or group names for which you want to grant access to this computer, select the **Allow** check box next to the **Allowed to Authenticate** permission, and then click **OK**.  
  
    -   Click **Add**. In **Enter the object names to select**, type the name of the user object or group object for which you want to grant access to this resource computer, and then click **OK**. Select the **Allow** check box next to the **Allowed to Authenticate** permission, and then click **OK**.  
  
  