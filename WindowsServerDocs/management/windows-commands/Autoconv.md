---
title: Autoconv
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 17281e54-0b18-4e84-94ac-24586c82df4e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Autoconv

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Converts file allocation table (FAT) and FAT32 volumes to the NTFS file system, leaving existing files and directories intact at startup after **Autochk** runs. Volumes converted to the NTFS file system cannot be converted back to FAT or FAT32.
## Remarks
You cannot run **Autoconv** on the command-line. This will only be run at startup, if set through **Convert.exe**.
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Autochk](Autochk.md)
[Convert](Convert.md)
[Working with File Systems](http://go.microsoft.com/fwlink/?LinkId=4509)
