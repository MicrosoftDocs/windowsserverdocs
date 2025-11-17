---
title: Manage Hyper-V Hypervisor Scheduler Types
description: Find out about modes of virtual processor scheduling logic that determine how the Hyper-V hypervisor allocates and manages work across guest virtual processors.
ms.author: daknappe
author: dknappettmsft
ms.topic: how-to
ms.date: 04/02/2025
ms.custom: sfi-image-nochange
# customer intent: As an administrator, I want to become familiar with the scheduler types that are available in the Hyper-V hypervisor so that I can optimize the security and performance of virtualization hosts.
---

# Manage Hyper-V hypervisor scheduler types

This article describes the modes of virtual processor scheduling logic in Windows Server and Windows. These modes, or *scheduler types*, determine how the Hyper-V hypervisor allocates and manages work across guest virtual processors. A Hyper-V host administrator can:

- Select hypervisor scheduler types best suited for guest virtual machines (VMs).
- Configure VMs to take advantage of scheduling logic.

## Background

Before you consider the logic and controls behind Hyper-V virtual processor scheduling, it's important to understand certain concepts like simultaneous multithreading (SMT) and how Hyper-V virtualizes processors.

### Understand SMT

SMT is a technique in modern processor design that provides a way for separate, independent execution threads to share processor resources. SMT usually gives a modest performance boost to workloads. It parallelizes computations when possible, increasing instruction throughput. However, when threads compete with each other for shared processor resources, there's sometimes no noticeable improvement in performance. There might even be a slight decrease in performance.

In order to use SMT with Windows Server, you must have a compatible processor. Processors with Intel Hyper-Threading Technology (Intel HT Technology) or Advanced Micro Devices (AMD) SMT are examples of compatible processors.

For the purposes of this article, the descriptions of SMT and how it's used by Hyper-V apply equally to both Intel and AMD systems.

