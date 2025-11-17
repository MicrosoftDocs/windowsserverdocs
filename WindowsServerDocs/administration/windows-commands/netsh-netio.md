---
title: netsh netio
description: The netsh netio command  manages network binding filters in Windows.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 08/12/2025
---

# netsh netio

The `netsh netio` command is used to manage network binding filters, allowing administrators to control which clients can bind to specific network providers.

## Syntax

```
netsh netio [add | delete | dump | help | show | ?]
```

```
netsh netio add bindingfilter [npi=]<string> [client=]<string> [provider=]<string>
                              [type=](block|singleclient) [store=](active|persistent)
```

```
netsh netio delete bindingfilter [npi=]<string> [client=]<string> [provider=]<string>
                                 [store=](active|persistent)
```

```
netsh netio dump
```

```
netsh netio show bindingfilter [store=](active|persistent)
```

## Parameters

| Command | Description |
|--|--|
| netio `add bindingfilter` | Adds a new binding filter. <br><br><li> **npi** - Specifies the NPI (Network Programming Interface) GUID or name. <li> **client** - Specifies the client GUID or name. <li> **provider** - Specifies the provider GUID or name. <li> **type** - Determines the filter type. `block` prevents the specified client from binding to the provider. `singleclient` allows only the specified client to bind to the provider (default). <li> **store** - Specifies filter persistence. `active` indicates the filter is temporary and will disappear on the next boot. `persistent` indicates the filter remains in effect across reboots (default). </li> |
| netio `delete bindingfilter` | Removes an existing binding filter. <br><br><li> **npi** - Specifies the NPI GUID or name. <li> **client** - Specifies the client GUID or name. <li> **provider** - Specifies the provider GUID or name. <li> **store** - Specifies filter persistence. `active` indicates the filter removal is temporary will reappear after the system is rebooted. `persistent` indicates the filter removal is permanent and remains in effect across system reboots (default). </li> |
| netio `dump` | Creates a script containing the current netio configuration. The script can be saved to a file and used to restore settings if they're altered or need to be replicated on another system. |
| netio `show bindingfilter` | Displays all binding filters. <br><br>  **store** - Specifies the filter persistence. `active` displays the filters in the stack (default). `persistent` displays all persistent filters. |
| `help` *or* `?` | Displays a list of commands and their descriptions in the current context. |

## Examples

To block a specified client from binding to a provider persistently, you can run the following command:

```cmd
netsh netio add bindingfilter npi="NPI_Name" client="Client_Name" provider="Provider_Name" type=block store=persistent
```

To permanently remove a binding filter, you can run the following command:

```cmd
netsh netio delete bindingfilter npi="NPI_Name" client="Client_Name" provider="Provider_Name" store=persistent
```

To display all active binding filters, you can run the following command:

```cmd
netsh netio show bindingfilter store=active
```

## See also

- [Command-Line Syntax Key](command-line-syntax-key.md)
