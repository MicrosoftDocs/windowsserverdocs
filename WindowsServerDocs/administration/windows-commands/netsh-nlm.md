---
title: netsh nlm
description: The netsh nlm command manages the Network Location Manager (NLM) settings to override network connection quality classification in Windows.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/09/2025
---

# netsh nlm

The `netsh nlm` command allows admins to manage the Network Location Manager (NLM) settings and behavior by manually overriding how Windows classifies the network connection quality.

## Syntax

```
netsh nlm [ dump | enum | help | query | set | show | ?]
```

```
netsh nlm enum <connection> <network>
```

```
netsh nlm query all
```

```
netsh nlm set connectionquality [<guid> [good|bad|ignore]]
```

```
netsh nlm show <connectivity> <cost>
```

## Parameters

| Command | Description |
|--|--|
| nlm `dump` | Creates a script containing the current context configuration. The script can be saved to a file and used to restore settings if they're altered or need to be replicated on another system. |
| nlm `enum` | `connection` - Enumerates the current INetworkConnection objects. <br> `network` - Enumerates the current INetwork objects. |
| nlm `query all` | Queries all network states from all supported services and writes to a file. A file path and name must be specified to save results. |
| nlm `set connectionquality` | Manually sets the connection quality of a network interface, overriding the connection quality classification by the Network classifier. <br><br> `guid` - Is the interface GUID. <br> `good` - Forces Windows to consider the specified network interface’s connection quality as stable and reliable. <br> `bad` - Forces Windows to consider the specified network interface’s connection quality as unreliable where certain features might disable themselves, or services might limit their operations. <br> `ignore` - Forces Windows to not override its own assessment. Windows determines the connection quality by itself, based on its normal detection algorithms (reverting automatic classification). |
| nlm `show` | `connectivity` - Displays the current connectivity state from the INetworkListManager. <br> `cost` - Displays the current cost from the INetworkCostManager. |
| `help` *or* `?` | Displays a list of commands and their descriptions in the current context. |

## Examples

To enumerate the current network connections, run the following command:

```cmd
netsh nlm enum connection
```

To query all network states and save the results to a file, run the following command:

```cmd
netsh nlm query all <Filepath\Filename>
```

To manually set the connection quality of a network interface to "good", run the following command:

```cmd
netsh nlm set connectionquality <My_GUID> good
```

To display the current connectivity state, run the following command:

```cmd
netsh nlm show connectivity
```

## See also

- [Command-Line Syntax Key](command-line-syntax-key.md)
