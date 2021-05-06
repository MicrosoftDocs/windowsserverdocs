---
title: Troubleshoot problems on the DHCP client
description: This artilce introduces how to troubleshoot problems on the DHCP client and collect data.
manager: dcscontentpm
ms.date: 5/26/2020
ms.topic: troubleshooting
author: Deland-Han
ms.author: delhan
---
# Troubleshoot problems on the DHCP client

This article discusses how to troubleshoot problems that occur on DHCP clients.

## Troubleshooting checklist

Check the following devices and settings:

  - Cables are connected and working.

  - MAC filtering is enabled on the switches to which the client is connected.

  - The network adapter is enabled.

  - The correct network adapter driver is installed and updated.

  - The DHCP Client service is started and running. To check this, run the **net start** command, and look for **DHCP Client**.

  - There is no firewall blocking ports 67 and 68 UDP on the client computer.

## Event logs

Examine the Microsoft-Windows-DHCP Client Events/Operational and Microsoft-Windows-DHCP Client Events/Admin event logs. All events that are related to the DHCP client service are sent to these event logs.
The Microsoft-Windows-DHCP Client Events are located in the Event Viewer under **Applications and Services Logs**.

The "Get-NetAdapter -IncludeHidden" PowerShell command provides the necessary information to interpret the events that are listed in the logs. For example, Interface ID, MAC address, and so on.

## Data collection

We recommend that you collect data simultaneously on both the DHCP client and server side when the problem occurs. However, depending on the actual problem, you can also start your investigation by using a single data set on either the DHCP client or DHCP server.

To collect data from the server and affected client, use [Wireshark](https://www.wireshark.org/download.html). Start collecting at the same time on the DHCP client and the DHCP server computers.

Run the following commands on the client that is experiencing the problem:

```console
ipconfig /release
ipconfig /renew
```

Then, stop Wireshark on the client and server. Check the generated
traces. These should, at least, tell you at which stage the
communication stops.