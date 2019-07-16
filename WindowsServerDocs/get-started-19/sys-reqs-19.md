--- 
title: Windows Server 2019 System Requirements
description: "Minimum requirements for storage, CPU, network, memory, RAM in a clean installation of Windows Server 2019." 
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4a8b42d7-9fe5-4efe-9ea1-ace2131f860e
author: coreyp-at-msft
ms.author: coreyp
manager: jasgroce
ms.localizationpriority: medium
---
# System Requirements

>Applies To: Windows Server 2019 

This topic outlines the minimum system requirements to run Windows Server&reg; 2019.

## Review system requirements  

The following are estimated system requirements Windows Server 2019. If your computer has less than the "minimum" requirements, you will not be able to install this product correctly. Actual requirements will vary based on your system configuration and the applications and features you install.

Unless otherwise specified, these minimum system requirements apply to all installation options (Server Core, Server with Desktop Experience, and Nano Server) and both Standard and Datacenter editions.  

> [!IMPORTANT]  
> The highly diverse scope of potential deployments makes it unrealistic to state "recommended" system requirements that would be generally applicable. Consult documentation for each of the server roles you intend to deploy for more details about the resource needs of particular server roles. For the best results, conduct test deployments to determine appropriate system requirements for your particular deployment scenarios.  

## Processor  

Processor performance depends not only on the clock frequency of the processor, but also on the number of processor cores and the size of the processor cache. The following are the processor requirements for this product:  

**Minimum**:  
- 1.4 GHz 64-bit processor  
- Compatible with x64 instruction set  
- Supports NX and DEP  
- Supports CMPXCHG16b, LAHF/SAHF, and PrefetchW  
- Supports Second Level Address Translation (EPT or NPT)  

[Coreinfo](https://technet.microsoft.com/sysinternals/cc835722.aspx) is a tool you can use to confirm which of these capabilities your CPU has.

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
> -   Allocate more than 800 MB RAM to the virtual machine you intend to install this release on. Once Setup has completed, you can change the allocation to as little as 512 MB RAM, depending on the actual server configuration.  
> -   Interrupt the boot process of this release on the virtual machine with SHIFT+F10. In the command prompt that opens, use Diskpart.exe to create and format an installation partition. Run **Wpeutil createpagefile /path=C:\pf.sys** (assuming the installation partition you created was C:). Close the command prompt and proceed with Setup.  

## Storage controller and disk space requirements  
Computers that run Windows Server 2019 must include a storage adapter that is compliant with the PCI Express architecture specification. Persistent storage devices on servers classified as hard disk drives must not be PATA. Windows Server 2019 does not allow ATA/PATA/IDE/EIDE for boot, page, or data drives.  

The following are the estimated **minimum** disk space requirements for the system partition.  

**Minimum**: 32 GB  

> [!NOTE]
> Be aware that 32 GB should be considered an *absolute minimum* value for successful installation. This minimum should allow you to install Windows Server 2019 in Server Core mode, with the Web Services (IIS) server role. A server in Server Core mode is about 4 GB smaller than the same server in Server with a GUI mode. 
> 
> The system partition will need extra space for any of the following circumstances:  
> 
> -   If you install the system over a network.  
> -   Computers with more than 16 GB of RAM will require more disk space for paging, hibernation, and dump files.  

## Network adapter requirements  

Network adapters used with this release should include these features:  

**Minimum**:  
- An Ethernet adapter capable of at least gigabit throughput  
- Compliant with the PCI Express architecture specification.  

A network adapter that supports network debugging (KDNet) is useful, but not a minimum requirement.   

A network adapter that supports the Pre-boot Execution Environment (PXE) is useful, but not a minimum requirement.

## Other requirements  
Computers running this release also must have the following:  

-   DVD drive (if you intend to install the operating system from DVD media)  

The following items are not strictly required, but are necessary for certain features:  

- UEFI 2.3.1c-based system and firmware that supports secure boot  
- Trusted Platform Module  

-   Graphics device and monitor capable of Super VGA (1024 x 768) or higher-resolution  

-   Keyboard and Microsoft&reg; mouse (or other compatible pointing device)  

-   Internet access (fees may apply)  

> [!NOTE]  
> A Trusted Platform Module (TPM) chip is not strictly required to install this release, though it is necessary in order to use certain features such as BitLocker Drive Encryption. If your computer uses TPM, it must meet these requirements:  
>  
> - Hardware-based TPMs must implement version 2.0 of the TPM specification.  
> - TPMs that implement version 2.0 must have an EK certificate that is either pre-provisioned to the TPM by the hardware vendor or be capable of being retrieved by the device during the first boot.  
> - TPMs that implement version 2.0 must ship with SHA-256 PCR banks and implement PCRs 0 through 23 for SHA-256. It is acceptable to ship TPMs with a single switchable PCR bank that can be used for both SHA-1 and SHA-256 measurements.  
> - A UEFI option to turn off the TPM is not a requirement.  
