---
title: Supported Windows guest operating systems for Hyper-V on Windows, Windows Server, and Azure Local
description: Lists the Windows operating systems supported for use as a guest in a virtual machine. Also gives links to similar articles for previous versions of Hyper-V.
ms.topic: concept-article
ms.author: daknappe
author: dknappettmsft
ms.date: 04/30/2025
---

# Supported Windows guest operating systems for Hyper-V on Windows, Windows Server, and Azure Local

Hyper-V supports several versions of Windows Server, Windows, and Linux distributions to run in virtual machines, as guest operating systems. This article covers supported Windows Server and Windows guest operating systems. For Linux and FreeBSD distributions, see [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md).

Some operating systems have the integration services built-in. Others require that you install or upgrade integration services as a separate step after you set up the operating system in the virtual machine. For more information, see the following sections and [Integration Services](/virtualization/hyper-v-on-windows/reference/integration-services).

Guest operating systems configurable components are confined based on the hosting operating system. To learn more about the maximum configurable components in Hyper-V, see [Plan for Hyper-V scalability in Windows Server](maximum-scale-limits.md).

## Supported Windows Server guest operating systems

Following are the versions of Windows Server that are supported as guest operating systems for Hyper-V on Windows Server.

### Windows Server 2025

- **Maximum number of virtual processors**:  
  - 2,048 for generation 2  
  - 64 for generation 1  
  - 2,048 available to the host OS (root partition)  
- **Integration Services**: Built-in  
- **Host operating systems**:
  - Windows Server 2022 and later
  - Azure Local OS, version 23H2 and later with Windows Server subscription.
- **Notes**:  
  - Maximum number of virtual processors depends on the host OS. For example, Windows Server 2025 can provide up to 2,048 virtual processors.  

### Windows Server 2022

- **Maximum number of virtual processors**:  
  - 1,024 for generation 2  
  - 64 for generation 1  
  - 1,024 available to the host OS (root partition)  
- **Integration Services**: Built-in  
- **Host operating systems**:
  - Windows Server 2019 and later
  - Azure Local OS, version 23H2 and later.

### Windows Server 2019

- **Maximum number of virtual processors**:  
  - 240 for generation 2  
  - 64 for generation 1  
  - 320 available to the host OS (root partition)  
- **Integration Services**: Built-in  

### Windows Server 2016

- **Maximum number of virtual processors**:  
  - 240 for generation 2  
  - 64 for generation 1  
  - 320 available to the host OS (root partition)  
- **Integration Services**: Built-in  

### Windows Server 2012 R2

- **Maximum number of virtual processors**: 64  
- **Integration Services**: Built-in  

### Windows Server 2012

- **Maximum number of virtual processors**: 64  
- **Integration Services**: Built-in  

### Windows Server 2008 R2 with Service Pack 1 (SP1)

- **Maximum number of virtual processors**: 64  
- **Integration Services**: Install all critical Windows updates after you set up the guest operating system.  
- **Notes**: Datacenter, Enterprise, Standard, and Web editions.  

### Windows Server 2008 with Service Pack 2 (SP2)

- **Maximum number of virtual processors**: 8  
- **Integration Services**: Install all critical Windows updates after you set up the guest operating system.  
- **Notes**: Datacenter, Enterprise, Standard, and Web editions (32-bit and 64-bit).  

## Supported Windows client guest operating systems

Following are the versions of Windows client that are supported as guest operating systems for Hyper-V on Windows Server.

### Windows 11

- **Maximum number of virtual processors**: 32
- **Integration Services**: Built-in
- **Host operating systems**:
  - Generation 2 virtual machine hosted on Windows Server 2019 and later
  - Generation 2 virtual machine hosted on Azure Local OS, version 23H2 and later
- **Notes**:  
  - Windows 11 requires an increased CPU instruction for installation and boot (POPCNT and SSE4.2). To meet these requirements in Hyper-V:  
    - On Windows 11, Windows Server 2022 (standalone or clustered hosts), or standalone Windows Server 2025 hosts, disable processor compatibility to enable these features. Disabling processor compatibility limits live migration to hosts with the same processor features.  
    - On Windows Server 2025 clusters with CPUs supporting POPCNT and SSE4.2, enable dynamic processor compatibility to ensure these features are available while retaining live migration capabilities within the cluster. To learn more about dynamic processor compatibility, see [Processor compatibility for Hyper-V virtual machines](processor-compatibility-mode.md).

### Windows 10

- **Maximum number of virtual processors**: 32  
- **Integration Services**: Built-in  

### Windows 8.1

- **Maximum number of virtual processors**: 32  
- **Integration Services**: Built-in  

### Windows 7 with Service Pack 1 (SP1)

- **Maximum number of virtual processors**: 4  
- **Integration Services**: Upgrade the integration services after you set up the guest operating system.  
- **Notes**: Ultimate, Enterprise, and Professional editions (32-bit and 64-bit).  

## Supported Linux and FreeBSD

| Guest operating system |
|:-----|
| [CentOS and Red Hat Enterprise Linux](/windows-server/virtualization/hyper-v/Supported-CentOS-and-Red-Hat-Enterprise-Linux-virtual-machines-on-Hyper-V) |
| [Debian virtual machines on Hyper-V](/windows-server/virtualization/hyper-v/Supported-Debian-virtual-machines-on-Hyper-V) |
| [SUSE](/windows-server/virtualization/hyper-v/Supported-SUSE-virtual-machines-on-Hyper-V) |
| [Oracle Linux](/windows-server/virtualization/hyper-v/Supported-Oracle-Linux-virtual-machines-on-Hyper-V)  |
| [Ubuntu](/windows-server/virtualization/hyper-v/Supported-Ubuntu-virtual-machines-on-Hyper-V) |
| [FreeBSD](/windows-server/virtualization/hyper-v/Supported-FreeBSD-virtual-machines-on-Hyper-V) |

## How Microsoft provides support for guest operating systems

Microsoft provides support for guest operating systems in the following manner:

- Issues found in Microsoft operating systems and in integration services are supported by Microsoft support.

- For issues found in other operating systems that have been certified by the operating system vendor to run on Hyper-V, support is provided by the vendor.

- For issues found in other operating systems, Microsoft submits the issue to the multi-vendor support community, [TSANet](https://www.tsanet.org/).

In order to be supported, all operating systems (guest and host) must be up-to-date. Check Windows Update for critical updates.
