---
title: netsh bridge
description: The netsh bridge command manages network adapter bridge settings to combine two or more network segments as one network in Windows.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/10/2025
---

# netsh bridge

The `netsh bridge` command configures network adapter bridge settings in Windows. By creating a network bridge, you can link two or more network segments, allowing devices on separate segments to communicate seamlessly as if they're part of a single network.

## Syntax

```
netsh bridge [add | create | destroy | dump | help | list | remove | set | show | ?]
```

```
netsh bridge add <Adapter ID> to <Bridge GUID>
```

```
netsh bridge create [<Adapter ID #1> <Adapter ID #2>]
```

```
netsh bridge destroy <Bridge GUID>
```

```
netsh bridge list
```

```
netsh bridge remove <Adapter ID> from <Bridge GUID>
netsh bridge remove all from <Bridge GUID>
```

```
netsh bridge set adapter [id=]<integer> [[forcecompatmode=]enable|disable]
```

```
netsh bridge show adapter
```

## Parameters

| Command | Description |
|--|--|
| bridge `add` | Adds a network adapter, specified by its Adapter ID, to an existing bridge identified by its Bridge GUID. |
| bridge `create` | Creates a new network bridge that includes two specified network adapters. The newly created bridge is assigned its own unique GUID, which can be retrieved using the `netsh bridge list` command. |
| bridge `destroy` | Removes all network adapters from the specified bridge, identified by its bridge GUID, and deletes the bridge. |
| bridge `dump` | Creates a script containing the current context configuration. The script can be saved to a file and used to restore settings if they're altered or need to be replicated on another system. |
| bridge `list` | Displays all the created bridges that are uniquely identified by the bridge GUID. |
| bridge `remove` | Removes a network adapter, specified by its Adapter ID, from a bridge identified by its Bridge GUID. <br><br> Using the `all` parameter removes all network adapters from the specified bridge and deletes the bridge. |
| bridge `set adapter` | Modifies the bridge configuration for the specified adapter. <br><br> `id` - The identifier of the network adapter to configure. To view available adapter IDs, use the `netsh bridge show adapter` command. <br> `forcecompatmode` - Specifies whether to enable or disable Layer 3 compatibility mode for the adapter: <br> - `enable`: Turns on Layer 3 mode. <br> - `disable`: Turns off Layer 3 mode. |
| bridge `show adapter` | Displays a list of all available network adapters, including their Adapter IDs, current settings, and status flags, indicating which adapters can participate in a network bridge. |
| `help` *or* `?` | Displays a list of commands and their descriptions in the current context. |

## Examples

To add a network adapter (Adapter ID 3) to an existing bridge, with Bridge GUID `{12345678-ABCD-EF01-2345-6789ABCDEF03}`, run the following command:

```cmd
netsh bridge add adapter=3 bridge={12345678-ABCD-EF01-2345-6789ABCDEF03}
```

To create a new network bridge with two adapters (Adapter ID 1 and Adapter ID 2), run the following command:**

```cmd
netsh bridge create adapter=1 adapter=2
```

To destroy a bridge and remove all its adapters (Bridge GUID `{12345678-ABCD-EF01-2345-6789ABCDEF02}`), run the following command:

```cmd
netsh bridge destroy bridge={12345678-ABCD-EF01-2345-6789ABCDEF02}
```

To display all created network bridges and their GUIDs, run the following command:

```cmd
netsh bridge list
```

To remove a network adapter (Adapter ID 2) from an existing bridge, with Bridge GUID `{12345678-ABCD-EF01-2345-6789ABCDEF02}`, run the following command:

```cmd
netsh bridge remove adapter=2 bridge={12345678-ABCD-EF01-2345-6789ABCDEF02}
```

To display all available network adapters, run the following command:

```cmd
netsh bridge show adapter
```

To modify an adapter (Adapter ID 1) in a bridge to enable Layer 3 compatibility mode, run the following command:

```cmd
netsh bridge set adapter id=1 forcecompatmode=enable
```

## See also

- [Command-Line Syntax Key](command-line-syntax-key.md)
