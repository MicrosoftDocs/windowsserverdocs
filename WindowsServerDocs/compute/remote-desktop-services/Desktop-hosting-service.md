---
title: Desktop hosting service
description: Describes the components of a desktop hosting service.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 08/01/2016
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8bfa3e48-5198-4dd8-b2d8-4013477135fb
author: lizap
manager: dongill
---
# Desktop hosting service

>Applies To: Windows Server 2016

The following information describes the components of the desktop hosting service.  
  
## Tenant environment  
The provider's desktop hosting service is implemented as a set of isolated tenant environments. Each tenant's environment consists of a storage container, a set of virtual machines, and a combination of Azure services, all communicating over an isolated virtual network. Each virtual machine contains one or more of the components that make up the tenant's hosted desktop environment. The following subsections describe the components that make up each tenant's hosted desktop environment.  
  
## Remote Desktop Web Access  
The Remote Desktop Web Access (RD Web Access) component allows the tenant's employees to have a single website where they can authenticate and then access Windows desktops and applications that are hosted in Microsoft Azure. By using RD Web Access, Windows desktops and applications can be published to a variety of Windows and non-Windows client devices, and they can be selectively published to specific users or groups.  
  
The RD Web Access component requires installation of Internet Information Services (IIS). A Hypertext Transfer Protocol Secure (HTTPS) connection is used to provide an encrypted communications channel between the clients and the RD Web server. The RD Web Access virtual machine must be accessible through a public IP address that allows inbound TCP connections to port 443 to allow the tenant's users to connect from the Internet using the HTTPS communications transport protocol.   
  
Matching digital certificates must be installed on the server and clients. For development and testing purposes, this can be a self-generated and self-signed certificate. For a released service, the digital certificate must be obtained from a trusted certification authority. The name of the certificate must match the Fully Qualified Domain Name (FQDN) that is used to access RD Web Access whether that be the externally facing DNS name for the public IP address or the CNAME DNS record pointing to the public IP address.  
  
For tenants with small numbers of users, the RD Web Access and Remote Desktop Gateway workloads may be combined in a single virtual machine to reduce cost. To provide a highly available service and to scale-out to larger numbers of users, additional RD Web virtual machines may be added to an RD Web Access farm. When a RD Web Access farm has been implemented in a multiple VMs for high availability and scale out, the virtual machines must be configured in a load-balanced set.  
  
