---
title: autochk
description: "Windows Commands topic for **autochk** - Runs when the computer is started and prior to Windows Server starting to verify the logical integrity of a file system."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8787e6a3-f023-4ea5-b2d1-61c6876d8aff
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# autochk



Runs when the computer is started and prior to Windows Server® 2008 R2 starting to verify the logical integrity of a file system.

**Autochk.exe** is a version of **Chkdsk** that runs only on NTFS disks and only before Windows Server 2008 R2 starts. **Autochk** cannot be run directly from the command-line. Instead, **Autochk** runs in the following situations:
-   If you try to run **Chkdsk** on the boot volume
-   If **Chkdsk** cannot gain exclusive use of the volume
-   If the volume is flagged as dirty

## Remarks

> -   [!WARNING]
>     The **Autochk** command-line tool cannot be directly run from the command-line. Instead, use the **Chkntfs** command-line tool to configure the way you want **Autochk** to run at startup.
> -   You can use **Chkntfs** with the **/x** parameter to prevent **Autochk** from running on a specific volume or multiple volumes.
> -   Use the **Chkntfs.exe** command-line tool with the **/t** parameter to change the Autochk delay from 0 seconds to up to 3 days (259,200 seconds). However, a long delay means that the computer does not start until the time elapses or until you press a key to cancel **Autochk**.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

[Chkdsk](chkdsk.md)

[Chkntfs](chkntfs.md)

[Troubleshooting Disks and File Systems](https://go.microsoft.com/fwlink/?LinkId=4527)