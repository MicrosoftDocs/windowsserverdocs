---
title: Remote Desktop Services Technical Preview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7be33b82-4e6d-4c5b-9289-813aebf1bfa3
author: lizap
---
# Remote Desktop Services Technical Preview
Remote Desktop Services enables the mobile work force to connect to desktops and applications from anywhere they want to provide the full Windows experience.  
  
Microsoft has made significant investments in the user and management experiences in Remote Desktop Services in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. For the user experience, our goal was to ensure that users have a rich experience, regardless of the type of device that is used to connect, the type of resources they are connecting to \(for example, virtual desktops, RemoteApp programs, or session\-based desktops\), or whether they are connecting through a LAN or WAN. For the management experience, there is now a centralized console so you can manage the Remote Desktop Services role services and their associated resources from a single location.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Remote Desktop Services has enhanced support for the following scenarios:  
  
-   Unified, simplified, low\-cost Virtual Desktop Infrastructure \(VDI\) deployments  
  
-   Unified, simplified, low\-cost Session Virtualization deployments  
  
-   Centralized resource publishing  
  
-   Rich user experience with RemoteFX  
  
The overall architecture for Remote Desktop Services in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is shown in Figure 1.  
  
![](../Image/1_RDS_Rev_Guide.jpg)  
  
**Figure 1** Remote Desktop Services architecture  
  
## Unified, simplified, low\-cost VDI deployment  
Remote Desktop Services introduced a VDI deployment in Windows Server 2008 R2. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], VDI in Remote Desktop Services provides the following new ways to configure and manage your virtual desktops to reduce the total cost\-of\-ownership in traditional desktop deployments:  
  
-   **Unified central experience** You can deploy VDI in less than few hours using commodity hardware and manage your pooled and personal virtual desktop deployments from a single pane of glass through a new unified central experience.  
  
-   **Simple single image management** VDI enables automation for deploying and managing pooled virtual desktops with a virtual desktop template.  
  
-   **User personalization** User profile disks allow you to preserve user personalization settings for pooled virtual desktop deployments.  
  
-   **Less expensive storage** You can use less expensive local storage by using the live migrate functionality between host computers for pooled virtual desktops, and personal virtual desktops can use less expensive central server message block \(SMB\) storage.  
  
### Virtual desktops  
There are two types of virtual desktops in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]: pooled and personal. Pooled virtual desktops allow the user to log on to any virtual desktop in the virtual desktop pool and get the same experience. With a pooled virtual desktop, user personalization is stored in a user profile disk. Personal virtual desktops are permanently assigned to a user account and the user logs on to the same virtual desktop each time to get a fully personalized experience.  
  
The following table shows the available options for managing your virtual desktops.  
  
|Virtual desktop creation|Virtual desktop updates|Pooled|Personal|  
|----------------------------|---------------------------|----------|------------|  
|Automatically create virtual desktops from a virtual desktop template|Virtual desktops are automatically updated.|Yes<br /><br />\(This is the recommended deployment scenario for pooled virtual desktops.\)|No|  
||Virtual desktops are individually updated.|Yes<br /><br />\(This is supported but not recommended.\)|Yes<br /><br />\(This is the recommended deployment scenario for personal virtual desktops.\)|  
|Manually create or import virtual desktops|Virtual desktops are automatically updated.|No|No|  
||Virtual desktops are individually updated.|Yes<br /><br />\(This is supported but not recommended.\)|Yes<br /><br />\(This is supported but not recommended.\)|  
  
> [!NOTE]  
> To increase performance, we recommend that you store your virtual desktop template for a pooled virtual desktop collection on a solid state drive \(SSD\).  
  
### VDI Quick Start  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], VDI Quick Start installs everything on one computer that you need test the Virtual Desktop Infrastructure deployment scenario.  
  
VDI Quick Start does the following:  
  
-   Installs the RD Connection Broker, RD Virtualization Host, and RD Web Access role services on a single computer.  
  
-   Creates a pooled virtual desktop collection with two pooled virtual desktops that are based on a virtual hard disk that is the virtual desktop template.  
  
-   Creates a Hyper\-V network switch named RDS Virtual.  
  
> [!NOTE]  
> VDI Quick Start is not recommended for a production environment.  
  
### VDI Standard Deployment  
Virtual Desktop Infrastructure Standard Deployment is new in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and it allows you to install the appropriate role services on separate computers. Unlike the VDI Quick Start, a standard deployment gives you precise control of virtual desktops and virtual desktop collections by not creating them automatically.  
  
### High availability for your VDI deployment  
Remote Desktop Services in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides support for highly available virtual desktop collections by leveraging a clustered environment.  
  
RD Connection Broker plays a central role with Remote Desktop Services scenarios by providing users access to the virtual desktops and RemoteApp programs in a virtual desktop collection.  
  
