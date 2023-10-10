---
title: Guest operating system and application supportability on Hyper-V
description: Understand which versions of Windows Server or Azure Stack HCI are compatible products for a guest operating system or application that has been validated for Hyper-V.
ms.topic: conceptual
author: dknappettmsft
ms.author: daknappe
manager: femila
ms.date: 01/11/2022
ms.prod: windows-server
---

# Guest operating system and application supportability on Hyper-V

Hyper-V is a hypervisor that is broadly used in many Microsoft server products, including the Windows Server family (Datacenter, Standard, and Essentials editions) and Azure Stack HCI. Hyper-V provides a platform with broad ecosystem support and compatibility. This article clarifies which versions of Windows Server or Azure Stack HCI map to which Hyper-V build numbers. This helps understand supported scenarios where a guest operating system or application has been validated for Hyper-V.

Although the different products that include Hyper-V could contain variations in features, the common codebase provides a consistent platform for guest operating systems and applications running inside of a virtual machine to run on compatible products that share the same Hyper-V build number. This means that any support or compatibility statements for a guest operating system or application that is certified for specific builds of Hyper-V is compatible with all products that share the same build number for Hyper-V.

The table below shows which Hyper-V build numbers are available in which compatible products:

| Hyper-V build | Compatible products |
|--|--|
| 20348 | Windows Server 2022 Datacenter<br />Windows Server 2022 Standard<br />Windows Server 2022 Essentials<br />Azure Stack HCI version 21H2 <br />Azure Stack HCI version 22H2|
| 17763 and 17784 | Windows Server 2019 Datacenter<br />Windows Server 2019 Standard<br />Windows Server 2019 Essentials<br />Hyper-V Server 2019<br />Azure Stack HCI version 20H2|
| 14393 | Windows Server 2016 Datacenter<br />Windows Server 2016 Standard<br />Windows Server 2016 Essentials<br />Hyper-V Server 2016 |

For more information, see:

- [Windows Server release information](../../../get-started/windows-server-release-info.md)
- [Supported Windows guest operating systems on Hyper-V](../Supported-Windows-guest-operating-systems-for-Hyper-V-on-Windows.md)
- [Supported Linux and FreeBSD guest operating systems on Hyper-V](../Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md)
