---
title: Create a DFS Namespace
description: This article describes how to create a DFS namespace.
ms.date: 6/5/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Create a DFS namespace

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

To create a new namespace, you can use Server Manager to create the namespace when you install the DFS Namespaces role service. You can also use the [New-DfsnRoot cmdlet](https://docs.microsoft.com/powershell/module/dfsn/new-dfsnroot) from a Windows PowerShell session. 

The DFSN Windows PowerShell module was introduced in Windows Server 2012. 

Alernatively, you can use the following procedure to create a namespace after installing the role service.

## To create a namespace

1.  Click **Start**, point to **Administrative Tools**, and then click **DFS Management**.

2.  In the console tree, right-click the **Namespaces** node, and then click **New Namespace**.

3.  Follow the instructions in the **New Namespace Wizard**.

    To create a stand-alone namespace on a failover cluster, specify the name of a clustered file server instance on the **Namespace Server** page of the **New Namespace Wizard** .

> [!IMPORTANT]
> Do not attempt to create a domain-based namespace using the Windows Server 2008 mode unless the forest functional level is Windows Server 2003 or higher. Doing so can result in a namespace for which you cannot delete DFS folders, yielding the following error message: "The folder cannot be deleted. Cannot complete this function".

## See also

-   [Deploying DFS Namespaces](deploying-dfs-namespaces.md)
-   [Choose a Namespace Type](choose-a-namespace-type.md)
-   [Add Namespace Servers to a Domain-based DFS Namespace](add-namespace-servers-to-a-domain-based-dfs-namespace.md)
-   [Delegate Management Permissions for DFS Namespaces](delegate-management-permissions-for-dfs-namespaces.md).


