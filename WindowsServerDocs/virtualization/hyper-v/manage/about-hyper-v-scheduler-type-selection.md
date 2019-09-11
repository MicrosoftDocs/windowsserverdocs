---
title: About Hyper-V hypervisor scheduler type selection
description: Provides information for Hyper-V host administrators on the use of Hyper-V's scheduler modes
author: allenma
ms.author: allenma
ms.date: 08/14/2018
ms.topic: article
ms.prod: windows-server-hyper-v
ms.technology: virtualization
ms.localizationpriority: low
ms.assetid: 5fe163d4-2595-43b0-ba2f-7fad6e4ae069
---
# About Hyper-V hypervisor scheduler type selection

Applies To:

* Windows Server 2016
* Windows Server, version 1709
* Windows Server, version 1803
* Windows Server 2019

This document describes important changes to Hyper-V's default and recommended use of hypervisor scheduler types. These changes impact both system security and virtualization performance. Virtualization host administrators should review and understand the changes and implications described in this document, and carefully evaluate the impacts, suggested deployment guidance and risk factors involved to best understand how to deploy and manage Hyper-V hosts in the face of the rapidly changing security landscape.

>[!IMPORTANT]
>Currently known side-channel security vulnerabilities sighted in multiple processor architectures could be exploited by a malicious guest VM through the scheduling behavior of the legacy hypervisor classic scheduler type when run on hosts with Simultaneous Multithreading (SMT) enabled.  If successfully exploited, a malicious workload could observe data outside its partition boundary. This class of attacks can be mitigated by configuring the Hyper-V hypervisor to utilize the hypervisor core scheduler type and reconfiguring guest VMs. With the core scheduler, the hypervisor restricts a guest VM's VPs to run on the same physical processor core, therefore strongly isolating the VM's ability to access data to the boundaries of the physical core on which it runs.  This is a highly effective mitigation against these side-channel attacks, which prevents the VM from observing any artifacts from other partitions, whether the root or another guest partition.  Therefore, Microsoft is changing the default and recommended configuration settings for virtualization hosts and guest VMs.

## Background