With [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can easily deploy clustered instances of RD Connection Broker for high availability and improved scalability. With a centralized database, the RD Connection Broker service now only needs to be configured once. Any additional RD Connection Broker servers that are added to the deployment will be added as an active instance.  
  
If one of the RD Connection Broker servers in the cluster fails, users are not impacted because they are redirected to another RD Connection Broker server automatically.  
  
## Unified, simplified, low\-cost Session Virtualization deployment  
Many customers are deploying RD Session Host servers to reduce the total cost\-of\-ownership involved with traditional desktop deployments. In previous versions of Windows Server, the deployment of an RD Session Host server farm could be a time consuming task because you had to preinstall the RD Session Host role service on each server. Additionally in Windows Server 2008 R2, ongoing management of the RD Session Host farm was done at a per\-server level. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], a Session Virtualization deployment scenario was created to enable centralized installation and management from a “single pane of glass.”  
  
A Session Virtualization deployment consists of RD Session Host servers and infrastructure servers \(such as RD Licensing, RD Connection Broker, RD Gateway, and RD Web Access\).  
  
Session collections \(referred to as a farm in previous versions of Windows Server\) are groupings of RD Session Host servers. A session collection is used to publish one of the following resources:  
  
-   Session\-based desktops  
  
-   RemoteApp programs  
  
A Session Virtualization deployment in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] offers the following benefits:  
  
-   **Unified central experience** You can deploy Session Virtualization in a few hours by using commodity hardware, and then you can centrally manage your session\-based desktops and RemoteApp programs.  
  
-   **Simplified and centralized deployment** Simple scenario\-based installations enable you to create an entire session collection at one time.  
  
-   **User personalization** User profile disks enable you to preserve user personalization settings for your session collections.  
  
-   **Centralized and unified management** Manage all of the RD Session Host servers in your session collections from a single location.  
  
-   **Fairshare experience** Provides a predictable user experience and ensures that one user does not negatively impact the performance of another user’s session. To facilitate positive user experiences, the following features are enabled by default on RD Session Host servers:  
  
    -   **Network Fairshare** Dynamically distributes available bandwidth across sessions to enable equal bandwidth utilization, based on the number of active sessions.  
  
    -   **Disk Fairshare** Prevents sessions from over utilizing disk usage by equally distributing disk I\/O among sessions.  
  
    -   **CPU Fairshare** Dynamically distributes processor time across sessions, based on the number of active sessions and the load on these sessions. This was introduced in Windows Server 2008 R2, and has been improved for heavier loads in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
### Session Virtualization Quick Start  
Session Virtualization Quick Start installs everything on one computer that you need to evaluate the Session Virtualization deployment scenario.  
  
Session Virtualization Quick Start does the following:  
  
-   Installs the RD Connection Broker, RD Web Access, and RD Session Host role services on a single computer  
  
-   Creates a session collection  
  
-   Publishes a session\-based desktop for each RD Session Host server in the collection  
  
-   Publishes RemoteApp programs  
  
> [!NOTE]  
> Session Virtualization Quick Start is not recommended for a production environment.  
  
### Session Virtualization Standard Deployment  
Session Virtualization Standard Deployment enables you to install the appropriate role services on separate computers. Unlike Session Virtualization Quick Start, this deployment type gives you more control over the session collection and published RemoteApp programs by not creating them automatically.  
  
### Enabling high availability for your Session Virtualization deployment  
Remote Desktop Services in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides support for highly available session collections by leveraging a clustered environment.  
  
The RD Connection Broker role plays a central role in Remote Desktop Services scenarios by providing users access to their session\-based desktops or RemoteApp programs that are hosted on RD Session Host servers.  
  
With [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can deploy clustered instances of RD Connection Broker for high availability and improved scalability. With a centralized database, the RD Connection Broker service now needs to be configured only once. Additional RD Connection Broker servers that are added to the deployment will be added as an active instance.  
  
If one of the RD Connection Broker servers in the cluster fails, users are not impacted because they are redirected to another RD Connection Broker server automatically.  
  
## Centralized resource publishing  
In Windows Server 2008 R2, publishing and managing applications on pooled and personal virtual desktops is a time consuming and costly process. RemoteApp programs only partially integrate with the native Windows experience, so they add to the management cost because there is no way to organize published RemoteApp programs for end users.  
  
Remote Desktop Services in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] enables you to publish and manage resources \(such as RemoteApp programs, session\-based desktops, and virtual desktops\) from a centralized console. With the new publishing features in the centralized console, you can see an historic view of resources that are assigned to end users, you can change published resources for any virtual desktop collection or session collection, and you can edit the properties of published resources. Centralized resource publishing provides end users with an experience that can replace locally installed applications.  
  
In addition to publishing and managing resources from the centralized console, you can now configure a RemoteApp and Desktop connection URL by using Group Policy, and then make this URL automatically available to end users by having them enter their email address.  
  
