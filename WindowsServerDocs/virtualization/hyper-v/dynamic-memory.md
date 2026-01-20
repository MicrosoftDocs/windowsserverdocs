---
title: Dynamic Memory for Hyper-V Virtual Machines
description: Provides an overview of Dynamic Memory for Hyper-V virtual machines, including how it works and best practices.
ms.topic: concept-article
ms.author: daknappe
author: dknappettmsft
ms.date: 10/27/2025
---

# Hyper-V Dynamic Memory Overview

If you have idle or low-load virtual machines, such as in pooled Virtual Desktop Infrastructure (VDI) environments, Dynamic Memory enables you to increase consolidation and improve reliability for restart operations. You also gain agility in responding to requirement changes with these new capabilities.

## Key benefits

With Dynamic Memory, you can attain higher consolidation numbers with improved reliability for restart operations. This capability can lead to lower costs, especially in environments that have many idle or low-load virtual machines, such as pooled VDI environments. Dynamic Memory run-time configuration changes can reduce downtime and provide increased agility to respond to requirement changes.

Hyper-V running on Windows Server automatically calculates an amount of memory to reserve for exclusive use by the management host operating system. This memory is used to run virtualization services. If the computer is part of a failover cluster, Hyper-V also reserves enough memory to run failover cluster services.

## Technical overview

Dynamic Memory defines startup memory (startup RAM) as the minimum amount of memory that a virtual machine can have. However, Windows requires more memory during startup than the steady state. As a result, administrators sometimes assign extra memory to a virtual machine because Hyper-V can't reclaim memory from these virtual machines after startup. Dynamic Memory introduces a minimum memory setting (minimum RAM), which is the minimum amount allocated after startup and allows Hyper-V to reclaim the unused memory from the virtual machines. This feature is reflected as increased virtual machine consolidation numbers, especially in Virtual Desktop Infrastructure (VDI) environments.

Windows Server also introduced Smart Paging for reliable virtual machine restart operations. Although minimum memory increases virtual machine consolidation numbers, it also brings a challenge. If a virtual machine has a smaller amount of memory than its startup memory and if it's restarted, Hyper-V needs additional memory to restart the virtual machine. Due to host memory pressure or virtual machine states, Hyper-V might not always have additional memory available. This limitation can cause sporadic virtual machine restart failures. Smart Paging bridges the memory gap between minimum memory and startup memory, and allows virtual machines to restart reliably.

### Minimum memory configuration with reliable restart operation

As in the previous version of Dynamic Memory, you can configure a minimum memory amount for virtual machines, and Hyper-V continues to ensure that it always assigns this amount to running virtual machines.

To provide a reliable restart experience for virtual machines configured with less minimum memory than startup memory, Hyper-V uses Smart Paging. This memory management method uses disk resources as additional, temporary memory when more memory is required to restart a virtual machine. This approach has advantages and drawbacks. It provides a reliable way to keep the virtual machines running when there's no available physical memory. However, it can degrade virtual machine performance because disk access speeds are much slower than memory access speeds.

> [!IMPORTANT]
> When installing or upgrading the operating system of a virtual machine, the amount of memory that's available to the virtual machine during the installation and upgrade process is the value specified as **Startup RAM**. Even if you configure Dynamic Memory for the virtual machine, the virtual machine uses only the amount of memory configured in the **Startup RAM** setting. Ensure the **Startup RAM** value meets the minimum memory requirements of the operating system during the install or upgrade procedure.

To minimize the performance impact of Smart Paging, Hyper-V uses it only when all of the following conditions occur:

- The virtual machine is being restarted.
- There's no available physical memory.
- No memory can be reclaimed from other virtual machines running on the host.

Hyper-V doesn't use Smart Paging when:

- You start a virtual machine from an "off state" (instead of a restart).
- You oversubscribe memory for a running virtual machine.
- A virtual machine fails over in Hyper-V clusters.

When you oversubscribe host memory, Hyper-V continues to rely on the paging operation in the guest operating system because it's more effective than Smart Paging. The paging operation in the guest operating system is performed by Windows Memory Manager. Windows Memory Manager has more information than the Hyper-V host about memory usage within the virtual machine, which means it can provide Hyper-V with better information to use when choosing the memory to be paged. Because of this, the system incurs less overhead compared to Smart Paging.

