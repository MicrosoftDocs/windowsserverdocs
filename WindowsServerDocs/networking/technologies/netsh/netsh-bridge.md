---
title: Netsh Commands for a network bridge of different network adapters.
description: Use Netsh bridge commands to create and manage a bridge of network adapters for sharing connectivity.
author: hiepkhuuMS
ms.author: msedgedevrel
ms.topic: how-to 
ms.date: 09/09/2022
---

# Netsh bridge

Use `netsh bridge` commands to create and manage a network bridge of at least two network adapters. The network bridge shares the network connectivity and resources of one network adapter with the other.

> [!NOTE]
>
> - This command is available beginning with 2023-09 Cumulative Update for Windows 11,
> version 22H2 ([KB5030310](https://support.microsoft.com/help/5030310)).
>
> - The `netsh bridge` commands is not available on Windows Server 2022 and earlier.

## Netsh bridge commands

The available commands are:

| Command | Description |
|--|--|
| [help](#netsh-bridge-help) | Display a list of commands for the `netsh bridge` context. |
| [list](#netsh-bridge-list-bridge) | List all available bridges by their unique bridge GUIDs. |
| [show adapter](#netsh-bridge-show-adapter) | List all network adapters that can be bridged and network adapters that already form a bridge. |
| [create](#netsh-bridge-create-bridge) | Create a bridge using least two network adapters. |
| [add](#netsh-bridge-add) | Add a network adapter to an existing bridge. |
| [remove](#netsh-bridge-remove) | Remove a bridged network adapter from an existing bridge. |
| [remove all from](#netsh-bridge-remove-all-from) | Remove all bridged network adapters from an existing bridge and  destroy the bridge. |
| [destroy](#netsh-bridge-destroy) | Remove all bridged network adapters from an existing bridge and destroy the bridge. |

## Netsh bridge syntax

```dos
netsh bridge list

netsh bridge show adapter

netsh bridge create [<Adapter ID 1> <Adapter ID 2>]

netsh bridge add [<Adapter ID>] to [<Bridge GUID>]

netsh bridge remove [<Adapter ID>] from [<Bridge GUID>]

netsh bridge remove all from [<Bridge GUID>]

netsh bridge destroy [<Bridge GUID>]
```

## Netsh bridge help

The help command provides more detailed information about the supported `netsh bridge` commands.

### Netsh bridge help parameters

| Parameter | Description |
|--|--|
| `<command>` | Shows information about the commands. |

### Netsh bridge help examples

The following command is an example of the command to show all supported Netsh bridge commands.

```dos
netsh bridge help
```

The following output shows the supported commands and their descriptions.

```output
The following commands are available:
Commands in this context:
?       - Display a list of commands
help    - Display a list of commands
list    - Display all available created bridges.
show    - Displays information (i.e. adapter).
add     - Add a network adapter onto an existing bridge
create  - Create a bridge with two user-provided network adapters.
destroy - Remove ALL bridged network adapters from the existing bridge and destroy the bridge.
remove  - Remove network adapter from a bridge, and destroy the bridge automatically when all network adapters are removed.
dump    - Displays a configuration script.
set     - Sets configuration information
```

## Netsh bridge list bridge

Command lists all available created bridges, identified by their unique bridge GUIDs.

### Netsh bridge list bridge examples

The following command is an example of this command and its expected result:

```dos
netsh bridge list
```

The following output lists the bridge GUIDs for each configured bridge.

```output

```output
-------------------------------------------------------------
GUID                                Bridge Name
-------------------------------------------------------------
{Uniquely generated Bridge GUID}    Network Bridge
-------------------------------------------------------------
```

## Netsh bridge show adapter

The command shows the bridgeable network adapters and any network adapters that form a bridge.

Each adapter is identified with its unique ID, which can be adapter GUID or interface index (namely, IfIndex) or Adapter Name.

### Netsh bridge show adapter examples

The following command is an example of this command.

```dos
netsh bridge show adapter
```

The following output lists network adapters that can be added to a bridge, and any network adapters already in a bridge.

```output
------------------------------------------------------------------------------------------
IfIndex GUID                        Adapter Name        IsBridged Bridgeable Compatibility
------------------------------------------------------------------------------------------
1       <Wi-Fi Interface GUID>      Wi-Fi                   No        Yes      disabled
4       <Ethernet Interface GUID>   Ethernet                No        Yes      disabled
------------------------------------------------------------------------------------------
```

## Netsh bridge create bridge

Creates a bridge of at least two network adapters joining onto the bridge. Providing two network adapters are required as parameters for the command. A successfully created bridge is identified with its unique bridge GUID and can be confirmed using the command `netsh bridge list`.

### Netsh bridge create bridge parameters

| Parameter | Description | Requirement |
|--|--|--|
| `Adapter ID` | Uniquely identifies a network adapter that can join a bridge, and can be acquired from command `netsh bridge show adapters`. An adapter ID can be either of followings: `GUID` or `Adapter Name`, or `IfIndex` | Required |

### Netsh bridge create bridge examples

#### Example 1: Create a bridge of two network adapters by IfIndex

The following command is an example of this command providing `IfIndex` parameters.

```dos
netsh bridge create 1 4
```

The following output shows the bridge GUID for the newly created bridge, confirming the interface indexes used.

```output
Successfully added adapter 1 onto the bridge.
Successfully added adapter 4 onto the bridge.
```

#### Example 2: Create a bridge of two network adapters by adapter GUID

The following command is an example of this command providing `Adapter GUID` parameters.

```dos
netsh bridge create [<Wi-Fi Interface GUID>] [<Ethernet Interface GUID>]
```

The following output shows the bridge GUID for the newly created bridge, confirming the adapter GUIDs used.

```output
Successfully added adapter <Wi-Fi Interface GUID> onto the bridge.
Successfully added adapter <Ethernet Interface GUID> onto the bridge.
```

#### Example 3: Create a bridge of two network adapters by adapter name

The following command is an example of this command providing `Adapter Name` parameters.

```dos
netsh bridge create "Wi-Fi" "Ethernet"
```

The output shows the bridge GUID for the newly created bridge, confirming the adapter names used.

```output
Successfully added adapter Wi-Fi onto the bridge.
Successfully added adapter Ethernet onto the bridge.
```

## Netsh bridge add

This command adds a bridgeable network adapter to an existing bridge.

### Netsh bridge add parameters

| Parameter | Description | Requirement |
|--|--|--|
| `Adapter ID` | An adapter ID can be either of followings: `Adapter GUID` or `Adapter Name`, or `IfIndex`. The parameter uniquely identifies the network adapter that can join a bridge, and can be found from command `netsh bridge show adapters`. | Required |
| `Bridge GUID` | GUID uniquely identifies the bridge found from command `netsh bridge list`. | Required |

### Netsh bridge add examples

The following command is an example of this command.

```dos
netsh bridge add [<Adapter ID>] to [<Bridge GUID>]
```

The following output confirms the operation was successful for the adapter ID and bridge GUID.

```output
Successfully added adapter <Adapter ID> to <Bridge GUID>
```

## Netsh bridge remove

Removes a bridged network adapter from an existing bridge.

### Netsh bridge remove parameters

| Parameter | Description | Requirement |
|--|--|--|
| `Adapter ID` | An adapter ID can be either of followings: `GUID` or `Adapter Name`, or `IfIndex`. The parameter uniquely identifies the network adapter that can join a bridge, and can be found from command `netsh bridge show adapters`. | Required |
| `Bridge GUID` | GUID uniquely identifies the bridge acquired from command `netsh bridge list`. | Required |

### Netsh bridge remove examples

The following command is an example of this command.

```dos
netsh bridge remove [<Adapter ID>] from [<Bridge GUID>]
```

The following output confirms the adapter was successfully removed.

```output
Successfully removed adapter <Adapter ID> from bridge.
```

## Netsh bridge remove all from

Removes all bridged network adapters from an existing bridge and destroys the bridge.

### Netsh bridge remove all from parameters

| Parameter | Description | Requirement |
|--|--|--|
| `Bridge GUID` | Specifies the GUID to be removed. You can identify the bridge using the command `netsh bridge list`. | Required |

### Netsh bridge remove all examples

The following command is an example of this command.

```dos
netsh bridge remove all from [<Bridge GUID>]
```

The output confirms the bridge was successfully destroyed for the bridge GUID.

```output
Successfully destroyed bridge <Bridge GUID>.
```

## Netsh bridge destroy

Removes all bridged network adapters from an existing bridge and then destroys the bridge.

### Netsh bridge destroy parameters

| Parameter | Description | Requirement |
|--|--|--|
| `Bridge GUID` | Specifies the GUID to be removed. You can identify the bridge using the command `netsh bridge list`. | Required |

### Netsh bridge destroy examples

The following command is an example of this command.

```dos
netsh bridge destroy [<Bridge GUID>]
```

The output confirms the bridge was successfully destroyed for the bridge GUID.

```output
Successfully destroyed bridge <Bridge GUID>.
```
