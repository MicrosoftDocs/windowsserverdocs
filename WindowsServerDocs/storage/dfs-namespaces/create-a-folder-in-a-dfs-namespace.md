---
title: Create a Folder in a DFS Namespace
description: This article describes how to create a folder in a DFS namespace
ms.date: 6/5/2017
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Create a folder in a DFS namespace

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

You can use folders to create additional levels of hierarchy in a namespace. You can also create folders with folder targets to add shared folders to the namespace. DFS folders with folder targets cannot contain other DFS folders, so if you want to add a level of hierarchy to the namespace, do not add folder targets to the folder.

Use the following procedure to create a folder in a namespace using DFS Management:

## To create a folder in a DFS namespace

1.  Click **Start**, point to **Administrative Tools**, and then click **DFS Management**.

2.  In the console tree, under the **Namespaces** node, right-click a namespace or a folder within a namespace, and then click **New Folder**.

3.  In the **Name** text box, type the name of the new folder.

4.  To add one or more folder targets to the folder, click **Add** and specify the Universal Naming Convention (UNC) path of the folder target, and then click **OK** .


> [!TIP]
> To create a folder in a namespace by using Windows PowerShell, use the [New-DfsnFolder](https://docs.microsoft.com/powershell/module/dfsn/new-dfsnfolder)
cmdlet. The DFSN Windows PowerShell module was introduced in Windows Server 2012.


## See also

-   [Deploying DFS Namespaces](deploying-dfs-namespaces.md)
-   [Delegate Management Permissions for DFS Namespaces](delegate-management-permissions-for-dfs-namespaces.md)


