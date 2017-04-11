---
title: dfsutil Root Export
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c79b3131-e7a2-4480-b35c-915df8997cb5
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# dfsutil Root Export

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The **dfsutil root export** command exports the namespace configuration information to a file.



## Syntax

```
dfsutil root export <\\server\share> <filename> [verbose] [DownLevel]
```

### Parameters

|Parameter|Description|
|-------|--------|
|<\\\\server\\share>|UNC path to the namespace on the namespace server.|
|<filename>|Name of the file that will store the namespace configuration in XML file format.|
|Downlevel|Saves the export file as a text file that is compatible with the version of dfsutil that is included with the Windows Server 2003 Support Tools.|
|verbose|Displays detailed status of the export process.|
|\/?|Displays help at the command prompt.|

## <a name="BKMK_Examples"></a>Examples
To TBD, type:

```
dfsutil root export \\contoso.com\DomainNamespace1 C:\dir1\a.txt downlevel
```

To TBD, type:

```
dfsutil root export \\SRV1\StandaloneNamespace1 C:\dir1\docroot.xml
```

To view help for this command, type:

```
dfsutil root export /?
```

## additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)

-   [dfsutil Root](dfsutil-root.md)

-   [dfsutil](dfsutil.md)


