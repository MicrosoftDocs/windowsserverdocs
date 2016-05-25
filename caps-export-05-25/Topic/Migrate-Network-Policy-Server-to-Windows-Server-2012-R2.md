---
title: Migrate Network Policy Server to Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 18ab28df-7cef-45be-ab89-60edcb25691d
---
# Migrate Network Policy Server to Windows Server 2012 R2
This document provides guidance for migrating the Network Policy Server \(NPS\) or Internet Authentication Server \(IAS\) role service from an x86\-based or x64\-based server running Windows Server 2003, [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)], [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)], or [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] to a new [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] server.  
  
## About this guide  
  
> [!NOTE]  
> Your detailed feedback is very important, and helps us to make Windows Server Migration Guides as reliable, complete, and easy to use as possible. Please take a moment to rate this topic by clicking the stars in the upper\-right corner of the page \(1\=poor, 5\=excellent\), and then add comments that support your rating. Describe what you liked, did not like, or want to see in future versions of the topic. To submit additional suggestions about how to improve Migration guides or utilities, post on the [Windows Server Migration forum](http://go.microsoft.com/fwlink/?LinkId=181228).  
  
NPS migration documentation and tools ease the migration of NPS role service settings and data from an existing server to a destination server that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. By using the tools that are described in this guide, you can simplify the IAS\/NPS migration process, reduce migration time, increase the accuracy of the IAS\/NPS migration process, and help to eliminate possible conflicts that might otherwise occur during the migration process.  
  
### Target audience  
This guide is intended for the following IT professionals:  
  
-   IT architects responsible for computer management and security throughout an organization.  
  
-   IT operations engineers who are responsible for the day\-to\-day management and troubleshooting of networks, servers, client computers, operating systems, or applications.  
  
-   IT operations managers who are accountable for network and server management.  
  
### What this guide does not provide  
This guide does not provide detailed steps to migrate the configuration of other services that might be running on the source server.  
  
Guidance is not provided for scenarios in which the new operating system is installed on existing server hardware by using the upgrade option during setup.  
  
### <a name="BKMK_Supportedmigrationscenarios"></a>Supported migration scenarios  
This guide provides the instructions for migrating an existing server that is running NPS or IAS to a server that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. This guide does not contain instructions for Network Policy Server migration when the source server is running multiple roles. If your server is running multiple roles, it is recommended that you design a custom migration procedure specific to your server environment, based on the information provided in other role migration guides. Migration guides for additional roles are available on [Migrating Roles and Features in Windows Server](http://technet.microsoft.com/windowsserver/jj554790.aspx).  
  
> [!CAUTION]  
> If your source server is running multiple roles, some migration steps in this guide, such as those for computer name and IP configuration, can cause other roles that are running on the source server to fail.  
  
#### Supported operating systems  
The following table displays the minimum operating system requirements that are supported by this guide.  
  
|Source server processor|Source server operating system|Destination server operating system|Destination server processor|  
|---------------------------|----------------------------------|---------------------------------------|--------------------------------|  
|x86\- or x64\-based|Windows Server 2003 SP2|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|x64\-based|  
|x86\- or x64\-based|Windows Server 2003 R2|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|x64\-based|  
|x86\- or x64\-based|[!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|x64\-based|  
|x64\-based|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|x64\-based|  
|x64\-based|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|x64\-based|  
|x64\-based|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|x64\-based|  
  
-   The NPS role service is not available in Server Core editions. Foundation, Standard, Enterprise, and Datacenter editions of Windows Server are supported as either source or destination servers. Windows Server Foundation edition is not available for Windows Server 2003.  
  
-   Migration from a source server to a destination server that is running an operating system with a different installed language is not supported. For example, migration of server roles from a computer that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] with a system language of French to a computer that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] with a system language of German is not supported. The system language is the language of the localized installation package that was used to set up the Windows operating system.  
  
-   Both x86\-based and x64\-based migrations are supported for Windows Server 2003 and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. All editions of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] are x64\-based.  
  
#### Supported NPS role configurations  
Migration of the following NPS settings are supported by this guide:  
  
1.  **Policies**. Migration of NPS policy configuration, including connection request policies, network policies, and health policies is supported by using this guide.  
  