## Rich user experience with RemoteFX  
Windows Server 2008 R2 and Windows 7 with Service Pack 1 introduced Microsoft RemoteFX, which enables the delivery of a full Windows user experience to a range of client devices including rich clients, thin clients, and ultrathin clients. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] builds on this platform to enable a richer and more seamless experience on all types of networks and all types of devices. Specifically, Remote Desktop Protocol \(RDP\) in [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] enables a consistent and seamless user experience when connecting to centralized workspaces, even on networks where bandwidth is limited and latency is high.  
  
RDP in [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] introduces new capabilities and enhances several existing capabilities that deliver a great end\-user experience. Some of the key capabilities include:  
  
-   Superior wide area network \(WAN\) performance with RemoteFX for WAN  
  
-   Full three\-dimensional \(3\-D\) and Windows Aero remoting experience with a software GPU  
  
-   Rich desktop remoting experience for all content types with RemoteFX Adaptive Graphics  
  
-   Smooth media playback experience with RemoteFX Media Streaming  
  
-   Rich client\-side device support with RemoteFX multitouch and RemoteFX USB Redirection  
  
### RemoteFX for WAN  
RDP in [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] has been optimized to work better over low bandwidth, high\-latency connections through the addition of the following features:  
  
-   **User Datagram Protocol \(UDP\) transport** RDP in [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] intelligently chooses between the TCP and UDP transports, depending on the content type and the quality of the connection. When Remote Desktop is enabled on a computer, UDP for port 3389 is automatically enabled in the Windows firewall. For enhanced performance, make sure that this port is enabled on your network.  
  
-   **RemoteFX Network Auto Detect** RemoteFX Network Auto Detect determines the amount of available bandwidth between the client and server, and then uses this information to optimize the user’s experience.  
  
RemoteFX Network Auto Detect is automatically enabled by using Remote Desktop Connection.  
  
### RemoteFX Adaptive Graphics  
RemoteFX Adaptive Graphics is a new feature in [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], and it enables a seamless delivery of virtual desktop and RemoteApp programs by using the Windows Aero and 3\-D experience across a variety of networks, including networks where bandwidth is limited and latency is high.  
  
Two of the key features that are enabled by RemoteFX Adaptive Graphics are:  
  
-   RemoteFX progressive download  
  
-   Windows Aero and 3\-D experience through Microsoft Basic Render Driver \(a software GPU\)  
  
By default, the RemoteFX graphics processing pipeline will adaptively determine the optimal RDP experience level, based on available bandwidth and server resource availability. You can change the RDP experience level by using Group Policy.  
  
### RemoteFX Media Streaming  
RemoteFX Media Streaming enables a smooth multimedia experience on networks where bandwidth is limited and latency is high. The key features in RemoteFX Media Streaming are smooth video playback that uses H.264\-encoded video streaming and audio video synchronization.  
  
RemoteFX Media Streaming requires the Desktop Experience feature.  
  
### RemoteFX multitouch  
RDP in [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] introduces true multitouch and gesture remoting with support for up to ten simultaneous touch inputs. This enables users to use the new touch and gesture\-enabled applications in Remote Desktop environments.  
  
### RemoteFX USB redirection  
RDP in [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] supports RemoteFX USB Redirection for RD Session Host. In Windows Server 2008 R2 with SP1, RemoteFX USB Redirection was only supported within virtual desktops that were using the RD Virtualization Host role service. Configuring RemoteFX USB Redirection for RD Session Host uses the same configuration steps as configuring RemoteFX USB Redirection for RD Virtualization Host. For more information about RemoteFX USB Redirection for RD Virtualization Host, see the [Configuring USB Device Redirection with Microsoft RemoteFX Step\-by\-Step Guide](http://technet.microsoft.com/library/ff817581(WS.10).aspx).  
  
The following is a list of devices that can be used with RemoteFX USB Redirection:  
  
-   All\-in\-one printer  
  
-   Scanner  
  
-   Biometric  
  
-   Webcam  
  
-   VoIP telephone and headset  
  
### RemoteFX vGPU  
RemoteFX vGPU enables an administrator to share a physical GPU on a server running Hyper\-V across multiple virtual machines. This feature enables a desktop graphics experience that is similar to that on a physical computer because applications running in a virtual machine can access GPU resources.  
  
#### Hardware requirements  
The server running Hyper\-V and the RemoteFX\-enabled virtual desktop must meet the RemoteFX hardware requirements. The requirements have not changed since the release of Windows Server 2008 R2 with SP1. They include:  
  
-   Ensure that the hyperthreading technology is enabled on the server running Hyper\-V.  
  
-   Configure the proper memory as required. Per the [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] requirements, if you are using an x86\-based virtual machine, you must configure at least 1024 megabytes \(MB\) of RAM. If you are using an x64\-based virtual machine, you must configure at least 2048 MB of RAM.  
  
-   Ensure that the builds match on the RemoteFX server, the virtual desktop, and the client computer.  
  
-   For more information about the hardware requirements for deploying RemoteFX vGPU, see [Hardware Considerations for RemoteFX](http://go.microsoft.com/fwlink/?LinkId=191918).  
  
