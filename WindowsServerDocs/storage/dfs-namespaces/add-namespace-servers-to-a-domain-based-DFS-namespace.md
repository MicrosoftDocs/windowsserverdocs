---
title: Add Namespace Servers to a Domain-based DFS Namespace
description: This article describes how to specify additional namespace servers to host a namespace using DFS management.
ms.date: 6/5/2017
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Add namespace servers to a domain-based DFS namespace

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

You can increase the availability of a domain-based namespace by specifying additional namespace servers to host the namespace.

## To add a namespace server to a domain-based namespace

To add a namespace server to a domain-based namespace using DFS Management, use the following procedure:

1.  Click **Start**, point to **Administrative Tools**, and then click **DFS Management**.

2.  In the console tree, under the **Namespaces** node, right-click a domain-based namespace, and then click **Add Namespace Server**.

3.  Enter the path to another server, or click **Browse** to locate a server.

> [!NOTE]
> This procedure is not applicable for stand-alone namespaces because they support only a single namespace server. To increase the availability of a stand-alone namespace, specify a failover cluster as the namespace server in the New Namespace Wizard.


> [!TIP]
> To add a namespace server by using Windows PowerShell, use the [New-DfsnRootTarget cmdlet](https://docs.microsoft.com/powershell/module/dfsn/set-dfsnroottarget). The DFSN Windows PowerShell module was introduced in Windows Server 2012.

## See also

-   [Deploying DFS Namespaces](deploying-dfs-namespaces.md)
-   [Review DFS Namespaces Server Requirements](https://technet.microsoft.com/library/cc753448(v=ws.11).aspx)
-   [Create a DFS Namespace](create-a-dfs-namespace.md)
-   [Delegate Management Permissions for DFS Namespaces](delegate-management-permissions-for-dfs-namespaces.md)

