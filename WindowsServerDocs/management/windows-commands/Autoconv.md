---
title: autoconv
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 17281e54-0b18-4e84-94ac-24586c82df4e
---
# autoconv
converts file allocation table \(Fat\) and Fat32 volumes to the NTFS file system, leaving existing files and directories intact at startup after **autochk** runs. volumes converted to the NTFS file system cannot be converted back to Fat or Fat32.

## remarks
You cannot run **autoconv** on the command\-line. This will only be run at startup, if set through **convert.exe**.

## additional references
[Command-Line Syntax Key](commandline-syntax-key.md)

[autochk](autochk.md)

[convert](convert.md)

[Working with File Systems](http://go.microsoft.com/fwlink/?LinkId=4509)


