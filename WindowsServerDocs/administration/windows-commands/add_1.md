---
title: add
description: "Windows Commands topic for **add_1** - adds volumes to the set of volumes that are to be shadow copied, or adds aliases to the alias environment."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 47efce7a-86d2-4872-ae31-baa108757afd

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# add


Adds volumes to the set of volumes that are to be shadow copied, or adds aliases to the alias environment. If used without subcommands, **add** lists the current volumes and aliases.

> [!NOTE]
> Aliases are not added to the alias environment until the shadow copy is created. Aliases that you need immediately should be added by using **add alias**.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
add 
add volume <Volume> [provider <ProviderID>] 
add alias <AliasName> <AliasValue>
```

## Add subcommands

|Subcommand|Description|
|----------|-----------|
|volume|Adds a volume to the Shadow Copy Set, which is the set of volumes to be shadow copied. See [Add volume](add-volume.md) for syntax and parameters.|
|alias|Adds the given name and value to the alias environment. See [Add alias](add-alias.md) for syntax and parameters.|
|/?|Displays help at the command line.|

## <a name="BKMK_examples"></a>Examples

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

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)