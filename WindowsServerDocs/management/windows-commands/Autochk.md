---
title: autochk
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8787e6a3-f023-4ea5-b2d1-61c6876d8aff
---
# autochk
Runs when the computer is started and prior to  Windows Server® 2008 R2  starting to verify the logical integrity of a file system.

**autochk.exe** is a version of **Chkdsk** that runs only on NTFS disks and only before  Windows Server 2008 R2  starts. **autochk** cannot be run directly from the command\-line. Instead, **autochk** runs in the following situations:

-   if you try to run **Chkdsk** on the boot volume

-   if **Chkdsk** cannot gain exclusive use of the volume

-   if the volume is flagged as dirty

## remarks

-   > [!WARNING]
    > The **autochk** command\-line tool cannot be directly run from the command\-line. Instead, use the **chkntfs** command\-line tool to configure the way you want **autochk** to run at startup.

-   You can use **chkntfs** with the **\/x** parameter to prevent **autochk** from running on a specific volume or multiple volumes.

-   Use the **chkntfs.exe** command\-line tool with the **\/t** parameter to change the autochk delay from 0 seconds to up to 3 days \(259,200 seconds\). However, a long delay means that the computer does not start until the time elapses or until you press a key to cancel **autochk**.

## additional references
[Command-Line Syntax Key](commandline-syntax-key.md)

[Chkdsk]()

[chkntfs](chkntfs.md)

[Troubleshooting Disks and File Systems](http://go.microsoft.com/fwlink/?LinkId=4527)


