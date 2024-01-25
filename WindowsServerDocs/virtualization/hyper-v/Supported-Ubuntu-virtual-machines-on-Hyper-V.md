---
title: Supported Ubuntu virtual machines on Hyper-V
description: Lists the Ubuntu/Linux integration services and features included in each version
ms.topic: article
ms.assetid: 95ea5f7c-25c6-494b-8ffd-2a77f631ee94
ms.author: kkashanjat
author: kkkashan
ms.date: 09/27/2023
---
# Supported Ubuntu virtual machines on Hyper-V

> Applies to: Azure Stack HCI, Windows Server 2022, Windows Server 2019, Hyper-V Server 2019, Windows Server 2016, Hyper-V Server 2016, Windows Server 2012 R2, Hyper-V Server 2012 R2, Windows 10, Windows 8.1

The following feature distribution map indicates the features in each version. The known issues and workarounds for each distribution are listed after the table.

## Table legend

* **Built in** -  Linux Integration Services (LIS) is included as part of this Linux distribution. The Microsoft-provided LIS download package doesn't work for this distribution, so don't install it. The kernel module version numbers for the built in LIS (as shown by **lsmod**, for example) are different from the version number on the Microsoft-provided LIS download package. A mismatch doesn't indicate that the built in LIS is out of date.

* &#10004; - Feature available

* (*blank*) - Feature not available

| **Feature** | **Windows Server operating system version** | **22.04 LTS** | **20.04 LTS** | **18.04 LTS** | **16.04 LTS** |
|--|--|--|--|--|--|
| **Availability** |  | Built-in | Built-in | Built-in | Built-in |
| **[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core)** | 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| Windows Server 2016 Accurate Time | 2022, 2019, 2016 | ✔ | ✔ | ✔ | ✔ |
| **[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking)** |  |  |  |  |  |
| Jumbo frames | 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| VLAN tagging and trunking | 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| Live migration | 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| Static IP Injection | 2022, 2019, 2016, 2012 R2 | ✔ Note 1 | ✔ Note 1 | ✔ Note 1 | ✔ Note 1 |
| vRSS | 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| TCP Segmentation and Checksum Offloads | 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| SR-IOV | 2022, 2019, 2016 | ✔ | ✔ | ✔ | ✔ |
| **[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage)** |  |  |  |  |  |
| VHDX resize | 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| Virtual Fibre Channel | 2022, 2019, 2016, 2012 R2 | ✔ Note 2 | ✔ Note 2 | ✔ Note 2 | ✔ Note 2 |
| Live virtual machine backup | 2022, 2019, 2016, 2012 R2 | ✔ Note 3, 4, 5 | ✔ Note 3, 4, 5 | ✔ Note 3, 4, 5 | ✔ Note 3, 4, 5 |
| TRIM support | 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| SCSI WWN | 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| **[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory)** |  |  |  |  |  |
| PAE Kernel Support | 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| Configuration of MMIO gap | 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| Dynamic Memory - Hot-Add | 2022, 2019, 2016, 2012 R2 | ✔ Note 6, 7, 8 | ✔ Note 6, 7, 8 | ✔ Note 6, 7, 8 | ✔ Note 6, 7, 8 |
| Dynamic Memory - Ballooning | 2022, 2019, 2016, 2012 R2 | ✔ Note 6, 7, 8 | ✔ Note 6, 7, 8 | ✔ Note 6, 7, 8 | ✔ Note 6, 7, 8 |
| Runtime Memory Resize | 2022, 2019, 2016 | ✔ | ✔ | ✔ | ✔ |
| **[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video)** |  |  |  |  |  |
| Hyper-V specific video device | 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| **[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous)** |  |  |  |  |  |
| Key/value pair | 2022, 2019, 2016, 2012 R2 | ✔ Note 5, 9 | ✔ Note 5, 9 | ✔ Note 5, 9 | ✔ Note 5, 9 |
| Non-Maskable Interrupt | 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| File copy from host to guest | 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| lsvmbus command | 2022, 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| Hyper-V Sockets | 2022, 2019, 2016 | ✔ | ✔ | ✔ | ✔ |
| PCI Passthrough/DDA | 2022, 2019, 2016 | ✔ | ✔ | ✔ | ✔ |
| **[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines)** |  |  |  |  |  |
| Boot using UEFI | 2022, 2019, 2016, 2012 R2 | ✔ | ✔ Note 10, 11 | ✔ Note 10, 11 | ✔ Note 10, 11 |
| Secure boot | 2022, 2019, 2016 | ✔ | ✔ | ✔ | ✔ |

