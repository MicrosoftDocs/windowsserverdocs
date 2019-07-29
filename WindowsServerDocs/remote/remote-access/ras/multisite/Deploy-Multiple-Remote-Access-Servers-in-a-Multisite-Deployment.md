---
title: Deploy Multiple Remote Access Servers in a Multisite Deployment
description: This topic is part of the guide Deploy Multiple Remote Access Servers in a Multisite Deployment in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ac2f6015-50a5-4909-8f67-8565f9d332a2
ms.author: pashort
author: shortpatti
---
# Deploy Multiple Remote Access Servers in a Multisite Deployment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

 Windows Server 2016 and Windows Server 2012 combine DirectAccess and Remote Access Service (RAS) VPN into a single Remote Access role. Remote Access can be deployed in a number of enterprise scenarios. This overview provides an introduction to the enterprise scenario for deploying Remote Access servers in a multisite configuration.  
  
## <a name="BKMK_OVER"></a>Scenario description  
In a multisite deployment two or more Remote Access servers or server clusters are deployed and configured as different entry points in a single location, or in dispersed geographical locations. Deploying multiple entry points in a single location allows for server redundancy, or for the alignment of Remote Access servers with existing network architecture. Deployment by geographical location ensures efficient use of resources, as remote client computers can connect to internal network resources using an entry point closest to them. Traffic across a multisite deployment can be distributed and balanced with an external global load balancer.  
  
A multisite deployment supports client computers running Windows 10, Windows 8 or  Windows 7 . Client computers running Windows 10 or Windows 8 automatically identify an entry point, or the user can manually select an entry point. Automatic assignment occurs in the following priority order:  
  
1.  Use an entry point selected manually by the user.  
  
2.  Use an entry point identified by an external global load balancer if one is deployed.  
  
3.  Use the closest entry point identified by the client computer using an automatic probe mechanism.  
  
Support for clients running Windows 7 must be manually enabled on each entry point, and selection of an entry point by these clients is not supported.  
  
## Prerequisites  
Before you begin deploying this scenario, review this list for important requirements:  
  
-   [Deploy a Single DirectAccess Server with Advanced Settings](../../directaccess/single-server-advanced/Deploy-a-Single-DirectAccess-Server-with-Advanced-Settings.md) must be deployed before a multisite deployment.  
  
-   Windows 7 clients will always connect to a specific site. They will not be able to connect to the closest site based on location of the client (unlike Windows 10, 8, or 8.1 clients).  
  
-   Changing policies outside of the DirectAccess management console or PowerShell cmdlets is not supported.  
  
