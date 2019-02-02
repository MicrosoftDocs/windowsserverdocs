---
title: Storage Migration Service known issues
description: Known issues and troubleshooting support for Storage Migration Service, such as how to collect logs for Microsoft Support.
author: nedpyle
ms.author: nedpyle
manager: siroy
ms.date: 12/20/2018
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

The Windows Admin Center Storage Migration Service extension is version-bound to only manage Windows Server 2019 version 1809 or later operating systems. If you use it to manage older Windows Server operating systems or insider previews, the tool will not appear. This behavior is by design. 

To resolve, use or upgrade to Windows Server 2019 build 1809 or later.

## Storage Migration Service doesn't let you choose static IP on cutover

When using the 0.57 version of the Storage Migration Service extension in Windows Admin Center and you reach the Cutover phase, you cannot select a static IP for an address. You are forced to use DHCP.

To resolve this issue, in Windows Admin Center, look under **Settings** > **Extensions** for an alert stating that updated version Storage Migration Service 0.57.2 is available to install. You may need to restart your browser tab for Windows Admin center.

## Storage Migration Service cutover validation fails with error "Access is denied for the token filter policy on destination computer"

When running cutover validation, you receive error "Fail: Access is denied for the token filter policy on destination computer." This occurs even if you provided correct local administrator credentials for both the source and destination computers.

This issue is caused by a code defect in Windows Server 2019. The issue will occur when you are using the destination computer as a Storage Migration Service Orchestrator.

To work around this issue, install the Storage Migration Service on a Windows Server 2019 computer that is not the intended migration destination, then connect to that server with Windows Admin Center and perform the migration.

We intend to fix this issue in a later release of Windows Server. Please open a support case via [Microsoft Support](https://support.microsoft.com) to request a backport of this fix be created.

## Storage Migration Service not included in Windows Server 2019 Evaluation edition"

When using Windows Admin Center to connect to a [Windows Server 2019 Evaluation release](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2019) there is no option to manage the Storage Migration Service. There is also no Storage Migration Service included in Roles and Features.

This is issue is caused by a servicing issue in the Evaluation media of Windows Server 2019. 

To work around this issue, install a retail, MSDN, OEM, or Volume License version of Windows Server 2019 and do not activate it, Without activation, all editions of Windows Server operate in evaluation mode for 180 days. 

We have fixed this issue in a later release of Windows Server 2019. We may release an update to the existing version of Windows Server 2019 as part of the normal monthly update cycle. 


## See also

- [Storage Migration Service overview](overview.md)