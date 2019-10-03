---
title: add volume
description: "Windows Commands topic for **add volume** - adds volumes to the shadow copy Set, which is the set of volumes to be shadow copied."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b7d4d35d-8bda-46d2-8df5-eb598cecaaba
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017

---

# add volume



Adds volumes to the Shadow Copy Set, which is the set of volumes to be shadow copied. This command is necessary to create shadow copies. If used without parameters, **add volume** displays help at the command prompt.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
add volume <Volume> [provider <ProviderID>]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<Volume>|Specifies a volume to add to the Shadow Copy Set. At least one volume is required for shadow copy creation.|
|[provider \<ProviderID>]|Specifies the Provider ID of a registered provider to use to create the shadow copy. If **provider** is not specified, the default provider is used.|

## Remarks

-   Volumes are added one at a time.
-   Each time a volume is added, it is checked to ensure that VSS supports shadow copy creation of that volume. This primary check may be invalidated, however, by later use of the **set context** command.
-   When a shadow copy is created, an environment variable links the alias to the shadow ID, so the alias can then be used for scripting.

## <a name="BKMK_examples"></a>Examples

To view the current list of registered providers, at the `DISKSHADOW>` prompt, type:
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
To add drive C to the Shadow Copy Set and assign an alias named System1, type:
```
add volume c: alias System1
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)