---
title: Hyper-V Maximum Scale Limits in Windows Server
description: View Hyper-V maximum scale limits for virtual machines and hosts in Windows Server. Use them to plan capacity and support demanding workloads.
ms.topic: limits-and-quotas
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 10/17/2025
---

# Hyper-V maximum scale limits in Windows Server

Hyper-V can scale to provide your workloads with the resources they need. This article details Hyper-V scalability limits in supported versions of Windows Server for virtual machines (VMs) and hosts, including virtual processors, memory, storage, and checkpoints. Use these maximums to plan capacity and support demanding workloads.

As you plan your deployment, consider these maximums that apply to each virtual machine and host. Maximums continue to grow in Windows Server versions, in response to requests to support newer scenarios such as machine learning and data analytics.

## Maximums for Hyper-V virtual machines

These maximums apply to each virtual machine for the version of Windows Server running on a Hyper-V host. Some components have different maximums depending on whether the VM is generation 1 or generation 2. For a comparison of the generations, see [Should I create a generation 1 or 2 virtual machine in Hyper-V?](plan/should-i-create-a-generation-1-or-2-virtual-machine-in-hyper-v.md).

> [!IMPORTANT]
> The guest operating system you run in the virtual machine might support less than Hyper-V's maximum. Check with your operating system vendor for its supported limits and choose the appropriate VM generation before deploying at scale. Vendor limits might change; verify against current updates.

Select the relevant tab to see the maximums for each supported version of Windows Server.

### [Windows Server 2025 host](#tab/windows-server-2025)

Here are the limits for virtual machines on a Hyper-V host running Windows Server 2025:

| Component | Maximum Limit |
|--|--|
| Virtual processors | 2,048 (generation 2 - for example: 64 sockets with 32 virtual processors per NUMA node, PowerShell only); 64 (generation 1). |
| Memory | 240 TB (generation 2); 1 TB (generation 1). |
| Virtual hard disk capacity | 64 TB (VHDX); 2,040 GB (VHD). |
| Virtual hard disks | 256 (SCSI); 4 (IDE, generation 1 only). |
| Physical disk pass-through | The operating system determines the maximum size for the virtual machine. |
| Virtual network adapters | 64 standard (generation 2); 8 standard + 4 legacy (generation 1). |
| Virtual SCSI controllers | 4 |
| Virtual SCSI devices | 256. Each SCSI controller supports up to 64 virtual hard disks and/or DVD drives. |
| Virtual IDE controllers (generation 1 only) | 2. Each IDE controller supports up to 2 IDE devices (hard disks and/or DVD drives) per controller. |
| Virtual IDE devices (generation 1 only) | 4. For generation 1 VMs, the startup/boot disk must be attached to one of the IDE devices. |
| Virtual DVD drives | 256 (SCSI); 4 (IDE, generation 1 only). |
| Virtual Fibre Channel adapters | 4. We recommended that you connect each virtual Fibre Channel Adapter to a different virtual SAN. |
| Serial (COM) ports (generation 1 only) | 2 |
| Virtual floppy devices (generation 1 only) | 1 |
| Checkpoints | 50, dependent on the amount of available storage. |

### [Windows Server 2022 host](#tab/windows-server-2022)

Here are the limits for virtual machines on a Hyper-V host running Windows Server 2022. This list also applies to Azure Local.

| Component | Maximum Limit |
|--|--|
| Virtual processors | 1,024 (generation 2 - for example: 64 sockets with 16 virtual processors per NUMA node); 64 (generation 1). |
| Memory | 240 TB (generation 2); 1 TB (generation 1). |
| Virtual hard disk capacity | 64 TB (VHDX); 2,040 GB (VHD). |
| Virtual hard disks | 256 (SCSI); 4 (IDE, generation 1 only). |
| Physical disk pass-through | The operating system determines the maximum size for the virtual machine. |
| Virtual network adapters | 64 standard (generation 2); 8 standard + 4 legacy (generation 1). |
| Virtual SCSI controllers | 4 |
| Virtual SCSI devices | 256. Each SCSI controller supports up to 64 virtual hard disks and/or DVD drives. |
| Virtual IDE controllers (generation 1 only) | 2. Each IDE controller supports up to 2 IDE devices (hard disks and/or DVD drives) per controller. |
| Virtual IDE devices (generation 1 only) | 4. For generation 1 VMs, the startup/boot disk must be attached to one of the IDE devices. |
| Virtual DVD drives | 256 (SCSI); 4 (IDE, generation 1 only). |
| Virtual Fibre Channel adapters | 4. We recommended that you connect each virtual Fibre Channel Adapter to a different virtual SAN. |
| Serial (COM) ports (generation 1 only) | 2 |
| Virtual floppy devices (generation 1 only) | 1 |
| Checkpoints | 50, dependent on the amount of available storage. |

