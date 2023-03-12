---
title: Enable or Disable Referrals and Client Failback
description: This article describes how to enable or disable referrals and client failback.
ms.date: 6/5/2017
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Enable or Disable Referrals and Client Failback

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

A referral is an ordered list of servers that a client computer receives from a domain controller or namespace server when the user accesses a namespace root or DFS folder with targets. After the computer receives the referral, the computer attempts to access the first server in the list. If the server is not available, the client computer attempts to access the next server. If a server becomes unavailable, you can configure clients to fail back to the preferred server after it becomes available.

The following sections provide information about how to enable or disable referrals or enable client failback:

## Enable or disable referrals

By disabling a namespace server's or folder target's referral, you can prevent users from being directed to that namespace server or folder target. This is useful if you need to temporarily take a server offline for maintenance.

-   To enable or disable referrals to a folder target, use the following steps:

    1.  In the DFS Management console tree, under the **Namespaces** node, click a folder containing targets, and then click the **Folder Targets** tab in the **Details** pane.
    2.  Right-click the folder target, and then click either **Disable Folder Target** or **Enable Folder Target**.

-   To enable or disable referrals to a namespace server, use the following steps:

    1.  In the DFS Management console tree, select the appropriate namespace and then click the **Namespace Servers** tab.
    2.  Right-click the appropriate namespace server and then click either **Disable Namespace Server** or **Enable Namespace Server**.


> [!TIP]
> To enable or disable referrals by using Windows PowerShell, use the [Set-DfsnRootTarget –State](https://technet.microsoft.com/library/jj884266.aspx) or [Set-DfsnServerConfiguration](https://technet.microsoft.com/library/jj884277.aspx) cmdlets, which were introduced in Windows Server 2012.

## Enable client failback

If a target becomes unavailable, you can configure clients to fail back to the target after it is restored. For failback to work, client computers must meet the requirements listed in the following topic: [Review DFS Namespaces Client Requirements](https://technet.microsoft.com/library/cc771913(v=ws.11).aspx).


> [!NOTE]
> To enable client failback on a namespace root by using Windows PowerShell, use the [Set-DfsnRoot](https://technet.microsoft.com/library/jj884281.aspx) cmdlet. To enable client failback on a DFS folder, use the [Set-DfsnFolder](https://technet.microsoft.com/library/jj884283.aspx) cmdlet.


## To enable client failback for a namespace root

1.  Click **Start**, point to **Administrative Tools**, and then click **DFS Management**.

2.  In the console tree, under the **Namespaces** node, right-click a namespace, and then click **Properties**.

3.  On the **Referrals** tab, select the **Clients fail back to preferred targets** check box.

Folders with targets inherit client failback settings from the namespace root. If client failback is disabled on the namespace root, you can use the following procedure to enable the client to fail back on a folder with targets.

## To enable client failback for a folder with targets

1.  Click **Start**, point to **Administrative Tools**, and then click **DFS Management**.

2.  In the console tree, under the **Namespaces** node, right-click a folder with targets, and then click **Properties**.

3.  On the **Referrals** tab, click the **Clients fail back to preferred targets** check box.

## See also 

-   [Tuning DFS Namespaces](tuning-dfs-namespaces.md)
-   [Review DFS Namespaces Client Requirements](https://technet.microsoft.com/library/cc771913(v=ws.11).aspx)
-   [Delegate Management Permissions for DFS Namespaces](delegate-management-permissions-for-dfs-namespaces.md)