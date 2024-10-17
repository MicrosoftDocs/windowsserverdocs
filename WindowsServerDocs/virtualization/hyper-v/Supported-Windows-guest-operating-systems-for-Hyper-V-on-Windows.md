---
title: Supported Windows guest operating systems for Hyper-V on Windows Server and Azure Stack HCI
description: Lists the Windows operating systems supported for use as a guest in a virtual machine. Also gives links to similar articles for previous versions of Hyper-V.
ms.topic: conceptual
ms.author: roharwoo
author: robinharwood
ms.date: 08/13/2024
---
# Supported Windows guest operating systems for Hyper-V on Windows Server and Azure Stack HCI

Hyper-V supports several versions of Windows Server, Windows, and Linux distributions to run in virtual machines, as guest operating systems. This article covers supported Windows Server and Windows guest operating systems. For Linux and FreeBSD distributions, see [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md).

Some operating systems have the integration services built-in. Others require that you install or upgrade integration services as a separate step after you set up the operating system in the virtual machine. For more information, see the following sections and [Integration Services](/virtualization/hyper-v-on-windows/reference/integration-services).

Guest operating systems configurable components are confined based on the hosting operating system. To learn more about the maximum configurable components in Hyper-V, see [Plan for Hyper-V scalability in Windows Server](plan/plan-hyper-v-scalability-in-windows-server.md).

## Supported Windows Server guest operating systems

Following are the versions of Windows Server that are supported as guest operating systems for Hyper-V on Windows Server.

|Guest operating system (server)|Maximum number of virtual processors|Integration Services|Notes|
|-------------------------------------|----------------------------------------|------------------------|---------|
|Windows Server 2025 (preview) |2,048 for generation 2;<br>64 for generation 1;<br>2,048 available to the host OS (root partition)|Built-in| Hosted on Windows Server 2025 and later |
|Windows Server 2022 |1,024 for generation 2;<br>64 for generation 1;<br>1,024 available to the host OS (root partition)|Built-in| Hosted on Windows Server 2019 and later, Azure Stack HCI, version 20H2 and later.|
|Windows Server 2019 |240 for generation 2;<br>64 for generation 1;<br>320 available to the host OS (root partition)|Built-in||
|Windows Server 2016 |240 for generation 2;<br>64 for generation 1;<br>320 available to the host OS (root partition)|Built-in||
|Windows Server 2012 R2 |64|Built-in||
|Windows Server 2012 |64|Built-in||
|Windows Server 2008 R2 with Service Pack 1 (SP 1)|64|Install all critical Windows updates after you set up the guest operating system.|Datacenter, Enterprise, Standard, and Web editions.|
|Windows Server 2008 with Service Pack 2 (SP2)|8|Install all critical Windows updates after you set up the guest operating system.|Datacenter, Enterprise, Standard, and Web editions (32-bit and 64-bit).|

## Supported Windows client guest operating systems

Following are the versions of Windows client that are supported as guest operating systems for Hyper-V on Windows Server.

| Guest operating system (client) | Maximum number of virtual processors | Integration Services | Notes |
|--|--|--|--|
| Windows 11 | 32 | Built-in | Generation 2 virtual machine hosted on Windows Server 2019 or above <br/> Azure Stack HCI, version 20H2 and later. |
| Windows 10 | 32 | Built-in |  |
| Windows 8.1 | 32 | Built-in |  |
| Windows 7 with Service Pack 1 (SP1) | 4 | Upgrade the integration services after you set up the guest operating system. | Ultimate, Enterprise, and Professional editions (32-bit and 64-bit). |

## Guest operating system support on other versions of Windows

The following table gives links to information about guest operating systems supported for Hyper-V on other versions of Windows.

|Host operating system|Article|
|-------------------------|---------|
|Windows 10, 11|[Supported Guest Operating Systems for Client Hyper-V in Windows 10](/virtualization/hyper-v-on-windows/about/supported-guest-os)|
|Windows Server 2012 R2 and Windows 8.1|-   [Supported Windows Guest Operating Systems for Hyper-V in Windows Server 2012 R2 and Windows 8.1](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn792027(v=ws.11))<br />-   [Linux and FreeBSD Virtual Machines on Hyper-V](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md)|
|Windows Server 2012 and Windows 8|[Supported Windows Guest Operating Systems for Hyper-V in Windows Server 2012 and Windows 8](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn792028(v=ws.11))|
|Windows Server 2008 and Windows Server 2008 R2|[About Virtual Machines and Guest Operating Systems](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc794868(v=ws.10))|

## How Microsoft provides support for guest operating systems

Microsoft provides support for guest operating systems in the following manner:

- Issues found in Microsoft operating systems and in integration services are supported by Microsoft support.

- For issues found in other operating systems that have been certified by the operating system vendor to run on Hyper-V, support is provided by the vendor.

- For issues found in other operating systems, Microsoft submits the issue to the multi-vendor support community, [TSANet](https://www.tsanet.org/).

## Related links

- [Linux and FreeBSD Virtual Machines on Hyper-V](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md)

- [Supported Guest Operating Systems for Client Hyper-V in Windows](/virtualization/hyper-v-on-windows/about/supported-guest-os)
