---
title: Remote Desktop Services: Prepare to Migrate
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7441980a-af6b-4835-979e-a00288fdc276
author: lizap
---
# Remote Desktop Services: Prepare to Migrate
This topic explains how to prepare to migrate the Remote Desktop Services role services from a source server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to a destination server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. It assumes that you are migrating some or all of the role services, including dependencies, from a functional deployment of Remote Desktop Services.  
  
The general preparation instructions provided in this topic apply to the following role services in Remote Desktop Services.  
  
-   RD Connection Broker  
  
-   RD Session Host  
  
-   RD Virtualization Host  
  
-   RD Web Access  
  
-   RD Licensing  
  
-   RD Gateway  
  
## Assign permissions required to migrate Remote Desktop Services  
At a minimum, you must be a member of the **Administrators** group on the source server and the destination server to install, remove, or set up Remote Desktop Services.  
  
## Migration dependencies  
Remote Desktop Services role services have dependencies or prerequisites for migration, as described in this section.  
  
### Prerequisite features to migrate separately  
The following features in Remote Desktop Services must be migrated separately:  
  
-   DNS Server  
  
-   Active Directory Domain Services  
  
    Remote Desktop User Profiles are stored in Active Directory.:  
  
    -   To migrate Active Directory Domain Services, see [Active Directory Domain Services and DNS Server Migration Guide](http://technet.microsoft.com/library/dd379558(WS.10).aspx)  
  
    -   To deploy user profiles, see [User Profiles on Windows Server 2008 R2 Remote Desktop Services](http://blogs.msdn.com/b/rds/archive/2009/06/02/user-profiles-on-windows-server-2008-r2-remote-desktop-services.aspx)  
  
-   Active Directory Certificates Services  
  
    -   If you are migrating an enterprise certification authority \(CA\) within the same domain, before you migrate Remote Desktop Services, follow the instructions in [AD CS Migration: Migrating the Certification Authority](http://technet.microsoft.com/library/ee126140(WS.10).aspx).  
  
    -   If you are migrating an enterprise CA within the same domain, before you migrate Remote Desktop Services, follow the instructions in [AD CS Migration: Migrating the Certification Authority](http://technet.microsoft.com/library/ee126140(WS.10).aspx).  
  
    -   Group Policy  
  
        You can migrate Group Policy objects \(GPOs\) by using the Import Settings Wizard in the Group Policy Management Console \(GPMC\). For more information, see [Import Settings from a Group Policy Object](http://technet.microsoft.com/library/cc753786.aspx).  
  
-  
  
### Prerequisite features already installed  
Remote Desktop Services role services require the following roles and features in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. With the exception of Network Policy and Access Services \(NPAS\), these roles and features are installed automatically when the role service is installed, if they are not already installed on the server.  
  
-   RD Web Access requires Web Server \(IIS\)  
  
-   RD Virtualization Host requires Hyper\-V  
  
-   RD Gateway requires Web Server \(IIS\), RPC over HTTP Proxy, and Network Policy and Access Services \(NPAS\)  
  
## Prepare your source server  
To prepare your source server for migration, you need to back it up and gather data.  
  
### Back up your source server  
Migrating some Remote Desktop Services role services require import or export of registry settings. You should back up the computer before working with the registry.  
  
You can find information about backing up [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] in the following topics:  
  
-   [Backup and Recovery](http://go.microsoft.com/fwlink/?LinkId=195054).  
  
-   [Registry Editor](http://go.microsoft.com/fwlink/?LinkId=193002).  
  
### Gather data from your source server  
Settings for applications on the Remote Desktop Session Host server will not be gathered or recorded during this migration. Before you retire the RD Session Host server, gather and record the data that you will migrate from the source server into a data collection worksheet for each role service.  
  
## Prepare your destination server  
The following steps are necessary to prepare all destination servers for the migration of Remote Desktop Services role services.  
  
### Hardware requirements for the destination server  
Verify that the computer meets the hardware requirements for the role service and its prerequisites. Minimally, you should migrate to servers with comparable memory, disk space, processors, and GPUs.  
  
The RD Virtualization Host server must meet the hardware requirements for the Hyper\-V server role. For more information about Hyper\-V hardware requirements, see [Hardware Considerations](http://go.microsoft.com/fwlink/?LinkId=129920).  
  
RD Session Host, RD Web Access, and RD Virtualization Host cannot run on virtual machines.  
  
### Software requirements for the destination server  
Remote Desktop Services is a server role in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] must be installed on the destination server before you migrate any of the Remote Desktop Services role services.  
  
RD Session Host, RD Virtualization Host, RD Connection Broker, and RD Web Access require that the name of the destination server is the same as the name of the source server.  
  
### Other servers and client computers in the enterprise  
Within the domain, if the destination server has the same name as the source server, no preparations are needed on other computers in the deployment.  
  
To migrate Remote Desktop Services role services across domains, RD Session Host, RD Virtualization Host, RD Connection Broker, and RD Web Access must have accounts with permissions to join the new domain.  
  
When you migrate RD Gateway and Remote Desktop license servers across domains, domain trust relationships are required.  
  
## Additional references  
  
-   [Migrate Remote Desktop Services to Windows Server 2012 R2](../Topic/Migrate-Remote-Desktop-Services-to-Windows-Server-2012-R2.md)  
  
-   **You are here in this migration process document \->** Remote Desktop Services: Prepare to Migrate  
  
-   [Remote Desktop Services: Migrate Remote Desktop Services Role Services](../Topic/Remote-Desktop-Services--Migrate-Remote-Desktop-Services-Role-Services.md)  
  
-   [Remote Desktop Services: Verify the Migration](../Topic/Remote-Desktop-Services--Verify-the-Migration.md)  
  
-   [Remote Desktop Services: Post-Migration Tasks](../Topic/Remote-Desktop-Services--Post-Migration-Tasks.md)  
  
-   [Windows Server Migration forum](http://go.microsoft.com/fwlink/?LinkId=247606)  
  
-   [Windows Server Migration Portal](http://technet.microsoft.com/windowsserver/jj554790.aspx)  
  
