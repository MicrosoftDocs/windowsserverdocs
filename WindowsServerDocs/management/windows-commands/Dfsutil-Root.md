---
title: Dfsutil Root
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

# Dfsutil Root

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

The **dfsutil root** command displays information about the namespace root. Dfsutil Root commands support creating, removing, importing or exporting namespace roots.



## Syntax

```
dfsutil root <\\server\share> [Verbose] | AddDom | AddStd | Remove | Export | Import | ForceSync | /?
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|<\\\\server\\share>|UNC path to the namespace.|
|Verbose|Displays additional information while the command runs.|
|[Dfsutil Root AddDom](Dfsutil-Root-AddDom.md)|Creates a new domain\-based namespace.|
|[Dfsutil Root AddStd](Dfsutil-Root-AddStd.md)|Creates a new stand\-alone namespace.|
|[Dfsutil Root Remove](Dfsutil-Root-Remove.md)|Removes the namespace.|
|[Dfsutil Root Export](Dfsutil-Root-Export.md)|Exports the namespace configuration to a file.|
|Dfsutil Root Import|Imports the namespace from another namespace or a file.|
|Dfsutil Root ForceSync|Perform a Forced sync on the target of a namespace.|
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
Dfsutil root /?
```

## Additional references

-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)

-   [Dfsutil](Dfsutil.md)


