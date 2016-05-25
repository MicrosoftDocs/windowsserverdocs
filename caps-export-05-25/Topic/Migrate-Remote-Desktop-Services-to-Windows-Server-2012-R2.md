---
title: Migrate Remote Desktop Services to Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 51d5f470-eae7-4f60-b308-e06c324aaa7b
author: lizap
---
# Migrate Remote Desktop Services to Windows Server 2012 R2
Remote Desktop Services is a role in the Windows Server operating system that provides multi\-user access to applications and desktops for non\-administrative purposes. This guide describes how to migrate Remote Desktop Services, what Remote Desktop Services role services will be migrated, and tasks that apply to migrating the role services.  
  
## About this guide  
This guide describes how to migrate the Remote Desktop Services role by providing preparation, migration and verification steps.  
  
Migration documentation and tools ease the migration of server role settings and data from an existing server to a destination server that is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. By using the process described in this guide, you can simplify the migration process, reduce migration time, increase the accuracy of the migration process, and help eliminate possible conflicts that might otherwise occur during the migration process.  
  
> [!NOTE]  
> Your detailed feedback is very important, and it helps us make Windows Server Migration Guides as reliable, complete, and easy\-to\-use as possible. Please take a moment to rate this topic and add comments that support your rating. Click **Rate this topic** at the top of the page. Describe what you liked, did not like, or want to see in future versions of the topic. To submit additional suggestions about how to improve Windows Server migration guides or tools, please write a post on the [Windows Server Migration forum](http://go.microsoft.com/fwlink/?LinkId=247606).  
  
### Target audience  
This guide is intended for the following audiences:  
  
-   IT architects who are responsible for computer management and security throughout an organization  
  
-   IT operations engineers who are responsible for the day\-to\-day management and troubleshooting of networks, servers, client computers, operating systems, or applications  
  
-   IT operations managers who are accountable for network and server management  
  
## What this guide does not provide  
This guide does not cover migration of the following:  
  
-   Customizations made to any Remote Desktop Services role service. In particular, this may apply to the RD Session Host, RD Virtualization Host, RD Web Access, or RD Connection Broker role services.  
  
-   Third\-party application settings, programs, or plug\-ins  
  
-   More than one server role at the same time  
  
-   More than one role service at a time  
  
-   Group Policy settings  
  
-   User profiles, including roaming profiles  
  
-   Event history  
  
-   Microsoft applications or application settings  
  
-   RD Connection Broker servers that are configured in a clustered or load\-balanced environment \(except High\-Availability mode\)  
  
This guide does not contain instructions for migration when the source server is running multiple roles. If your server is running multiple roles, it is recommended that you design a custom migration procedure that is specific to your server environment, based on the information provided in other role migration guides. Migration guides for additional server roles are available on the [Windows Server Migration Portal](http://technet.microsoft.com/windowsserver/jj554790.aspx).  
  
> [!CAUTION]  
> If your source server is running multiple roles, some migration steps in this guide, such as those for computer name and IP configuration, can cause other roles that are running on the source server to fail.  
  
## Supported migration scenarios  
This guide provides you with instructions for the following:  
  
-   Migrating a server that is running Remote Desktop Services on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to a server that is running Remote Desktop Services on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]  
  
-   Migrating between two servers running Remote Desktop Services on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]  
  
For the migration scenarios that are described in this guide, each of the Remote Desktop Services role services is migrated separately. You can migrate one, some, or all role services by following the steps in this guide. For information about the order of migration, see [Order of migration for multiple role services](../Topic/Migrate-Remote-Desktop-Services-to-Windows-Server-2012-R2.md#BKMK_Order)later in this topic.  
  
### Supported operating systems  
The Remote Desktop Services role services are available in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] as follows:  
  
-   All Remote Desktop Services role services are available in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] Standard, [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] Enterprise, and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] Datacenter.  
  
-   RD Web Access is available in Windows Web Server 2012 R2.  
  
-   RD Session Host, RD Licensing, RD Web Access, and RD Gateway are available in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] Foundation.  
  
**Physical to virtual machine migration**  
  
Migration between physical operating systems and virtual operating systems are supported for the RD Connection Broker, RD Session Host, RD Web Access, RD Licensing, and RD Gateway role services. However, the RD Virtualization Host role services and the Hyper\-V role do not run on virtual machines.  
  
**Backward compatibility**  
  
You can migrate the Remote Desktop Services role services from computers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to a computer running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
### Policy and configuration settings  
Some Remote Desktop Services settings can be configured by using Group Policy. Information about migrating Group Policy settings is not included in this migration guide.  
  
### Supported role services and features  
This migration guide describes how to migrate the Remote Desktop Services role services from a source server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to a destination server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
Following are the Remote Desktop Services role services that can be migrated to a computer running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]:  
  
1.  RD Connection Broker  
  
2.  RD Virtualization Host  
  
3.  RD Session Host  
  
4.  RD Web Access  
  
5.  RD Licensing  
  
