---
title: Hardware requirements for Windows Server
description: What are the minimum hardware requirements for storage, CPU, network, and memory (RAM) for Windows Server.
ms.topic: article
author: xelu86
ms.author: wscontent
ms.date: 03/07/2024
ms.assetid: 4a8b42d7-9fe5-4efe-9ea1-ace2131fe068
---

# Hardware requirements for Windows Server

To install Windows Server correctly, your computer must meet the minimum hardware requirements outlined in this article. If your computer falls short of these requirements, the product may not install properly. Actual requirements vary based on your system configuration, applications, and features that are installed.

Unless otherwise specified, these minimum hardware requirements apply to all installation options (Server Core and Server with Desktop Experience) for both Windows Server Standard and Windows Server Datacenter editions.

> [!IMPORTANT]
> The highly diverse scope of potential deployments makes it unrealistic to state recommended hardware requirements that would be generally applicable. Consult documentation for each of the server roles you intend to deploy for more details about the resource needs of particular server roles. For the best results, conduct test deployments to determine appropriate hardware requirements for your particular deployment scenarios.

## Components

# [CPU](#tab/cpu)

Processor performance depends not only on the clock frequency of the processor, but also on the number of processor cores and the size of the processor cache. The following are the processor requirements.

**Minimum**:

- 1.4 GHz 64-bit processor
- Compatible with x64 instruction set
- Supports NX and DEP
- Supports CMPXCHG16b, LAHF/SAHF, and PrefetchW
- Supports Second Level Address Translation (EPT or NPT)

You can utilize [Coreinfo](/sysinternals/downloads/coreinfo), which is a tool included in Windows Sysinternals, to verify the capabilities that your CPU possesses.

# [RAM](#tab/ram)

The following are the estimated Random Access Memory (RAM) requirements for this product.

**Minimum**:

- 512 MB for Server Core
- 2 GB for Server with Desktop Experience
- ECC (Error Correcting Code) type or similar technology for physical host deployments

> [!IMPORTANT]
> Attempting to install Windows Server in a virtual machine configured with the minimum supported hardware parameters (1 processor core and 512 MB RAM) will result in a failed installation.
>
> To prevent this issue, perform one of the following:
>
> - Allocate more than 800 MB RAM to the virtual machine on which you intend to install this release. Once the setup has completed, you can change the allocation to as little as 512 MB RAM, depending on the actual server configuration. If you've modified the boot image for the setup with addition languages and updates, you may need to allocate more than 800 MB RAM in order to complete the installation.
> - Interrupt the boot process of this release on the virtual machine with the keyboard combination `SHIFT+F10`. In the command prompt that opens, use `diskpart.exe` to create and format an installation partition. Run `wpeutil createpagefile /path=C:\pf.sys` (assuming the installation partition you created was C:\\). Then close the command prompt and proceed with the installation.

# [Storage](#tab/storage)

Computers that run Windows Server must include a storage adapter that is compliant with the PCI Express architecture specification. Servers classified as hard disk drives must not use Parallel Advanced Technology Attachment (PATA) for persistent storage devices. Windows Server also doesn't allow PATA, Advanced Technology Attachment (ATA), Integrated Drive Electronics (IDE), and Enhanced Integrated Drive Electronic (EIDE) for boot, page, or data drives.

The following are the estimated **minimum** disk space requirements for the system partition.

**Minimum**:

- 32 GB of space

> [!NOTE]
> Be aware that 32 GB should be considered an *absolute minimum* value for successful installation. This minimum should allow you to install Windows Server 2022 or later using the Server Core installation option with the Web Services (IIS) server role. A server in Server Core mode is ~4 GB smaller than the same server using the **Server with Desktop Experience** installation option.
>
> The system partition will need extra space for any of the following circumstances:
>
> - If you install the system over a network.
> - Computers with more than 16 GB of RAM will require more disk space for paging, hibernation, and dump files.

# [Network](#tab/network)

Network adapters used should include these features.

**Minimum**:

- An Ethernet adapter that can achieve a throughput of at least 1 gigabit per second
- Compliant with the PCI Express architecture specification

A network adapter that supports network debugging (KDNet) is useful, but not a minimum requirement.

A network adapter that supports the Pre-boot Execution Environment (PXE) is useful, but not a minimum requirement.

---

## Other requirements

There are other hardware requirements to consider depending on your scenario:

- DVD drive (if you intend to install the operating system from DVD media)

The following items are only required for certain features:

- UEFI 2.3.1c-based system and firmware that supports secure boot
- Trusted Platform Module (TPM)
- Graphics device and monitor capable of Super VGA (1024 x 768) or higher-resolution
- Keyboard and Microsoft mouse (or other compatible pointing device)
- Internet access (fees may apply)

> [!NOTE]
> A TPM chip is required in order to use certain features such as **BitLocker Drive Encryption**. If your computer has a TPM, it must meet these requirements:
>
> - Hardware-based TPMs must implement version 2.0 of the TPM specification.
> - TPMs that implement version 2.0 must have an EK certificate that is either pre-provisioned to the TPM by the hardware vendor or be capable of being retrieved by the device during the first boot.
> - TPMs that implement version 2.0 must ship with SHA-256 PCR banks and implement PCRs 0 through 23 for SHA-256. It is acceptable to ship TPMs with a single switchable PCR bank that can be used for both SHA-1 and SHA-256 measurements.
