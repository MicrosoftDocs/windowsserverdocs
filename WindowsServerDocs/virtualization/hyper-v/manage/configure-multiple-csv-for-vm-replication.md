---
title: Configure multiple CSV for VM replication in Windows Server
description: Configure multiple CSV for VM replication using Hyper-V Replica to increase scalability and fault tolerance in Windows Server.
ms.topic: how-to
ms.author: daknappe
author: dknappettmsft
ms.date: 01/15/2025
---

# Configure multiple CSV for VM replication

When setting up Virtual Machine (VM) replication, you might encounter a limitation where only a single path for Cluster Shared Volumes (CSV) can be specified. This guide outlines how to overcome this limitation to configure multiple CSV for VM replication. This approach provides greater control over your VM by improving flexibility and storage efficiency of your resources.

## Prerequisites

The following are required on your device before proceeding:

- The **Hyper-V** role must be installed. To learn more, see [Install the Hyper-V role on Windows Server](/windows-server/virtualization/hyper-v/get-started/install-the-hyper-v-role-on-windows-server).
- VM replication is enabled and inbound firewall rules are configured. To learn more, see [Set up Hyper-V Replica](/windows-server/virtualization/hyper-v/manage/set-up-hyper-v-replica).
- Sufficient disk space for successful storage migration.

> [!NOTE]
> During the replication process, the hardware and network you use affects the services that rely on them. Depending on the amount of data replicated between the source and target systems, this process consumes a large amount of system resources. Your device performance is impacted until this process completes.

## Configure multiple CSV locations

When copying VMs through a replication process, it's possible to use multiple storage volumes to store the replicated data. There are two methods to configure new replication locations, through the Hyper-V Manager UI or via PowerShell.

# [Hyper-V](#tab/hyperv)

1. Open the **Hyper-V Manager**, under **Actions**, select **Hyper-V Settings**.
1. Under **Authorization and storage**, select either **Allow replication from any authenticated server** or **Allow replication from the specified servers**, then select **Browse**.
1. In the **Select Folder** window, choose a new default location, then select **Select Folder**.

When changes are made to the "default location" where replication is enabled for a VM, the new target volume is used for any new subsequent replication enablement. However, VMs that were already being replicated continues to use the original target volume that was set up when replication was first enabled.

# [PowerShell](#tab/powershell)

Open an elevated PowerShell window and run the following command:

```powershell
$VM = "MyVM"
$Destination = "E:\MyVM_NewPath"
Move-VMStorage $VM -DestinationStoragePath $Destination
```

This command moves the VM storage to the specified destination path, allowing for configuration of multiple CSV for VM replication.

This approach is effective in different situations, including prereplication, post-replication, and during delta transfers of a replicated VM. During a VM storage move operation, delta replication is temporarily paused and automatically resumes once the move is complete. However, in some situations, such as when there's low disk space or storage movement latency, it might be necessary to manually resume the replication process.

---

