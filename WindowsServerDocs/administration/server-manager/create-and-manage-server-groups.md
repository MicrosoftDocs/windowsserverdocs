---
title: create and Manage Server Groups
description: "Server Manager"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-server-manager
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9d5b1be8-49fd-4ff7-9580-e4ff21fe4b17
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# create and Manage Server Groups

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic describes how to create custom, user-defined groups of servers in Server Manager in Windows Server.

## <a name="BKMK_groups"></a>Server groups
Servers that you add to the server pool are displayed on the **All Servers** page in Server Manager. You can create custom groups of servers that you have added. Server groups allow you to view and manage a smaller subset of your server pool as a logical unit; for example, you can create a group called **Accounting Servers** for all servers in your organization's Accounting department, or a group called **Chicago** for all servers that are geographically located in Chicago. After you create a server group, the group's home page in Server Manager displays information about events, services, performance counters, Best Practices Analyzer results, and installed roles and features for the group as a whole.

Servers can be a member of more than one group.

#### To create a new server group

1.  On the **Manage** menu, click **create Server Group**.

2.  In the **Server group name** text box, type a friendly name for your server group, such as **Accounting Servers**.

3.  add servers to the **selected** list from the server pool, or add other servers to the group by using the **active directory**, **DNS**, or **import** tabs. For more information about how to use these tabs, see [add Servers to Server Manager](add-servers-to-server-manager.md) in this guide.

4.  When you have finished adding servers to the group, click **OK**. The new group is displayed in the Server Manager navigation pane under the **All Servers** group.

#### To edit an existing server group

1.  Do one of the following.

    -   In the Server Manager navigation pane, right-click a server group, and then click **edit Server Group**.

    -   On the home page for the server group, open the **Tasks** menu on the **Servers** tile, and then click **edit Server Group**.

2.  change the group name, or add or remove servers from the group.

    > [!NOTE]
    > removing servers from a server group does not remove servers from Server Manager. Servers that you remove from a group remain in the **All Servers** group, in the server pool.

3.  When you are finished with changes to the group, click **OK**.

#### To delete an existing server group

1.  Do one of the following.

    -   In the Server Manager navigation pane, right-click a server group, and then click **delete Server Group**.

    -   On the home page for the server group, open the **Tasks** menu on the **Servers** tile, and then click **delete Server Group**.

2.  When you are prompted to make sure you want to delete the server group, click **Yes**.

    > [!NOTE]
    > deleting a server group does not remove servers from Server Manager. Servers that were in a deleted group remain in the **All Servers** group, in the server pool.

3.  When you are finished with changes to the group, click **OK**.

## See Also
[add Servers to Server Manager](add-servers-to-server-manager.md)
[Server Manager](server-manager.md)



