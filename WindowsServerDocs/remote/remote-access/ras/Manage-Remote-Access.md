---
title: Manage Remote Access
description: This topic provides information on how to manage Remote Access in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1459819a-b1b6-4800-8770-4a85d02c7a2b
ms.author: pashort
author: shortpatti
---
# Manage Remote Access

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

The DirectAccess Remote Client Management deployment scenario uses DirectAccess to maintain clients over the Internet. This section explains the scenario, including its phases, roles, features, and links to additional resources.  
  
Windows Server 2016 and Windows Server 2012 combine DirectAccess and Routing and Remote Access Service (RRAS) VPN into a single Remote Access role.   
  
> [!NOTE]  
> In addition to this topic, the following Remote Access management topics are available.  
>   
> -   [Use Remote Access Monitoring and Accounting](monitoring-and-accounting/Use-Remote-Access-Monitoring-and-Accounting.md)  
> -   [Manage DirectAccess Clients Remotely](manage-remote-clients/Manage-DirectAccess-Clients-Remotely.md)  
  
## <a name="BKMK_OVER"></a>Scenario description  
DirectAccess client computers are connected to the intranet whenever they are connected to the Internet, regardless of whether the user has signed in to the computer. They can be managed as intranet resources and kept current with Group Policy changes, operating system updates, antimalware updates, and other organizational changes.  
  
In some cases, intranet servers or computers must initiate connections to DirectAccess clients. For example, Help Dtechnicians can use remote desktop connections to connect to and troubleshoot remote DirectAccess clients. This scenario lets you keep your existing remote access solution in place for user connectivity, while using DirectAccess for remote management.  
  
DirectAccess provides a configuration that supports remote management of DirectAccess clients. You can use a deployment wizard option that limits the creation of policies to only those needed for remote management of client computers.  
  
> [!NOTE]  
> In this deployment, user-level configuration options such as force tunneling, Network Access Protection (NAP) integration, and two-factor authentication are not available.  
  
## In this scenario  
The DirectAccess Remote Client Management deployment scenario includes the following steps for planning and configuring.  
  
### Plan the deployment  
There are only a few computer and network requirements for planning this scenario. They include:  
  
-   **Network and server topology**: With DirectAccess, you can place your Remote Access server at the edge of your intranet or behind a network address translation (NAT) device or a firewall.  
  
-   **DirectAccess network location server**: The network location server is used by DirectAccess clients to determine whether they are located on the internal network. The network location server can be installed on the DirectAccess server or on another server.  
  
-   **DirectAccess clients**: Decide which managed computers will be configured as DirectAccess clients.  
  
### Configure the deployment  
Configuring your deployment consists of a number of steps. These include:  
  
