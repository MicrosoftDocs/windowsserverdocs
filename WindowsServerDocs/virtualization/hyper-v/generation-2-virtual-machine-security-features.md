---
title: Hyper-V Generation 2 Virtual Machine Security Features
description: Discover Hyper-V generation 2 VM security features to protect data and prevent tampering. Learn about secure booting, encryption, and shielding options.
ms.topic: concept-article
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 07/01/2025
---

# Hyper-V generation 2 virtual machine security features

Hyper-V generation 2 virtual machines (VMs) provide robust security features designed to safeguard sensitive data and prevent unauthorized access or tampering. This article explores the security settings available in Hyper-V Manager for generation 2 VMs and shows you how to configure them. Learn how these features can help protect your VMs from threats and ensure compliance with security best practices.

The available security features for generation 2 VMs in Hyper-V include:

- Secure Boot.
- Encryption support for Trusted Platform Module (TPM), live migration, and saved state.
- Shielded VMs.
- Host Guardian Service (HGS).

These security features are designed to help protect the data and state of a virtual machine. You can protect VMs from inspection, theft, and tampering from both malware that might run on the host, and datacenter administrators. The level of security you get depends on the host hardware you run, the virtual machine generation, and whether you set up the companion Host Guardian Service (HGS), that authorizes hosts to start shielded VMs.

The Host Guardian Service was first introduced in Windows Server 2016. It identifies legitimate Hyper-V hosts and allows them to run a set of shielded VMs. You'd most commonly enable the Host Guardian Service for a datacenter, but you can also create a shielded VM to run it locally without setting up Host Guardian Service. You can later distribute the shielded virtual machine to the Host Guardian Service.

To learn how you can make your VMs more secure with the Host Guardian Service, see [Guarded Fabric and Shielded VMs](../../security/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms.md) and [Harden the Fabric: Protecting Tenant Secrets in Hyper-V (Ignite video)](https://go.microsoft.com/fwlink/?LinkId=746379).

## Secure Boot

Secure Boot is a feature available with generation 2 VMs that helps prevent unauthorized firmware, operating systems, or Unified Extensible Firmware Interface (UEFI) drivers (also known as option ROMs) from running at boot time. Secure Boot is enabled by default. You can use secure boot with generation 2 VMs that run Windows or Linux distribution operating systems.

There are three different templates available, depending on the VM's operating system and configuration. The following table lists each of these templates and refers to the certificates that you need to verify the integrity of the boot process:

| Template name | Compatibility |
|--|--|
| Microsoft Windows | Windows operating systems. |
| Microsoft UEFI Certificate Authority | Linux distribution operating systems. |
| Open Source Shielded VM | [Linux-based shielded VMs](../../security/guarded-fabric-shielded-vm/guarded-fabric-create-a-linux-shielded-vm-template.md). |

## Encryption support

Hyper-V Generation 2 virtual machines offer robust encryption capabilities that provide multiple layers of protection for your virtualized infrastructure. The encryption support encompasses three critical areas: TPM (Trusted Platform Module) functionality, live migration network traffic, and saved state data. These security features work together to create a comprehensive defense against unauthorized access and data breaches, ensuring that sensitive information remains protected both at rest and in transit.

The virtualized TPM (vTPM) feature represents a significant advancement in VM security architecture. By adding a vTPM to your Generation 2 virtual machine, you enable the guest operating system to use hardware-based security functions similar to those functions available on physical machines. This virtualized security chip allows the guest OS to encrypt the entire virtual machine disk using BitLocker Drive Encryption, creating an extra layer of protection against unauthorized access. The vTPM can also support other security technologies that need a TPM, making it an essential component for enterprise environments that require strict compliance with security standards and regulations.

You can migrate a virtual machine with virtual TPM enabled to any host that runs a supported version of Windows Server or Windows. If you migrate it to another host, you might not be able to start it. You must update the Key Protector for that virtual machine to authorize the new host to run the virtual machine. For more information, see [Guarded Fabric and Shielded VMs](../../security/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms.md) and [System requirements for Hyper-V on Windows Server](host-hardware-requirements.md).

## Security Policy in Hyper-V Manager

Shielded virtual machines represent the highest level of security available for Hyper-V Generation 2 VMs, providing comprehensive protection against both external threats and privileged access attacks. When you enable shielding on a virtual machine, you create a hardened environment that encrypts the VM's state and migration traffic while restricting administrative access to critical VM functions. This protection extends beyond traditional security measures by preventing even datacenter administrators and host-level malware from accessing the VM's memory, saved state, or network traffic during live migration operations.

The shielding feature automatically enforces several security requirements, including Secure Boot, TPM enablement, and encryption of saved state and migration traffic. Additionally, shielded VMs disable certain management capabilities such as console connections, PowerShell Direct, and specific integration components that attackers could potentially exploit. This approach creates a defense-in-depth security model where the virtual machine becomes effectively opaque to the host system, ensuring that sensitive workloads remain protected even in compromised hosting environments. Organizations can deploy shielded VMs with Host Guardian Service for enterprise-scale implementations or run them locally for enhanced security in smaller deployments.

You can run the shielded virtual machine locally without setting up a Host Guardian Service. If you migrate it to another host, you might not be able to start it. You must update the Key Protector for that virtual machine to authorize the new host to run the virtual machine. For more information, see [Guarded Fabric and Shielded VMs](../../security/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms.md).

## Related content

For more information, see the following articles:

- [Security and Assurance in Windows Server](../../security/Security-and-Assurance.yml).
- [Should I create a generation 1 or 2 virtual machine in Hyper-V?](plan/Should-I-create-a-generation-1-or-2-virtual-machine-in-Hyper-V.md)
- [Linux and FreeBSD Virtual Machines on Hyper-V](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md)