2.  **Authentication methods**. All supported authentication method settings can be migrated using this guide.  For more information about authentication methods, see [NPS Authentication Methods](http://go.microsoft.com/fwlink/?LinkId=169629) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=169629\).  
  
3.  **System Health Validators \(SHVs\)**. Migration of SHV configuration settings implemented using Microsoft published SDK are supported.  
  
4.  **NPS templates**. Template settings are migrated using NPS UI export and import functionality. You cannot migrate template settings using the command line.  
  
5.  **RADIUS clients and remote RADIUS servers**. RADIUS clients and remote RADIUS server configuration settings, including shared secrets can be migrated using this guide.  
  
6.  **SQL accounting**. The configuration of SQL parameters, including connection, description, accounting, authentication, periodic accounting status, periodic authentication status, and max sessions settings can be migrated using this guide. It is recommended to manually configure SQL connection string settings. For more information, see [Configure SQL Server Logging in NPS](http://go.microsoft.com/fwlink/?LinkId=169631) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=169631\).  
  
##### IP address and host name configuration  
This guide supports the following scenarios:  
  
1.  The destination server is configured with the same host name or IP address as source server.  
  
2.  The destination server is configured with a different host name or IP address than the source server.  
  
#### Migration scenarios that are not supported  
The following migration scenarios are not covered in this document:  
  
-   **Upgrade**. Guidance is not provided for scenarios in which the new operating system is installed on existing server hardware by using the **Upgrade** option during setup.  
  
-   **Extension DLLs**. This guide does not support migration of extension DLL registry key settings. For more information about extension DLL registry key migration, see [Setting Up the Extension DLLs](http://go.microsoft.com/fwlink/?LinkId=169632) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=169632\).  
  
-   **Non\-Microsoft authentication methods**. The migration of settings for non\-Microsoft authentication methods is not supported. To migrate these settings, refer to your vendor documentation.  
  
-   **Non\-Microsoft SHVs**. The migration of settings for non\-Microsoft SHVs is supported only if the SHV is developed using guidance from the NAP SHA\/SHV SDK. To migrate these settings, refer to your vendor documentation.  
  
## Overview of migration process for this role  
Network Policy Server \(NPS\) is the Microsoft implementation of a Remote Authentication Dial\-in User Service \(RADIUS\) server and proxy in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. NPS is the replacement for Internet Authentication Service \(IAS\) in Windows Server 2003.  
  
The current topic provides an overview of the NPS migration process. The NPS migration guide also includes the following major sections:  
  
-   [Prepare to Migrate](assetId:///fe7cb58d-a062-4b42-9d90-0ec5b79d32c5)  
  
-   [Migrating the NPS Server](../Topic/Migrating-the-NPS-Server.md)  
  
-   [Verifying the NPS Server Migration](../Topic/Verifying-the-NPS-Server-Migration.md)  
  
-   [Post-Migration Tasks](../Topic/Post-Migration-Tasks.md)  
  
-   [Appendix A \- Data Collection Worksheet](assetId:///8b5be90e-1c95-41cc-9eaa-9bf9daa984ac)  
  
The pre\-migration process involves establishing a storage location for migration data, collection of information that will be used to perform the server migration, and operating system installation on the destination server. The NPS migration process includes using the **iasmigreader** tool if the source server is running Windows Server 2003. If the source server is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], the Network Shell \(netsh\) utility is used to obtain NPS settings. When migrating a source server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you can use netsh or [!INCLUDE[wps_1](../Token/wps_1_md.md)]. Procedures are then performed on the destination server to install the required roles and migrate NPS settings. Verification procedures include testing the destination server to ensure it works correctly. Post\-migration procedures include retiring or repurposing the source server.  
  
## <a name="BKMK_impact"></a>Impact of migration  
In its recommended configuration, the destination server has the same host name and IP address as the source server. In this scenario, the source server will be unavailable to process network access requests for the duration of the migration process \(estimated 1\-2 hours\).  
  
This guide also includes procedures for migration of the NPS server configuration from the source server to a destination server with a different host name or IP address. This allows the source and destination NPS servers to run simultaneously until all testing and verification is complete, and reduces service disruption. If you change the name or IP address of the server running NPS, RADIUS clients must also be updated with the new NPS server name and IP address.  
  
### Impact of migration on the source server  
  
-   When deploying the destination server with the same host name and IP address as the source server, the source server must be decommissioned and taken offline prior to renaming the destination server from *tempNPS* to the host name of the source server.  
  
-   When deploying the destination server with a different host name and IP address, there is no impact to the source server.  
  
### Impact of migration on other computers in the enterprise  
  
-   When deploying the destination server with the same host name and IP address, network access requests cannot be evaluated by NPS while the source server is offline and before the destination server brought online with the same name and IP address. During this time, client computers requesting access to the network cannot authenticate and are denied network access.  
  
-   When deploying the destination server with a different host name and IP address, RADIUS client settings for all network access servers that are configured to use the source server must be updated.  
  
## Permissions required to complete migration  
The following permissions are required on the source server and the destination server:  
  
-   Membership in the **Administrators** group, or the equivalent, is the minimum required to install and configure server running NPS.  
  
-   Membership in the SQL database rights are required for SQL settings migration.  
  
-   If the destination server is a domain member, membership in the **Domain Admins** group, or the equivalent, is the minimum required to authorize the NPS server.  
  
## Estimated duration  
The work required to migrate NPS settings from the source to destination server, including testing, can require 1 to 2 hours. Additional time may be required for migration of non\-Microsoft authentication methods, SHVs or extension DLLs.  
  
