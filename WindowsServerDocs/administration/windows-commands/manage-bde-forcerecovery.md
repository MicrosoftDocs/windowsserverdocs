---
title: manage-bde forcerecovery
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eecae37c-c9a3-46c5-b615-a0ace1f1d778
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# manage-bde: forcerecovery



Forces a BitLocker-protected drive into recovery mode on restart. This command deletes all Trusted Platform Module (TPM)-related key protectors from the drive. When the computer restarts, only a recovery password or recovery key can be used to unlock the drive. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
manage-bde –forcerecovery <Drive> [-computername <Name>] [{-?|/?}] [{-help|-h}]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<Drive>|Represents a drive letter followed by a colon.|
|-computername|Specifies that Manage-bde.exe will be used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command.|
|\<Name>|Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address.|
|-? or /?|Displays brief Help at the command prompt.|
|-help or -h|Displays complete Help at the command prompt.|

## <a name="BKMK_Examples"></a>Examples

The following example illustrates using the **-forcerecovery** command to cause BitLocker to start in recovery mode on drive C.
```
manage-bde –forcerecovery C:
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Manage-bde](manage-bde.md)