Starting with Windows Server 2016, Hyper-V supports several methods of scheduling and managing virtual processors, referred to as hypervisor scheduler types.  A detailed description of all hypervisor scheduler types can be found in [Understanding and using Hyper-V hypervisor scheduler types](https://docs.microsoft.com/windows-server/virtualization/hyper-v/manage/manage-hyper-v-scheduler-types).

>[!NOTE]
>New hypervisor scheduler types were first introduced with Windows Server 2016, and are not available in prior releases. All versions of Hyper-V prior to Windows Server 2016 support only the classic scheduler. Support for the core scheduler was only recently published.

## About hypervisor scheduler types

This article focuses specifically on the use of the new hypervisor core scheduler type versus the legacy "classic" scheduler, and how these scheduler types intersect with the use of Symmetric Multi-Threading, or SMT.  It is important to understand the differences between the core and classic schedulers and how each places work from guest VMs on the underlying system processors.

### The classic scheduler

The classic scheduler refers to the fair-share, round robin method of scheduling work on virtual processors (VPs) across the system - including root VPs as well as VPs belonging to guest VMs. The classic scheduler has been the default scheduler type used on all versions of Hyper-V (until Windows Server 2019, as described herein).  The performance characteristics of the classic scheduler are well understood, and the classic scheduler is demonstrated to ably support over-subscription of workloads - that is, over-subscription of the host's VP:LP ratio by a reasonable margin (depending on the types of workloads being virtualized, overall resource utilization, etc.).

When run on a virtualization host with SMT enabled, the classic scheduler will schedule guest VPs from any VM on each SMT thread belonging to a core independently. Therefore, different VMs can be running on the same core at the same time (one VM running on one thread of a core while another VM is running on the other thread).

### The core scheduler

The core scheduler leverages the properties of SMT to provide isolation of guest workloads, which impacts both security and system performance. The core scheduler ensures that VPs from a VM are scheduled on sibling SMT threads. This is done symmetrically so that if LPs are in groups of two, VPs are scheduled in groups of two, and a system CPU core is never shared between VMs.

By scheduling guest VPs on underlying SMT pairs, the core scheduler offers a strong security boundary for workload isolation, and can also be used to reduce performance variability for latency sensitive workloads.

Note that when the VP is scheduled for a virtual machine without SMT enabled, that VP will consume the entire core when it runs, and the core's sibling SMT thread will be left idle.  This is necessary to provide the correct workload isolation, but impacts overall system performance, especially as the system LPs become over-subscribed - that is, when total VP:LP ratio exceeds 1:1. Therefore, running guest VMs configured without multiple threads per core is a sub-optimal configuration.

### Benefits of the using the core scheduler

The core scheduler offers the following benefits:

* A strong security boundary for guest workload isolation - Guest VPs are constrained to run on underlying physical core pairs, reducing vulnerability to side-channel snooping attacks.

* Reduced workload variability - Guest workload throughput variability is significantly reduced, offering greater workload consistency.

* Use of SMT in guest VMs - The OS and applications running in the guest virtual machine can utilize SMT behavior and programming interfaces (APIs) to control and distribute work across SMT threads, just as they would when run non-virtualized.

The core scheduler is currently used on Azure virtualization hosts, specifically to take advantage of the strong security boundary and low workload variabilty. Microsoft believes that the core scheduler type should be and will continue to be the default hypervisor scheduling type for the majority of virtualization  scenarios.  Therefore, to ensure our customers are secure by default, Microsoft is making this change for Windows Server 2019 now.

### Core scheduler performance impacts on guest workloads

While required to effectively mitigate certain classes of vulnerabilities, the core scheduler may also potentially reduce performance. Customers may see a difference in the performance characteristics with their VMs and impacts to the overall workload capacity of their virtualization hosts. In cases where the core scheduler must run a non-SMT VP, only one of the instruction streams in the underlying logical core executes while the other must be left idle. This will limit the total host capacity for guest workloads.

These performance impacts can be minimized by following the deployment guidance in this document. Host administrators must carefully consider their specific virtualization deployment scenarios and balance their tolerance for security risk against the need for maximum workload density, over-consolidation of  virtualization hosts, etc.

## Changes to the default and recommended configurations for Windows Server 2016 and Windows Server 2019

Deploying Hyper-V hosts with the maximum security posture requires use of the hypervisor core scheduler type. To ensure our customers are secure by default, Microsoft is changing the following default and recommended settings.

>[!NOTE]
>While the hypervisor's internal support for the scheduler types was included in the initial release of Windows Server 2016, Windows Server 1709, and Windows Server 1803, updates are required in order to access the configuration control which allows selecting the hypervisor scheduler type.  Please refer to [Understanding and using Hyper-V hypervisor scheduler types](https://docs.microsoft.com/windows-server/virtualization/hyper-v/manage/manage-hyper-v-scheduler-types) for details on these updates.

### Virtualization host changes

* The hypervisor will use the core scheduler by default beginning with Windows Server 2019.

* Microsoft reccommends configuring the core scheduler on Windows Server 2016. The hypervisor core scheduler type is supported in Windows Server 2016, however the default is the classic scheduler. The core scheduler is optional and must be explicitly enabled by the Hyper-V host administrator.

### Virtual machine configuration changes

* On Windows Server 2019, new virtual machines created using the default VM version 9.0 will automatically inherit the SMT properties (enabled or disabled) of the virtualization host. That is, if SMT is enabled on the physical host, newly created VMs will also have SMT enabled, and will inherit the SMT topology of the host by default, with the VM having the same number of hardware threads per core as the underlying system. This will be reflected in the VM's configuration with HwThreadCountPerCore = 0, where 0 indicates the VM should inherit the host's SMT settings.

* Existing virtual machines with a VM version of 8.2 or earlier will retain their original VM processor setting for HwThreadCountPerCore, and the default for 8.2 VM version guests is HwThreadCountPerCore = 1. When these guests run on a Windows Server 2019 host, they will be treated as follows:

    1. If the VM has a VP count that is less than or equal to the count of LP cores, the VM will be treated as a non-SMT VM by the core scheduler. When the guest VP runs on a single SMT thread, the core's sibling SMT thread will be idled. This is non-optimal, and will result in overall loss of performance.

    2. If the VM has more VPs than LP cores, the VM will be treated as an SMT VM by the core scheduler. However, the VM will not observe other indications that it is an SMT VM. For example, use of the CPUID instruction or Windows APIs to query CPU toplogy by the OS or applications will not indicate that SMT is enabled.

* When an existing VM is explicitly updated from eariler VM versions to version 9.0 through the Update-VM operation, the VM will retain its current value for HwThreadCountPerCore.  The VM will not have SMT force-enabled.

* On Windows Server 2016, Microsoft recommends enabling SMT for guest VMs.  By default, VMs created on Windows Server 2016 would have SMT disabled, that is HwThreadCountPerCore is set to 1, unless explicitly changed.

>[!NOTE]
>Windows Server 2016 does not support setting HwThreadCountPerCore to 0.

#### Managing virtual machine SMT configuration

The guest virtual machine SMT configuration is set on a per-VM basis. The host administrator can inspect and configure a VM's SMT configuration to select from the following options:

    1. Configure VMs to run as SMT-enabled, optionally inheriting the host SMT topology automatically

    2. Configure VMs to run as non-SMT

The SMT configuaration for a VM is displayed in the Summary panes in the Hyper-V Manager console.  Configuring a VM's SMT settings may be done by using the VM Settings or PowerShell.

#### Configuring VM SMT settings using PowerShell

To configure the SMT settings for a guest virtual machine, open a PowerShell window with sufficient permissions, and type:

``` powershell
Set-VMProcessor -VMName <VMName> -HwThreadCountPerCore <0, 1, 2>
```

Where:

    0 = Inherit SMT topology from the host (this setting of HwThreadCountPerCore=0 is not supported on Windows Server 2016)

    1 = Non-SMT

    Values > 1 = the desired number of SMT threads per core. May not exceed the number of physical SMT threads per core.

To read the SMT settings for a guest virtual machine, open a PowerShell window with sufficient permissions, and type:

``` powershell
(Get-VMProcessor -VMName <VMName>).HwThreadCountPerCore
```

Note that guest VMs configured with HwThreadCountPerCore = 0 indicates that SMT will be enabled for the guest, and will expose the same number of SMT threads to the guest as they are on the underlying virtualization host, typically 2.

### Guest VMs may observe changes to CPU topology across VM mobility scenarios

The OS and applications in a VM may see changes to both host and VM settings before and after VM lifecycle events such as live migration or save and restore operations. During an operation in which VM state is saved and restored, both the VM's HwThreadCountPerCore setting and the realized value (that is, the computed combination of the VM's setting and source host's configuration) are migrated. The VM will continue running with these settings on the destination host. At the point the VM is shutdown and re-started, it's possible that the realized value observed by the VM will change. This should be benign, as OS and application layer software should look for CPU topology information as part of their normal startup and initialization code flows. However, because these boot time initialization sequences are skipped during live migration or save/restore operations, VMs that undergo these state transitions could observe the originally computed realized value until they are shut down and re-started.  

### Alerts regarding non-optimal VM configurations

Virtual machines configured with more VPs than there are physical cores on the host result in a non-optimal configuration. The hypervisor scheduler will treat these VMs as if they are SMT-aware. However, OS and application software in the VM will be presented a CPU topology showing SMT is disabled. When this condition is detected, the Hyper-V Worker Process will log an event on the virtualization host warning the host administrator that the VM's configuration is non-optimal, and recommending SMT be enabled for the VM.

#### How to identify non-optimally configured VMs

You can identify non-SMT VMs by examining the System Log in Event Viewer for Hyper-V Worker Process event ID 3498, which will be triggered for a VM whenever the number of VPs in the VM is greater than the physical core count. Worker process events can be obtained from Event Viewer, or via PowerShell.

#### Querying the Hyper-V worker process VM event using PowerShell

To query for Hyper-V worker process event ID 3498 using PowerShell, enter the following commands from a PowerShell prompt.

``` powershell
Get-WinEvent -FilterHashTable @{ProviderName="Microsoft-Windows-Hyper-V-Worker"; ID=3498}
```

### Impacts of guest SMT configuaration on the use of hypervisor enlightenments for guest operating systems

The Microsoft hypervisor offers multiple enlightenments, or hints, which the OS running in a guest VM may query and use to trigger optimizations, such as those that might benefit performance or otherwise improve handling of various conditions when running virtualized. One recently introduced  enlightenment concerns the handling of virtual processor scheduling and the use of OS mitigations for side-channel attacks that exploit SMT.

>[!NOTE]
>Microsoft recommends that host administrators enable SMT for guest VMs to optimize workload performance.

The details of this guest enlightenment are provided below, however the key takeaway for virtualization host administrators is that virtual machines should have HwThreadCountPerCore configured to match the host's physical SMT configuration. This allows the hypervisor to report that there is no non-architectural core sharing. Therefore, any guest OS supporting optimizations that require the enlightenment may be enabled. On Windows Server 2019, create new VMs and leave the default value of HwThreadCountPerCore (0). Older VMs migrated from Windows Server 2016 hosts can be updated to the Windows Server 2019 configuration version. After doing so, Microsoft recommends setting HwThreadCountPerCore = 0.  On Windows Server 2016, Microsoft recommends setting HwThreadCountPerCore to match the host configuration (typically 2).

### NoNonArchitecturalCoreSharing enlightenment details

Starting in Windows Server 2016, the hypervisor defines a new enlightenment to describe its handling of VP scheduling and placement to the guest OS. This enlightenment is defined in the [Hypervisor Top Level Functional Specification v5.0c](https://docs.microsoft.com/virtualization/hyper-v-on-windows/reference/tlfs).

Hypervisor synthetic CPUID leaf CPUID.0x40000004.EAX:18[NoNonArchitecturalCoreSharing = 1] indicates that a virtual processor will never share a physical core with another virtual processor, except for virtual processors that are reported as sibling SMT threads. For example, a guest VP will never run on an SMT thread alongside a root VP running simultaneously on a sibling SMT thread on the same processor core. This condition is only possible when running virtualized, and so represents a non-architectural SMT behavior that also has serious security implications. The guest OS can use NoNonArchitecturalCoreSharing = 1 as an indication that it is safe to enable optimizations, which may help it avoid the performance overhead of setting STIBP.

In certain configurations, the hypervisor will not indicate that NoNonArchitecturalCoreSharing = 1. As an example, if a host has SMT enabled and is configured to use the hypervisor classic scheduler, NoNonArchitecturalCoreSharing will be 0. This may prevent enlightened guests from enabling certain optimizations. Therefore, Microsoft recommends that host administrators using SMT rely on the hypervisor core scheduler and ensure that virtual machines are configured to inherit their SMT configuration from the host to ensure optimal workload performance.

## Summary

The security threat landscape continues to evolve. To ensure our customers are secure by default, Microsoft is changing the default configuration for the hypervisor and virtual machines starting in Windows Server 2019 Hyper-V, and providing updated guidance and recommendations for customers running Windows Server 2016 Hyper-V. Virtualization host administrators should:

* Read and understand the guidance provided in this document

* Carefully evaluate and adjust their virtualization deployments to ensure they meet the security, performance, virtualization density, and workload responsiveness goals for their unique requirements

* Consider re-configuring existing Windows Server 2016 Hyper-V hosts to leverage the strong security benefits offered by the hypervisor core scheduler

* Update existing non-SMT VMs to reduce the performance impacts from scheduling constraints imposed by VP isolation that addresses hardware security vulnerabilities
