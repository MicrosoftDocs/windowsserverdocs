---
title: Install Server Core
description: How to obtain and install a Server Core installation on Windows Server 2019, Windows Server 2016, or Windows Server (Semi-Annual Channel).
ms.prod: windows-server
ms.date: 05/21/2019
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2d22818c-fbb7-487a-bb82-81ef0a3f7ede
author: jasongerend
ms.author: jgerend
manager: dougkim
ms.localizationpriority: medium
---
# Install Server Core

> Applies to: Windows Server 2019, Windows Server 2016, Windows Server (Semi-Annual Channel)
  
When you install Windows Server for the first time, you have the following installation options:

>[!NOTE]
> In the following list, editions without “Desktop Experience” are the Server Core installation options

-	Windows Server Standard
-	Windows Server Standard with Desktop Experience
-	Windows Server Datacenter
-	Windows Server Datacenter with Desktop Experience

When you install Windows Server (Semi-Annual Channel), you have the following installation options:

-	Windows Server Standard 
-	Windows Server Datacenter

The Server Core option reduces the space required on disk and the potential attack surface, so we recommend that you choose the Server Core installation unless you have a particular need for the additional user interface elements and graphical management tools that are included in the Server with Desktop Experience option. If you do feel you need the additional user interface elements, see [Install Server with Desktop Experience](Getting-Started-with-Server-with-Desktop-Experience.md). 

With the Server Core option, the standard user interface (the Desktop Experience) is not installed; you manage the server using the command line, Windows PowerShell, or by remote methods.

>[!NOTE]
>
>Unlike some previous releases of Windows Server, you cannot convert between Server Core and Server with Desktop Experience after installation. If you install Server Core and later decide to use Server with Desktop Experience, you should do a fresh installation.

**User interface:** command prompt

**Install, configure, uninstall server roles locally:** at a command prompt with Windows PowerShell.

**Install, configure, uninstall server roles remotely from a Windows client computer (or a server with the Desktop Experience installed):** with Server Manager, Remote Server Administration Tools (RSAT), Windows PowerShell, or Windows Admin Center.

>[!NOTE]
>
>For RSAT, you must use the Windows 10 version.
>Microsoft Management Console is not available locally.

**Example server roles available:**

- Active Directory Certificate Services
- Active Directory Domain Services
- DHCP Server
- DNS Server
- File Services (including File Server Resource Manager)
- Active Directory Lightweight Directory Services (AD LDS)
- Hyper-V
- Print and Document Services
- Streaming Media Services
- Web Server (including a subset of ASP.NET)
- Windows Server Update Server
- Active Directory Rights Management Server
- Routing and Remote Access Server and the following sub-roles:
   - Remote Desktop Services Connection Broker
   - Licensing
   - Virtualization
   - Volume Activation Services

For roles not included in Server Core, see [Roles, Role Services, and Features not in Windows Server - Server Core](../administration/server-core/server-core-removed-roles.md).

## Installing on Windows Server 2019 or Windows Server 2016

For general installation steps and options for Windows Server (Long Term Servicing Channel), see [Windows Server Installation and Upgrade](installation-and-upgrade.md).

## Installing on Windows Server (Semi-Annual Channel)

Installation steps for Windows Server (Semi-Annual Channel) are the same as installing previous versions of Windows Server (from an .ISO image), with the following exceptions:

- No supported upgrades from previous versions of Windows Server to Windows Server, version 1709. A fresh installation is always required.
   This means that when you run setup.exe from the desktop of a Windows computer, the setup experience does not permit the upgrade option (it is grayed out).
- There's no evaluation version for Windows Server (Semi-Annual Channel)
- There's no OEM or retail version. Windows Server (Semi-Annual Channel) can only be licensed through Software Assurance or loyalty programs.

For more info about Semi-Annual Channel, see [Comparison of servicing channels](../get-started-19/servicing-channels-19.md).

To see what's new in Windows Server Semi-Annual Channel, see [What's New in Windows Server](whats-new-in-windows-server.md)
