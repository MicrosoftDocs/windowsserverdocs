---
title: Secured-core server by OEM partners in Windows Server
description: Learn how Secured-core server by Windows Server hardware OEMs offers advanced protection of your operating environment
author: SCuffy
ms.author: wscontent
ms.topic: conceptual 
ms.date: 02/27/2023
ms.prod: windows-server
ms.custom: template-overview, team=cloud_advocates, kr2b-contr-experiment
ms.contributors: socuff-01282022
---

# What is Secured-core server?

>Applies to: Windows Server 2022, Azure Stack HCI version 21H2 and later

Secured-core is a collection of security features that offers built-in hardware, firmware, and operating system protection. The protection provided by Secured-core begins before the operating system boots and continues whilst running. Secured-core server is designed to deliver a secure platform for critical data and applications.

Secured-core server is built on three key concepts:

- Creating a hardware back root of trust.
- Defense again firmware level attacks.
- Protecting the OS from the execution of unverified code.

## What makes a Secured-core Server

Secured-core started with Windows PCs through a deep collaboration between Microsoft and PC manufacturing partners to provide the most elevated Windows security ever. Microsoft has expanded the partnership further with server manufacturing partners to help ensure Windows Server delivers a secure operating system environment.

Windows Server integrates closely with the hardware to provide increasing levels of security:

- Recommended baseline: The recommended minimum for all systems to provide foundational system integrity. Uses TPM 2.0 for a hardware root of trust, secure boot.
- Secured-core Server: Recommended for systems and industry requiring higher levels of assurance. Secured-core builds on the previous features and uses advanced processor capabilities to provide protection from firmware attacks.

The following table shows how each security concept and feature are used to create a Secured-core Server.

| Concept | Feature | Requirement | Recommended baseline | Secured-Core Server |
|---|---|---|---|---|
| **Create a hardware backed root of trust** |  |  |  |  |
|  | Secure Boot | Secure Boot is enabled in the BIOS by default. | ✓ | ✓ |
|  | Trusted Platform Module (TPM) 2.0 | Meet the latest Microsoft requirements for the Trusted Computing Group (TCG) specification | ✓ | ✓ |
|  | Certified for Windows Server | Demonstrates that a server system meets Microsoft's highest technical bar for security, reliability and manageability. | ✓ | ✓ |
|  | Boot DMA protection | Support on devices that have the Input/Output Memory Management Unit (IOMMU). For example, Intel VT-D, AMD-Vi. |  | ✓ |
| **Defend against firmware level attacks** |  |  |  |  |
|  | System Guard Secure Launch | Enabled in the operating system with compatible supported Intel Trusted Execution Technology (TXT) and AMD SKINIT hardware |  | ✓ |
| **Protect the OS from execution of unverified code** |  |  |  |  |
|  | Virtualization-based Security (VBS) |  | ✓ | ✓ |
|  | Hypervisor Enhanced Code Integrity (HVCI) |  | ✓ | ✓ |

TODO: Requires at least Intel ICX or AMD Milan. Why? are the instruction sets/features covered below

From PPT:

- Baseline requirement:
  - Windows Hardware Lab Kit (HLK) Certified
  - Secure Boot*
  - Trusted Platform Module 2.0
  - Hypervisor Enhanced Code Integrity (HVCI)*
