---
title: Supported Oracle Linux virtual machines on Hyper-V
description: Lists the Oracle Linux integration services and features included in each version
ms.topic: concept-article
ms.author: daknappe
author: dknappettmsft
ms.date: 06/19/2025
---
# Supported Oracle Linux virtual machines on Hyper-V

The following feature distribution map indicates the features that are present in each version. The known issues and workarounds for each distribution are listed after the table.

In this section:

* [Oracle Linux 9.x Series](#oracle-linux-9x-series)
* [Oracle Linux 8.x Series](#oracle-linux-8x-series)

## Table legend

* **Built in** - LIS are included as part of this Linux distribution. The kernel module version numbers for the built in LIS (as shown by **lsmod**, for example) are different from the version number on the Microsoft-provided LIS download package. A mismatch doesn't indicate that the built in LIS is out of date.

* &#10004; - Feature available
* (*blank*) - Feature not available
* **RHCK** - Red Hat Compatible Kernel

## Oracle Linux 9.x Series

| **Feature** | **Windows Server version** | **9.0 (RHCK)** |
|--|--|--|
| **Availability** |  |
| **[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core)** | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| Windows Server 2016 Accurate Time | 2025, 2022, 2019, 2016 | &#10004; |
| **[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking)** |  |
| Jumbo frames | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| VLAN tagging and trunking | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| Live Migration | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| Static IP Injection | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; Note 1 |
| vRSS | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| TCP Segmentation and Checksum Offloads | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| SR-IOV | 2025, 2022, 2019, 2016 | &#10004; |
| **[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage)** |  |
| VHDX resize | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| Virtual Fibre Channel | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; Note 2 |
| Live virtual machine backup | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; Note 3 |
| TRIM support | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| SCSI WWN | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| **[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory)** |  |
| PAE Kernel Support | 2025, 2022, 2019, 2016, 2012 R2 | N/A |
| Configuration of MMIO gap | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| Dynamic Memory - Hot-Add | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; Note 4, 5, 6 |
| Dynamic Memory - Ballooning | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; Note 4, 5, 6 |
| Runtime Memory Resize | 2025, 2022, 2019, 2016 | &#10004; |
| **[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video)** |  |
| Hyper-V-specific video device | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| **[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous)** |  |
| Key-Value Pair | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| Non-Maskable Interrupt | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| File copy from host to guest | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| lsvmbus command | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| Hyper-V Sockets | 2025, 2022, 2019, 2016 | &#10004; |
| PCI Passthrough/DDA | 2025, 2022, 2019, 2016 | &#10004; |
| **[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines)** |  |  |
| Boot using UEFI | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; Note 7 |
| Secure boot | 2025, 2022, 2019, 2016 | &#10004; |

## Oracle Linux 8.x Series

| **Feature** | **Windows Server version** | **8.0-8.5 (RHCK)** |
|--|--|--|
| **Availability** |  |  |
| **[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core)** | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| Windows Server 2016 Accurate Time | 2025, 2022, 2019, 2016 | &#10004; |
| **[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking)** |  |  |
| Jumbo frames | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| VLAN tagging and trunking | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| Live Migration | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| Static IP Injection | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; Note 1 |
| vRSS | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| TCP Segmentation and Checksum Offloads | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| SR-IOV | 2025, 2022, 2019, 2016 | &#10004; |
| **[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage)** |  |  |
| VHDX resize | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| Virtual Fibre Channel | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; Note 2 |
| Live virtual machine backup | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; Note 3 |
| TRIM support | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| SCSI WWN | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| **[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory)** |  |  |
| PAE Kernel Support | 2025, 2022, 2019, 2016, 2012 R2 | N/A |
| Configuration of MMIO gap | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| Dynamic Memory - Hot-Add | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; Note 4, 5, 6 |
| Dynamic Memory - Ballooning | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; Note 4, 5, 6 |
| Runtime Memory Resize | 2025, 2022, 2019, 2016 | &#10004; |
| **[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video)** |  |  |
| Hyper-V-specific video device | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| **[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous)** |  |  |
| Key-Value Pair | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| Non-Maskable Interrupt | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| File copy from host to guest | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| lsvmbus command | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; |
| Hyper-V Sockets | 2025, 2022, 2019, 2016 | &#10004; |
| PCI Passthrough/DDA | 2025, 2022, 2019, 2016 | &#10004; |
| **[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines)** |  |  |
| Boot using UEFI | 2025, 2022, 2019, 2016, 2012 R2 | &#10004; Note 7 |
| Secure boot | 2025, 2022, 2019, 2016 | &#10004; |

## Notes

1. Static IP injection may not work if Network Manager has been configured for a given synthetic network adapter on the virtual machine. For smooth functioning of static IP injection please make sure that either Network Manager is either turned off completely or has been turned off for a specific network adapter through its ifcfg-ethX file.

2.	On Windows Server 2012 R2 while using virtual fibre channel devices, make sure that logical unit number 0 (LUN 0) has been populated. If LUN 0 has not been populated, a Linux virtual machine might not be able to mount fibre channel devices natively.

3. If there are open file handles during a live virtual machine backup operation, then in some corner cases, the backed-up VHDs might have to undergo a file system consistency check (fsck) on restore. Live backup operations can fail silently if the virtual machine has an attached iSCSI device or direct-attached storage (also known as a pass-through disk).

4. Hot-Add support is not enabled by default in this distribution. To enable Hot-Add support you need to add a udev rule under /etc/udev/rules.d/ as follows:

   1. Create a file **/etc/udev/rules.d/100-balloon.rules**. You may use any other desired name for the file.

   2. Add the following content to the file: `SUBSYSTEM=="memory", ACTION=="add", ATTR{state}="online"`

   3. Reboot the system to enable Hot-Add support.

   While the Linux Integration Services download creates this rule on installation, the rule is also removed when LIS is uninstalled, so the rule must be recreated if dynamic memory is needed after uninstallation.

5. Dynamic memory operations can fail if the guest operating system is running too low on memory. The following are some best practices:

   * Startup memory and minimal memory should be equal to or greater than the amount of memory that the distribution vendor recommends.

   * Applications that tend to consume the entire available memory on a system are limited to consuming up to 80 percent of available RAM.

6. If you are using Dynamic Memory on a Windows Server 2016 or Windows Server 2012 R2 operating system, specify **Startup memory**, **Minimum memory**, and **Maximum memory** parameters in multiples of 128 megabytes (MB). Failure to do so can lead to hot-add failures, and you may not see any memory increase in a guest operating system.

7. On Windows Server 2012 R2 Generation 2 virtual machines have secure boot enabled by default and some Linux virtual machines will not boot unless the secure boot option is disabled. You can disable secure boot in the **Firmware** section of the settings for the virtual machine in **Hyper-V Manager** or you can disable it using PowerShell:

    ```Powershell
    Set-VMFirmware -VMName "VMname" -EnableSecureBoot Off
    ```

    The Linux Integration Services download can be applied to existing Generation 2 VMs but does not impart Generation 2 capability.

## Related content

* [Set-VMFirmware](/powershell/module/hyper-v/set-vmfirmware)

* [Supported CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V](Supported-CentOS-and-Red-Hat-Enterprise-Linux-virtual-machines-on-Hyper-V.md)

* [Supported Debian virtual machines on Hyper-V](Supported-Debian-virtual-machines-on-Hyper-V.md)

* [Supported SUSE virtual machines on Hyper-V](Supported-SUSE-virtual-machines-on-Hyper-V.md)

* [Supported Ubuntu virtual machines on Hyper-V](Supported-Ubuntu-virtual-machines-on-Hyper-V.md)

* [Supported FreeBSD virtual machines on Hyper-V](Supported-FreeBSD-virtual-machines-on-Hyper-V.md)

* [Feature Descriptions for Linux and FreeBSD virtual machines on Hyper-V](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md)

* [Best Practices for running Linux on Hyper-V](Best-Practices-for-running-Linux-on-Hyper-V.md)

