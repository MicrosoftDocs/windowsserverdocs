---
title: Migrate your Remote Desktop Services deployment to Windows Server 2016
description: This article describes how to migrate your Remote Desktop Services deployment to new Windows Server 2016 servers.
ms.custom: na
ms.prod: windows-server
msreviewer:
nams.suite:
nams.technology: remote-desktop-services
ms.author: chrimo
ms.date: 11/01/2016
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9b1fa833-4325-48a8-bf34-46265f40c001
author: christianmontoya
manager: scottman
---
# Migrate your Remote Desktop Services deployment to Windows Server 2016

If you are currently running Remote Desktop Services in Windows Server 2012 R2, you can move to Windows Server 2016 to take advantage of new features like support for Azure SQL and Storage Spaces Direct.

Migration for a Remote Desktop Services deployment is supported from source servers running Windows Server 2016 to destination servers running Windows Server 2016. In other words, there is no direct in-place migration from RDS in Windows Server 2012 R2 to Windows Server 2016. Instead, for most of the RDS components, you first upgrade to Windows Server 2016 and then migrate data and licenses. The only components with a direct migration are RD Web, RD Gateway, and the licensing server.

For more information on the upgrade process and requirements, see [upgrading your Remote Desktop Services deployments to Windows Server 2016](upgrade-to-rds-2016.md).

Use the following steps to migrate your Remote Desktop Services deployment:

- [Migrate RD Connection Broker servers](#migrate-rdconnection-broker-servers)

- [Migrate session collections](#migrate-session-collections)

- [Migrate virtual desktop collections](#migrate-virtual-desktop-collections)

- [Migrate RD Web Access servers](#migrate-rdweb-access-servers)

- [Migrate RD Gateway servers](#migrate-rdgateway-servers)

- [Migrate RD Licensing servers](#migrate-rdgateway-servers)

- [Migrate certificates](#migrate-certificates)

## Migrate RD Connection Broker servers

This is the first and most important step for migrating: migrating your RD Connection Brokers to destination servers running Windows Server 2016.

> [!IMPORTANT]
> The Remote Desktop Connection Broker (RD Connection Broker) source servers must be configured for high availability to support migration. For more information, see [Deploy a Remote Desktop Connection Broker cluster](Deploy-a-Remote-Desktop-Connection-Broker-cluster.md).

1. If you have more than one RD Connection Broker server in the high availability setup, remove all the RD Connection Broker servers except the one that is currently active.

2. [Upgrade](upgrade-to-rds-2016.md) the remaining RD Connection Broker server in the deployment to Windows Server 2016.

3. Add Windows Server 2016 RD Connection Broker servers into the high availability deployment.

> [!NOTE] 
> A mixed high availability configuration with Windows Server 2016 and Windows Server 2012 R2 is not supported for RD Connection Broker servers. 
> An RD Connection Broker running Windows Server 2016 can serve session collections with RD Session Host servers running Windows Server 2012 R2, and it can serve virtual desktop collections with RD Virtualization Host servers running Windows Server 2012 R2.

## Migrate session collections

Follow these steps to migrate a session collection in Windows Server 2012 R2 to a session collection in Windows Server 2016.

> [!IMPORTANT]
> Migrate session collections only after successfully completing the previous step, [Migrate RD Connection Broker servers](#migrate-rdconnection-broker-servers).

1. [Upgrade the session collection](Upgrade-to-RDSH-2016.md) from Windows Server 2012 R2 to Windows Server 2016.

2. Add the new RD Session Host server running Windows Server 2016 to the session collection.

3. Sign out of all sessions in the RD Session Host servers, and remove the servers that require migration from the session collection.

   > [!NOTE]
   > If the UVHD template (UVHD-template.vhdx) is enabled in the session collection and the file server has been migrated to a new server, update the User Profile Disks: Location collection property with the new path. The User Profile Disks must be available at the same relative path in the new location as they were on the source server.
   >
   > A session collection of RD Session Host servers with a mix of servers running Windows Server 2012 R2 and Windows Server 2016 is not supported.

## Migrate virtual desktop collections

Follow these steps to migrate a virtual desktop collection from a source server running Windows Server 2012 R2 to a destination server running Windows Server 2016.

> [!IMPORTANT]
> Migrate virtual desktop collections only after successfully completing the previous step, [Migrate RD Connection Broker servers](#migrate-rdconnection-broker-servers).

1. [Upgrade the virtual desktop collection](Upgrade-to-RDVH-2016.md) from the server running Windows Server 2012 R2 to Windows Server 2016.

2. Add the new Windows Server 2016 RD Virtualization Host servers to the virtual desktop collection.

3. Migrate all virtual machines in the current virtual desktop collection that are running on RD Virtualization Host servers to the new servers.

4. Remove all RD Virtualization Host servers that required migration from the virtual desktop collection in the source server.

> [!NOTE]
> If the UVHD template (UVHD-template.vhdx) is enabled in the session collection and the file server has been migrated to a new server, update the User Profile Disks: Location collection property with the new path. The User Profile Disks must be available at the same relative path in the new location as they were on the source server.
>
> A virtual desktop collection of RD Virtualization Host servers with a mix of servers running Windows Server 2012 R2 and Windows Server 2016 is not supported.

## Migrate RD Web Access servers

Follow these steps to migrate RD Web Access servers:

- Join the destination servers running Windows Server 2016 to the Remote Desktop Services deployment and install the RD Web role

- Use [IIS Web Deploy tool](https://www.iis.net/) to migrate the RD Web website settings from the current RD Web Access servers to the destination servers running Windows Server 2016.

- [Migrate certificates](#migrate-certificates) to the destination servers running Windows Server 2016.

- Remove the source servers from the Remote Desktop Services deployment.

## Migrate RD Gateway servers

Follow these steps to migrate RD Gateway servers:

- Join the destination servers running Windows Server 2016 to the Remote Desktop Services deployment and install the RD Gateway role

- Use [IIS Web Deploy tool](https://www.iis.net/) to migrate the RD Gateway endpoint settings from the current RD Gateway servers to the destination servers running Windows Server 2016.

- [Migrate certificates](#migrate-certificates) to the destination servers running Windows Server 2016.

- Remove the source servers from the Remote Desktop Services deployment.

## Migrate RD Licensing servers

Follow these steps to migrate an RD Licensing server from a source server running Windows Server 2012 or Windows Server 2012 R2 to a destination server running Windows Server 2016.

1. [Migrate the Remote Desktop Services client access licenses (RDS CALs)](migrate-rds-cals.md) from the source server to the destination server.

2. Edit the **Deployment Properties** in **Server Manager** on the Remote Desktop management server (which is typically being run on the first RD Connection Broker server) to include only the new RD Licensing servers running Windows Server 2016.

3. Deactivate the source RD Licensing server: In **Remote Desktop Licensing Manager**, right-click the appropriate server, hover over **Advanced** to select **Deactivate Server**, and then follow the steps in the wizard.

4. Remove the source RD Licensing servers from the deployment in **Server Manager** on the Remote Desktop management server.

## Migrate certificates

Successful certificate migration requires both the actual process of migrating certificates and updating certificate information in the Remote Desktop Services Deployment Properties.

Typical certificate migration includes the following steps:

- Export the certificate to a PFX file with the private key.

- Import the certificate from a PFX file.

After migrating the appropriate certificates, update the following required certificates for the Remote Desktop Services deployment in server manager or PowerShell:

- RD Connection Broker - single sign-on

- RD Connection Broker - RDP file publishing

- RD Gateway - HTTPS connection

- RD Web Access - HTTPS connection and RemoteApp/desktop connection subscription
