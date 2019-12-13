---
title: Choose a Namespace Type
description: This article describes how to choose a namespace type.
ms.date: 6/5/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Choose a namespace type

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

When creating a namespace, you must choose one of two namespace types: a stand-alone namespace or a domain-based namespace. In addition, if you choose a domain-based namespace, you must choose a namespace mode: Windows 2000 Server mode or Windows Server 2008 mode.

## Choosing a namespace type

Choose a stand-alone namespace if any of the following conditions apply to your environment:

-   Your organization does not use Active Directory Domain Services (AD DS).
-   You want to increase the availability of the namespace by using a failover cluster.
-   You need to create a single namespace with more than 5,000 DFS folders in a domain that does not meet the requirements for a domain-based namespace (Windows Server 2008 mode) as described later in this topic.

> [!NOTE]
> To check the size of a namespace, right-click the namespace in the DFS Management console tree, click **Properties**, and then view the namespace size in the **Namespace Properties** dialog box. For more information about DFS Namespace scalability, see the Microsoft website [File Services](https://technet.microsoft.com/library/cc771548.aspx).

Choose a domain-based namespace if any of the following conditions apply to your environment:

-   You want to ensure the availability of the namespace by using multiple namespace servers.
-   You want to hide the name of the namespace server from users. This makes it easier to replace the namespace server or migrate the namespace to another server.

## Choosing a domain-based namespace mode

If you choose a domain-based namespace, you must choose whether to use the Windows 2000 Server mode or the Windows Server 2008 mode. The Windows Server 2008 mode includes support for access-based enumeration and increased scalability. The domain-based namespace introduced in Windows 2000 Server is now referred to as "domain-based namespace (Windows 2000 Server mode)."

To use the Windows Server 2008 mode, the domain and namespace must meet the following minimum requirements:

-   The forest uses the Windows Server 2003 or higher forest functional level.
-   The domain uses the Windows Server 2008 or higher domain functional level.
-   All namespace servers are running Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008.

If your environment supports it, choose the Windows Server 2008 mode when you create new domain-based namespaces. This mode provides additional features and scalability, and also eliminates the possible need to migrate a namespace from the Windows 2000 Server mode.

For information about migrating a namespace to Windows Server 2008 mode, see [Migrate a Domain-based Namespace to Windows Server 2008 Mode](migrate-a-domain-based-namespace-to-windows-server-2008-mode.md).

If your environment does not support domain-based namespaces in Windows Server 2008 mode, use the existing Windows 2000 Server mode for the namespace.

## Comparing namespace types and modes

The characteristics of each namespace type and mode are described in the following table.

|Characteristic|Stand-Alone Namespace|Domain-based Namespace (Windows 2000 Server Mode) |Domain-based Namespace (Windows Server 2008 Mode) | 
|---|---|---|---|
|Path to namespace|\\\ *ServerName\RootName* |\\\ *NetBIOSDomainName\RootName* <br />\\\ *DNSDomainName\RootName*|\\\ *NetBIOSDomainName\RootName* <br /> \\\ *DNSDomainName\RootName*|
|Namespace information storage location|In the registry and in a memory cache on the namespace server|In AD DS and in a memory cache on each namespace server|In AD DS and in a memory cache on each namespace server|
|Namespace size recommendations|The namespace can contain more than 5,000 folders with targets; the recommended limit is 50,000 folders with targets|The size of the namespace object in AD DS should be less than 5 megabytes (MB) to maintain compatibility with domain controllers that are not running Windows Server 2008. This means no more than approximately 5,000 folders with targets.|The namespace can contain more than 5,000 folders with targets; the recommended limit is 50,000 folders with targets |
|Minimum AD DS forest functional level|AD DS is not required|Windows 2000|Windows Server 2003|
|Minimum AD DS domain functional level|AD DS is not required|Windows 2000 mixed|Windows Server 2008|
|Minimum supported namespace servers|Windows 2000 Server|Windows 2000 Server|Windows Server 2008|
|Support for access-based enumeration (if enabled)|Yes, requires Windows Server 2008 namespace server|No|Yes|
|Supported methods to ensure namespace availability|Create a stand-alone namespace on a failover cluster.|Use multiple namespace servers to host the namespace. (The namespace servers must be in the same domain.)|Use multiple namespace servers to host the namespace. (The namespace servers must be in the same domain.)|
|Support for using DFS Replication to replicate folder targets|Supported when joined to an AD DS domain|Supported|Supported|

## See also

-   [Deploying DFS Namespaces](deploying-dfs-namespaces.md)
-   [Migrate a Domain-based Namespace to Windows Server 2008 Mode](migrate-a-domain-based-namespace-to-windows-server-2008-mode.md)


