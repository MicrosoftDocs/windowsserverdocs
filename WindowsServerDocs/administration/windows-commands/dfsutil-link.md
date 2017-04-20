---
title: dfsutil Link
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ec462af0-2f81-4671-99c2-cd3d8523e44a
robots: noindex,nofollow
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# dfsutil Link

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The **dfsutil link** command displays the information about the link\(folder\) and link\(folder\) targets.Link commands are used to create a new link, delete a link or move the links.



## Syntax

```
dfsutil link <Dfspath> | add | remove | move | /?
```

### Parameters

|Parameter|Description|
|-------|--------|
|<Dfspath>|UNC path of the link.|
|dfsutil Link add|creates a new folder.|
|dfsutil Link remove|removes the specified folder.|
|dfsutil Link move|moves the folder to another location in the namespace.|
|\/?||

## <a name="BKMK_Examples"></a>Examples
To TBD, type:

```
dfsutil link \\contoso.com\DomainNamespace1\Link1
```

To TBD, type:

```
dfsutil link \\SRV1\StandaloneNamespace1\Link1
```

To view help for this command, type:

```
dfsutil link /?
```

## additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)

-   [dfsutil](dfsutil.md)


