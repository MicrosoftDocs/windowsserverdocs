---
title: Manage DirectAccess Clients Remotely_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d7993da0-0bbd-4d67-9529-de72f53e8550
---
# Manage DirectAccess Clients Remotely_1
[!INCLUDE[remote_access_combo](../Token/remote_access_combo_md.md)]  
  
This topic provides an introduction to an advanced scenario that you can use to set up a single Remote Access server for remote management of DirectAccess clients.  
  
## <a name="BKMK_OVER"></a>Scenario description  
In this scenario, a single computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is configured as a Remote Access server with the only purpose of remotely managing DirectAccess clients. Using this scenario enables the remote management of clients, but it disables other components that you can use if you select a full DirectAccess deployment, including client access to internal networks, force tunneling, strong authentication, and NAP compliance.  
  
> [!NOTE]  
> If you want to configure a basic deployment with simple settings only, see [Deploy a Single DirectAccess Server Using the Getting Started Wizard](../Topic/Deploy-a-Single-DirectAccess-Server-Using-the-Getting-Started-Wizard.md). In the simple scenario, you can set up Remote Access with default settings by using a wizard. You do not configure infrastructure settings, such as a certification authority \(CA\) or Active Directory security groups.  
  
## In this scenario  
To set up a single Remote Access server to manage clients, a number of planning and deployment steps are required.  
  
### Planning steps  
Planning for this scenario is divided into two phases:  
  
1.  Plan the Remote Access infrastructure: In this phase, you plan the network infrastructure before you begin the Remote Access deployment. It includes planning for the network and server topology, certificates, Domain Name System \(DNS\), Active Directory, Group Policy Objects \(GPOs\), and the DirectAccess network location server.  
  
2.  **Plan the Remote Access deployment**: In this phase, you prepare for the Remote Access deployment. It includes planning for Remote Access client computers, server and client authentication requirements, VPN settings, infrastructure, and management servers.  
  
For detailed planning steps, see [Plan Deployment for Remote Management of DirectAccess Clients_1](../Topic/Plan-Deployment-for-Remote-Management-of-DirectAccess-Clients_1.md).  
  
### Prerequisites  
Before you begin this scenario, review this list for important requirements:  
  
-   Windows firewall must be enabled on all profiles.  
  
-   DirectAccess supports only clients running Windows 8.1, Windows 8, and Windows 7.  
  
-   Changing policies outside of the DirectAccess management console or by using Windows PowerShell cmdlets is not supported.  
  
### Deployment steps  
Deployment for this scenario is divided into three phases:  
  
1.  **Configure the Remote Access infrastructure**: In this phase, you configure network and routing, firewall settings if required, certificates, DNS servers, Active Directory and GPO settings, and the DirectAccess network location server.  
  
2.  **Configure Remote Access server settings**: In this phase, you configure Remote Access client computers, the Remote Access server, infrastructure servers, and management and application servers.  
  
3.  **Verify the deployment**: In this phase, you verify that the deployment is working as required.  
  
For detailed deployment steps, see [Install and Configure Deployment for Remote Management of DirectAccess Clients_1](../Topic/Install-and-Configure-Deployment-for-Remote-Management-of-DirectAccess-Clients_1.md).  
  
## <a name="BKMK_APP"></a>Practical applications  
Deploying a single Remote Access server for managing DirectAccess clients provides the following benefits:  
  
-   **Ease\-of\-access**: Managed client computers running Windows 8.1, [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], or Windows 7 can be configured as DirectAccess client computers. These clients can access internal network resources through DirectAccess any time they are connected to the Internet, without the need to sign in to a VPN connection. Client computers that are not running one of these operating systems can connect to the internal network through a VPN. DirectAccess and VPN are managed in the same console and with the same set of wizards.  
  
-   **Ease\-of\-management**: DirectAccess client computers that are connected to the Internet can be remotely managed by remote access administrators through DirectAccess, even when the client computers are not located on the internal corporate network. Client computers that do not meet corporate requirements can be remediated automatically by using management servers.  
  
## <a name="BKMK_NEW"></a>Roles and features included in this scenario  
The following table lists the roles and features that are required to plan and deploy this scenario.  
  
|Role\/feature|How it supports this scenario|  
|-----------------|---------------------------------|  
|*Remote Access role*|The role is installed and uninstalled using the Server Manager console or Windows PowerShell. This role encompasses both DirectAccess, which was previously a feature in Windows Server 2008 R2, and Routing and Remote Access Services which was previously a role service under the Network Policy and Access Services \(NPAS\) server role. The Remote Access role consists of two components:<br /><br />1.  DirectAccess and Routing and Remote Access Services \(RRAS\) VPN—DirectAccess and VPN are managed together in the Remote Access Management console.<br />2.  RRAS Routing—RRAS routing features are managed in the legacy Routing and Remote Access console.<br /><br />The Remote Access Server Role is dependent on the following server roles\\features:<br /><br />-   Internet Information Services \(IIS\) Web Server – This feature is required to configure the network location server on the Remote Access server, and the default web probe.<br />-   Windows Internal Database—Used for local accounting on the Remote Access server.|  
|Remote Access Management Tools feature|This feature is installed as follows:<br /><br />-   It is installed by default on a Remote Access server when the Remote Access role is installed, and supports the Remote Management console user interface and the Windows PowerShell cmdlets.<br />-   It can be optionally installed on a server not running the Remote Access server role. In this case it is used for remote management of a Remote Access computer running DirectAccess and VPN.<br /><br />The Remote Access Management Tools feature consists of the following:<br /><br />-   Remote Access GUI<br />-   Remote Access module for Windows PowerShell<br /><br />Dependencies include:<br /><br />-   Group Policy Management Console<br />-   RAS Connection Manager Administration Kit \(CMAK\)<br />-   Windows PowerShell 3.0<br />-   Graphical Management Tools and Infrastructure|  
  
