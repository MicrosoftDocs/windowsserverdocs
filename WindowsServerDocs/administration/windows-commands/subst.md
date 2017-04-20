---
title: subst
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3e69234c-2312-4343-868b-afc1017c622a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# subst

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

associates a path with a drive letter. If used without parameters, **subst** displays the names of the virtual drives in effect.
for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
subst [<Drive1>: [<Drive2>:]<path>] 
subst <Drive1>: /d
```
## Parameters
|Parameter|Description|
|-------|--------|
|<Drive1>:|Specifies the virtual drive to which you want to assign a path.|
|[<Drive2>:]<path>|Specifies the physical drive and path that you want to assign to a virtual drive.|
|/d|deletes a substituted (virtual) drive.|
|/?|Displays help at the command prompt.|
## remarks
-   The following commands do not work and should not be used on drives that are specified in the **subst** command:
    **chkdsk**
    **diskcomp**
    **diskcopy**
    **format**
    **label**
    **recover**
-   The *Drive1* parameter must be within the range that is specified by the **lastdrive** command. If not, **subst** displays the following error message:
    `Invalid parameter - drive1:`
## <a name="BKMK_examples"></a>Examples
To create a virtual drive Z for the path B:\User\Betty\forms, type:
```
subst z: b:\user\betty\forms 
```
Instead of typing the full path, you can reach this directory by typing the letter of the virtual drive followed by a colon as follows:
```
z: 
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
