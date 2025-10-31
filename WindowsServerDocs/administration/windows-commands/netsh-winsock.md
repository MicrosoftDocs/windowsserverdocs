---
title: netsh winsock
description: The netsh winsock command manages the Windows Sockets (Winsock) API network communication in Windows.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 08/12/2025
---

# netsh winsock

The `netsh winsock` command manages the Windows Sockets (Winsock) API, which is responsible for network communication between applications and network services.

## Syntax

```
netsh winsock [audit | dump | help | remove | reset | set | show | ?]
```

```
netsh winsock audit trail
netsh winsock dump
netsh winsock remove provider <catalog id>
netsh winsock reset
netsh winsock set autotuning <on|off>
netsh winsock show <autotuning> <catalog>
```

## Parameters

| Command | Description |
|--|--|
| winsock `audit trail` | Displays the audit trail of Layered Service Providers (LSP) that are installed and uninstalled. |
| winsock `dump` | Creates a script containing the current Winsock configuration. The script can be saved to a file and used to restore settings if they're altered or need to be replicated on another system. |
| winsock `remove provider` `<catalog id>` | Removes a specific Winsock LSP from the system using its catalog ID. This ID can be found when you run `winsock show catalog`. The Namespace Providers are presented as a GUID rather than a catalog ID. |
| winsock `reset` | Resets the Winsock catalog to a clean state, removing any custom LSPs to resolve network problems caused by corrupted Winsock settings. It doesn't affect Winsock Name Space Provider entries. |
| winsock `set autotuning` | This command toggles Winsock send autotuning, which enables dynamic send buffering to improve overall network throughput. Options are `on` or `off`. |
| winsock `show` | `autotuning` - Displays whether Winsock send autotuning is currently enabled or disabled. <br><br> `catalog` - Displays the contents of the Winsock catalog, listing all registered Winsock LSPs and namespace providers. |
| `help` *or* `?` | Displays a list of commands and their descriptions in the current context. |

## Examples

To view the audit trail of LSPs, run the following command:

```cmd
netsh winsock audit trail
```

To remove a specific Winsock LSP using its catalog ID, run the following command:

```cmd
netsh winsock remove provider <catalog_id>
```

To enable Winsock send autotuning for better throughput, run the following command:

```cmd
netsh winsock set autotuning on
```

To display the contents of the Winsock catalog, run the following command:

```cmd
netsh winsock show catalog
```

## See also

- [Command-Line Syntax Key](command-line-syntax-key.md)
