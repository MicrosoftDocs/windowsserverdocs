---
title: Active Directory Domain Services functional levels
description: Learn more about Active Directory Domain Services functional levels in Windows Server
ms.topic: troubleshooting
ms.author: robinharwood
author: gswashington
ms.date: 06/30/2024
---
# Active Directory Domain Services functional levels

>Applies to: Windows Server 2025 (preview), Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012

Functional levels determine the available Active Directory Domain Services (AD DS) domain or forest capabilities. They also determine which Windows Server operating systems you can run on domain controllers in the domain or forest. However, functional levels don't affect which operating systems you can run on workstations and member servers joined to the domain or forest.

When you deploy AD DS, set the domain and forest functional levels to the highest value that your environment can support to use as many AD DS features as possible. When you deploy a new forest, you're prompted to set the forest functional level, and then set the domain functional level. You can set the domain functional level to a value that is higher than the forest functional level, but you can't set the domain functional level to a value that is lower than the forest functional level.

Domain controllers (DCs) need to be updated to Windows Server 2012, 2012 R2, 2016, 2019, 2022 or Windows Server 2025 (preview). As with any server, domain controllers (DCs) running on an unsupported version of Windows Server should be removed from the domain and replaced with a version of Windows Server that is supported. For more information, see [Windows Server release information](/windows-server/get-started/windows-server-release-info).

> [!NOTE]
> There have been no new forest or domain functional levels added since Windows Server 2016. Later operating system versions can and should be used for domain controllers, however they use Windows Server 2016 as the most recent functional levels.

<!-- 2025 (preview) section is new -->

## Windows Server 2025 (preview) functional levels

<!-- Need to verify the following bullet list is accurate -->

Supported domain controller operating systems:

* Windows Server 2025 (preview)
* Windows Server 2022
* Windows Server 2019

> [!NOTE]
> Domains must use DFS-R as the engine to replicate SYSVOL. See [Streamlined Migration of FRS to DFSR SYSVOL blog](https://techcommunity.microsoft.com/t5/storage-at-microsoft/streamlined-migration-of-frs-to-dfsr-sysvol/ba-p/425405) for more information. Windows Server 2016 is the last Windows Server release that includes FRS.

### Windows Server 2025 (preview) forest functional level features

* All of the features that are available in earlier forest functional levels plus the following features are available:
   * [Privileged access management (PAM) using Microsoft Identity Manager (MIM)](../whats-new-active-directory-domain-services.md#privileged-access-management)

### Windows Server 2025 (preview) domain functional level features

* All default Active Directory features in earlier domain functional levels plus the following features are available:
   * DCs can support automatic rolling of the NTLM and other password-based secrets on a user account configured to require PKI authentication. This configuration is also known as "Smart card required for interactive logon"
   * DCs can support allowing network NTLM when a user is restricted to specific domain-joined devices.
   * Kerberos clients successfully authenticating with the PKInit Freshness Extension will get the fresh public key identity SID.

    For more information, see [What's New in Kerberos Authentication](../../get-started/whats-new-in-windows-server-2016.md#kerberos-authentication) and [What's new in Credential Protection](../../security/credentials-protection-and-management/whats-new-in-credential-protection.md)

## Windows Server 2016 functional levels

Supported domain controller operating systems:

* Windows Server 2025 (preview)
* Windows Server 2022
* Windows Server 2019
* Windows Server 2016

> [!NOTE]
> Domains must use DFS-R as the engine to replicate SYSVOL. See [Streamlined Migration of FRS to DFSR SYSVOL blog](https://techcommunity.microsoft.com/t5/storage-at-microsoft/streamlined-migration-of-frs-to-dfsr-sysvol/ba-p/425405) for more information. Windows Server 2016 is the last Windows Server release that includes FRS.

### Windows Server 2016 forest functional level features

* All of the features that are available in earlier forest functional levels plus the following features are available:
   * [Privileged access management (PAM) using Microsoft Identity Manager (MIM)](../whats-new-active-directory-domain-services.md#privileged-access-management)

### Windows Server 2016 domain functional level features

* All default Active Directory features in earlier domain functional levels plus the following features are available:
   * DCs can support automatic rolling of the NTLM and other password-based secrets on a user account configured to require PKI authentication. This configuration is also known as "Smart card required for interactive logon"
   * DCs can support allowing network NTLM when a user is restricted to specific domain-joined devices.
   * Kerberos clients successfully authenticating with the PKInit Freshness Extension will get the fresh public key identity SID.

    For more information, see [What's New in Kerberos Authentication](../../get-started/whats-new-in-windows-server-2016.md#kerberos-authentication) and [What's new in Credential Protection](../../security/credentials-protection-and-management/whats-new-in-credential-protection.md)

## Windows Server 2012 R2 functional levels

Supported domain controller operating systems:

* Windows Server 2025 (preview)
* Windows Server 2022
* Windows Server 2019
* Windows Server 2016
* Windows Server 2012

## Next Steps

* [Raise the Domain Functional Level](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753104(v=ws.11))
* [How to raise Active Directory domain and forest functional levels](/raise-domain-forest-functional-levels?branch=pr-en-us-4776)