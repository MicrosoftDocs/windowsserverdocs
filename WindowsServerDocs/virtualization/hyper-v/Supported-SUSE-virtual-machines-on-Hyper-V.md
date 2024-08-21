---
title: Supported SUSE Linux Enterprise Server (SLES) virtual machines on Hyper-V
description: Lists the SUSE Linux Enterprise Server (SLES)/Linux integration services and features included in each version
ms.topic: article
ms.assetid: 7ec0e14c-4498-4bd9-8fe6-b94260198efc
ms.author: kkashanjat
author: kkkashan
ms.date: 09/27/2023
---
# Supported SUSE Linux Enterprise Server (SLES) virtual machines on Hyper-V

> Applies to: Azure Stack HCI, Windows Server 2022, Windows Server 2019, Hyper-V Server 2019, Windows Server 2016, Hyper-V Server 2016, Windows Server 2012 R2, Hyper-V Server 2012 R2, Windows 10, Windows 8.1

The following is a feature distribution map that indicates the features in each version. The known issues and workarounds for each distribution are listed after the table.

The built-in SUSE Linux Enterprise Service drivers for Hyper-V are certified by SUSE. An example configuration can be viewed in this bulletin: [SUSE YES Certification Bulletin](https://www.suse.com/nbswebapp/yesBulletin.jsp?bulletinNumber=144176).

## Table legend

* **Built in** - LIS are included as part of this Linux distribution.The Microsoft-provided LIS download package does not work for this distribution, so do not install it.The kernel module version numbers for the built in LIS (as shown by **lsmod**, for example) are different from the version number on the Microsoft-provided LIS download package. A mismatch doesn't indicate that the built in LIS is out of date.

* &#10004; - Feature available

* (*blank*) - Feature not available

SLES12+ is 64-bit only.

| **Feature** | **Operating system version** | **SLES 15 SP1-SP4** | **SLES 15** | **SLES 12 SP3-SP5** | **SLES 12 SP2** | **SLES 12 SP1** | **SLES 11 SP4** | **SLES 11 SP3** |
|--|--|--|--|--|--|--|--|--|
| **Availability** |  | Built-in | Built-in | Built-in | Built-in | Built-in | Built-in | Built-in |
| **[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core)** | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Windows Server 2016 Accurate Time | WS/Hyper-V 2022,2019,2016 | ✔ | ✔ | ✔ | ✔ |  |  |  |
| **[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking)** |  |  |  |  |  |  |  |  |
| Jumbo frames | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| VLAN tagging and trunking | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Live migration | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Static IP Injection | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔Note 1 | ✔Note 1 | ✔Note 1 | ✔Note 1 | ✔Note 1 | ✔Note 1 | ✔Note 1 |
| vRSS | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ |  |  |
| TCP Segmentation and Checksum Offloads | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |  |
| SR-IOV | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ | ✔ | ✔ | ✔ |  |  |  |
| **[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage)** |  |  |  |  |  |  |  |  |
| VHDX resize | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Virtual Fibre Channel | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Live virtual machine backup | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ Note 2,3,8 | ✔Note 2,3,8 | ✔ Note 2,3,8 | ✔ Note 2,3,8 | ✔ Note 2,3,8 | ✔ Note 2,3,8 | ✔ Note 2,3,8 |
| TRIM support | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |  |
| SCSI WWN | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ | ✔ | ✔ | ✔ |  |  |  |
| **[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory)** |  |  |  |  |  |  |  |  |
| PAE Kernel Support | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | N/A | N/A | N/A | N/A | N/A | ✔ | ✔ |
| Configuration of MMIO gap | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| Dynamic Memory - Hot-Add | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ Note 6 | ✔Note 6 | ✔ Note 6 | ✔ Note 6 | ✔ Note 6 | ✔ Note 4,5,6 | ✔ Note 4,5,6 |
| Dynamic Memory - Ballooning | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ Note 6 | ✔ Note 6 | ✔ Note 6 | ✔ Note 6 | ✔ Note 6 | ✔ Note 4,5,6 | ✔ Note 4,5,6 |
| Runtime Memory Resize | WS/Hyper-V 2022,2019,2016 | ✔ Note 6 | ✔ Note 6 | ✔ Note 6 | ✔ Note 6 |  |  |  |
| **[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video)** |  |  |  |  |  |  |  |  |
| Hyper-V-specific video device | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| **[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous)** |  |  |  |  |  |  |  |  |
| Key/value pair | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ Note 7 | ✔ Note 7 |
| Non-Maskable Interrupt | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |
| File copy from host to guest | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ | ✔ | ✔ | ✔ | ✔ | ✔ |  |
| lsvmbus command | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ | ✔ | ✔ | ✔ |  |  |  |
| Hyper-V Sockets | WS/Hyper-V 2022,2019,2016 | ✔ | ✔ | ✔ |  |  |  |  |
| PCI Passthrough/DDA | WS/Hyper-V 2022,2019,2016 | ✔ | ✔ | ✔ | ✔ | ✔ |  |  |
| **[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines)** |  |  |  |  |  |  |  |  |
| Boot using UEFI | WS/Hyper-V 2022,2019,2016,2012<br/> Azure Stack HCI | ✔ Note 9 | ✔ Note 9 | ✔ Note 9 | ✔ Note 9 | ✔ Note 9 | ✔ Note 9 |  |
| Secure boot | WS/Hyper-V 2022,2019,2016 | ✔ | ✔ | ✔ | ✔ | ✔ |  |  |

## Notes

1. Static IP injection may not work if **NetworkManager** has been configured for a given Hyper-V-specific network adapter on the virtual machine as it can override static IP settings that have been manually configured. To ensure smooth functioning of static IP injection please ensure that Network Manager is turned off completely or has been turned off for a specific network adapter through its **ifcfg-ethX** file.

2. If there are open file handles during a live virtual machine backup operation, then in some corner cases, the backed-up VHDs might have to undergo a file system consistency check (fsck) on restore.

3. Live backup operations can fail silently if the virtual machine has an attached iSCSI device or direct-attached storage (also known as a pass-through disk).

4. Dynamic memory operations can fail if the guest operating system is running too low on memory. The following are some best practices:

   * Startup memory and minimal memory should be equal to or greater than the amount of memory that the distribution vendor recommends.

   * Applications that tend to consume the entire available memory on a system are limited to consuming up to 80 percent of available RAM.

5. Dynamic memory support is only available on 64-bit virtual machines.

6. If you are using Dynamic Memory on Windows Server 2016 or Windows Server 2012 operating systems, specify **Startup memory**, **Minimum memory**, and **Maximum memory** parameters in multiples of 128 megabytes (MB). Failure to do so can lead to Hot-Add failures, and you may not see any memory increase in a guest operating system.

7. In Windows Server 2016 or Windows Server 2012 R2, the key/value pair infrastructure might not function correctly without a Linux software update. Contact your distribution vendor to obtain the software update in case you see problems with this feature.

8. VSS backup will fail if a single partition is mounted multiple times.

9. On Windows Server 2012 R2, Generation 2 virtual machines have secure boot enabled by default and Generation 2 Linux virtual machines will not boot unless the secure boot option is disabled. You can disable secure boot in the **Firmware** section of the settings for the virtual machine in Hyper-V Manager or you can disable it using PowerShell:

   ```Powershell
   Set-VMFirmware -VMName "VMname" -EnableSecureBoot Off
   ```

## See Also

* [Set-VMFirmware](/powershell/module/hyper-v/set-vmfirmware)

* [Supported CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V](Supported-CentOS-and-Red-Hat-Enterprise-Linux-virtual-machines-on-Hyper-V.md)

* [Supported Debian virtual machines on Hyper-V](Supported-Debian-virtual-machines-on-Hyper-V.md)

* [Supported Oracle Linux virtual machines on Hyper-V](Supported-Oracle-Linux-virtual-machines-on-Hyper-V.md)

* [Supported Ubuntu virtual machines on Hyper-V](Supported-Ubuntu-virtual-machines-on-Hyper-V.md)

* [Supported FreeBSD virtual machines on Hyper-V](Supported-FreeBSD-virtual-machines-on-Hyper-V.md)

* [Feature Descriptions for Linux and FreeBSD virtual machines on Hyper-V](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md)

* [Best Practices for running Linux on Hyper-V](Best-Practices-for-running-Linux-on-Hyper-V.md)
