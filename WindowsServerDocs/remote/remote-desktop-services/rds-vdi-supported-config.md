---
title: Supported Windows 10 security configurations for Remote Desktop Services VDI
description: Provides information about supported configurations for Windows 10 VDI with RDS in Windows Server 2016.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 10/27/2016  
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8f164f5d-a498-4f91-a12f-3e01d554f810
author: lizap
manager: dongill
---
# Supported Windows 10 security configurations for Remote Desktop Services VDI

> Applies To: Windows Server 2016

Windows 10 and Windows Server 2016 have new layers of protection built into the operating system to further safeguard against security breaches, help block malicious attacks and enhance the security of virtual machines, applications, and data.

> [!NOTE]
> Make sure to review the [Remote Desktop Services supported configuration information](rds-supported-config.md).

The following table outlines which of these new features are supported in a VDI deployment using RDS.

|  VDI collection  type               |  Managed  pooled |  Managed  personal |  Unmanaged  pooled                                     |  Unmanaged  personal                                    |
|-------------------------------------|------------------|--------------------|--------------------------------------------------------|--------------------------------------------------------|
| [Credential Guard](https://technet.microsoft.com/itpro/windows/keep-secure/credential-guard)                    | Yes              | Yes                | Yes                                                    | Yes                                                    |
| [Device Guard](https://technet.microsoft.com/itpro/windows/keep-secure/device-guard-deployment-guide)                        | Yes              | Yes                | Yes                                                    | Yes                                                    |
| [Remote Credential Guard](https://technet.microsoft.com/itpro/windows/keep-secure/remote-credential-guard)             | No               | No                 | No                                                     | No                                                     |
| [Shielded & Encryption Supported VMs](../../security/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms.md) | No               | No                 | Encryption supported VMs with additional configuration | Encryption supported VMs with additional configuration |

## Remote Credential Guard:

Remote Credential Guard is only supported for direct connections to the target machines and not for the ones via Remote Desktop Connection Broker and Remote Desktop Gateway.
> [!NOTE]
> If you have a Connection Broker in a single-instance environment, and the DNS name matches the computer name, you may be able to use Remote Credential Guard, although this is not supported.

## Shielded VMs and Encryption Supported VMs: 

- Shielded VMs are not supported in Remote Desktop Services VDI 

For leveraging Encryption Supported VMs:
- Use an unmanaged collection and a provisioning technology outside of the Remote Desktop Services collection creation process to provision the virtual machines. 
- User Profile Disks are not supported as they rely on differential disks 

