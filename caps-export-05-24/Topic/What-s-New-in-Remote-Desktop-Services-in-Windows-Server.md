---
title: What&#39;s New in Remote Desktop Services in Windows Server
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 00330c05-5c14-4c49-9032-86393c3beeb3
author: lizap
---
# What&#39;s New in Remote Desktop Services in Windows Server
This topic describes the Remote Desktop Services functionality that is new or changed in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and Windows Server 2012.  
  
**In this topic:**  
  
-   [What’s new in Remote Desktop Services in Windows Server 2012 R2](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#BKMK_RDS2012R2)  
  
-   [What’s new in Remote Desktop Services in Windows Server 2012](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#BKMK_RDS2012)  
  
## <a name="BKMK_RDS2012R2"></a>What’s new in Remote Desktop Services in Windows Server 2012 R2  
In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], Remote Desktop Services offers enhanced support in the following areas:  
  
-   [Session Shadowing](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#BKMK_SS)  
  
-   [Online Data Deduplication](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#BKMK_ODD)  
  
-   [Improved RemoteApp behavior](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#BKMK_RA)  
  
-   [Quick reconnect for remote desktop clients](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#BKMK_Quick)  
  
-   [Improved compression and bandwidth usage](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#BKMK_Band)  
  
-   [Dynamic display handling](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#BKMK_DDH)  
  
-   [RemoteFX virtualized GPU supports DX11.1](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#BKMK_FX)  
  
-   [RestrictedAdmin Mode Remote Desktop](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#BKMK_Admin)  
  
-   [Remote Desktop Services role services description](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#overview)  
  
-   [Removed or deprecated functionality](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#BKMK_DEP)  
  
### <a name="BKMK_SS"></a>Session Shadowing  
In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], Session Shadowing enables you to remotely monitor or control an active session of another user on a Remote Desktop Session Host \(RD Session Host\) server. The current version includes integration with Server Manager and Remote Desktop Connection \(mstsc.exe\).  
  
### <a name="BKMK_ODD"></a>Online Data Deduplication  
In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] the Data Deduplication feature, released in Windows Server 2012, can be used with actively running personal desktop collections when the desktop virtual hard disks \(VHDs\) are stored on a file server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and accessed by using Server Message Block \(SMB\). Storage capacity requirements can be dramatically reduced by using the Data Deduplication feature. Data Deduplication on the SMB server caches frequently accessed data, allowing performance improvements on many read\-intensive operations, including parallel remote client boot.  
  
### <a name="BKMK_RA"></a>Improved RemoteApp behavior  
In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] RemoteApp programs are one step closer to the look and feel of local applications by including support for transparency, live thumbnails, and seamless application move that allows the application content to remain visible while the application is moved on screen.  
  
### <a name="BKMK_Quick"></a>Quick reconnect for remote desktop clients  
In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] Quick Reconnect improves connection performance enabling users to reconnect to their existing virtual desktops, RemoteApp programs, and session\-based desktops more quickly. The connection process for RemoteApp programs has been redesigned for [!INCLUDE[winblue_client_1](../Token/winblue_client_1_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] clients, to be more informative and user friendly.  
  
### <a name="BKMK_Band"></a>Improved compression and bandwidth usage  
[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] improves performance on the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] remote experience, by using codecs that enable better compression, delivering bandwidth savings \(for example video content delivery over a WAN utilizes up to 50% less bandwidth compared to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]\).  
  
### <a name="BKMK_DDH"></a>Dynamic display handling  
In [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] support has been added for display changes on the client to be automatically reflected on the remote client. This translates to seamless device rotation, and monitor addition and removal \(for example connecting to a projector or docking a laptop\) for both remote sessions and RemoteApp programs.  
  
### <a name="BKMK_FX"></a>RemoteFX virtualized GPU supports DX11.1  
The RemoteFX vGPU in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] includes support for DX11.1 on systems that have DX11.1 capable GPU cards. Graphics intensive applications that rely on DX11.1 features can be virtualized and run in a virtualized environment on [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] introduces the following functionality:  
  
-   Non\-Uniform Memory Access \(NUMA\) support: RemoteFX running on NUMA\-based platforms will experience improved scaling capabilities.  
  
-   Video RAM \(VRAM\) changes: Adding system memory, to the server running Hyper\-V, will allow for a dynamic increase in virtual machine VRAM which can improve performance for applications.  
  
### <a name="BKMK_Admin"></a>RestrictedAdmin Mode Remote Desktop  
[!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] support a new remote desktop option to connect in RestrictedAdmin mode. When connecting using RestrictedAdmin mode, the user’s credentials are not sent to the host by the remote desktop client. Using this mode with administrator credentials, the remote desktop client attempts to interactively logon to a host that also supports this mode without sending credentials. When the host verifies that the user account connecting to it has administrator rights and supports Restricted Admin mode, the connection is successful. Otherwise, the connection attempt fails. Restricted Admin mode does not at any point send plain text or other re\-usable forms of credentials to remote computers.  
  
> [!NOTE]  
> Once connected to a host in RestrictedAdmin mode, the user will not be able to seamlessly access other network resources from that host using the credentials they provided to the remote desktop client.  
  
To connect using RestrictedAdmin mode requires  
  
-   [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] for the remote desktop host  
  
-   [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] for the remote desktop client  
  
### <a name="overview"></a>Remote Desktop Services role services description  
Remote Desktop Services is a server role that consists of several role services. In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], Remote Desktop Services consists of the following role services:  
  
|Role service name|Role service description|  
|---------------------|----------------------------|  
|RD Virtualization Host|Remote Desktop Virtualization Host \(RD Virtualization Host\) integrates with Hyper\-V to deploy pooled or personal virtual desktop collections within your organization.|  
|RD Session Host|Remote Desktop Session Host \(RD Session Host\) enables a server to host RemoteApp programs or session\-based desktops. Users can connect to RD Session Host servers in a session collection to run programs, save files, and use resources on those servers.|  
|RD Connection Broker|Remote Desktop Connection Broker \(RD Connection Broker\):<br /><br />-   Allows users to reconnect to their existing virtual desktops, RemoteApp programs, and session\-based desktops.<br />-   Enables you to evenly distribute the load among RD Session Host servers in a session collection or pooled virtual desktops in a pooled virtual desktop collection.<br />-   Provides access to virtual desktops in a virtual desktop collection.|  
|RD Web Access|Remote Desktop Web Access \(RD Web Access\) enables users to access RemoteApp and Desktop Connection through the **Start** menu on a computer that is running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], Windows 7, or through a web browser. RemoteApp and Desktop Connection provides a customized view of RemoteApp programs and session\-based desktops in a session collection, and RemoteApp programs and virtual desktops in a virtual desktop collection.|  
|RD Licensing|Remote Desktop Licensing \(RD Licensing\) manages the licenses required to connect to a Remote Desktop Session Host server or a virtual desktop. You can use RD Licensing to install, issue, and track the availability of licenses.|  
|RD Gateway|Remote Desktop Gateway \(RD Gateway\) enables authorized users to connect to virtual desktops, RemoteApp programs, and session\-based desktops on an internal corporate network from any Internet\-connected device.|  
  
### <a name="BKMK_DEP"></a>Removed or deprecated functionality  
For a list of deprecated features, see [Features Removed or Deprecated in Windows Server 2012 R2](../Topic/Features-Removed-or-Deprecated-in-Windows-Server-2012-R2.md).  
  
## <a name="BKMK_RDS2012"></a>What’s new in Remote Desktop Services in Windows Server 2012  
The Remote Desktop Services server role in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides technologies that enable users to connect to virtual desktops, RemoteApp programs, and session\-based desktops. With Remote Desktop Services, users can access remote connections from within a corporate network or from the Internet.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Remote Desktop Services offers enhanced support for the following scenarios:  
  
-   [Virtual Desktop Infrastructure \(VDI\) deployment](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#BKMK_VDI)  
  
-   [Session Virtualization deployment](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#BKMK_SV)  
  
-   [Centralized resource publishing](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#BKMK_CRP)  
  
-   [Rich user experience with Remote Desktop Protocol \(RDP\)](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#BKMK_RDP)  
  
-   [Rich graphics experience with RemoteFX vGPU](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#BKMK_GPU)  
  
-   [Remote Desktop Services role services description](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#overview2)  
  
-   [Removed or deprecated functionality](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md#BKMK_DEP2)  
  
### <a name="BKMK_VDI"></a>Virtual Desktop Infrastructure \(VDI\) deployment  
Remote Desktop Services introduced a VDI deployment in Windows Server 2008 R2. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Remote Desktop Services includes new ways to efficiently configure and manage your virtual desktops. Some of the enhancements include:  
  
-   **Unified central experience** – Deploy VDI quickly, and then manage your pooled and personal virtual desktop deployments through a new unified central experience.  
  
-   **Automated and simple single\-image management** – Take advantage of automated ways to deploy and manage pooled virtual desktops with a virtual desktop template.  
  
-   **User personalization** – Preserve user personalization settings for pooled virtual desktop deployments by using user profile disks.  
  
-   **Less expensive storage** – Use inexpensive local storage with live migration functionality between host computers for pooled virtual desktops. Personal virtual desktops can use the less expensive SMB central storage.  
  
### <a name="BKMK_SV"></a>Session Virtualization deployment  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Session Virtualization deployment in Remote Desktop Services includes new ways to efficiently configure and manage your session\-based desktops. In earlier versions of Remote Desktop Services, ongoing management of the RD Session Host servers is performed at a per server level. By using a Session Virtualization deployment scenario, centralized management and installation is enabled. Session Virtualization in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] offers the following benefits:  
  
-   **Unified central experience** – In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can deploy Session Virtualization quickly and manage your deployments through a new unified central experience.  
  
-   **Simplified and centralized deployment** – Simple scenario\-based installations allow you to create an entire session collection at one time.  
  
-   **User personalization** – User profile disks allow you to preserve user personalization settings for your session collections.  
  
-   **Centralized and unified management** – Manage all of the RD Session Host servers in your session collection from a single location.  
  
-   **Fairshare experience** – For a predictable user experience in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and to ensure that one user does not negatively impact the performance of another user’s session, the following features are enabled by default on RD Session Host servers:  
  
    -   **Network Fairshare** – Dynamically distributes available bandwidth across sessions based on the number of active sessions to enable equal bandwidth utilization.  
  
    -   **Disk Fairshare** – Prevents sessions from over utilizing disk usage by equal distribution of disk I\/O among sessions.  
  
    -   **CPU Fairshare** – Dynamically distributes processor time across sessions based on the number of active sessions and load on these sessions. This was introduced in Windows Server 2008 R2 and has been improved for heavier loads in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
A Session Virtualization deployment consists of RD Session Host servers along with infrastructure servers, such as RD Licensing, RD Connection Broker, RD Gateway, and RD Web Access servers.  
  
A session collection \(referred to as a farm in earlier versions of Windows Server\) is a grouping of RD Session Host servers for a given session. A session collection is used to publish one of the following resources:  
  
-   Session\-based desktops  
  
-   RemoteApp programs  
  
Session Virtualization is a scenario\-based installation within Server Manager that allows you to install, configure, and manage RD Session Host servers from a central location. With the Session Virtualization deployment scenario, you’re presented with two deployment types:  
  
-   **Quick Start:** Installs all the necessary Remote Desktop Services role services on one computer to enable you to install and configure Remote Desktop Services role services in a test environment.  
  
-   **Standard deployment:** Allows you to flexibly deploy the various Remote Desktop Services role services on different servers.  
  
### <a name="BKMK_CRP"></a>Centralized resource publishing  
In Windows Server 2008 R2, publishing and managing applications on both pooled and personal virtual desktops is a very time\-consuming and costly process. Because RemoteApp programs only partially integrate with the native Windows® experience, they add to the management cost since there is no way to organize published RemoteApp programs to users.  
  
Remote Desktop Services in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] enables you to publish and manage resources, such as RemoteApp programs, session\-based desktops, and virtual desktops, from a centralized console. Using this new publishing feature, you can get an historic view of resources assigned to end users, change published resources for any given collection, and edit properties of published resources.  
  
In addition to the centralized console, you can now configure a RemoteApp and Desktop Connection URL by using Group Policy, and then give users access to the URL automatically through an email address.  
  
Centralized resource publishing provides end users with an experience that can replace locally installed applications.  
  
### <a name="BKMK_RDP"></a>Rich user experience with Remote Desktop Protocol \(RDP\)  
Windows Server 2008 R2 with Service Pack 1 and Windows 7 with Service Pack 1 introduced Microsoft RemoteFX, which enables the delivery of a full Windows user experience to a range of client devices, including rich clients, thin clients, and ultrathin clients. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] builds on this platform to enable a richer and more seamless experience on all types of networks and devices. Specifically, Remote Desktop Protocol \(RDP\) enables a consistent user experience when connecting to centralized workspaces even on networks where bandwidth is limited and latency is high.  
  
Following are the key benefits for end users and IT professionals in using RDP in [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] for their centralized workspace deployments.  
  
|||  
|-|-|  
|RDP key benefits to end users|RDP key benefits to IT professionals|  
|-   Rich end user experience<br />-   Access to corporate desktop and applications from anywhere by using any device<br />-   Secure, managed, and fully supported desktops and applications|<ul><li>Flexible deployment options<br /><br /><ul><li>Virtual desktops</li><li>Session\-based desktops</li><li>RemoteApp programs</li><li>Full desktop clients</li><li>Thin clients</li><li>Corporate networks</li><li>Branch offices</li></ul></li><li>Diverse workforce support<br /><br /><ul><li>Roaming users</li><li>Telecommuters</li><li>Bring your own computer</li></ul></li><li>Keep costs down</li></ul>|  
  
### <a name="BKMK_GPU"></a>Rich graphics experience with RemoteFX vGPU  
Windows Server 2008 R2 with Service Pack 1 and Windows 7 with Service Pack 1 introduced Microsoft RemoteFX vGPU support, a set of technologies for a rich PC\-like experience for virtual desktops. Windows Server 2008 R2 with Service Pack 1 introduced the following functionality:  
  
-   Host\-side remoting  
  
-   Render\-capture\-encode pipeline  
  
-   Highly efficient GPU\-based encode  
  
-   Throttling based on client activity  
  
-   DirectX\-enabled virtual graphics processing unit \(vGPU\)  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] builds upon this platform and implements support for the vGPU from DX9 to DX11. The user experience is also improved including support for additional monitors at higher resolutions. As hardware acceleration proliferates to more applications like the web browser, the vGPU enables applications to run higher levels of DirectX within Remote Desktop Virtualization Host \(RD Virtualization Host\).  
  
Maximum monitor resolution for virtual machines per Windows Version:  
  
|Maximum resolution|Monitors per virtual machine for Windows 7 with SP 1|Monitors per virtual machine for Windows 8|  
|----------------------|--------------------------------------------------------|----------------------------------------------|  
|1024 x 768|4|8|  
|1280 x 1024|4|8|  
|1600 x 1200|3|4|  
|1920 x 1200|2|4|  
|2560 x 1600|\-|2|  
  
### <a name="overview2"></a>Remote Desktop Services role services description  
Remote Desktop Services is a server role that consists of several role services. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Remote Desktop Services consists of the following role services:  
  
|Role service name|Role service description|  
|---------------------|----------------------------|  
|RD Virtualization Host|Remote Desktop Virtualization Host \(RD Virtualization Host\) integrates with Hyper\-V to deploy pooled or personal virtual desktop collections within your organization by using RemoteApp and Desktop Connection.|  
|RD Session Host|Remote Desktop Session Host \(RD Session Host\) enables a server to host RemoteApp programs or session\-based desktops. Users can connect to RD Session Host servers in a session collection to run programs, save files, and use resources on those servers.|  
|RD Connection Broker|Remote Desktop Connection Broker \(RD Connection Broker\):<br /><br />-   Allows users to reconnect to their existing virtual desktops, RemoteApp programs, and session\-based desktops.<br />-   Enables you to evenly distribute the load among RD Session Host servers in a session collection or pooled virtual desktops in a pooled virtual desktop collection.<br />-   Provides access to virtual desktops in a virtual desktop collection.|  
|RD Web Access|Remote Desktop Web Access \(RD Web Access\) enables users to access RemoteApp and Desktop Connection through the **Start** menu on a computer that is running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], Windows 7, or through a web browser. RemoteApp and Desktop Connection provides a customized view of RemoteApp programs and session\-based desktops in a session collection, and RemoteApp programs and virtual desktops in a virtual desktop collection.|  
|RD Licensing|Remote Desktop Licensing \(RD Licensing\) manages the licenses required to connect to a Remote Desktop Session Host server or a virtual desktop. You can use RD Licensing to install, issue, and track the availability of licenses.|  
|RD Gateway|Remote Desktop Gateway \(RD Gateway\) enables authorized users to connect to virtual desktops, RemoteApp programs, and session\-based desktops on an internal corporate network from any Internet\-connected device.|  
  
### <a name="BKMK_DEP2"></a>Removed or deprecated functionality  
For a list of deprecated features, see [Features Removed or Deprecated in Windows Server 2012](../Topic/Features-Removed-or-Deprecated-in-Windows-Server-2012.md).  
  
## See also  
  
-   [Remote Desktop Services Overview](../Topic/Remote-Desktop-Services-Overview.md)  
  
-   [What’s New in Remote Desktop Services in Windows Server 2008 R2](http://technet.microsoft.com/library/dd560658(v=WS.10).aspx)  
  
-   [What's New in Terminal Services for Windows Server 2008](http://technet.microsoft.com/library/cc733093(v=WS.10).aspx)  
  
-   [Changes in Functionality in Terminal Services from Windows Server 2003 with SP1 to Windows Server 2008](http://technet.microsoft.com/library/cc731263(v=ws.10).aspx)  
  
