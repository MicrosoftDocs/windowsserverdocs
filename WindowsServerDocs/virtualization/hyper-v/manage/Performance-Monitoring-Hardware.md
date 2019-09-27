---
title: Enable Intel Performance Monitoring Hardware in a Hyper-V Virtual Machine
description: "How to enable Intel's Performance Monitoring Hardware in a Hyper-V Machine. Also touches on how enabling performance monitoring hardware effects live migration."
ms.prod: windows-server
ms.reviewer: ifufondu
author: ifeomaufondu-ms
ms.author: ifufondu
manager: chhuybre
ms.topic: article
ms.date: 09/20/2019
---
# Enable Intel Performance Monitoring Hardware in a Hyper-V virtual machine

Intel processors contain features collectively called performance monitoring hardware (e.g. PMU, PEBS, LBR). These features are used by performance tuning software like Intel VTune Amplifier to analyze software performance.  Prior to Windows Server 2019 and Windows 10 Version 1809, neither the host operating system nor Hyper-V guest virtual machines could use performance monitoring hardware when Hyper-V was enabled.  Starting with Windows Server 2019 and Windows 10 Version 1809, the host operating system has access to performance monitoring hardware by default.  Hyper-V guest virtual machines do not have access by default, but Hyper-V administrators may choose to grant access to one or more guest virtual machines.  This document describes the steps required to expose performance monitoring hardware to guest virtual machines.

## Requirements

To enable performance monitoring hardware in a virtual machine, you'll need:

- An Intel processor with performance monitoring hardware (i.e. PMU, PEBS, IPT)
- Windows Server 2019 or Windows 10 Version 1809 (October 2018 Update) or later
- A Hyper-V virtual machine _without_ [nested virtualization](https://docs.microsoft.com/virtualization/hyper-v-on-windows/user-guide/nested-virtualization) that is also in the stopped state
 
## Enabling performance monitoring components in a virtual machine

To enable different performance monitoring components for a specific guest virtual machine, use the `Set-VMProcessor` PowerShell cmdlet:
 
``` Powershell
# Enable all components
Set-VMProcessor MyVMName -Perfmon @("pmu", "lbr", "pebs")
```
 
``` Powershell
# Enable a specific component
Set-VMProcessor MyVMName -Perfmon @("pmu")
```
 
``` Powershell
# Disable all components
Set-VMProcessor MyVMName -Perfmon @()
```
> [!NOTE]
> When enabling the performance monitoring components, if `"pebs"` is specified, then `"pmu"` must be specified.  Also, enabling a component that is not supported by the host's physical processors will result in a virtual machine start failure.
 
## Effects of enabling performance monitoring hardware on save/restore, export, and live migration
 
Microsoft does not recommend live migrating or saving/restoring virtual machines with performance monitoring hardware between systems with different Intel hardware. The specific behavior of performance monitoring hardware is often non-architectural and changes between Intel hardware systems.  Moving a running virtual machine between different systems can result in unpredictable behavior of the non-architectural counters.