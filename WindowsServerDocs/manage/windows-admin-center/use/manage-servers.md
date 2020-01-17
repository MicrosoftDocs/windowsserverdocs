---
title: Manage Servers with Windows Admin Center
description: Manage Servers with Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 11/21/2019
ms.localizationpriority: medium
ms.prod: windows-server
---
# Manage Servers with Windows Admin Center

>Applies To: Windows Admin Center, Windows Admin Center Preview

> [!Tip]
> New to Windows Admin Center?
> [Download or learn more about Windows Admin Center](../overview.md).

## Managing Windows Server machines

You can add individual servers running Windows Server 2012 or later to Windows Admin Center to manage the server with a comprehensive set of tools including Certificates, Devices, Events, Processes, Roles and Features, Updates, Virtual Machines and more.

![Server connection Overview screen](../media/manage-servers/server-overview.png)

## Adding a server to Windows Admin Center

To add a server to Windows Admin Center:

1. Click **+ Add** under All Connections.
2. Choose to add a **Server Connection**.
3. Type the name of the server and, if prompted, the credentials to use.
4. Click **Submit** to finish.

The server will be added to your connection list on the Overview page. Click it to connect to the server.

> [!NOTE]
> You can also add [failover clusters](manage-failover-clusters.md) or [hyper-converged clusters](manage-hyper-converged.md) as a separate connection in Windows Admin Center.

## Tools

The following tools are available for server connections:

