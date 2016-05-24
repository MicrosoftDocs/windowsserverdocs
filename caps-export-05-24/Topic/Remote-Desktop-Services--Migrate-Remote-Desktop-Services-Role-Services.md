---
title: Remote Desktop Services: Migrate Remote Desktop Services Role Services
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7748f80c-7c42-497e-87b3-8418b9189713
author: lizap
---
# Remote Desktop Services: Migrate Remote Desktop Services Role Services
Migration for a Remote Desktop Services deployment is supported from source servers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to destination servers running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Migration from any other major or minor releases to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is not supported.  
  
Following are the steps for migrating a Remote Desktop Services deployment:  
  
1.  [Migrate the RD Connection Broker server](../Topic/Remote-Desktop-Services--Migrate-Remote-Desktop-Services-Role-Services.md#BKMK_Connection)  
  
2.  [Migrate session collections](../Topic/Remote-Desktop-Services--Migrate-Remote-Desktop-Services-Role-Services.md#BKMK_Session)  
  
3.  [Migrate virtual desktop collections](../Topic/Remote-Desktop-Services--Migrate-Remote-Desktop-Services-Role-Services.md#BKMK_Virtual)  
  
4.  [Migrate RD Web Access servers](../Topic/Remote-Desktop-Services--Migrate-Remote-Desktop-Services-Role-Services.md#BKMK_RDWeb)  
  
5.  [Migrate RD Gateway servers](../Topic/Remote-Desktop-Services--Migrate-Remote-Desktop-Services-Role-Services.md#BKMK_RDGateway)  
  
6.  [Migrate RD Licensing servers](../Topic/Remote-Desktop-Services--Migrate-Remote-Desktop-Services-Role-Services.md#BKMK_RDLicensing)  
  
7.  [Migrate standalone Remote Desktop Services servers](../Topic/Remote-Desktop-Services--Migrate-Remote-Desktop-Services-Role-Services.md#BKMK_Standalone)  
  
8.  [Migrate certificates](../Topic/Remote-Desktop-Services--Migrate-Remote-Desktop-Services-Role-Services.md#BKMK_Certificates)  
  
## <a name="BKMK_Connection"></a>Migrate the RD Connection Broker server  
This is the first and most important step for migrating to a destination server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
-   The Remote Desktop Connection Broker \(RD Connection Broker\) destination server must be configured for high availability to support migration.  
  
    For more information, see [RD Connection Broker High Availability in Windows Server 2012](http://blogs.msdn.com/b/rds/archive/2012/06/27/rd-connection-broker-high-availability-in-windows-server-2012.aspx).  
  
-   If you have more than one RD Connection Broker server in the high availability setup, remove all the RD Connection Broker servers except the one that is currently active.  
  
-   Upgrade the remaining RD Connection Broker server to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
-   After the server is upgraded, add it to the high availability deployment.  
  
> [!NOTE]  
> A mixed high availability configuration with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is not supported for RD Connection Broker servers.  
>   
> An RD Connection Broker running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] can serve session collections with RD Session Host servers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and it can serve virtual desktop collections with RD Virtualization Host servers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
## <a name="BKMK_Session"></a>Migrate session collections  
Follow these steps to migrate a session collection in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to a session collection in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
> [!IMPORTANT]  
> Migrate session collections only after successfully completing the previous step, [Migrate the RD Connection Broker server](../Topic/Remote-Desktop-Services--Migrate-Remote-Desktop-Services-Role-Services.md#BKMK_Connection).  
  
1.  Upgrade the session collection from [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
2.  Add the new RD Session Host server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to the session collection.  
  
    > [!TIP]  
    > Use drain mode when you are setting the RD Session Host servers. For more information about drain mode, see [Introducing Terminal Services Server Drain Mode](http://blogs.msdn.com/b/rds/archive/2007/06/15/introducing-terminal-services-server-drain-mode.aspx).  
  
3.  Sign out of all sessions in the RD Session Host servers, and remove the servers that require migration from the session collection.  
  
> [!NOTE]  
> If the UVHD template \(UVHD\-template.vhdx\) is enabled in the session collection and the file server has been migrated to a new server, update the **User Profile Disks: Location** collection property with the new path. The User Profile Disks must be available at the same relative path in the new location as they were on the source server.  
>   
> A session collection of RD Session Host servers with a mix of servers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is not supported.  
  
## <a name="BKMK_Virtual"></a>Migrate virtual desktop collections  
Follow these steps to migrate a virtual desktop collection from a source server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to a destination server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
> [!IMPORTANT]  
> Migrate virtual desktop collections only after successfully completing the previous step, [Migrate the RD Connection Broker server](../Topic/Remote-Desktop-Services--Migrate-Remote-Desktop-Services-Role-Services.md#BKMK_Connection).  
  
1.  Upgrade the virtual desktop collection from the server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
2.  Add the new [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] RD Virtualization Host servers to the session collection.  
  
    > [!TIP]  
    > Use drain mode when you set the RD Session Host servers that need to be migrated.  
  
3.  Migrate all virtual machines in the current virtual desktop collection that are running on RD Virtualization Host servers to the new servers.  
  
4.  Remove all RD Virtualization Host servers that required migration from the virtual desktop collection in the source server.  
  
> [!NOTE]  
> If the UVHD template \(UVHD\-template.vhdx\) is enabled in the session collection and the file server has been migrated to a new server, update the **User Profile Disks: Location** collection property with the new path. The User Profile Disks must be available at the same relative path in the new location as they were on the source server.  
>   
> A session collection of RD Session Host servers with a mix of servers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is not supported.  
  
## <a name="BKMK_RDWeb"></a>Migrate RD Web Access servers  
To migrate the RD Web Access servers, see [Remote Desktop Web Access Role Service Migration](http://technet.microsoft.com/library/ff849224(v=ws.10).aspx).  
  
## <a name="BKMK_RDGateway"></a>Migrate RD Gateway servers  
To migrate the RD Gateway Servers, see [Remote Desktop Gateway Role Service Migration](http://technet.microsoft.com/library/ff849225(v=ws.10).aspx).  
  
## <a name="BKMK_RDLicensing"></a>Migrate RD Licensing servers  
Follow these steps to migrate an RD Licensing server from a source server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to a destination server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
1.  Migrate the Remote Desktop Services client access licenses \(RDS CALs\) from the source server to the destination server.  
  
    For more information, see [Migrate Remote Desktop Services Client Access Licenses \(RDS CALs\)](http://technet.microsoft.com/library/dd851844.aspx).  
  
2.  Use the Deployment Properties Wizard to list the new RD Licensing servers on the server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
3.  Remove the RDS CALs from the source RD Licensing server.  
  
    For more information, see [Remove Remote Desktop Services Client Access Licenses](http://technet.microsoft.com/library/dd759244.aspx).  
  
4.  Remove the source RD Licensing servers from the deployment.  
  
## <a name="BKMK_Standalone"></a>Migrate standalone Remote Desktop Services servers  
The following list contains the complete migration guides for each role service. Each guide include information about preparing to migrate, verifying the migration, and post\-migration tasks:  
  
-   [Remote Desktop Session Host Role Service Migration](http://technet.microsoft.com/library/ff849231(v=ws.10).aspx)  
  
-   [Remote Desktop Virtualization Host Role Service Migration](http://technet.microsoft.com/library/ff849258(v=ws.10).aspx)  
  
-   [Remote Desktop Web Access Role Service Migration](http://technet.microsoft.com/library/ff849224(v=ws.10).aspx)  
  
-   [Remote Desktop Licensing Role Service Migration](http://technet.microsoft.com/library/ff849253(v=ws.10).aspx)  
  
-   [Remote Desktop Gateway Role Service Migration](http://technet.microsoft.com/library/ff849225(v=ws.10).aspx)  
  
## <a name="BKMK_Certificates"></a>Migrate certificates  
Migrating certificates simply requires updating certificate information in **Deployment Properties: Manage certificates**  
  
### Remote Desktop Services features that use certificates  
Although this guide does not describe how to migrate Remote Desktop Services features, the following list of features that use certificates is included for reference. Each of the following features uses certificates for at least one role service:  
  
-   Single sign\-on \(SSO\) for RemoteApp and Desktop Connection  
  
-   Web Single Sign\-On \(Web SSO\)  
  
-   HTTPS connections to RD Web Access  
  
-   Digital signing of Remote Desktop Protocol \(.rdp\) files for personal virtual desktops and virtual desktop pools  
  
-   Digital signing of Remote Desktop Protocol files for Remote App programs  
  
-   RD Gateway connections to Remote Desktop Services  
  
-   RD Session Host server connections in a farm configuration  
  
### Preparing certificates for migration  
In most cases, the migration of certificates for Remote Desktop Services requires you to export the certificate with the private key. After export, you should store the certificate in a safe location.  
  
A certificate with a private key can be migrated by using the following steps:  
  
1.  To export the certificate to a PFX file, see [Export a certificate with the private key](http://go.microsoft.com/fwlink/?LinkID=186422).  
  
2.  To import the certificate from a PFX file, see [Import a certificate](http://go.microsoft.com/fwlink/?LinkId=188055).  
  
After you have imported the certificate to the certificate store on the destination server, follow the instructions for configuring the certificate for the specific role service.  
  
## Additional references  
  
-   [Migrate Remote Desktop Services to Windows Server 2012 R2](../Topic/Migrate-Remote-Desktop-Services-to-Windows-Server-2012-R2.md)  
  
-   [Remote Desktop Services: Prepare to Migrate](../Topic/Remote-Desktop-Services--Prepare-to-Migrate.md)  
  
-   **You are here in this migration process document \->**Remote Desktop Services: Migrate Remote Desktop Services Role Services  
  
-   [Remote Desktop Services: Verify the Migration](../Topic/Remote-Desktop-Services--Verify-the-Migration.md)  
  
-   [Remote Desktop Services: Post-Migration Tasks](../Topic/Remote-Desktop-Services--Post-Migration-Tasks.md)  
  
-   [Windows Server Migration forum](http://go.microsoft.com/fwlink/?LinkId=247606)  
  
-   [Windows Server Migration Portal](http://technet.microsoft.com/windowsserver/jj554790.aspx)  
  
