---
title: Supported FreeBSD virtual machines on Hyper-V
description: Lists the FreeBSD/Linux integration services and features included in each version
ms.topic: article
ms.assetid: 930e758f-bd50-46b4-a3a4-9857110f17b4
ms.author: kkashanjat
author: kkkashan
ms.date: 09/27/2023
---
# Supported FreeBSD virtual machines on Hyper-V

> Applies to: Azure Stack HCI, Windows Server 2022, Windows Server 2019, Hyper-V Server 2019, Windows Server 2016, Hyper-V Server 2016, Windows Server 2012 R2, Hyper-V Server 2012 R2, Windows 10, Windows 8.1

The following feature distribution map indicates the features in each version. The known issues and workarounds for each distribution are listed after the table.

## Table legend

* **Built in** - BIS (FreeBSD Integration Service) are included as part of this FreeBSD release.

* &#10004; - Feature available

* (*blank*) - Feature not available

| **Feature** | **Windows Server operating system version** | **13.0-13.1** | **12.0-12.3** | **11.2-11.4** | **10.4** |
|--|--|--|--|--|--|
| **Availability** |  | Built in | Built in | Built in | Built in |
| **[Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#core)** | 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| Windows Server 2016 Accurate Time | 2019, 2016 | ✔ | ✔ | ✔ |  |
| **[Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#networking)** |  |  |  |  |  |
| Jumbo frames | 2019, 2016, 2012 R2 | ✔ Note 3 | ✔ Note 3 | ✔ Note 3 | ✔ Note 3 |
| VLAN tagging and trunking | 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| Live migration | 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| Static IP Injection | 2019, 2016, 2012 R2 | ✔ Note 4 | ✔ Note 4 | ✔ Note 4 | ✔ Note 4 |
| vRSS | 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| TCP Segmentation and Checksum Offloads | 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| Large Receive Offload (LRO) | 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| SR-IOV | 2019, 2016 | ✔ | ✔ | ✔ | ✔ |
| **[Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#storage)** |  | Note 1 | Note1 | Note 1 | Note 1 |
| VHDX resize | 2019, 2016, 2012 R2 | ✔ Note 6 | ✔ Note 6 | ✔ Note 6 | ✔ Note 6 |
| Virtual Fibre Channel | 2019, 2016, 2012 R2 |  |  |  |  |
| Live virtual machine backup | 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ |  |
| TRIM support | 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ |  |
| SCSI WWN | 2019, 2016, 2012 R2 |  |  |  |  |
| **[Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#memory)** |  |  |  |  |  |
| PAE Kernel Support | 2019, 2016, 2012 R2 |  |  |  |  |
| Configuration of MMIO gap | 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| Dynamic Memory - Hot-Add | 2019, 2016, 2012 R2 |  |  |  |  |
| Dynamic Memory - Ballooning | 2019, 2016, 2012 R2 |  |  |  |  |
| Runtime Memory Resize | 2019, 2016 |  |  |  |  |
| **[Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#video)** |  |  |  |  |  |
| Hyper-V specific video device | 2019, 2016, 2012 R2 |  |  |  |  |
| **[Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#miscellaneous)** |  |  |  |  |  |
| Key/value pair | 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| Non-Maskable Interrupt | 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ | ✔ |
| File copy from host to guest | 2019, 2016, 2012 R2 |  |  |  |  |
| lsvmbus command | 2019, 2016, 2012 R2 |  |  |  |  |
| Hyper-V Sockets | 2019, 2016 |  |  |  |  |
| PCI Passthrough/DDA | 2019, 2016 | ✔ | ✔ | ✔ |  |
| **[Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#generation-2-virtual-machines)** |  |  |  |  |  |
| Boot using UEFI | 2019, 2016, 2012 R2 | ✔ | ✔ | ✔ |  |
| Secure boot | 2019, 2016 |  |  |  |  |

## <a name="BKMK_notes"></a>Notes

1. Suggest to [Label Disk Devices]( https://www.freebsd.org/doc/handbook/geom-glabel.html) to avoid ROOT MOUNT ERROR during startup.

2. The virtual DVD drive may not be recognized when BIS drivers are loaded on FreeBSD 8.x and 9.x unless you enable the legacy ATA driver through the following command.
    ```sh
    # echo ‘hw.ata.disk_enable=1' >> /boot/loader.conf
    # shutdown -r now
    ```

3. 9126 is the maximum supported MTU size.

4. In a failover scenario, you cannot set a static IPv6 address in the replica server. Use an IPv4 address instead.

5. KVP is provided by ports on FreeBSD 10.0. See the [FreeBSD 10.0 ports](https://svnweb.freebsd.org/ports/branches/2015Q1/emulators/hyperv-is/) on FreeBSD.org for more information.

6. To make VHDX online resizing work properly in FreeBSD 11.0, a special manual step is required to work around a GEOM bug which is fixed in 11.0+, after the host resizes the VHDX disk - open the disk for write, and run “gpart recover” as the following.
    ```sh
    # dd if=/dev/da1 of=/dev/da1 count=0
    # gpart recover da1
    ```

**Additional Notes**: The feature matrix of 10 stable and 11 stable is same with FreeBSD 11.1 release. In addition, FreeBSD 10.2 and previous versions (10.1, 10.0, 9.x, 8.x) are end of life. Please refer [here](https://security.freebsd.org/) for an up-to-date list of supported releases and the latest security advisories.

## See Also

* [Feature Descriptions for Linux and FreeBSD virtual machines on Hyper-V](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md)
* [Best practices for running FreeBSD on Hyper-V](Best-practices-for-running-FreeBSD-on-Hyper-V.md)
