---
title: manage-bde keypackage
description: Reference article for the manage-bde keypackage command, which generates a key package for a drive.
ms.topic: reference
ms.assetid: c631ef10-2a2f-4541-8578-292f2d4e9e80
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# manage-bde keypackage

Generates a key package for a drive. The key package can be used in conjunction with the repair tool to repair corrupted drives.

## Syntax

```
manage-bde -keypackage [<drive>] [-ID <keyprotectoryID>] [-path <pathtoexternalkeydirectory>] [-computername <name>] [{-?|/?}] [{-help|-h}]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<drive>` | Represents a drive letter followed by a colon. |
| -ID | Creates a key package using the key protector with the identifier specified by this ID value. **Tip:** Use the **manage-bde –protectors –get** command, along with the drive letter that you want to create a key package for, to get a list of available GUIDs to use as the ID value. |
| -path | Specifies the location to save the created key package. |
| -computername | Specifies that manage-bde.exe will be used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command. |
| `<name>` | Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address. |
| -? or /? | Displays brief Help at the command prompt. |
| -help or -h | Displays complete Help at the command prompt. |

### Examples

To create a key package for drive C, based on the key protector identified by the GUID, and to save the key package to F:\Folder, type:

```
manage-bde -keypackage C: -id {84E151C1...7A62067A512} -path f:\Folder
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [manage-bde command](manage-bde.md)
