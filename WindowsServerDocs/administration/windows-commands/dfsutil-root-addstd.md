---
title: dfsutil Root addStd
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 95d2ea1e-2467-405a-9f85-987a4660fcb4
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# dfsutil Root addStd

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The **dfsutil root addstd** command creates a new stand\-alone namespace.



## Syntax

```
dfsutil root addstd <\\server\share> [<Comment>] | /?
```

### Parameters

|Parameter|Description|
|-------|--------|
|<\\\\server\\share>|UNC path to the namespace on the namespace server.|
|<Comment>|Specifies an administrator comment for the namespace.|
|\/?|Displays help at the command prompt.|

## remarks
create the share on the namespace server before running this command.

## <a name="BKMK_Examples"></a>Examples
To TBD, type:

```
dfsutil root addstd \\SRV1\StandaloneNamesapce1 "Standalone Root"
```

To TBD, type:

```
dfsutil root addstd \\SRV2\StandaloneNamesapce2
```

To view help for this command, type:

```
dfsutil root addstd /?
```

## additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)

-   [dfsutil Root](dfsutil-root.md)

-   [dfsutil](dfsutil.md)


