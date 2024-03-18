---
title: What's new in Windows Server Insiders 2025 (Preview)
description: This article describes some of the new features in Windows Server 2025 for Insiders Preview.
ms.topic: article
author: xelu86
ms.author: wscontent
ms.date: 03/18/2024
---

# What's new in Windows Server Insiders Preview

> [!IMPORTANT]
> Windows Server Insider builds are in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

This article describes some of the new features in Windows Server Insiders Preview. Windows Server Insiders Preview is built on the strong foundation of Windows Server 2022 and brings many innovations.

## What's new

The following new features are specific to Windows Server with Desktop Experience only. Having both the physical devices running the operating system and the correct drivers readily available are required.

### Active Directory Domain Services

The latest enhancements to Active Directory Domain Services (AD DS) and Active Directory Lightweight Domain Services (AD LDS) introduce a range of new functionalities and capabilities aimed at optimizing your domain management experience:

- **32k database page size optional feature** - AD uses an Extensible Storage Engine (ESE) database since its introduction in Windows 2000 that uses an 8k database page size. The 8k architectural design decision resulted in limitations throughout AD that are documented in [AD Maximum Limits Scalability](/previous-versions/windows/it-pro/windows-server-2003/cc756101(v=ws.10)). An example of this limitation is a single record AD object, which can't exceed 8k bytes in size. Moving to a 32k database page format offers a huge improvement in areas affected by legacy restrictions, including multi-valued attributes are now able to hold up to ~3,200 values, which is an increase by a factor of 2.6.

  New DCs can be installed with a 32k page database that uses 64-bit Long Value IDs (LIDs) and runs in an "8k page mode" for compatibility with previous versions. An upgraded DC continues to use its current database format and 8k pages. Moving to 32k database pages is done on a forest-wide basis and requires that all DCs in the forest have a 32k page capable database.

- **AD schema updates** - Three new Log Database Files (LDF) are introduced that extend the AD schema, `sch89.ldf`, `sch90.ldf`, and `sch91.ldf`. The AD LDS equivalent schema updates are in `MS-ADAM-Upgrade3.ldf`. For learn more about previous schema updates, see [Windows Server AD schema updates](../identity/ad-ds/deploy/Schema-Updates.md)

- **AD object repair** - AD now allows enterprise administrators to repair objects with missing core attributes **SamAccountType** and **ObjectCategory**. Enterprise administrators can reset the **LastLogonTimeStamp** attribute on an object to the current time. These operations are achieved through a new [RootDSE](/openspecs/windows_protocols/ms-adts/fc74972f-b267-4c1a-8716-0f5b48cf52b9) modify operation feature on the affected object called **fixupObjectState**.

- **Channel binding audit support** - Events 3074 and 3075 can now be enabled for Lightweight Directory Access Protocol (LDAP) channel binding. When the channel binding policy was modified to a more secure setting, an administrator can identify devices in the environment that don't support or fail channel binding validations. These audit events are also available in Windows Server 2022 and later via [KB4520412](https://support.microsoft.com/topic/2020-2023-and-2024-ldap-channel-binding-and-ldap-signing-requirements-for-windows-kb4520412-ef185fb8-00f7-167d-744c-f299a66fc00a).

- **DC-location algorithm improvements** - DC discovery algorithm provides new functionality with improvements to mapping of short NetBIOS-style domain names to DNS-style domain names. To learn more, see [Active Directory DC locator changes](../identity/ad-ds/manage/dc-locator-changes.md).

  > [!NOTE]
  > Windows doesn't use mailslots during DC discovery operations as Microsoft has announced  the [deprecation of WINS and mailslots](https://techcommunity.microsoft.com/t5/storage-at-microsoft/the-beginning-of-the-end-of-remote-mailslots-as-part-of-windows/ba-p/3762048) for these legacy technologies.

- **Forest and Domain Functional Levels** - The new functional level is used for general supportability and is required for the new 32K database page size feature. The new functional level maps to the value of `DomainLevel 10` and `ForestLevel 10` for unattended installs. Microsoft has no plans to retrofit functional levels for Windows Server 2019 and Windows Server 2022. To perform an unattended promotion and demotion of a Domain Controller (DC), see [DCPROMO answer file syntax for unattended promotion and demotion of domain controllers](/troubleshoot/windows-server/identity/syntax-build-answer-files-unattended-installation-ad-ds).

  The [DsGetDcName](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamew) Application Programming Interface (API) also supports a new flag `DS_DIRECTORY_SERVICE_13_REQUIRED` that enables location of DCs running Windows Server Insider Preview. You can learn more about functional levels in the following articles:

  - [Forest and Domain Functional Levels](../identity/ad-ds/active-directory-functional-levels.md)
  
  - [Raise the Domain Functional Level](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753104(v=ws.11))
  
  - [Raise the Forest Functional Level](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc730985(v=ws.11))

  > [!NOTE]
  > New AD forests or AD LDS configuration sets are required to have a functional level of Windows Server 2016 or greater. Promotion of an AD or AD LDS replica requires that the existing domain or config set is already running with a functional level of Windows Server 2016 or greater.
  >
  > Microsoft recommends that all customers begin planning now to upgrade their AD and AD LDS servers to Windows Server 2022 in preparation of the next release.

