---
title: Dfsutil Diag
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9bd59960-d535-4512-9ae5-b9ffc1661f6d
robots: noindex,nofollow
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Dfsutil Diag

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

The **dfsutil diag** command performs diagnostics on a DFS namespace.



## Syntax

```
dfsutil diag | clean <\\server\share> [Verbose] |unmapdomroot <\\domain\root>  <\\rootreplica\share> [Verbose] | viewdfsdirs <drive> [removereparse] [Verbose] | viewdfspath <DfsPath> | /?
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|[Dfsutil Diag UnMapDomRoot]|Deletes obsolete references to a domain\-based root target.|
|[Dfsutil Diag Clean]|Removes reference to an obsolete root from host machine.|
|[Dfsutil Diag Viewdfsdirs]|List\/Remove all DFS reparse directories in a volume.|
|[Dfsutil Diag Viewdfspath]|Resolves a DfsPath to a destination UNC path.|
|\/?|Displays help at the command prompt.|

## <a name="BKMK_Examples"></a>Examples
To TBD, type:

```
Dfsutil diag
```

To view help for this command, type:

```
dfsutil diag/?
```

## Additional references

-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)

-   [Dfsutil](Dfsutil.md)


