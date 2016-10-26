---
title: Supported configurations for Remote Desktop Services
description: Provides information about supported configurations for RDS in Windows Server 2016.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 10/20/2016  
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c925c7eb-6880-411f-8e59-bd0f57cc5fc3
author: lizap
manager: dongill
---
# Supported configurations for Remote Desktop Services in Windows Server 2016

> Applies To: Windows Server 2016

When it comes to supported configurations for Remote Desktop Services environments, the largest concern tends to be version interoperability. Most environments include multiple versions of Windows Server - for example, you may have an existing Windows Server 2012 R2 RDS deployment but want to upgrade to Windows Server 2016 to take advantage of the new features (like support for vGPU or Storage Spaces Direct). The question then becomes, which RDS components can work with different versions and which need to be the same?

So with that in mind, here are basic guidelines for supported configurations of Remote Desktop Services in Windows Server 2016.

> [!NOTE]
> Make sure to review the [system requirements for Windows Server 2016](../../get-started/system-requirements.md).

## Best practices
- Use Windows Server 2016 for your Remote Desktop infrastructure - the Web Access, Gateway, Connection Broker, and license server. Windows Server 2016 is backward compatible for these components - so a 2012 R2 RD Session Host can connect to a 2016 RD Connection Broker, but the reverse is not true.

- For RD Session Hosts - all Session Hosts in a collection need to be at the same level, but you can have multiple collections. You can have a collection with Windows Server 2012 R2 Session Hosts and one with Windows Server 2016 Session Hosts.

- If you upgrade your RD Session Host to Windows Server 2016, also upgrade the license server. Remember that a 2016 license server can process CALs from all previous versions of Windows Server, down to Windows Server 2003.

- Follow the upgrade order recommended in [Upgrading your Remote Desktop Services environment](Upgrade-to-RDS-2016.md#flow-for-deployment-upgrades). 

- For the RD Connection Broker - Windows Server 2016 removed the restriction for the number of Connection Brokers you can have in a deployment. (Windows Server 2012 R2 was limited to 2 Connection Brokers.)

## VDI deployment – supported guest OSs 
Windows Server 2016 RD Virtualization Host servers support the following guest OSs:

- Windows 10 Enterprise
- Windows 8.1 Enterprise 
- Windows 8 Enterprise 
- Windows 7 SP1 Enterprise 

The table below shows the supported RD Virtualization Hosts operating systems and guest operating system combinations:

| RDVH OS Version        | Guest OS Version           |
| ------------- |-------------|
| Windows Server 2016      | Windows 7 SP1, Windows 8, Windows 8.1, Windows 10 |
| Windows Server 2012 R2   | Windows 7 SP1, Windows 8, Windows 8.1, Windows 10 |
| Windows Server 2012      | Windows 7 SP1, Windows 8, Windows 8.1 |

> [!NOTE]  
> - Windows Server 2016 Remote Desktop Services does not support heterogeneous collections. All VMs in a collection must be same OS version. 
> - You can have separate homogeneous collections with different guest OS versions on the same host. 
> - VM templates must be created on a Windows Server 2016 Hyper-V host to used as guest OS on a Windows Server 2016 Hyper-V host.
  
## VDI deployment - supported security configurations
Windows 10 and Windows Server 2016 have new layers of protection built into the operating system to further safeguard against security breaches, help block malicious attacks and enhance the security of virtual machines, applications, and data.

The following table outlines which of these new features are supported in a VDI deployment using RDS.

|  VDI collection  type               |  Managed  pooled |  Managed  personal |  Unmanaged  pooled                                     |  Unmanaged  personal                                    |
|-------------------------------------|------------------|--------------------|--------------------------------------------------------|--------------------------------------------------------|
| [Credential Guard](https://technet.microsoft.com/itpro/windows/keep-secure/credential-guard)                    | Yes              | Yes                | Yes                                                    | Yes                                                    |
| [Device Guard](https://technet.microsoft.com/itpro/windows/keep-secure/device-guard-deployment-guide)                        | Yes              | Yes                | Yes                                                    | Yes                                                    |
| [Remote Credential Guard](https://technet.microsoft.com/itpro/windows/keep-secure/remote-credential-guard)             | No               | No                 | No                                                     | No                                                     |
| [Shielded & Encryption Supported VMs](../../security/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms.md) | No               | No                 | Encryption supported VMs with additional configuration | Encryption supported VMs with additional configuration |

### Remote Credential Guard:
Remote Credential Guard is only supported for direct connections to the target machines and not for the ones via Remote Desktop Connection Broker.

### Shielded VMs and Encryption Supported VMs: 

- Shielded VMs are not supported in Remote Desktop Services VDI 

For leveraging Encryption Supported VMs:
- Use an unmanaged collection and a provisioning technology outside of the Remote Desktop Services collection creation process to provision the virtual machines. 
- User Profile Disks are not supported as they rely on differential disks 

