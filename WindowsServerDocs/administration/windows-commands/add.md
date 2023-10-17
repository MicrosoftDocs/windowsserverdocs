---
title: add (diskshadow)
description: Reference article for the add command, which adds volumes to the set of volumes that are to be shadow copied, or adds aliases to the alias environment.
ms.topic: reference
ms.assetid: 47efce7a-86d2-4872-ae31-baa108757afd
ms.author: wscontent
author: xelu86
ms.date: 10/13/2023
---

# add (diskshadow)

Adds volumes to the set of volumes that are to be shadow copied, or adds aliases to the alias environment. If used without subcommands, **add** lists the current volumes and aliases.

> [!NOTE]
> Aliases are not added to the alias environment until the shadow copy is created. Aliases that you need immediately should be added by using **add alias**.

## Syntax

```
add
add volume <volume> [provider <providerid>]
add alias <aliasname> <aliasvalue>
```

### Parameters

| Parameter | Description |
| ---------- | ----------- |
| volume | Adds a volume to the Shadow Copy Set, which is the set of volumes to be shadow copied. See [add volume](add-volume.md) for syntax and parameters. |
| alias | Adds the given name and value to the alias environment. See [add alias](add-alias.md) for syntax and parameters. |
| /? | Displays help at the command line. |

## Examples

To display the volumes added and the aliases that are currently in the environment, type:

```
add
```

The following output shows that drive C has been added to the Shadow Copy Set:

```
Volume c: alias System1    GUID \\?\Volume{XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}\
1 volume in Shadow Copy Set.
No Diskshadow aliases in the environment.
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
