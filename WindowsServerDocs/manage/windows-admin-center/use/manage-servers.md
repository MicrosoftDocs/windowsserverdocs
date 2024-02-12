---
title: Manage Servers with Windows Admin Center
description: Manage Servers with Windows Admin Center (Project Honolulu)
ms.topic: article
author: davannaw-msft
ms.author: dawhite
ms.date: 11/21/2019
---
# Manage Servers with Windows Admin Center

>Applies to: Windows Admin Center, Windows Admin Center Preview

> [!Tip]
> New to Windows Admin Center?
> [Download or learn more about Windows Admin Center](../overview.md).

## Managing Windows Server machines

You can add individual servers running Windows Server 2012 or later to Windows Admin Center to manage the server with a comprehensive set of tools including Certificates, Devices, Events, Processes, Roles and Features, Updates, Virtual Machines and more.

![Server connection Overview screen](../media/manage-servers/server-overview.png)

## Adding a server to Windows Admin Center

To add a server to Windows Admin Center:

1. Click **+ Add** under All Connections.
2. Choose to add **Servers**.
3. Type the name of the server and, if prompted, the credentials to use.
4. Click **Add** to finish.

The server will be added to your connection list on the Overview page. Click it to connect to the server.

> [!NOTE]
> You can also add [failover clusters](manage-failover-clusters.md) or [hyper-converged clusters](manage-hyper-converged.md) as a separate connection in Windows Admin Center.

## Tools

The following tools are available for server connections:

