---
title: Hyper-V technology overview
description: Describes what Hyper-V is, how to get it, key features, and common uses. This article includes an overview for Hyper-V in Windows and Windows Server.
ms.topic: overview
ms.assetid: ac069fed-7bf5-4cc3-aff5-25a2766040b8
ms.author: mosagie
author: meaghanlewis
ms.date: 05/27/2025
ms.subservice: core-os
zone_pivot_groups: windows
---

# Hyper-V technology overview

Hyper-V is Microsoft's hardware virtualization product. It lets you create and run a software version of a computer, called a *virtual machine*. Each virtual machine acts like a complete computer, running an operating system and programs. When you need compute resources, virtual machines give you more flexibility, help save time and money, and are a more efficient way to use hardware than just running one operating system on physical hardware.

Hyper-V runs each virtual machine in its own isolated space, which means you can run more than one virtual machine on the same hardware at the same time. You might want to do this to avoid problems such as a crash affecting the other workloads, or to give different people, groups, or services access to different systems.

## Some ways Hyper-V can help you

Hyper-V can help you:

- **Establish or expand a private cloud environment.** Provide more flexible, on-demand IT services by moving to or expanding your use of shared resources and adjust utilization as demand changes.

- **Use your hardware more effectively.** Consolidate servers and workloads onto fewer, more powerful physical computers to use less power, and physical space.

- **Improve business continuity.** Minimize the impact of both scheduled and unscheduled downtime of your workloads.

- **Establish or expand a virtual desktop infrastructure (VDI).** Use a centralized desktop strategy with VDI can help you increase business agility and data security, as well as simplify regulatory compliance and manage desktop operating systems and applications. Deploy Hyper-V and Remote Desktop Virtualization Host (RD Virtualization Host) on the same server to make personal virtual desktops or virtual desktop pools available to your users.

- **Make development and test more efficient.** Reproduce different computing environments without having to buy or maintain all the hardware you'd need if you only used physical systems.

## Hyper-V and other virtualization products

Hyper-V in Windows and Windows Server replaces older hardware virtualization products, such as Microsoft Virtual PC, Microsoft Virtual Server, and Windows Virtual PC. Hyper-V offers networking, performance, storage, and security features not available in these older products.