6.  RD Gateway  
  
## Migration scenarios that are not supported  
The following scenarios are not supported:  
  
-   Upgrading Windows Server 2008 Terminal Services or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] Remote Desktop Services server role or role services  
  
-   Migrating or upgrading from Windows Server 2003 or Windows Server 2003 R2  
  
-   Migrating from a source server to a destination server that is running an operating system with a different system UI language installed  
  
-   Migrating the RD Virtualization Host or RD Session Host role services from physical computers to virtual machines  
  
-   Migrating any applications or application settings from the RD Session Host server  
  
## <a name="BKMK_Order"></a>Order of migration for multiple role services  
The steps in this guide are based on migrating the role services in the following order when you are migrating more than one role service:  
  
1.  RD Connection Broker  
  
2.  RD Session Host  
  
3.  RD Virtualization Host  
  
4.  RD Web Access  
  
The following role services can be migrated at any time during the migration:  
  
-   RD Licensing  
  
-   RD Gateway  
  
In a Remote Desktop Services deployment, RD Connection Broker servers must be migrated first. All other services can be migrated independently. If you do not have RD Connection Broker servers, you can migrate other role services by following the steps provided in this document.  
  
The Remote Desktop license server can be migrated at any time, but if the new license server does not have the same name as the source server, the Remote Desktop deployments and standalone RD Session Host servers that use that license server must be configured after migration to use the new license server.  
  
The RD Gateway server migration is not dependent on the other role services for migration. It can be migrated at any time.  
  
## Impact of migration on Remote Desktop Services  
A Remote Desktop Services role service will not be available during migration. This is also the case for any role services that are dependent on it. In addition, applications and add\-ons on the affected servers will not be available.  
  
Migration times will be affected by the dependencies between role services. For example, RD Session Host servers, RD Virtualization Host servers, and RD Web Access servers are dependent on RD Connection Broker servers. These dependencies should be considered when you are estimating downtime.  
  
Plan your data migration to occur during off\-peak hours to minimize downtime and reduce impact to users. Notify users that the resources will be unavailable during that time.  
  
In some deployments, replication may extend the length of time that the services are unavailable.  
  
If there is more than one role service on the source server, after you remove the source server from the domain, you will not have access to role services that you didn’t migrate.  
  
The following table details the expected impacts during the migration process.  
  
|Role service|Dependent role services|Impact of migration|Downtime estimates|  
|----------------|---------------------------|-----------------------|----------------------|  
|RD Connection Broker|RD Virtualization Host, RD Session Host, RD Web Access|Users will not have access to any resources that are managed by the RD Connection Broker or TS Session Broker server that is being migrated. These resources include RemoteApp programs, virtual desktop pools, and personal virtual desktops.|Three hours|  
|RD Session Host|RD Web Access may be dependent on RD Session Host in your deployment.|Session collections will not be available until migration of all destination servers in the virtual desktop collection is complete. RemoteApp programs will not be available until they are installed on the destination servers.|One hour|  
|RD Virtualization Host|RD Virtualization Host is dependent on RD Connection Broker.|Virtual desktop collections will not be available until migration of all destination servers in the virtual desktop collection is complete.|Three hours or more depending on the number of virtual machines being migrated|  
|RD Web Access|RD Web Access cannot serve connections to session collections or virtual desktop collections while they are being migrated.|Resources that are accessed by RD Web Access and managed by the associated RD Connection Broker server will not be available. These resources include session collections and virtual desktop collections.|One hour|  
|RD Licensing|Remote Desktop deployments and standalone RD Session Host servers must be configured with at least one Remote Desktop license server that is available to serve licenses. If not, users cannot connect to the RD Session Host servers while they are being migrated.|Remote Desktop deployments and standalone RD Session Host servers that are configured to use the license server may not be able to receive licenses during the migration.|One hour|  
|RD Gateway|RD Gateway|Users cannot  access the network with the RD Gateway server that is being migrated. The Remote Desktop Gateway service may be slow or not available.|One hour|  
  
## Additional references  
  
-   **You are here in this migration process document:** Migrate Remote Desktop Services to Windows Server 2012  
  
-   [Remote Desktop Services: Prepare to Migrate](../Topic/Remote-Desktop-Services--Prepare-to-Migrate.md)  
  
-   [Remote Desktop Services: Migrate Remote Desktop Services Role Services](../Topic/Remote-Desktop-Services--Migrate-Remote-Desktop-Services-Role-Services.md)  
  
-   [Remote Desktop Services: Verify the Migration](../Topic/Remote-Desktop-Services--Verify-the-Migration.md)  
  
-   [Remote Desktop Services: Post-Migration Tasks](../Topic/Remote-Desktop-Services--Post-Migration-Tasks.md)  
  
-   [Windows Server Migration forum](http://go.microsoft.com/fwlink/?LinkId=247606)  
  
-   [Windows Server Migration Portal](http://technet.microsoft.com/windowsserver/jj554790.aspx)  
  
