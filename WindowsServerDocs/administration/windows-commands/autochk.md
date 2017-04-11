---
title: autochk
description: "Windows Commands topic for **autochk** - Runs when the computer is started and prior to Windows Server starting to verify the logical integrity of a file system."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8787e6a3-f023-4ea5-b2d1-61c6876d8aff
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# autochk

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Runs when the computer is started and prior to  Windows Server  2008 R2  starting to verify the logical integrity of a file system.
**autochk.exe** is a version of **chkdsk** that runs only on NTFS disks and only before  Windows Server 2008 R2  starts. **autochk** cannot be run directly from the command-line. Instead, **autochk** runs in the following situations:
-   if you try to run **chkdsk** on the boot volume
-   if **chkdsk** cannot gain exclusive use of the volume
-   if the volume is flagged as dirty
## remarks
-   > [!WARNING]
    > The **autochk** command-line tool cannot be directly run from the command-line. Instead, use the **chkntfs** command-line tool to configure the way you want **autochk** to run at startup.
-   You can use **chkntfs** with the **/x** parameter to prevent **autochk** from running on a specific volume or multiple volumes.
-   Use the **chkntfs.exe** command-line tool with the **/t** parameter to change the autochk delay from 0 seconds to up to 3 days (259,200 seconds). However, a long delay means that the computer does not start until the time elapses or until you press a key to cancel **autochk**.
## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[chkdsk](chkdsk.md)
[chkntfs](chkntfs.md)
[Troubleshooting Disks and File Systems](http://go.microsoft.com/fwlink/?LinkId=4527)
