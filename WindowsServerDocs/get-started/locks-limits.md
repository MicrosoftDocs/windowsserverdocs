---
title: Locks and limits in Windows Server
description: In this article, you can compare the operating system locks and limits across the different editions of Windows Server.
ms.topic: conceptual
author: robinharwood
ms.author: roharwoo
ms.date: 10/25/2024
zone_pivot_groups: windows-os-version
---

# Comparison of locks and limits in Windows Server

Use this article to compare the operating system locks and limits across the different editions of Windows Server.

## Locks and limits

:::zone pivot="windows-server-2025"

# [Full Comparison](#tab/full-comparison)

| Locks and limits | Windows Server 2025 Standard | Windows Server 2025 Datacenter | Windows Server 2025 Datacenter: Azure Edition |
|--|--|--|--|
| Maximum number of users | Based on CALs | Based on CALs | Based on CALs |
| Maximum SMB connections | 16,777,216 | 16,777,216 | 16,777,216 |
| Maximum RRAS connections | Unlimited | Unlimited | Unlimited |
| Maximum IAS connections | 2,147,483,647 | 2,147,483,647 | 2,147,483,647 |
| Maximum RDS connections | 65,535 | 65,535 | 65,535 |
| Maximum number of 64-bit sockets | 64 | 64 | 64 |
| Maximum number of cores | Unlimited | Unlimited | 2,048 logical processors |
| Maximum RAM | <ul><li>4 PB for hosts that support 5-level paging</li><li>256 TB for hosts that support 4-level paging</li></ul> | <ul><li>4 PB for hosts that support 5-level paging</li><li>256 TB for hosts that support 4-level paging</li></ul> | <ul><li>240 TB for a generation 2 virtual machine</li><li>1 TB for a generation 1 virtual machine</li></ul> |
| Can be used as virtualization guest | Yes; 2 virtual machines, plus one Hyper-V host per license | Yes; **unlimited virtual machines**, plus one Hyper-V host per license | Yes; **unlimited virtual machines**, plus one Hyper-V host per license |
| Windows Server Containers | Unlimited | Unlimited | Unlimited |
| Virtual OSE/Hyper-V isolated Containers | 2 | Unlimited | Unlimited |
| Windows Server Containers | Unlimited Windows containers and up to two Hyper-V containers | Unlimited Windows containers and Hyper-V containers | Unlimited Windows containers and Hyper-V containers |
| Storage Replica | 1 partnership and 1 resource group with a single 2TB volume | **Unlimited** | **Unlimited** |

# [Version Differences](#tab/version-differences)

| Locks and limits | Windows Server 2025 Standard | Windows Server 2025 Datacenter | Windows Server 2025 Datacenter: Azure Edition |
|--|--|--|--|
| Maximum number of cores | Unlimited | Unlimited | 2,048 logical processors |
| Maximum RAM | <ul><li>4 PB for hosts that support 5-level paging</li><li>256 TB for hosts that support 4-level paging</li></ul> | <ul><li>4 PB for hosts that support 5-level paging</li><li>256 TB for hosts that support 4-level paging</li></ul> | <ul><li>240 TB for a generation 2 virtual machine</li><li>1 TB for a generation 1 virtual machine</li></ul> |
| Can be used as virtualization guest | Yes; 2 virtual machines, plus one Hyper-V host per license | Yes; **unlimited virtual machines**, plus one Hyper-V host per license | Yes; **unlimited virtual machines**, plus one Hyper-V host per license |
| Virtual OSE/Hyper-V isolated Containers | 2 | Unlimited | Unlimited |
| Windows Server Containers | Unlimited Windows containers and up to two Hyper-V containers | Unlimited Windows containers and Hyper-V containers | Unlimited Windows containers and Hyper-V containers |
| Storage Replica | 1 partnership and 1 resource group with a single 2TB volume | **Unlimited** | **Unlimited** |

---

::: zone-end

:::zone pivot="windows-server-2022"

# [Full Comparison](#tab/full-comparison)

