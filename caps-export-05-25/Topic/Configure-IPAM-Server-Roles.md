---
title: Configure IPAM Server Roles
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6ce38f4b-ed05-4b56-a59e-20eeb50e67e8
---
# Configure IPAM Server Roles
[Checklist: Assign Roles](../Topic/Checklist--Assign-Roles.md) > **Configure IPAM Server Roles**  
  
Before you can begin using IPAM, you must configure server discovery \(also called the scope of discovery\) and select the manageability status of servers in the server inventory. For more information, see [Getting Started with IPAM](../Topic/Getting-Started-with-IPAM.md).  
  
You can also update these settings when \(for example\) you add new servers or domains to your organization. The procedures to update the scope of discovery and managed server roles are the same as those used to initially configure these settings. The procedures with some additional details are also provided in this topic for convenience, and to emphasize that the management scope of an IPAM server is dynamic and can be modified at any time to adapt to your environment.  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Configuring IPAM server roles  
Use the following procedures to update server discovery and managed server role settings:  
  
1.  [Configure the scope of discovery](../Topic/Configure-IPAM-Server-Roles.md#scope_of_discovery)  
  
2.  [Configure managed servers and roles](../Topic/Configure-IPAM-Server-Roles.md#managed_server_roles)  
  
### <a name="scope_of_discovery"></a>To configure the scope of discovery  
  
1.  On the IPAM Overview page, click **Configure server discovery**. Alternatively, you can click **Manage** on the Server Manager menu, click **IPAM Settings**, and then click **Configure Server Discovery**. The **Configure Server Discovery** dialog box will open.  
  
2.  To add a domain to manage with the current IPAM server, selecting it from the drop\-down list and then click **Add**.  
  
    ![](../Image/IPAM_discovery_scope.gif)  
  
    > [!TIP]  
    > To sort items in the list by name, click a column header.  
  
3.  To remove a domain from the scope of discovery, click the domain and then click **Remove**. Removing domains from the scope of discovery will not remove managed servers from the server inventory list if they have already been discovered or added. To remove these servers, you must delete them manually.  
  
4.  By default all server roles are enabled in the domains you select. To remove a server role from the scope of discovery for a specific domain, de\-select the checkbox under the appropriate server role. Selecting a server role to be discovered does not automatically enable IPAM management for the role, it only allows discovery of the role on the network.  
  
    > [!NOTE]  
    > NPS servers can also be managed servers, but this server role is not automatically discovered on the network.  
  
5.  Click **OK** when you are finished choosing domains and server roles to discover.  
  
### <a name="managed_server_roles"></a>To configure managed servers and roles  
  
1.  In the upper IPAM navigation tree, click **SERVER INVENTORY**. The list of servers that have been discovered or manually added is displayed.  
  
2.  Select one or more servers by clicking the appropriate row in the list. To select multiple servers, hold down SHIFT or CTRL when clicking.  
  
3.  Right\-click the server or servers that are selected and then click **Edit Server**.  
  
    ![](../Image/IPAM_edit-server.gif)  
  
4.  In the **Add or Edit Server** dialog box next to **Manageability status**, select **Managed**, **Unmanaged**, or **Unspecified** from the drop\-down list.  
  
5.  Select the server roles that will be managed by the current IPAM server by selecting the appropriate checkboxes next to **Server type**, and then click **OK**.  
  
    ![](../Image/IPAM_edit-server2.gif)  
  
    > [!NOTE]  
    > If you have selected the manual provisioning method, you must apply or remove IPAM access settings to managed servers manually if you add or remove servers and server roles from the managed server inventory.  
  
6.  If a new managed server role was added, a recommended action of **Retrieve IPAM Access Status** will be displayed. To refresh access status, right\-click the server in the list and then click **Refresh Server Access Status**.  
  
    ![](../Image/IPAM_edit-server3.gif)  
  
7.  Wait for the IPAM **ServerDiscovery** task to complete, and then refresh the console view.  
  
To quickly view managed server roles for all servers in the inventory, view the **Server Type** column.  
  
## See Also  
[Configure Server Discovery](../Topic/Configure-Server-Discovery.md)  
[Choose Managed Servers](../Topic/Choose-Managed-Servers.md)  
  
