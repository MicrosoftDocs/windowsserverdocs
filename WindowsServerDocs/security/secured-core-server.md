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

>Applies to: Windows Server 2022, Azure Stack HCI, version 21H2

TODO: Article introduction

Secured-core is a collection of security features that offers protection in pre-OS and OS runtime environments. It started with Windows PCs through a deep collaboration between Microsoft and PC manufacturing partners to provide the most elevated Windows security ever. Microsoft has expanded the partnership further with server manufacturing partners to bring the unparalleled host protection to servers. Secured-core server is built on three key pillars: simplified security, advanced protection, and preventative defense.

## What makes a Secured-core Server

From WAC:

- Hypervisor Enhanced Code Integrity (HVCI)
- Boot DMA protection
- System Guard
- Secure Boot
- Virtualization-based Security (VBS)
- Trusted Platform Module 2.0 (TPM 2.0)

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

TODO: *confirm base requirement shows capable vs enabled?
TODO: **confirm what is AQ?
TODO: ***what is TXT/SKINIT, I assume this is different to DRTM


|Column1  |Column2  |Column3  |Column4  |Column5  |
|---------|---------|---------|---------|---------|
|Row1     |         |         |         |         |
|     |   test      |         |         |         |
|Row3     |         |         |         |         |
|head     |
|Row5     |         |         |         |         |
|Row6     |         |         |         |         |
|Row7     |         |         |         |         |
|Row8     |         |         |         |         |
|Row9     |         |         |         |         |

Secured-core server protections are designed to deliver platforms that are secure for critical data and applications. The Secured-core functionality spans the following areas:

## Create a hardware backed root of trust

Secured-core Servers ship with UEFI Secure Boot and Trusted Platform Module (TPM) 2.0 enabled.

UEFI Secure Boot verifies that each of the boot components such as UEFI firmware drivers, EFI applications and so on are digitally signed by a trusted author. Upon successful verification, the server boots and the firmware hands off the control to the operating system. This helps elevate supply chain security of the servers.

TPM 2.0 provides a secure, hardware-backed storage for sensitive keys and data. Moreover, every component that is loaded during the boot process is measured into the TPM This hardware root-of-trust elevates the protection provided by capabilities like BitLocker, which uses the TPM 2.0 and facilitates the creation of attestation-based workflows that can be incorporated into zero-trust security strategies. 

Learn more about [Trusted Platform Modules](/windows/security/information-protection/tpm/trusted-platform-module-overview) and [how Windows 10 uses the TPM](/windows/security/information-protection/tpm/how-windows-uses-the-tpm).

## Defend against firmware level attacks

In the last few years, there has been a significant uptick in firmware vulnerabilities, in large part due to the higher level of privileges that firmware runs combined with limited visibility into firmware by traditional anti-virus solutions. Using processor support for Dynamic Root of Trust of Measurement (DRTM) technology, Secured-core systems put firmware in a hardware-backedsed sandbox helping to limit the impact of vulnerabilities in millions of lines of highly privileged firmware code. Along with pre-boot DMA protection, Secured-core systems provide protection throughout the boot process.

## Protect the OS from execution of unverified code

Secured-core Server support Virtualization-based security (VBS) and hypervisor-protected code integrity (HVCI). HVCI helps ensure that only signed and trusted code is allowed to execute in the kernel. This prevents attacks that attempt to modify the kernel mode code such as drivers, and against exploits such as WannaCry that attempt to inject malicious code into the kernel. 

## Simplified management

The new security extension in the Windows Admin Center makes provides a single pane of glass view for customers to view and configure the OS security features of Secured-core for Azure Stack HCI systems.  It allows customers to enable advanced security features with the click of a button from a web browser anywhere in the world. With Azure Stack HCI Integrated Systems, manufacturing partners have further simplified the configuration experience for customers so that Microsoft’s best server security is available right out of the box.

<!--- Insert image? --->

Learn more about [Windows Admin Center]( https://learn.microsoft.com/en-us/windows-server/manage/windows-admin-center/overview).

## Preventative defense

You can proactively defend against and disrupt many of the paths attackers use to exploit systems by enabling Secured-core functionality. Secured-core server enables advanced security features at the bottom layers of the technology stack. This protects the most privileged areas of the system before many security tools are aware of exploits. It also occurs without the need for additional tasks or monitoring by IT and SecOps teams.

# Begin your Secured-core journey

Secured-core servers, which are now available in the [Azure Stack HCI]( https://hcicatalog.azurewebsites.net/#/catalog?FeatureSupported=securedCoreServer) and [Windows Server]( https://www.windowsservercatalog.com/results.aspx?&bCatID=1333&cpID=0&avc=10&ava=0&avt=0&avq=140&OR=1&PGS=25&PG=1) catalogs, come fully equipped with industry-leading security mitigations built into the hardware, firmware, and the operating system to help thwart some of the most advanced attack vectors. Coupled with Windows Admin Center and Microsoft services such as Azure Sentinel and Microsoft Defender for Cloud, managing and monitoring the security state of your mission-critical infrastructure has never been easier.

Learn more about how secured-core servers can help protect your workloads here:
>> Microsoft brings advanced hardware security to Server and Edge with Secured-core - Microsoft Security Blog
>> New Secured-core servers are now available from the Microsoft ecosystem to help secure your infrastructure - Microsoft Security Blog
