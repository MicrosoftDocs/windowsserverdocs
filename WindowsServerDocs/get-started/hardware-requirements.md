---
title: Hardware requirements for Windows Server
description: What are the minimum hardware requirements for storage, CPU, network, memory, RAM for Windows Server.
ms.topic: article
author: dknappettmsft
ms.author: daknappe
manager: femila
ms.date: 8/16/2021
ms.prod: windows-server
ms.assetid: 4a8b42d7-9fe5-4efe-9ea1-ace2131fe068
---

# Hardware requirements for Windows Server

This article outlines the minimum hardware requirements to run Windows Server. If your computer has less than the minimum requirements, you will not be able to install this product correctly. Actual requirements will vary based on your system configuration and the applications and features you install.

Unless otherwise specified, these minimum hardware requirements apply to all installation options (Server Core and Server with Desktop Experience) and both Standard and Datacenter editions.

> [!IMPORTANT]
> The highly diverse scope of potential deployments makes it unrealistic to state recommended hardware requirements that would be generally applicable. Consult documentation for each of the server roles you intend to deploy for more details about the resource needs of particular server roles. For the best results, conduct test deployments to determine appropriate hardware requirements for your particular deployment scenarios.

## Processor

Processor performance depends not only on the clock frequency of the processor, but also on the number of processor cores and the size of the processor cache. The following are the processor requirements for this product:

**Minimum**:

- 1.4 GHz 64-bit processor
- Compatible with x64 instruction set
- Supports NX and DEP
- Supports CMPXCHG16b, LAHF/SAHF, and PrefetchW
- Supports Second Level Address Translation (EPT or NPT)

[Coreinfo](/sysinternals/downloads/coreinfo), part of Windows Sysinternals, is a tool you can use to confirm which of these capabilities your CPU has.

## RAM

The following are the estimated RAM requirements for this product:

**Minimum**:

- 512 MB (2 GB for Server with Desktop Experience installation option)
- ECC (Error Correcting Code) type or similar technology, for physical host deployments

> [!IMPORTANT]
> If you create a virtual machine with the minimum supported hardware parameters (1 processor core and 512 MB RAM) and then attempt to install this release on the virtual machine, Setup will fail.
>
> To avoid this, do one of the following:
>
> - Allocate more than 800 MB RAM to the virtual machine on which you intend to install this release. Once Setup has completed, you can change the allocation to as little as 512 MB RAM, depending on the actual server configuration. If you've modified the boot image for Setup with addition languages and updates, you may need to allocate more than 800 MB RAM in order to complete the installation
> - Interrupt the boot process of this release on the virtual machine with the keyboard combination `SHIFT+F10`. In the command prompt that opens, use `diskpart.exe` to create and format an installation partition. Run `wpeutil createpagefile /path=C:\pf.sys` (assuming the installation partition you created was C:\\). Then close the command prompt and proceed with Setup.

## Storage controller and disk space requirements

Computers that run Windows Server  must include a storage adapter that is compliant with the PCI Express architecture specification. Persistent storage devices on servers classified as hard disk drives must not be PATA. Windows Server does not allow ATA/PATA/IDE/EIDE for boot, page, or data drives.

The following are the estimated **minimum** disk space requirements for the system partition.

**Minimum**: 32 GB

> [!NOTE]
> Be aware that 32 GB should be considered an *absolute minimum* value for successful installation. This minimum should allow you to install Windows Server 2022 using the Server Core installation option, with the Web Services (IIS) server role. A server in Server Core mode is about 4 GB smaller than the same server using the Server with Desktop Experience installation option.
>
> The system partition will need extra space for any of the following circumstances:
>
> - If you install the system over a network.
> - Computers with more than 16 GB of RAM will require more disk space for paging, hibernation, and dump files.

## Network adapter requirements

Network adapters used with this release should include these features:

**Minimum**:

- An ethernet adapter capable of at least 1 gigabit per second throughput
- Compliant with the PCI Express architecture specification.

A network adapter that supports network debugging (KDNet) is useful, but not a minimum requirement.

A network adapter that supports the Pre-boot Execution Environment (PXE) is useful, but not a minimum requirement.

## Other requirements

Computers running this release also must have the following:

- DVD drive (if you intend to install the operating system from DVD media)

The following items are only required for certain features:

- UEFI 2.3.1c-based system and firmware that supports secure boot
- Trusted Platform Module
- Graphics device and monitor capable of Super VGA (1024 x 768) or higher-resolution
- Keyboard and Microsoft mouse (or other compatible pointing device)
- Internet access (fees may apply)

> [!NOTE]
> A Trusted Platform Module (TPM) chip is required in order to use certain features such as BitLocker Drive Encryption. If your computer uses TPM, it must meet these requirements:
>
> - Hardware-based TPMs must implement version 2.0 of the TPM specification.
> - TPMs that implement version 2.0 must have an EK certificate that is either pre-provisioned to the TPM by the hardware vendor or be capable of being retrieved by the device during the first boot.
> - TPMs that implement version 2.0 must ship with SHA-256 PCR banks and implement PCRs 0 through 23 for SHA-256. It is acceptable to ship TPMs with a single switchable PCR bank that can be used for both SHA-1 and SHA-256 measurements.
>
> A UEFI option to turn off the TPM is not a requirement.
