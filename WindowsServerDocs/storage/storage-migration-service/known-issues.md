---
title: Storage Migration Service known issues
description: Known issues and troubleshooting support for Storage Migration Service, such as how to collect logs for Microsoft Support.
author: nedpyle
ms.author: nedpyle
manager: siroy
ms.date: 12/17/2018
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: storage
---
# Storage Migration Service known issues

This topic contains answers to known issues when using [Storage Migration Service](overview.md) to migrate servers.

## <a name="collecting-logs"></a> How to collect log files when working with Microsoft Support

The Storage Migration Service contains event logs for the Orchestrator service and the Proxy Service. The urchestrator server always contains both event logs, and destination servers with the proxy service installed contain the proxy logs. These logs are located under:

- Application and Services Logs \ Microsoft \ Windows \ StorageMigrationService
- Application and Services Logs \ Microsoft \ Windows \ StorageMigrationService-Proxy

If you need to gather these logs for offline viewing or to send to Microsoft Support, there is an open source PowerShell script available on GitHub:

 [Storage Migration Service Helper](https://aka.ms/smslogs) 

Review the README for usage.

## Storage Migration Service doesn't show up in Windows Admin Center unless managing Windows Server 2019

When using the 1809 version of Windows Admin Center to manage a Windows Server 2019 orchestrator, you don't see the tool option for Storage Migration Service. 

The the Windows Admin Center Storage Migration Service extension is version-bound to only manage Windows Server 2019 version 1809 or later operating systems. If you use it to manage older Windows Server operating systems or insider previews, the tool will not appear. This behavior is by design. 

To resolve, use or upgrade to Windows Server 2019 build 1809 or later.

## Storage Migration Service doesn't let you choose static IP on cutover

When using the 0.57 version of the Storage Migration Service extension in Windows Admin Center and you reach the Cutover phase, you cannot select "Static IP" for an address. You are forced to use DHCP. 

To resolve this issue, look under Settings > Extensions for an alert stating that updated version Storage Migration Service 0.57.1 is available to install. You may need to restart your browser tab for Windows Admin center.

## See also

- [Storage Migration Service overview](overview.md)