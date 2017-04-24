---
title: dfsutil Root remove
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
# dfsutil Root remove

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The **dfsutil root remove** command deletes the namespace root.



## Syntax

```
dfsutil root remove <\\server\share>
```

### Parameters

|Parameter|Description|
|-------|--------|
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

## additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)

-   [dfsutil Root](dfsutil-root.md)

-   [dfsutil](dfsutil.md)


