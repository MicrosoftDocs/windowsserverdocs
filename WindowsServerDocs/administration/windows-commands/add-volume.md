---
title: add volume
description: Reference article for the add volume command, which adds volumes to the shadow copy Set, which is the set of volumes to be shadow copied.
ms.topic: reference
ms.assetid: b7d4d35d-8bda-46d2-8df5-eb598cecaaba
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# add volume

Adds volumes to the Shadow Copy Set, which is the set of volumes to be shadow copied. When a shadow copy is created, an environment variable links the alias to the shadow ID, so the alias can then be used for scripting.

Volumes are added one at a time. Each time a volume is added, it's checked to make sure VSS supports shadow copy creation for that volume. This check can be invalidated by later use of the **set context** command.

This command is necessary to create shadow copies. If used without parameters, **add volume** displays help at the command prompt.

## Syntax

```
add volume <volume> [provider <providerid>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<volume>` | Specifies a volume to add to the Shadow Copy Set. At least one volume is required for shadow copy creation. |
| `[provider \<providerid>]` | Specifies the Provider ID for a registered provider to use to create the shadow copy. If **provider** is not specified, the default provider is used. |

## Examples

To view the current list of registered providers, at the `diskshadow>` prompt, type:

```
list providers
```

The following output displays a single provider, which will be used by default:

```
* ProviderID: {b5946137-7b9f-4925-af80-51abd60b20d5}
        Type: [1] VSS_PROV_SYSTEM
        Name: Microsoft Software Shadow Copy provider 1.0
        Version: 1.0.0.7
        CLSID: {65ee1dba-8ff4-4a58-ac1c-3470ee2f376a}
1 provider registered.
```

To add drive C: to the Shadow Copy Set and assign an alias named *System1*, type:

```
add volume c: alias System1
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [set context command](set-context.md)
