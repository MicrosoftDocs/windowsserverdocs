---
title: Configure Role Based Access Control
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e83cec88-2825-48b5-b4ed-3621e1f81921
---
# Configure Role Based Access Control
[Checklist: Assign Roles](../Topic/Checklist--Assign-Roles.md) > [Configure IPAM Server Roles](../Topic/Configure-IPAM-Server-Roles.md) > **Configure Role Based Access Control**  
  
> [!IMPORTANT]  
> Procedures in this topic only apply to IPAM in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
Role based access control enables you to configure detailed control of the procedures that IPAM users are able to perform. To configure these settings:  
  
1.  **Specify a user role**: Configure a new role, use an existing custom role, or use a default role.  
  
2.  **Specify an access scope**: Configure a new access scope, use an existing custom access scope, or use the Global access scope.  
  
3.  **Specify an access policy**: Configure a new access policy or modify an existing access policy.  
  
If you are using role\-based access control for users that are already members of one or more local IPAM security groups, it is important to understand that role based access control can only add permissions to the user’s existing access permissions. You cannot deny permission for a user with an access policy. If a user already has permission granted to perform a procedure because they are a member of one or more IPAM administrator groups, they will continue to have that permission even if they have only limited rights granted by role based access polices.  
  
For more information about role\-based access control, see [Access Control](../Topic/Access-Control.md).  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Configuring role based access control  
Use the following procedures to assign IPAM administrator roles using built\-in local security groups on the IPAM server:  
  
### <a name="scope_of_discovery"></a>To configure role based access control  
  
1.  First, specify a user role.  
  
2.  ###### To specify a user role  
3.  1.  On the IPAM server, click **ACCESS CONTROL** in the upper navigation pane, and click **Roles** in the lower navigation pane. A list of existing roles is shown in the display pane.  
  
    2.  Click an existing role to view the allowed operations that are associated to the role. The allowed operations are displayed in the details view, located under the list of roles.  
  
    3.  If you will use one of the existing roles, it is not necessary to create a new role and you can skip to the next section of this procedure to specify an access scope.  
  
    4.  If you wish to modify an existing role, right\-click the name of the role and then click **Edit Role**. Note: You cannot edit the default roles.  
  
    5.  If you wish to create a new role, right\-click **Roles** and then click **Add User Role**.  
  
    6.  In the **Add or Edit Role** dialog box, type a name for the role. Also type a description for the role if desired.  
  
        > [!NOTE]  
        > An issue entering spaces in the name and description fields has been identified. To enter a text string with spaces, first enter a string without spaces. Spaces can then be inserted into the text string.  
  
    7.  Specify one or more operations that the user role will be allowed to perform by selecting the check box next to the action. To specify all operations in a category, select the checkbox next to that category.  
  
    8.  Click **OK** when you are finished specifying allowed operations for this user role.  
4.  Next, specify an access scope.  
  
5.  ###### To specify an access scope  
6.  1.  On the IPAM server, click **ACCESS CONTROL** in the upper navigation pane, and click **Access Scopes** in the lower navigation pane. A list of existing access scopes is shown in the display pane.  
  
    2.  Click an existing access scope to display details for this access scope in the details view.  
  
    3.  If you will use one of the existing access scopes, it is not necessary to create a new access scope and you can skip to the next section of this procedure to specify an access policy.  
  
    4.  If you wish to modify the name or description of an existing access scope, right\-click the name of the access scope and then click **Edit Access Scope**. Note: You cannot edit the Global access scope, and you cannot modify the path of an existing access scope.  
  
    5.  If you wish to create a new access scope, right\-click **Access Scopes** and then click **Add Access Scope**.  
  
    6.  In the **Add Access Scope** dialog box, under **Select the parent access scope**, click the parent location for the path of your access scope and then click **New**.  
  
    7.  Type a name and optional description for your new access scope. You can also change the parent access scope if you have not yet clicked **Add**.  
  
        > [!NOTE]  
        > An issue entering spaces in the name and description fields has been identified. To enter a text string with spaces, first enter a string without spaces. Spaces can then be inserted into the text string.  
  
    8.  Click **Add** to complete adding your new access scope.  
  
    9. Click **New** again to add additional access scopes, or click **OK** to finish.  
  
    10. To delete an access scope, return to the Access Scopes view, right\-click the name of the access scope, and click **Delete**. Deleting a parent access scope will also delete all child access scopes. You cannot delete the Global access scope.  
7.  Finally, specify an access policy.  
  
8.  ###### To specify an access policy  
9. 1.  On the IPAM server, click **ACCESS CONTROL** in the upper navigation pane, and click **Access Policies** in the lower navigation pane. A list of existing access policies is shown in the display pane.  
  
    2.  Click an existing access scope to display details for this access policy in the details view, including the access settings for this access policy.  
  
    3.  If you will use one of the existing access policies, it is not necessary to create a new access policy. However, you cannot modify the user alias for an existing access policy, you can only add, remove, or modify the role and scope for the policy.  
  
    4.  If you wish to create a new access policy, right\-click **Access Policies** and then click **Add Access Policy**.  
  
    5.  In the **Add Access Policy** dialog box, under **User Settings**, click **Add**, enter a user or group name, and then click **OK**. Note: The default location is the local computer. To add a user or group from Active Directory, click **Locations**, and then specify the Active Directory location or specify **Entire Directory**.  
  
    6.  Under **Access Settings**, click **New**.  
  
    7.  Under **New Setting**, use the drop\-down list under **Select role** to choose a role for this user.  
  
    8.  Click **New** again to add additional access scopes, or click **OK** to finish.  
  
    9. Under **Select the access scope for the role**, click the name of the access scope you wish to use, and then click **Add Setting**.  
  
    10. Multiple access settings can be entered for this access policy. To add additional roles and access scopes for this user, click **New** and repeat the previous two steps.  
  
    11. Click **OK** when you are finished configuring the access policy.  
  
## See Also  
[IPAM Server](../Topic/IPAM-Architecture.md#server)  
  
