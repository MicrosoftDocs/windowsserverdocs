---
title: Event logging
description: Event logging from Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: haley-rowland
ms.author: harowl
ms.date: 04/12/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Event logging from Windows Admin Center

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

## Gain insight into management activities in your environment through user action logging
Windows Admin Center provides insight into the management activities performed on the servers in your environment by logging actions to the **Microsoft-ServerManagementExperience** event channel in the event log of the managed server, with EventID 4000 and Source SMEGateway. Windows Admin Center only logs actions on the managed server, so you won't see events logged if a user accesses a server for read-only purposes. 
Logged events include the following information:
| Key           | Value                                                                                              |
|---------------|----------------------------------------------------------------------------------------------------|
| PowerShell    | PowerShell script name that was executed on the server, if the action executed a PowerShell script |
| CIM           | CIM call that was executed on the server, if the action executed a CIM call                        |
| Module        | Tool (or module) where the action was executed                                                     |
| Gateway       | Name of the Windows Admin Center gateway machine where the action was executed                     |
| UserOnGateway | Username used to access the Windows Admin Center gateway and execute the action                    |
| UserOnTarget  | Username used to access the target managed server, if different from the userOnGateway (i.e. the user accessed using the server using "Manage as" credentials) |
| Delegation    | Boolean: if the target managed server trusts the gateway and credentials are delegated from the user's client machine             |
| LAPS          | Boolean: if the user accessed the server using [LAPS](https://technet.microsoft.com/mt227395.aspx) credentials                          |
| File          | name of the file uploaded, if the action executed was a file upload                                |

## Learn about Windows Admin Center gateway usage with event logging
To help you troubleshoot issues and view metrics on the usage of the gateway, Windows Admin Center logs gateway activity to the event channel on the gateway machine. These events are logged to the **Microsoft-ServerManagementExperience** event channel. The following events are logged on the gateway machine: 
| Event ID | Event                                                                                             | Source     |
|----------|---------------------------------------------------------------------------------------------------|------------|
| 0        | Informational events (HTTPS requests and PowerShellStream proccessing ID)                         | SMEGateway |
| 2        | UI Error                                                                                          | UI         |
| 4        | UI Warning                                                                                        | UI         |
| 7        | User action and module open events                                                                | Telemetry  |
| 8        | Gateway usage (how many nodes have ever been registered to the gateway, gateway status)                                         | Telemetry  |
| 9        | Gateway usage (how many users using the gateway machine, how many nodes are actively being managed by the gateway)  | Telemetry  |

[Learn more about troubleshooting Windows Admin Center.](../use/troubleshooting.md)





















