---
title: Active Directory Domain Services Functional Levels
description: Discover the capabilities of Active Directory Domain Services functional levels and learn how they impact domain controllers and Windows Server compatibility.
#customer intent: As an IT admin, I want to understand the functional levels of Active Directory Domain Services so that I can determine the capabilities available in my environment.
ms.topic: concept-article
ms.author: roharwoo
author: robinharwood
ms.date: 10/30/2025
---

# Active Directory Domain Services functional levels

Functional levels determine the available Active Directory Domain Services (AD DS) domain or forest capabilities. They also determine which Windows Server operating systems you can run on domain controllers in the domain or forest. However, functional levels don't affect which operating systems you can run on workstations and member servers joined to the domain or forest. This article describes which functioning levels are compatible with which versions of Windows Server.

When you deploy AD DS, set the domain and forest functional levels to the highest value that your environment can support in order to use as many AD DS features as possible. When you deploy a new forest, you need to set both the forest and domain functional levels. You can set a domain functional level higher than the forest functional level. You can't set a domain functional level lower than the forest functional level.

## Windows Server functional level interoperability

The following interoperability matrix summarizes which Windows Server versions you can run as domain controllers for each currently supported AD DS forest and domain functional level.

| Windows Server version (DC) | Windows Server 2025 functional level | Windows Server 2016 functional level | Windows Server 2012 R2 functional level |
|-----------------------------|--------------------------------------|--------------------------------------|-----------------------------------------|
| Windows Server 2025         | ✅ Supported                         | ✅ Supported                         | ❌ Not supported                        |
| Windows Server 2022         | ❌ Not supported                     | ✅ Supported                         | ✅ Supported                            |
| Windows Server 2019         | ❌ Not supported                     | ✅ Supported                         | ✅ Supported                            |
| Windows Server 2016         | ❌ Not supported                     | ✅ Supported                         | ✅ Supported                            |
| Windows Server 2012 R2      | ❌ Not supported                     | ❌ Not supported                     | ✅ Supported                            |

✅ Supported means you can run a domain controller with that Windows Server release at the specified forest and domain functional level; ❌ Not supported means you cannot.

> [!NOTE]
> Windows Server 2019 and Windows Server 2022 use Windows Server 2016 as the most recent functional level. For earlier functional levels (for example Windows Server 2008 R2), see [Understanding Active Directory Domain Services (AD DS) Functional Levels](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754918(v=ws.10)).

### Windows Server 2025 functional levels

You can use the following operating systems as domain controllers (DCs) with the Windows Server 2025 forest and domain functional level.

- Windows Server 2025

#### Windows Server 2025 forest and domain functional level features

The Windows Server 2025 domain functional level includes all features available in earlier domain functional levels, but also has the following new features:

- Database 32k pages optional feature. To learn more about using the 32k database page size, see [Database 32k pages for Active Directory](/windows-server/identity/ad-ds/32k-pages-optional-feature).

To learn more about new features, see [What's new in Windows Server 2025](../../get-started/whats-new-windows-server-2025.md).

> [!NOTE]
> Windows Server 2019 and Windows Server 2022 use Windows Server 2016 as the most recent functional levels.

### Windows Server 2016 functional levels

You can use the following operating systems as domain controllers (DCs) with the Windows Server 2016 forest and domain functional level.

- Windows Server 2025
- Windows Server 2022
- Windows Server 2019
- Windows Server 2016

> [!NOTE]
> Domains must use DFSR as the engine to replicate SYSVOL. To learn more about migrating to DFSR, see [Streamlined Migration of FRS to DFSR SYSVOL](https://techcommunity.microsoft.com/blog/filecab/streamlined-migration-of-frs-to-dfsr-sysvol/425405). Windows Server 2016 is the last Windows Server release that supports the File Replication Service (FRS). See [Windows Server version 1709 no longer supports FRS](/troubleshoot/windows-server/networking/windows-server-version-1709-no-longer-supports-frs) for information on how to work around this issue.

#### Windows Server 2016 forest and domain functional level features

All default Active Directory features in earlier forest functional levels are available, plus the following features:

- [Privileged access management (PAM) using Microsoft Identity Manager (MIM)](../whats-new-active-directory-domain-services.md#privileged-access-management)

All default Active Directory features in earlier domain functional levels are available, plus the following features:

- DCs can support automatic rolling of the New Technology LAN Manager (NTLM) and other password-based secrets on a user account configured to require public key infrastructure (PKI) authentication. This configuration is also known as *Smart card required for interactive logon*.
- DCs can support allowing network NTLM when a user is restricted to specific domain-joined devices.
- Kerberos clients successfully authenticating with the PKInit Freshness Extension get the fresh public key identity security identifier (SID).

    For more information, see [What's New in Kerberos Authentication](../../get-started/whats-new-in-windows-server-2016.md#kerberos-authentication).

### Windows Server 2012 R2 functional levels

You can use the following operating systems as domain controllers (DCs) with the Windows Server 2012 R2 forest and domain functional level.

- Windows Server 2022
- Windows Server 2019
- Windows Server 2016
- Windows Server 2012 R2

#### Windows Server 2012 R2 forest and domain functional level features

All default Active Directory features, all features from the Windows Server 2012 domain functional level, plus the following features:

- DC-side protections for Protected Users. When Protected Users authenticate to a Windows Server 2012 R2 domain, they're no longer able to:

  - Authenticate with NTLM authentication.

  - Use DES or RC4 cipher suites in Kerberos preauthentication.

  - Be delegated with unconstrained or constrained delegation.

  - Renew user tickets (TGTs) beyond the initial four hour lifetime.

- Authentication policies

  - New forest-based authentication policies can be applied to accounts. The policies can control which hosts an account can sign on from, and apply access control conditions for authentication to services running as an account.

- Authentication policy silos

  - A new forest-based Active Directory object to be used to classify accounts for authentication policies or for authentication isolation. The new object can create a relationship between user, managed service, and computer accounts.

### Functional and domain levels in previous versions of Windows Server

If you want to identify functional levels for a previous version of Windows Server, such as Windows Server 2008 R2, see [Understanding Active Directory Domain Services (AD DS) Functional Levels](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754918(v=ws.10)).

## Related content

- Use the PowerShell command [Set-ADForestMode](/powershell/module/activedirectory/set-adforestmode) to raise the forest functional level.

- Use the PowerShell command [Set-ADDomainMode](/powershell/module/activedirectory/set-addomainmode) to raise the domain functional level.

- To learn more about raising the domain and forest functional levels, see [How to raise Active Directory domain and forest functional levels](/troubleshoot/windows-server/active-directory/raise-active-directory-domain-forest-functional-levels).