Hyper-V and most third-party virtualization applications that require the same processor features aren't compatible. That's because the processor features, known as hardware virtualization extensions, are designed to not be shared. For details, see [Virtualization applications don't work together with Hyper-V, Device Guard, and Credential Guard](https://support.microsoft.com/kb/3204980).

## What features does Hyper-V have?

Hyper-V offers many features. This is an overview, grouped by what the features provide or help you do.

**Computing environment** - A Hyper-V virtual machine includes the same basic parts as a physical computer, such as memory, processor, storage, and networking. All these parts have features and options that you can configure different ways to meet different needs. Storage and networking can each be considered categories of their own, because of the many ways you can configure them.

**Disaster recovery and backup** - For disaster recovery, Hyper-V Replica creates copies of virtual machines, intended to be stored in another physical location, so you can restore the virtual machine from the copy. For backup, Hyper-V offers two types. One uses saved states and the other uses Volume Shadow Copy Service (VSS) so you can make application-consistent backups for programs that support VSS.

**Optimization** - Each supported guest operating system has a customized set of services and drivers, called *integration services*, that make it easier to use the operating system in a Hyper-V virtual machine.

**Portability** - Features such as live migration, storage migration, and import/export make it easier to move or distribute a virtual machine.

**Remote connectivity** - Hyper-V includes Virtual Machine Connection, a remote connection tool for use with both Windows and Linux. Unlike Remote Desktop, this tool gives you console access, so you can see what's happening in the guest even when the operating system isn't booted yet.

**Security** - Secure boot and shielded virtual machines help protect against malware and other unauthorized access to a virtual machine and its data.

## How to get Hyper-V

Hyper-V is available in Windows Server and Windows.

:::zone pivot="windows-server"

 Hyper-V is a server role available for x64 versions of Windows Server. For server instructions, see [Install the Hyper-V role on Windows Server](get-started/Install-the-Hyper-V-role-on-Windows-Server.md).

::: zone-end

:::zone pivot="windows"

On Windows, Hyper-V available as feature in some 64-bit versions of Windows. It's also available as a downloadable, standalone server product, [Microsoft Hyper-V Server](https://www.microsoft.com/evalcenter/evaluate-hyper-v-server-2019).

::: zone-end

## Supported operating systems

Many operating systems run on virtual machines. In general, an operating system that uses an x86 architecture runs on a Hyper-V virtual machine. Not all operating systems that can be run are tested and supported by Microsoft, however. For lists of what Microsoft supports, see:

:::zone pivot="windows-server"

[Supported Windows guest operating systems for Hyper-V on Windows Server](/windows-server/virtualization/hyper-v/supported-windows-guest-operating-systems-for-hyper-v-on-windows)

::: zone-end

:::zone pivot="windows"

[Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](/windows-server/virtualization/hyper-v/supported-linux-and-freebsd-virtual-machines-for-hyper-v-on-windows)

::: zone-end

## How Hyper-V works

Hyper-V is a hypervisor-based virtualization technology. Hyper-V uses the Windows hypervisor, which requires a physical processor with specific features. For hardware details, see [System requirements for Hyper-V on Windows Server](System-requirements-for-Hyper-V-on-Windows.md).

In most cases, the hypervisor manages the interactions between the hardware and the virtual machines. This hypervisor-controlled access to the hardware gives virtual machines the isolated environment in which they run. In some configurations, a virtual machine or the operating system running in the virtual machine has direct access to graphics, networking, or storage hardware.

:::zone pivot="windows-server"

## What does Hyper-V consist of?

Hyper-V has required parts that work together so you can create and run virtual machines. Together, these parts are called the virtualization platform. They're installed as a set when you install the Hyper-V role. The required parts include Windows hypervisor, Hyper-V Virtual Machine Management Service, the virtualization WMI provider, the virtual machine bus (VMbus), virtualization service provider (VSP), and virtual infrastructure driver (VID).

Hyper-V also has tools for management and connectivity. You can install these on the same computer that Hyper-V role is installed on, and on computers without the Hyper-V role installed. These tools are:

- Hyper-V Manager
- [Hyper-V module for Windows PowerShell](/powershell/module/hyper-v/index)
- [Virtual Machine Connection](./learn-more/hyper-v-virtual-machine-connect.md) \(sometimes called VMConnect\)
- [Windows PowerShell Direct](manage/Manage-Windows-virtual-machines-with-PowerShell-Direct.md)

## Related technologies

These are some technologies from Microsoft that are often used with Hyper-V:

- [Failover Clustering](../../failover-clustering/whats-new-in-failover-clustering.md)
- [Remote Desktop Services](../../remote/remote-desktop-services/remote-desktop-services-overview.md)
- [System Center Virtual Machine Manager](/system-center/vmm/overview)
- [Client Hyper-V](/virtualization/hyper-v-on-windows/index)

Various storage technologies: cluster shared volumes, SMB 3.0, storage spaces direct

::: zone-end

Windows containers offer another approach to virtualization. See the [Windows Containers](/virtualization/windowscontainers/index) library on MSDN.

:::zone pivot="windows"

## System requirements

Hyper-V requires:

- A processor with second level address translation (SLAT) capabilities.

- Windows 10 (Pro or Enterprise) or Windows 11 (Pro or Enterprise).

> Upgrade to Windows Pro by opening **Settings** > **Update and Security** > **Activation**. Here you can visit the store and purchase an upgrade.

Most computers run Hyper-V, however each virtual machine runs a separate operating system. You can generally run one or more virtual machines on a computer with 4 GB of RAM, though you need more resources for more virtual machines or to install and run resource intense software like games, video editing, or engineering design software.

For more information about Hyper-V's system requirements and how to verify that Hyper-V runs on your machine, see the [Hyper-V Requirements Reference](/virtualization/hyper-v-on-windows/reference/hyper-v-requirements).

## Operating systems you can run in a virtual machine

Hyper-V on Windows supports many different operating systems in a virtual machine including various releases of Linux, FreeBSD, and Windows.

As a reminder, you need to have a valid license for any operating systems you use in the VMs.

For information about which operating systems are supported as guests in Hyper-V on Windows, see [Supported Windows Guest Operating Systems](/windows-server/virtualization/hyper-v/supported-windows-guest-operating-systems-for-hyper-v-on-windows) and [Supported Linux Guest Operating Systems](/windows-server/virtualization/hyper-v/Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows).

::: zone-end

## Differences between Hyper-V on Windows and Hyper-V on Windows Server

There are some features that work differently in Hyper-V on Windows than they do in Hyper-V running on Windows Server.

Hyper-V features only available on Windows Server:

- Live migration of virtual machines from one host to another
- Hyper-V Replica
- Virtual Fiber Channel
- SR-IOV networking
- Shared VHDX files

Hyper-V features only available on Windows:

- Quick Create and the VM Gallery
- Default network (NAT switch)

The memory management model is different for Hyper-V on Windows. On a server, Hyper-V memory is managed with the assumption that only the virtual machines are running on the server. In Hyper-V on Windows, memory is managed with the expectation that most client machines are running software on host in addition to running virtual machines.

## Limitations

Programs that depend on specific hardware don't work well in a virtual machine. For example, games or applications that require processing with GPUs might not work well. Also, applications relying on sub-10ms timers such as live music mixing applications or high precision times could have issues running in a virtual machine.

In addition, if you have Hyper-V enabled, those latency-sensitive, high-precision applications may also have issues running in the host. This is because with virtualization enabled, the host OS also runs on top of the Hyper-V virtualization layer, just as guest operating systems do. However, unlike guests, the host OS is special in that it has direct access to all the hardware, which means that applications with special hardware requirements can still run without issues in the host OS.
