---
title: Desktop hosting service
description: Describes the components of a desktop hosting service.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 06/01/2018
ms.tgt_pltfrm: na
ms.topic: article
author: lizap
manager: dongill
---
# Desktop hosting service

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This article will tell you more about the desktop hosting service's components.

## Tenant environment

The provider's desktop hosting service is implemented as a set of isolated tenant environments. Each tenant's environment consists of a storage container, a set of virtual machines, and a combination of Azure services, all communicating over an isolated virtual network. Each virtual machine contains one or more of the components that make up the tenant's hosted desktop environment. The following subsections describe the components that make up each tenant's hosted desktop environment.

## Azure Active Directory Domain Services

The tenant's network includes Azure Active Directory Domain Services (AD DS) for the tenant's forest and domain. Using Azure AD DS allows the tenant to manage groups and users in their Azure AD tenant, with all changes syncing back to the domain on a recurring basis.

The tenant's forest does not require any trust relationship with the provider's management forest. A domain administrator account may be set up in the tenant's domain to allow the provider's technical personnel to perform administrative tasks in the tenant's environment (such as monitoring system status and applying software updates) and to assist with troubleshooting and configuration.

Some alternatives to deploying Azure AD DS are:

1. The hosting provider sets up a stand-alone AD DS server in the tenant's virtual networking environment.
2. Creating a site-to-site VPN connection to an AD DS server located on the tenant's premises.

For more information, see the following articles:

* [Azure Active Directory Domain Services documentation](https://docs.microsoft.com/azure/active-directory-domain-services/)
* [Desktop Hosting Reference Architecture Guide for Windows Server 2012 R2](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-howto-site-to-site-resource-manager-portal)
* [Create a site-to-site connection in the Azure portal](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-howto-site-to-site-resource-manager-portal)

## Azure SQL Database

Hosters can use Azure SQL Database to extend their Remote Desktop Services deployment without deploying or maintaining a full SQL Server Always-On cluster. The Azure SQL Database is used by the Remote Desktop Connection Broker to store deployment information, such as the mapping of current users' connections to end-host servers. Like other Azure services, Azure SQL DB follows a consumption model, ideal for any size deployment.

For information, see [What is the Azure SQL Database service?](https://docs.microsoft.com/azure/sql-database/sql-database-technical-overview)

## Azure Active Directory Application Proxy

Azure Active Directory (AD) Application Proxy is a service provided in paid SKUs of Azure AD that allow users to connect to internal applications through Azure's own reverse-proxy service. This allows the RD Web and RD Gateway endpoints to be hidden inside of the virtual network, eliminating the need to be exposed to the internet by a public IP address. Hosters can use Azure AD Application Proxy to condense the number of virtual machines in the tenant's environment while still maintaining a full deployment. Azure AD Application Proxy also enables many of the benefits that Azure AD provides, such as conditional access and multi-factor authentication.

For more information, see [Get started with Application Proxy and install the connector](https://docs.microsoft.com/azure/active-directory/manage-apps/application-proxy-enable).

## File server

The file server uses the Server Message Block (SMB) 3.0 protocol to provide shared folders. These shared folders are used to create and store user profile disk files (.vhdx) to back up data and let users share data with with each other within the tenant's cloud service.

The virtual machine that deploys the file server must have an Azure data disk attached and configured with shared folders. Azure data disks use write-through caching, guaranteeing that writes to the disk will not be erased whenever the virtual machine is restarted.

Small tenants can reduce costs by combining the file server and [RD Licensing role](rds-roles.md#remote-desktop-licensing) on a single virtual machine in the tenant's environment.

For more information, see the following articles:

* [File and Storage Services overview](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831487(v=ws.11)>)
* [How to attach a managed data disk to a Windows VM in the Azure portal](https://docs.microsoft.com/azure/virtual-machines/windows/attach-managed-disk-portal?toc=%2Fazure%2Fvirtual-machines%2Fwindows%2Fclassic%2Ftoc.json)

### User Profile Disks

User profile disks allow users to save personal settings and files when they are signed in to a session on an RD Session Host server in one collection, then access the same settings and files when signing in to a different [RD Session Host](rds-roles.md#remote-desktop-session-host) server in the collection. When the user first signs in, the tenant's file server creates a user profile disk that gets mounted to the RD Session Host server that the user is currently connected to. For each subsequent sign-in, the user profile disk is mounted to the appropriate RD Session host server, and it is unmounted with each sign-out. Only the user can access the profile disk's contents.