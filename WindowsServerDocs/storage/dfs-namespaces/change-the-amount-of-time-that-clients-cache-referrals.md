---
title: Change the Amount of Time that Clients Cache Referrals
description: This article describes how to change the amount of time that clients cache referrals 
ms.date: 6/5/2017
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Change the amount of time that clients cache referrals

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

A referral is an ordered list of targets that a client computer receives from a domain controller or namespace server when the user accesses a namespace root or folder with targets in the namespace. You can adjust how long clients cache a referral before requesting a new one.

## To change the amount of time that clients cache namespace root referrals

1.  Click **Start**, point to **Administrative Tools**, and then click **DFS Management**.

2.  In the console tree, under the **Namespaces** node, right-click a namespace, and then click **Properties**.

3.  On the **Referrals** tab, in the **Cache duration (in seconds)** text box, type the amount of time (in seconds) that clients cache namespace root referrals. The default setting is 300 seconds (five minutes).

> [!TIP]
> To change the amount of time that clients cache namespace root referrals by using Windows PowerShell, use the [Set-DfsnRoot TimeToLiveSec](https://technet.microsoft.com/library/jj884281.aspx)
cmdlet. These cmdlets were introduced in Windows Server 2012.

## To change the amount of time that clients cache folder referrals

1.  Click **Start** , point to **Administrative Tools**, and then click **DFS Management**.

2.  In the console tree, under the **Namespaces** node, right-click a folder that has targets, and then click **Properties**.

3.  On the **Referrals** tab, in the **Cache duration (in seconds)** text box, type the amount of time (in seconds) that clients cache folder referrals. The default setting is 1800 seconds (30 minutes).

## See also

-   [Tuning DFS Namespaces](tuning-dfs-namespaces.md)
-   [Delegate Management Permissions for DFS Namespaces](delegate-management-permissions-for-dfs-namespaces.md)


