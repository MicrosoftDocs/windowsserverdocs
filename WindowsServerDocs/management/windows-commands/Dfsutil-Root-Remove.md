---
title: Dfsutil Root Remove
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 354e0327-d906-4679-8f45-59e60307d3a1
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Dfsutil Root Remove
The **dfsutil root remove** command deletes the namespace root.

For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).

## Syntax

```
dfsutil root remove <\\server\share>
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|<\\\\server\\share>|UNC path to the namespace on the namespace server.|
|\/?|Displays help at the command prompt.|

## <a name="BKMK_Examples"></a>Examples
To TBD, type:

```
dfsutil root remove \\contoso.com\DomainNamespace1
```

To TBD, type:

```
dfsutil root remove \\SRV1\StandaloneNamespace2
```

To view help for this command, type:

```
dfsutil root remove /?
```

## Additional references

-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)

-   [Dfsutil Root](Dfsutil-Root.md)

-   [Dfsutil](Dfsutil.md)


