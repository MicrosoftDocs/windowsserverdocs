---
title: Configure multiple CSV for VM replication in Windows Server
description: Configure multiple CSV for VM replication using Hyper-V Replica to increase scalability and fault tolerance in Windows Server.
ms.topic: how-to
ms.author: alalve
author: xelu86
ms.date: 12/06/2024
---

# Configure multiple CSV for VM replication

When setting up Virtual Machine (VM) replication, you might encounter a limitation where only a single path for Cluster Shared Volumes (CSV) can be specified. This guide outlines how to overcome this limitation to configure multiple CSV for VM replication. This approach provides greater control over your VM by improving flexibility and storage efficiency of your resources.

## Prerequisites

The following are required on your device before proceeding:

- The **Hyper-V** role must be installed. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).
- VM replication is enabled. To learn more, see [Set up Hyper-V Replica](/windows-server/virtualization/hyper-v/manage/set-up-hyper-v-replica).
- Sufficient storage space for successful replication.

> [!NOTE]
> During the replication process, be aware that the hardware and network you use affects the services that rely on them. Depending on the amount of data replicated between the source and target systems, this process consumes a large amount of system resources. Your device performance is impacted until this process completes.

## Resolution methods

### Update HVR broker settings

### Move storage path using PowerShell
