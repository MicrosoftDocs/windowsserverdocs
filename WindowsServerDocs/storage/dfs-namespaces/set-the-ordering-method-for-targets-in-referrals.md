---
title: Set the Ordering Method for Targets in Referrals
description: This article describes how to set the ordering method for targets in referrals.
ms.date: 6/5/2017
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Set the Ordering Method for Targets in Referrals

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

A referral is an ordered list of targets that a client computer receives from a domain controller or namespace server when the user accesses a namespace root or folder with targets. After the client receives the referral, the client attempts to access the first target in the list. If the target is not available, the client attempts to access the next target.
Targets on the client's site are always listed first in a referral. Targets outside of the client's site are listed according to the ordering method.

Use the following sections to specify in what order targets should be referred to clients and to understand the different methods of ordering target referrals:

## To set the ordering method for targets in namespace root referrals

Use the following procedure to set the ordering method on the namespace root:

1.  Click **Start**, point to **Administrative Tools**, and then click **DFS Management**.

2.  In the console tree, under the **Namespaces** node, right-click a namespace, and then click **Properties**.

3.  On the **Referrals** tab, select an ordering method.

> [!NOTE]
> To use Windows PowerShell to set the ordering method for targets in namespace root referrals, use the [Set-DfsnRoot](https://technet.microsoft.com/library/jj884281.aspx) cmdlet with one of the following parameters:
>    -   **EnableSiteCosting** specifies the **Lowest cost ordering** method
>    -   **EnableInsiteReferrals** specifies the **Exclude targets outside of the client's site** ordering method
>    -   Omitting either parameter specifies the **Random order** referral ordering method. 

The DFSN Windows PowerShell module was introduced in Windows Server 2012.
   
## To set the ordering method for targets in folder referrals

Folders with targets inherit the ordering method from the namespace root. You can override the ordering method by using the following procedure:

1.  Click **Start**, point to **Administrative Tools**, and then click **DFS Management**.

2.  In the console tree, under the **Namespaces** node, right-click a folder with targets, and then click **Properties**.

3.  On the **Referrals** tab, select the **Exclude targets outside of the client's site** check box.

> [!NOTE]
> To use Windows PowerShell to exclude folder targets outside of the client's site, use the [Set-DfsnFolder –EnableInsiteReferrals](https://technet.microsoft.com/library/jj884283.aspx) cmdlet.

## Target referral ordering methods

The three ordering methods are:

-   Random order
-   Lowest cost
-   Exclude targets outside of the client's site

## Random order

In this method, targets are ordered as follows:

1.  Targets in the same Active Directory Directory Services (AD DS) site as the client are listed in random order at the top of the referral.
2.  Targets outside of the client's site are listed in random order.

If no same-site target servers are available, the client computer is referred to a random target server regardless of how expensive the connection is or how distant the target.

## Lowest cost

In this method, targets are ordered as follows:

1.  Targets in the same site as the client are listed in random order at the top of the referral.
2.  Targets outside of the client's site are listed in order of lowest cost to highest cost. Referrals with the same cost are grouped together, and the targets are listed in random order within each group.

> [!NOTE]
> Site link costs are not shown in the DFS Management snap-in. To view site link costs, use the Active Directory Sites and Services snap-in.

## Exclude targets outside of the client's site

In this method, the referral contains only the targets that are in the same site as the client. These same-site targets are listed in random order. If no same-site targets exist, the client does not receive a referral and cannot access that portion of the namespace.

> [!NOTE]
> Targets that have target priority set to "First among all targets" or "Last among all targets" are still listed in the referral, even if the ordering method is set to **Exclude targets outside of the client's site**.

## See also 

-   [Tuning DFS Namespaces](tuning-dfs-namespaces.md)
-   [Delegate Management Permissions for DFS Namespaces](delegate-management-permissions-for-dfs-namespaces.md)