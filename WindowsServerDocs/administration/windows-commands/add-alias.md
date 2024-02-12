---
title: add alias
description: Reference article for the add alias command, which adds aliases to the alias environment.
ms.topic: reference
ms.assetid: 5fe12f5d-11e9-4f3d-b7f9-40b26c8685e5
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# add alias

Adds aliases to the alias environment. If used without parameters, **add alias** displays help at the command prompt. Aliases are saved in the metadata file and will be loaded with the **load metadata** command.

## Syntax

```
add alias <aliasname> <aliasvalue>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<aliasname>` | Specifies the name of the alias. |
| `<aliasvalue>` | Specifies the value of the alias. |
| `? | Displays help at the command prompt. |

## Examples

To list all shadows, including their aliases, type:

```
list shadows all
```

The following excerpt shows a shadow copy to which the default alias, *VSS_SHADOW_x*, has been assigned:

```
* Shadow Copy ID = {ff47165a-1946-4a0c-b7f4-80f46a309278}
%VSS_SHADOW_1%
```

To assign a new alias with the name *System1* to this shadow copy, type:

```
add alias System1 %VSS_SHADOW_1%
```

Alternatively, you can assign the alias by using the shadow copy ID:

```
add alias System1 {ff47165a-1946-4a0c-b7f4-80f46a309278}
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [load metadata command](load-metadata.md)