- For more information on Intel HT Technology, see [Intel Hyper-Threading Technology](https://www.intel.com/content/www/us/en/gaming/resources/hyper-threading.html).
- For more information on AMD SMT, see [AMD "Zen" Core Architecture](https://www.amd.com/en/technologies/zen-core.html).

### Understand how Hyper-V virtualizes processors

Before you consider hypervisor scheduler types, you should understand Hyper-V architecture. For a detailed summary of how this architecture works, see [Hyper-V Technology overview](../overview.md). For now, keep the following concepts in mind:

- Hyper-V creates and manages VM partitions, allocating and sharing compute resources across them, under control of the hypervisor. Partitions provide strong isolation boundaries between all guest VMs and between guest VMs and the root partition.

- The root partition is itself a VM partition, although it has unique properties and greater privileges than guest VMs. The root partition:
  - Provides management services that control all guest VMs.
  - Provides virtual device support for guests.
  - Manages all device input and output for guest VMs.

  We recommend not running any application workloads in the root partition.

- A one-to-one mapping exists between the virtual processors of the root partition and the underlying logical processors. A host virtual processor always runs on the same underlying logical processor. There's no migration of root partition virtual processors.

- By default, the logical processors that host the root partition virtual processors can also run guest virtual processors.

- The hypervisor can schedule a guest virtual processor to run on any available logical processor. The hypervisor scheduler tries to consider temporal cache locality, nonuniform memory access (NUMA) topology, and many other factors when it schedules a guest virtual processor. But ultimately, the virtual processor can be scheduled on any host logical processor.

## Hypervisor scheduler types

The Hyper-V hypervisor supports several modes of scheduler logic, which determine how the hypervisor schedules virtual processors on the underlying logical processors. These scheduler types are:

- [The classic scheduler](#the-classic-scheduler)
- [The core scheduler](#the-core-scheduler)
- [The root scheduler](#the-root-scheduler)

### The classic scheduler

The classic scheduler is the default scheduler that's used on all versions of Hyper-V earlier than Windows Server 2019. The classic scheduler provides a fair-share, preemptive, round-robin scheduling model for guest virtual processors.

The classic scheduler type is appropriate for most traditional Hyper-V uses, such as private clouds, hosting providers, and so on. The performance characteristics of the classic scheduler type are optimized to support a wide range of virtualization scenarios, such as:

- Over-subscribing of virtual processors to logical processors.
- Running many heterogeneous VMs and workloads at the same time.
- Running larger-scale high-performance VMs.
- Supporting the full feature set of Hyper-V without restrictions and other scenarios.

### The core scheduler

The hypervisor core scheduler is an alternative to the classic scheduler logic. The core scheduler is available starting with Windows Server 2016 and Windows 10 version 1607. The core scheduler offers a strong security boundary for guest workload isolation. It also reduces performance variability for workloads inside VMs that run on an SMT-enabled virtualization host. The core scheduler supports running both SMT and non-SMT VMs at the same time on the same SMT-enabled virtualization host.

The core scheduler:

- Uses the virtualization host's SMT topology.
- Optionally exposes SMT pairs to guest VMs.
- Schedules groups of guest virtual processors from the same VM onto groups of SMT logical processors.

This work happens symmetrically. If logical processors are in groups of two, virtual processors are scheduled in groups of two, and a core is never shared between VMs. When you schedule a virtual processor for a VM without SMT enabled, that virtual processor consumes the entire core when it runs. When you use the core scheduler:

- It creates a strong security boundary for guest workload isolation. Guest virtual processors can only run on underlying physical core pairs, reducing vulnerability to side-channel snooping attacks.
- It reduces variability in throughput.
- It can potentially reduce performance. If only one virtual processor in a group can run, only one of the instruction streams in the core launches. The other is left idle.
- The operating system (OS) and applications running in the guest VM can use SMT behavior and programming interfaces (APIs) to control and distribute work across SMT threads, just like they do with a physical machine.

As of Windows Server 2019, Hyper-V uses the core scheduler by default. In earlier versions like Windows Server 2016, the core scheduler is optional, and the classic scheduler is the default one.

#### Core scheduler behavior with host SMT disabled

In some cases, you might configure the hypervisor to use the core scheduler type, but the SMT capability is disabled or isn't present on the virtualization host. In these cases, Hyper-V uses the classic scheduler behavior regardless of the hypervisor scheduler type setting.

### The root scheduler

The root scheduler arrived with Windows 10, version 1803. When you enable the root scheduler type, the hypervisor gives the root partition control of work scheduling. In the root partition OS instance, the NT scheduler manages all aspects of assigning work to system logical processors.

The root scheduler addresses the unique requirements to support a utility partition and provide strong workload isolation, as used with Windows Defender Application Guard (WDAG). In this scenario, leaving scheduling responsibilities to the root OS offers several advantages:

- You can use CPU resource controls applicable to container scenarios with the utility partition, simplifying management and deployment.
- The root OS scheduler can readily gather metrics about workload CPU use inside the container. It can use this data as input to the scheduling policy and apply it to all other workloads in the system.
- These same metrics also help attribute work done in an application container to the host system. Tracking these metrics is more difficult with traditional VM workloads, where some work on behalf of all running VMs takes place in the root partition.

#### Root scheduler use on client systems

Starting with Windows 10, version 1803, the root scheduler is used by default on client systems only, which means:

- You can enable the hypervisor to support virtualization-based security and WDAG workload isolation.
- It's important to properly operate future systems with heterogenous core architectures.

This configuration is the only supported hypervisor scheduler configuration for client systems. Administrators shouldn't attempt to override the default hypervisor scheduler type on Windows client systems.

#### VM CPU resource controls and the root scheduler

The resource controls that the Hyper-V hypervisor uses on individual VM processors aren't supported when you enable the hypervisor root scheduler. On the root OS, the scheduler logic manages host resources on a global basis and doesn't manage the guest resources of individual VMs. The Hyper-V per-VM processor resource controls, such as caps, weights, and reserves, only apply where the hypervisor directly controls virtual processor scheduling, such as with the classic and core scheduler types.

#### Root scheduler use on server systems

We don't recommend using the root scheduler with Hyper-V on servers. Its performance characteristics aren't yet fully characterized and tuned to accommodate the wide range of workloads typical of many server virtualization deployments.

## Enable SMT in guest VMs

After you configure the virtualization host's hypervisor to use the core scheduler type, you can also configure guest VMs to use SMT. Specifically, you can specify the number of virtual SMT threads to expose to a guest VM. The guest OS scheduler and VM workloads can then detect and use the SMT topology in their own work scheduling.

- In Windows Server 2016, guest SMT isn't configured by default. A Hyper-V host administrator must explicitly enable it.
- In Windows Server 2019 and later versions, new VMs that you create on the host inherit the host SMT topology by default. For example, a version 9.0 VM that you create on a host with two SMT threads per core also has two SMT threads per core.

You must use PowerShell to enable SMT in a guest VM. There's no user interface provided in Hyper-V Manager.
To enable SMT in a guest VM:

1. Open a PowerShell window by using an account that's a member of the Hyper-V Administrators or equivalent group.

1. Run `Set-VMProcessor -VMName <VM-name> -HwThreadCountPerCore <n>`, where `<n>` is the number of SMT threads per core the guest VM sees. If you use a value of `0` for `<n>`, the `HwThreadCountPerCore` value is set to the host's SMT thread count per core.

   > [!NOTE]
   > Windows Server 2016 doesn't support setting `HwThreadCountPerCore` to `0`.

The following screenshot shows system information taken from the guest OS running in a VM. There are two virtual processors, and SMT is enabled. The guest OS detects two logical processors that belong to the same core.

:::image type="content" source="media/Hyper-V-CoreScheduler-VM-Msinfo32.png" alt-text="Screenshot of the System Information window. The Processor line is selected. It lists information about one core and two processors.":::

## Configure the hypervisor scheduler type

The type of hypervisor scheduler that Hyper-V uses by default depends on the OS version. No matter which scheduler is the default one on your OS, you can configure the hypervisor to use the core scheduler. The core scheduler increases security by restricting guest virtual processors to run on corresponding physical SMT pairs. This configuration supports the use of VMs with SMT scheduling for their guest virtual processors.

> [!NOTE]
> On Windows Server 2016, Hyper-V uses the classic scheduler by default. If you use Hyper-V on Windows Server 2016 or later, we recommend that you select the core scheduler. Making this switch ensures your virtualization hosts are optimally protected against potentially malicious guest VMs.

## Consider impacts on security and performance

To help ensure Hyper-V hosts are deployed in an optimal security configuration, Hyper-V uses the core hypervisor scheduler model by default starting with Windows Server 2019. The host administrator might optionally configure the host to use the legacy classic scheduler. Before overriding the default settings, administrators should carefully read, understand, and consider the impacts each scheduler type has on the security and performance of virtualization hosts. For more information, see [About Hyper-V hypervisor scheduler type selection](./about-hyper-v-scheduler-type-selection.md).

## Select the hypervisor scheduler type on Windows Server

The hypervisor scheduler configuration is controlled by the `hypervisorschedulertype` boot configuration data (BCD) entry.

To select a scheduler type:

1. Open Command Prompt with administrator privileges.

1. Enter `bcdedit /set hypervisorschedulertype <type>`, where `<type>` is one of the following options:

   - `Classic`
   - `Core`
   - `Root`

You must restart the system for any changes you make to the hypervisor scheduler type to take effect.

> [!NOTE]
> The hypervisor root scheduler isn't supported on Hyper-V on Windows Server at this time. Hyper-V administrators shouldn't attempt to configure the root scheduler for use with server virtualization scenarios.

## Determine the current scheduler type

You can determine the hypervisor scheduler type that Hyper-V is currently using by examining the Windows system log. Look for the most recent hypervisor launch event that has an ID of 2. That event reports the hypervisor scheduler type configured at the hypervisor launch. The following values are possible for the hypervisor scheduler type:

| Value | Scheduler type |
| --- | --- |
| 1 | Classic scheduler, SMT disabled |
| 2 | Classic scheduler |
| 3 | Core scheduler |
| 4 | Root scheduler |

You can use Event Viewer or PowerShell to view hypervisor launch event logs.

:::image type="content" source="media/Hyper-V-CoreScheduler-EventID2-Details.png" alt-text="Screenshot of the Event Viewer properties window for a Hyper-V-Hypervisor event with ID 2. Text in the General tab indicates a scheduler type of 0x2.":::

:::image type="content" source="media/Hyper-V-CoreScheduler-EventViewer.png" alt-text="Screenshot of events in Event Viewer. A Hyper-V-Hypervisor launch event with an ID of 2 is selected. A lower pane shows event details.":::

### Use PowerShell to query system logs for a hypervisor launch event

To query the system logs for a hypervisor event with an ID of 2 by using PowerShell, run the following command:

``` powershell
Get-WinEvent -FilterHashTable @{ProviderName="Microsoft-Windows-Hyper-V-Hypervisor"; ID=2} -MaxEvents 1
```

:::image type="content" source="media/Hyper-V-CoreScheduler-PowerShell.png" alt-text="Screenshot of a PowerShell window. A command queries for the latest hypervisor launch event with ID 2. The output shows the scheduler type as 0x2.":::


