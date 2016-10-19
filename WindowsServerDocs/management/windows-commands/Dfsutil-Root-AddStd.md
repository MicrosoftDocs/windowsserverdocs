---
title: Dfsutil Root AddStd
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
# Dfsutil Root AddStd

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

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

## Remarks
Create the share on the namespace server before running this command.

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

## Additional references

-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)

-   [Dfsutil Root](Dfsutil-Root.md)

-   [Dfsutil](Dfsutil.md)


