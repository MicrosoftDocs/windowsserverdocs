---
title: Understanding the desktop hosting environment
description: Overview of an RDS deployhment using Azure IaaS.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 08/01/2016  
ms.tgt_pltfrm: na
ms.topic: article
author: lizap
manager: dongill
---
# Understanding the desktop hosting environment

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

The following information describes the components of the desktop hosting service.  
  
## Tenant environment  
The provider's desktop hosting service is implemented as a set of isolated tenant environments. Each tenant's environment consists of a storage container, a set of virtual machines, and a combination of Azure services, all communicating over an isolated virtual network. Each virtual machine contains one or more of the components that make up the tenant's hosted desktop environment. The following subsections describe the components that make up each tenant's hosted desktop environment.

## Remote Desktop Services
In a desktop hosting environment, the following Remote Desktop Services roles are installed amongst various virtual machines:

  - Remote Desktop Connection Broker
  - Remote Desktop Gateway
  - Remote Desktop Licensing
  - Remote Desktop Session Host
  - Remote Desktop Web Access

For a full description of each of these roles and how they interact with each other, please review the [Understanding RDS roles](Understanding-RDS-roles.md) document.
  
##  (Azure) Active Directory Domain Services  
There are multiple ways to connect to and manage Active Directory Domain Services (AD DS) for a desktop hosting environment in Azure:

1. Create a virtual machine in the tenant's environment running the AD DS role
2. Create a site-to-site VPN connection with the tenant's on-premises environment to use an existing AD DS
3. Use the Azure AD Domain Services PaaS role, which creates a domain on the tenant's virtual network based on the tenant's Azure Active Directory

With Remote Desktop Services, the tenant must have an Active Directory to manage access into the environment, user profile storage, and monitoring within the deployment. When using the standard (non-Azure) AD DS, the tenant's forest does not require any trust relationship with the provider's management forest. A domain administrator account may be set up in the tenant's domain to allow the provider's technical personnel to perform administrative tasks in the tenant's environment (such as monitoring system status and applying software updates) and to assist with troubleshooting and configuration.  
    
Additional information:  
[Azure Active Directory Domain Services Documentation](https://azure.microsoft.com/documentation/services/active-directory-ds/)  
[Install a new Active Directory forest on an Azure virtual network](https://azure.microsoft.com/documentation/articles/active-directory-new-forest-virtual-machine/)  
[Create a resource manager VNet with a Site-to-Site VPN connection using the Azure Portal](https://azure.microsoft.com/documentation/articles/vpn-gateway-howto-site-to-site-resource-manager-portal/)  
  
## Azure SQL Database  
Azure SQL Database allows for hosters to extend their Remote Desktop Services deployment without needing to deploy and maintain a full SQL Server Always-On cluster. The Azure SQL Database is used by the Remote Desktop Connection Broker to store deployment information, such as the mapping of current users' connections to end-host servers. Like other Azure services, Azure SQL DB follows a consumption model, ideal for any size deployment.   
  
Additional information:  
[What is SQL Database?](https://azure.microsoft.com/documentation/articles/sql-database-technical-overview/)  
  
## Azure Active Directory Application Proxy  
Azure Active Directory Application Proxy is a service provided in paid-SKUs of Azure Active Directory that allow users to connect to internal applications through Azure's own reverse-proxy service. This allows the RD Web and RD Gateway endpoints to be hidden inside of the virtual network, eliminating the need to be exposed to the internet via a public IP address. This further allows hosters to condense the number of virtual machines in the tenant's environment while still maintaining a full deployment.
  
Additional information:  
[Enabling Azure AD Application Proxy](https://azure.microsoft.com/documentation/articles/active-directory-application-proxy-enable/)  
    
## File server  
The file server provides shared folders by using the Server Message Block (SMB) 3.0 protocol. The shared folders are used to create and store user profile disk files (.vhdx), to backup data, and to allow users a place to share data with other users in the tenant's virtual network.
  
The VM used to deploy the file server must have an Azure data disk attached and configured with shared folders. Azure data disks use write-through caching which guarantees that writes to the disk persist across restarts of the VM.  
  
For small tenants, the cost can be reduced by combining the file server with the virtual machine running the RD Connection Broker and RD Licensing roles on a single virtual machine in the tenant's environment.  
  
Additional information  
[File and Storage Services Overview](https://technet.microsoft.com/library/hh831487.aspx)  
[How to Attach a Data Disk to a Virtual Machine](http://www.windowsazure.com/manage/windows/how-to-guides/attach-a-disk/)  
  
### User Profile Disks  
User profile disks allow users to save personal settings and files when they are signed in to a session on an RD Session Host server in a collection, and then have access to the same settings and files when signing in to a different RD Session Host server in the collection. When the user first signs in, a user profile disk is created on the tenant's file server, and that disk is mounted to the RD Session Host server to which the user is connected. For each subsequent sign-in, the user profile disk is mounted to the appropriate RD Session host server, and with each sign-out, it is un-mounted. The contents of the profile disk can only be accessed by that user.  
  


