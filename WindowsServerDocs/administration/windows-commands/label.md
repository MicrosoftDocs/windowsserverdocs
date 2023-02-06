---
title: label
description: Reference article for the label command, which creates, changes, or deletes the volume label (that is, the name) of a disk.
ms.topic: reference
ms.assetid: bbae8bdd-97d4-4566-9118-7c95aa07645f
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# label

Creates, changes, or deletes the volume label (that is, the name) of a disk. If used without parameters, the **label** command changes the current volume label or deletes the existing label.

## Syntax

```
label [/mp] [<volume>] [<label>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /mp | Specifies that the volume should be treated as a mount point or volume name. |
| `<volume>` | Specifies a drive letter (followed by a colon), mount point, or volume name. If a volume name is specified, the **/mp** parameter is unnecessary. |
| `<label>` | Specifies the label for the volume. |
| /? | Displays help at the command prompt. |

## Remarks

- Windows displays the volume label and serial number (if it has one) as part of the directory listing.

- An NTFS volume label can be up to 32 characters in length, including spaces. NTFS volume labels retain and display the case that was used when the label was created.

## Examples

To label a disk in drive A that contains sales information for July, type:

```
label a:sales-july
```

To view and delete the current label for drive C, follow these steps:

1. At the command prompt, type:

   ```
   label
   ```

   Output similar to the following should be displayed:

   ```
   Volume in drive C: is Main Disk
   Volume Serial Number is 6789-ABCD
   Volume label (32 characters, ENTER for none)?
   ```

2. Press ENTER. The following prompt should be displayed:

   ```
   Delete current volume label (Y/N)?
   ```

3. Press **Y** to delete the current label, or **N** if you want to keep the existing label.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)