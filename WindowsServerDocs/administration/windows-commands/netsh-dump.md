---
title: netsh dump
description: Reference article for the netsh dump command that allows exporting network configuration settings to a text file.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 07/25/2025
---

# netsh dump

The `netsh dump` command generates a script that saves the system's current network settings. By running this command, you produce a script that can be used to recreate the same settings later or on a different device.

## Syntax

```
netsh dump
```

## Parameters

| Command | Description |
|--|--|
| dump | Exports the network configuration details and settings to your device. |

## Example

To export your network configuration settings to a file named "netsh_config.txt" and save it in **C:\NetConfig**, run the following command:

```cmd
netsh dump > "C:\NetConfig\netsh_config.txt"
```
