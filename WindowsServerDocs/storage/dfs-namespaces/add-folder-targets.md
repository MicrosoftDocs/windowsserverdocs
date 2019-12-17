---
title: Add Folder Targets
description: This topic describes how to add folder targets (UNC paths)
ms.prod: windows-server
ms.author: jgerend
ms.manager: brianlic
ms.technology: storage
ms.topic: article
author: jasongerend
ms-date: 06/05/2017
---
# Add folder targets

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

A folder target is the Universal Naming Convention (UNC) path of a shared folder or another namespace that is associated with a folder in a namespace. Adding multiple folder targets increases the availability of the folder in the namespace.

## To add a folder target

To add a folder target by using DFS Management, use the following procedure:

1.  Click **Start**, point to **Administrative Tools**, and then click **DFS Management**.

2.  In the console tree, under the **Namespaces** node, right-click a folder, and then click **Add Folder Target**.

3.  Type the path to the folder target, or click **Browse** to locate the folder target.

4.  If the folder is replicated using DFS Replication, you can specify whether to add the new folder target to the replication group.

> [!TIP]
> To add a folder target by using Windows PowerShell, use the [New-DfsnFolderTarget](https://docs.microsoft.com/powershell/module/dfsn/new-dfsnfoldertarget) cmdlet. The DFSN Windows PowerShell module was introduced in Windows Server 2012.

> [!NOTE]
> Folders can contain folder targets or other DFS folders, but not both, at the same level in the folder hierarchy.

## See also

-   [Deploying DFS Namespaces](deploying-dfs-namespaces.md)
-   [Delegate Management Permissions for DFS Namespaces](delegate-management-permissions-for-dfs-namespaces.md)
-   [Replicate Folder Targets Using DFS Replication](replicate-folder-targets-using-dfs-replication.md)