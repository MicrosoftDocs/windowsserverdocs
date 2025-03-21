---
title: Migrate DHCP server to Windows Server
description: This article serves as a guide for how to migrate a Dynamic Host Configuration Protocol (DHCP) in Windows Server.
ms.topic: how-to
ms.author: mosagie
author: meaghanlewis
ms.date: 03/12/2025
#customer intent: As an IT administrator, I want to migrate a DHCP server to Windows Server so that I can ensure seamless network configuration and management.
---

# Migrate DHCP server

DHCP server role migration involves moving the settings for your existing DHCP server to a new DHCP server on the network. The goal of this server migration is to install the DHCP server role on the Windows Server operating system so that it provides DHCP leases on a network without any perceptible change to DHCP client computers.

This guide describes the steps for migrating existing DHCP server settings to a server that is running Windows Server. Migration documentation and tools ease the migration of server role settings and data from an existing server to a destination server that is running Windows Server. By using the tools that are described in this guide to migrate a DHCP server, you can simplify migration, reduce migration time, increase the accuracy of the migration process, and help eliminate possible conflicts that might otherwise occur during DHCP migration. This guide does not contain instructions for migration when the source server is running multiple roles. If your server is running multiple roles, we recommend that you design a custom migration procedure specific to your server environment. Some notes about migration:

- Migrations between physical operating systems and virtual operating systems are supported.

- Migration from a source server to a destination server that is running an operating system in a different system user interface (UI) language than the source server isn't supported.

- We recommend migration rather than an upgrade even when the hardware is native x64-based.

This guide is intended for IT administrators, IT professionals, and other knowledge workers who are responsible for the operation and deployment of DHCP servers in a managed environment. The server administrator can choose which components of an existing installation to migrate; together with the server role, these components usually include configuration, data, system identity, and operating system settings.

## Prerequisites

- An existing DHCP server that is set up and running
- The following permissions are required on the source server and the destination server:
  - Domain administrative rights that are required to authorize DHCP Server.
  - Local administrative rights are required to install or manage DHCP Server.
  - Write permissions are required to the migration store location.

## Server migration process

DHCP Server migration is divided into the following major sections:

- Prepare to migrate
- Migrate the DHCP Server Role
- Verify the migration
- Post-migration tasks

As shown in the following illustration, the pre-migration process involves the manual collection of data, followed by procedures on the destination and source servers. The migration process includes source and destination server procedures that use the Export and Import cmdlets to automatically collect, store, and then migrate server role settings. Post-migration procedures include verifying that the destination server successfully replaced the source server and then retiring or repurposing the source server. If the verification procedure indicates that the migration failed, troubleshooting begins. If troubleshooting fails, rollback instructions are provided to return to the use of the original source server.

![Illustration of the server migration process, showing pre-migration, migration, and post-migration steps.](media/server-migration-process.jpeg)

## Server migration overview

DHCP Server migration is divided into the following major sections:

- Prepare to migrate
- Migrate the DHCP Server Role
- Verify the migration
- Post-migration tasks

## Prepare to migrate

