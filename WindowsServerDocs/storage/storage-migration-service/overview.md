---
Title: Storage Migration Service overview
description: Storage Migration Service makes it easier to migrate servers to a newer version of Windows Server. It provides a graphical tool that inventories data on servers and then transfers the data and configuration to newer servers—all without apps or users having to change anything.
author: jasongerend
ms.author: jgerend
manager: elizapo
ms.date: 05/21/2019
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: storage
---
# Storage Migration Service overview

>Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server (Semi-Annual Channel)

Storage Migration Service makes it easier to migrate servers to a newer version of Windows Server. It provides a graphical tool that inventories data on servers and then transfers the data and configuration to newer servers—all without apps or users having to change anything.

This topic discusses why you'd want to use Storage Migration Service, how the migration process works, and what the requirements are for source and destination servers.

## Why use Storage Migration Service

Use Storage Migration Service because you've got a server (or a lot of servers) that you want to migrate to newer hardware or virtual machines. Storage Migration Service is designed to help by doing the following:

- Inventory multiple servers and their data
- Rapidly transfer files, file shares, and security configuration from the source servers
- Optionally take over the identity of the source servers (also known as cutting over) so that users and apps don't have to change anything to access existing data
- Manage one or multiple migrations from the Windows Admin Center user interface

![Diagram showing Storage Migration Service migrating files & configuration from source servers to destination servers, Azure VMs, or Azure File Sync.](media/overview/storage-migration-service-diagram.png)

**Figure 1: Storage Migration Service sources and destinations**

## How the migration process works

Migration is a three-step process:

1. **Inventory servers** to gather info about their files and configuration (shown in Figure 2).
2. **Transfer (copy) data** from the source servers to the destination servers.
3. **Cut over to the new servers** (optional).<br>The destination servers assume the source servers' former identities so that apps and users don't have to change anything. <br>The source servers enter a maintenance state where they still contain the same files they always have (we never remove files from the source servers) but are unavailable to users and apps. You can then decommission the servers at your convenience.

![Screenshot showing a server ready to be scanned](media/migrate/inventory.png)
**Figure 2: Storage Migration Service inventorying servers**

## Requirements

To use Storage Migration Service, you need the following:

- A **source server** to migrate files and data from
- A **destination server** running Windows Server 2019 to migrate to—Windows Server 2016 and Windows Server 2012 R2 work as well but are around 50% slower
- An **orchestrator server** running Windows Server 2019 to manage the migration  <br>If you're migrating only a few servers and one of the servers is running Windows Server 2019, you can use that as the orchestrator. If you're migrating more servers, we recommend using a separate orchestrator server.
- A **PC or server running [Windows Admin Center](../../manage/windows-admin-center/understand/windows-admin-center.md)** to run the Storage Migration Service user interface, unless you prefer using PowerShell to manage the migration. The Windows Admin Center and Windows Server 2019 version must both be at least version 1809.

We strongly recommend that the orchestrator and destination computers have at least two cores or two vCPUs, and at least 2 GB of memory. Inventory and transfer operations are significantly faster with more processors and memory.

### Security requirements

- A migration account that is an administrator on the source computers and the orchestrator computer.
- A migration account that is an administrator on the destination computers and the orchestrator computer.
- The orchestrator computer must have the File and Printer Sharing (SMB-In) firewall rule enabled *inbound*.
- The source and destination computers must have the following firewall rules enabled *inbound* (though you might already have them enabled):
  - File and Printer Sharing (SMB-In)
  - Netlogon Service (NP-In)
  - Windows Management Instrumentation (DCOM-In)
  - Windows Management Instrumentation (WMI-In)
  
  > [!TIP]
  > Installing the Storage Migration Service Proxy service on a Windows Server 2019 computer automatically opens the necessary firewall ports on that computer.
- If the computers belong to an Active Directory Domain Services domain, they should all belong to the same forest. The destination server must also be in the same domain as the source server if you want to transfer the source's domain name to the destination when cutting over. Cutover technically works across domains, but the fully-qualified domain name of the destination will be different from the source...

### Requirements for source servers

The source server must run one of the following operating systems:

- Windows Server, Semi-Annual Channel
- Windows Server 2019
- Windows Server 2016
- Windows Server 2012 R2
- Windows Server 2012
- Windows Server 2008 R2
- Windows Server 2008
- Windows Server 2003 R2
- Windows Server 2003

If the orchestrator is running Windows Server, version 1903 or later, you can migrate the following additional source types:

- Failover clusters
- Linux servers that use Samba. We've tested the following:
    - RedHat Enterprise Linux 7.6, CentOS 7, Debian 8, Ubuntu 16.04 and 12.04.5, SUSE Linux Enterprise Server (SLES) 11 SP4
    - Samba 4.x, 3.6.x

### Requirements for destination servers

The destination server must run one of the following operating systems:

- Windows Server, Semi-Annual Channel
- Windows Server 2019
- Windows Server 2016
- Windows Server 2012 R2

> [!TIP]
> Destination servers running Windows Server 2019 or Windows Server, Semi-Annual Channel version 1809 or later have double the transfer performance of earlier versions of Windows Server. This performance boost is due to the inclusion of a built-in Storage Migration Service proxy service, which also opens the necessary firewall ports if they're not already open.

## What's new in Storage Migration Service

Windows Server, version 1903 adds the following new features, when run on the orchestrator server:

- Migrate local users and groups to the new server
- Migrate storage from failover clusters
- Migrate storage from a Linux server that uses Samba
- More easily sync migrated shares into Azure by using Azure File Sync
- Migrate to new networks such as Azure

## See also

- [Migrate a file server by using Storage Migration Service](migrate-data.md)
- [Storage Migration Services frequently asked questions (FAQ)](faq.md)
- [Storage Migration Service known issues](known-issues.md)
