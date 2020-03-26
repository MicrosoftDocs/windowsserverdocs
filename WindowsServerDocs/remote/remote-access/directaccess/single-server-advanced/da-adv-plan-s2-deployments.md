---
title: Step 2 Plan Advanced DirectAccess Deployments
description: This topic is part of the guide Deploy a Single DirectAccess Server with Advanced Settings for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3bba28d4-23e2-449f-8319-7d2190f68d56
ms.author: lizross
author: eross-msft
---
# Step 2 Plan Advanced DirectAccess Deployments

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

After you plan the DirectAccess infrastructure, the next step in deploying advanced DirectAccess on a single server with IPv4 and IPv6 is to plan the settings for the Remote Access Setup Wizard.  
  
|Task|Description|  
|----|--------|  
|[2.1 Plan for client deployment](#21-plan-for-client-deployment)|Plan how to allow client computers to connect by using DirectAccess. Decide which managed computers will be configured as DirectAccess clients, and plan to deploy the Network Connectivity Assistant or DirectAccess Connectivity Assistant on client computers.|  
|[2.2 Plan for DirectAccess server deployment](#22-plan-for-directaccess-server-deployment)|Plan how to deploy the DirectAccess server.|  
|[2.3 Plan infrastructure servers](#23-plan-infrastructure-servers)|Plan the infrastructure servers for your DirectAccess deployment, including the DirectAccess network location server, Domain Name System (DNS) servers, and DirectAccess management servers.|  
|[2.4 Plan application servers](#24-plan-application-servers)|Plan for IPv4 and IPv6 application servers, and optionally consider whether end-to-end authentication between DirectAccess client computers and internal application servers is required.|  
|[2.5 Plan DirectAccess and third-party VPN clients](#25-plan-directaccess-and-third-party-vpn-clients)|When deploying DirectAccess with third-party VPN clients, it might be necessary to set a registry value to enable a seamless coexistence of the two remote access solutions.|  
  
## 2.1 Plan for client deployment  
There are three decisions to make when you are planning your client deployment:  
  
1.  Will DirectAccess be available to mobile computers only, or to any computer?  
  
    When you configure DirectAccess clients in the DirectAccess Client Setup Wizard, you can choose to allow only mobile computers in the specified security groups to connect by using DirectAccess. If you restrict access to mobile computers, Remote Access automatically configures a WMI filter to ensure that the DirectAccess client GPO is applied only to mobile computers in the specified security groups. The Remote Access administrator requires Create or Modify security permissions to create or modify Group Policy Object (GPO) WMI filters to enable this setting.  
  
2.  What security groups will contain the DirectAccess client computers?  
  
    DirectAccess client settings are contained in the DirectAccess client GPO. The GPO is applied to computers that are part of the security groups that you specify in the DirectAccess Client Setup Wizard. You can specify that security groups be contained in any supported domain. For more information, see section [1.7 Plan Active Directory Domain Services](da-adv-plan-s1-infrastructure.md#17-plan-active-directory-domain-services).  
  
    Before you configure DirectAccess, you should create the security groups. You can add computers to the security group after you complete the DirectAccess deployment, but if you add client computers that reside in a different domain than the security group, the client GPO will not be applied to those clients. For example, if you created SG1 in domain A for DirectAccess clients, and later add clients from domain B to this group, the client GPO will not be applied to clients from domain B. To avoid this issue, create a new client security group for each domain that contains DirectAccess client computers. Alternatively, if you do not want to create a new security group, run the Windows PowerShell cmdlet **Add-DAClient** with the name of the new GPO for the new domain.  
  
3.  What settings will you configure for the network connectivity assistant?  
  
    The network connectivity assistant runs on client computers, and it provides additional information about the DirectAccess connection to end users. In the DirectAccess Client Setup Wizard, you can configure the following:  
  
    -   **Connectivity verifiers**  
  
        A default web probe is created that clients use to validate connectivity to the internal network. The default name is:  
  
        https://directaccess-WebProbeHost.<domain_name>  
  
        The name should be registered manually in DNS. You can create other connectivity verifiers by using other web addresses over HTTP or **ping**. For each connectivity verifier, a DNS entry must exist.  
  
    -   **A Help Desk email address**  
  
        If end users experience DirectAccess connectivity issues, they can send an email that contains diagnostic information to the DirectAccess administrator to troubleshoot the issue.  
  
    -   **A DirectAccess connection name**  
  
        Specify a DirectAccess connection name to help end users identify the DirectAccess connection on their computer.  
  
    -   **Allow DirectAccess clients to use local name resolution**  
  
        Clients require a way to resolve names locally. If you allow DirectAccess clients to use local name resolution, end users can use local DNS servers to resolve names. When end users select to use local DNS servers for name resolutions, DirectAccess does not send resolution requests for single label names to the internal corporate DNS server. It uses local name resolution instead (by using the Link-Local Multicast Name Resolution (LLMNR) and NetBIOS over TCP/IP protocols).  
  
## 2.2 Plan for DirectAccess server deployment  
Consider the following decisions when you are planning to deploy your DirectAccess server:  
  
-   **Network topology**  
  
    There are a couple of topologies available when deploying a DirectAccess server:  
  
    -   **Two network adapters**. With two network adapters, DirectAccess can be configured with one network adapter connected directly to the Internet, and the other connected to the internal network. Alternately, the server is installed behind an edge device such as a firewall or a router. In this configuration, one network adapter is connected to the perimeter network, and the other is connected to the internal network.  
  
    -   **One network adapter**. In this configuration, the DirectAccess server is installed behind an edge device such as a firewall or a router. The network adapter is connected to the internal network.  
  
    For more information about selecting the topology for your deployment, see [1.1 Plan network topology and settings](da-adv-plan-s1-infrastructure.md#11-plan-network-topology-and-settings).  
  
-   **ConnectTo address**  
  
    Client computers use the ConnectTo address to connect to the DirectAccess server. The address that you choose must match the subject name of the IP-HTTPS certificate that you deploy for the IP-HTTPS connection, and it must be available in the public DNS.  
  
-   **Network adapters**  
  
    The Remote Access Server Setup Wizard automatically detects the network adapters that are configured on the DirectAccess server. You must make sure that the correct adapters are selected.  
  
-   **IP-HTTPS certificate**  
  
    The Remote Access Server Setup Wizard automatically detects a certificate that is suitable for the IP-HTTPS connection. The subject name of the certificate that you select must match the ConnectTo address. If you are using self-signed certificates, you can select to use a certificate that is created automatically by the Remote Access server.  
  
-   **IPv6 prefixes**  
  
    If the Remote Access Server Setup Wizard detects that IPv6 has been deployed on the network adapters, it automatically populates IPv6 prefixes for the internal network, an IPv6 prefix to assign to DirectAccess client computers, and an IPv6 prefix to assign to VPN client computers. If the automatically generated prefixes are not correct for your native IPv6 infrastructure, you must manually change them. For more information, see [1.1 Plan network topology and settings](da-adv-plan-s1-infrastructure.md#11-plan-network-topology-and-settings).  
  
-   **Authentication**  
  
    Decide how DirectAccess clients will authenticate to the DirectAccess server:  
  
    -   **User authentication**. You can enable users to authenticate with Active Directory credentials or with two-factor authentication. For more information about authenticating with two-factor authentication, see [Deploy Remote Access with OTP authentication](https://technet.microsoft.com/library/hh831379.aspx).  
  
    -   **Computer authentication**. You can configure computer authentication to use certificates or to use the DirectAccess server as a Kerberos proxy on behalf of the client. For more information, see [1.3 Plan certificate requirements](da-adv-plan-s1-infrastructure.md#13-plan-certificate-requirements).  
  
    -   **Windows 7 clients**. By default, client computers that are running  Windows 7 cannot connect to a  Windows Server 2012 R2 or  Windows Server 2012 DirectAccess deployment. If you have clients in your organization that are running  Windows 7, and they require remote access to internal resources, you can allow them to connect. Any client computers that you want to allow to access internal resources must be a member of a security group that you specify in the DirectAccess Client Setup Wizard.  
  
        > [!NOTE]  
        > Allowing clients running Windows 7 to connect by using DirectAccess requires that you use computer certificate authentication.  
  
-   **VPN configuration**  
  
    Before you configure DirectAccess, decide whether you are going to provide VPN access to non-DirectAccess capable remote clients. You should provide VPN access if you have client computers in your organization that do not support DirectAccess connectivity (because they are unmanaged or because they run an operating system for which DirectAccess is not supported). The Remote Access Server Setup Wizard allows you to configure how IP addresses are assigned (by using DHCP or from a static address pool) and how VPN clients are authenticated - by using Active Directory or a Remote Authentication Dial-Up Service (RADIUS) server.  
  
## 2.3 Plan infrastructure servers  
DirectAccess requires three types of infrastructure servers:  
  
-   **DNS servers**. For more information, see [1.4 Plan DNS requirements](da-adv-plan-s1-infrastructure.md#14-plan-dns-requirements)  
  
-   **Network location server**. For more information, see [1.5 Plan the network location server](da-adv-plan-s1-infrastructure.md#15-plan-the-network-location-server)  
  
-   **Management servers**. For more information, see [1.6 Plan management servers](da-adv-plan-s1-infrastructure.md#16-plan-management-servers)  
  
## 2.4 Plan application servers  
Application servers are the servers on the corporate network that are accessible by client computers over a DirectAccess connection. Application servers are identified by adding them into a security group. The application server GPO is then applied to servers in that group.  
  
> [!NOTE]  
> Adding the application servers to a security group is required only if you require end-to-end authentication and encryption.  
  
You can optionally require end-to-end authentication and encryption between DirectAccess client and selected internal application servers. If you configure end-to-end authentication, DirectAccess clients use an IPsec transport policy. This policy requires that the authentication and traffic protection of IPsec sessions is terminated at the specified application servers. In this case, the Remote Access server forwards the authenticated and protected IPsec sessions to the application servers.  
  
By default, when you extend authentication to application servers, the data payload is encrypted between the DirectAccess client and the application server. You can choose to not encrypt traffic, and use authentication only. However, this is less secure than using authentication and encryption, and it is supported only for application servers running the  Windows Server 2008 R2 , or  Windows Server 2012  operating systems.  
  
## 2.5 Plan DirectAccess and third-party VPN clients  
Some third-party VPN clients do not create connections in the Network Connections folder. This can cause DirectAccess to determine that it has no intranet connectivity when the VPN connection is established and connectivity to the intranet exists. This occurs when third-party VPN clients register their interfaces by defining them as Network Device Interface Specification (NDIS) endpoint types. You can enable coexistence with these types of VPN clients by setting the following registry value to 1 on DirectAccess clients:  
  
**HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\NlaSvc\Parameters\ShowDomainEndpointInterfaces (REG_DWORD)**  
  
Some third-party VPN clients use a split-tunneling configuration, which allows the VPN client computer to access the Internet directly, without the need to send the traffic through the VPN connection to the intranet.  
  
Split-tunnel configurations typically leave the default gateway setting on the VPN client as not configured or as all zeros (0.0.0.0). You can confirm this by establishing a successful VPN connection to your intranet and using the Ipconfig.exe command line tool to view the resulting configuration.  
  
If the VPN connection lists its default gateway as empty or all zeros (0.0.0.0), your VPN client is configured in this way. By default, the DirectAccess client does not identify split-tunnelf configurations. To configure DirectAccess clients to detect these types of VPN client configurations and coexist with them, set the following registry value to 1:  
  
**HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\NlaSvc\Parameters\Internet\ EnableNoGatewayLocationDetection (REG_DWORD)**  
  
## Previous step  
  
-   [Step 1: Plan the DirectAccess Infrastructure](da-adv-plan-s1-infrastructure.md)  
  


