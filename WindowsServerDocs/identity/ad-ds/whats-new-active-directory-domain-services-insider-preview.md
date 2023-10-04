---
title: What's new in Active Directory Domain Services Insider Preview
description: Find out what is new in the Windows Server Insider Preview for Active Directory Domain Services (AD DS) and Active Directory Lightweight Domain Services (AD LDS).
ms.topic: article
author: lindakup
ms.author: lindakup
ms.date: 10/03/2023
---
# What's new in Active Directory Domain Services Insider Preview

> [!IMPORTANT]
> Windows Server Insider builds are in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

This article describes some of the new features in the Windows Server Insider Preview for
Active Directory Domain Services (AD DS) and Active Directory Lightweight Domain Services (AD LDS).

To get started with Windows Server Insider Preview, visit
[Getting started with the Windows Insider Program for Windows Server](https://insider.windows.com/for-business-getting-started-server/).
Details regarding each preview is shared in release announcements posted to the
[Windows Server Insiders](https://techcommunity.microsoft.com/t5/windows-server-insiders/bd-p/WindowsServerInsiders)
space on Microsoft Tech Community.

## Build 25951

The following new features offer improvements and new capabilities in Active Directory Domain Services (AD DS) and Active Directory Lightweight Domain Services (AD LDS).

- Active Directory functional levels
- Scaling and performance improvements
- Supportability enhancements
- Security enhancements

### Active Directory functional levels

#### New Forest and Domain Functional Levels

Added support for a new domain and forest functional level. The new functional levels are also applicable to AD LDS.

:::image type="content" source="../media/whats-new-active-directory-domain-services-insider-preview/dcpromo.png" alt-text="Screenshot showing the Active Directory Domain Services Configuration Wizard domain and forest functional level.":::

The new functional level is used for general supportability, and is required for the new 32K database page feature as described in this document.

For unattended installs, the new functional level maps to the value of `DomainLevel 10` and `ForestLevel 10`. Windows Server 2016 functional level maps to `DomainLevel 7` and `ForestLevel 7`. Microsoft has no plans to retrofit functional levels for Windows Server 2019 and Windows Server 2022. For more information about performing an unattended promotion and demotion of domain controllers, see [DCPROMO answer file syntax for unattended promotion and demotion of domain controllers](/troubleshoot/windows-server/identity/syntax-build-answer-files-unattended-installation-ad-ds).

[DsGetDcName api](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamew) also supports a new flag (`DS_DIRECTORY_SERVICE_13_REQUIRED`) to enable location of domain controllers running Windows Server Insider Preview.

You can learn more about functional levels in the following articles.

- [Understanding Active Directory Domain Services (AD DS) Functional Levels](active-directory-functional-levels.md)

- [Raise the Domain Functional Level](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753104(v=ws.11))

- [Raise the Forest Functional Level](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc730985(v=ws.11))

#### Minimum Active Directory and Active Directory LDS functional levels

New AD forests or AD LDS configuration sets are required to have a functional level of Windows Server 2016 or greater.

Promotion of an AD or AD LDS replica requires that the existing domain or config set is already running with a functional level of Windows Server 2016 or greater.

Microsoft recommends that all customers begin planning now to upgrade their AD and AD LDS servers to Windows Server 2022 in preparation of the next release. To learn more about the windows Server lifecycle, see [Modern Lifecycle Policy](/lifecycle/).

### Active Directory schema updates

There are two new LDF files that extend the active directory schema, `sch89.ldf` and `sch90.ldf`.

The AD LDS equivalent schema updates are in `MS-ADAM-Upgrade3.ldf`.

For more information about previous schema updates, see [Schema updates in Windows Server](deploy/Schema-Updates.md)

### Scaling and performance improvements

The following scaling and performance improvements are available in this release of the Windows Server Insider Preview.

#### 32k database page size optional feature

Active Directory uses an [ESE database engine](/windows/win32/extensible-storage-engine/extensible-storage-engine), also known as JET Blue. Since its initial introduction in Windows 2000,  AD DS (and AD LDS) has always used an 8k database page size. The 8k architectural design decision resulted in limitations throughout Active Directory, some of which are documented in [Active Directory Maximum Limits Scalability Capacity](/previous-versions/windows/it-pro/windows-server-2003/cc756101(v=ws.10)). For example, a single record (AD object) couldn't exceed 8k bytes in size (more or less, depending on various metadata). Moving to a 32k database page format offers a huge improvement in many areas affected by such legacy restrictions. Total allowable object size of ~32k is one obvious example. For another, multi-valued attributes are now able to hold up to ~3200 values, an increase in the number of values by a factor of 2.6.

A new domain controller is installed with a 32k page database and uses 64-bit Long Value IDs (LIDs) and runs in an "8k page mode" for compatibility with previous versions. An upgraded Domain Controller continues to use its current database format and 8k pages. Moving to 32k database pages is done on a forest-wide basis and requires that all Domain Controllers in the forest have a 32k page capable database.

To enable the 32k database pages, the forest functional level must be raised to the new level
described in [New Forest and Domain Functional Levels](#new-forest-and-domain-functional-levels), and
the **Database 32k Pages Feature** optional feature must be enabled.

The 32k database page size is also an optional feature for AD LDS.

#### NUMA support

AD DS now takes advantage of NUMA capable hardware by utilizing CPUs in all processor groups.  Previously, AD would only use CPUs in group 0.  Active Directory can expand to beyond 64 cores.

> [!TIP]
> NUMA support for Active Directory is also available on Window Server 2022 beginning with 2022-08 Cumulative Update for Microsoft server operating system version 21H2 for x64-based Systems ([KB 5016693](https://support.microsoft.com/help/5016693)).

#### Replication priority order

Active Directory now allows administrators to increase the system calculated replication priority with a particular replication partner for a particular naming context.  This feature allows more flexibility in configuring the replication order to address specific scenarios.

### Supportability enhancements

This release of the Windows Server Insider Preview has the following supportability enhancements.

#### LSA Lookups performance counters

Performance counters have been added to monitor and troubleshoot performance of Name and SID Lookups through the LsaLookupNames and LsaLookupSids and equivalent APIs. These performance counters are available on Client and Server SKU.

:::image type="content" source="../media/whats-new-active-directory-domain-services-insider-preview/lsa-lookups.png" alt-text="Screenshot showing the new LSA Lookups performance counters.":::

#### DC Locator performance counters

Performance counters have been added to monitor and troubleshoot performance of DC Locator. There are Client and Server specific counters available.

:::image type="content" source="../media/whats-new-active-directory-domain-services-insider-preview/dc-locator.png" alt-text="Screenshot showing the new DC Locators performance counters.":::

These performance counters are also available in Windows Server 2022 after installing Windows Update [KB 5029250](https://support.microsoft.com/help/5029250) and later.

#### LDAP Client performance counters

Performance counters have been added to monitor and troubleshoot LDAP client request performance.

:::image type="content" source="../media/whats-new-active-directory-domain-services-insider-preview/ldap-client.png" alt-text="Screenshot showing the new LDAP Client performance counters.":::

These performance counters are also available in Windows Server 2022 after installing Windows Update [KB 5029250](https://support.microsoft.com/help/5029250) and later.

#### Improvements in DC-location algorithm

Microsoft previously [announced the deprecation of both WINS and mailslots](https://techcommunity.microsoft.com/t5/storage-at-microsoft/the-beginning-of-the-end-of-remote-mailslots/ba-p/3762048). These legacy technologies are no longer secure in today's environments.

Windows doesn't use mailslots during DC discovery operations. The DC discovery algorithm has been improved with new functionality to improve the mapping of short NetBIOS-style domain names to DNS-style domain names, to help ease the transition away from mailslots. See [Active Directory DC locator changes](manage/dc-locator-changes.md).

### Security  enhancements

#### Improved security for confidential attributes

Domain controllers and AD LDS instances only allow LDAP add, search, modify operations involving confidential attributes when the connection is encrypted.

#### Channel binding audit support

LDAP Channel Binding audit events 3074 and 3075 can now be enabled for LDAP channel binding. When the channel binding policy was modified to a more secure setting, an administrator can identify devices in the environment that don't support or would fail channel binding validations.

These audit events are also available in Windows Server 2022 and later [KB4520412](https://support.microsoft.com/help/4520412)

#### LDAP prefers encryption by default

All LDAP client communication after a Simple Authentication and Security Layer (SASL) bind prefers LDAP sealing by default. To learn more about SASL, see [SASL Authentication](/openspecs/windows_protocols/ms-adts/989e0748-0953-455d-9d37-d08dfbf3998b).

#### LDAP support for TLS 1.3

LDAP uses the latest SCHANNEL implementation and supports TLS 1.3 for LDAP over TLS connections. Using TLS 1.3 eliminates obsolete cryptographic algorithms, enhances security over older versions, and aims to encrypt as much of the handshake as possible. Learn more about [supported TLS versions](/windows/win32/secauthn/protocols-in-tls-ssl--schannel-ssp-) and about [supported cipher suites](/windows/win32/secauthn/tls-cipher-suites-in-windows-server-2022).

#### Changes to default behavior of legacy SAM RPC password change methods

Secure protocols such as Kerberos are the preferred way to change domain user passwords. On Domain Controllers, the latest SAM RPC password change method [SamrUnicodeChangePasswordUser4](/openspecs/windows_protocols/ms-samr/bbc1c5e5-9b81-4038-b2b9-c87d3569ed38) using AES is accepted by default when called remotely.

The following legacy SAM RPC methods are blocked by default when called remotely:

- [SamrChangePasswordUser](/openspecs/windows_protocols/ms-samr/9699d8ca-e1a4-433c-a8c3-d7bebeb01476)
- [SamrOemChangePasswordUser2](/openspecs/windows_protocols/ms-samr/8d0bf63e-fa5f-4c75-be22-558c52075842)
- [SamrUnicodeChangePasswordUser2](/openspecs/windows_protocols/ms-samr/acb3204a-da8b-478e-9139-1ea589edb880)

For domain users that are members of the [Protected users group](../../security/credentials-protection-and-management/protected-users-security-group.md) and for local accounts on domain member computers, all remote password changes through the legacy SAM RPC interface are blocked by default including `SamrUnicodeChangePasswordUser4`.

This behavior can be controlled using the following Group Policy setting:

**Windows Settings > Administrative Templates > System > Security Accounts Manager > Configure SAM change password RPC methods policy**

#### Removal of the policy Network security: Don't store LAN Manager hash value on next password change

The Security Group Policy setting **Network security: Don't store LAN Manager hash value on next password change** is no longer present and applicable to new versions of Windows.

#### Kerberos support for AES SHA256/384

The Kerberos protocol implementation has been updated to support stronger encryption and signing mechanisms with support for [RFC 8009](https://datatracker.ietf.org/doc/rfc8009/) by adding SHA-256 and SHA-384.

RC4 has been deprecated and moved to the do-not-use cipher list.

#### Kerberos PKINIT support for cryptographic agility

The Kerberos Public Key Cryptography for Initial Authentication in Kerberos (PKINIT) protocol implementation has been updated to allow for cryptographic agility by supporting more algorithms and removing hardcoded algorithms.
