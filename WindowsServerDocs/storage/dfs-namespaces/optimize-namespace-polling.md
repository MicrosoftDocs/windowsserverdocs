---
title: Optimize Namespace Polling
description: This article describes how to optimize namespace polling to maintain a consistent domain-based namespace across namespace servers
ms.date: 6/5/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Optimize Namespace Polling

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

To maintain a consistent domain-based namespace across namespace servers, it is necessary for namespace servers to periodically poll Active Directory Domain Services (AD DS) to obtain the most current namespace data. 

## To optimize namespace polling

Use the following procedure to optimize how namespace polling occurs:

1.  Click **Start**, point to **Administrative Tools**, and then click **DFS Management**.

2.  In the console tree, under the **Namespaces** node, right-click a domain-based namespace, and then click **Properties** .

3.  On the **Advanced** tab, select whether you  want the namespace optimized for consistency or scalability.

    -   Choose **Optimize for consistency** if there are 16 or fewer namespace servers hosting the namespace.
    -   Choose **Optimize for scalability** if there are more than 16 namespace servers. This reduces the load on the Primary Domain Controller (PDC) Emulator, but increases the time required for changes to the namespace to replicate to all namespace servers. Until changes replicate to all servers, users might have an inconsistent view of the namespace.

> [!NOTE]
> To set the namespace polling mode by using Windows PowerShell, use the [Set-DfsnRoot EnableRootScalability](https://technet.microsoft.com/library/jj884281.aspx) cmdlet, which was introduced in Windows Server 2012.

## See also

-   [Tuning DFS Namespaces](tuning-dfs-namespaces.md)
-   [Delegate Management Permissions for DFS Namespaces](delegate-management-permissions-for-dfs-namespaces.md)