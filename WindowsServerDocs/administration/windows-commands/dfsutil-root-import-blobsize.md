---
title: dfsutil Root import BlobSize
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7541f0d1-534e-4c5f-90d3-c7e43bdb4c16
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# dfsutil Root import BlobSize

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The **dfsutil root import blobsize** command displays the approximate size of active directory Domain Services \(AD DS\) Blob for the specified namespace import file.



## Syntax

```
dfsutil root import blobsize <filename> | /?
```

### Parameters

|Parameter|Description|
|-------|--------|
|<filename>|Name of the XML file that stores the configuration of the namespace you want to analyze.|
|\/?|<Another concise description, starts with verb.>|

## <a name="BKMK_Examples"></a>Examples
To TBD, type:

```
dfsutil root import blobsize docroot.xml
```

To view help for this command, type:

```
dfsutil root import blobsize /?
```

## additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)


-   [dfsutil Root](dfsutil-root.md)

-   [dfsutil](dfsutil.md)


