---
Title: Storage Migration Service overview
description: Brief description of topic for search engine results
author: jasongerend
ms.author: jgerend
manager: elizapo
ms.date: 09/24/2018
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: storage
---

# Storage Migration Service overview

Storage Migration Service makes it easier to migrate servers to a newer version of Windows Server. It provides a graphical tool that inventories data on servers and then transfers the data and configuration to newer servers--all without apps or users having to change anything.

This topic discusses why you'd want to use Storage Migration Service, how the migration process works, and what the requirements are for source and destination servers.

## Why use Storage Migration Service

Use Storage Migration Service because you've got a server--or a lot of servers--that you want to migrate to newer hardware (or virtual machines). Storage Migration Service is designed to help by doing the following:

- Inventory multiple servers and their data
- Rapidly transfer files, file shares, and security configuration from the source servers
- Optionally take over the identity of the source servers (also known as cutting over) so that users and apps don't have to change anything to access existing data
- Manage one or multiple migrations from the Windows Admin Center user interface

![Migrate files & configuration from source servers to destination servers, Azure VMs, or Azure File Sync.](media\overview\storage-migration-service-diagram.png)

## How the migration process works

Migration is a three-step process:

1. **Inventory servers** to gather info about their files and configuration.
2. **Transfer data** from the source devices to the destination servers.
3. **Cut over to the new servers** (optional)<br>The destination servers assume the source servers' former identities so that apps and users don't have to change anything. <br>The source servers enter a maintenance state where they're unavailable to users and apps, and can be decommissioned at your convenience.

**[Screenshot showing Inventory phase]**

## Requirements

To use Storage Migration Service, you need the following:

- A **source server** (migrate files and data from this server)
- A **destination server** running Windows Server 2012 R2 or newer (migrate to this server)
- An optional **orchestrator server** to manage the migration. <br>If one of the other servers is running Windows Server 2019, you can use that as the orchestrator, though if you're doing a lot of migrations, you might want a separate orchestrator server.
- A **PC or server running [Windows Admin Center](../../manage/windows-admin-center/understand/windows-admin-center.md)** to run the Storage Migration Service user interface, unless you prefer using PowerShell to manage the migration.

### Security requirements

- All computers must belong to an Active Directory Domain Services domain
- You must provide a migration account that is an administrator on the source computers
- You must provide a migration account that is an administrator on selected destination computers
- The following firewall rules must be enabled INBOUND on source and destination computers:
  - “File and Printer Sharing (SMB-In)”
  - “Netlogon Service (NP-In)”
  - “Windows Management Instrumentation (DCOM-In)”
  - “Windows Management Instrumentation (WMI-In)”

### Requirements for source servers

The source server must run one of the following operating systems:

- Windows Server 2019
- Windows Server 2016
- Windows Server 2012 R2
- Windows Server 2012
- Windows Server 2008 R2
- Windows Server 2008
- Windows Server 2003

### Requirements for destination servers

The destination server must run one of the following operating systems:

- Windows Server 2019
- Windows Server 2016
- Windows Server 2012 R2

> [!TIP]
> Destination servers running Windows Server 2019 have double the transfer performance of earlier versions of Windows Server. This performance boost is due to the inclusion of a built-in Storage Migration Service proxy service, which also opens the necessary firewall ports if they're not already open.

## See also