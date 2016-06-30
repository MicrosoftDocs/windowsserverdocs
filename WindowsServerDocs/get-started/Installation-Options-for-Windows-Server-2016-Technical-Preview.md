---
title: Installation Options for Windows Server 2016 Technical Preview
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology:
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 74aa1da3-7076-4a1f-ad5b-9e17bd46dba2
author: jaimeo
---
# Installation Options for Windows Server 2016 Technical Preview

>Applies To: Windows Server Technical Preview

This document summarizes the differences between the installation options available for Windows Server&#174; 2016 Technical Preview, including the features that are installed with each option and the management options available after installation.  

## Installation options description  
When you install Windows Server 2016 Technical Preview using the Setup wizard, you can choose between **Windows Server 2016 Technical Preview** and **Windows Server Technical Preview (Server with Desktop Experience)**. The **Server with Desktop Experience** option is the Windows Server 2016 Technical Preview equivalent of the Full installation option available in Windows Server 2012 R2 with the Desktop Experience feature installed. If you do not make a choice in the Setup wizard,    Windows Server 2016 Technical Preview is installed; this is the Server Core installation option. The Server Core option reduces the space required on disk, the potential attack surface, and especially the servicing requirements, so we recommend that you choose the Server Core installation unless you have a particular need for the additional user interface elements and graphical management tools that are included in the **Server with Desktop Experience** option.  

> [!NOTE]  
> Unlike some previous releases of Windows Server, your choice of Server Core vs. Server with Desktop Experience at the time of installation is not convertible to the other mode.  

The "Minimal Server Interface" and "Server with a GUI" modes present in Windows Server 2012 R2 are not available in this release.  

> [!NOTE]  
> You can also install Windows Server Technical Preview as a Nano Server, which is a remotely administered version of Windows Server that is optimized for hosting in private clouds, datacenters, and running applications that are developed using cloud application patterns. This installation option is not available from the Setup wizard; you install it by configuring a VHD. For more details, see [Getting Started with Nano Server](https://technet.microsoft.com/en-us/library/mt126167.aspx).  

### If you choose the Server with Desktop Experience option  
With this option, the standard user interface and all tools are installed, including client experience features that required a separate installation in Windows Server 2012 R2. Server roles and features are installed with Server Manager or by other methods.  

-   **User interface:** standard graphical user interface ("Server Graphical Shell"). The Server Graphical Shell includes the new Windows 10 shell. The specific Windows features installed by default with this option are User-Interfaces-Infra, Server-GUI-Shell, Server-GUI-Mgmt-Infra, InkAndHandwritingServices, ServerMediaFoundation and Desktop Experience. **While these features do appear in Server Manager in this release, uninstalling them is not supported and they will not be available in future releases.**  

-   **Install, configure, uninstall server roles locally:** with Server Manager or with Windows PowerShell  

    **Install, configure, uninstall server roles remotely:** with Server Manager, Remote Server, RSAT, or Windows PowerShell  

-   **Microsoft Management Console:** installed  

### If you choose the Windows Server 2016 Technical Preview option  
With this option, the standard user interface (the "Server Graphical Shell") is not installed; you manage the server using the command line, Windows PowerShell, or by remote methods.  

-   **User interface:** command prompt  

-   **Install, configure, uninstall server roles locally:** at a command prompt with Windows PowerShell.  

-   **Install, configure, uninstall server roles remotely:** with Server Manager, Remote Server Administration Tools (RSAT), or Windows PowerShell.  

    > [!NOTE]  
    > For RSAT, you must use the Windows 10 version.  

-   **Microsoft Management Console:** not available locally.  

-   **Server roles available:**  

    -   Active Directory Certificate Services  

    -   Active Directory Domain Services  

    -   DHCP Server  

    -   DNS Server  

    -   File Services (including File Server Resource Manager)  

    -   Active Directory Lightweight Directory Services (AD LDS)  

    -   Hyper-V  

    -   Print and Document Services  

    -   Streaming Media Services  

    -   Web Server (including a subset of ASP.NET)  

    -   Windows Server Update Server  

    -   Active Directory Rights Management Server  

    -   Routing and Remote Access Server and the following sub-roles:  

        -   Remote Desktop Services Connection Broker  

        -   Licensing  

        -   Virtualization  

## <a name="BKMK_LINKS"></a>See also  
For detailed information about working with a server in Server Core mode, see [Configure and Manage Server Core Installations](https://technet.microsoft.com/en-us/library/jj574091.aspx).  

1.0  