### [Windows Server 2019 host](#tab/windows-server-2019)

Here are the limits for virtual machines on a Hyper-V host running Windows Server 2019:

| Component | Maximum Limit |
|--|--|
| Virtual processors | 240 (generation 2); 64 (generation 1). |
| Memory | 12 TB (generation 2); 1 TB (generation 1). |
| Virtual hard disk capacity | 64 TB (VHDX); 2,040 GB (VHD). |
| Virtual hard disks | 256 (SCSI); 4 (IDE, generation 1 only). |
| Physical disk pass-through | The operating system determines the maximum size for the virtual machine. |
| Virtual network adapters | 64 standard (generation 2); 8 standard + 4 legacy (generation 1). |
| Virtual SCSI controllers | 4 |
| Virtual SCSI devices | 256. Each SCSI controller supports up to 64 virtual hard disks and/or DVD drives. |
| Virtual IDE controllers (generation 1 only) | 2. Each IDE controller supports up to 2 IDE devices (hard disks and/or DVD drives) per controller. |
| Virtual IDE devices (generation 1 only) | 4. For generation 1 VMs, the startup/boot disk must be attached to one of the IDE devices. |
| Virtual DVD drives | 256 (SCSI); 4 (IDE, generation 1 only). |
| Virtual Fibre Channel adapters | 4. We recommended that you connect each virtual Fibre Channel Adapter to a different virtual SAN. |
| Serial (COM) ports (generation 1 only) | 2 |
| Virtual floppy devices (generation 1 only) | 1 |
| Checkpoints | 50, dependent on the amount of available storage. |

### [Windows Server 2016 host](#tab/windows-server-2016)

Here are the limits for virtual machines on a Hyper-V host running Windows Server 2016:

| Component | Maximum Limit |
|--|--|
| Virtual processors | 240 (generation 2); 64 (generation 1). |
| Memory | 12 TB (generation 2); 1 TB (generation 1). |
| Virtual hard disk capacity | 64 TB (VHDX); 2,040 GB (VHD). |
| Virtual hard disks | 256 (SCSI); 4 (IDE, generation 1 only). |
| Physical disk pass-through | The operating system determines the maximum size for the virtual machine. |
| Virtual network adapters | 8 standard (generation 2); 8 standard + 4 legacy (generation 1). |
| Virtual SCSI controllers | 4 |
| Virtual SCSI devices | 256. Each SCSI controller supports up to 64 virtual hard disks and/or DVD drives. |
| Virtual IDE controllers (generation 1 only) | 2. Each IDE controller supports up to 2 IDE devices (hard disks and/or DVD drives) per controller. |
| Virtual IDE devices (generation 1 only) | 4. For generation 1 VMs, the startup/boot disk must be attached to one of the IDE devices. |
| Virtual DVD drives | 256 (SCSI); 4 (IDE, generation 1 only). |
| Virtual Fibre Channel adapters | 4. We recommended that you connect each virtual Fibre Channel Adapter to a different virtual SAN. |
| Serial (COM) ports (generation 1 only) | 2 |
| Virtual floppy devices (generation 1 only) | 1 |
| Checkpoints | 50, dependent on the amount of available storage. |

---

## Maximums for Hyper-V hosts

These maximums apply to each Hyper-V host running Windows Server. Select the relevant tab to see the maximums for each supported version of Windows Server.

### [Windows Server 2025](#tab/windows-server-2025)

Here are the limits for a Hyper-V host running Windows Server 2025:

