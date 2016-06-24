---
title: Add DirectAccess to an Existing Remote Access (VPN) Deployment
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b5db01f7-1ae0-46f2-9be7-8d9e121446b2
author: coreyp
---
# Add DirectAccess to an Existing Remote Access (VPN) Deployment
  
## <a name="BKMK_OVER"></a>Scenario description  
In this scenario, a single computer running Windows Server® 2016 Technical Preview, Windows Server® 2012 R2 or Windows Server® 2012 is configured as a DirectAccess server with recommended settings after you have already installed and configured VPN. If you want to configure DirectAccess with enterprise features, such as a load-balanced cluster, multisite deployment, or two-factor client authentication, complete the scenario described in this topic to set up a single server, and then set up the enterprise scenario as described in [Deploy Remote Access in an enterprise](assetId:///77ce3214-c029-4c4b-8f09-78bec490716e).  
  
## In this scenario  
To set up a single Remote Access server, a number of planning and deployment steps are required.  
  
### Planning steps  
Planning is divided into two phases:  
  
1.  **Plan the Remote Access infrastructure**  
  
    In this phase, you describe the planning that is required to set up the network infrastructure before you begin the Remote Access deployment. It includes planning for the network and server topology, certificates, Domain Name System (DNS), Active Directory and Group Policy Object (GPO) configuration, and the DirectAccess network location server.  
  
2.  **Plan the Remote Access deployment**  
  
    In this phase, you describe the planning steps that are required to prepare for the Remote Access deployment. It includes planning for Remote Access client computers, server and client authentication requirements, and infrastructure servers.  
  
### Deployment steps  
Deployment is divided into three phases:  
  
1.  **Configure the Remote Access infrastructure**  
  
    In this phase, you configure the network and routing, firewall settings (if required), certificates, DNS servers, Active Directory and GPO settings, and the DirectAccess network location server.  
  
2.  **Configure Remote Access server settings**  
  
    In this phase, you configure the Remote Access client computers, the Remote Access server, and the infrastructure servers.  
  
3.  **Verify the deployment**  
  
    In this phase, you verify that the deployment is working as required.  
  
## <a name="BKMK_APP"></a>Practical applications  
Deploying a single Remote Access server provides the following:  
  
-   **Ease of access**  
  
    Managed client computers running Windows 8 and Windows 7 can be configured as DirectAccess client computers. These clients can access internal network resources through DirectAccess any time they are located on the Internet, without the need to sign in to a VPN connection. Client computers that are not running one of these operating systems can connect to the internal network through a VPN. DirectAccess and VPN are managed in the same console and with the same set of wizards.  
  
-   **Ease of management**  
  
    DirectAccess client computers that have access to the Internet can be remotely managed by remote access administrators by using DirectAccess, even when the client computers are not located on the internal corporate network. Client computers that do not meet corporate requirements can be remediated automatically by management servers.  
  
## <a name="BKMK_NEW"></a>Roles and features required for this scenario  
The following table lists the roles and features that are required for this scenario:  
  
|Role/feature|How it supports this scenario|  
|-----------------|---------------------------------|  
|Remote Access role|The role is installed and uninstalled by using the Server Manager console or Windows PowerShell. This role encompasses DirectAccess, which was previously a feature in Windows Server 2008 R2, and Routing and Remote Access Services, which was previously a role service under the Network Policy and Access Services (NPAS) server role. The Remote Access role consists of two components:<br /><br />1.  DirectAccess and Routing and Remote Access Services (RRAS) VPN: Managed in the Remote Access Management console.<br />2.  RRAS Routing: Managed in the Routing and Remote Access console.<br /><br />The Remote Access Server role is dependent on the following server features:<br /><br />-   Internet Information Services (IIS) Web Server:Required to configure the network location server on the Remote Access server, and the default web probe.<br />-   Windows Internal Database: Used for local accounting on the Remote Access server.|  
|Remote Access Management Tools feature|This feature is installed as follows:<br /><br />-   By default on a Remote Access server when the Remote Access role is installed. Supports the Remote Management console user interface and the Windows PowerShell cmdlets.<br />-   Optionally installed on a server not running the Remote Access server role. In this case, it is used for remote management of a Remote Access computer running DirectAccess and VPN.<br /><br />The Remote Access Management Tools feature consists of the following:<br /><br />-   Remote Access GUI<br />-   Remote Access module for Windows PowerShell<br /><br />Dependencies include:<br /><br />-   Group Policy Management Console<br />-   RAS Connection Manager Administration Kit (CMAK)<br />-   Windows PowerShell 3.0<br />-   Graphical Management Tools and Infrastructure|  
  
## <a name="BKMK_HARD"></a>Hardware requirements  
Hardware requirements for this scenario include the following:  
  
**Server requirements**  
  
-   A computer that meets the hardware requirements for  Windows Server 2012 .  
  
-   The server must have at least one network adapter installed, enabled, and joined to the internal network. When two adapters are used, there should be one adapter connected to the internal corporate network, and one connected to the external network (Internet).  
  
-   If Teredo is required as an IPv4 to IPv6 transition protocol, the external adapter of the server requires two consecutive public IPv4 addresses. The Enable DirectAccess Wizard does not enable Teredo, even if two consecutive IP addresses are present. To enable Teredo, see [Deploying Advanced Remote Access](assetId:///3475e527-541f-4a34-b940-18d481ac59f6). If a single IP address is available, only IP-HTTPS can be used as the transition protocol.  
  
-   At least one domain controller. The Remote Access server and DirectAccess clients must be domain members.  
  
-   The Enable DirectAccess Wizard requires certificates for IP-HTTPS and the network location server. If the SSTP VPN is already using a certificate, it is reused for IP-HTTPS. If the SSTP VPN is not configured, you can configure a certificate for IP-HTTPS or use an automatically created self-signed certificate. For the network location server, you can configure a certificate or use an automatically created self-signed certificate.  
  
**Client requirements**  
  
-   A client computer must be running Windows 8 or Windows 7.  
  
    > [!NOTE]  
    > Only the following operating systems can be used as DirectAccess clients:  Windows Server 2012 ,  Windows Server 2008 R2 , Windows 8 Enterprise, Windows 7 Enterprise, and Windows 7 Ultimate.  
  
**Infrastructure and management server requirements**  
  
-   During the remote management of DirectAccess client computers, clients initiate communication with management servers, such as domain controllers, System Center configuration servers, and Health Registration Authority (HRA) servers for services that include Windows and antivirus updates and Network Access Protection (NAP) client compliance. The required servers should be deployed before you begin the Remote Access deployment.  
  
-   If remote access requires client NAP compliance, the Network Policy Server (NPS) and the HRA should be deployed before you begin the Remote Access deployment.  
  
-   A DNS server running  Windows Server 2012 , Windows Server 2008 R2, or Windows Server 2008 with SP2 is required.  
  
## <a name="BKMK_SOFT"></a>Software requirements  
Software requirements for this scenario include the following:  
  
**Server requirements**  
  
-   The Remote Access server must be a domain member. The server can be deployed at the edge of the internal network, or behind an edge firewall or other device.  
  
-   If the Remote Access server is located behind an edge firewall or network address translation (NAT) device, the device must be configured to allow traffic to and from the Remote Access server.  
  
-   The person who deploys remote access on the server requires local administrator permissions on the server, and domain user permissions. In addition, the administrator requires permissions for the GPOs that are used in DirectAccess deployment. To take advantage of the features that restrict a DirectAccess deployment to mobile computers only, permissions to create a WMI filter on the domain controller are required.  
  
**Remote access client requirements**  
  
-   DirectAccess clients must be domain members. Domains that contain clients can belong to the same forest as the Remote Access server, or they can have a two-way trust with the Remote Access server forest or domain.  
  
-   An Active Directory security group is required to contain the computers that will be configured as DirectAccess clients. If a security group is not specified when you configure DirectAccess client settings, by default, the client GPO is applied on all laptop computers (that are DirectAccess capable) in the Domain Computers security group. Only the following operating systems can be used as DirectAccess clients:  Windows Server 2012 ,  Windows Server 2008 R2 , Windows 8 Enterprise, Windows 7 Enterprise, and Windows 7 Ultimate.  
  
    > [!NOTE]  
    > We recommend that you create a security group for each domain that contains computers that will be configured as DirectAccess clients.  
  
## <a name="BKMK_LINKS"></a>See also  
The following table provides links to additional resources.  
  
|Content type|References|  
|----------------|--------------|  
|**Remote Access on TechNet**|[Remote Access TechCenter](http://technet.microsoft.com/en-us/network/bb530961.aspx)|  
|**Product evaluation**|[Demonstrate DirectAccess in a cluster with NLB](http://technet.microsoft.com/en-us/library/hh831830.aspx)<br /><br />[Demonstrate a DirectAccess multisite deployment](http://technet.microsoft.com/en-us/library/hh831461.aspx)<br /><br />[Demonstrate a DirectAccess multisite deployment](http://technet.microsoft.com/en-us/library/hh831461.aspx)|  
|**Deployment**|[Remote Access](http://technet.microsoft.com/en-us/library/hh831416.aspx)|  
|**Tools and settings**|[Remote Access PowerShell cmdlets](http://technet.microsoft.com/library/hh918399.aspx)|  
|**Community resources**|-   [RRAS Product Team blog](http://blogs.technet.com/RRAS/)<br />-   [DirectAccess Wiki entries](http://go.microsoft.com/fwlink/?LinkId=236871)|  
|**Related technologies**|[How IPv6 works](http://technet.microsoft.com/en-us/library/cc781672(v=WS.10).aspx)|  
  

