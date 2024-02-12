---
title: nslookup set root
description: Reference article for the nslookup set root command, which changes the name of the root server that's used for queries.
ms.topic: reference
ms.assetid: 8ad5393c-d4fd-4594-8187-576b1dcde60a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# nslookup set root

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Changes the name of the root server used for queries.

> [!NOTE]
> This command supports the [nslookup root](nslookup-root.md) command.

## Syntax

```
set root=<rootserver>
```

### Parameters

| Parameter | Description |
| ---------- | ---------- |
| `<rootserver>` | Specifies the new name for the root server. The default value is **ns.nic.ddn.mil**. |
| /? | Displays help at the command prompt. |
| /help | Displays help at the command prompt. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [nslookup root](nslookup-root.md)
