---
title: Hardware Requirements for Windows Server
description: Review the minimum hardware requirements for CPU, memory (RAM), storage, and network needed to install and run Windows Server.
ms.topic: concept-article
author: dknappettmsft
ms.author: daknappe
ms.date: 07/02/2025
zone_pivot_groups: windows-os-version
---

# Hardware requirements for Windows Server

To install Windows Server correctly, your computer must meet the minimum hardware requirements outlined in this article. If your computer falls short of these requirements, the product might not install properly. Actual requirements vary based on your system configuration, applications, and features that are installed.

Unless otherwise specified, these minimum hardware requirements apply to all installation options (Server Core and Server with Desktop Experience) for both Windows Server Standard and Windows Server Datacenter editions.

> [!IMPORTANT]
> The highly diverse scope of potential deployments makes it unrealistic to state recommended hardware requirements that would be applicable. Consult documentation for each of the server roles you intend to deploy to learn more about the resource needs of particular server roles. For the best results, conduct test deployments to determine appropriate hardware requirements for your particular deployment scenarios.

## Components

# [CPU](#tab/cpu)

Processor performance depends not only on the clock frequency of the processor, but also on the number of processor cores and the size of the processor cache. The following are the processor requirements.

**Minimum**:

- 1.4-GHz 64-bit processor

- Compatible with x64 instruction set

- Support for NX and DEP

- Support for CMPXCHG16b, LAHF/SAHF, and PrefetchW instructions

- Support for Second Level Address Translation (EPT or NPT)

:::zone pivot="windows-server-2025"

- Support for the SSE4.2 (Streaming SIMD Extensions 4.2) instruction set

- Support for the POPCNT instruction

::: zone-end

You can utilize [Coreinfo](/sysinternals/downloads/coreinfo), which is a tool included in Windows Sysinternals, to verify the capabilities of your CPU.

# [RAM](#tab/ram)

The following are the estimated Random Access Memory (RAM) requirements for this product.

**Minimum**:

:::zone pivot="windows-server-2025"

- 2 GB for Server Core

- 2 GB for Server with Desktop Experience, 4 GB recommended

- ECC (Error Correcting Code) type or similar technology for physical host deployments

> [!IMPORTANT]
> Attempting to install Windows Server on a virtual machine configured with the minimum supported hardware parameters (1 processor core and 1,024 MB RAM) results in a failed installation.
>
> To prevent this issue, perform one of the following actions:
>
> - Allocate 1,280 MB RAM or more to the virtual machine on which you intend to install this release. After setup is complete, you can change the allocation to as little as 1,024 MB RAM, depending on the actual server configuration. If you've modified the boot image for the setup with additional languages and updates, you might need to allocate more than 1,280 MB RAM in order to complete the installation.
>
> - Interrupt the boot process of this release on the virtual machine with the keyboard combination `SHIFT+F10`. In the command prompt that opens, use `diskpart.exe` to create and format an installation partition. Run `wpeutil createpagefile /path=C:\pf.sys` (assuming the installation partition you created was C:\\). Then close the command prompt and proceed with the installation.

::: zone-end

:::zone pivot="windows-server-2022,windows-server-2019,windows-server-2016"

- 1 GB for Server Core

- 2 GB for Server with Desktop Experience

- ECC (Error Correcting Code) type or similar technology for physical host deployments

> [!IMPORTANT]
> Attempting to install Windows Server on a virtual machine configured with the minimum supported hardware parameters (1 processor core and 512 MB RAM) results in a failed installation.
>
> To prevent this issue, perform one of the following actions:
>
> - Allocate 800 MB RAM or more to the virtual machine on which you intend to install this release. After setup is complete, you can change the allocation to as little as 800 MB RAM, depending on the actual server configuration. If you've modified the boot image for the setup with additional languages and updates, you might need to allocate more than 800 MB RAM in order to complete the installation.
>
> - Interrupt the boot process of this release on the virtual machine with the keyboard combination `SHIFT+F10`. In the command prompt that opens, use `diskpart.exe` to create and format an installation partition. Run `wpeutil createpagefile /path=C:\pf.sys` (assuming the installation partition you created was C:\\). Then close the command prompt and proceed with the installation.

