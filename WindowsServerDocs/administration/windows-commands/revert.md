---
title: revert
description: Reference article for the revert command, which reverts a volume back to a specified shadow copy.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# revert

Reverts a volume back to a specified shadow copy. This is supported only for shadow copies in the CLIENTACCESSIBLE context. These shadow copies are persistent and can only be made by the system provider. If used without parameters, **revert** displays help at the command prompt.

## Syntax

```
revert <shadowcopyID>
```

### Parameters

| Parameter | Description |
|--|--|
| `<shadowcopyID>` | Specifies the shadow copy ID to revert the volume to. If you don't use this parameter, the command displays help at the command prompt. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
