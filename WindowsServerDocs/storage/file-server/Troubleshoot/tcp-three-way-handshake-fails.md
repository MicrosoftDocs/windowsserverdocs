---
title: TCP three-way handshake failure during SMB connection 
description: Introduces the TCP three-way handshake failure during SMB connection.
author: Deland-Han
manager: dcscontentpm
audience: ITPro
ms.topic: article
ms.author: delhan
ms.date: 12/25/2019
---

# TCP three-way handshake failure during SMB connection

When you analyze a network trace, you notice that there is a Transmission Control Protocol (TCP) three-way handshake failure that causes the SMB issue to occur. This article describes how to troubleshoot this situation.

## Troubleshooting

Generally, the cause is a local or infrastructure firewall that blocks the traffic. This issue can occur in either of the following scenarios.

## Scenario 1

The TCP SYN packet arrives on the SMB server, but the SMB server does not return a TCP SYN-ACK packet.

To troubleshoot this scenario, follow these steps.

### Step 1

Run **netstat** or **Get-NetTcpConnection** to make sure that there is a listener on TCP port 445 that should be owned by the SYSTEM process.

```cmd
netstat -ano | findstr :445
```

```PowerShell
Get-NetTcpConnection -LocalPort 445
```

### Step 2

Make sure that the Server service is started and running.

### Step 3

Take a Windows Filtering Platform (WFP) capture to determine which rule or program is dropping the traffic. To do this, run the following command in a Command Prompt window:

```cmd
netsh wfp capture start
```

Reproduce the issue, and then, run the following command:

```cmd
netsh wfp capture stop
```

Run a scenario trace, and look for WFP drops in SMB traffic (on TCP port 445).

Optionally, you could remove the anti-virus programs because they are not always WFP-based.

### Step 4

If Windows Firewall is enabled, enable firewall logging to determine whether it records a drop in traffic.

Make sure that the appropriate "File and Printer Sharing (SMB-In)" rules are enabled in **Windows Firewall with Advanced Security** \> **Inbound Rules**.

> [!NOTE]
> Depending on how your computer is set up, “Windows Firewall” might be called “Windows Defender Firewall.”

## Scenario 2

The TCP SYN packet never arrives at the SMB server.

In this scenario, you have to investigate the devices along the network path. You may analyze network traces that are captured on each device to determine which device is blocking the traffic.