- **Improved algorithms for Name/Sid Lookups** - Local Security Authority (LSA) Name and Sid lookup forwarding between machine accounts no longer uses the legacy Netlogon secure channel. Kerberos authentication and DC Locator algorithm are used instead. To maintain compatibility with legacy operating systems, it's still possible to use the Netlogon secure channel as a fallback option.

- **Improved security for confidential attributes** - DCs and AD LDS instances only allow LDAP add, search, and modify operations involving confidential attributes when the connection is encrypted.

- **Improved security for default machine account passwords** - AD now uses random generated default computer account passwords. Windows 2025 DCs block setting computer account passwords to the default password of the computer account name.

  This behavior can be controlled by enabling the GPO setting _Domain controller: Refuse setting default machine account password_ located in:
  **Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options**
  
  Utilities like Active Directory Administrative Center (ADAC), Active Directory Users and Computers (ADUC), `net computer`, and `dsmod` also honors this new behavior. Both ADAC and ADUC no longer allow creating a pre-2k Windows account.

- **Kerberos AES SHA256 and SHA384** - The Kerberos protocol implementation is updated to support stronger encryption and signing mechanisms with support for [RFC 8009](https://datatracker.ietf.org/doc/rfc8009/) by adding SHA-256 and SHA-384. RC4 is deprecated and moved to the do-not-use cipher list.

- **Kerberos PKINIT support for cryptographic agility** - The Kerberos Public Key Cryptography for Initial Authentication in Kerberos (PKINIT) protocol implementation is updated to allow for cryptographic agility by supporting more algorithms and removing hardcoded algorithms.

- **LAN Manager GPO setting** - The GPO setting _Network security: Don't store LAN Manager hash value on next password change_ is no longer present nor applicable to new versions of Windows.

- **LDAP encryption by default** - All LDAP client communication after a Simple Authentication and Security Layer (SASL) bind utilizes LDAP sealing by default. To learn more about SASL, see [SASL Authentication](/openspecs/windows_protocols/ms-adts/989e0748-0953-455d-9d37-d08dfbf3998b).

- **LDAP support for TLS 1.3** - LDAP uses the latest SCHANNEL implementation and supports TLS 1.3 for LDAP over TLS connections. Using TLS 1.3 eliminates obsolete cryptographic algorithms, enhances security over older versions, and aims to encrypt as much of the handshake as possible. To learn more, see [Protocols in TLS/SSL (Schannel SSP)](/windows/win32/secauthn/protocols-in-tls-ssl--schannel-ssp-) and [TLS Cipher Suites in Windows Server 2022](/windows/win32/secauthn/tls-cipher-suites-in-windows-server-2022).

- **Legacy SAM RPC password change behavior** - Secure protocols such as Kerberos are the preferred way to change domain user passwords. On DCs, the latest SAM RPC password change method [SamrUnicodeChangePasswordUser4](/openspecs/windows_protocols/ms-samr/bbc1c5e5-9b81-4038-b2b9-c87d3569ed38) using AES is accepted by default when called remotely. The following legacy SAM RPC methods are blocked by default when called remotely:

  - [SamrChangePasswordUser](/openspecs/windows_protocols/ms-samr/9699d8ca-e1a4-433c-a8c3-d7bebeb01476)
  
  - [SamrOemChangePasswordUser2](/openspecs/windows_protocols/ms-samr/8d0bf63e-fa5f-4c75-be22-558c52075842)
  
  - [SamrUnicodeChangePasswordUser2](/openspecs/windows_protocols/ms-samr/acb3204a-da8b-478e-9139-1ea589edb880)

  For domain users that are members of the [Protected Users](/windows-server/security/credentials-protection-and-management/protected-users-security-group#BKMK_Requirements) group and for local accounts on domain member computers, all remote password changes through the legacy SAM RPC interface are blocked by default including `SamrUnicodeChangePasswordUser4`.

  This behavior can be controlled using the following Group Policy Object (GPO) setting:

  **Computer Configuration > Administrative Templates > System > Security Account Manager > Configure SAM change password RPC methods policy**

- **NUMA support** - AD DS now takes advantage of Non-uniform Memory Access (NUMA) capable hardware by utilizing CPUs in all processor groups. Previously, AD would only use CPUs in group 0. Active Directory can expand beyond 64 cores.

- **Performance counters** - Monitoring and troubleshooting the performance of the following counters are now available:

  - _DC Locator_ - Client and DC specific counters available.
  
  - _LSA Lookups_ - **Name** and **SID** lookups through the **LsaLookupNames**, **LsaLookupSids**, and equivalent APIs. These counters are available on both Client and Server SKUs.
  
  - _LDAP Client_ - Available in Windows Server 2022 and later via [KB 5029250](https://support.microsoft.com/topic/august-8-2023-kb5029250-os-build-20348-1906-2db4a1ac-8e18-443e-b4d6-ee17435cf94c) update.

- **Replication priority order** - AD now allows administrators to increase the system calculated replication priority with a particular replication partner for a particular naming context. This feature allows more flexibility in configuring the replication order to address specific scenarios.
  
### Azure Arc

By default, the Azure Arc setup Feature-on-Demand is installed, which offers a user-friendly wizard interface and a system tray icon in the taskbar to facilitate the process of adding servers to Azure Arc. Azure Arc extends the capabilities of the Azure platform, allowing for the creation of applications and services that can operate in diverse environments. These include data centers, the edge, multicloud environments, and provide increased flexibility. To learn more, see [Connect Windows Server machines to Azure through Azure Arc Setup](/azure/azure-arc/servers/onboard-windows-server).

### Bluetooth

You can now connect mice, keyboards, headsets, audio devices, and more via bluetooth in Windows Server Preview.

### Desktop shell

When you sign in for the first time, the desktop shell experience conforms to the style and appearance of Windows 11.

### Delegated Managed Service Account

This new type of account enables migration from a service account to a delegated Managed Service Account (dMSA). This account type comes with managed and fully randomized keys ensuring minimal application changes while disabling the original service account passwords. To learn more, see [Delegated Managed Service Accounts overview](../security/delegated-managed-service-accounts/delegated-managed-service-accounts-overview.md).

### Email & accounts

You can now add the following accounts in **Settings > Accounts > Email & accounts** for Windows Server Preview:

- Microsoft Entra ID
- Microsoft account
- Work or school account

It's important to keep in mind that domain join is still required for most situations.

### Feedback Hub

Submitting feedback or reporting problems encountered while using Windows Server Preview can now be done using the Windows Feedback Hub. You can include screenshots or recordings of the process that caused the issue to help us understand your situation and share suggestions to enhance your Windows experience. To learn more, see [Explore the Feedback Hub](/windows-insider/feedback-hub/feedback-hub-app).

### File Compression

Build 26040 has a new compression feature when compressing an item by performing a right-click called **Compress to**. This feature supports **ZIP**, **7z**, and **TAR** compression formats with specific compression methods for each.

### Flighting

Flighting is only available for the Canary Channel release beginning in early 2024 starting with Preview build 26010, which allows users to receive Windows Server flights similar to Windows client. To enable flighting on your device, go to **Start > Settings > Windows Update > Windows Insider Program**. From there, you can choose to opt into your desired Insiders release.

### Pinned apps

Pinning your most used apps is now available through the **Start** menu and is customizable to suit your needs. As of build 26040, the default pinned apps in Preview are currently **Edge**, **File Explorer**, and **Settings**.

### Server Message Block

Server Message Block (SMB) is one of the most widely used protocols in networking by providing a reliable way to share files and other resources between devices on your network. Windows Server Preview brings the following SMB capabilities:

- The [SMB over Quick UDP Internet Connections](../storage/file-server/smb-over-quic.md) (QUIC) server feature, which was only available in Windows Server Azure Edition, is now available in both Windows Server Standard and Windows Server Datacenter versions. SMB over QUIC adds the benefits of the QUIC, which provides low-latency, encrypted connections over the internet. For more information, see [SMB over QUIC now available in Windows Server Insider Datacenter and Standard editions](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-over-quic-now-available-in-windows-server-insider-datacenter/ba-p/3975242).

  Previously, SMB server in Windows mandated inbound connections to use the IANA-registered port TCP/445 while the SMB TCP client only allowed outbound connections to that same TCP port. Now, SMB over QUIC allows for [SMB alternative ports](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-alternative-ports-now-supported-in-windows-insider/ba-p/3974509) where QUIC-mandated UDP/443 ports are available for both server and client devices.

  Another feature that's introduced to SMB over QUIC is [client access control](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-over-quic-client-access-control-now-supported-in-windows/ba-p/3951938), which is alternative to TCP and RDMA that supplies secure connectivity to edge file servers over untrusted networks.

- Previously, when a share was created, the [SMB firewall rules](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-firewall-rule-changes-in-windows-insider/ba-p/3974496) would be automatically configured to enable the "File and Printer Sharing" group for the relevant firewall profiles. Now, the creation of an SMB share in Windows results in the automatic configuration of the new "File and Printer Sharing (Restrictive)" group, which no longer permits inbound NetBIOS ports 137-139.

- Starting with build 25997, an update is made to [enforce SMB encryption](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-client-encryption-mandate-now-supported-in-windows-insider/ba-p/3964037) for all outbound SMB client connections. With this update, administrators can set a mandate that all destination servers support SMB 3.x and encryption. If a server lacks these capabilities, the client is unable to establish a connection.

- Also in build 25997, the [SMB authentication rate limiter](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-authentication-rate-limiter-now-on-by-default-in-windows/ba-p/3634244), which limits the number of authentication attempts that can be made within a certain time period, is enabled by default.

- Starting with build 25951, the SMB client supports [NTLM blocking](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-ntlm-blocking-now-supported-in-windows-insider/ba-p/3916206) for remote outbound connections. Previously, the Windows Simple and Protected GSSAPI Negotiation Mechanism ([SPNEGO](/openspecs/windows_protocols/ms-spng/b16309d8-4a93-4fa6-9ee2-7d84b2451c84)) would negotiate Kerberos, NTLM, and other mechanisms with the destination server to determine a supported security package.

- New in build 25951 is the [SMB dialect management](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-dialect-management-now-supported-in-windows-insider/ba-p/3916368) feature where the SMB server now controls which SMB 2 and SMB 3 dialects it negotiates compared to the previous behavior matching only the highest dialect.

- Beginning with build 25931, [SMB signing](https://techcommunity.microsoft.com/t5/storage-at-microsoft/smb-signing-required-by-default-in-windows-insider/ba-p/3831704) is now required by default for all SMB outbound connections where previously it was only required when connecting to shares named **SYSVOL** and **NETLOGON** on AD domain controllers.

- The [Remote Mailslot](https://techcommunity.microsoft.com/t5/storage-at-microsoft/the-beginning-of-the-end-of-remote-mailslots-as-part-of-windows/ba-p/3762048) protocol is disabled by default starting in build 25314.

- SMB compression adds support for industry standard LZ4 compression algorithm, in addition to its existing support for XPRESS (LZ77), XPRESS Huffman (LZ77+Huffman), LZNT1, and PATTERN_V1.

### Storage Replica Enhanced Log

Enhanced Logs help the Storage Replica log implementation to eliminate the performance costs associated with file system abstractions, leading to improved block replication performance. To learn more, see [Storage Replica Enhanced Log](../storage/storage-replica/storage-replica-enhanced-log.md).

### Task Manager

Build 26040 now sports the modern Task Manager app with mica material conforming to the style of Windows 11.

### Wi-Fi

It's now easier to enable wireless capabilities as the Wireless LAN Service feature is now installed by default. The wireless startup service is set to manual and can be enabled by running `net start wlansvc` in the Command Prompt, Windows Terminal, or PowerShell.

### Winget

Winget is installed by default, which is a command line Windows Package Manager tool that provides comprehensive package manager solutions for installing applications on Windows devices. To learn more, see [Use the winget tool to install and manage applications](/windows/package-manager/winget).

### Windows Insider Program

The [Windows Insider Program](/windows-insider/get-started) provides early access to the latest Windows OS releases for a community of enthusiasts. As a member, you can be among the first to try out new ideas and concepts that Microsoft is developing. After registering as a member, you can opt to participate in different release channels by going to go to **Start > Settings > Windows Update > Windows Insider Program**.

### Windows Local Administrator Password Solution (LAPS)

The latest update to Windows LAPS includes an automatic account management feature that allows IT admins to create a managed local account with ease. With this feature, you can customize the account name, enable or disable the account, and even randomize the account name for enhanced security. Additionally, the update includes improved integration with Microsoft's existing local account management policies. To learn more about this feature, see [Windows LAPS account management modes](/windows-server/identity/laps/laps-concepts-account-management-modes).

Improvements to LAPS also include:

- **Improved readability password dictionary**
  
  LAPS introduces a new _PasswordComplexity_ setting that enables IT admins to create less complex passwords. This feature allows you to customize LAPS to use all four character categories (upper case letters, lower case letters, numbers, and special characters) like the existing complexity setting of 4. However, with the new setting of 5, the more complex characters are excluded to enhance password readability and minimize confusion. For example, the number "**1**" and the letter "**I**" are never used with the new setting.

  When _PasswordComplexity_ is configured to 5, the following changes are made to the default password dictionary character set:

  1. Don’t use these letters: '**I**', '**O**', '**Q**', '**l**', '**o**'
  1. Don’t use these numbers: '**0**', '**1**'
  1. Don’t use these "special" characters: '**,**', '**.**', '**&**', '**{**', '**}**', '**[**', '**]**', '**(**', '**)**', '**;**'
  1. Start using these "special" characters: '**:**', '**=**', '**?**', '**\***'

  The Active Directory Users and Computers snap-in (via Microsoft Management Console) now features an improved Windows LAPS tab. The Windows LAPS password is now displayed in a new font that enhances its readability when shown in plain text.

- **New automatic account management feature**

  IT admins can set up Windows LAPS to automatically create a managed local account. In addition, it's possible to customize the account name, enable or disable the account, and optionally randomize the account name for better security. Moreover, improvement in the integration with Microsoft's current local account management policies.

- **New image rollback detection feature**
  
  Windows LAPS now detects when an image rollback occurs. If a rollback does happen, the password stored in AD may no longer match the password stored locally on the device. Rollbacks can result in a "torn state" where the IT admin is unable to sign into the device using the persisted Windows LAPS password.

  To address this issue, a new feature was added that includes an AD attribute called **msLAPS-CurrentPasswordVersion**. This attribute contains a random GUID written by Windows LAPS every time a new password is persisted in AD and saved locally. During every processing cycle, the GUID stored in **msLAPS-CurrentPasswordVersion** is queried and compared to the locally persisted copy. If they're different, the password is immediately rotated.

  To enable this feature, it's necessary to run the latest version of the `Update-LapsADSchema` cmdlet. Once complete, Windows LAPS recognizes the new attribute and begins using it. If you don't run the updated version of the `Update-LapsADSchema` cmdlet, Windows LAPS logs a 10108 warning event in the event log, but continues to function normally in all other respects.

  No policy settings are used to enable or configure this feature. The feature is always enabled once the new schema attribute is added.

- **New passphrase feature**

  IT admins can now utilize a new feature in Windows LAPS that enables the generation of less complex passphrases. An example would be a passphrase such as "EatYummyGummyBears", which is easier to read, remember, and type, compared to a traditional password like "V3r_b4tim#963?".

  This new feature also allows the _PasswordComplexity_ policy setting to be configured to select one of three different passphrase word lists, all of which are included in Windows without requiring a separate download. A new policy setting called _PassphraseLength_ controls the number of words used in the passphrase.

  When you're creating a passphrase, the specified number of words are randomly selected from the chosen word list and concatenated. The first letter of each word is capitalized to enhance readability. This feature also fully supports backing passwords up to either Windows Server AD or Microsoft Entra ID.

  The passphrase word lists used in the three new _PasswordComplexity_ passphrase settings are sourced from the Electronic Frontier Foundation's article, "[Deep Dive: EFF's New Wordlists for Random Passphrases](https://www.eff.org/deeplinks/2016/07/new-wordlists-random-passphrases)". The [Windows LAPS Passphrase Word Lists](https://go.microsoft.com/fwlink/?linkid=2255471) is licensed under the CC-BY-3.0 Attribution license and is available for download.

  > [!NOTE]
  > Windows LAPS doesn't allow for customization of the built-in word lists nor the use of customer-configured word lists.

- **PostAuthenticationAction support for terminating individual processes**

  A new option is added to the PostAuthenticationActions (PAA) Group Policy setting, “_Reset the password, sign out the managed account, and terminate any remaining processes_” located in **Computer Configuration > Administrative Templates > System > LAPS > Post-authentication actions**.

  This new option is an extension of the previous "_Reset the password and sign out the managed account_" option. Once configured, the PAA notifies and then terminates any interactive sign-in sessions. It enumerates and terminates any remaining processes that are still running under the Windows LAPS-managed local account identity. It's important to note that no notification precedes this termination.
  
  Furthermore, the expansion of logging events during post-authentication-action execution provides deeper insights into the operation.

To learn more about LAPS, see [What is Windows LAPS?](/windows-server/identity/laps/laps-overview).

### Windows Terminal

The Windows Terminal, a powerful and efficient multishell application for command-line users, is available in this build. Search for "Terminal" in the search bar.

## See also

- [Windows Server Insiders Community discussions](https://techcommunity.microsoft.com/t5/windows-server-insiders/bd-p/WindowsServerInsiders)
