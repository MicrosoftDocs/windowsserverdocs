---
title: Migrate Remote Desktop Services to Windows Server 2016
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d83178fc-962c-4aa1-80b7-ee4b63f2b450
author: lizap
manager: msswadhwa
---
# Migrate Remote Desktop Services to Windows Server 2016

>Applies To: Windows Server Technical Preview

Use the following steps to migrate from Remote Desktop Services on Windows Server 2012 R2 to Windows Server 2016:

- [Migrate the RD Connection Broker server](#migrate-the-rd-connection-broker-server)
- [Migrate session collections](#migrate-session-collections)
- [Migrate virtual desktop collections](#migrate-virtual-desktop-collections)
- [Migrate RD Web Access servers](#migrate-rd-web-access-servers)
- [Migrate RD Gateway servers](#migrate-rd-gateway-servers) 
- [Migrate RD Licensing servers](#migrate-rd-licensing-servers)
- [Migrate standalone Remote Desktop Services servers](#migrate-standalone-remote-desktop-services-servers)
- [Migrate certificates](#migrate-certificates)

## Migrate the RD Connection Broker server
This is the first and most important step for migrating to a destination server running Windows Server 2016.

- The Remote Desktop Connection Broker (RD Connection Broker) destination server must be configured for high availability to support migration. For more information, see RD Connection Broker High Availability in Windows Server 2012.
- If you have more than one RD Connection Broker server in the high availability setup, remove all the RD Connection Broker servers except the one that is currently active.
- Upgrade the remaining RD Connection Broker server to Windows Server 2012 R2.
- After the server is upgraded, add it to the high availability deployment.

> [!NOTE]
> A mixed high availability configuration with Windows Server 2012 and Windows Server 2012 R2 is not supported for RD Connection Broker servers. 

> An RD Connection Broker running Windows Server 2012 R2 can serve session collections with RD Session Host servers running Windows Server 2012, and it can serve virtual desktop collections with RD Virtualization Host servers running Windows Server 2012.

## Migrate session collections
Follow these steps to migrate a session collection in Windows Server 2012 to a session collection in Windows Server 2012 R2.

> [!IMPORTANT]
> Migrate session collections only after successfully completing the previous step, [Migrate the RD Connection Broker server](#migrate-the-rd-connection-broker).

1. Upgrade the session collection from Windows Server 2012 to Windows Server 2012 R2.
2. Add the new RD Session Host server running Windows Server 2012 R2 to the session collection.
   > [!TIP]
   > Use drain mode when you set the RD Session Host servers that need to be migrated.
3. Migrate all virtual machines in the current virtual desktop collection that are running on RD Virtualization Host servers to the new servers. 
4. Remove all RD Virtualization Host servers that required migration from the virtual desktop collection in the source server.

> [!NOTE]
> If the UVHD template (UVHD-template.vhdx) is enabled in the session collection and the file server has been migrated to a new server, update the **User Profile Disks: Location** collection property with the new path. The User Profile Disks must be available at the same relative path in the new location as they were on the source server.

> A session collection of RD Session Host servers with a mix of servers running Windows Server 2012 and Windows Server 2012 R2 is not supported.

## Migrate virtual desktop collections
Follow these steps to migrate a virtual desktop collection from a source server running Windows Server 2012 to a destination server running Windows Server 2012 R2.

> [!IMPORTANT]
> Migrate virtual desktop collections only after successfully completing the previous step, [Migrate the RD Connection Broker server](#migrate-the-rd-connection-broker-server).

1. Upgrade the virtual desktop collection from the server running Windows Server 2012 to Windows Server 2012 R2.
2. Add the new Windows Server 2012 R2 RD Virtualization Host servers to the session collection.
   > [!TIP]
   > Use drain mode when you set the RD Session Host servers that need to be migrated.
3. Migrate all virtual machines in the current virtual desktop collection that are running on RD Virtualization Host servers to the new servers. 
4. Remove all RD Virtualization Host servers that required migration from the virtual desktop collection in the source server.

> [!NOTE]
> If the UVHD template (UVHD-template.vhdx) is enabled in the session collection and the file server has been migrated to a new server, update the **User Profile Disks: Location** collection property with the new path. The User Profile Disks must be available at the same relative path in the new location as they were on the source server.

> A session collection of RD Session Host servers with a mix of servers running Windows Server 2012 and Windows Server 2012 R2 is not supported.

## Migrate RD Web Access servers
<!---Christian - I don't know if we need this information - this references a 2008 article: [RD Web Access Migration: Migrating the RD Web Access Role Service](https://technet.microsoft.com/en-us/library/ff849264(v=ws.10).aspx). If we do need it, let me know. I can add the steps here, or create another article to hold it. -->

## Migrate RD Gateway servers
<!--- Christian - Again, this section references a 2008 article, https://technet.microsoft.com/en-us/library/ff849244(v=ws.10).aspx That links off the a TS Gateway Manager tool. I imagine, at the very least, we're not still calling it that.-->

## Migrate RD Licensing servers
Follow these steps to migrate an RD Licensing server from a source server running Windows Server 2012 or Windows Server 2012 R2 to a destination server running Windows Server 2012 R2.

1. Migrate the Remote Desktop Services client access licenses (RDS CALs) from the source server to the destination server.

For more information, see [Migrate Remote Desktop Services Client Access Licenses (RDS CALs)](https://technet.microsoft.com/library/dd851844.aspx).
<!-- Christian - this links to 3 different ways to do this, pick one and I'll import the content. -->

2. Use the Deployment Properties Wizard to list the new RD Licensing servers on the server running Windows Server 2012 R2.
3. Remove the RDS CALs from the source RD Licensing server.

For more information, see [Remove Remote Desktop Services Client Access Licenses](https://technet.microsoft.com/library/dd759244.aspx).
<!-- Christian, this doesn't actually really tell you how to remove the license, I don't think. Check it out. -->

4. Remove the source RD Licensing servers from the deployment.

## Migrate standalone Remote Desktop Services servers
The following list contains the complete migration guides for each role service. Each guide include information about preparing to migrate, verifying the migration, and post-migration tasks:

<!-- Again, these are all WS 2008 links. -->
- [Remote Desktop Session Host Role Service Migration](https://technet.microsoft.com/library/ff849231(v=ws.10).aspx) 
- [Remote Desktop Virtualization Host Role Service Migration](https://technet.microsoft.com/library/ff849258(v=ws.10).aspx) 
- [Remote Desktop Web Access Role Service Migration](https://technet.microsoft.com/library/ff849224(v=ws.10).aspx) 
- [Remote Desktop Licensing Role Service Migration](https://technet.microsoft.com/library/ff849253(v=ws.10).aspx) 
- [Remote Desktop Gateway Role Service Migration](https://technet.microsoft.com/library/ff849225(v=ws.10).aspx) 

## Migrate certificates
Migrating certificates simply requires updating certificate information in **Deployment Properties: Manage certificates**.

### Remote Desktop Services features that use certificates
The following Remote Desktop SErvices features use certificates:

- Single sign-on (SSO) for RemoteApp and Desktop Connection
- Web Single Sign-On (Web SSO)
- HTTPS connections to RD Web Access
- Digital signing of Remote Desktop Protocol (.rdp) files for personal virtual desktops and virtual desktop pools
- Digital signing of Remote Desktop Protocol files for Remote App programs
- RD Gateway connections to Remote Desktop Services
- RD Session Host server connections in a farm configuration

### Preparing certificates for migration
In most cases, the migration of certificates for Remote Desktop Services requires you to export the certificate with the private key. After export, you should store the certificate in a safe location.

A certificate with a private key can be migrated by using the following steps:
<!-- All WS2008 links -->
1. To export the certificate to a PFX file, see [Export a certificate with the private key](https://technet.microsoft.com/library/cc754329.aspx).
2. To import the certificate from a PFX file, see [Import a certificate](https://technet.microsoft.com/library/cc754489.aspx).

After you have imported the certificate to the certificate store on the destination server, follow the instructions for configuring the certificate for the specific role service.