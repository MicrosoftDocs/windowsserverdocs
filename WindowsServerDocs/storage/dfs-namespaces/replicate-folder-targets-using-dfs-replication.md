---
title: Replicate Folder Targets using DFS Replication
description: This article describes how to replicate folder targets using DFS Replication
ms.date: 6/5/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Replicate folder targets using DFS Replication

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, and Windows Server 2008

You can use DFS Replication to keep the contents of folder targets in sync so that users see the same files regardless of which folder target the client computer is referred to.

## To replicate folder targets using DFS Replication

1.  Click **Start**, point to **Administrative Tools**, and then click **DFS Management**.

2.  In the console tree, under the **Namespaces** node, right-click a folder that has two or more folder targets, and then click **Replicate Folder**.

3.  Follow the instructions in the Replicate Folder Wizard.

> [!NOTE]
> Configuration changes are not applied immediately to all members except when using the [Suspend-DfsReplicationGroup](https://technet.microsoft.com/itpro/powershell/windows/dfsr/suspend-dfsreplicationgroup) and [Sync-DfsReplicationGroup](https://technet.microsoft.com/itpro/powershell/windows/dfsr/sync-dfsreplicationgroup) cmdlets. The new configuration must be replicated to all domain controllers, and each member in the replication group must poll its closest domain controller to obtain the changes. The amount of time this takes depends on the Active Directory Directory Services (AD DS) replication latency and the long polling interval (60 minutes) on each member. To poll immediately for configuration changes, open a Command Prompt window and then type the following command once for each member of the replication group: <br /> dfsrdiag.exe PollAD /Member:DOMAIN\Server1 
<br />
To do so from a Windows PowerShell session, use the [Update-DfsrConfigurationFromAD](https://technet.microsoft.com/itpro/powershell/windows/dfsr/update-dfsrconfigurationfromad) cmdlet, which was introduced in Windows Server 2012 R2.

## See also

-   [Deploying DFS Namespaces](deploying-dfs-namespaces.md)
-   [Delegate Management Permissions for DFS Namespaces](delegate-management-permissions-for-dfs-namespaces.md)
-   [DFS Replication](../dfs-replication/dfsr-overview.md)