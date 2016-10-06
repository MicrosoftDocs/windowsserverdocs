---
title: Dfsutil Root AddDom
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e35c88bf-ef21-45b7-b4d0-c3e015f00695
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Dfsutil Root AddDom

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

The **dfsutil root adddom** command  creates a new domain\-based DFS namespace.

For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).

## Syntax

```
dfsutil root adddom <\\server\share> [<Version>] [<Comment>] | /?
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|<\\\\server\\share>|UNC path to the namespace.|
|<Comment>|Specifies an administrator comment for the namespace.|
|<Version>|Version of the namespace, possible values are V1 or V2. V1 \- Creates a Windows 2000 Server mode namespace. V2 \- Creates a Windows Server 2008 mode namespace.|
|\/?|Displays help at the command prompt.|

## Remarks
Note the following about this command:

-   To add new root targets, use the "dfsutil target add" command.

-   The default version for creating a new namespace is V2.

-   Create the share on the namespace server before running this command.

## <a name="BKMK_Examples"></a>Examples
To TBD, type:

```
dfsutil root addDom \\SRV1\DomainNameSpace1 "This is a V2 namespace"
```

To TBD, type:

```
dfsutil root addDom \\SRV2\DomainNameSpace2
```

To TBD, type:

```
dfsutil root addDom \\SRV3\DomainNameSpace3 V1 "This is V1 Root"
```

To view help for this command, type:

```
dfsutil root adddom /?
```

## Additional references

-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)

-   [Dfsutil Root](Dfsutil-Root.md)

-   [Dfsutil](Dfsutil.md)


