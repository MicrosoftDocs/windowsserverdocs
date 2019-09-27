---
title: manage-bde KeyPackage
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c631ef10-2a2f-4541-8578-292f2d4e9e80

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# manage-bde: KeyPackage



Generates a key package for a drive. The key package can be used in conjunction with the repair tool to repair corrupted drives. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
manage-bde -KeyPackage [<Drive>] [-ID <KeyProtectoryID>] [-path <PathToExternalKeyDirectory>] [-computername <Name>] [{-?|/?}] [{-help|-h}]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<Drive>|Represents a drive letter followed by a colon.|
|-ID|Create a key package using the key protector with the identifier specified by this ID value.|
|-path|Location in which to save the key package created.|
|-computername|Specifies that Manage-bde.exe will be used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command.|
|\<Name>|Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address.|
|-? or /?|Displays brief Help at the command prompt.|
|-help or -h|Displays complete Help at the command prompt.|

## <a name="BKMK_Examples"></a>Examples

The following example illustrates using the **-KeyPackage** command to create a key package for drive C  based off the key protector identified by the GUID and to save the key package to F:\Folder.
```
manage-bde -KeyPackage C: -id {84E151C1...7A62067A512} -path "f:\Folder"
```

> [!TIP]
> Use **manage-bde –protectors –get** along with the drive letter that you want to create a key package for to get a list of available GUIDs to use as the ID value.

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Manage-bde](manage-bde.md)