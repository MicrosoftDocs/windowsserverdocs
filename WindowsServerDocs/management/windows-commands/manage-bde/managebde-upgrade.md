---
title: manage-bde: upgrade
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 23bfa824-6ff0-44cc-9b8b-b199a769fb8d
---
# manage-bde: upgrade
Upgrades the BitLocker version. for examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
manage-bde -upgrade [<Drive>] [-computername <Name>] [{-?|/?}] [{-help|-h}]
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|<Drive>|Represents a drive letter followed by a colon.|
|\-computername|Specifies that manage\-bde.exe will be used to modify BitLocker protection on a different computer. You can also use **\-cn** as an abbreviated version of this command.|
|<Name>|Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address.|
|\-? or \/?|Displays brief help at the command prompt.|
|\-help or \-h|Displays complete help at the command prompt.|

## <a name="BKMK_Examples"></a>Examples
The following example illustrates using the **\-upgrade** command to upgrade BitLocker encryption on drive C.

```
manage-bde –upgrade C:
```

## additional references

-   [Command-Line Syntax Key](../commandline-syntax-key.md)

-   [manage-bde]()

-   [Upgrading a BitLocker\-Protected computer from Windows Vista to Windows 7](https://technet.microsoft.com/library/ee424325(v=ws.10).aspx)


