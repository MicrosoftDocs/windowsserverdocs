---
title: break
description: Reference article for the break command, which breaks the mirrored volume with focus into two simple volumes.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
no-loc: [break]
---

# break

> [!IMPORTANT]
> This command is no longer in use. It is included only to preserve compatibility with existing MS-DOS files, but it has no effect at the command line because the functionality is automatic.

Sets or clears extended CTRL+C checking on MS-DOS systems. If used without parameters, **break** displays the existing setting value.

If command extensions are enabled and running on the Windows platform, inserting the **break** command into a batch file enters a hard-coded breakpoint if being debugged by a debugger.

## Syntax

```
break=[on|off]
```

> [!NOTE]
> Because the break command has no effect, it is often used to create empty files or delete the content of an existing file. For example:

```
rem -- cleans the content of the file --
break>log
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [break command](break.md)
