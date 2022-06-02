---
title: Secured-core server by OEM partners in Windows Server
description: Learn how Secured-core server by Windows Server hardware OEMs offers advanced protection of your operating environment
author: SCuffy
ms.author: socuff
ms.topic: overview 
ms.date: 06/01/2022
ms.prod: windows-server
ms.custom: template-overview, team=cloud_advocates
ms.contributors: socuff-01282022
ms.custom: kr2b-contr-experiment
---

# What is Secured-core server?

>Applies to: Windows Server 2022, Azure Stack HCI, version 21H2

Secured-core server provides higher levels of protection for operating environments, from boot processes right through to data in memory. It achieves this by advancing a combination of hardware, firmware, and driver capabilities. Secured-core server is built on three key pillars: simplified security, advanced protection, and preventative defense.

## 1. Simplified security

Certified OEM hardware for Secured-core server provides assurance that all hardware, firmware, and drivers meet the requirements for Secured-core server capabilities. You can easily enable these capabilities by configuring Windows Server systems in Windows Admin Center.

## 2. Advanced protection

Secured-core server protections are designed to deliver platforms that are secure for critical data and applications. The Secured-core functionality spans the following areas:

- **Hardware root-of-trust**

    Trusted Platform Modules (TPM) are hardware chips embedded in the motherboard or that are added to it. Newer processors have firmware-based TPMs.  A TPM can create and store encryption keys and store other secrets like certificates. This chip storage is separate from traditional disk or memory storage used by applications and operating systems. This isolates it from software-based attacks.

    A TPM 2.0 chip can check the integrity of the BIOS and firmware of devices. It can compare it to information burned into chips by device manufacturers. This Secure Boot capability checks that no unauthorized firmware or software has loaded before the operating system, and allows the operating system to then load. This provides a “hardware root of trust”. It's a hardware-level verification that the rest of the operating system and applications can rely on.

    Learn more about [Trusted Platform Modules](/windows/security/information-protection/tpm/trusted-platform-module-overview) and [how Windows 10 uses the TPM](/windows/security/information-protection/tpm/how-windows-uses-the-tpm).

- **Secure Boot with Dynamic Root of Trust for Measurement (DRTM)**

    Root of Trust for Measurement (RTM) doesn't live solely inside the TPM chip. It is a software capability that is helped by the TPM. The booting environment is measured and compared to verify that it hasn't been tampered with. Many different processes occur during a boot. This is known as the boot chain. These processes can change over time, including and the order in which they load. Dynamic Root of Trust for Measurement allows the components to load first and then be measured. Root of trust is another security check to ensure that system components (the boot chain) haven't been tampered with.

- **System Guard with Kernel Direct Memory Access (DMA) protection**

    PCI devices in the past, like high-performance graphics cards, were connected to motherboard PCI slots. They were also sometimes soldered onto motherboards. These devices have direct access to read and write system memory using the system processor, hence the reason they are perfect for high-performance tasks. You can now also plug certain PCI devices into externally accessible PCIe ports like you would a USB key. Unfortunately, this means unattended devices could now have malicious PCI devices plugged into them. This allows them to read system memory, or load malicious code without any defense. This is known as a drive-by attack.

    [Kernel DMA protection](/windows/security/information-protection/kernel-dma-protection-for-thunderbolt) uses the Input/Output Memory Management Unit (IOMMU) to block PCI devices unless drivers for those devices support memory isolation, like DMA remapping. DMA remapping restricts devices to a specific memory location (a pre-assigned domain or physical memory region). This ensures that devices are allocated a clear space of memory to perform functions. They don't have access to any other information stored in system memory. If a device driver doesn’t support DMA remapping, it won’t be able to run on a Secured-core server.

- **Virtualization-based security (VBS) and Hypervisor-based code integrity (HVCI)**

    [Virtualization-based security.](/windows-hardware/design/device-experiences/oem-vbs) (VBS) uses hardware-based virtualization features to create and isolate a secure region of memory, away from the operating system. A Secured-core server can use this to protect authenticated user credentials. It can also run other security features away from the reach of any malware that gains access to the operating system kernel.

    [Hypervisor-based code integrity.](/windows-hardware/design/device-experiences/oem-hvci-enablement) (HVCI) uses VBS to check the integrity of kernel mode drivers and binaries before they are started. It also prevents unsigned drivers or system files from being loaded into system memory. User-mode Configurable Code Integrity policy checks applications before they're loaded. It only starts executables that are signed by known, approved signers. VBS runs these checks in an isolated environment. Therefore the code doesn't gain access to the hypervisor or system memory until after it has been checked and verified from within the VBS environment.

## 3. Preventative defense

You can proactively defend against and disrupt many of the paths attackers use to exploit systems by enabling Secured-core functionality. Secured-core server enables advanced security features at the bottom layers of the technology stack. This protects the most privileged areas of the system before many security tools are aware of exploits. It also occurs without the need for additional tasks or monitoring by IT and SecOps teams.
