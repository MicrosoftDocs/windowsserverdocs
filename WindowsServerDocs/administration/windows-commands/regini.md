---
title: regini
description: Reference article for the regini command, which modifies the registry from the command line or a script, and applies changes that were preset in one or more text files.
ms.topic: reference
ms.assetid: 5ff18dc3-5bd8-400a-b311-fd73a3267e8c
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 07/11/2018
---

# regini

Modifies the registry from the command line or a script, and applies changes that were preset in one or more text files. You can create, modify, or delete registry keys, in addition to modifying the permissions on the registry keys.

For details on the format and content of the text script file that regini.exe uses to make changes to the registry, see [How to change registry values or permissions from a command line or a script](https://support.microsoft.com/help/264584/how-to-change-registry-values-or-permissions-from-a-command-line-or-a).

## Syntax

```
regini [-m \\machinename | -h hivefile hiveroot][-i n] [-o outputwidth][-b] textfiles...
```

### Parameters

| Parameter | Description |
|--|--|
| -m `<\\computername>` | Specifies the remote computer name with a registry that is to be modified. Use the format **\\ComputerName**. |
| -h `<hivefile hiveroot>` | Specifies the local registry hive to modify. You must specify the name of the hive file and the root of the hive in the format **hivefile hiveroot**. |
| -i `<n>` | Specifies the level of indentation to use to indicate the tree structure of registry keys in the command output. The **regdmp.exe** tool (which gets a registry key's current permissions in binary format) uses indentation in multiples of four, so the default value is **4**. |
| -o `<outputwidth>` | Specifies the width of the command output, in characters. If the output will appear in the command window, the default value is the width of the window. If the output is directed to a file, the default value is **240** characters. |
| -b | Specifies that **regini.exe** output is backward compatible with previous versions of **regini.exe**. |
| textfiles | Specifies the name of one or more text files that contain registry data. Any number of ANSI or Unicode text files can be listed. |

#### Remarks

The following guidelines apply primarily to the content of the text files that contain registry data that you apply by using **regini.exe**.

- Use the semicolon as an end-of-line comment character. It must be the first non-blank character in a line.

- Use the backslash to indicate continuation of a line. The command will ignore all characters from the backslash up to (but not including) the first non-blank character of the next line. If you include more than one space before the backslash, it is replaced by a single space.

- Use hard-tab characters to control indentation. This indentation indicates the tree structure of the registry keys; however, these characters are converted to a single space regardless of their position.

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
