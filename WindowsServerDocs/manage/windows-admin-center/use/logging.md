---
title: Event logging
description: Event logging from Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: haley-rowland
ms.author: harowl
ms.date: 06/18/2018
ms.localizationpriority: medium
ms.prod: windows-server
---

# Use event logging in Windows Admin Center to gain insight into management activities and track gateway usage

>Applies To: Windows Admin Center, Windows Admin Center Preview

Windows Admin Center writes event logs to let you see the management activities being performed on the servers in your environment, as well as to help you troubleshoot any Windows Admin Center issues.

## Gain insight into management activities in your environment through user action logging

Windows Admin Center provides insight into the management activities performed on the servers in your environment by logging actions to the **Microsoft-ServerManagementExperience** event channel in the event log of the managed server, with EventID 4000 and Source SMEGateway. Windows Admin Center only logs actions on the managed server, so you won't see events logged if a user accesses a server for read-only purposes.

Logged events include the following information:

| Key           | Value                                                                                              |
|---------------|----------------------------------------------------------------------------------------------------|
| PowerShell    | PowerShell script name that was run on the server, if the action ran a PowerShell script |
| CIM           | CIM call that was run on the server, if the action ran a CIM call                        |
| Module        | Tool (or module) where the action was run                                                     |
| Gateway       | Name of the Windows Admin Center gateway machine where the action was run                     |
| UserOnGateway | User name used to access the Windows Admin Center gateway and execute the action                    |
| UserOnTarget  | User name used to access the target managed server, if different from the userOnGateway (i.e. the user accessed using the server using "Manage as" credentials) |
| Delegation    | Boolean: if the target managed server trusts the gateway and credentials are delegated from the user's client machine             |
| LAPS          | Boolean: if the user accessed the server using [LAPS](https://technet.microsoft.com/mt227395.aspx) credentials                          |
| File          | name of the file uploaded, if the action was a file upload                                |

## Learn about Windows Admin Center activity with event logging

Windows Admin Center logs gateway activity to the event channel on the gateway computer to help you troubleshoot issues and view metrics on usage. These events are logged to the **Microsoft-ServerManagementExperience** event channel.

[Learn more about troubleshooting Windows Admin Center.](troubleshooting.md)
