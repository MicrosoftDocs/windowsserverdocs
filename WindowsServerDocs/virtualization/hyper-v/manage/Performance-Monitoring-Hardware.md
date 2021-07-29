---
title: Enable Intel Performance Monitoring Hardware in a Hyper-V Virtual Machine
description: How to enable Intel's Performance Monitoring Hardware in a Hyper-V Machine. Also touches on how enabling performance monitoring hardware effects live migration.
ms.reviewer: ifufondu
author: ifeomaufondu-ms
ms.author: ifufondu
manager: chhuybre
ms.topic: article
ms.date: 11/30/2020
---

# Enable Intel Performance Monitoring Hardware in a Hyper-V virtual machine

Intel processors contain features collectively called performance monitoring hardware (e.g. PMU, PEBS, LBR). These features are used by performance tuning software like Intel VTune Amplifier to analyze software performance.  Prior to Windows Server 2019 and Windows 10 Version 1809, neither the host operating system nor Hyper-V guest virtual machines could use performance monitoring hardware when Hyper-V was enabled.  Starting with Windows Server 2019 and Windows 10 Version 1809, the host operating system has access to performance monitoring hardware by default.  Hyper-V guest virtual machines do not have access by default, but Hyper-V administrators may choose to grant access to one or more guest virtual machines.  This document describes the steps required to expose performance monitoring hardware to guest virtual machines.

## Requirements

To enable performance monitoring hardware in a virtual machine, you'll need:

- An Intel processor with performance monitoring hardware (i.e. PMU, PEBS, LBR).  Refer to [this document]( https://software.intel.com/en-us/vtune-amplifier-cookbook-configuring-a-hyper-v-virtual-machine-for-hardware-based-hotspots-analysis) from Intel to determine which performance monitoring hardware your system supports.
- Windows Server 2019 or Windows 10 Version 1809 (October 2018 Update) or later
- A Hyper-V virtual machine _without_ [nested virtualization](/virtualization/hyper-v-on-windows/user-guide/nested-virtualization) that is also in the stopped state

To enable upcoming Intel Processor Trace (IPT) performance monitoring hardware in a virtual machine, you’ll need:

- An Intel processor that supports IPT and the PT2GPA feature.  [^1]  Refer to [this document]( https://software.intel.com/en-us/vtune-amplifier-cookbook-configuring-a-hyper-v-virtual-machine-for-hardware-based-hotspots-analysis) from Intel to determine which performance monitoring hardware your system supports.
- Windows Server version 1903 (SAC) or Windows 10 Version 1903 (May 2019 Update) or later
- A Hyper-V virtual machine _without_ [nested virtualization](/virtualization/hyper-v-on-windows/user-guide/nested-virtualization) that is also in the stopped state
- PMU needs to be enabled via the command line using the command seen below.

[^1]: PT2GPA refers to the “Intel PT uses guest physical addresses” bit. This is described in 25.5.4.1 of the Intel SDM.

## Enabling performance monitoring components in a virtual machine

To enable different performance monitoring components for a specific guest virtual machine, use the `Set-VMProcessor` PowerShell cmdlet while running as Administrator:

> [!NOTE]
> The virtual machine generation must be 9.1 or higher. If nested virtualization is offered to the guest as well, then this needs 9.3 and up.

``` Powershell
# Enable IPT
Set-VMProcessor MyVMName -Perfmon @("ipt", "pmu")
```

``` Powershell
# Enable all components
Set-VMProcessor MyVMName -Perfmon @("ipt", "pmu", "lbr", "pebs")
```

``` Powershell
# Disable all components
Set-VMProcessor MyVMName -Perfmon @()
```

> [!NOTE]
> When enabling the performance monitoring components, if `"pebs"` is specified, then `"pmu"` must also be specified.<br/>
> PEBS is only supported on hardware that has a PMU Version >= 4.<br/>
> Also, any command that attempts to enable `"ipt"` must also specify `"pmu"`.
>
> Enabling a component that is not supported by the host's physical processors will result in a virtual machine start failure.

## Effects of enabling performance monitoring hardware on save/restore, export, and live migration

Microsoft does not recommend live migrating or saving/restoring virtual machines with performance monitoring hardware between systems with different Intel hardware. The specific behavior of performance monitoring hardware is often non-architectural and changes between Intel hardware systems.  Moving a running virtual machine between different systems can result in unpredictable behavior of the non-architectural counters.