## Notes

1. Static IP injection may not work if **NetworkManager** has been configured for a given Hyper-V-specific network adapter on the virtual machine as it can override static IP settings that have been manually configured. To ensure smooth functioning of static IP injection, ensure that Network Manager is turned off completely or has been turned off for a specific network adapter through its **ifcfg-ethX** file.

1. While using virtual fiber channel devices, ensure that logical unit number 0 (LUN 0) has been populated. If LUN 0 hasn't been populated, a Linux virtual machine might not be able to mount fiber channel devices natively.

1. If there are open file handles during a live virtual machine backup operation, then in some corner cases, the backed-up VHDs might have to undergo a file system consistency check (`fsck`) on restore.

1. Live backup operations can fail silently if the virtual machine has an attached iSCSI device or direct-attached storage (also known as a pass-through disk).

1. On long term support (LTS) releases use latest virtual Hardware Enablement (HWE) kernel for up to date Linux Integration Services.

   To install the Azure-tuned kernel on 16.04, 18.04 and 20.04, run the following commands as root (or sudo):

   ```bash
   # apt-get update
   # apt-get install linux-azure
   ```

1. Dynamic memory support is only available on 64-bit virtual machines.

1. Dynamic Memory operations can fail if the guest operating system is running too low on memory. The following are some best practices:

   * Startup memory and minimal memory should be equal to or greater than the amount of memory that the distribution vendor recommends.

   * Applications that tend to consume the entire available memory on a system are limited to consuming up to 80 percent of available RAM.

1. If you're using Dynamic Memory on Windows Server 2019, Windows Server 2016 or Windows Server 2012/2012 R2 operating systems, specify **Startup memory**, **Minimum memory**, and **Maximum memory** parameters in multiples of 128 megabytes (MB). Failure to do so can lead to Hot-Add failures, and you might not see any memory increase on a guest operating system.

1. In Windows Server 2019, Windows Server 2016 or Windows Server 2012 R2, the key/value pair infrastructure might not function correctly without a Linux software update. Contact your distribution vendor to obtain the software update in case you see problems with this feature.

1. On Windows Server 2012 R2, Generation 2 virtual machines have secure boot enabled by default and some Linux virtual machines won't boot unless the secure boot option is disabled. You can disable secure boot in the **Firmware** section of the settings for the virtual machine in **Hyper-V Manager** or you can disable it using PowerShell:

    ```Powershell
    Set-VMFirmware -VMName "VMname" -EnableSecureBoot Off
    ```

1. Before attempting to copy the VHD of an existing Generation 2 VHD virtual machine to create new Generation 2 virtual machines, follow these steps:

    1. Log in to the existing Generation 2 virtual machine.

    2. Change directory to the boot EFI directory:

       ```bash
       # cd /boot/efi/EFI
       ```

    3. Copy the ubuntu directory in to a new directory named boot:

       ```bash
       # sudo cp -r ubuntu/ boot
       ```

    4. Change directory to the newly created boot directory:

       ```bash
       # cd boot
       ```

    5. Rename the shimx64.efi file:

       ```bash
       # sudo mv shimx64.efi bootx64.efi
       ```

1. In order to perform live migrations for VMs that are Generation 2 configured, the **Migrate to a physical computer with a different processor version** option must be enabled under *Processor* > *Compatibility* in your VM settings. To learn more, see [Processor compatibility mode in Hyper-V](../hyper-v/manage/processor-compatibility-mode-hyper-v.md).

## See Also

* [Supported CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V](Supported-CentOS-and-Red-Hat-Enterprise-Linux-virtual-machines-on-Hyper-V.md)

* [Supported Debian virtual machines on Hyper-V](Supported-Debian-virtual-machines-on-Hyper-V.md)

* [Supported Oracle Linux virtual machines on Hyper-V](Supported-Oracle-Linux-virtual-machines-on-Hyper-V.md)

* [Supported SUSE virtual machines on Hyper-V](Supported-SUSE-virtual-machines-on-Hyper-V.md)

* [Feature Descriptions for Linux and FreeBSD virtual machines on Hyper-V](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md)

* [Best Practices for running Linux on Hyper-V](Best-Practices-for-running-Linux-on-Hyper-V.md)

* [Set-VMFirmware](/powershell/module/hyper-v/set-vmfirmware)

* [Ubuntu 14.04 in a Generation 2 VM - Ben Armstrong's Virtualization Blog](/archive/blogs/virtual_pc_guy/ubuntu-14-04-in-a-generation-2-vm)
