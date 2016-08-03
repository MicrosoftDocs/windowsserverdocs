---
title: Plan for Hyper-V security in Windows Server 2016
description: " "
ms.prod: windows-server-threshold
ms.service: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
author: cwatsonMSFT
---

# Plan for Hyper-V security in Windows Server 2016

>Applies To: Windows Server 2016 Technical Preview, Microsoft Hyper-V Server 2016

**This is preliminary content and subject to change.**  

Secure the Hyper-V host operating system, the virtual machines, configuration files, and virtual machine data. Use the following list of recommended best practices as a checklist to help you secure your Hyper-V environment.

## Secure the Hyper-V host
- **Keep the host OS secure.**
    - Minimize the attack surface by using the minimum Windows Server installation option that you need for the management operating system. For more information, see [Installation Options for Windows Server 2016 Technical Preview](../../../get-started/Installation-Options-for-Windows-Server-2016-Technical-Preview.md) and [Getting started with Nano Server](../../nano-server/getting-started-with-nano-server.md). In production environments, we don't recommend that you run Hyper-V on Windows 10.
    - Keep the Hyper-V host operating system, firmware, and device drivers up to date with the latest security updates. Check your vendor's recommendations to update firmware and drivers.
    - Don't use the Hyper-V host as a workstation or install any unnecessary software.
    - Remotely manage the Hyper-V host. If you must manage the Hyper-V host locally, use Credential Guard. For more information, see [Protect derived domain credentials with Credential Guard](https://technet.microsoft.com/itpro/windows/keep-secure/credential-guard).
- **Use a secure network.**
    - Use a separate network with a dedicated network adapter for the physical Hyper-V computer.
    - Use a private or secure network to access VM configurations and virtual hard disk files.
    - Use a private/dedicated network for your live migration traffic. Consider enabling IPSec on this network to use encryption and secure your VM's data going over the network during migration. For more information, see [Set up hosts for live migration without Failover Clustering](../deploy/set-up-hosts-for-live-migration-without-failover-clustering.md).
- **Secure storage migration traffic.** Use SMB 3.0 for end-to-end encryption of SMB data and data protection tampering or eavesdropping on untrusted networks. Use a private network to access the SMB share contents to prevent man-in-the-middle attacks. For more information, see [SMB Security Enhancements](https://technet.microsoft.com/library/dn551363.aspx). 
- **Use hardware that supports shielded virtual machines.** For more information, see [System requirements for Hyper-V on Windows Server 2016 Technical Preview](../system-requirements-for-hyper-v-on-windows.md).
- **Secure devices.** Secure the storage devices where you keep virtual machine resource files.
- **Secure the hard drive.** Use BitLocker Drive Encryption to protect resources.
- **Harden the Hyper-V host operating system.** Use the baseline security setting recommendations described in the [Windows Server Security Baseline](https://technet.microsoft.com/library/jj898542.aspx). 
- **Grant appropriate permissions.**
    - Add users that need to manage the Hyper-V host to the Hyper-V administrators group.
    - Don't grant virtual machine administrators permissions on the Hyper-V host operating system.
- **Don't install or use anti-malware in the host operating system.** If you must run anti-malware for regulatory compliance or other reasons, configure any real-time scanning components to exclude the directories where virtual machine files are stored, and to exclude the program files vmms.exe and vmwp.exe in C:\Windows\System32. 
- **Don't mount unknown VHDs.** This can expose the host to file system level attacks.
- **Don't enable nesting in your production environment unless it's required.** If you enable nesting, don't run unsupported hypervisors on a virtual machine.  
- **Enable code integrity policies.**

For more secure environments:
-  **Create generation 2 virtual machines with shielding enabled and deploy to a Guarded Fabric.** For more information, see [Generation 2 security settings](../learn-more/Generation-2-virtual-machine-security-settings-for-Hyper-V.md) and [Guarded fabric](../../../security/Guarded-Fabric-and-Shielded-VMs.md).

## Secure virtual machines
- **Create generation 2 virtual machines for supported guest operating systems.** For more information, see [Generation 2 security settings](../learn-more/Generation-2-virtual-machine-security-settings-for-Hyper-V.md).
- **Enable Secure Boot.** For more information, see [Generation 2 security settings](../learn-more/Generation-2-virtual-machine-security-settings-for-Hyper-V.md).
- **Keep the guest OS secure.**
    - Install the latest security updates before you turn on a virtual machine in a production environment.
    - Install integration services for the supported guest operating systems that need it and keep it up to date. Integrated service updates for guests that run supported Windows versions are available through Windows Update.
    - Harden the operating system that runs in each virtual machine based on the server role it performs. Use the baseline security setting recommendations that are described in the Windows Server 2012 Security Baseline.
- **Use a secure network.** Make sure virtual network adapters connect to the correct virtual switch and have the appropriate security setting and limits applied.
- **Store virtual hard disks and snapshot files in a secure location.**
- **Secure devices.**	Configure only required devices for a virtual machine. Don't enable discrete device assignment in your production environment unless you need it for a specific scenario. If you do enable it, make sure to only expose devices from trusted vendors. 
- **Configure antivirus, firewall, and intrusion detection software within virtual machines as appropriate based on server role.**
- **Enable virtualization based security for guests that run Windows 10 or Windows Server 2016.** For more information, see [Secure Hyper-V virtual machines using virtualization-based security](secure-hyper-v-virtual-machines-using-virtualization-based-security.md) and the [Device Guard Deployment Guide](https://technet.microsoft.com/itpro/windows/keep-secure/device-guard-deployment-guide).