| Tool | Description |
| ---- | ----------- |
| [Overview](#overview) | View server details and control server state |
| [Active Directory](#active-directory-preview) | Manage Active Directory |
| [Backup](#backup) | View and configure Azure Backup |  
| [Certificates](#certificates) | View and modify certificates |
| [Containers](#containers) | View Containers |
| [Devices](#devices) | View and modify devices |
| [DHCP](#dhcp) | View and manage DHCP server configuration |
| [DNS](#dns) | View and manage DNS server configuration |
| [Events](#events) | View events |
| [Files](#files) | Browse files and folders |
| [Firewall](#firewall) | View and modify firewall rules |
| [Installed Apps](#installed-apps) | View and remove installed apps |
| [Local Users and Groups](#local-users-and-groups) | View and modify local users and groups |
| [Network](#network) | View and modify network devices |
| [Packet monitoring](https://aka.ms/wac1908) | Monitor network packets |
| [Performance monitor](https://aka.ms/perfmon-blog) | View performance counters and reports |
| [PowerShell](#powershell) | Interact with server via PowerShell |
| [Processes](#processes) | View and modify running processes |
| [Registry](#registry) | View and modify registry entries |
| [Remote Desktop](#remote-desktop) | Interact with server via Remote Desktop |
| [Roles and Features](#roles-and-features) | View and modify roles and features |
| [Scheduled Tasks](#scheduled-tasks) | View and modify scheduled tasks |
| [Services](#services) | View and modify services |
| [Settings](#settings) | View and modify services |
| [Storage](#storage) | View and modify storage devices |
| [Storage Migration Service](#storage-migration-service) | Migrate servers and file shares to Azure or Windows Server 2019 |
| [Storage Replica](#storage-replica) | Use Storage Replica to manage server-to-server storage replication |
| [System Insights](#system-insights) | System Insights gives you increased insight into the functioning of your server. |
| [Updates](#updates) | View installed and check for new updates |
| [Virtual Machines](manage-virtual-machines.md) | View and manage virtual machines |
| [Virtual Switches](#virtual-switches) | View and manage virtual switches |

## Overview

**Overview** allows you to see the current state of CPU, memory, and network performance, as well as perform operations and modify settings on a target computer or server.

### Features

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

[**View feedback and proposed features for Server Overview**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BOverview%5D).

## Active Directory (Preview)

**Active Directory** is an early preview that is available on the [extension feed](../configure/using-extensions.md).

### Features

The following Active Directory management are available:

- Create user
- Create group
- Search for users, computers, and groups
- Details pane for users, computers, and groups when selected in grid
- Global Grid actions users, computers, and groups (disable/enable, remove)
- Reset user password
- User objects: configure basic properties & group memberships
- Computer objects: configure delegation to a single machine
- Group objects: manage membership (add/remove 1 user at a time)  

[**View feedback and proposed features for Active Directory**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BActive%20Directory%5D).

## Backup

**Backup** allows you to protect your Windows server from corruptions, attacks or disasters by backing up your server directly to Microsoft Azure.
[Learn more about Azure Backup.](https://aka.ms/windows-admin-center-backup)

[Provide feedback for backup in Windows Admin Center](https://aka.ms/backup-wac-feedback)

### Features

The following features are supported in Backup:

- View an overview of your Azure backup status
- Configure backup items and schedule
- Start or stop a backup job
- View backup job history and status
- View recovery points and recover data
- Delete backup data

## Certificates

**Certificates** allows you to manage certificate stores on a computer or server.

### Features

The following features are supported in Certificates:

- Browse and search existing certificates
- View certificate details
- Export certificates
- Renew certificates
- Request new certificates
- Delete certificates

[**View feedback and proposed features for Certificates**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BCertificates%5D).

## Containers

**Containers** allows you to view the containers on a Windows Server container host. In the case of a running Windows Server Core container, you can view the event logs and access the CLI of the container.

[**View feedback and proposed features for Containers**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BContainers%5D).

## Devices

**Devices** allows you to manage connected devices on a computer or server.

### Features

The following features are supported in Devices:

- Browse and search devices
- View device details
- Disable a device
- Update driver on a device

[**View feedback and proposed features for Devices**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BDevices%5D).

## DHCP

**DHCP** allows you to manage connected devices on a computer or server.

### Features

- Create/configure/view IPV4 and IPV6 scopes
- Create address exclusions and configure start and end IP address
- Create address reservations and configure client MAC address (IPV4), DUID and IAID (IPV6)

[**View feedback and proposed features for DHCP**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BDHCP%5D).

## DNS

**DNS** allows you to manage connected devices on a computer or server.

### Features

- View details of DNS Forward Lookup zones, Reverse Lookup zones and DNS records
- Create forward Lookup zones (primary, secondary, or stub), and configure forward lookup zone properties
- Create Host (A or AAAA), CNAME or MX type of DNS records
- Configure DNS records properties
- Create IPV4 and IPV6 Reverse Lookup zones (primary, secondary and stub), configure reverse lookup zone properties
- Create PTR, CNAME type of DNS records under reverse lookup zone.

[**View feedback and proposed features for DHCP**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BDNS%5D).

## Events

**Events** allows you to manage event logs on a computer or server.

### Features

The following features are supported in Events:

- Browse and search events
- View event details
- Clear events from the log
- Export events from the log

[**View feedback and proposed features for Events**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BEvents%5D).

## Files

**Files** allows you to manage files and folders on a computer or server.

### Features

The following features are supported in Files:

- Browse files and folders
- Search for a file or folder
- Create a new folder
- Delete a file or folder
- Download a file or folder
- Upload a file or folder
- Rename a file or folder
- Extract a zip file
- View file or folder properties
- Add, edit, or remove file shares
- Modify user and group permissions on file shares

[**View feedback and proposed features for Files**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BFiles%5D).

## Firewall

**Firewall** allows you to manage firewall settings and rules on a computer or server.

### Features

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

[**View feedback and proposed features for Firewall**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BFirewall%5D).

## Installed Apps

**Installed Apps** allows you to list and uninstall application that are installed.

[**View feedback and proposed features for Installed Apps**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BInstalled%20Apps%5D).

## Local Users and Groups

**Local Users and Groups** allows you to manage security groups and users that exist locally on a computer or server.

### Features

The following features are supported in Local Users and Groups:

- View and search users and groups
- Create a new user or group
- Manage a user's group membership
- Delete a user or group
- Change a user's password
- Edit the properties of a user or group

[**View feedback and proposed features for Local User and Groups**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BLocal%20users%20and%20Groups%5D)

## Network

**Network** allows you to manage network devices and settings on a computer or server.

### Features

The following features are supported in Network:

- Browse and search existing network adapters
- View details of a network adapter
- Edit properties of a network adapter
- Create an [Azure Network Adapter (Preview feature)](https://blogs.technet.microsoft.com/networking/2018/09/05/azurenetworkadapter/)

[**View feedback and proposed features for Network**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BNetwork%5D)

## PowerShell

**PowerShell** allows you to interact with a computer or server via a PowerShell session.

### Features

The following features are supported in PowerShell:

- Create an interactive PowerShell session on the server
- Disconnect from PowerShell session on the server

[**View feedback and proposed features for PowerShell**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BPowerShell%5D)

## Processes

**Processes** allows you to manage running processes on a computer or server.

### Features

The following features are supported in Processes:

- Browse and search for running processes
- View process details
- Start a process
- End a process
- Create a process dump
- Find process handles

[**View feedback and proposed features for Processes**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BProcesses%5D).

## Registry

**Registry** allows you to manage registry keys and values on a computer or server.

### Features

The following features are supported in Registry:

- Browse registry keys and values
- Add or modify registry values
- Delete registry values

[**View feedback and proposed features for Registry**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BRegistry%5D).

## Remote Desktop

**Remote Desktop** allows you to interact with a computer or server via an interactive desktop session.

### Features

The following features are supported in Remote Desktop:

- Start an interactive remote desktop session
- Disconnect from a remote desktop session
- Send Ctrl+Alt+Del to a remote desktop session

[**View feedback and proposed features for Remote Desktop**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BRemote%20Desktop%5D).

## Roles and Features

**Roles and Features** allows you to manage roles and features on a server.

### Features

The following features are supported in Roles and Features:

- Browse list of roles and features on a server
- View role or feature details
- Install a role or feature
- Remove a role or feature

[**View feedback and proposed features for Roles and Features**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BRoles%20and%20Features%5D).

## Scheduled Tasks

**Scheduled Tasks** allows you to manage scheduled tasks on a computer or server.

### Features

The following features are supported in Scheduled Tasks:

- Browse the task scheduler library
- Edit scheduled tasks
- Enable & Disable scheduled tasks
- Start & Stop scheduled tasks
- Create scheduled tasks

[**View feedback and proposed features for Scheduled Tasks**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BScheduled%20Tasks%5D).

## Services

**Services** allows you to manage services on a computer or server.

### Features

The following features are supported in Services:

- Browse and search services on a server
- View details of a service
- Start a service
- Pause a service
- Edit the properties of a service

[**View feedback and proposed features for Services**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BServices%5D).

## Settings

**Settings** is a central location to manage settings on a computer or server.

### Features

- View and modify user and system environment variables
- View the configuration for monitoring alerts from [Azure Monitor](azure-monitor.md)
- View and modify the power configuration
- View and modify Remote Desktop settings
- View and modify role-based access control settings
- View and modify Hyper-V host settings, if applicable

## Storage

**Storage** allows you to manage storage devices on a computer or server.

### Features

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
- Manage File Server Resource Manager Quotas [Storage->Create/Update Quota](https://docs.microsoft.com/windows-server/storage/fsrm/quota-management)

[**View feedback and proposed features for Storage**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BStorage%5D)

## Storage Migration Service

**Storage Migration Service** allows you to migrate servers and file shares to Azure or Windows Server 2019—without requiring apps or users to change anything.
[Get an overview of Storage Migration Service](https://go.microsoft.com/fwlink/?linkid=2016155)

>[!NOTE]
>Storage Migration Service requires Windows Server 2019.

## Storage Replica

Use **Storage Replica** to manage server-to-server storage replication.
[Learn more about Storage Replica](https://docs.microsoft.com/windows-server/storage/storage-replica/storage-replica-ui)

## System Insights

**System Insights** introduces predictive analytics natively in Windows Server to help give you increased insight into the functioning of your server.
[Get an overview of System Insights](https://aka.ms/systeminsights)

>[!NOTE]
>System Insights requires Windows Server 2019.

## Updates

**Updates** allows you to manage Microsoft and/or Windows Updates on a computer or server.

### Features

The following features are supported in Updates:

- View available Windows or Microsoft Updates
- View a list of update history
- Install Updates
- Check online for updates from Microsoft Update
- Manage [Azure Update Management](https://docs.microsoft.com/azure/automation/automation-update-management) integration

[**View feedback and proposed features for Updates**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BUpdates%5D)

## Virtual Machines

See [Managing Virtual Machines with Windows Admin Center](manage-virtual-machines.md)

## Virtual Switches

**Virtual Switches** allows you to manage Hyper-V virtual switches on a computer or server.

### Features

The following features are supported in Virtual Switches:

- Browse and search Virtual Switches on a server
- Create a new Virtual Switch
- Rename a Virtual Switch
- Delete an existing Virtual Switch
- Edit the properties of a Virtual Switch

[**View feedback and proposed features for Virtual Switches**](https://windowsserver.uservoice.com/forums/295071/filters/top?category_id=319162&query=%5BVirtual%20Switch%5D)
