---
title: Migrate a Domain-based Namespace to Windows Server 2008 Mode
description: This article describes how to migrate a domain-based namespace to Windows Server 2008 mode
ms.date: 6/5/2017
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Migrate a domain-based namespace to Windows Server 2008 Mode

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

The Windows Server 2008 mode for domain-based namespaces includes support for access-based enumeration and increased scalability.

## To migrate a domain-based namespace to Windows Server 2008 mode

To migrate a domain-based namespace from Windows 2000 Server mode to Windows Server 2008 mode, you must export the namespace to a file, delete the namespace, re-create it in Windows Server 2008 mode, and then import the namespace settings. To do so, use the following procedure:

1.  Open a Command Prompt window and type the following command to export the namespace to a file, where \\\\*domain*\\*namespace* is the name of the appropriate domain, and namespace and *path\\filename* is the path and file name of the  file for export:
     ```
     Dfsutil root export \\domain\namespace path\filename.xml 
     ```
2.  Write down the path ( \\\\*server* \\*share* ) for each namespace server. You must manually add namespace servers to the re-created namespace because Dfsutil cannot import namespace servers.
3.  In DFS Management, right-click the namespace and then click **Delete**, or type the following command at a command prompt, <br /> where \\\\*domain*\\*namespace* is the name of the appropriate domain and namespace:
     ```
     Dfsutil root remove \\domain\namespace
     ```
4.  In DFS Management, re-create the namespace with the same name, but use the Windows Server 2008 mode, or type the following command at a command prompt, where <br /> \\\\*server*\\*namespace* is the name of the appropriate server and share for the namespace root:
     ```
     Dfsutil root adddom \\server\namespace v2
     ```
5.  To import the namespace from the export file, type the following command at a command prompt, where <br /> \\\\*domain*\\*namespace* is the name of the appropriate domain and namespace and *path\\filename* is the path and file name of the file to import:
     ```
     Dfsutil root import merge path\filename.xml \\domain\namespace
     ```

    > [!NOTE]
    > To minimize the time required to import a large namespace, run the **Dfsutil** root import command locally on a namespace server.
6.  Add any remaining namespace servers to the re-created namespace by right-clicking the namespace in DFS Management and then clicking **Add Namespace Server**, or by typing the following command at a command prompt, where <br /> \\\\*server*\\*share* is the name of the appropriate server and share for the namespace root:
     ```
     Dfsutil target add \\server\share 
     ```

    > [!NOTE]
    > You can add namespace servers before importing the namespace, but doing so causes the namespace servers to incrementally download the metadata for the namespace instead of immediately downloading the entire namespace after being added as a namespace server.

## See also
-   [Deploying DFS Namespaces](deploying-dfs-namespaces.md)
-   [Choose a Namespace Type](choose-a-namespace-type.md)