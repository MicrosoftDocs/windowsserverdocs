---
title: Remote Desktop Services Overview
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 29ca8b62-e699-4cd7-ab93-007734f155fe
author: lizap
---
# Remote Desktop Services Overview
Remote Desktop Services accelerates and extends desktop and application deployments to any device, improving remote worker efficiency, while helping to keep critical intellectual property secure and simplify regulatory compliance. Remote Desktop Services enables virtual desktop infrastructure \(VDI\), session\-based desktops, and applications, allowing users to work anywhere.  
  
**Did you mean…**  
  
-   [Terminal Services in Windows Server 2008](http://technet.microsoft.com/library/cc754746(WS.10).aspx)  
  
-   [Remote Desktop Services in Windows Server 2008 R2](http://technet.microsoft.com/library/dd647502(WS.10).aspx)  
  
-   [Remote Desktop Services resources \(all versions\)](http://technet.microsoft.com/windowsserver/ee236407)  
  
-   [Microsoft Server and Cloud Platform](http://www.microsoft.com/server-cloud/)  
  
|||  
|-|-|  
|![](b93f8edc-baa1-46ad-aed5-99c8690273c0)|Did you know that Microsoft Azure provides similar functionality in the cloud? Learn more about [Microsoft Azure virtualization solutions](http://aka.ms/f9bh7g).<br /><br />Create a hybrid virtualization solution in Microsoft Azure:<br />\- [Learn about Azure RemoteApp](http://aka.ms/w9e2d7)<br />\- [Migrate a hybrid collection from a RemoteApp VNET to an Azure VNET](http://aka.ms/ej05ot)<br />\- [Create a hybrid collection for Azure RemoteApp](http://aka.ms/hgnm06)<br />\- [Publish an app in Azure RemoteApp](http://aka.ms/iwew4c)|  
  
## <a name="BKMK_OVER"></a>Role description  
The Remote Desktop Services role provides technologies that enable users to connect to virtual desktops, RemoteApp programs, and session\-based desktops. With Remote Desktop Services, users can access remote connections from within a corporate network or from the Internet.  
  
## <a name="BKMK_APP"></a>Practical applications  
Remote Desktop Services allows workers to work anywhere. Some of the key benefits of Remote Desktop Services include:  
  
-   **Unified administration experience** – Administer your session and virtual desktop collections, configure your RemoteApp programs, manage your virtual desktops, and add servers to the deployment from one centralized console.  
  
-   **User personalization** – User profile disks allow you to preserve user personalization settings across session collections and pooled virtual desktop collections.  
  
-   **Less expensive storage** – Pooled virtual desktops can use local storage live migration between host computers. Personal virtual desktops can use storage located on network shares.  
  
-   **Automated pooled virtual desktop management** – Deploy and manage pooled virtual desktops centrally by using a virtual desktop template. Any changes, such as application installation or security updates, are installed on the virtual desktop template, and the pooled virtual desktops are then recreated from the virtual desktop template.  
  
## <a name="BKMK_NEW1"></a>New and changed functionality for Windows Server 2012 R2  
In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], Remote Desktop Services includes enhancements in the following areas:  
  
-   Monitor and control by using session shadowing  
  
-   Reduced storage requirements and improved performance accessing common data  
  
-   RemoteApp programs perform more like locally\-based applications  
  
-   Improved reconnection performance for remote clients  
  
-   Improved compression allowing improved usage of network bandwidth  
  
-   Display resolution changes are automatically reflected on the remote client  
  
-   RemoteFX virtualized GPU supports DX11.1  
  
For more information about new features and functionality, see [What's New in Remote Desktop Services in Windows Server](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md).  
  
## <a name="BKMK_NEW"></a>New and changed functionality for Windows Server 2012  
Remote Desktop Services enables the mobile work force to connect to desktop and applications from anywhere. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Remote Desktop Services includes enhancements in the following areas:  
  
-   Simplified Virtual Desktop Infrastructure \(VDI\) deployment and management  
  
-   Simplified Session Virtualization deployment and management  
  
-   Centralized resource publishing  
  
-   Rich user experience with Remote Desktop Protocol \(RDP\)  
  
The user experience has been enhanced for Remote Desktop Services in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] in the following ways:  
  
-   Rich Windows desktop remoting experience  
  
-   Smooth audio and video playback experience  
  
-   Rich graphics and video user experience over a WAN  
  
-   Enhanced device remoting support with USB Redirection for Session Virtualization and VDI  
  
-   True Multi\-Touch and gesture remoting  
  
-   Email name discovery and subscription to administrator supplied remote resources  
  
-   RemoteFX virtualized GPU provides DX 11 support  
  
In addition to these areas of enhancement, Remote Desktop Services in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces a new management console for managing the majority of Remote Desktop Services\-related tasks. For more information about new features and functionality, see [What's New in Remote Desktop Services in Windows Server](../Topic/What-s-New-in-Remote-Desktop-Services-in-Windows-Server.md).  
  
## <a name="BKMK_Clients"></a>New Microsoft Remote Desktop Clients  
You can use the Microsoft Remote Desktop client to connect to a remote PC and your work resources from almost anywhere. Experience rich interactivity using a remote desktop client designed to help you get your work done wherever you are. For example, you can connect to your work PC and have access to all of your apps, files, and network resources as if you were sitting right in front of your work PC. You can leave apps open at work and then see those same apps using the RD client.  
  
For information about these new features and functionality for Android, iOS, and Mac, see [Microsoft Remote Desktop Clients](../Topic/Microsoft-Remote-Desktop-Clients.md).  
  
## <a name="BKMK_DEP"></a>Removed or deprecated functionality  
For a list of deprecated features, see [Features Removed or Deprecated in Windows Server 2012 R2](../Topic/Features-Removed-or-Deprecated-in-Windows-Server-2012-R2.md) and [Features Removed or Deprecated in Windows Server 2012](../Topic/Features-Removed-or-Deprecated-in-Windows-Server-2012.md).  
  
## <a name="BKMK_HARD"></a>Hardware requirements  
Remote Desktop Services requires that the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] operating system be installed. There are no additional hardware or software requirements for running Remote Desktop Services.  
  
There are several hardware requirements that must be met when you deploy RemoteFX virtualized GPU to hardware accelerate your Windows client virtual desktops:  
  
-   **SLAT\-enabled processor**. The processor on the RemoteFX server must support Second\-Level Address Translation \(SLAT\).  
  
-   **GPU**. At least one graphics processing unit \(GPU\) that is capable of supporting RemoteFX is required on the RemoteFX server. The GPU driver must support DirectX 11.  
  
    > [!NOTE]  
    > Without a RemoteFX virtualized GPU, applications that require DirectX will still work using a built in Hyper\-V specific GPU.  
  
## <a name="BKMK_INSTALL"></a>Server Manager information  
Remote Desktop Services is a server role that consists of several role services. In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the following Remote Desktop Services role services can be installed with this role:  
  
|Role service name|Role service description|  
|---------------------|----------------------------|  
|RD Virtualization Host|Remote Desktop Virtualization Host \(RD Virtualization Host\) integrates with Hyper\-V to deploy pooled or personal virtual desktop collections within your organization.|  
|RD Session Host|Remote Desktop Session Host \(RD Session Host\) enables a server to host RemoteApp programs or session\-based desktops. Users can connect to RD Session Host servers in a session collection to run programs, save files, and use resources on those servers.|  
|RD Connection Broker|Remote Desktop Connection Broker \(RD Connection Broker\):<br /><br />-   Allows users to reconnect to their existing virtual desktops, RemoteApp programs, and session\-based desktops.<br />-   Enables you to evenly distribute the load among RD Session Host servers in a session collection or pooled virtual desktops in a pooled virtual desktop collection.<br />-   Provides access to virtual desktops in a virtual desktop collection.|  
|RD Web Access|Remote Desktop Web Access \(RD Web Access\) enables users to access RemoteApp and Desktop Connection through the **Start** menu on a computer that is running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], Windows 7, or through a web browser. RemoteApp and Desktop Connection provides a customized view of RemoteApp programs and session\-based desktops in a session collection, and RemoteApp programs and virtual desktops in a virtual desktop collection.|  
|RD Licensing|Remote Desktop Licensing \(RD Licensing\) manages the licenses required to connect to a Remote Desktop Session Host server or a virtual desktop. You can use RD Licensing to install, issue, and track the availability of licenses.|  
|RD Gateway|Remote Desktop Gateway \(RD Gateway\) enables authorized users to connect to virtual desktops, RemoteApp programs, and session\-based desktops on an internal corporate network from any Internet\-connected device.|  
  
## <a name="BKMK_LINKS"></a>See also  
The following table provides additional resources for evaluating Remote Desktop Services.  
  
|Content type|References|  
|----------------|--------------|  
|**Product evaluation**|-   [Test Lab Guide: Virtual Desktop Infrastructure Quick Start](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Quick-Start.md)<br />-   [Test Lab Guide: Virtual Desktop Infrastructure Standard Deployment](../Topic/Test-Lab-Guide--Virtual-Desktop-Infrastructure-Standard-Deployment.md)<br />-   [Test Lab Guide: Remote Desktop Services Session Virtualization Quick Start](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Quick-Start.md)<br />-   [Test Lab Guide: Remote Desktop Services Session Virtualization Standard Deployment](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Session-Virtualization-Standard-Deployment.md)<br />-   [Test Lab Guide: Managed Pooled Virtual Desktop Collections](../Topic/Test-Lab-Guide--Managed-Pooled-Virtual-Desktop-Collections.md)<br />-   [Test Lab Guide: Unmanaged Pooled Virtual Desktop Collections](../Topic/Test-Lab-Guide--Unmanaged-Pooled-Virtual-Desktop-Collections.md)<br />-   [Test Lab Guide: Remote Desktop Services Publishing](../Topic/Test-Lab-Guide--Remote-Desktop-Services-Publishing.md)<br />-   [Test Lab Guide: Remote Desktop Licensing](../Topic/Test-Lab-Guide--Remote-Desktop-Licensing.md)<br />-   [Remote desktop experience in Windows 8](http://channel9.msdn.com/Events/BUILD/BUILD2011/SAC-642T)|  
|**Community resources**|<ul><li>[Remote Desktop Services \(Terminal Services\) Team Blog](http://blogs.msdn.com/b/rds/)</li><li>[Remote Desktop Services Web Forum](http://social.technet.microsoft.com/Forums/en/winserverTS/threads)</li><li>[Remote Desktop Services TechNet Wiki](http://social.technet.microsoft.com/wiki/)</li><li>[Hyper\-V Forum](http://social.technet.microsoft.com/Forums/winserverhyperv/threads)</li><li>[Windows Virtualization Team Blog](http://blogs.technet.com/virtualization/)</li><li>[Microsoft Virtual Academy: Using Microsoft VDI to Enable New Workstyles](http://channel9.msdn.com/Series/Using-Microsoft-VDI-to-Enable-New-Workstyles)<br /><br /><ul><li>[Microsoft Virtual Academy: Using Microsoft VDI to Enable New Workstyles: \(01\) Introduction to Desktop Virtualization](http://channel9.msdn.com/Series/Using-Microsoft-VDI-to-Enable-New-Workstyles/Using-Microsoft-VDI-to-Enable-New-Workstyles-01-Introduction-to-Desktop-Virtualization)</li><li>[Microsoft Virtual Academy: Using Microsoft VDI to Enable New Workstyles: \(02\) Optimizing the User Experience](http://channel9.msdn.com/Series/Using-Microsoft-VDI-to-Enable-New-Workstyles/Using-Microsoft-VDI-to-Enable-New-Workstyles-02-Optimizing-the-User-Experience)</li><li>[Microsoft Virtual Academy: Using Microsoft VDI to Enable New Workstyles: \(03\) Deploying Virtual Desktops with Windows Server 2012 and RDS](http://channel9.msdn.com/Series/Using-Microsoft-VDI-to-Enable-New-Workstyles/Using-Microsoft-VDI-to-Enable-New-Workstyles-03-Deploying-Virtual-Desktops-with-Windows-Server-2012-)</li><li>[Microsoft Virtual Academy: Using Microsoft VDI to Enable New Workstyles: \(04\) Hyper\-V for VDI](http://channel9.msdn.com/Series/Using-Microsoft-VDI-to-Enable-New-Workstyles/Using-Microsoft-VDI-to-Enable-New-Workstyles-04-Hyper-V-for-VDI)</li><li>[Microsoft Virtual Academy: Using Microsoft VDI to Enable New Workstyles: \(05\) Capacity Planning and Architecture](http://channel9.msdn.com/Series/Using-Microsoft-VDI-to-Enable-New-Workstyles/Using-Microsoft-VDI-to-Enable-New-Workstyles-05-Capacity-Planning-and-Architecture)</li><li>[Microsoft Virtual Academy: Using Microsoft VDI to Enable New Workstyles: \(06\) Leveraging Citrix](http://channel9.msdn.com/Series/Using-Microsoft-VDI-to-Enable-New-Workstyles/Using-Microsoft-VDI-to-Enable-New-Workstyles-06-Leveraging-Citrix)</li><li>[Microsoft Virtual Academy: Using Microsoft VDI to Enable New Workstyles: \(07\) Microsoft VDI Licensing](http://channel9.msdn.com/Series/Using-Microsoft-VDI-to-Enable-New-Workstyles/Using-Microsoft-VDI-to-Enable-New-Workstyles-07-Microsoft-VDI-Licensing)</li></ul></li></ul>|  
|**Related technologies**|-   [Terminal Services in Windows Server 2008](http://technet.microsoft.com/library/cc754746(WS.10).aspx)<br />-   [Remote Desktop Services in Windows Server 2008 R2](http://technet.microsoft.com/library/dd647502(WS.10).aspx)<br />-   [Remote Desktop Services resources \(all versions\)](http://technet.microsoft.com/windowsserver/ee236407)|  
  
