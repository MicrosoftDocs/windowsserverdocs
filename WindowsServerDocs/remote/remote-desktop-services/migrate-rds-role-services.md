---
title: Migrate your Remote Desktop Services deployment
description: This article describes how to migrate your Remote Desktop Services deployment to the newest Windows Server version.
ms.author: daknappe
ms.date: 7/3/2024
ms.topic: upgrade-and-migration-article
author: dknappettmsft
---
# Migrate your Remote Desktop Services deployment to a newer Windows Server version

Migration of a Remote Desktop Services deployment is supported from source servers running a Windows Server version to destination servers running the same Windows Server version. For example, from Windows Server 2025 to Windows Server 2025. Meaning, there is no direct in-place migration from RDS in an earlier version of Windows Server to a later Windows Server version. Instead, you need to upgrade most RDS components first to a later Windows Server version, then migrate data and licenses. The only components that support a direct migration are RD Web, RD Gateway, and the licensing server.

For more information on the upgrade process and requirements, see [upgrading your Remote Desktop Services deployments](./upgrade-to-rds.md).

Use the following steps to migrate your Remote Desktop Services deployment:

  - [Migrate RD Connection Broker servers](#migrate-rdconnection-broker-servers)
  - [Migrate session collections](#migrate-session-collections)
  - [Migrate virtual desktop collections](#migrate-virtual-desktop-collections)
  - [Migrate RD Web Access servers](#migrate-rdweb-access-servers)
  - [Migrate RD Gateway servers](#migrate-rdgateway-servers)
  - [Migrate RD Licensing servers](#migrate-rdlicensing-servers)
  - [Migrate certificates](#migrate-certificates)

## Migrate RD Connection Broker servers

This is the first and most important step for migrating: migrating your RD Connection Brokers to destination servers running the latest version of Windows Server.

> [!IMPORTANT]
> The Remote Desktop Connection Broker (RD Connection Broker) source servers must be configured for high availability to support migration. For more information, see [Deploy a Remote Desktop Connection Broker cluster](./rds-connection-broker-cluster.md).

1. If you have more than one RD Connection Broker server in the high availability setup, remove all the RD Connection Broker servers except the one that is currently active.

1. [Upgrade](./upgrade-to-rds.md) the remaining RD Connection Broker server in the deployment to a later Windows Server version.

1. Add the new Windows Server version RD Connection Broker servers into the high availability deployment.

> [!NOTE]
> - A mixed high availability configuration with different versions of Windows Server is not supported for RD Connection Broker servers.
> - An RD Connection Broker running a newer version of Windows Server can serve session collections with RD Session Host servers running a previous version of Windows Server, and it can serve virtual desktop collections with RD Virtualization Host servers running a previous version of Windows Server.

## Migrate session collections

Follow these steps to migrate a session collection in an earlier version of Windows Server to a session collection in a later version of Windows Server.

> [!IMPORTANT]
> Migrate session collections only after successfully completing the previous step, [Migrate RD Connection Broker servers](#migrate-rdconnection-broker-servers).

1. [Upgrade the session collection](./upgrade-to-rdsh.md) to a later version of Windows Server.

1. Add the new RD Session Host server running the new Windows Server version to the session collection.

1. Sign out of all sessions in the RD Session Host servers, and remove the servers that require migration from the session collection.

   > [!NOTE]
   > If the UVHD template (UVHD-template.vhdx) is enabled in the session collection and the file server has been migrated to a new server, update the User Profile Disks: Location collection property with the new path. The User Profile Disks must be available at the same relative path in the new location as they were on the source server.
   >
   > A session collection of RD Session Host servers with a mix of Windows Server versions isn't supported.

## Migrate virtual desktop collections

Follow these steps to migrate a virtual desktop collection from a source server running the earlier version of Windows Server to a destination server running a later version of Windows Server.

> [!IMPORTANT]
> Migrate virtual desktop collections only after successfully completing the previous step, [Migrate RD Connection Broker servers](#migrate-rdconnection-broker-servers).

1. [Upgrade the virtual desktop collection](./upgrade-to-rdvh.md) from the server running the earlier version of Windows Server to a later version of Windows Server.

1. Add the new Windows Server version RD Virtualization Host servers to the virtual desktop collection.

1. Migrate all virtual machines in the current virtual desktop collection that are running on RD Virtualization Host servers to the new servers.

1. Remove all RD Virtualization Host servers that required migration from the virtual desktop collection in the source server.

> [!NOTE]
> If the UVHD template (UVHD-template.vhdx) is enabled in the session collection and the file server has been migrated to a new server, update the User Profile Disks: Location collection property with the new path. The User Profile Disks must be available at the same relative path in the new location as they were on the source server.
>
> A virtual desktop collection of RD Virtualization Host servers with a mix of servers running earlier versions of Windows Server and later versions of Windows Server is not supported.

## Migrate RD Web Access servers

Follow these steps to migrate RD Web Access servers:

1. Join the destination servers running the new version of Windows Server to the Remote Desktop Services deployment and install the RD Web role

1. Use [IIS Web Deploy tool](https://www.iis.net/) to migrate the RD Web website settings from the current RD Web Access servers to the destination servers running the new version of Windows Server.

1. [Migrate certificates](#migrate-certificates) to the destination servers running the new version of Windows Server.

1. Remove the source servers from the Remote Desktop Services deployment.

## Migrate RD Gateway servers

Follow these steps to migrate RD Gateway servers:

1. Join the destination servers running the new version of Windows Server to the Remote Desktop Services deployment and install the RD Gateway role

1. Use the [IIS Web Deploy tool](https://www.iis.net/) to migrate the RD Gateway endpoint settings from the current RD Gateway servers to the destination servers running the new version of Windows Server.

1. [Migrate certificates](#migrate-certificates) to the destination servers running the new version of Windows Server.

1. Remove the source servers from the Remote Desktop Services deployment.

## Migrate RD Licensing servers

Follow these steps to migrate an RD Licensing server from a source server running an earlier version of Windows Server to a destination server running a later version Windows Server.

1. [Migrate the Remote Desktop Services client access licenses (RDS CALs)](migrate-rds-cals.md) from the source server to the destination server.

1. Edit the **Deployment Properties** in **Server Manager** on the Remote Desktop management server (which is typically being run on the first RD Connection Broker server) to include only the new RD Licensing servers running the new version of Windows Server.

1. Deactivate the source RD Licensing server: In **Remote Desktop Licensing Manager**, right-click the appropriate server, hover over **Advanced** to select **Deactivate Server**, and then follow the steps in the wizard.

1. Remove the source RD Licensing servers from the deployment in **Server Manager** on the Remote Desktop management server.

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
