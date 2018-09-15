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

Storage Migration Service is a technology included with Windows Server that enables you to migrate servers and data without apps or users having to change anything. 

This topic discusses why you'd want to use Storage Migration Service, how the migration process works, and what the requirements are for source and destination servers.

## Why use Storage Migration Service

Use Storage Migration Service because you've got a server--or a lot of servers--that you have to migrate. Storage Migration Service is designed to help with this migration process by doing the following:

- Rapidly transfer files, file shares, and security configuration
- Manage one or multiple migrations from the Windows Admin Center user interface
- Optionally take over the identity of the source server so that users and apps don't have to change anything to access existing data


![Migrate files & configuration from source servers to destination servers, Azure VMs, or Azure File Sync.](media\overview\storage-migration-service-diagram.png)

## How the migration process works

Storage Migration Service migrates files and configurations in three steps:

1.  **Inventory devices** to gather info about their files and configuration

2.  **Transfer data** from the source devices to the destination servers

3.  **Cut over to the new servers** (optional)<br>These destination servers assume the source servers' former identities so that apps and users don't have to change anything. <br>The source servers enter a maintenance state where they're unavailable to users and apps, and can be decommisioned at your convenience.

## Requirements

To use Storage Migration Service, you need the following:

- A **source server** (migrate files and data from this server)
- A **destination server** running Windows Server 2012 R2 or newer (migrate to this server)
- An optional **orchestrator server** to manage the migration.<br>If one of the other servers is running Windows Server 2019, you can use that as the orchestrator, though if you're doing a lot of migrations, you might want a separate orchestrator server.
- A **PC or server running [Windows Admin Center](../../manage/windows-admin-center/understand/windows-admin-center.md)** to run the Storage Migration Service user interface, unless you prefer using PowerShell to manage the migration.

To use Storage Migration Service, you'll need at least two servers:

- A source server (migrate files and data from this server)
- A destination server (migrate to this server)

If neither of these servers are running Windows Server 2019, you also need a server running Windows Server 2019 to manage (orchestrate) the migration. You might also want a seperate server to use to manage the migration if you're going to do a lot of migrations.

You'll also probably want a PC or server running [Windows Admin Center](../../manage/windows-admin-center/understand/windows-admin-center.md), unless you prefer using PowerShell to manage the migration.

### Security requirements

-   All computers must be joined to an Active Directory Domain Services domain
-   You must provide a migration account that is an administrator on selected source computers
-   You must provide a migration account that is an administrator on selected destination computers
-   The following firewall rules must be enabled INBOUND on source and destination computers:
    -   “File and Printer Sharing (SMB-In)”
    -   “Netlogon Service (NP-In)”
    -   “Windows Management Instrumentation (DCOM-In)”
    -   “Windows Management Instrumentation (WMI-In)”

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
> Destination servers running Windows Server 2019 have double the transfer performance of earlier versions of Windows Server. This performance boost is due to the inclusion of a built-in Storage Migration Service proxy service.

## What’s new?


## See also