- Secured-core Server AQ**
  - Secured-core certified compatible hardware (https://www.windowsservercatalog.com/)
  - System Guard Secure Launch (TXT/SKINIT***)
  - Direct Memory Access (DMA) Protection
  - Disabled S3 sleep TODO: possible overlap with System Guard, is this required for System Guard anyway?

1. TODO: *confirm base requirement shows capable vs enabled? But this is beyond WS hardware requirements?
1. TODO: **confirm what is AQ?
1. TODO: ***what is TXT/SKINIT, I assume this is different to DRTM
1. TODO: ****TODO: What about? Default trust for Microsoft bootloaders only with BIOS option for enabling trust for non-Microsoft bootloaders

### Create a hardware backed root of trust

Secured-core Servers ship with UEFI Secure Boot and Trusted Platform Module (TPM) 2.0 enabled.

UEFI Secure Boot verifies that each of the boot components such as UEFI firmware drivers, EFI applications and so on are digitally signed by a trusted author. Upon successful verification, the server boots and the firmware hands off the control to the operating system. This helps elevate supply chain security of the servers.

TPM 2.0 provides a secure, hardware-backed storage for sensitive keys and data. Moreover, every component that is loaded during the boot process is measured into the TPM This hardware root-of-trust elevates the protection provided by capabilities like BitLocker, which uses the TPM 2.0 and facilitates the creation of attestation-based workflows that can be incorporated into zero-trust security strategies.

Learn more about [Trusted Platform Modules](/windows/security/information-protection/tpm/trusted-platform-module-overview) and [how Windows 10 uses the TPM](/windows/security/information-protection/tpm/how-windows-uses-the-tpm).

### Defend against firmware level attacks

In the last few years, there has been a significant uptick in firmware vulnerabilities, in large part due to the higher level of privileges that firmware runs combined with limited visibility into firmware by traditional anti-virus solutions. Using processor support for Dynamic Root of Trust of Measurement (DRTM) technology, Secured-core systems put firmware in a hardware-backedsed sandbox helping to limit the impact of vulnerabilities in millions of lines of highly privileged firmware code. Along with pre-boot DMA protection, Secured-core systems provide protection throughout the boot process.

### Protect the OS from execution of unverified code

Secured-core Server support Virtualization-based security (VBS) and hypervisor-protected code integrity (HVCI). HVCI helps ensure that only signed and trusted code is allowed to execute in the kernel. This prevents attacks that attempt to modify the kernel mode code such as drivers, and against exploits such as WannaCry that attempt to inject malicious code into the kernel. 

## Simplified management

The new security extension in the Windows Admin Center makes provides a single pane of glass view for customers to view and configure the OS security features of Secured-core for Azure Stack HCI systems.  It allows customers to enable advanced security features with the click of a button from a web browser anywhere in the world. With Azure Stack HCI Integrated Systems, manufacturing partners have further simplified the configuration experience for customers so that Microsoft’s best server security is available right out of the box.

<!--- Insert image? --->

Learn more about [Windows Admin Center]( https://learn.microsoft.com/en-us/windows-server/manage/windows-admin-center/overview).

## Preventative defense

You can proactively defend against and disrupt many of the paths attackers use to exploit systems by enabling Secured-core functionality. Secured-core server enables advanced security features at the bottom layers of the technology stack. This protects the most privileged areas of the system before many security tools are aware of exploits. It also occurs without the need for extra tasks or monitoring by IT and SecOps teams.

# Begin your Secured-core journey

Secured-core servers, which are now available in the [Azure Stack HCI]( https://hcicatalog.azurewebsites.net/#/catalog?FeatureSupported=securedCoreServer) and [Windows Server]( https://www.windowsservercatalog.com/results.aspx?&bCatID=1333&cpID=0&avc=10&ava=0&avt=0&avq=140&OR=1&PGS=25&PG=1) catalogs, come fully equipped with industry-leading security mitigations built into the hardware, firmware, and the operating system to help thwart some of the most advanced attack vectors. Coupled with Windows Admin Center and Microsoft services such as Azure Sentinel and Microsoft Defender for Cloud, managing and monitoring the security state of your mission-critical infrastructure has never been easier.

Learn more about how secured-core servers can help protect your workloads here:
>> Microsoft brings advanced hardware security to Server and Edge with Secured-core - Microsoft Security Blog
>> New Secured-core servers are now available from the Microsoft ecosystem to help secure your infrastructure - Microsoft Security Blog