1.  **Configure the infrastructure**: Configure DNS settings, join the server and client computers to a domain if required, and configure Active Directory security groups.  
  
    In this deployment scenario, Group Policy Objects (GPOs) are created automatically by Remote Access. For advanced certificate GPO options, see [Deploying advanced Remote Access](assetId:///3475e527-541f-4a34-b940-18d481ac59f6).  
  
2.  **Configure Remote Access server and network settings**: Configure network adapters, IP addresses, and routing.  
  
3.  **Configure certificate settings**: In this deployment scenario, the Getting Started Wizard creates self-signed certificates, so there is no need to configure the more advanced certificate infrastructure.  
  
4.  **Configure the network location server**:  In this scenario, the network location server is installed on the Remote Access server.  
  
5.  **Plan DirectAccess management servers**: Administrators can remotely manage DirectAccess client computers that are located outside the corporate network by using the Internet. Management servers include computers  that are used during remote client management (such as update servers).  
  
6.  **Configure the Remote Access server**: Install the Remote Access role and run the DirectAccess Getting Started Wizard to configure DirectAccess.  
  
7.  **Verify the deployment**: Test a client to make sure it is able to connect to the internal network and the Internet by using DirectAccess.  
  
## <a name="BKMK_APP"></a>Practical applications  
Deploying a single Remote Access server for managing DirectAccess clients provides the following:  
  
-   **Ease-of-access**: Managed client computers running Windows 8 or Windows 7 can be configured as DirectAccess client computers. These clients can access internal network resources through DirectAccess any time they are connected to the Internet without needing to sign in to a VPN connection. Client computers not running one of these operating systems can connect to the internal network through VPN. DirectAccess and VPN are managed in the same console and with the same set of wizards.  
  
-   **Ease-of-management**: DirectAccess client computers that are connected to the Internet can be remotely managed by remote access administrators by using DirectAccess, even when the client computers are not located in the internal corporate network. Client computers that do not meet corporate requirements can be remediated automatically by management servers. One or more Remote Access servers can be managed from a single Remote Access Management console.  
  
## <a name="BKMK_NEW"></a>Roles and features included in this scenario  
The following table lists the roles and features required for the scenario:  
  
|Role or feature|How it supports this scenario|  
|----------|-----------------|  
|*Remote Access role*|This role is installed and uninstalled by using the Server Manager console or Windows PowerShell. This role encompasses DirectAccess, which was previously a feature in Windows Server 2008 R2, and Routing and Remote Access Services, which was previously a role service under the Network Policy and Access Services (NPAS) server role. The Remote Access role consists of two components:<br /><br />1.  DirectAccess and Routing and Remote Access Services (RRAS) VPN: DirectAccess and VPN are managed in the Remote Access Management console.<br />2.  RRAS: Features are managed in the Routing and Remote Access console.<br /><br />The Remote Access server role is dependent on the following features:<br /><br />-   Web Server (IIS): Required to configure the network location server and default web probe.<br />-   Windows internal database: Used for local accounting on the Remote Access server.|  
|Remote Access Management Tools feature|This feature is installed as follows:<br /><br />-   By default on a Remote Access server when the Remote Access role is installed and supports the Remote Management console user interface.<br />-   As an option on a server that is not running the Remote Access server role. In this case, it is used for remote management of a Remote Access server.<br /><br />This feature consists of the following:<br /><br />-   Remote Access GUI and command-line tools<br />-   Remote Access module for Windows PowerShell<br /><br />Dependencies include:<br /><br />-   Group Policy Management Console<br />-   RAS Connection Manager Administration Kit (CMAK)<br />-   Windows PowerShell 3.0<br />-   Graphical Management Tools and Infrastructure|  
  
## <a name="BKMK_HARD"></a>Hardware requirements  
Hardware requirements for this scenario include the following:  
  
### Server requirements  
  
-   A computer that meets the hardware requirements for  Windows Server 2016. For more information, see Windows Server 2016 [System Requirements](https://technet.microsoft.com/windows-server-docs/get-started/system-requirements-and-installation).  
  
-   The server must have at least one network adapter installed and enabled. There should be only one adapter connected to the corporate internal network, and only one connected to the external network (Internet).  
  
-   If Teredo is required as an IPv6 to IPv4 transition protocol, the external adapter of the server requires two consecutive public IPv4 addresses. If a single network adapter is available, only IP-HTTPS can be used as the transition protocol.  
  
-   At least one domain controller. The Remote Access servers and DirectAccess clients must be domain members.  
  
-   A certification authority is required on the server if you do not want to use self-signed certificates for IP-HTTPS or the network location server, or if you want to use client certificates for client IPsec authentication.  
  
### Client requirements  
  
-   A client computer must be running Windows 10 or Windows 8 or Windows 7.  
  
### Infrastructure and management server requirements  
  
-   During remote management of DirectAccess client computers, clients initiate communications with management servers, such as domain controllers, System Center Configuration Servers, and Health Registration Authority (HRA) servers. These servers provide services that include Windows and antivirus updates and Network Access Protection (NAP) client compliance. You should deploy the required servers before you begin the Remote Access deployment.  
  
-   A DNS server running  Windows Server 2016,  Windows Server 2012 R2 ,  Windows Server 2012 , Windows Server 2008 R2, or Windows Server 2008 with SP2 is required.  
  
## <a name="BKMK_SOFT"></a>Software requirements  
Software requirements for this scenario include the following:  
  
### Server requirements  
  
-   The Remote Access server must be a domain member. The server can be deployed at the edge of the internal network, or behind an edge firewall or other device.  
  
-   If the Remote Access server is located behind an edge firewall or NAT device, the device must be configured to allow traffic to and from the Remote Access server.  
  
-   Admins who deploy a Remote Access server require local administrator permissions on the server and domain user permissions. In addition, the administrator requires permissions for the GPOs that are used for DirectAccess deployment. To take advantage of the features that restrict DirectAccess deployment to only mobile computers, Domain Admin permissions are required  on the domain controller to create a WMI filter.  
  
-   If the network location server is not located on the Remote Access server, a separate server to run it is required.  
  
### Remote access client requirements  
  
-   DirectAccess clients must be domain members. Domains that contain clients can belong to the same forest as the Remote Access server, or they can have a two-way trust with the Remote Access server forest or domain.  
  
-   An Active Directory security group is required to contain the computers that will be configured as DirectAccess clients. Computers should not be included in more than one security group that includes DirectAccess clients. If clients are included in multiple groups, name resolution for client requests will not work as expected.  
  