To further reduce the impact of Smart Paging, Hyper-V removes memory from the virtual machine after it completes the start process. It accomplishes this goal by coordinating with Dynamic Memory components inside the guest operating system ("ballooning"), so the virtual machine stops using Smart Paging. With this technique, the use of Smart Paging is temporary and isn't expected to last longer than 10 minutes.

Also note the following about how Hyper-V uses Smart Paging:

- It creates Smart Paging files only when needed for a virtual machine.
- It deletes Smart Paging files after it removes the additional amount of memory.
- It doesn't use Smart Paging for this virtual machine again until another restart occurs and there's not enough physical memory.

### Run-time Dynamic Memory configuration changes

Hyper-V enables you to make the following configuration changes to Dynamic Memory when the virtual machine is running:

- Increase the maximum memory.
- Decrease the minimum memory.

## About the Dynamic Memory settings

The following virtual machine settings in Hyper-V Manager allow you to configure Dynamic Memory. Review the following descriptions to understand how the features work and how they are related.

| Setting | Description |
| --- | --- |
| Startup RAM (startup memory) | Specifies the amount of memory required to start the virtual machine. The value needs to be high enough to allow the guest operating system to start, but should be as low as possible to allow for optimal memory utilization and potentially higher consolidation ratios. |
| Minimum RAM (minimum memory) | Specifies the minimum amount of memory that should be allocated to the virtual machine after the virtual machine starts. Set the value as low as 32 MB up to a maximum value equal to the **Startup RAM** value. |
| Maximum RAM (maximum memory) | Specifies the maximum amount of memory that this virtual machine can use. Set the value from as low as the value for Startup RAM up to as high as 1 TB. However, a virtual machine can use only as much memory as the maximum amount supported by the guest operating system. For example, if you specify 64 GB for a virtual machine running a guest operating system that supports a maximum of 32 GB, the virtual machine can't use more than 32 GB. |
| Memory buffer | Specifies how much memory Hyper-V attempts to assign to the virtual machine compared to the amount of memory actually needed by the applications and services running inside the virtual machine. Memory buffer is specified as a percentage because the actual amount of memory that represents the buffer changes in response to changes in memory usage while the virtual machine is running. Hyper-V uses performance counters in the virtual machine that identify committed memory to determine the current memory requirements of the virtual machine and then calculates the amount of memory to add as a buffer. The buffer is determined using the following formula: **Amount of memory buffer = how much memory the virtual machine actually needs x (memory buffer value / 100)**. For example, if the memory committed to the guest operating system is 1,000 MB and the memory buffer is 20%, Hyper-V attempts to allocate an additional 20% (200 MB) for a total of 1,200 MB of physical memory allocated to the virtual machine. **Note:** The buffer isn't maintained when there's not enough physical memory available in the computer to give every virtual machine its requested memory buffer. |
| Memory weight | Provides Hyper-V with a way to determine how to distribute memory among virtual machines if there's not enough physical memory available in the computer to give every virtual machine its requested amount of memory. |

## Dynamic Memory / Hyper-V Memory Management FAQs

The following are some frequently asked questions regarding Dynamic Memory.

### Do I need to manually configure the size of the page file after installing the Hyper-V role?

No, it's recommended to allow the system to manage the page file size when running Hyper-V.

### How is the memory divided between the host operating system and running virtual machines?

Hyper-V monitors the runtime health of the host operating system to determine how much memory it can safely allocate to virtual machines.

### My virtual machine failed to start with the following error message “Not enough memory in the system to start the virtual machine” or “Could not initialize memory: Ran out of memory (0x8007000E)”. How can I tell how much memory is available for virtual machines?

As described earlier, Hyper-V monitors the runtime health of the host operating system to determine how much memory it can safely allocate to virtual machines.

You can view the current amount of memory available to virtual machines in the following Performance Monitor counter: **Hyper-V Dynamic Memory Balancer – Available Memory**.
