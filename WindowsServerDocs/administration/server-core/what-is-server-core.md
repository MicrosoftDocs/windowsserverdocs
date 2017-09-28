---
title: What is Server Core?
description: Learn about the Server Core installation option in Windows Server
ms.prod: windows-server-threshold
ms.mktglfcycl: manage
ms.sitesec: library
author: lizap
ms.localizationpriority: medium
ms.date: 09/18/2017
---
# What is the Server Core installation option in Windows Server?

> Applies to: Windows Server, Windows Server 2016

The Server Core option is a  minimal installation option that is available when you are deploying the Standard, Enterprise, or Datacenter edition of Windows Server. Server Core provides you with a minimal installation of Windows Server includes only certain server roles. Contrast this with the Server with Desktop Experience installation option, which supports installing all available server roles and other Microsoft or third-party server applications, such as Microsoft Exchange Server or SAP. Server Core has a smaller disk footprint, and therefore a smaller attack surface due to a smaller code base.

## Server Core vs Server with Desktop Experience 
When you install Windows Server, you install only the server roles that you choose - this helps reduce the overall footprint for Windows Server. However, the Server with Desktop Experience installation option still installs many services and other components that are often not needed for a particular usage scenario. 

That's where Server Core comes into play: the Server Core installation eliminates any services and other features that are not essential for the support of certain commonly used server roles. For example, a DNS server doesn't need a graphical user interface (GUI), because you can manage virtually all aspects of DNS either from the command line using Windows PowerShell, the Dnscmd.exe command, or remotely using the DNS Microsoft Management Console (MMC) snap-in.

Server Core is Windows Server stripped of everything that is not absolutely essential to run core network services like Active Directory Domain Services (AD DS), DNS, Dynamic Host Configuration Protocol (DHCP), File and Print, and a few other server roles. 

## The Server Core difference - core capabilities without the frills
When you finish installing Server Core on a system and sign in for the first time, you're in for a bit of a surprise. The main difference between the Server with Desktop Experience installation option and Server Core is that Server Core does not include the following GUI shell packages:

- Microsoft-Windows-Server-Shell-Package
- Microsoft-Windows-Server-Gui-Mgmt-Package
- Microsoft-Windows-Server-Gui-RSAT-Package
- Microsoft-Windows-Cortana-PAL-Desktop-Package

In other words, there is **no desktop** in Server Core, by design. While maintaining the capabilities required to support traditional business applications and role-based workloads, Server Core does not have a traditional desktop interface. Instead, Server Core is designed to be managed remotely through command line, PowerShell, or a GUI tool (like [RSAT](../../remote/remote-server-administration-tools,md) or the Project Honolulu management portal).

In addition to no UI, Server Core also differs from the Server with Desktop Experience in the following ways:

- Server Core does not have any accessibility tools
- No OOBE (out-of-box-experience) for setting up Server Core
- No Audio support

For more information about what's not included in Server Core, see [Roles, Role Services, and Features not in Windows Server - Server Core](server-core-removed-roles.md)

## Get started using Server Core
Use the follwing information to install, configure, and manage the Server Core installation option of Windows Server.

- [Install the Server Core installation option](../../get-started/getting-started-with-server-core.md)
- [Configure Server Core with the SConfig tool](../../get-started/sconfig-on-ws2016.md)
- [Manage Server Core](server-core-manage.md)