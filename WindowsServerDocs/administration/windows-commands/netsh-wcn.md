---
title: netsh wcn
description: The netsh wcn command configures, manages, and troubleshoots Wireless Configuration Network (WCN) settings on Windows devices.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 07/29/2025
---

# netsh wcn

The `netsh wcn` command allows administrators to configure and manage Wireless Configuration Network (WCN) settings on local or remote Windows devices. It provides commands to query, enroll, and export wireless configuration details.

## Syntax

```
netsh wcn [dump] [enroll] [query] [help] [?]
netsh wcn enroll [enrolleeUUID=] <string> [password=] <string> [profile=] <string> [interface=] <string> [type=] (auto | ethernet | 802dot11)
netsh wcn query [SSID=] <string> [interface=] <string>
```

## Parameters

| Parameter | Description |
|--|--|
| `dump` | Exports the current WCN settings and configuration as a script for documentation or replication on another system. |
| `enroll` | Initiates the process to connect to a wireless network using WCN protocols. <br><br><li> `enrolleeUUID` - Specifies the Wi-Fi Protected Setup (WPS) Universally Unique Identifier (UUID) of the device you wish to enroll. This is a unique identifier provided by the device. <li> `password` - The WPS password or PIN associated with the device. This is used during the enrollment process to authenticate the device to the network. <li> `profile` - The name of the network profile to be used. This profile contains the configuration settings for the network connection. <li> `interface` - Specifies the friendly name of the network interface on which the enrollment process is performed. If omitted, the default network interface is used. This parameter is optional. <li> `type` - Determines the transport method to be used for the enrollment. This can specify different transport technologies, such as: **auto** (automatically selects the available network interfaces), **ethernet** (a wired Ethernet connection), **802dot11** (a wireless 802.11 connection). <br><br> This parameter is optional. </li> |
| `query` | Retrieves and displays detailed information about a WCN device, including network settings, security details, and device-specific information. <br><br><li> `ssid` - Specifies the SSID (Service Set Identifier) of the 802.11 wireless network you wish to query. <li> `interface` - Specifies the friendly name of the network interface you want to use for the query. This parameter is optional. </li> |
| `help` or `?` | Provides a list of commands available in the `netsh wcn` context. |

## Examples

To initiate the enrollment process for a device with a specific UUID using a wireless 802.11 connection, run the following command:

```cmd
netsh wcn enroll enrolleeUUID=your-device-uuid password=your-password profile=your-ssid type=802dot11
```

To enroll a device using a wired Ethernet connection on a specified network interface, run the following command:

```cmd
netsh wcn enroll enrolleeUUID=your-device-uuid password=your-password profile=your-ssid interface=your-interface-name type=ethernet
```

To query a wireless network with a specific SSID using the default network interface, run the following command:

```cmd
netsh wcn query SSID=your-network-ssid
```

To query detailed information about a wireless network with a specific SSID using a specified network interface, run the following command:

```cmd
netsh wcn query SSID=your-network-ssid interface=your-interface-name
```

## Remarks

The `enroll` parameter starts WPS enrollment with the device identified by the enrollee UUID. The specified network profile is applied using the chosen interface, or the default if none is given.

The device password is usually a 4-digit or 8-digit PIN. Refer to your device's documentation for its UUID and PIN. If no transport type is set, or "auto" is used, the system selects the best available option.

## See also

- [Command-Line Syntax Key](command-line-syntax-key.md)
