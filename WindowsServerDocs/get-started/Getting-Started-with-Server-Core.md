---
title: Install Server Core
description: Explains how to obtain and install a Server Core installation
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.date: 10/17/2017
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2d22818c-fbb7-487a-bb82-81ef0a3f7ede
author: jaimeo
ms.author: jaimeo
manager: elizapo
---
# Install Server Core
> Applies To: Windows Server (Semi-Annual Channel) and Windows Server 2016
  
When you install Windows Server 2016 for the first time, you have the following installation options:

>[!NOTE]
> In the following list, editions without “Desktop Experience” are the Server Core installation options

-	Windows Server Standard
-	Windows Server Standard with Desktop Experience
-	Windows Server Datacenter
-	Windows Server Datacenter with Desktop Experience

When you install Windows Server, version 1709, you have the following installation options:

-	Windows Server Standard 
-	Windows Server Datacenter

The Server Core option reduces the space required on disk and the potential attack surface, so we recommend that you choose the Server Core installation unless you have a particular need for the additional user interface elements and graphical management tools that are included in the Server with Desktop Experience option. If you do feel you need the additional user interface elements, see [Install Server with Desktop Experience](Getting-Started-with-Server-with-Desktop-Experience.md). 

With the Server Core option, the standard user interface (the Desktop Experience) is not installed; you manage the server using the command line, Windows PowerShell, or by remote methods.

>[!NOTE]
>
>Unlike some previous releases of Windows Server, you cannot convert between Server Core and Server with Desktop Experience after installation. If you install Server Core and later decide to use Server with Desktop Experience, you should do a fresh installation.

**User interface:** command prompt

**Install, configure, uninstall server roles locally:** at a command prompt with Windows PowerShell.

**Install, configure, uninstall server roles remotely from a Windows client computer (or server with Desktop installed:** with Server Manager, Remote Server Administration Tools (RSAT), Windows PowerShell, or Project Honolulu.

>[!NOTE]
>
>For RSAT, you must use the Windows 10 version.
>Microsoft Management Console is not available locally.

**Server roles available:**

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

## Windows Server 2016 installation

To install the Server Core installation option in Windows Server 2016, see [Windows Server Installation and Upgrade](installation-and-upgrade.md).

## Windows Server, version 1709, installation

Installation steps for Windows Server, version 1709, are the same as installing previous versions of Windows Server (from an .ISO image), with the following exceptions:
- No supported upgrades from previous versions of Windows Server to Windows Server, version 1709. A fresh installation is always required.
   This means that when you run setup.exe from the desktop of a Windows computer, the setup experience will not permit the upgrade option (it is grayed out).
- There’s no evaluation version for Windows Server, version 1709.
- There’s no OEM or retail version. Windows Server version 1709 can only be licensed through Software Assurance or loyalty programs.

To get Windows Server version 1709, see [Introducing Windows Server, version 1709](get-started-with-1709.md).
