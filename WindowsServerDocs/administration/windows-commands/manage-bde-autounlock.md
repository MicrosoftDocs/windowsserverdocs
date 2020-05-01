---
title: manage-bde autounlock
description: Reference topic for **** - 

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: 063528bf-d235-4b44-887a-52a7d983e01a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# manage-bde: autounlock



Manages the automatic unlocking of BitLocker-protected data drives.

## Syntax

```
manage-bde -autounlock [{-enable|-disable|-clearallkeys}] <Drive> [-computername <Name>] [{-?|/?}] [{-help|-h}]

```

#### Parameters

|Parameter|Description|
|---------|-----------|
|-enable|Enables automatic unlocking for a data drive.|
|-disable|Disables automatic unlocking for a data drive.|
|-clearallkeys|Removes all stored external keys on the operating system drive.|
|\<Drive>|Represents a drive letter followed by a colon.|
|-computername|Specifies that Manage-bde.exe will be used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command.|
|\<Name>|Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address.|
|-? or /?|Displays brief Help at the command prompt.|
|-help or -h|Displays complete Help at the command prompt.|

## Examples

To illustrates using the **-autounlock** command to enable automatic unlocking of data drive E.
```
manage-bde –autounlock -enable E:
```

## Additional References

-   - [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Manage-bde](manage-bde.md)