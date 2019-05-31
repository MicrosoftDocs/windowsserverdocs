---
title: dfsutil
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ef5093a4-0d24-4b21-9d04-59933ad98e2c
robots: noindex,nofollow
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# dfsutil

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The dfsutil command manages DFS Namespaces, servers and clients. dfsutil commands use the original Distributed File System terminology, with updated DFS Namespaces terminology provided as explanation for most commands.

for examples of how this command can be used, see 

## Syntax

```
command </parameter> </param2>
```

### Parameters

|Parameter|Description|
|-------|--------|
|[dfsutil Root](dfsutil-root.md)|Displays,creates,removes,imports,exports namespace roots.|
|[dfsutil Link](dfsutil-link.md)|Displays, creates, removes, or moves folders \(links\).|
|[dfsutil Target](dfsutil-target.md)|Displays,create,remove folder target or namespace server.|
|[dfsutil Property](dfsutil-property.md)|Displays or modifies a folder target or namespace server.|
|[dfsutil Client](dfsutil-client.md)|Displays or modifies client information or registry keys.|
|[dfsutil Server](dfsutil-server.md)|Displays or modifies namespace configuration.|
|[dfsutil Diag](dfsutil-diag.md)|Perform diagnostics or view dfsdirs\/dfspath.|
|[dfsutil Domain](dfsutil-domain.md)|Displays all domain\-based namespaces in a domain.|
|[dfsutil Cache](dfsutil-cache.md)|Displays or flushes the client cache.|
|[dfsutil oldcli](dfsutil-oldcli.md)|Use the dfsutil \/oldcli command to use of the original dfsutil syntax.|

## Remarks <optional section>
if you specify an object \(such as a namespace server\) at the end of a command, most commands will display information about the object without requiring further parameters or commands. For example, when using the dfsutil Root command, you can append a namespace root to the command to view information about the root.

## <a name="BKMK_Examples"></a>Examples
&lt;Here is where you put a detailed description of your example.&gt;

```
This /is /the /example /of /calling /command /with /parameters
```

&lt;Here is where you put a detailed description of another example.&gt;

```
This /is /a:different /example
```

## additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)


