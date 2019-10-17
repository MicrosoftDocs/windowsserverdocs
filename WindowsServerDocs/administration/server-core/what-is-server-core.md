---
title: What is Server Core?
description: Learn about the Server Core installation option in Windows Server
ms.prod: windows-server
ms.mktglfcycl: manage
ms.sitesec: library
author: lizap
ms.localizationpriority: medium
ms.date: 02/20/2018
---
# What is the Server Core installation option in Windows Server?

> Applies to: Windows Server 2019, Windows Server 2016, and Windows Server (Semi-Annual Channel)

The Server Core option is a minimal installation option that is available when you are deploying the Standard or Datacenter edition of Windows Server. Server Core includes most but not all server roles. Server Core has a smaller disk footprint, and therefore a smaller attack surface due to a smaller code base. 

## Server (Core) vs Server with Desktop Experience 
When you install Windows Server, you install only the server roles that you choose - this helps reduce the overall footprint for Windows Server. However, the Server with Desktop Experience installation option still installs many services and other components that are often not needed for a particular usage scenario. 

That's where Server Core comes into play: the Server Core installation eliminates any services and other features that are not essential for the support of certain commonly used server roles. For example, a Hyper-V server doesn't need a graphical user interface (GUI), because you can manage virtually all aspects of Hyper-V either from the command line using Windows PowerShell or remotely using the Hyper-V Manager. 

## The Server Core difference - core capabilities without the frills
When you finish installing Server Core on a system and sign in for the first time, you're in for a bit of a surprise. The main difference between the Server with Desktop Experience installation option and Server Core is that Server Core does not include the following GUI shell packages:

- Microsoft-Windows-Server-Shell-Package
- Microsoft-Windows-Server-Gui-Mgmt-Package
- Microsoft-Windows-Server-Gui-RSAT-Package
- Microsoft-Windows-Cortana-PAL-Desktop-Package

In other words, there is **no desktop** in Server Core, by design. While maintaining the capabilities required to support traditional business applications and role-based workloads, Server Core does not have a traditional desktop interface. Instead, Server Core is designed to be managed remotely through the command line, PowerShell, or a GUI tool (like [RSAT](../../remote/remote-server-administration-tools.md) or [Windows Admin Center](../../manage/windows-admin-center/overview.md)).

In addition to no UI, Server Core also differs from the Server with Desktop Experience in the following ways:

- Server Core does not have any accessibility tools
- No OOBE (out-of-box-experience) for setting up Server Core
- No audio support

The following table shows which applications are available *locally* on Server Core vs Server with Desktop Experience. **Important**: In most cases, applications that are listed as "not available" below can be run remotely from a Windows client computer and used to manage your Server Core installation.

> [!NOTE]
> This list is intended for quick reference - it isn't intended to be a complete list.


| Application                     | Server Core     | Server with Desktop Experience |
|------------------------------------|-----------------|--------------------------------|
| Command prompt                     | available       | available                      |
| Windows PowerShell/ Microsoft .NET | available       | available                      |
| Perfmon.exe                        | not available  | available                      |
| Windbg (GUI)                         | supported       | supported                      |
| Resmon.exe                         | not available   | available                      |
| Regedit                            | available       | available                      |
| Fsutil.exe                         | available       | available                      |
| Disksnapshot.exe                   | not available   | available                      |
| Diskpart.exe                       | available       | available                      |
| Diskmgmt.msc                       | not available   | available                      |
| Devmgmt.msc                        | not available   | available                      |
| Server Manager                     | not available  | available                      |
| Mmc.exe                            | not available   | available                      |
| Eventvwr                           | not available  | available                      |
| Wevtutil (Event queries)           | available       | available                      |
| Services.msc                       | not available   | available                      |
| Control Panel                      | not available   | available                      |
| Windows Update (GUI)                 | not available | available                      |
| Windows Explorer                   | not available   | available                      |
| Taskbar                            | not available   | available                      |
| Taskbar notifications              | not available   | available                      |
| Taskmgr                            | available       | available                      |
| Internet Explorer or Edge          | not available   | available                      |
| Built-in help system               | not available   | available                      |
| Windows 10 Shell                   | not available   | available                      |
| Windows Media Player               | not available   | available                      |
| PowerShell                         | available       | available                      |
| PowerShell ISE                     | not available   | available                      |
| PowerShell IME                     | available       | available                      |
| Mstsc.exe                          | not available   | available                      |
| Remote Desktop Services            | available       | available                      |
| Hyper-V Manager                    | not available  | available                      |


For more information about what *is* included in Server Core, see [Roles, Role Services, and Features included in Windows Server - Server Core](server-core-roles-and-services.md). And for information about what *is not* included in Server Core, see [Roles, Role Services, and Features not included in Server Core](server-core-removed-roles.md)

## Get started using Server Core
Use the following information to install, configure, and manage the Server Core installation option of Windows Server.

Server Core installation: 
- [Roles, Role Services, and Features included in Server Core](server-core-roles-and-services.md)
- [Roles, Role Services, and Features not in Server Core](server-core-removed-roles.md)
- [Install the Server Core installation option](../../get-started/getting-started-with-server-core.md)
- [Configure Server Core with the SConfig tool](../../get-started/sconfig-on-ws2016.md)

Using Server Core:
- [Basic Server Core administration tasks using Windows PowerShell or the command line](server-core-administer.md)
- [Manage Server Core](server-core-manage.md)
- [Patching Server Core](server-core-servicing.md)
- [Configure memory dump files](server-core-memory-dump.md)