---
title: Deploy a Single DirectAccess Server Using the Getting Started Wizard
description: This topic is part of the guide Deploy a Single DirectAccess Server Using the Getting Started Wizard for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eb0cf464-0668-40f8-8222-feb6bae6d3d5
ms.author: lizross
author: eross-msft
---
# Deploy a Single DirectAccess Server Using the Getting Started Wizard

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic provides an introduction to the DirectAccess scenario that uses a single DirectAccess server, and allows you to deploy DirectAccess in a few easy steps.  
  
## Before you begin deploying, see the list of unsupported configurations, known issues, and prerequisites  
You can use the following topics to review prerequisites and other information before you deploy DirectAccess.  
  
-   [DirectAccess Unsupported Configurations](../../../remote-access/directaccess/DirectAccess-Unsupported-Configurations.md)  
  
-   [Prerequisites for Deploying DirectAccess](../../../remote-access/directaccess/Prerequisites-for-Deploying-DirectAccess.md)  
  
## <a name="BKMK_OVER"></a>Scenario description  
In this scenario, a single computer running either   Windows Server 2016, Windows Server 2012 R2 or Windows Server 2012,  is configured as a DirectAccess server with default settings in a few easy wizard steps, without any need to configure infrastructure settings such as a certification authority (CA) or Active Directory security groups.  
  
> [!NOTE]  
> If you want to configure an advanced deployment with custom settings, see [Deploy a Single DirectAccess Server with Advanced Settings](../../../remote-access/directaccess/single-server-advanced/../../../remote-access/directaccess/single-server-advanced/../../../remote-access/directaccess/single-server-advanced/Deploy-a-Single-DirectAccess-Server-with-Advanced-Settings.md)  
  
## In this scenario  
To set up a basic DirectAccess server, several planning and deployment steps are required.  
  
### Prerequisites  
Before you begin deploying this scenario, review this list for important requirements:  
  
-   Windows firewall must be enabled on all profiles  
  
-   This scenario is only supported when your client computers are running Windows 10, Windows 8.1 or Windows 8.  
  
-   ISATAP in the corporate network is not supported. If you are using ISATAP, you should remove it and use native IPv6.  
  
-   A Public Key Infrastructure is not required.  
  
-   Not supported for deploying two factor authentication. Domain credentials are required for authentication.  
  
-   Automatically deploys DirectAccess to all mobile computers in the current domain.  
  
-   Traffic to Internet does not go over the DirectAccess tunnel. Force tunnel configuration is not supported.  
  
-   DirectAccess server is the Network Location Server.  
  
-   Network Access Protection (NAP) is not supported.  
  
-   Changing policies outside of the DirectAccess management console or PowerShell cmdlets is not supported.  
  
-   To deploy multisite, now or in the future, first [Deploy a Single DirectAccess Server with Advanced Settings](../../../remote-access/directaccess/single-server-advanced/../../../remote-access/directaccess/single-server-advanced/../../../remote-access/directaccess/single-server-advanced/Deploy-a-Single-DirectAccess-Server-with-Advanced-Settings.md).  
  
### Planning steps  
Planning is divided into two phases:  
  
1.  Planning for the DirectAccess infrastructure. This phase describes the planning required to set up the network infrastructure before beginning the DirectAccess deployment. It includes planning the network and server topology, and the DirectAccess network location server.  
  
2.  Planning for the DirectAccess deployment. This phase describes the planning steps required to prepare for the DirectAccess deployment. It includes planning for DirectAccess client computers, server and client authentication requirements, VPN settings, infrastructure servers, and management and application servers.  
  
For detailed planning steps, see [Plan an Advanced DirectAccess Deployment](../../../remote-access/directaccess/single-server-advanced/Plan-an-Advanced-DirectAccess-Deployment.md).  
  
### Deployment steps  
Deployment is divided into three phases:  
  
1.  Configuring the DirectAccess infrastructure-This phase includes configuring network and routing, configuring firewall settings if required, configuring certificates, DNS servers, Active Directory and GPO settings, and the DirectAccess network location server.  
  
2.  Configuring DirectAccess server settings. This phase includes steps for configuring DirectAccess client computers, the DirectAccess server, infrastructure servers, management and application servers.  
  
3.  Verifying the deployment. This phase includes steps to verify that the deployment is working as required.  
  
For detailed deployment steps, see [Install and Configure Basic DirectAccess](../../../remote-access/directaccess/single-server-wizard/Install-and-Configure-Basic-DirectAccess.md).  
  
## <a name="BKMK_APP"></a>Practical applications  
Deploying a single Remote Access server provides the following:  
  
-   Ease-of-access. You can configure managed client computers running Windows 10, Windows 8.1, Windows 8, or Windows 7, as DirectAccess clients. These clients can access internal network resources via DirectAccess any time they are located on the Internet without needing to log in to a VPN connection. Client computers that are not running one of these operating systems can connect to the internal network by using traditional VPN connections.  
  
-   Ease-of-management. DirectAccess client computers located on the Internet can be remotely managed by Remote Access administrators over DirectAccess, even when the client computers are not located in the internal corporate network. Client computers that do not meet corporate requirements can be remediated automatically by management servers. Both DirectAccess and VPN are managed in the same console and with the same set of wizards. Additionally, one or more Remote Access servers can be managed from a single Remote Access Management console  
  
## <a name="BKMK_NEW"></a>Roles and features included in this scenario  
The following table lists the roles and features required for the scenario:  
  
