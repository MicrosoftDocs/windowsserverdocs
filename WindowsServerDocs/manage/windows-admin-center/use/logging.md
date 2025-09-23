---
title: Event Logging in Windows Admin Center
description: Learn about event logging in Windows Admin Center.
ms.topic: concept-article
ms.author: roharwoo
author: robinharwood
ms.date: 06/18/2018
---

# Event logging in Windows Admin Center

Windows Admin Center writes event logs that show the management activities performed on the servers in your environment. Event logs can also help you troubleshoot any Windows Admin Center problems.

## Management activities

Windows Admin Center provides insight into the management activities performed on the servers in your environment by logging actions to the **WindowsAdminCenter** event channel in the event log of the managed server. `EventID` is `4000`, and `Source` is `SMEGateway`.

Windows Admin Center logs only actions on the managed server. Events aren't logged if a user accesses a server for read-only purposes.

Logged events include the following information:

| Key           | Value                                                                                              |
|---------------|----------------------------------------------------------------------------------------------------|
| `PowerShell`    | PowerShell script name that was run on the server, if the action ran a PowerShell script. |
| `CIM `          | CIM call that was run on the server, if the action ran a CIM call.                        |
| `Module`        | Tool (or module) where the action was run.                                                     |
| `Gateway`       | Name of the Windows Admin Center gateway machine where the action was run.                     |
| `UserOnGateway` | Username that's used to access the Windows Admin Center gateway and execute the action.                    |
| `UserOnTarget`  | Username that's used to access the target managed server, if it's different from `UserOnGateway`. That is, the user accessed the server by using **Manage as** credentials. |
| `Delegation`    | Boolean, if the target managed server trusts the gateway and credentials are delegated from the user's client machine.             |
| `LAPS`          | Boolean, if the user accessed the server by using [LAPS](/previous-versions/mt227395(v=msdn.10)) credentials.                          |
| `File`          | Name of the uploaded file, if the action was a file upload.                                |

## Gateway usage

Windows Admin Center logs gateway activity to the event channel on the gateway computer to help you troubleshoot issues and view metrics on usage. These events are also logged to the **WindowsAdminCenter** event channel.

[Learn more about troubleshooting Windows Admin Center](../support/troubleshooting.md).
