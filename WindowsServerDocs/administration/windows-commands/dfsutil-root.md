---
title: dfsutil Root
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a4f02614-9edc-4e2d-8152-1d9ae6af5e49
robots: noindex,nofollow
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# dfsutil Root

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The **dfsutil root** command displays information about the namespace root. dfsutil Root commands support creating, removing, importing or exporting namespace roots.



## Syntax

```
dfsutil root <\\server\share> [verbose] | addDom | addStd | remove | Export | import | forceSync | /?
```

### Parameters

|Parameter|Description|
|-------|--------|
|<\\\\server\\share>|UNC path to the namespace.|
|verbose|Displays additional information while the command runs.|
|[dfsutil Root addDom](dfsutil-root-adddom.md)|creates a new domain\-based namespace.|
|[dfsutil Root addStd](dfsutil-root-addstd.md)|creates a new stand\-alone namespace.|
|[dfsutil Root remove](dfsutil-root-remove.md)|removes the namespace.|
|[dfsutil Root Export](dfsutil-root-export.md)|Exports the namespace configuration to a file.|
|dfsutil Root import|imports the namespace from another namespace or a file.|
|dfsutil Root forceSync|Perform a forced sync on the target of a namespace.|
|\/?|Displays help at the command prompt.|

## <a name="BKMK_Examples"></a>Examples
To TBD, type:

```
dfsutil root \\contoso.com\DomainNamespace1
```

To TBD, type:

```
dfsutil root \\SRV1\StandaloneNameSpace2
```

To enable verbose logging for this command, type:

```
dfsutil root \\SRV1\StandaloneNameSpace2 verbose
```

To view help for this command, type:

```
dfsutil root /?
```

## additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)

-   [dfsutil](dfsutil.md)


