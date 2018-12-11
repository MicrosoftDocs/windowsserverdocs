---
title: Generation 2 virtual machine security settings for Hyper-V
description: "Describes the security settings available in Hyper-V Manager for generation 2 virtual machines"
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 06ab4f5f-6b8e-4058-8108-76785aa93d4c
author: larsiwer
ms.author: kathydav
ms.date: 10/04/2016
---
# Generation 2 virtual machine security settings for Hyper-V

>Applies To: Windows Server 2016, Microsoft Hyper-V Server 2016, Windows Server 2019, Microsoft Hyper-V Server 2019

Use the virtual machine security settings in Hyper-V Manager to help protect the data and state of a virtual machine. You can protect virtual machines from inspection, theft, and tampering from both malware that may run on the host, and datacenter administrators. The level of security you get depends on the host hardware you run, the virtual machine generation, and whether you set up the service, called the Host Guardian Service, that authorizes hosts to start shielded virtual machines.  

The Host Guardian Service is a new role in Windows Server 2016. It identifies legitimate Hyper-V hosts and allows them to run a given virtual machine. You'd most commonly set up the Host Guardian Service for a datacenter. But you can create a shielded virtual machine to run it locally without setting up a Host Guardian Service. You can later distribute the shielded virtual machine to a Host Guardian Fabric.  

If you haven't set up the Host Guardian Service or are running it in local mode on the Hyper-V host and the host has the virtual machine owner's guardian key, you can change the settings described in this topic.   An owner of a guardian key is an organization that creates and shares a private or public key to own all virtual machines created with that key.  

To learn how you can make your virtual machines more secure with the Host Guardian Service, see the following resources.  

- [Harden the Fabric: Protecting Tenant Secrets in Hyper-V (Ignite video)](https://go.microsoft.com/fwlink/?LinkId=746379)
- [Guarded Fabric and Shielded VMs](https://go.microsoft.com/fwlink/?LinkId=746381)

## Secure Boot setting in Hyper-V Manager  

Secure Boot is a feature available with generation 2 virtual machines that helps prevent unauthorized firmware, operating systems, or Unified Extensible Firmware Interface (UEFI) drivers (also known as option ROMs) from running at boot time. Secure Boot is enabled by default. You can use secure boot with generation 2 virtual machines that run Windows or Linux distribution operating systems.  

The templates described in the following table refer to the certificates that you need to verify the integrity of the boot process.  

|Template name|Description|  
|-----------------|---------------|  
|Microsoft Windows|Select to secure boot the virtual machine for a Windows operating system.|  
|Microsoft UEFI Certificate Authority|Select to  secure boot the virtual machine for  a Linux distribution operating system.|  
|Open Source Shielded VM|This template is leveraged to secure boot for [Linux-based shielded VMs](https://docs.microsoft.com/windows-server/security/guarded-fabric-shielded-vm/guarded-fabric-create-a-linux-shielded-vm-template).|

For more information, see the following topics.  

- [Windows 10 Security Overview](https://docs.microsoft.com/windows/security/threat-protection/overview-of-threat-mitigations-in-windows-10)  
- [Should I create a generation 1 or 2 virtual machine in Hyper-V?](../plan/Should-I-create-a-generation-1-or-2-virtual-machine-in-Hyper-V.md)  
- [Linux and FreeBSD Virtual Machines on Hyper-V](../Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md)  

## Encryption support settings in Hyper-V Manager

You can help protect the data and state of the virtual machine by selecting the following encryption support options.  

- **Enable Trusted Platform Module** - This setting makes a virtualized Trusted Platform Module (TPM) chip available to your virtual machine. This allows the guest to encrypt the virtual machine disk by using BitLocker.
  - If your Hyper-V host is running Windows 10 1511, you have to enable Isolated User Mode. 
- **Encrypt State and VM migration traffic** - Encrypts the virtual machine saved state and live migration traffic.

### Enable Isolated User Mode

If you select **Enable Trusted Platform Module** on Hyper-V hosts that run versions of Windows earlier than Windows 10 Anniversary Update, you must enable Isolated User Mode. You don't need to do this for Hyper-V hosts that run Windows Server 2016 or Windows 10 Anniversary Update or later.

Isolated User Mode is the runtime environment that hosts security applications inside Virtual Secure Mode on the Hyper-V host. Virtual Secure Mode is used to secure and protect the state of the virtual TPM chip.  

To enable Isolated User Mode on the Hyper-V host that run earlier versions of Windows 10,  

1.  Open Windows PowerShell as an administrator.  

2.  Run the following commands:  

    ```  
    Enable-WindowsOptionalFeature -Feature IsolatedUserMode -Online  
    New-Item -Path HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard -Force  
    New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard -Name EnableVirtualizationBasedSecurity -Value 1 -PropertyType DWord -Force  

    ```  

You can migrate a virtual machine with virtual TPM enabled to any host that runs Windows Server 2016, Windows 10 build 10586 or higher versions. But if you migrate it to another host, you may not be able to start it. You must update the Key Protector for that virtual machine to authorize the new host to run the virtual machine. For more information, see [Guarded Fabric and Shielded VMs](https://go.microsoft.com/fwlink/?LinkId=746381) and [System requirements for Hyper-V on Windows Server](../System-requirements-for-Hyper-V-on-Windows.md).  

## Security Policy in Hyper-V Manager  
For more virtual machine security, use the **Enable Shielding** option to disable management features like console connection, PowerShell Direct, and some integration components. If you select this option, **Secure Boot**, **Enable Trusted Platform Module**, and **Encrypt State and VM migration traffic** options are selected and enforced.   

You can run the shielded virtual machine locally without setting up a Host Guardian Service. But if you migrate it to another host, you may not be able to start it. You must update the Key Protector for that virtual machine to authorize the new host to run the virtual machine. For more information, see [Guarded Fabric and Shielded VMs](https://go.microsoft.com/fwlink/?LinkId=746381).  

For more information about security in Windows Server, see [Security and Assurance](../../../security/Security-and-Assurance.md).  
