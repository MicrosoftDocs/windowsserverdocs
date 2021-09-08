---
title: Secured-core server from OEM partners
description: Find out the advanced security features with Secured-core server hardware from OEM partners.
author: SCuffy
ms.author: socuff
ms.topic: overview 
ms.date: 09/07/2021
ms.prod: windows-server
ms.custom: template-overview 
---

# What is Secured-core server?
Secured-core server combines hardware, firmware, and driver capabilities to further protect the operating environment - from the boot process through to data in memory. It's built on three key pillars: simplified security, advanced protection, and preventative defense.

## Simplified security
Certified OEM hardware for Secured-core server gives you the assurance that the hardware, firmware, and drivers meet the requirements for Secured-core server capabilities. Windows Server systems can be easily configured in Windows Admin Center to enable these capabilities.

## Advanced protection
The protections enabled by a Secured-core server are targeted to create a secure platform for critical applications and data used on that server. The Secured-core functionality spans the following areas:

- **Hardware root-of-trust**
    
    Trusted Platform Modules (TPM) are either hardware chips (embedded in the motherboard or added on), or newer processors have a firmware-based TPM.  A TPM can create and store encryption keys and store other secrets like certificates. This chip storage is separate from traditional disk or memory storage used by the operating system and applications, so it is isolated from software-based attacks.

    A TPM 2.0 chip can check the integrity of the BIOS and firmware of the device, comparing it to information that has been burned into the chip by the device manufacturer. This Secure Boot capability confirms that no unauthorized firmware or software has been loaded before the operating system, and allows the operating system to then load. This provides a “hardware root of trust” – a hardware level verification that the rest of the operating system and applications can rely on.

    Learn more about [Trusted Platform Modules](/windows/security/information-protection/tpm/trusted-platform-module-overview) and [how Windows 10 uses the TPM.](/windows/security/information-protection/tpm/how-windows-uses-the-tpm)

-  **Secure Boot with Dynamic Root of Trust for Measurement (DRTM)**
    
    Root of Trust for Measurement (RTM) does not live solely inside the TPM chip. It is a software capability that the TPM helps with. The environment that is booting is measured and compared to verify it has not been tampered with. There are many different things that happen during boot (known as the boot chain) and these can change over time and change the order in which they load. Dynamic Root of Trust for Measurement allows the components to load first and then be measured. This root of trust is another security check that system components (the boot chain) has not been tampered with.

- **System Guard with Kernel Direct Memory Access (DMA) protection**
    
    PCI devices, like high-performance graphics cards, used to be connected to the motherboard in PCI slots or they were soldered onto the motherboard. These devices have direct access to read and write system memory using the system processor, hence why they are perfect for high-performance tasks. With externally accessible PCIe ports, you can now plug in certain PCI devices like you would a USB key. Unfortunately, that means an unattended device could now have a malicious PCI device plugged into it, which could read the system memory or load malicious code into it, with no protection. This is known as a drive-by attack.

    [Kernel DMA protection](/windows/security/information-protection/kernel-dma-protection-for-thunderbolt) uses the Input/Output Memory Management Unit (IOMMU) to block PCI devices unless the drivers for that device support memory isolation, like DMA remapping. DMA remapping restricts the device to a certain memory location (a pre-assigned domain or physical memory region). That ensures that the device is allocated a clear space of memory to perform its functions and doesn’t have access to any other information stored in system memory. If the device driver doesn’t support DMA remapping, it won’t be able to run on a Secured-core server.

- **Virtualization-based security (VBS) and Hypervisor-based code integrity (HVCI)**
    
    Virtualization-based security uses hardware-based virtualization features to create and isolate a secure region of memory away from the operating system. A Secured-core server can use this to protect authenticated user credentials and run other security features, away from the reach of malware that gains access to the operating system kernel.

    Learn more about [virtualization-based security.](/windows-hardware/design/device-experiences/oem-vbs)

    Hypervisor-based code integrity (HVCI) uses VBS to check the integrity of kernel mode drivers and binaries before they are started and prevents unsigned drivers or system files from being loaded into system memory. User-mode configurable code integrity policy checks applications before they're loaded and will only start executables that are signed by known, approved signers. As VBS runs these checks in an isolated environment, the code does not gain access to the hypervisor or system memory until it has been checked and verified inside the VBS environment.

    Learn more about [hypervisor-based code integrity.](/windows-hardware/design/device-experiences/oem-hvci-enablement)

## Preventative defense
Enabling Secured-core functionality helps proactively defend against and disrupt many of the paths attackers may use to exploit a system. Secured-core server enables advanced security features at the bottom layers of the technology stack, protecting the most privileged areas of the system before many security tools are aware of the exploit with no additional tasks or monitoring needed by the IT and SecOps teams.

