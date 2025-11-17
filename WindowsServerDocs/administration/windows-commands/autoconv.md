---
title: autoconv
description: Reference article for the autoconv command, which converts file allocation table (Fat) and Fat32 volumes to the NTFS file system.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# autoconv



Converts file allocation table (Fat) and Fat32 volumes to the NTFS file system, leaving existing files and directories intact at startup after **autochk** runs. volumes converted to the NTFS file system cannot be converted back to Fat or Fat32.

> [!IMPORTANT]
> You can't run **autoconv** from the command-line. This can only run at startup, if set through **convert.exe**.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [autochk command](autochk.md)

- [convert command](convert.md)