| Locks and limits | Windows Server 2022 Standard | Windows Server 2022 Datacenter | Windows Server 2022 Datacenter: Azure Edition |
|--|--|--|--|
| Maximum number of users | Based on CALs | Based on CALs | Based on CALs |
| Maximum SMB connections | 16,777,216 | 16,777,216 | 16,777,216 |
| Maximum RRAS connections | Unlimited | Unlimited | Unlimited |
| Maximum IAS connections | 2,147,483,647 | 2,147,483,647 | 2,147,483,647 |
| Maximum RDS connections | 65,535 | 65,535 | 65,535 |
| Maximum number of 64-bit sockets | 64 | 64 | 64 |
| Maximum number of cores | Unlimited | Unlimited | 1,024 logical processors |
| Maximum RAM | <ul><li>4 PB for hosts that support 5-level paging</li><li>256 TB for hosts that support 4-level paging</li></ul> | <ul><li>4 PB for hosts that support 5-level paging</li><li>256 TB for hosts that support 4-level paging</li></ul> | <ul><li>240 TB for a generation 2 virtual machine</li><li>1 TB for a generation 1 virtual machine</li></ul> |
| Can be used as virtualization guest | Yes; 2 virtual machines, plus one Hyper-V host per license | Yes; **unlimited virtual machines**, plus one Hyper-V host per license | Yes; **unlimited virtual machines**, plus one Hyper-V host per license |
| Windows Server Containers | Unlimited | Unlimited | Unlimited |
| Virtual OSE/Hyper-V isolated Containers | 2 | Unlimited | Unlimited |
| Windows Server Containers | Unlimited Windows containers and up to two Hyper-V containers | Unlimited Windows containers and Hyper-V containers | Unlimited Windows containers and Hyper-V containers |
| Storage Replica | 1 partnership and 1 resource group with a single 2TB volume | **Unlimited** | **Unlimited** |

# [Version Differences](#tab/version-differences)

| Locks and limits | Windows Server 2022 Standard | Windows Server 2022 Datacenter | Windows Server 2022 Datacenter: Azure Edition |
|--|--|--|--|
| Can be used as virtualization guest | Yes; 2 virtual machines, plus one Hyper-V host per license | Yes; **unlimited virtual machines**, plus one Hyper-V host per license | Yes; **unlimited virtual machines**, plus one Hyper-V host per license |
| Virtual OSE/Hyper-V isolated Containers | 2 | Unlimited | Unlimited |
| Windows Server Containers | Unlimited Windows containers and up to two Hyper-V containers | Unlimited Windows containers and Hyper-V containers | Unlimited Windows containers and Hyper-V containers |
| Storage Replica | 1 partnership and 1 resource group with a single 2TB volume | **Unlimited** | **Unlimited** |

---

::: zone-end

:::zone pivot="windows-server-2019"

# [Full Comparison](#tab/full-comparison)

| Locks and limits | Windows Server 2019 Standard | Windows Server 2019 Datacenter |
|--|--|--|
| Maximum number of users | Based on CALs | Based on CALs |
| Maximum SMB connections | 16,777,216 | 16,777,216 |
| Maximum RRAS connections | Unlimited | Unlimited |
| Maximum IAS connections | 2,147,483,647 | 2,147,483,647 |
| Maximum RDS connections | 65,535 | 65,535 |
| Maximum number of 64-bit sockets | 64 | 64 |
| Maximum number of cores | Unlimited | Unlimited |
| Maximum RAM | 24 TB | 24 TB |
| Can be used as virtualization guest | Yes; 2 virtual machines, plus one Hyper-V host per license | Yes; **unlimited virtual machines**, plus one Hyper-V host per license |
| Windows Server Containers | Unlimited Windows containers and up to two Hyper-V containers | Unlimited Windows containers and Hyper-V containers |

# [Version Differences](#tab/version-differences)

| Locks and limits | Windows Server 2019 Standard | Windows Server 2019 Datacenter |
|--|--|--|
| Can be used as virtualization guest | Yes; 2 virtual machines, plus one Hyper-V host per license | Yes; **unlimited virtual machines**, plus one Hyper-V host per license |
| Windows Server Containers | Unlimited Windows containers and up to two Hyper-V containers | Unlimited Windows containers and Hyper-V containers |

---

::: zone-end

:::zone pivot="windows-server-2016"

# [Full Comparison](#tab/full-comparison)

| Locks and limits | Windows Server 2016 Standard | Windows Server 2016 Datacenter |
|--|--|--|
| Maximum number of users | Based on CALs | Based on CALs |
| Maximum SMB connections | 16,777,216 | 16,777,216 |
| Maximum RRAS connections | Unlimited | Unlimited |
| Maximum IAS connections | 2,147,483,647 | 2,147,483,647 |
| Maximum RDS connections | 65,535 | 65,535 |
| Maximum number of 64-bit sockets | 64 | 64 |
| Maximum number of cores | Unlimited | Unlimited |
| Maximum RAM | 24 TB | 24 TB |
| Can be used as virtualization guest | Yes; 2 virtual machines, plus one Hyper-V host per license | Yes; **unlimited virtual machines**, plus one Hyper-V host per license |

# [Version Differences](#tab/version-differences)

| Locks and limits | Windows Server 2016 Standard | Windows Server 2016 Datacenter |
|--|--|--|
| Can be used as virtualization guest | Yes; 2 virtual machines, plus one Hyper-V host per license | Yes; **unlimited virtual machines**, plus one Hyper-V host per license |

---

::: zone-end
