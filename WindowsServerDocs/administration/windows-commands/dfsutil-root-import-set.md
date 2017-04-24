---
title: dfsutil Root import Set
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 354b42d9-46f5-4c33-8262-d606f1326b09
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# dfsutil Root import Set

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The **dfsutil root import set** command  imports folders, folder targets and configuration information for a namespace from a file or another namespace and overwrites existing folders and folder targets.



## Syntax

```
dfsutil root import set <\\srcserver\share>|<filename> <\\destserver\share> [NoBackup] [verbose] | /?
```

### Parameters

|Parameter|Description|
|-------|--------|
|<\\\\srcserver\\share>|UNC path to the namespace from which you want to import the configuration.|
|<\\\\destserver\\share>|UNC path to the namespace to which you want to import the configuration.|
|<filename>|Name of the xml file from which you want to import the namespace configuration.|
|NoBackup|Does not create backup file to restore overwritten folders and folder targets.|
|verbose|Displays detailed status of the import process.|
|\/?|Displays help at the command prompt.|

## <a name="BKMK_Examples"></a>Examples
To TBD, type:

```
dfsutil root import set \\contoso.com\Namespace1 \\contoso.com\Namespace2
```

To TBD, type:

```
dfsutil root import set C:\dir\docroot.txt \\SRV1\StandaloneNamespace NoBackup
```

To enable verbose logging for this command, type:

```
dfsutil root import set verbose \\contoso.com\Namespace1 \\contoso.com\Namespace2
```

To view help for this command, type:

```
dfsutil root import set /?
```

## additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)


-   [dfsutil Root](dfsutil-root.md)

-   [dfsutil](dfsutil.md)


