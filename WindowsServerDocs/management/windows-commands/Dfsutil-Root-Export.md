---
title: Dfsutil Root Export
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

# Dfsutil Root Export

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

The **dfsutil root export** command exports the namespace configuration information to a file.

For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).

## Syntax

```
dfsutil root export <\\server\share> <filename> [Verbose] [DownLevel]
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|<\\\\server\\share>|UNC path to the namespace on the namespace server.|
|<filename>|Name of the file that will store the namespace configuration in XML file format.|
|Downlevel|Saves the export file as a text file that is compatible with the version of Dfsutil that is included with the Windows Server 2003 Support Tools.|
|Verbose|Displays detailed status of the export process.|
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

## Additional references

-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)

-   [Dfsutil Root](Dfsutil-Root.md)

-   [Dfsutil](Dfsutil.md)