| Component | Maximum Limit |
|--|--|
| Running virtual machines per server | 1,024 |
| Logical processors | 2,048 |
| Virtual processors available to the host | 2,048. This limit is applied to the host operating system using the Hyper-V root partition. |
| Virtual processors per logical processor | No ratio imposed by Hyper-V. |
| Virtual processors in-use per host | 2,048 |
| Memory | 4 PB (5-level paging); 256 TB (4-level paging). |
| Physical network adapters | No limits imposed by Hyper-V. |
| Network adapter teams (NIC teaming) | No limits imposed by Hyper-V. |
| Virtual network switch ports per server | No limits imposed by Hyper-V. The practical limit depends on the available computing resources. |
| Virtual switches | No limits imposed by Hyper-V. The practical limit depends on the available computing resources. |
| Storage | No limits imposed by Hyper-V. |
| Virtual storage area networks (SANs) | No limits imposed by Hyper-V. |

### [Windows Server 2022](#tab/windows-server-2022)

Here are the limits for a Hyper-V host running Windows Server 2022:

| Component | Maximum Limit |
|--|--|
| Running virtual machines per server | 1,024 |
| Logical processors | 1,024 |
| Virtual processors available to the host | 1,024. This limit is applied to the host operating system using the Hyper-V root partition. |
| Virtual processors per logical processor | No ratio imposed by Hyper-V. |
| Virtual processors in-use per host | 2,048 |
| Memory | 4 PB (5-level paging); 256 TB (4-level paging). |
| Physical network adapters | No limits imposed by Hyper-V. |
| Network adapter teams (NIC teaming) | No limits imposed by Hyper-V. |
| Virtual network switch ports per server | No limits imposed by Hyper-V. The practical limit depends on the available computing resources. |
| Virtual switches | No limits imposed by Hyper-V. The practical limit depends on the available computing resources. |
| Storage | No limits imposed by Hyper-V. |
| Virtual storage area networks (SANs) | No limits imposed by Hyper-V. |

### [Windows Server 2019](#tab/windows-server-2019)

Here are the limits for a Hyper-V host running Windows Server 2019:

| Component | Maximum Limit |
|--|--|
| Running virtual machines per server | 1,024 |
| Logical processors | 512 |
| Virtual processors available to the host | 320. This limit is applied to the host operating system using the Hyper-V root partition. |
| Virtual processors per logical processor | No ratio imposed by Hyper-V. |
| Virtual processors in-use per host | 2,048 |
| Memory | 24 TB |
| Physical network adapters | No limits imposed by Hyper-V. |
| Network adapter teams (NIC teaming) | No limits imposed by Hyper-V. |
| Virtual network switch ports per server | No limits imposed by Hyper-V. The practical limit depends on the available computing resources. |
| Virtual switches | No limits imposed by Hyper-V. The practical limit depends on the available computing resources. |
| Storage | No limits imposed by Hyper-V. |
| Virtual storage area networks (SANs) | No limits imposed by Hyper-V. |

### [Windows Server 2016](#tab/windows-server-2016)

Here are the limits for a Hyper-V host running Windows Server 2016:

| Component | Maximum Limit |
|--|--|
| Running virtual machines per server | 1,024 |
| Logical processors | 512 |
| Virtual processors available to the host | 320. This limit is applied to the host operating system using the Hyper-V root partition. |
| Virtual processors per logical processor | No ratio imposed by Hyper-V. |
| Virtual processors in-use per host | 2,048 |
| Memory | 24 TB |
| Physical network adapters | No limits imposed by Hyper-V. |
| Network adapter teams (NIC teaming) | No limits imposed by Hyper-V. |
| Virtual network switch ports per server | No limits imposed by Hyper-V. The practical limit depends on the available computing resources. |
| Virtual switches | No limits imposed by Hyper-V. The practical limit depends on the available computing resources. |
| Storage | No limits imposed by Hyper-V. |
| Virtual storage area networks (SANs) | No limits imposed by Hyper-V. |

---

## Maximums for Failover Cluster with Hyper-V hosts

These maximums apply in a Failover Cluster with Hyper-V hosts for all supported versions of Windows Server. It's important to do capacity planning to ensure that there's enough hardware resources to run all the virtual machines in a clustered environment.

| Component | Maximum Limit |
|--|--|
| Nodes per cluster | 64 |
| Running virtual machines per cluster | 8,000 |
