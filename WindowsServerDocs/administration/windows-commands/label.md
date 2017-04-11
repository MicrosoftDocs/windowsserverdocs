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
ms.date: 10/12/2016
---
# label

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

creates, changes, or deletes the volume label (that is, the name) of a disk. If used without parameters, the **label** command changes the current volume label or deletes the existing label.
for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
label [/mp] [<volume>] [<label>]
```
## Parameters
|Parameter|Description|
|-------|--------|
|/mp|Specifies that the volume should be treated as a mount point or volume name.|
|<volume>|Specifies a drive letter (followed by a colon), mount point, or volume name. If a volume name is specified, the **/mp** parameter is unnecessary.|
|<label>|Specifies the label for the volume.|
|/?|Displays help at the command prompt.|
## remarks
-   Windows displays the volume label and serial number (if it has one) as part of the directory listing.
-   An NTFS volume label can be up to 32 characters in length, including spaces. NTFS volume labels retain and display the case that was used when the label was created.
-   if you do not specify a value for the **label** parameter, the **label** command displays output in the following format:
    ```
    volume in drive C: xxxxxxxxxxx 
    volume Serial Number is xxxx-xxxx 
    volume label (32 characters, ENTER for none)?
    ```
    You can type a new volume label or press ENTER to keep the current label. If you press ENTER and the volume currently has a label, the **label** command prompts you with the following message:
    ```
    delete current volume label (Y/N)?
    ```
    Press Y to delete the label, or press N to keep the label.
## <a name="BKMK_examples"></a>Examples
To label a disk in drive A that contains sales information for July, type:
```
label a:sales-july
```
To delete the current label for drive C, follow these steps:
1.  at the command prompt, type:
    ```
    label
    ```
    Output similar to the following should be displayed:
    ```
    volume in drive C: is Main Disk
    volume Serial Number is 6789-ABcd
    volume label (32 characters, ENTER for none)?
    ```
2.  Press ENTER. The following prompt should be displayed:
    ```
    delete current volume label (Y/N)?
    ```
3.  Press Y to delete the current label.
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
