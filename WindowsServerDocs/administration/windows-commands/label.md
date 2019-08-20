---
title: label
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bbae8bdd-97d4-4566-9118-7c95aa07645f
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# label



Creates, changes, or deletes the volume label (that is, the name) of a disk. If used without parameters, the **label** command changes the current volume label or deletes the existing label.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
label [/mp] [<Volume>] [<Label>]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|/mp|Specifies that the volume should be treated as a mount point or volume name.|
|\<Volume>|Specifies a drive letter (followed by a colon), mount point, or volume name. If a volume name is specified, the **/mp** parameter is unnecessary.|
|\<Label>|Specifies the label for the volume.|
|/?|Displays help at the command prompt.|

## Remarks

- Windows displays the volume label and serial number (if it has one) as part of the directory listing.
- An NTFS volume label can be up to 32 characters in length, including spaces. NTFS volume labels retain and display the case that was used when the label was created.
- If you do not specify a value for the **Label** parameter, the **label** command displays output in the following format:  
  ```
  Volume in drive C: xxxxxxxxxxx 
  Volume Serial Number is xxxx-xxxx 
  Volume label (32 characters, ENTER for none)?
  ```  
  You can type a new volume label or press ENTER to keep the current label. If you press ENTER and the volume currently has a label, the **label** command prompts you with the following message:  
  ```
  Delete current volume label (Y/N)?
  ```  
  Press Y to delete the label, or press N to keep the label.

## <a name="BKMK_examples"></a>Examples

To label a disk in drive A that contains sales information for July, type:
```
label a:sales-july
```
To delete the current label for drive C, follow these steps:
1. At the command prompt, type:  
   ```
   Label
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
3. Press Y to delete the current label.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)