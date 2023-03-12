---
title: Checklist Deploy DFS Namespaces
description: This article describes how to configure and deploy DFS Namespaces.
ms.date: 6/5/2017
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Checklist: Deploy DFS Namespaces

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

Distributed File System (DFS) Namespaces and DFS Replication can be used to publish documents, software, and line-of-business data to users throughout an organization. Although DFS Replication alone is sufficient to distribute data, you can use DFS Namespaces to configure the namespace so that a folder is hosted by multiple servers, each of which holds an updated copy of the folder. This increases data availability and distributes the client load across servers.

When browsing a folder in the namespace, users are not aware that the folder is hosted by multiple servers. When a user opens the folder, the client computer is automatically referred to a server on its site. If no same-site servers are available, you can configure the namespace to refer the client to a server that has the lowest connection cost as defined in Active Directory Directory Services (AD DS).

To deploy DFS Namespaces, perform the following tasks:

-   Review the concepts, and requirements of DFS Namespaces.
[Overview of DFS Namespaces](dfs-overview.md)
-   [Choose a namespace type](choose-a-namespace-type.md)
-   [Create a DFS namespace](create-a-dfs-namespace.md) 
-   Migrate existing domain-based namespaces to Windows Server 2008 mode domain-based namespaces. [Migrate a Domain-based Namespace to Windows Server 2008 mode](migrate-a-domain-based-namespace-to-windows-server-2008-mode.md) 
-   Increase availability by adding namespace servers to a domain-based namespace. [Add Namespace Servers to a Domain-based DFS Namespace](add-namespace-servers-to-a-domain-based-dfs-namespace.md)
-   Add folders to a namespace. [Create a Folder in a DFS Namespace](create-a-folder-in-a-dfs-namespace.md)
-   Add folder targets to folders in a namespace. [Add Folder Targets](add-folder-targets.md)
-   Replicate content between folder targets using DFS Replication (optional). [Replicate Folder Targets Using DFS Replication](replicate-folder-targets-using-dfs-replication.md)


## See also

-   [Namespaces](https://technet.microsoft.com/library/cc771914(v=ws.11).aspx)
-   [Checklist: Tune a DFS Namespace](checklist-tune-a-dfs-namespace.md)
-   [Replication](https://technet.microsoft.com/library/cc770278(v=ws.11).aspx)


