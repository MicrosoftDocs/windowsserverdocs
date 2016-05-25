---
title: Access Control
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c0570054-7c89-4e7a-9115-b26d876dcdcd
---
# Access Control
This topic contains information and procedures you can use to configure role based access control in IPAM. Role based access control is new in IPAM in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. You cannot configure role based access control on an IPAM server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
Also see [Configure Role Based Access Control](../Topic/Configure-Role-Based-Access-Control.md) in the IPAM deployment guide.  
  
Role based access control is comprised of roles, access scopes, and access policies:  
  
-   **Roles**: A role is a collection of IPAM operations. You can associate a role with a user or group in Windows using an access policy. Several built\-in roles are provided, but you can also create customized roles to meet your business requirements.  
  
-   **Access scopes**: An access scope determines the objects that a user has access to. You can use access scopes to define administrative domains in IPAM. For example, you might create access scopes based on geographical location. By default, IPAM includes an access scope of Global. All other access scopes are subsets of the Global access scope. Users or groups that are assigned to the Global access scope have access to all objects in IPAM that are permitted by their assigned role.  
  
-   **Access policies**: An access policy combines a role with an access scope to assign permission to a user or group. For example, you might define an access policy for user1 with a role of IP Block Admin and an access scope of Global\\Asia. Therefore, user1 will have permission to edit and delete IP address blocks that are associated to the Asia access scope. This user will not have permission to edit or delete any other IP address blocks in IPAM.  
  
> [!IMPORTANT]  
> Access control settings add permissions for an IPAM user or administrator to their existing set of permissions. You cannot deny permissions for a user or administrator using access control. For example, if a user is a member of the IPAM Administrators group on the local IPAM server, then they will have unrestricted access to IPAM and any access control settings that are configured will not affect this user.  
  
## Configure access control  
The following is an example of how to configure a new user role, access scope, and access policy. After configuring an access policy, verify that the user only has permissions that are assigned using these settings. You must have at least one DHCP scope and IPAM user account available to test the access control settings.  
  
1.  [Create new user role named DHCP Scope Editor with only Edit DHCP Scope permission](../Topic/Access-Control.md#create_role)  
  
2.  [Create a new access scope under the Global access scope](../Topic/Access-Control.md#create_access_scope)  
  
3.  [Set the access scope on a DHCP Scope](../Topic/Access-Control.md#assign_scope)  
  
4.  [Create an access policy for a user and assign the DHCP Scope Editor role for the custom access scope](../Topic/Access-Control.md#create_policy)  
  
5.  [Sign in on the IPAM server with the user account and verify that this user is only able to perform the operations assigned by the DHCP Scope Editor role and only on the specified DHCP scope](../Topic/Access-Control.md#test_policy)  
  
### <a name="create_role"></a>Create new user role named DHCP Scope Editor with only Edit DHCP Scope permission  
  
1.  Click **ACCESS CONTROL**, right\-click **Roles**, and then click **Add User Role**.  
  
2.  Type **DHCP Scope Editor** next to **Name**.  
  
3.  Expand **DHCP scope operations** to view the list of all available operations.  
  
4.  Select only the **Edit DHCP scope** operation, and then click **OK**.  
  
### <a name="create_access_scope"></a>Create a new access scope under the Global access scope  
  
1.  Right\-click **Access Scopes** and then click **Add Access Scope**.  
  
2.  Click **New**, type a name for the access scope next to **Name**, click **Add**, and then click **OK**.  
  
### <a name="assign_scope"></a>Set the access scope on a DHCP Scope  
  
1.  Click **DHCP Scopes**, right\-click a DHCP scope, and then click **Set Access Scope**.  
  
2.  Clear the **Inherit access scope** from parent checkbox.  
  
3.  Click the access scope you created under **Global**, and then click **OK**.  
  
4.  Verify that **\\Global\\<access scope>** is displayed under **Access Scope**.  
  
### <a name="create_policy"></a>Create an access policy for a user and assign the DHCP Scope Editor role for the custom access scope  
  
1.  Click **ACCESS CONTROL**, right\-click **Access Policies**, and then click **Add Access Policy**.  
  
2.  Click **Add**, type **<domain>\\<user>**, for example: *contoso\\user1*, and then click **OK**.  
  
    > [!TIP]  
    > If you didn’t create a user account to test, create it before proceeding. You must be able to sign in with this account’s credentials.  
  
3.  Under **Access Settings**, click **New**.  
  
4.  Under **Select role**, choose **DHCP Scope Editor**.  
  
5.  Under **Select the access scope for the role**, click the access scope you created, click **Add Setting**, verify that the new role and access scope is displayed under **Access Settings**, and then click **OK**.  
  
### <a name="test_policy"></a>Sign in on the IPAM server with the user account and verify that this user is only able to perform the operations assigned by the DHCP Scope Editor role and only on the specified DHCP scope  
  
1.  Sign out or switch users on the IPAM server, and then sign in with the user account that was assigned access control settings.  
  
2.  Launch Server Manager and click **IPAM**.  
  
3.  Click **DHCP Scopes**, right\-click a scope that is not a member of the access scope permitted by the access policy that you created, for example *\\Global* , and then click **Edit DHCP Scope**.  
  
4.  Change the **Scope name** and then click OK.  
  
5.  Review the error message displayed. Under **Details**, a message is displayed indicating that the user does not have privileges to perform this action. Click **Cancel**.  
  
6.  Right\-click a DHCP scope that is a member of the access scope granted to the user account, and then click **Edit DHCP Scope**.  
  
7.  Change the **Scope name** and then click **OK**.  
  
8.  Verify that the operation is successful.  
  
9. Sign out and then sign in again with IPAM Administrator privileges.  
  
## See also  
[Walkthrough: Demonstrate IPAM in Windows Server 2012 R2](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012-R2.md)  
  
