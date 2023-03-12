---
title: Set Target Priority to Override Referral Ordering
description: This article describes how to set the target priority to override referral ordering
ms.date: 6/5/2017
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Set target priority to override referral ordering

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

A referral is an ordered list of targets that a client computer receives from a domain controller or namespace server when the user accesses a namespace root or folder with targets in the namespace. Each target in a referral is ordered according to the ordering method for the namespace root or folder. 

To refine how targets are ordered, you can set priority on individual targets. For example, you can specify that the target is first among all targets, last among all targets, or first or last among all targets of equal cost.

## To set target priority on a root target for a domain-based namespace

To set target priority on a root target for a domain-based namespace, use the following procedure:

1.  Click **Start**, point to **Administrative Tools**, and then click **DFS Management**.

2.  In the console tree, under the **Namespaces** node, click the domain-based namespace for the root targets for which you want to set priority.

3.  In the **Details** pane, on the **Namespace Servers** tab, right-click the root target with the priority that you want to change, and then click **Properties**.

4.  On the **Advanced** tab, click **Override referral ordering**, and then click the priority  you want.

    -   **First among all targets**  Specifies that users should always be referred to this target if the target is available.
    -   **Last among all targets** Specifies that users should never be referred to this target unless all other targets are unavailable.
    -   **First among targets of equal cost**  Specifies that users should be referred to this target before other targets of equal cost (which usually means other targets in the same site).
    -   **Last among targets of equal cost**  Specifies that users should never be referred to this target if there are other targets of equal cost available (which usually means other targets in the same site).

## To set target priority on a folder target

To set target priority on a folder target, use the following procedure:

1.  Click **Start**, point to **Administrative Tools**, and then click **DFS Management**.

2.  In the console tree, under the **Namespaces** node, click the folder of the targets for which you want to set priority.

3.  In the **Details** pane, on the **Folder Targets** tab, right-click the folder target with the priority that you want to change, and then click **Properties** .

4.  On the **Advanced** tab, click **Override referral ordering**  and then click the priority that you want.

> [!NOTE]
> To set target priorities by using Windows PowerShell, use the  [Set-DfsnRootTarget](https://technet.microsoft.com/library/jj884266.aspx) and [Set-DfsnFolderTarget](https://technet.microsoft.com/library/jj884264.aspx) cmdlets with the **ReferralPriorityClass** and **ReferralPriorityRank** parameters. These cmdlets were introduced in Windows Server 2012.

## See also

-   [Tuning DFS Namespaces](tuning-dfs-namespaces.md)
-   [Delegate Management Permissions for DFS Namespaces](delegate-management-permissions-for-dfs-namespaces.md)