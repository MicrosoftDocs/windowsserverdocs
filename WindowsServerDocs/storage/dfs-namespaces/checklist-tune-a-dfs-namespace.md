---
title: Checklist Tune a DFS Namespace
description: This article describes how to optimize how the DFS Namespace handles referrals and polls AD DS for updated namespace data
ms.date: 6/5/2017
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Checklist: Tune a DFS namespace

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

After creating a namespace and adding folders and targets, use the following checklist to tune or optimize the way the DFS namespace handles referrals and polls Active Directory Domain Services (AD DS) for updated namespace data.

-   Prevent users from seeing folders in a namespace that they do not have permissions to access. [Enable Access-Based Enumeration on a Namespace](enable-access-based-enumeration-on-a-namespace.md) 
-   Enable or prevent users from being referred to a namespace or folder target when they access a folder in the namespace. [Enable or Disable Referrals and Client Failback](enable-or-disable-referrals-and-client-failback.md) 
-   Adjust how long clients cache a referral before requesting a new one. [Change the Amount of Time That Clients Cache Referrals](change-the-amount-of-time-that-clients-cache-referrals.md)
-   Optimize how namespace servers poll AD DS to obtain the most current namespace data. [Optimize Namespace Polling](optimize-namespace-polling.md)
-   Use inherited permissions to control which users can view folders in a namespace for which access-based enumeration is enabled. [Using Inherited Permissions with Access-Based Enumeration](using-inherited-permissions-with-access-based-enumeration.md)

In addition, by using a DFS Namespaces enhancement known as target priority, you can specify the priority of servers so that a specific server is always placed first or last in the list of servers (known as a referral) that the client receives when it accesses a folder with targets in the namespace.

-   Specify in what order users should be referred to folder targets. [Set the Ordering Method for Targets in Referrals](set-the-ordering-method-for-targets-in-referrals.md)
-   Override referral ordering for a specific namespace server or folder target. [Set Target Priority to Override Referral Ordering](set-target-priority-to-override-referral-ordering.md)

## See also

-   [Namespaces](https://technet.microsoft.com/library/cc771914(v=ws.11).aspx)
-   [Checklist: Deploy DFS Namespaces](checklist-deploy-dfs-namespaces.md)
-   [Tuning DFS Namespaces](tuning-dfs-namespaces.md)


