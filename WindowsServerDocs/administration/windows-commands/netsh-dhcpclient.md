---
title: netsh dump
description: Reference article for the netsh dhcpclient command which configures and manages the DHCP client settings.
ms.topic: reference
ms.author: alalve
author: xelu86
ms.date: 05/08/2025
---

# netsh dhcpclient

The `netsh dhcpclient` command is used to configure and manage settings for the DHCP client, including enabling tracing and exporting diagnostic logs.

## Syntax

```
netsh dump dhcpclient [list | help | ? | trace]
netsh dump dhcpclient list
netsh dump dhcpclient trace <enable> <disable>
netsh dump dhcpclient trace <dump>
```

## Parameters

| Command | Description |
|--|--|
| dump | Displays a list of all available commands within the `dhcpclient` context. |
| help or ? | Provides detailed information for the given command. |
| trace `<enable>` \| `<disable>` <br><br> `<dump>` | Controls tracing for the DHCP client, allowing you to enable or disable it. This feature is helpful for troubleshooting as it generates detailed logs of DHCP client activities. You can retrieve the last 100 traces to review recent DHCP interactions. <br><br> `enable` - Enables tracing for the DHCP client. <br> `disable` - Disables tracing for the DHCP client. <br> `dump` - Exports the last 100 traces. |

## Example

To enable tracing for the DHCP client, run the following command:

```cmd
netsh dhcpclient trace enable
```

To dump the last 100 traces for review in a specified path, run the following command:

```cmd
netsh dhcpclient trace dump > C:\NetshTrace\dhcp_trace.txt
```
