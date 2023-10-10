---
title: list providers
description: Reference article for the list providers command, which lists shadow copy providers that are currently registered on the system.
ms.topic: reference
ms.assetid: 844b4036-c0b9-449d-8347-7d58ef9bf16d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# list providers

Lists shadow copy providers that are currently registered on the system.

## Syntax

```
list providers
```

### Examples

To list the currently registered shadow copy providers, type:

```
list providers
```

Output that is similar to the following displays:

```
* ProviderID: {b5946137-7b9f-4925-af80-51abd60b20d5}
        Type: [1] VSS_PROV_SYSTEM
        Name: Microsoft Software Shadow Copy provider 1.0
        Version: 1.0.0.7
        CLSID: {65ee1dba-8ff4-4a58-ac1c-3470ee2f376a}
1 provider registered.
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)