::: zone-end

# [Storage](#tab/storage)

Computers that run Windows Server must include a storage adapter that's compliant with the PCI Express architecture specification. Servers classified as hard disk drives must not use Parallel Advanced Technology Attachment (PATA) for persistent storage devices. Windows Server also doesn't allow PATA, Advanced Technology Attachment (ATA), Integrated Drive Electronics (IDE), and Enhanced Integrated Drive Electronic (EIDE) for boot, page, or data drives.

The following are the estimated **minimum** disk space requirements for the system partition.

**Minimum**:

- 32 GB of space

> [!NOTE]
> 32 GB should be considered an *absolute minimum* value for successful installation. This minimum should allow you to install Windows Server 2022 or later using the Server Core installation option with the Web Services (IIS) server role. A server in Server Core mode is ~4 GB smaller than the same server using the **Server with Desktop Experience** installation option.
>
> The system partition needs extra space for any of the following circumstances:
>
> - If you install the system over a network
> - Computers with more than 16 GB of RAM require more disk space for paging, hibernation, and dump files

# [Network](#tab/network)

Network adapters used should include these features.

**Minimum**:

- An Ethernet adapter that can achieve a throughput of at least 1 gigabit per second.

- Compliant with the PCI Express architecture specification.

A network adapter that supports network debugging (KDNet) is useful, but not a minimum requirement.

A network adapter that supports the Preboot Execution Environment (PXE) is useful, but not a minimum requirement.

---

## Secured-core server requirements

Secured-core is a set of integrated hardware, firmware, driver, and operating system (OS) security features that provide enhanced protection against advanced threats. Secured-core systems deliver security that starts before the OS boots and continues throughout system operation. Secured-core server features are available in Windows Server 2022 and later. To deploy a Secured-core server, your device must meet these additional requirements:

- **DMA Remapping (IOMMU)**: Support for *Intel VT-d* or *AMD-Vi* is required to ensure secure and efficient management of direct memory access (DMA) by devices, safeguarding against unauthorized memory access.

- **Kernel DMA Protection**: The system must have opt-in capability for Kernel DMA Protection, which helps prevent attacks that exploit external peripherals to gain unauthorized access.

- **DRTM (Dynamic Root of Trust for Measurement)**: This feature is needed to ensure a secure boot process by verifying the integrity of the system's startup environment, protecting against firmware-based attacks.

> [!NOTE]
> In addition to the specific requirements outlined for Secured-core server, the following features must be enabled on your hardware:
>
> - TPM 2.0
> - Secure Boot
> - Virtualization-based Security (VBS) support, including hardware virtualization extensions
>
> To learn more, see [What is Secured-core server?](/windows-server/security/secured-core-server).

## Other requirements

There are other hardware requirements to consider, depending on your scenario:

- DVD drive (if you intend to install the OS from DVD media)

The following items are required only for certain features:

- UEFI 2.3.1c-based system and firmware that supports secure boot.

- Trusted Platform Module (TPM).

- Integrated or dedicated graphics and monitor capable of Super VGA (1024 x 768) or higher-resolution.

- Keyboard and mouse (or other compatible pointing device).

- Internet access. (Fees might apply.)

> [!NOTE]
> A TPM chip is required in order to use certain features, such as **BitLocker Drive Encryption**. If your computer has a TPM, it must meet these requirements:
>
> - Hardware-based TPMs must implement version 2.0 of the TPM specification.
> - TPMs that implement version 2.0 must have an EK certificate that's either pre-provisioned to the TPM by the hardware vendor or capable of being retrieved by the device during the first boot.
> - TPMs that implement version 2.0 must ship with SHA-256 PCR banks and implement PCRs 0 through 23 for SHA-256. It's acceptable to ship TPMs with a single switchable PCR bank that can be used for both SHA-1 and SHA-256 measurements.

