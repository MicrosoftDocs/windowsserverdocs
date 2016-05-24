---
title: Create a User Role for Access Control
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ae6a42db-a104-401b-a8e6-b85c47d30b46
---
# Create a User Role for Access Control
You can use this topic to create a new Access Control user role in the IPAM client console.  
  
Membership in **Administrators**, or equivalent, is the minimum required to perform this procedure.  
  
> [!NOTE]  
> After you create a role, you can create an access policy to assign the role to a specific user or Active Directory group. For more information, see [Create an Access Policy](../Topic/Create-an-Access-Policy.md).  
  
### To create a role  
  
1.  In Server Manager, click  **IPAM**. The IPAM client console appears.  
  
2.  In the navigation pane, click **ACCESS CONTROL**, and in the lower navigation pane, click **Roles**.  
  
    ![](../Image/ipam_CreateUserRole_01.jpg)  
  
3.  Right\-click **Roles**, and then click **Add User Role**.  
  
    ![](../Image/ipam_CreateUserRole_02.jpg)  
  
4.  The **Add or Edit Role** dialog box opens. In **Name**, type a name for the role that makes the role function clear. For example, if you want to create a role that allows Administrators to manage DNS SRV resource records, you might name the role **IPAMSrv**. If needed, scroll down in **Operations** to locate the type of operations you want to define for the role. For this example, scroll down to **DNS resource record management operations**.  
  
    ![](../Image/ipam_CreateUserRole_03.jpg)  
  
5.  Expand **DNS resource record management operations**, and then locate **SRV record operations**.  
  
    ![](../Image/ipam_CreateUserRole_04.jpg)  
  
6.  Expand and select **SRV record operations**, and then click **OK**.  
  
    ![](../Image/ipam_CreateUserRole_05.jpg)  
  
7.  In the IPAM client console, click the role that you just created. In **Details View,** the permitted operations for the role are displayed.  
  
    ![](../Image/ipam_CreateUserRole_06.jpg)  
  
## See Also  
[Role-based Access Control](../Topic/Role-based-Access-Control.md)  
[Manage IPAM](../Topic/Manage-IPAM.md)  
  
