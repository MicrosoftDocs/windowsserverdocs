---
title: netsh namespace
description: The netsh namespace command retrieves namespace policies in Windows.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 07/29/2025
---

# netsh namespace

The `netsh namespace` command retrieves and displays namespace policy information from a Windows system.

## Syntax

```
netsh namespace [dump] [show] [help] [?]
netsh namespace show <effectivepolicy> <policy> [namespace=] <string>
```

## Parameters

| Parameter | Description |
|--|--|
| `dump` | Outputs a configuration script containing the current namespace policy settings. This script can be saved and used to restore settings if needed. |
| `show` | Displays information about namespace policies. <br><br><li> `effectivepolicy` - Displays the effective namespace policies in place. You can specify a namespace to view only the relevant policy entries for that namespace. <li> `policy` - Displays the entries in the namespace policy table. You can specify a namespace to restrict the output to policies specific to that namespace. |
| `help` or `?` | Provides help for the list of commands available in the `netsh namespace` context. |

## Examples

To retrieve the policies for a specific namespace, run the following command:

```cmd
netsh namespace show policy namespace=[YourNamespace]
```

## See also

- [Command-Line Syntax Key](command-line-syntax-key.md)