Additional information:  
[Deploying and Configuring RD Web Access](http://social.technet.microsoft.com/wiki/contents/articles/10758.deploying-and-configuring-rd-webaccess-in-windows-server-2012.aspx)  
[Publishing RemoteApps in Windows Server 2012 R2](http://social.technet.microsoft.com/wiki/contents/articles/10817.publishing-remoteapps-in-windows-server-2012.aspx)  
[Distribution of Remote Apps and Desktops in Windows Server 2012 R2](http://social.technet.microsoft.com/wiki/contents/articles/14488.distribution-of-remote-apps-and-desktops-in-windows-server-2012.aspx)  
  
##  Remote Desktop Gateway  
  
The Remote Desktop Gateway (RD Gateway) component enables tenant employees who are using client devices on the public Internet to securely access Windows desktops and applications that are hosted in a Cloud Service in Microsoft Azure.  
  
The RD Gateway component uses Secure Sockets Layer (SSL) to provide an encrypted communications channel between the clients and the server. The RD Gateway virtual machine must be accessible through a public IP address that allows inbound TCP connections to port 443 to allow the tenant's users to connect from the Internet using the HTTPS communications transport protocol. The RD Gateway virtual machine should also be accessible through a public IP address that allows inbound UDP connections to port 3391 to allow users to connect using the UDP protocol for improved performance. Matching digital certificates must be installed on the server and client. For development and testing purposes, this can be a self-generated and self-signed certificate. For a released service, the digital certificate must be obtained from a trusted certification authority. The name of the certificate must match the FQDN that is used to access RD Gateway whether that be the externally facing DNS name for the public IP address or the CNAME DNS record pointing to the public IP address.  
  
For tenants with small number of users, the RD Web Access and RD Gateway can be combined on a single virtual machine to reduce cost. To provide a highly available service and to scale-out to larger numbers of users, additional RD Gateway virtual machines may be added to an RD Gateway farm. When an RD Gateway farm has been implemented in multiple VMs for high availability and scale out, the virtual machines must be configured in a load-balanced set. Using Remote Desktop Gateway on a Windows Server 2016 virtual machine does not require IP affinity, which was required for Windows Server 2012R2.  
  
Additional information:  
[Deploying and Configuring RD Gateway](http://social.technet.microsoft.com/wiki/contents/articles/10974.deploying-and-configuring-rd-gateway-in-windows-server-2012.aspx)  
[What's New In Windows Server 2012 R2 RD Gateway?](https://blogs.technet.microsoft.com/enterprisemobility/2013/03/14/whats-new-in-windows-server-2012-remote-desktop-gateway/#loadbalancing)  
  
##  Azure Active Directory Domain Services  
The tenant's network includes Azure Active Directory Domain Services (AAD DS) for the tenant's forest and domain. Using AAD DS allows the tenant to manage groups and users in their AAD tenant, with all changes syncing back to the domain on a recurring basis.   
  
The tenant's forest does not require any trust relationship with the provider's management forest. A domain administrator account may be set up in the tenant's domain to allow the provider's technical personnel to perform administrative tasks in the tenant's environment (such as monitoring system status and applying software updates) and to assist with troubleshooting and configuration.  
  
Some alternatives to deploying AAD DS are:  
1.  Standing up a stand-alone AD DS server by the hosting provider and located in the tenant's virtual networking environment in Azure.  
2.  Connecting to an AD DS server located on the tenant's premises by creating a site-to-site VPN connection.  
  
Additional information:  
[Azure Active Directory Domain Services Documentation](https://azure.microsoft.com/documentation/services/active-directory-ds/)  
[Desktop Hosting Reference Architecture Guide for Windows Server 2012R2](https://technet.microsoft.com/library/mt404690.aspx) - for information about using on-premises Active Directory in a virtual machine  
[Create a resource manager VNet with a Site-to-Site VPN connection using the Azure Portal](https://azure.microsoft.com/documentation/articles/vpn-gateway-howto-site-to-site-resource-manager-portal/)  
  
## Azure SQL Database  
Azure SQL Database allows for hosters to extend their Remote Desktop Services deployment without needing to deploy and maintain a full SQL Server Always-On cluster. The Azure SQL Database is used by the Remote Desktop Connection Broker to store deployment information, such as the mapping of current users' connections to end-host servers. Like other Azure services, Azure SQL DB follows a consumption model, ideal for any size deployment.   
  
Additional information:  
[What is SQL Database?](https://azure.microsoft.com/documentation/articles/sql-database-technical-overview/)  
  
## Azure Active Directory Application Proxy  
Azure Active Directory Application Proxy is a service provided in paid-SKUs of Azure Active Directory that allow users to connect to internal applications through Azure's own reverse-proxy service. This allows the RD Web and RD Gateway endpoints to be hidden inside of the virtual network, eliminating the need to be exposed to the internet via a public IP address. This further allows hosters to condense the number of virtual machines in the tenant's environment while still maintaining a full deployment. Azure Active Directory Application Proxy also enables many of the benefits that Azure Active Directory provides, such as conditional access and multi-factor authentication.  
  
Additional information:  
[Enabling Azure AD Application Proxy](https://azure.microsoft.com/documentation/articles/active-directory-application-proxy-enable/)  
  
##  Remote Desktop Connection Broker  
Remote Desktop Connection Broker (RD Connection Broker) manages incoming remote desktop connections to the servers in Remote Desktop Session Host (RD Session Host) server farms, known as collections. RD Connection Broker handles connections to collections of full desktops and to collections of RemoteApps. For new connections, RD Connection Broker can balance the load across the servers in the collection. For a session that was disconnected, RD Connection Broker reconnects the user to the correct RD Session Host server and the disconnected session, which already exists in the RD Session Host farm.   
  
To support single sign-on and application publishing, matching digital certificates must be installed on the RD Connection broker server and the client. For development and testing purposes, this can be a self-generated and self-signed certificate. For a released service, the digital certificate must be obtained from a trusted certification authority. The name of the certificate must be the internal Fully Qualified Domain Name (FQDN) of the RD Connection Broker virtual machine.  
  
The Windows Server 2016 RD Connection Broker can be installed on the same virtual machine as AD DS to reduce cost. To provide a highly available service and to scale-out to larger numbers of users, additional RD Connection Broker virtual machines in the same availability set can be added for create an RD Connection Broker cluster. To create an RD Connection Broker cluster, an Azure SQL Database must be deployed in the tenant's environment. If you want to use a Microsoft SQL Server AlwaysOn Availability Group, see the [Desktop Hosting Reference Architecture Guide for Windows Server 2012R2](https://technet.microsoft.com/library/mt404690.aspx).  
  
Additional information:  
[Use an Azure SQL database to enable high availability for your Connection Broker](Use-an-Azure-SQL-database-to-enable-high-availability-for-your-Connection-Broker.md)  
##  Remote Desktop Licensing  
Each tenant's environment includes an activated Remote Desktop Licensing server to allow users to connect to the Remote Desktop Session Host (RD Session Host) servers that host the tenant's desktops and applications. For hosted environments, the licensing server is configured in "per user" mode.   
  
The service provider must acquire the proper number of RDS Subscriber Access Licenses (SALs) based on the number of unique (not concurrent) users authorized to log on to the service each month. Service providers who offer hosted desktops must purchase Microsoft Azure Infrastructure Services directly and the SALs through the Microsoft Service Provider Licensing Agreement (SPLA) program.  End customers who purchase a hosted desktop solution from a service provider must purchase the complete hosted solution (Azure and RDS) from the service provider.  
  
For small tenants, the cost can be reduced by combining the file server and RD Licensing components on a virtual machine in the tenant's environment. To provide a higher availability service, two RD License server virtual machines can be deployed in the same availability set. All the RD servers in the tenant's environment are associated with both RD license servers to ensure that users will be able to connect to new sessions even if one of the license servers is unavailable.  
  
Additional information:  
[Deploying Remote Desktop Licensing Step-by-Step Guide](https://technet.microsoft.com/library/dd983943(WS.10).aspx)  
[Managing RDS Licensing Using PowerShell on Windows Server 2012 R2](http://social.technet.microsoft.com/wiki/contents/articles/13293.managing-rds-licensing-using-powershell-on-windows-server-2012.aspx)  
[Generate Per User CAL Report](https://gallery.technet.microsoft.com/ScriptCenter/9739eaee-fb8a-4cb8-8456-7f138d175934/)  
[Microsoft Volume Licensing: Licensing Options for Service Providers](https://www.microsoft.com/en-us/licensing/licensing-programs/spla-program.aspx#tab=1)  
  
##  Remote Desktop Session Host  
The Remote Desktop Session Host (RD Session Host) component provides a tenant's users with session-based desktops and RemoteApp programs. The desktops and applications can be accessed over the Internet from any device running a capable remote desktop connection client. For more information, see the Client section later in this document.   
  
The remote desktops and applications can be organized into collections of one or more RD Session Host servers. The collections can be customized for specific groups of users within each tenant. For example, a collection could be created so that a tenant's accounting group can access accounting applications but the engineering group cannot access them.   
  
The applications can be installed directly on the RD Session host servers. For larger deployments, streaming applications to the RD Session Host from an App-V server is recommended to reduce the maintenance costs.   
  
To provide higher availability of the collections and to increase scale to support more users or applications that use more computer resources, each collection can be expanded by adding RD Session Host server virtual machines to a collection farm with each RDSH virtual machine within a collection assigned to same availability set.  
  
In most cases, the RD Session Host servers are shared by multiple users simultaneously. This is the most efficient way to utilize the Azure resources for a desktop hosting solution. In this configuration, users must sign in to collections by using non-administrative accounts. In certain cases, some users want full administrative access to their remote desktop; this can be achieved by creating personal session desktop collections.  
  
Additional customizations to desktops can be made by creating and uploading a virtual hard disk that contains the Windows Server operating system to be used as a template for creating RD Session Host virtual machines.  
  
Additional information:  
[Easier User Data Management with User Profile Disks in Windows Server 2012 R2  
Personal Session Desktops](http://blogs.msdn.com/b/rds/archive/2012/11/13/easier-user-data-management-with-user-profile-disks-in-windows-server-2012.aspx)  
[Getting started with App-V 5.0](https://technet.microsoft.com/itpro/mdop/appv-v5/getting-started-with-app-v-50--rtm)  
[Upload a Windows VM image to Microsoft Azure for Resource Manager deployments](https://azure.microsoft.com/documentation/articles/virtual-machines-windows-upload-image/)  
  
## File server  
The file server provides shared folders by using the Server Message Block (SMB) 3.0 protocol. The shared folders are used to create and store user profile disk files (.vhdx), to backup data, and to allow users a place to share data with other users in the tenant's Cloud Service.   
  
The VM used to deploy the file server must have an Azure data disk attached and configured with shared folders. Azure data disks use write-through caching which guarantees that writes to the disk persist across restarts of the VM.  
  
For small tenants, the cost can be reduced by combining the file server and RD Licensing components on a single virtual machine in the tenant's environment.  
  
Additional information  
[File and Storage Services Overview](http://technet.microsoft.com/library/hh831487.aspx)  
[How to Attach a Data Disk to a Virtual Machine](http://www.windowsazure.com/manage/windows/how-to-guides/attach-a-disk/)  
  
### User Profile Disks  
User profile disks allow users to save personal settings and files when they are signed in to a session on an RD Session Host server in a collection, and then have access to the same settings and files when signing in to a different RD Session Host server in the collection. When the user first signs in, a user profile disk is created on the tenant's file server, and that disk is mounted to the RD Session Host server to which the user is connected. For each subsequent sign-in, the user profile disk is mounted to the appropriate RD Session host server, and with each sign-out, it is un-mounted. The contents of the profile disk can only be accessed by that user.  
  


