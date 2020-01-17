---
title: Desktop hosting service
description: Describes the components of a desktop hosting service.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: helohr
ms.date: 07/06/2018
ms.tgt_pltfrm: na
ms.topic: article
author: heidilohr
manager: lizross
---
# Desktop hosting service

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

This article will tell you more about the desktop hosting service's components.

## Tenant environment

As described in [Remote Desktop service roles](rds-roles.md), each role plays a distinct part in the tenant envrionment.

The provider's desktop hosting service is implemented as a set of isolated tenant environments. Each tenant's environment consists of a storage container, a set of virtual machines, and a combination of Azure services, all communicating over an isolated virtual network. Each virtual machine contains one or more of the components that make up the tenant's hosted desktop environment. The following subsections describe the components that make up each tenant's hosted desktop environment.

## Active Directory Domain Services

Active Directory Domain Services (AD DS) provides the domain and forest information, such that the tenant's users can sign in to the desktops and applications to carry out their workloads. This also enables you to set up or connect to required file shares and databases that may be required for Windows applications.

The tenant's forest does not require any trust relationship with the provider's management forest. A domain administrator account may be set up in the tenant's domain to allow the provider's technical personnel to perform administrative tasks in the tenant's environment (such as monitoring system status and applying software updates) and to assist with troubleshooting and configuration.

There are multiple ways to deploy AD DS:

1. Enable Azure Active Directory Domain Services in the tenant's virtual networking environment. This will create a managed AD DS instance for the tenant based on the users and groups that exist in Azure AD.
2. Set up a stand-alone AD DS server in the tenant's virtual networking environment. This gives you all of the full control of the AD DS instance running on virtual machines.
3. Create a site-to-site VPN connection to an AD DS server located on the tenant's premises. This allows the tenant to connect to their existing AD DS instance and reduce duplication of users, groups, organizational units, and so on.

For more information, see the following articles:

* [Azure Active Directory Domain Services documentation](https://docs.microsoft.com/azure/active-directory-domain-services/)
* [Desktop Hosting Reference Architecture Guide for Windows Server 2012 R2](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-howto-site-to-site-resource-manager-portal)
* [Create a site-to-site connection in the Azure portal](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-howto-site-to-site-resource-manager-portal)

## SQL database

A highly-available SQL database is used by the Remote Desktop Connection Broker to store deployment information, such as the mapping of current users' connections to the host servers.

There are multiple ways to deploy an SQL database:

1. Create an Azure SQL Database in the tenant's environment. This provides you with the functionality of a redundant SQL database without you having to manage the servers themselves. This also allows you to pay for what you consume instead of investing in infrastructure.
2. Create an SQL Server AlwaysOn cluster. This allows you to leverage existing SQL Server infrastructure and gives you complete control over the SQL Server instances.

For more information about how to set up a highly-available SQL database infrastructure, see the following articles:

* [What is the Azure SQL Database service?](https://docs.microsoft.com/azure/sql-database/sql-database-technical-overview)
* [Creation and configuration of availability groups (SQL Server)](https://docs.microsoft.com/sql/database-engine/availability-groups/windows/creation-and-configuration-of-availability-groups-sql-server?view=sql-server-2017).
* [Add the RD Connection Broker server to the deployment and configure high availability](rds-connection-broker-cluster.md).

## File server

The file server uses the Server Message Block (SMB) 3.0 protocol to provide shared folders. These shared folders are used to create and store user profile disk files (.vhdx) to back up data and let users share data with each other within the tenant's cloud service.

The virtual machine that deploys the file server must have an Azure data disk attached and configured with shared folders. Azure data disks use write-through caching, guaranteeing that writes to the disk will not be erased whenever the virtual machine is restarted.

Small tenants can reduce costs by combining the file server and [RD Licensing role](rds-roles.md#remote-desktop-licensing) on a single virtual machine in the tenant's environment.

For more information, see the following articles:

* [Storage in Windows Server](../../storage/storage.md)
* [How to attach a managed data disk to a Windows VM in the Azure portal](https://docs.microsoft.com/azure/virtual-machines/windows/attach-managed-disk-portal?toc=%2Fazure%2Fvirtual-machines%2Fwindows%2Fclassic%2Ftoc.json)

### User profile disks

User profile disks allow users to save personal settings and files when they are signed in to a session on an RD Session Host server in one collection, then access the same settings and files when signing in to a different [RD Session Host](rds-roles.md#remote-desktop-session-host) server in the collection. When the user first signs in, the tenant's file server creates a user profile disk that gets mounted to the RD Session Host server that the user is currently connected to. For each subsequent sign-in, the user profile disk is mounted to the appropriate RD Session host server, and it is unmounted with each sign-out. Only the user can access the profile disk's contents.