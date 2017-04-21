---
title: dfsutil Root import compare
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 10928e05-e635-48a1-b60d-ab8393640e55
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# dfsutil Root import compare

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The **dfsutil root import compare** command compares a namespace on one server with the namespace configuration on another server or in a file.



## Syntax

```
dfsutil root import compare <\\srcserver\share>|<filename> <\\destserver\share> [verbose] /?
```

### Parameters

|Parameter|Description|
|-------|--------|
|<\\\\srcserver\\share>|UNC path to the namespace on the first namespace server that you want to compare.|
|<\\\\destserver\\share>|UNC path to the namespace on the second namespace server that you want to compare.|
|<filename>|Name of the XML file that contains the namespace configuration that you want to compare.|
|verbose|Displays detailed status of the import process|
|\/?|Displays help at the command prompt.|

## remarks <optional section>
<Insert command specific to remarks here.>

## Scripting <optional section>
<Here is where you discuss using the command within a script. You should also provide an FWLink to the Script Center.>

## <a name="BKMK_Examples"></a>Examples
To TBD, type:

```
dfsutil root import compare \\contoso.com\NameSpace1 \\contoso.com\NameSpace2
```

To TBD, type:

```
dfsutil root import compare C:\dir1\docroot.txt \\SRV1\StandaloneNamespace1
```

To enable verbose logging for this command, type:

```
dfsutil root import compare \\contoso.com\NameSpace1 \\contoso.com\NameSpace2 /v
```

To view help for this command, type:

```
dfsutil root import compare /?
```

## additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)

-   [dfsutil Root](dfsutil-root.md)

-   [dfsutil](dfsutil.md)


