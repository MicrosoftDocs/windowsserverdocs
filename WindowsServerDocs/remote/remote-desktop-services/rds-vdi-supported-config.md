---
title: Supported Windows security configurations for Remote Desktop Services VDI
description: Provides information about supported configurations for Windows VDI with RDS in Windows Server.
ms.author: daknappe
ms.date: 7/3/2024
ms.topic: concept-article
author: dknappettmsft
---

# Supported Windows security configurations for Remote Desktop Services VDI

Windows and Windows Server have new layers of protection built into the operating system to:

- Safeguard against security breaches
- Help block malicious attacks
- Enhance the security of virtual machines, applications, and data.

> [!NOTE]
>
> - Features like Credential Guard may have performance implication on user density. Ensure to test your scenarios. Learn more about other considerations for [credential guard configuration](/windows/security/identity-protection/credential-guard/considerations-known-issues).
>
> - Make sure to review the [Remote Desktop Services supported configuration information](rds-supported-config.md).

The following table outlines which of these new features are supported in a VDI deployment using RDS.

|  VDI collection  type               |  Managed  pooled |  Managed  personal |  Unmanaged  pooled                                     |  Unmanaged  personal                                    |
|-------------------------------------|------------------|--------------------|--------------------------------------------------------|--------------------------------------------------------|
| [Credential Guard](/windows/security/identity-protection/credential-guard/credential-guard)                    | Yes              | Yes                | Yes                                                    | Yes                                                    |
| [Device Guard](/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control-deployment-guide)                        | Yes              | Yes                | Yes                                                    | Yes                                                    |
| [Remote Credential Guard](/windows/security/identity-protection/remote-credential-guard)             | No               | No                 | No                                                     | No                                                     |
| [Shielded & Encryption Supported VMs](../../security/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms.md) | No               | No                 | Encryption supported VMs with extra configuration | Encryption supported VMs with extra configuration |

## Remote Credential Guard

Remote Credential Guard is only supported for direct connections to the target machines and not for the ones via Remote Desktop Connection Broker and Remote Desktop Gateway.
> [!NOTE]
> If you have a Connection Broker in a single-instance environment, and the DNS name matches the computer name, you may be able to use Remote Credential Guard, although this isn't supported.

## Shielded VMs and Encryption Supported VMs

Shielded VMs aren't supported in Remote Desktop Services VDI.

For leveraging Encryption Supported VMs:
- Use an unmanaged collection and a provisioning technology outside of the Remote Desktop Services collection creation process to provision the virtual machines.
- User Profile Disks aren't supported as they rely on differential disks
