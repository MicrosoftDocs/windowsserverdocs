---
title: Create and Manage Server Groups_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e5477e50-493a-4218-99fb-fc4183d17242
author: jpjofre
---
# Create and Manage Server Groups_1
This topic describes how to create custom, user\-defined groups of servers in [!INCLUDE[sm](../Token/sm_md.md)] in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] and [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)].  
  
## <a name="BKMK_groups"></a>Server groups  
Servers that you add to the server pool are displayed on the **All Servers** page in [!INCLUDE[sm](../Token/sm_md.md)]. You can create custom groups of servers that you have added. Server groups allow you to view and manage a smaller subset of your server pool as a logical unit; for example, you can create a group called **Accounting Servers** for all servers in your organization’s Accounting department, or a group called **Chicago** for all servers that are geographically located in Chicago. After you create a server group, the group’s home page in [!INCLUDE[sm](../Token/sm_md.md)] displays information about events, services, performance counters, [!INCLUDE[bpa](../Token/bpa_md.md)] results, and installed roles and features for the group as a whole.  
  
Servers can be a member of more than one group.  
  
#### To create a new server group  
  
1.  On the **Manage** menu, click **Create Server Group**.  
  
2.  In the **Server group name** text box, type a friendly name for your server group, such as **Accounting Servers**.  
  
3.  Add servers to the **Selected** list from the server pool, or add other servers to the group by using the **Active Directory**, **DNS**, or **Import** tabs. For more information about how to use these tabs, see [Add Servers to Server Manager](../Topic/Add-Servers-to-Server-Manager.md) in this topic.  
  
4.  When you have finished adding servers to the group, click **OK**. The new group is displayed in the [!INCLUDE[sm](../Token/sm_md.md)] navigation pane under the **All Servers** group.  
  
#### To edit an existing server group  
  
1.  Do one of the following.  
  
    -   In the [!INCLUDE[sm](../Token/sm_md.md)] navigation pane, right\-click a server group, and then click **Edit Server Group**.  
  
    -   On the home page for the server group, open the **Tasks** menu on the **Servers** tile, and then click **Edit Server Group**.  
  
2.  Change the group name, or add or remove servers from the group.  
  
    > [!NOTE]  
    > Removing servers from a server group does not remove servers from [!INCLUDE[sm](../Token/sm_md.md)]. Servers that you remove from a group remain in the **All Servers** group, in the server pool.  
  
3.  When you are finished with changes to the group, click **OK**.  
  
#### To delete an existing server group  
  
1.  Do one of the following.  
  
    -   In the [!INCLUDE[sm](../Token/sm_md.md)] navigation pane, right\-click a server group, and then click **Delete Server Group**.  
  
    -   On the home page for the server group, open the **Tasks** menu on the **Servers** tile, and then click **Delete Server Group**.  
  
2.  When you are prompted to make sure you want to delete the server group, click **Yes**.  
  
    > [!NOTE]  
    > Deleting a server group does not remove servers from [!INCLUDE[sm](../Token/sm_md.md)]. Servers that were in a deleted group remain in the **All Servers** group, in the server pool.  
  
3.  When you are finished with changes to the group, click **OK**.  
  
## See Also  
[Add Servers to Server Manager](../Topic/Add-Servers-to-Server-Manager.md)  
[Manage Multiple, Remote Servers with Server Manager](../Topic/Manage-Multiple,-Remote-Servers-with-Server-Manager.md)  
  