|Role/feature|How it supports this scenario|  
|---------|-----------------|  
|Remote Access role|The role is installed and uninstalled using the Server Manager console or Windows PowerShell. This role encompasses both DirectAccess, which was previously a feature in Windows Server 2008 R2, and Routing and Remote Access Services which was previously a role service under the Network Policy and Access Services (NPAS) server role. The Remote Access role consists of two components:<br /><br />1.  DirectAccess and Routing and Remote Access Services (RRAS) VPN. DirectAccess and VPN are managed together in the Remote Access Management console.<br />2.  RRAS Routing. RRAS routing features are managed in the legacy Routing and Remote Access console.<br /><br />The Remote Access Server Role is dependent on the following server roles/features:<br /><br />-   Internet Information Services (IIS) Web Server - This feature is required to configure the network location server on the Remote Access server, and the default web probe.<br />-   Windows Internal Database. Used for local accounting on the Remote Access server.|  
|Remote Access Management Tools feature|This feature is installed as follows:<br /><br />-   It is installed by default on a Remote Access server when the Remote Access role is installed, and supports the Remote Management console user interface and Windows PowerShell cmdlets.<br />-   It can be optionally installed on a server not running the Remote Access server role. In this case it is used for remote management of a Remote Access computer running DirectAccess and VPN.<br /><br />The Remote Access Management Tools feature consists of the following:<br /><br />-   Remote Access GUI<br />-   Remote Access module for Windows PowerShell<br /><br />Dependencies include:<br /><br />-   Group Policy Management Console<br />-   RAS Connection Manager Administration Kit (CMAK)<br />-   Windows PowerShell 3.0<br />-   Graphical Management Tools and Infrastructure|  
  
## <a name="BKMK_HARD"></a>Hardware requirements  
Hardware requirements for this scenario include the following:  
  
-   Server requirements:  
  
    -   A computer that meets the hardware requirements for  Windows Server 2016,   Windows Server 2012 R2 , or  Windows Server 2012 .  
  
    -   The server must have at least one network adapter installed, enabled, and connected to the internal network. When two adapters are used, there should be one adapter connected to the internal corporate network, and one connected to the external network (Internet, or private network).  
  
    -   At least one domain controller. The Remote Access server and DirectAccess clients must be domain members.  
  
-   Client requirements:  
  
    -   A client computer must be running Windows 10, Windows 8.1 or Windows 8.  
  
        > [!IMPORTANT]  
        > If some or all of your client computers are running Windows 7, you must use the Advanced Setup Wizard. The Getting Started Setup Wizard described in this document does not support client computers that are running Windows 7. See [Deploy a Single DirectAccess Server with Advanced Settings](../../../remote-access/directaccess/single-server-advanced/../../../remote-access/directaccess/single-server-advanced/../../../remote-access/directaccess/single-server-advanced/Deploy-a-Single-DirectAccess-Server-with-Advanced-Settings.md) for instructions on how to use Windows 7 clients with DirectAccess.  
  
        > [!NOTE]  
        > Only the following operating systems can be used as DirectAccess clients: Windows 10 Enterprise, Windows 8.1 Enterprise,  Windows Server 2016,  Windows Server 2012 R2 ,  Windows Server 2012 , Windows 8 Enterprise, Windows Server 2008 R2, Windows 7 Enterprise, and Windows 7 Ultimate.  
  
-   Infrastructure and management server requirements:  
  
    -   If VPN is enabled and a static IP address pool is not configured, you must deploy a DHCP server to allocate IP addresses automatically to VPN clients.  
  
-   A DNS server running  Windows Server 2016,  Windows Server 2012 R2 ,  Windows Server 2012 , Windows Server 2008 SP2, or Windows Server 2008 R2 is required.  
  
## <a name="BKMK_SOFT"></a>Software requirements  
There are a number of requirements for this scenario:  
  
-   Server requirements:  
  
    -   The Remote Access server must be a domain member. The server can be deployed at the edge of the internal network, or behind an edge firewall or other device.  
  
    -   If the Remote Access server is located behind an edge firewall or NAT device, the device must be configured to allow traffic to and from the Remote Access server.  
  
    -   The person deploying remote access on the server requires local administrator permissions on the server, and domain user permissions. In addition, the administrator requires permissions for the GPOs used in DirectAccess deployment. To take advantage of the features that restricts DirectAccess deployment to mobile computers only, permissions to create a WMI filter on the domain controller are required.  
  
-   Remote Access client requirements:  
  
    -   DirectAccess clients must be domain members. Domains containing clients can belong to the same forest as the Remote Access server, or have a two-way trust with the Remote Access server forest.  
  
    -   An Active Directory security group is required to contain the computers that will be configured as DirectAccess clients. If a security group is not specified when configuring DirectAccess client settings, by default the client GPO is applied on all laptop computers in the Domain Computers security group. Only the following operating systems can be used as DirectAccess clients:  Windows Server 2016,  Windows Server 2012 R2 ,  Windows Server 2012 , Windows Server 2008 R2, Windows 8 Enterprise, Windows 7 Enterprise, and Windows 7 Ultimate.  
  
## <a name="BKMK_LINKS"></a>See also  
The following table provides links to additional resources.  
  
|Content type|References|  
|--------|-------|  
|**Remote Access on TechNet**|[Remote Access TechCenter](https://technet.microsoft.com/network/bb545655.aspx)|  
|**Tools and settings**|[Remote Access PowerShell cmdlets](https://technet.microsoft.com/library/hh918399.aspx)|  
|**Community resources**|[DirectAccess Wiki entries](https://go.microsoft.com/fwlink/?LinkId=236871)|  
|**Related technologies**|[How IPv6 works](https://technet.microsoft.com/library/cc781672(v=WS.10).aspx)|  
  


