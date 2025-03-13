---
title: Migrate DHCP server to Windows Server
description: This article serves as a guide for how to migrate a Dynamic Host Configuration Protocol (DHCP) in Windows Server.
ms.topic: how-to
ms.author: mosagie
author: meaghanlewis
ms.date: 03/12/2025
---

# Migrate DHCP server

DHCP server role migration involves moving the settings for your existing DHCP server to a new DHCP server on the network. The goal of this server migration is to install the DHCP server role on the Windows Server operating system so that it provides DHCP leases on a network without any perceptible change to DHCP client computers.

## About this guide

This guide describes the steps for migrating existing DHCP server settings to a server that is running Windows Server. Migration documentation and tools ease the migration of server role settings and data from an existing server to a destination server that is running Windows Server. By using the tools that are described in this guide to migrate a DHCP server, you can simplify migration, reduce migration time, increase the accuracy of the migration process, and help eliminate possible conflicts that might otherwise occur during DHCP migration.

This guide is intended for information technology (IT) administrators, IT professionals, and other knowledge workers who are responsible for the operation and deployment of DHCP servers in a managed environment.

This guide gives you the instructions to migrate an existing DHCP server to a server that is running Windows Server 2012 R2. This guide does not contain instructions for migration when the source server is running multiple roles. If your server is running multiple roles, we recommend that you design a custom migration procedure specific to your server environment based on the information provided in other role migration guides. Migration guides for additional roles are available on the Windows Server 2012 TechCenter (https://technet.microsoft.com/library/jj134039.aspx).

>[!WARNING]
>If the source server is running multiple roles, some migration steps in this guide, such as those for computer name, and IP configuration, can cause other roles that are running on the source server to fail.

This guide provides instructions only for migrating DHCP data and settings from a server that is being replaced by an x64-based server running Windows Server 2012 or later.

Migrations between physical operating systems and virtual operating systems are supported.

Migration from a source server to a destination server that is running an operating system in a different system user interface (UI) language than the source server is not supported.

We recommend migration rather than an upgrade even when the hardware is native x64-based. For example, with a server role split, a scenario in which the source server has more than one server role, because of increased use of this server you might decide to separate the roles onto several additional x64-based servers. In this case, migrating (not upgrading) individual server roles to other servers may be the best solution.

The server administrator can choose which components of an existing installation to migrate; together with the server role, these components usually include configuration, data, system identity, and operating system settings.

## Supported role configurations

You can migrate all DHCP Server settings by using this guide, including registry and database settings.

>[!NOTE]
>If you're migrating a DHCP server in a cluster configuration, see Migrating DHCP to a Cluster Running Windows Server 2008 R2 Step-by-Step Guide (https://go.microsoft.com/fwlink/?LinkId=140512) on the Windows Server TechCenter. Also see Migrate to DHCP Failover. DHCP failover is a new option for DHCP high availability, introduced in Windows Server 2012.

## DHCP Server migration overview

DHCP Server migration is divided into the following major sections:

DHCP Server Migration: Preparing to Migrate

DHCP Server Migration: Migrating the DHCP Server Role

DHCP Server Migration: Verifying the Migration

DHCP Server Migration: Post-Migration Tasks