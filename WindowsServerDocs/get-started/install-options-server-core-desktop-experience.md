---
title: Server Core vs Server with Desktop Experience install options
description: Learn the differences between the Server Core and Server with Desktop Experience install options.
ms.topic: conceptual
author: dknappettmsft
ms.author: daknappe
manager: femila
ms.date: 08/17/2021
ms.prod: windows-server
---

# Server Core vs Server with Desktop Experience install options

When you install Windows Server using the setup wizard, you can choose between Server Core or Server with Desktop Experience install options. With Server Core, the standard graphical user interface (the Desktop Experience) is not installed; you manage the server from the command line using PowerShell, the [Server Configuration tool (SConfig)](../administration/server-core/server-core-sconfig.md), or by remote methods. Server with Desktop Experience installs the standard graphical user interface and all tools, including client experience features.

We recommend that you choose the Server Core install option unless you have a particular need for the extra user interface elements and graphical management tools that are included in the Server with Desktop Experience install option.

The setup wizard lists the install options below. In this list, editions without **Desktop Experience** are the Server Core install options:

- Windows Server Standard
- Windows Server Standard with Desktop Experience
- Windows Server Datacenter
- Windows Server Datacenter with Desktop Experience

> [!NOTE]
> Unlike some previous releases of Windows Server, you cannot convert between Server Core and Server with Desktop Experience after installation. You will need to do a [clean installation](install-upgrade-migrate.md) if you install later decide to use a different option.

## Differences

There are some key differences between Server Core and Server with Desktop Experience:

| Component | Server Core | Server with Desktop Experience |
|--|--|--|
| User interface | Minimal, command line driven (PowerShell, [SConfig](../administration/server-core/server-core-sconfig.md), cmd) | Standard Windows graphical user interface |
| Disk space | Smaller requirement | Larger requirement |
| Install, configure, uninstall server roles locally | PowerShell | Server Manager or PowerShell |
| Roles and Features | Some roles and features are not available. For more information, see [Roles, Role Services, and Features not in Windows Server - Server Core](../administration/server-core/server-core-removed-roles.md).<br /><br />Some of the features from Server with Desktop Experience for application compatibility can be installed with the [App Compatibility Feature on Demand (FOD)](server-core-app-compatibility-feature-on-demand.md). | All roles and features are available, including those for application compatibility. |
| Remote management | Yes, can be managed remotely using GUI tools, such as Windows Admin Center, Remote Server Administration Tools (RSAT), or Server Manager, or by PowerShell. | Yes, can be managed remotely using GUI tools, such as Windows Admin Center, Remote Server Administration Tools (RSAT), or Server Manager, or by PowerShell. |
| Potential attack surface | Greatly reduced attack surface | No reduction |
| Microsoft Management Console | Not installed - can be installed with the [App Compatibility Feature on Demand (FOD)](server-core-app-compatibility-feature-on-demand.md). | Installed |

> [!NOTE]
> For RSAT, you must use the version included with Windows 10 or later.