| Tool | Description |
| ---- | ----------- |
| [Overview](#overview) | View server details and control server state |
| [Settings](#settings) | View and modify services |
| [Active Directory](#active-directory-preview) | Manage Active Directory |
| [Azure Backup](#azure-backup) | View and configure Azure Backup |
| [Azure File Sync](#azure-file-sync) | View and configure Azure File Sync |
| [Azure hybrid center](#azure-hybrid-center) | View and configure Azure hybrid services |
| [Azure Monitor](#azure-monitor) | View and configure Azure Monitor |
| [Certificates](#certificates) | View and modify certificates |
| [Containers](#containers) | View Containers |
| [Devices](#devices) | View and modify devices |
| [DHCP](#dhcp) | View and manage DHCP server configuration |
| [DNS](#dns) | View and manage DNS server configuration |
| [Events](#events) | View events |
| [Files & file sharing](#files-and-file-sharing) | Browse files and folders |
| [Firewall](#firewall) | View and modify firewall rules |
| [Installed apps](#installed-apps) | View and remove installed apps |
| [Local users and groups](#local-users-and-groups) | View and modify local users and groups |
| [Microsoft Defender for Cloud](#microsoft-defender-for-cloud) | View and configure Microsoft Defender for Cloud |
| [Networks](#networks) | View and modify network devices |
| [Packet monitoring](https://aka.ms/wac1908) | Monitor network packets |
| [Performance monitor](https://aka.ms/perfmon-blog) | View performance counters and reports |
| [PowerShell](#powershell) | Interact with server via PowerShell |
| [Processes](#processes) | View and modify running processes |
| [Registry](#registry) | View and modify registry entries |
| [Remote Desktop](#remote-desktop) | Interact with server via Remote Desktop |
| [Roles & features](#roles-and-features) | View and modify roles and features |
| [Scheduled tasks](#scheduled-tasks) | View and modify scheduled tasks |
| [Security](#security) | View and modify security settings |
| [Services](#services) | View and modify services |
| [Storage](#storage) | View and modify storage devices |
| [Storage Migration Service](#storage-migration-service) | Migrate servers and file shares to Azure or Windows Server 2019 |
| [Storage Replica](#storage-replica) | Use Storage Replica to manage server-to-server storage replication |
| [System Insights](#system-insights) | System Insights gives you increased insight into the functioning of your server. |
| [Updates](#updates) | View installed and check for new updates |
| [Virtual machines](manage-virtual-machines.md) | View and manage virtual machines |
| [Virtual switches](#virtual-switches) | View and manage virtual switches |

## Overview

**Overview** allows you to see the current state of CPU, memory, and network performance, as well as perform operations and modify settings on a target computer or server.

### Overview features

The following features are supported in Server Manager Overview:

- View server details
- View CPU activity
- View memory activity
- View network activity
- Restart server
- Shutdown server
- Enable disk metrics on server
- Edit Computer ID on server
- View BMC IP address with hyperlink (requires IPMI-compatible BMC).

## Active Directory (Preview)

**Active Directory** is an early preview that is available on the [extension feed](../configure/using-extensions.md).

### Active Directory features

The following Active Directory management features are available:

- Create user
- Create group
- Search for users, computers, and groups
- Details pane for users, computers, and groups when selected in grid
- Global Grid actions users, computers, and groups (disable/enable, remove)
- Reset user password
- User objects: configure basic properties & group memberships
- Computer objects: configure delegation to a single machine
- Group objects: manage membership (add/remove 1 user at a time)

## Azure Backup

**Azure Backup** allows you to protect your Windows server from corruptions, attacks or disasters by backing up your server directly to Microsoft Azure.
[Learn more about Azure Backup.](https://aka.ms/windows-admin-center-backup)

### Azure Backup features

The following features are supported in Backup:

- View an overview of your Azure backup status
- Configure backup items and schedule
- Start or stop a backup job
- View backup job history and status
- View recovery points and recover data
- Delete backup data

## Azure File Sync

**Azure File Sync** allows you to sync your file server with the cloud.
[Learn more about Azure File Sync.](../azure/azure-file-sync.md)

## Azure hybrid center

**Azure hybrid center** is your centralized location for learning about and onboarding to Azure hybrid services.
[Learn more about Azure hybrid services in Windows Admin Center.](../azure/index.md)

## Azure Monitor

**Azure Monitor** allows you to monitor your servers and configure alerts.
[Learn more about Azure Monitor.](../azure/azure-monitor.md)

## Certificates

**Certificates** allows you to manage certificate stores on a computer or server.

### Certificates features

The following features are supported in Certificates:

- Browse and search existing certificates
- View certificate details
- Export certificates
- Renew certificates
- Request new certificates
- Delete certificates

## Containers

**Containers** allows you to view the containers on a Windows Server container host. In the case of a running Windows Server Core container, you can view the event logs and access the CLI of the container. It is available on the [extension feed](../configure/using-extensions.md).

## Devices

**Devices** allows you to manage connected devices on a computer or server.

### Devices features

The following features are supported in Devices:

- Browse and search devices
- View device details
- Disable a device
- Update driver on a device

## DHCP

**DHCP** allows you to manage connected devices on a computer or server. It is available on the [extension feed](../configure/using-extensions.md).

### DHCP features

- Create, configure, and view IPV4 and IPV6 scopes
- Create address exclusions and configure start and end IP address
- Create address reservations and configure client MAC address (IPV4), DUID and IAID (IPV6)

## DNS

**DNS** allows you to manage connected devices on a computer or server. It is available on the [extension feed](../configure/using-extensions.md).

### DNS features

- View details of DNS Forward Lookup zones, Reverse Lookup zones and DNS records
- Create forward Lookup zones (primary, secondary, or stub), and configure forward lookup zone properties
- Create Host (A or AAAA), CNAME or MX type of DNS records
- Configure DNS records properties
- Create IPV4 and IPV6 Reverse Lookup zones (primary, secondary and stub), configure reverse lookup zone properties
- Create PTR, CNAME type of DNS records under reverse lookup zone.

## Events

**Events** allows you to manage event logs on a computer or server.

### Events features

The following features are supported in Events:

- Browse and search events
- View event details
- Clear events from the log
- Export events from the log
- Create workspaces (preview)
- Save workspaces (preview)
- Delete workspaces (preview)
- View events in a stacked bar format (preview)

## Files and file sharing

**Files and file sharing** allows you to manage files and folders on a computer or server.

### Files and file sharing features

The following features are supported in Files and file sharing:

- Browse files and folders
- Search for a file or folder
- Create a new folder
- Delete a file or folder
- Download a file or folder
- Upload a file or folder
- Rename a file or folder
- Extract a zip file
- Copy and move files and folders
- View file or folder properties
- Add, edit, or remove file shares
- Modify user and group permissions on file shares
- Modify file server security

## Firewall

**Firewall** allows you to manage firewall settings and rules on a computer or server.

### Firewall features

The following features are supported in Firewall:

- View an overview of firewall settings
- View incoming firewall rules
- View outgoing firewall rules
- Search firewall rules
- View firewall rule details
- Create a new firewall rule
- Enable or disable a firewall rule
- Delete a firewall rule
- Edit the properties of a firewall rule

## Installed apps

**Installed apps** allows you to list and uninstall applications that are installed.

## Local users and groups

**Local users and groups** allows you to manage security groups and users that exist locally on a computer or server.

### Local users and groups features

The following features are supported in Local users and groups:

- View and search users and groups
- Create a new user or group
- Manage a user's group membership
- Delete a user or group
- Change a user's password
- Edit the properties of a user or group

## Microsoft Defender for Cloud

**Microsoft Defender for Cloud** is a cloud-native application protection platform with a set of security measures and practices designed to protect cloud-based applications from various cyber threats and vulnerabilities.

## Networks

**Networks** allows you to manage network devices and settings on a computer or server.

### Networks features

The following features are supported in Network:

- Browse and search existing network adapters
- View details of a network adapter
- Edit properties of a network adapter
- Create an [Azure Network Adapter (Preview feature)](https://blogs.technet.microsoft.com/networking/2018/09/05/azurenetworkadapter/)

## PowerShell

**PowerShell** allows you to interact with a computer or server via a PowerShell session.

### PowerShell features

The following features are supported in PowerShell:

- Create an interactive PowerShell session on the server
- Disconnect from PowerShell session on the server

## Processes

**Processes** allows you to manage running processes on a computer or server.

### Processes features

The following features are supported in Processes:

- Browse and search for running processes
- View process details
- Start a process
- End a process
- Create a process dump
- Find process handles

## Registry

**Registry** allows you to manage registry keys and values on a computer or server.

### Registry features

The following features are supported in Registry:

- Browse registry keys and values
- Add or modify registry values
- Delete registry values

## Remote Desktop

**Remote Desktop** allows you to interact with a computer or server via an interactive desktop session.

### Remote Desktop features

The following features are supported in Remote Desktop:

- Start an interactive remote desktop session
- Disconnect from a remote desktop session
- Send Ctrl+Alt+Del to a remote desktop session

## Roles and Features

**Roles and Features** allows you to manage roles and features on a server.

### Roles and Features features

The following features are supported in Roles and Features:

- Browse list of roles and features on a server
- View role or feature details
- Install a role or feature
- Remove a role or feature

## Scheduled tasks

**Scheduled tasks** allows you to manage scheduled tasks on a computer or server.

### Scheduled tasks features

The following features are supported in Scheduled tasks:

- Browse the task scheduler library
- Edit scheduled tasks
- Enable & Disable scheduled tasks
- Start & Stop scheduled tasks
- Create scheduled tasks

## Security

**Security** allows you to manage your security settings on a computer or server.

### Security features

The following features are supported in Security: 

- Run and schedule virus scans
- Enable and disable real-time threat protection
- View threat history
- Check Secured-core status
- Enable or disable Secured-core security features

## Services

**Services** allows you to manage services on a computer or server.

### Services features

The following features are supported in Services:

- Browse and search services on a server
- View details of a service
- Start a service
- Pause a service
- Restart a service
- Edit the properties of a service

## Settings

**Settings** is a central location to manage settings on a computer or server.

### Settings features

- View and modify File share settings
- View and modify user and system environment variables
- View and modify the power configuration
- View and modify Remote Desktop settings
- View and modify role-based access control settings
- View and modify Hyper-V host settings, if applicable

## Storage

**Storage** allows you to manage storage devices on a computer or server.

### Storage features

The following features are supported in Storage:

- Browse and search existing disks on a server
- View disk details
- Create a volume
- Initialize a disk
- Create, attach, and detach a virtual hard disk (VHD)
- Take a disk offline
- Format a volume
- Resize a volume
- Edit volume properties
- Delete a volume
- Install Quota Management
- Manage File Server Resource Manager Quotas [Storage->Create/Update Quota](../../../storage/fsrm/quota-management.md)

## Storage Migration Service

**Storage Migration Service** allows you to migrate servers and file shares to Azure or Windows Server 2019—without requiring apps or users to change anything.
[Get an overview of Storage Migration Service](../../../storage/storage-migration-service/overview.md)

>[!NOTE]
>Storage Migration Service requires Windows Server 2019.

## Storage Replica

Use **Storage Replica** to manage server-to-server storage replication.
[Learn more about Storage Replica](../../../storage/storage-replica/server-to-server-storage-replication.md)

## System Insights

**System Insights** introduces predictive analytics natively in Windows Server to help give you increased insight into the functioning of your server.
[Get an overview of System Insights](../../system-insights/overview.md)

>[!NOTE]
>System Insights requires Windows Server 2019.

## Updates

**Updates** allows you to manage Microsoft and/or Windows Updates on a computer or server.

### Updates features

The following features are supported in Updates:

- View available Windows or Microsoft Updates
- View a list of update history
- Install Updates
- Check online for updates from Microsoft Update
- Manage [Azure Update Management](/azure/automation/update-management/overview) integration

## Virtual machines

See [Managing Virtual Machines with Windows Admin Center](manage-virtual-machines.md)

## Virtual switches

**Virtual switches** allows you to manage Hyper-V virtual switches on a computer or server.

### Virtual switches features

The following features are supported in Virtual switches:

- Browse and search Virtual switches on a server
- Create a new Virtual switch
- Rename a Virtual switch
- Delete an existing Virtual switch
- Edit the properties of a Virtual Switch
