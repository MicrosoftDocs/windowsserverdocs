---
title: attrib
description: Reference article for the attrib command that displays, sets, or removes attributes assigned to files or directories.
ms.topic: reference
ms.assetid: 5e763ca5-21a2-45d2-b26d-a9c44c99091a
ms.author: wscontent
author: xelu86
ms.date: 09/22/2023
---

# attrib

Displays, sets, or removes attributes assigned to files or directories. If used without parameters, **attrib** displays attributes of all files in the current directory.

## Syntax

```
attrib [{+|-}r] [{+|-}a] [{+|-}s] [{+|-}h] [{+|-}o] [{+|-}i] [{+|-}x] [{+|-}p] [{+|-}u] [{+|-}b] [<drive>:][<path>][<filename>] [/s [/d] [/l]]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `{+\|-}r` | Sets (**+**) or clears (**-**) the Read-only file attribute. |
| `{+\|-}a` | Sets (**+**) or clears (**-**) the Archive file attribute. This attribute set marks files that have changed since the last time they were backed up. The **xcopy** command uses archive attributes. |
| `{+\|-}s` | Sets (**+**) or clears (**-**) the System file attribute. If a file uses this attribute set, you must clear the attribute before you can change any other attributes for the file. |
| `{+\|-}h` | Sets (**+**) or clears (**-**) the Hidden file attribute. If a file uses this attribute set, you must clear the attribute before you can change any other attributes for the file. |
| `{+\|-}o` | Sets (**+**) or clears (**-**) the Offline file attribute. |
| `{+\|-}i` | Sets (**+**) or clears (**-**) the Not Content Indexed file attribute. |
| `{+\|-}x` | Sets (**+**) or clears (**-**) the Scrub file attribute. |
| `{+\|-}p` | Sets (**+**) or clears (**-**) the Pinned file attribute. |
| `{+\|-}u` | Sets (**+**) or clears (**-**) the Unpinned file attribute. |
| `{+\|-}b` | Sets (**+**) or clears (**-**) the SMR Blob file attribute. |
| `[<drive>:][<path>][<filename>]` | Specifies the location and name of the directory, file, or group of files that you want to view or change attributes.<br>You can use the **?** and **\*** wildcard characters in the *filename* parameter to display or change the attributes for a group of files. |
| /s | Applies **attrib** and any command-line options to matching files in the current directory and all of its subdirectories. |
| /d | Applies **attrib** and any command-line options to directories. |
| /l | Applies **attrib** and any command-line options to the Symbolic Link, rather than the target of the Symbolic Link. |
| /? | Displays help at the command prompt. |

## Examples

To display the attributes of a file named News86 that is located in the current directory, type:

```
attrib news86
```

To assign the Read-only attribute to the file named report.txt, type:

```
attrib +r report.txt
```

To remove the Read-only attribute from files in the public directory and its subdirectories on a disk in drive b:, type:

```
attrib -r b:\public\*.* /s
```

To set the Archive attribute for all files on drive a:, and then clear the Archive attribute for files with the .bak extension, type:

```
attrib +a a:*.* & attrib -a a:*.bak
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
- [xcopy command](xcopy.md)