-   A Public Key Infrastructure must be deployed.  
  
    For more information see: [Test Lab Guide Mini-Module: Basic PKI for Windows Server 2012.](https://social.technet.microsoft.com/wiki/contents/articles/7862.test-lab-guide-mini-module-basic-pki-for-windows-server-2012.aspx)  
  
-   The corporate network must be IPv6 enabled. If you are using ISATAP, you should remove it and use native IPv6.  
  
## In this scenario  
The multisite deployment scenario includes a number of steps:  
  
1. [Deploy a single DirectAccess server with advanced settings](../../directaccess/single-server-advanced/Deploy-a-Single-DirectAccess-Server-with-Advanced-Settings.md). A single Remote Access server with advanced settings must be deployed before setting up a multisite deployment.  
  
2. [Plan a Multisite Deployment](plan/Plan-a-Multisite-Deployment.md). To build a multisite deployment from a single server a number of additional planning steps are required, including compliance with multisite prerequisites, and planning for Active Directory security groups, Group Policy Objects (GPOs), DNS, and client settings.  
  
3. [Configure a Multisite Deployment](configure/Configure-a-Multisite-Deployment.md). This consists of a number of configuration steps, including preparation of the Active Directory infrastructure, configuration of the existing Remote Access server, and the addition of multiple Remote Access servers as entry points to the multisite deployment.  
  
4. [Troubleshoot a Multisite Deployment](troubleshoot/Troubleshoot-a-Multisite-Deployment.md). This troubleshooting section describes a number of the most common errors that can occur when deploying Remote Access in a multisite deployment.
  
## <a name="BKMK_APP"></a>Practical applications  
A multisite deployment provides the following:  
  
-   Improved performance-A multisite deployment allows client computers accessing internal resources using Remote Access to connect using the closest and most suitable entry point. Client access internal resources efficiently, and the speed of client Internet requests routed via DirectAccess is improved. Traffic across entry points can be balanced using an external global load balancer.  
  
-   Ease-of-management-Multisite allows administrators to align the Remote Access deployment to an Active Directory sites deployment, providing a simplified architecture. Shared settings can easily be set across entry point servers or clusters. Remote Access settings can be managed from any of the servers in the deployment, or remotely using Remote Server Administration Tools (RSAT). In addition, the entire multisite deployment can be monitored from a single Remote Access Management console.  
  
## <a name="BKMK_NEW"></a>Roles and features included in this scenario  
The following table lists the roles and features used in this scenario.  
  
|Role/feature|How it supports this scenario|  
|---------|-----------------|  
|Remote Access role|The role is installed and uninstalled using the Server Manager console. It encompasses both DirectAccess, which was previously a feature in Windows Server 2008 R2, and Routing and Remote Access Services (RRAS), which was previously a role service under the Network Policy and Access Services (NPAS) server role. The Remote Access role consists of two components:<br /><br />-   DirectAccess and Routing and Remote Access Services (RRAS) VPN-DirectAccess and VPN are managed together in the Remote Access Management console.<br />-   RRAS Routing-RRAS routing features are managed in the legacy Routing and Remote Access console.<br /><br />Dependencies are as follows:<br /><br />-   Internet Information Services (IIS) Web Server - This feature is required to configure the network location server and default web probe.<br />-   Windows Internal Database-Used for local accounting on the Remote Access server.|  
|Remote Access Management Tools feature|This feature is installed as follows:<br /><br />-   It is installed by default on a Remote Access server when the Remote Access role is installed, and supports the Remote Management console user interface.<br />-   It can be optionally installed on a server not running the Remote Access server role. In this case it is used for remote management of a Remote Access computer running DirectAccess and VPN.<br /><br />The Remote Access Management Tools feature consists of the following:<br /><br />-   Remote Access GUI and Command Line Tools<br />-   Remote Access module for Windows PowerShell<br /><br />Dependencies include:<br /><br />-   Group Policy Management Console<br />-   RAS Connection Manager Administration Kit (CMAK)<br />-   Windows PowerShell 3.0<br />-   Graphical Management Tools and Infrastructure|  
  
## <a name="BKMK_HARD"></a>Hardware requirements  
Hardware requirements for this scenario include the following:  
  
-   At least two Remote Access computers to be gathered into a multisite deployment.   
  
-   In order to test the scenario, at least one computer running Windows 8 and configured as a DirectAccess client is required. To test the scenario for clients running Windows 7 at least one computer running Windows 7 is required.  
  
-   To load balance traffic across entry point servers, a third-party external global load balancer is required.  
  
## <a name="BKMK_SOFT"></a>Software requirements  
Software requirements for this scenario include the following:  
  
-   Software requirements for single server deployment.  
  
-   In addition to software requirements for a single server there are a number of multisite-specific requirements:  
  
    -   IPsec authentication requirements-In a multisite deployment DirectAccess must be deployed using IPsec machine certificate authentication. The option to perform IPsec authentication using the Remote Access server as a Kerberos proxy is not supported. An internal CA is required to deploy the IPsec certificates.  
  
    -   IP-HTTPS and network location server requirements-Certificates required for IP-HTTPS and the network location server must be issued by a CA. The option to use certificates that are automatically issued and self-signed by the Remote Access server is not supported. Certificates can be issued by an internal CA or by a third-party external CA.  
  
    -   Active Directory requirements-At least one Active Directory site is required. The Remote Access server should be located in the site. For faster update times, it is recommended that each site has a writeable domain controller, though this is not mandatory.  
  
    -   Security group requirements-Requirements are as follows:  
  
        -   A single security group is required for all Windows 8 client computers from all domains. It is recommended to create a unique security group of these clients for each domain.  
  
        -   A unique security group containing Windows 7 computers is required for each entry point configured to support Windows 7 clients. It is recommended to have a unique security group for each entry point in each domain.  
  
        -   Computers should not be included in more than one security group that includes DirectAccess clients. If clients are included in multiple groups, name resolution for client requests will not work as expected.  
  
    -   GPO requirements-GPOs can be manually created before configuring Remote Access, or automatically created during Remote Access deployment. Requirements are as follows:  
  
        -   A unique client GPO is required for each domain.  
  
        -   A server GPO is required for each entry point, in the domain in which the entry point is located. So if multiple entry points are located in the same domain, there will be multiple server GPOs (one for each entry point) in the domain.  
  
        -   A unique Windows 7 client GPO is required for each entry point enabled for Windows 7 client support, for each domain.  
  
## <a name="KnownIssues"></a>Known issues  
The following are known issues when configuring a multisite scenario:  
  
-   **Multiple entry points in the same IPv4 subnet**. Adding multiple entry points in the same IPv4 subnet will result in an IP address conflict message, and the DNS64 address for the entry point will not be configured as expected. This issue occurs when IPv6 has not been deployed on the internal interfaces of the servers on the corporate network. To prevent this problem run the following Windows PowerShell command on all current and future Remote Access servers:  
  
    ```  
    Set-NetIPInterface -InterfaceAlias <InternalInterfaceName> -AddressFamily IPv6 -DadTransmits 0  
    ```  
  
-   If the public address specified for DirectAccess clients to connect to the Remote Access server has a suffix included in NRPT, DirectAccess might not work as expected. Ensure that the NRPT has an exemption for the public name. In a multisite deployment, exemptions should be added for the public names of all entry points. Note that if force tunneling is enabled these exemptions are added automatically. They are removed if force tunneling is disabled.  
  
-   When using the Windows PowerShell cmdlet **Disable-DAMultiSite**, the WhatIf and Confirm parameters have no effect, and Multisite will be disabled and  Windows 7  GPOs will be removed.  
  
-   When  Windows 7  clients using DCA in a Multisite deployment are upgraded to Windows 8, the Network Connectivity Assistant will not function. This issue can be resolved in advance of the client upgrade by modifying the  Windows 7  GPOs using the following Windows PowerShell cmdlets:  
  
    ```  
    Set-GPRegistryValue -Name <Windows7GpoName> -Domain <DomainName> -Key "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityAssistant" -ValueName "TemporaryValue" -Type Dword -Value 1  
    Remove-GPRegistryValue -Name <Windows7GpoName> -Domain <DomainName> -Key "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityAssistant"  
    ```  
  
    In the event that the client has already been upgraded, then move the client computer to the Windows 8 security group.  
  
-   When modifying domain controller settings using the Windows PowerShell cmdlet **Set-DAEntryPointDC**, if the ComputerName parameter specified is a Remote Access server in an entry point other than the last one added to the Multisite deployment, a warning will be displayed indicating that the server specified will not be updated until the next policy refresh. The actual server(s) that was not updated can be seen using the **Configuration Status** in the **DASHBOARD** of the **Remote Access Management Console**. This will not cause any functional problems, however, you can run **gpupdate /force** on the server(s) that was not updated to get the configuration status updated immediately.  
  
-   When multisite is deployed in an IPv4-only corporate network, changing the internal network IPv6 prefix also changes the DNS64 address, but does not update the address on firewall rules that allow DNS queries to the DNS64 service. To resolve this issue, run the following Windows PowerShell commands after changing the internal network IPv6 prefix:  
  
    ```  
    $dns64Address = (Get-DAClientDnsConfiguration).NrptEntry | ?{ $_.DirectAccessDnsServers -match ':3333::1' } | Select-Object -First 1 -ExpandProperty DirectAccessDnsServers  
  
    $serverGpoName = (Get-RemoteAccess).ServerGpoName  
  
    $serverGpoDc = (Get-DAEntryPointDC).DomainControllerName  
  
    $gpoSession = Open-NetGPO -PolicyStore $serverGpoName -DomainController $serverGpoDc  
  
    Get-NetFirewallRule -GPOSession $gpoSession | ? {$_.Name -in @('0FDEEC95-1EA6-4042-8BA6-6EF5336DE91A', '24FD98AA-178E-4B01-9220-D0DADA9C8503')} |  Set-NetFirewallRule -LocalAddress $dns64Address  
  
    Save-NetGPO -GPOSession $gpoSession  
    ```  
  
-   If DirectAccess was deployed when an existing ISATAP infrastructure was present, when removing an entry point that was an ISATAP host, the IPv6 address of the DNS64 service will be removed from the DNS server addresses of all DNS suffixes in the NRPT.  
  
    To resolve this issue, in the **Infrastructure Server Setup** wizard, on the **DNS** page, remove the DNS suffixes that were modified and add them again with the correct DNS server addresses, by clicking **Detect** on the **DNS Server Addresses** dialog box.  
  