## <a name="BKMK_HARD"></a>Hardware requirements  
Hardware requirements for this scenario include the following:  
  
-   Server requirements:  
  
    -   A computer that meets the hardware requirements for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
    -   The server must have at least one network adapter installed and enabled. When two adapters are used, there should be one adapter connected to the internal corporate network, and one connected to the external network \(Internet\).  
  
    -   If Teredo is required as an IPv4 to IPv6 transition protocol, the external adapter of the server requires two consecutive public IPv4 addresses. If a single IP address is available, then only IP\-HTTPS can be used as the transition protocol.  
  
    -   At least one domain controller. The Remote Access server and DirectAccess clients must be domain members.  
  
    -   A CA server is required if you do not want to use self\-signed certificates for IP\-HTTPS or the network location server, or if you want to use client certificates for client IPsec authentication. Alternatively, you can request certificates from a public CA.  
  
    -   If the network location server is not located on the Remote Access server, a separate web server to run it is required.  
  
-   Client requirements:  
  
    -   A client computer must be running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] or [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)].  
  
        > [!NOTE]  
        > Only the following operating systems can be used as DirectAccess clients: [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], Windows 8 Enterprise, [!INCLUDE[nextref_client_7ent](../Token/nextref_client_7ent_md.md)], and [!INCLUDE[nextref_client_7ult](../Token/nextref_client_7ult_md.md)].  
  
-   Infrastructure and management server requirements:  
  
    -   During remote management of DirectAccess client computers, clients initiate communications with management servers such as domain controllers and System Center Configuration Servers, for services that include Windows and antivirus updates and Network Access Protection \(NAP\) client compliance. The required servers should be deployed before beginning the Remote Access deployment.  
  
    -   If remote access requires client NAP compliance, NPS and HRS servers should be deployed before beginning remote access deployment  
  
    -   If VPN is enabled, a DHCP server is required to allocate IP addresses automatically to VPN clients, if a static address pool is not used.  
  
    -   A DNS server running Windows Server 2008 SP2; Windows Server 2008 R2; or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is required.  
  
## <a name="BKMK_SOFT"></a>Software requirements  
There are a number of requirements for this scenario:  
  
-   Server requirements:  
  
    -   The Remote Access server must be a domain member. The server can be deployed at the edge of the internal network, or behind an edge firewall or other device.  
  
    -   If the Remote Access server is located behind an edge firewall or NAT device, the device must be configured to allow traffic to and from the Remote Access server.  
  
    -   The person deploying remote access on the server requires local administrator permissions on the server, and domain user permissions. In addition, the administrator requires permissions for the GPOs used in DirectAccess deployment. To take advantage of the features that restricts DirectAccess deployment to mobile computers only, permissions to create a WMI filter on the domain controller are required.  
  
-   Remote access client requirements:  
  
    -   DirectAccess clients must be domain members. Domains containing clients can belong to the same forest as the Remote Access server, or have a two\-way trust with the Remote Access server forest or domain.  
  
    -   An Active Directory security group is required to contain the computers that will be configured as DirectAccess clients. If a security group is not specified when configuring DirectAccess client settings, by default the client GPO is applied on all laptop computers in the Domain Computers security group. Note the following:  
  
        We  recommend that you create a security group for each domain that contains computers that will be configured as DirectAccess clients.  
  
## <a name="BKMK_LINKS"></a>See also  
The following table provides links to additional resources.  
  
|Content type|References|  
|----------------|--------------|  
|**Remote Access on TechNet**|[Remote Access TechCenter](http://technet.microsoft.com/network/bb545655.aspx)|  
|**Product evaluation**|[Test Lab Guide: Demonstrate DirectAccess in a Cluster with Windows NLB](../Topic/Test-Lab-Guide--Demonstrate-DirectAccess-in-a-Cluster-with-Windows-NLB.md)<br /><br />[Test Lab Guide: Demonstrate a DirectAccess Multisite Deployment](../Topic/Test-Lab-Guide--Demonstrate-a-DirectAccess-Multisite-Deployment.md)<br /><br />[Test Lab Guide: Demonstrate DirectAccess with OTP Authentication and RSA SecurID](../Topic/Test-Lab-Guide--Demonstrate-DirectAccess-with-OTP-Authentication-and-RSA-SecurID.md)|  
|**Troubleshooting**|Troubleshooting Remote Access documentation, when available.|  
|**Tools and settings**|[Remote Access PowerShell cmdlets](http://technet.microsoft.com/library/hh918399.aspx)|  
|**Community resources**|[RRAS Product Team blog](http://blogs.technet.com/RRAS/) &#124; [Remote Access  TechNet Forum](http://social.technet.microsoft.com/Forums/RRAS/threads)<br /><br />[DirectAccess Wiki entries](http://go.microsoft.com/fwlink/?LinkId=236871)|  
|**Related technologies**|[How IPv6 works](http://technet.microsoft.com/library/cc781672(v=WS.10).aspx)|  
  
