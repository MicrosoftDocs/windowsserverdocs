---
title: Understanding and using Hyper-V hypervisor scheduler types
description: Learn about new modes of virtual processor scheduling logic that determine how the Hyper-V hypervisor allocates and manages work across guest virtual processors.
ms.author: wscontent
author: BenjaminArmstrong
ms.date: 06/12/2023
ms.topic: article
ms.assetid: 6cb13f84-cb50-4e60-a685-54f67c9146be
---

# Manage Hyper-V hypervisor scheduler types

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server version 1803, Windows Server version 1709, Windows 10

This article describes new modes of virtual processor scheduling logic introduced in Windows Server 2016. These modes, or *scheduler types*, determine how the Hyper-V hypervisor allocates and manages work across guest virtual processors. A Hyper-V host administrator can:

- Select hypervisor scheduler types best suited for guest virtual machines (VMs).
- Configure VMs to take advantage of scheduling logic.

> [!NOTE]
> You must have all [required updates](#required-updates) in order to use the hypervisor scheduler features.

## Background

Before discussing the logic and controls behind Hyper-V virtual processor scheduling, it's helpful to review the basic concepts covered in this article.

### Understand SMT

Simultaneous multithreading (SMT) is a technique in modern processor designs that lets separate, independent execution threads share processor resources. SMT usually gives a modest performance boost to most workloads. It parallelizes computations when possible, increasing instruction throughput. No performance gain or even a slight loss in performance might occur when contention between threads for shared processor resources occurs.

Processors supporting SMT are available from both Intel and AMD. Intel refers to their SMT offerings as Intel Hyper Threading Technology, or Intel HT.

For the purposes of this article, the descriptions of SMT and how it's used by Hyper-V apply equally to both Intel and AMD systems.

- For more information on Intel HT Technology, see [Intel Hyper-Threading Technology](https://www.intel.com/content/www/us/en/architecture-and-technology/hyper-threading/hyper-threading-technology.html).

- For more information on AMD SMT, see [The "Zen" Core Architecture](https://www.amd.com/en/technologies/zen-core).

## Understand how Hyper-V virtualizes processors

Before considering hypervisor scheduler types, it's also helpful to understand the Hyper-V architecture. You can find a general summary in [Hyper-V technology overview](../hyper-v-technology-overview.md). The following concepts are important for this article:

- Hyper-V creates and manages VM partitions, across which compute resources are allocated and shared, under control of the hypervisor. Partitions provide strong isolation boundaries between all guest VMs and between guest VMs and the root partition.

- The root partition is itself a VM partition, although it has unique properties and greater privileges than guest VMs. The root partition:

  - Provides the management services that control all guest VMs.
  - Provides virtual device support for guests.
  - Manages all device I/O for guest VMs.

  We recommend not running any application workloads in the root partition.

- Each virtual processor (VP) of the root partition is mapped 1:1 to an underlying logical processor (LP). A host VP always runs on the same underlying LP. There's no migration of the root partition's VPs.

- By default, the LPs on which host VPs run can also run guest VPs.

- Hypervisor might schedule the guest VP to run on any available logical processor. While the hypervisor scheduler tries to consider temporal cache locality, non-uniform memory access (NUMA) topology, and many other factors when scheduling a guest VP, ultimately the VP can be scheduled on any host LP.

## Hypervisor scheduler types

In Windows Server 2016, the Hyper-V hypervisor supports several modes of scheduler logic, which determine how the hypervisor schedules virtual processors on the underlying logical processors. These scheduler types are:

- [The classic scheduler](#the-classic-scheduler).
- [The core scheduler](#the-core-scheduler).
- [The root scheduler](#the-root-scheduler).

### The classic scheduler

The classic scheduler has been the default for all versions of the Windows Hyper-V hypervisor since its inception, including Windows Server 2016 Hyper-V. The classic scheduler provides a fair share, preemptive, round-robin scheduling model for guest virtual processors.

The classic scheduler type is the most appropriate for most traditional Hyper-V uses, such as private clouds, hosting providers, and so on. The performance characteristics are well understood and best optimized to support a wide range of virtualization scenarios, such as:

- Over-subscribing of VPs to LPs.
- Running many heterogeneous VMs and workloads simultaneously.
- Running larger scale high-performance VMs.
- Supporting the full feature set of Hyper-V without restrictions and other scenarios.

### The core scheduler

The hypervisor core scheduler is an alternative to the classic scheduler logic and was introduced in Windows Server 2016 and Windows 10 version 1607. The core scheduler offers a strong security boundary for guest workload isolation and reduced performance variability for workloads inside of VMs that are running on an SMT-enabled virtualization host. The core scheduler supports running both SMT and non-SMT VMs simultaneously on the same SMT-enabled virtualization host.

The core scheduler:

- Uses the virtualization host's SMT topology.
- Optionally exposes SMT pairs to guest VMs.
- Schedules groups of guest virtual processors from the same VM onto groups of SMT logical processors.

This work happens symmetrically. If LPs are in groups of two, VPs are scheduled in groups of two, and a core is never shared between VMs. When you schedule the VP for a VM without SMT enabled, that VP consumes the entire core when it runs. The overall result of the core scheduler is that:

- Guest VPs are constrained to run on underlying physical core pairs, isolating a VM to processor core boundaries, and reducing vulnerability to side-channel snooping attacks from malicious VMs.
- Variability in throughput is reduced.
- Performance is potentially reduced. If only one in a group of VPs can run, only one of the instruction streams in the core launches while the other is left idle.
- The OS and applications running in the guest VM can use SMT behavior and programming interfaces (APIs) to control and distribute work across SMT threads, just as they would when not virtual.
- A strong security boundary exists for guest workload isolation. Guest VPs are constrained to run on underlying physical core pairs, reducing vulnerability to side-channel snooping attacks.

The core scheduler is used by default starting in Windows Server 2019. On Windows Server 2016, the core scheduler is optional. The Hyper-V host administrator must explicitly enable it. The classic scheduler is the default.

#### Core scheduler behavior with host SMT disabled

In some cases, you might configure the hypervisor to use the core scheduler type, but the SMT capability is disabled or isn't present on the virtualization host. In these cases, the classic scheduler behavior is used regardless of the hypervisor scheduler type setting.

### The root scheduler

The root scheduler was introduced with Windows 10 version 1803. When the root scheduler type is enabled, the hypervisor cedes control of work scheduling to the root partition. The NT scheduler in the root partition's OS instance manages all aspects of scheduling work to system LPs.

The root scheduler addresses the unique requirements inherent with supporting a utility partition to provide strong workload isolation, as used with Windows Defender Application Guard (WDAG). In this scenario, leaving scheduling responsibilities to the root OS offers several advantages.

- You can use CPU resource controls applicable to container scenarios with the utility partition, simplifying management and deployment.
- The root OS scheduler can readily gather metrics about workload CPU use inside the container. It can use this data as input to the same scheduling policy applicable to all other workloads in the system.
- These same metrics also help attribute work done in an application container to the host system. Tracking these metrics is more difficult with traditional VM workloads, where some work on behalf of all running VMs takes place in the root partition.

#### Root scheduler use on client systems

In Windows 10 version 1803, the root scheduler is used by default on client systems only, where:

- The hypervisor might be enabled in support of virtualization-based security and WDAG workload isolation.
- Proper operation of future systems with heterogeneous core architectures is helpful.

It's the only supported hypervisor scheduler configuration for client systems. Administrators shouldn't attempt to override the default hypervisor scheduler type on Windows 10 client systems.

#### Virtual Machine CPU resource controls and the root scheduler

The VM processor resource controls provided by Hyper-V aren't supported when the hypervisor root scheduler is enabled. The root operating system's scheduler logic is managing host resources on a global basis and doesn't have knowledge of a VM's specific configuration settings. The Hyper-V per-VM processor resource controls, such as caps, weights, and reserves, are only applicable where the hypervisor directly controls VP scheduling, such as with the classic and core scheduler types.

#### Root scheduler use on server systems

At this time, we don't recommend using the root scheduler with Hyper-V on servers. Its performance characteristics haven't yet been fully characterized and tuned to accommodate the wide range of workloads typical of many server virtualization deployments.

## Enable SMT in guest VMs

Once the virtualization host's hypervisor is configured to use the core scheduler type, you can configure guest VMs to use SMT. Exposing the fact that VPs are hyperthreaded to a guest VM lets the scheduler in the guest operating system, and workloads running in the VM, detect and use the SMT topology in their own work scheduling.

- In Windows Server 2016, guest SMT isn't configured by default. A Hyper-V host administrator must explicitly enable it.
- In Windows Server 2019, new VMs you create on the host inherits the host's SMT topology by default. That is, a version 9.0 VM that you create on a host with two SMT threads per core would also see two SMT threads per core.

You must use PowerShell to enable SMT in a guest VM. There's no user interface provided in Hyper-V Manager.
To enable SMT in a guest VM, open a PowerShell window with sufficient permissions and enter `Set-VMProcessor -VMName <VMName> -HwThreadCountPerCore <n>`, where `\<n>` is the number of SMT threads per core the guest VM sees. `\<n> = 0` sets the `HwThreadCountPerCore` value to match the host's SMT thread count per core value.

> [!NOTE]
> Setting `HwThreadCountPerCore = 0` is supported beginning with Windows Server 2019.

The following example shows system information taken from the guest operating system running in a VM. There are two virtual processors and SMT enabled. The guest operating system is detecting two logical processors belonging to the same core.

![Screenshot that shows msinfo32 in a guest VM with SMT enabled.](media/Hyper-V-CoreScheduler-VM-Msinfo32.png)

## Configure the hypervisor scheduler type on Windows Server 2016 Hyper-V

Windows Server 2016 Hyper-V uses the classic hypervisor scheduler model by default. You can optionally configure the hypervisor to use the core scheduler. The core scheduler increases security by restricting guest VPs to run on corresponding physical SMT pairs. This configuration supports the use of VMs with SMT scheduling for their guest VPs.

> [!NOTE]
> We recommend that all customers running Windows Server 2016 Hyper-V select the core scheduler to ensure their virtualization hosts are optimally protected against potentially malicious guest VMs.

## Windows Server 2019 Hyper-V defaults to using the core scheduler

To ensure Hyper-V hosts are deployed in the optimal security configuration, Windows Server 2019 Hyper-V now uses the core hypervisor scheduler model by default. The host administrator might optionally configure the host to use the legacy classic scheduler. Prior to overriding the default settings, administrators should carefully read, understand, and consider the impacts each scheduler type has on the security and performance of virtualization hosts. For more information, see [About Hyper-V hypervisor scheduler type selection](./about-hyper-v-scheduler-type-selection.md).

### Required updates

The following updates are required to use the hypervisor scheduler features described in this document. These updates include changes to support the new `hypervisorschedulertype` BCD option, which is necessary for host configuration.

| Version | Release  | Update Required | KB Article |
|--------------------|------|---------|-------------:|
|Windows Server 2016 | 1607 | 2018.07 C | [KB4338822](https://support.microsoft.com/help/4338822/windows-10-update-kb4338822) |
|Windows Server 2016 | 1703 | 2018.07 C | [KB4338827](https://support.microsoft.com/help/4338827/windows-10-update-kb4338827) |
|Windows Server 2016 | 1709 | 2018.07 C | [KB4338817](https://support.microsoft.com/help/4338817/windows-10-update-kb4338817) |
|Windows Server 2019 | 1804 | None | None |

## Select the hypervisor scheduler type on Windows Server

The hypervisor scheduler configuration is controlled via the `hypervisorschedulertype` BCD entry.

To select a scheduler type, open a command prompt with administrator privileges and enter `bcdedit /set hypervisorschedulertype type`, where `type` is one of these options:

- Classic
- Core
- Root

You must reboot the system for any changes to the hypervisor scheduler type to take effect.

> [!NOTE]
> The hypervisor root scheduler isn't supported on Windows Server Hyper-V at this time. Hyper-V administrators shouldn't attempt to configure the root scheduler for use with server virtualization scenarios.

## Determine the current scheduler type

You can determine the current hypervisor scheduler type in use by examining the Event Viewer system log. You can see the most recent hypervisor launch event ID 2, which reports the hypervisor scheduler type configured at hypervisor launch. You can get the hypervisor launch events from the Windows Event Viewer or in PowerShell.

Hypervisor launch event ID 2 denotes the hypervisor scheduler type, where:

- 1 = Classic scheduler, SMT disabled
- 2 = Classic scheduler
- 3 = Core scheduler
- 4 = Root scheduler

![Screenshot showing hypervisor launch event ID 2 details.](media/Hyper-V-CoreScheduler-EventID2-Details.png)

![Screenshot showing Event Viewer displaying hypervisor launch event ID 2.](media/Hyper-V-CoreScheduler-EventViewer.png)

### Query the Hyper-V hypervisor scheduler type launch event using PowerShell

To query for hypervisor event ID 2 using PowerShell, enter the following commands from a PowerShell prompt.

``` powershell
Get-WinEvent -FilterHashTable @{ProviderName="Microsoft-Windows-Hyper-V-Hypervisor"; ID=2} -MaxEvents 1
```

![Screenshot showing PowerShell query and results for hypervisor launch event ID 2.](media/Hyper-V-CoreScheduler-PowerShell.png)
