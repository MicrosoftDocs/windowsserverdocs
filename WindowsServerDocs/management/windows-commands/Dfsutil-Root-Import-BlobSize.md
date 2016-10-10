---
title: Dfsutil Root Import BlobSize
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

# Dfsutil Root Import BlobSize

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

The **dfsutil root import blobsize** command displays the approximate size of Active Directory Domain Services \(AD DS\) Blob for the specified namespace import file.



## Syntax

```
dfsutil root import blobsize <filename> | /?
```

### Parameters

|Parameter|Description|
|-------------|---------------|
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

## Additional references

-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)


-   [Dfsutil Root](Dfsutil-Root.md)

-   [Dfsutil](Dfsutil.md)


