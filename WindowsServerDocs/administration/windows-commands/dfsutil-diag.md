---
title: dfsutil Diag
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
# dfsutil Diag

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The **dfsutil diag** command performs diagnostics on a DFS namespace.



## Syntax

```
dfsutil diag | clean <\\server\share> [verbose] |unmapdomroot <\\domain\root>  <\\rootreplica\share> [verbose] | viewdfsdirs <drive> [removereparse] [verbose] | viewdfspath <Dfspath> | /?
```

### Parameters

|Parameter|Description|
|-------|--------|
|[dfsutil Diag UnMapDomRoot]|deletes obsolete references to a domain\-based root target.|
|[dfsutil Diag clean]|removes reference to an obsolete root from host machine.|
|[dfsutil Diag Viewdfsdirs]|list\/remove all DFS reparse directories in a volume.|
|[dfsutil Diag Viewdfspath]|Resolves a Dfspath to a destination UNC path.|
|\/?|Displays help at the command prompt.|

## <a name="BKMK_Examples"></a>Examples
To TBD, type:

```
dfsutil diag
```

To view help for this command, type:

```
dfsutil diag/?
```

## additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)

-   [dfsutil](dfsutil.md)


