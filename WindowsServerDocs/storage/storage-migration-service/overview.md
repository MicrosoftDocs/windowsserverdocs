---
title: Storage Migration Service overview
description: Storage Migration Service makes it easier to migrate storage to Windows Server or to Azure. It provides a graphical tool that inventories data on Windows, Linux, and NetApp CIFS servers and then transfers the data to newer servers or to Azure virtual machines. Storage Migration Service also provides the option to transfer the identity of a server to the destination server so that apps and users can access their data without changing links or paths.
author: jasongerend
ms.author: jgerend
manager: elizapo
ms.date: 03/25/2021
ms.topic: article
---

# Storage Migration Service overview

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

Storage Migration Service makes it easier to migrate storage to Windows Server or to Azure. It provides a graphical tool that inventories data on Windows, Linux, and NetApp CIFS servers and then transfers the data to newer servers or to Azure virtual machines. Storage Migration Service also provides the option to transfer the identity of a server to the destination server so that apps and users can access their data without changing links or paths.

This article discusses the following Storage Migration Service aspects:

- Why you'd want to use Storage Migration Service.
- How the migration process works.
- What the requirements are for source and destination servers.
- [What's new in Storage Migration Service](#whats-new-in-storage-migration-service).

## Why use Storage Migration Service

Use Storage Migration Service because you've got a server or multiple servers that you want to migrate to newer hardware or virtual machines. Storage Migration Service is designed to help by doing the following tasks:

- Inventory multiple servers and their data
- Rapidly transfer files, file shares, and security configuration from the source servers
- Optionally take over the identity of the source servers (also known as cutting over) so that users and apps don't have to change anything to access existing data
- Manage one or multiple migrations from the Windows Admin Center user interface

:::image type="content" source="media/overview/storage-migration-service-diagram.png" alt-text="Diagram showing Storage Migration Service migrating files and configuration from source servers to destination servers, Azure VMs, or Azure File Sync.":::

## How the migration process works

Migration is a three-step process:

1. **Inventory servers** to gather info about their files and configuration, shown in the following figure.

   :::image type="content" source="media/migrate/inventory.png" alt-text="Screenshot showing that a server is ready to be scanned.":::

1. **Transfer (copy) data** from the source servers to the destination servers.
1. **Cut over to the new servers** (optional).<br>The destination servers assume the source servers' former identities so that apps and users don't have to change anything. <br>The source servers enter a maintenance state where they still contain the same files they always have (we never remove files from the source servers) but are unavailable to users and apps. You can then decommission the servers at your convenience.

The following video shows how to use Storage Migration Service to take a server, such as a Windows Server 2008 R2 server that's out of support, and move the storage to a newer server.

> [!VIDEO https://www.youtube.com/embed/h-Xc9j1w144]

## Requirements

To use Storage Migration Service, you need the following items:

- A **source server** or **failover cluster** to migrate files and data from.
- A **destination server** running Windows Server 2019 or Windows Server 2022 (clustered or standalone) to migrate to. Windows Server 2016 and Windows Server 2012 R2 work as well but are around 50% slower.
- An **orchestrator server** running Windows Server 2019 or Windows Server 2022 to manage the migration  <br>If you're migrating only a few servers, and one of the servers is running Windows Server 2019 or Windows Server 2022, you can use that as the orchestrator. If you're migrating more servers, use a separate orchestrator server.
- A **PC or server running the latest [Windows Admin Center](../../manage/windows-admin-center/overview.md)** to run the Storage Migration Service user interface, along with the latest Storage Migration Service tool (extension) available from the feed. The Windows Admin Center must be at least version 2103.

We strongly recommend that the orchestrator and destination computers have at least two cores or two vCPUs and at least 2 GB of memory. Inventory and transfer operations are faster with more processors and memory.

### Security requirements, the Storage Migration Service proxy service, and firewall ports

- A migration account that is an administrator on the source computers and the orchestrator computer. This account can be a domain or local account except in the case of a computer that isn't joined to the domain, in which case it must be a local user.
- A migration account that is an administrator on the destination computers and the orchestrator computer. This account can be a domain or local account except in the case of a computer that isn't joined to the domain, in which case it must be a local user.
- The orchestrator computer must have the File and Printer Sharing (SMB-In) firewall rule enabled *inbound*.
- The source and destination computers must have the following firewall rules enabled *inbound* (although you might already have them enabled):
  - File and Printer Sharing (SMB-In)
  - Netlogon Service (NP-In)
  - Windows Management Instrumentation (DCOM-In)
  - Windows Management Instrumentation (WMI-In)

  > [!TIP]
  > Installing the Storage Migration Service Proxy service on a Windows Server 2019 or Windows Server 2022 computer automatically opens the necessary firewall ports on that computer. To do so, connect to the destination server in Windows Admin Center and then go to **Server Manager** (in Windows Admin Center) > **Roles and features**, select **Storage Migration Service Proxy**, and then choose **Install**.

- If the computers belong to an Active Directory Domain Services domain, they should all belong to the same forest. The destination server must also be in the same domain as the source server if you want to transfer the source's domain name to the destination when cutting over. Cutover technically works across domains, but the fully qualified domain name of the destination is different from the source.

### Requirements for source servers

The source server must run one of the following operating systems:

- Windows Server, Semi-Annual Channel
- Windows Server 2022
- Windows Server 2019
- Windows Server 2016
- Windows Server 2012 R2
- Windows Server 2012
- Windows Server 2008 R2
- Windows Server 2008
- Windows Server 2003 R2
- Windows Server 2003
- Windows Small Business Server 2003 R2
- Windows Small Business Server 2008
- Windows Small Business Server 2011
- Windows Server 2012 Essentials
- Windows Server 2012 R2 Essentials
- Windows Server 2016 Essentials
- Windows Server 2019 Essentials
- Windows Storage Server 2008
- Windows Storage Server 2008 R2
- Windows Storage Server 2012
- Windows Storage Server 2012 R2
- Windows Storage Server 2016

> [!NOTE]
> Windows Small Business Server and Windows Server Essentials are domain controllers. Storage Migration Service can't yet cut over from domain controllers, but it can inventory and transfer files from them.

You can migrate the following other source types if the orchestrator is running Windows Server 2019 with [KB5001384](https://support.microsoft.com/topic/april-20-2021-security-update-kb5001384-e471f445-59be-42cb-8c57-5db644cbc698) installed or Windows Server 2022:

- Failover clusters running Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, or Windows Server 2008 R2. Windows Server 2008 R2 only supports inventory and transfer, not cutover.
- Linux servers that use Samba. We've tested the following distributions:
  - CentOS 7
  - Debian GNU/Linux 8
  - RedHat Enterprise Linux 7.6
  - SUSE Linux Enterprise Server (SLES) 11 SP4
  - Ubuntu 16.04 LTS and 12.04.5 LTS
  - Samba 4.8, 4.7, 4.3, 4.2, and 3.6
- NetApp FAS arrays hosting NetApp CIFS server, running NetApp ONTAP 9.  

### Requirements for destination servers

The destination server must run one of the following operating systems:

- Windows Server, Semi-Annual Channel
- Windows Server 2022
- Windows Server 2019
- Windows Server 2016
- Windows Server 2012 R2

The destination servers can be standalone servers or part of a Windows failover cluster. They can't run Azure Stack HCI or use a non-Microsoft clustering add-on. While the Storage Migration Service doesn't support Azure Files as a destination, it fully supports servers running the Azure File Sync agent with cloud tiering.

> [!TIP]
> Destination servers running Windows Server 2022 or Windows Server 2019 have double the transfer performance of earlier versions of Windows Server. This performance boost is due to the inclusion of a built-in Storage Migration Service proxy service.

## Azure VM migration

Windows Admin Center integrates Azure IaaS deployment into Storage Migration Service. It lets you avoid building new servers and VMs in the Azure portal by hand prior to deploying your workload. It also lets you avoid possibly missing required steps and configuration. Windows Admin Center can deploy the Azure IaaS VM, configure its storage, join it to your domain, install roles, and then set up your distributed system.

The following video shows how to use Storage Migration Service to migrate to Azure VMs.

> [!VIDEO https://www.youtube-nocookie.com/embed/k8Z9LuVL0xQ]

If you want to lift and shift virtual machines to Azure without migrating to a later operating system, consider using Azure Migrate. For more information, see [About Azure Migrate](/azure/migrate/migrate-services-overview).

## What's new in Storage Migration Service

Windows Admin Center version 1910 added the ability to deploy Azure virtual machines. This update integrates Azure VM deployment into Storage Migration Service. For more information, see [Azure VM migration](#azure-vm-migration).

You can access the following post-RTM features when running the Storage Migration Server orchestrator on Windows Server 2019 with [KB5001384](https://support.microsoft.com/topic/april-20-2021-security-update-kb5001384-e471f445-59be-42cb-8c57-5db644cbc698) installed or on Windows Server 2022:

- Migrate local users and groups to the new server.
- Migrate storage from failover clusters, migrate to failover clusters, and migrate between standalone servers and failover clusters.
- Migrate storage from a Linux server that uses Samba.
- Sync migrated shares more easily into Azure by using Azure File Sync.
- Migrate to new networks such as Azure.
- Migrate NetApp CIFS servers from NetApp FAS arrays to Windows servers and clusters.

## Related links

- [Use Storage Migration Service to migrate a server](migrate-data.md)
- [Storage Migration Service frequently asked questions (FAQ)](faq.yml)
- [Storage Migration Service known issues](known-issues.md)
