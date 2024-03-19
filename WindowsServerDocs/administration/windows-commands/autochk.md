---
title: autochk
description: Reference article for the autochk command, which runs when the computer is started and prior to Windows Server starting to verify the logical integrity of a file system.
ms.topic: reference
ms.assetid: 8787e6a3-f023-4ea5-b2d1-61c6876d8aff
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# autochk

Runs when the computer is started and prior to Windows Server starting to verify the logical integrity of a file system.

**Autochk.exe** is a version of **chkdsk** that runs only on NTFS disks and only before Windows Server starts. **autochk** cannot be run directly from the command-line. Instead, **autochk** runs in the following situations:

- If you try to run **chkdsk** on the boot volume.

- If **chkdsk** cannot gain exclusive use of the volume.

- If the volume is flagged as dirty.

## Remarks

> [!WARNING]
> The **autochk** command-line tool cannot be directly run from the command-line. Instead, use the **chkntfs** command-line tool to configure the way you want **autochk** to run at startup.
>
> - You can use **chkntfs** with the **/x** parameter to prevent **autochk** from running on a specific volume or multiple volumes.
>
> - Use the **chkntfs.exe** command-line tool with the **/t** parameter to change the autochk delay from 0 seconds to up to 3 days (259,200 seconds). However, a long delay means that the computer does not start until the time elapses or until you press a key to cancel **autochk**.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [chkdsk command](chkdsk.md)

- [chkntfs command](chkntfs.md)
