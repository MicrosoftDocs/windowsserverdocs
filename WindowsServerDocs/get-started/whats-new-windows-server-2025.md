---
title: What's new in Windows Server 2025
description: Learn about the features and enhancements in Windows Server 2025 that help to improve security, performance, and flexibility.
ms.topic: whats-new
author: dknappettmsft
ms.author: daknappe
ms.date: 01/15/2026
---

# What's new in Windows Server 2025

This article describes some of the newest developments in Windows Server 2025, which boasts advanced features that improve security, performance, and flexibility. With faster storage options and the ability to integrate with hybrid cloud environments, managing your infrastructure is now more streamlined. Windows Server 2025 builds on the strong foundation of its predecessor and introduces a range of innovative enhancements to adapt to your needs.

## Desktop experience and upgrade

Explore upgrade options and the desktop experience.

### In-place upgrade from Windows Server 2012 R2

With Windows Server 2025, you can upgrade up to four versions at a time. You can upgrade directly to Windows Server 2025 from Windows Server 2012 R2 and later.

### Desktop shell

When you sign in for the first time, the desktop shell experience conforms to the style and appearance of Windows 11.

### Bluetooth

You can now connect mice, keyboards, headsets, audio devices, and more via Bluetooth in Windows Server 2025.

### DTrace

Windows Server 2025 comes equipped with `dtrace` as a native tool. DTrace is a command-line utility that enables users to monitor and troubleshoot their system's performance in real time. With DTrace, you can dynamically instrument both the kernel and user-space code without any need to modify the code itself. This versatile tool supports a range of data collection and analysis techniques, such as aggregations, histograms, and tracing of user-level events. To learn more, see [DTrace](/windows-server/administration/windows-commands/dtrace) for command-line help and [DTrace on Windows](/windows-hardware/drivers/devtest/dtrace) for other capabilities.

### Email and accounts

You can now add the following types of accounts in Windows **Settings** under **Accounts** > **Email & accounts** for Windows Server 2025:

- Microsoft Entra ID
- Microsoft account
- Work or school account

Domain join is still required for most situations.

### Feedback Hub

To submit feedback or report problems that you encounter when you use Windows Server 2025, use the Windows Feedback Hub. Include screenshots or recordings of the process that caused the issue to help us understand your situation and share suggestions to enhance your Windows experience. To learn more, see [Explore the Feedback Hub](/windows-insider/feedback-hub/feedback-hub-app).

### File compression

Windows Server 2025 has a new compression feature. To compress an item, right-click and select **Compress to**. This feature supports **ZIP**, **7z**, and **TAR** compression formats with specific compression methods for each one.

### Pinned apps

Pinning your most-used apps is now available through the **Start** menu and is customizable to suit your needs. The default pinned apps are currently:

- Azure Arc Setup
- Feedback Hub
- File Explorer
- Microsoft Edge
- Server Manager
- Settings
- Terminal
- Windows PowerShell

### Task Manager

Windows Server 2025 uses the modern Task Manager app with [Mica material](/windows/apps/design/style/mica) that conforms to the style of Windows 11.

### Wi-Fi

It's now easier to enable wireless capabilities because the Wireless LAN Service feature is now installed by default. The wireless startup service is set to manual. To enable it, run `net start wlansvc` in the command prompt, Windows Terminal, or PowerShell.

### Windows Terminal

The Windows Terminal, a powerful and efficient multishell application for command-line users, is available in Windows Server 2025. Search for **Terminal** on the search bar.

### WinGet

WinGet is installed by default, which is a command-line Windows Package Manager tool that provides comprehensive package manager solutions for installing applications on Windows devices. To learn more, see [Use the WinGet tool to install and manage applications](/windows/package-manager/winget).

## Advanced multilayer security

Learn about security in Windows 2025.

### Hotpatch (preview)

Hotpatch is now available for Windows Server 2025 machines connected to Azure Arc after Hotpatch is enabled in the Azure Arc portal. You can use Hotpatch to apply OS security updates without restarting your machine. To learn more, see [Hotpatch](hotpatch.md).

> [!IMPORTANT]
> Azure Arc-enabled Hotpatch is currently in preview. See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

### Credential Guard

Starting with Windows Server 2025, Credential Guard is now enabled by default on devices that meet the requirements. For more information about Credential Guard, see [Configure Credential Guard](/windows/security/identity-protection/credential-guard/configure).

### Active Directory Domain Services

The latest enhancements to Active Directory Domain Services (AD DS) and Active Directory Lightweight Domain Services (AD LDS) introduce a range of new functionalities and capabilities aimed at optimizing your domain management experience:

- **32k database page size optional feature**: Active Directory uses an Extensible Storage Engine (ESE) database since its introduction in Windows 2000 that uses an 8k database page size. The 8k architectural design decision resulted in limitations throughout Active Directory that are documented in [Active Directory maximum limits: Scalability](/previous-versions/windows/it-pro/windows-server-2003/cc756101(v=ws.10)). An example of this limitation is a single record Active Directory object, which can't exceed 8k-byte size. Moving to a 32k database page format offers a huge improvement in areas affected by legacy restrictions. Multivalued attributes can now hold up to approximately 3,200 values, which is an increase by a factor of 2.6.

  You can install new domain controllers (DCs) with a 32k-page database that uses 64-bit Long Value IDs (LIDs) and run in 8k-page mode for compatibility with previous versions. An upgraded DC continues to use its current database format and 8k pages. Moving to a 32k-page database is done on a forestwide basis and requires that all DCs in the forest have a 32k-page capable database.

- **Active Directory schema updates**: Three new log database files are introduced that extend the Active Directory schema: `sch89.ldf`, `sch90.ldf`, and `sch91.ldf`. The AD LDS equivalent schema updates are in `MS-ADAM-Upgrade3.ldf`. To learn more about previous schema updates, see [Windows Server Active Directory schema updates](../identity/ad-ds/deploy/Schema-Updates.md).
- **Active Directory object repair**: Enterprise administrators can now repair objects with the missing core attributes `SamAccountType` and `ObjectCategory`. Enterprise administrators can reset the `LastLogonTimeStamp` attribute on an object to the current time. These operations are achieved through a new [RootDSE](/openspecs/windows_protocols/ms-adts/fc74972f-b267-4c1a-8716-0f5b48cf52b9) modify operation feature on the affected object called `fixupObjectState`.
- **Channel binding audit support**: You can now enable events 3074 and 3075 for Lightweight Directory Access Protocol (LDAP) channel binding. When the channel binding policy is modified to a more secure setting, an administrator can identify devices in the environment that don't support or fail channel binding. These audit events are also available in Windows Server 2022 and later via [KB4520412](https://support.microsoft.com/topic/2020-2023-and-2024-ldap-channel-binding-and-ldap-signing-requirements-for-windows-kb4520412-ef185fb8-00f7-167d-744c-f299a66fc00a).
- **DC-location algorithm improvements**: The DC discovery algorithm provides new functionality with improvements to mapping of short NetBIOS-style domain names to DNS-style domain names. To learn more, see [Locating domain controllers in Windows and Windows Server](../identity/ad-ds/manage/dc-locator.md).

  > [!NOTE]
  > Windows doesn't use mailslots during DC discovery operations because Microsoft has announced the [deprecation of WINS and mailslots](https://techcommunity.microsoft.com/t5/storage-at-microsoft/the-beginning-of-the-end-of-remote-mailslots-as-part-of-windows/ba-p/3762048) for these legacy technologies.

- **Forest and domain functional levels**: The new functional level is used for general supportability and is required for the new 32k database page size feature. The new functional level maps to the value of `DomainLevel 10` and `ForestLevel 10` for unattended installations. Microsoft has no plans to retrofit functional levels for Windows Server 2019 and Windows Server 2022. To perform an unattended promotion and demotion of a DC, see [DCPROMO answer file syntax for unattended promotion and demotion of domain controllers](/troubleshoot/windows-server/identity/syntax-build-answer-files-unattended-installation-ad-ds).

  The [DsGetDcName](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamew) API also supports the new flag `DS_DIRECTORY_SERVICE_13_REQUIRED` that enables location of DCs running Windows Server 2025. You can learn more about functional levels in the following articles:

  - [AD DS functional levels](../identity/ad-ds/active-directory-functional-levels.md)
  - [Raise the domain functional level](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753104(v=ws.11))
  - [Raise the forest functional level](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc730985(v=ws.11))

  > [!NOTE]
  > New Active Directory forests or AD LDS configuration sets are required to have a functional level of Windows Server 2016 or later. Promotion of an Active Directory or AD LDS replica requires that the existing domain or configuration set is already running with a functional level of Windows Server 2016 or later.
  >
  > Microsoft recommends that all customers begin planning now to upgrade their Active Directory and AD LDS servers to Windows Server 2022 in preparation for the next release.

- **Improved algorithms for Name/SID Lookups**: Local security authority (LSA) Name and SID Lookup forwarding between machine accounts no longer uses the legacy Netlogon secure channel. Kerberos authentication and the DC Locator algorithm are used instead. To maintain compatibility with legacy operating systems, it's still possible to use the Netlogon secure channel as a fallback option.
- **Improved security for confidential attributes**: DCs and AD LDS instances only allow LDAP to add, search, and modify operations that involve confidential attributes when the connection is encrypted.
- **Improved security for default machine account passwords**: Active Directory now uses default computer account passwords that are randomly generated. Windows 2025 DCs block setting computer account passwords to the default password of the computer account name.

  To control this behavior, enable the Group Policy Object (GPO) setting **Domain controller: Refuse setting default machine account password** located in
  *Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options*.

  Utilities like Active Directory Administrative Center (ADAC), Active Directory Users and Computers (ADUC), `net computer`, and `dsmod` also honor this new behavior. Both ADAC and ADUC no longer allow creation of a pre-Windows 2000 account.

- **Kerberos PKINIT support for cryptographic agility**: The Kerberos Public Key Cryptography for Initial Authentication in Kerberos (PKINIT) protocol implementation is updated to allow for cryptographic agility by supporting more algorithms and removing hardcoded algorithms.
- **Kerberos changes for Algorithms used for Ticket Granting Tickets**: The Kerberos Distribution Center will no longer issue Ticket Granting Tickets using RC4 encryption, such as RC4-HMAC(NT).
- **Kerberos changes for supported encryption type configuration**: Kerberos no longer honors the legacy registry key REG_DWORD `SupportedEncryptionTypes` found in the path `HKEY_LOCAL_MACHINE\CurrentControlSet\Control\Lsa\Kerberos\Parameters`, Microsoft recommends using group policy instead. To learn more about the group policy settings, see [Network security: Configure encryption types allowed for Kerberos](/previous-versions/windows/it-pro/windows-10/security/threat-protection/security-policy-settings/network-security-configure-encryption-types-allowed-for-kerberos).
- **LAN Manager GPO setting**: The GPO setting **Network security: Don't store LAN Manager hash value on next password change** is no longer present and doesn't apply to new versions of Windows.
- **LDAP encryption by default**: All new Active Directory deployments require [LDAP signing (sealing) by default](../identity/ad-ds/ldap-signing.md) for all LDAP client communication after a [Simple Authentication and Security Layer (SASL)](/openspecs/windows_protocols/ms-adts/989e0748-0953-455d-9d37-d08dfbf3998b) bind. To learn more about the signing behavior, see [LDAP signing for Active Directory Domain Services](../identity/ad-ds/ldap-signing.md).
- **LDAP support for Transport Layer Security (TLS) 1.3**: LDAP uses the latest SCHANNEL implementation and supports TLS 1.3 for LDAP over TLS connections. Using TLS 1.3 eliminates obsolete cryptographic algorithms and enhances security over older versions. TLS 1.3 aims to encrypt as much of the handshake as possible. To learn more, see [Protocols in TLS/SSL (Schannel SSP)](/windows/win32/secauthn/protocols-in-tls-ssl--schannel-ssp-) and [TLS Cipher Suites in Windows Server 2022](/windows/win32/secauthn/tls-cipher-suites-in-windows-server-2022).
- **Legacy Security Account Manager (SAM) remote procedure call (RPC) password change behavior**: Secure protocols such as Kerberos are the preferred way to change domain user passwords. On DCs, the latest SAM RPC password change method [SamrUnicodeChangePasswordUser4](/openspecs/windows_protocols/ms-samr/bbc1c5e5-9b81-4038-b2b9-c87d3569ed38) by using Advanced Encryption Standard (AES) is accepted by default when it's called remotely. The following legacy SAM RPC methods are blocked by default when they're called remotely:

  - [SamrChangePasswordUser](/openspecs/windows_protocols/ms-samr/9699d8ca-e1a4-433c-a8c3-d7bebeb01476)
  - [SamrOemChangePasswordUser2](/openspecs/windows_protocols/ms-samr/8d0bf63e-fa5f-4c75-be22-558c52075842)
  - [SamrUnicodeChangePasswordUser2](/openspecs/windows_protocols/ms-samr/acb3204a-da8b-478e-9139-1ea589edb880)

  For domain users that are members of the [Protected Users](/windows-server/security/credentials-protection-and-management/protected-users-security-group#BKMK_Requirements) group and for local accounts on domain member computers, all remote password changes through the legacy SAM RPC interface are blocked by default, including `SamrUnicodeChangePasswordUser4`.

  To control this behavior, use the following GPO setting:

  **Computer Configuration** > **Administrative Templates** > **System** > **Security Account Manager** > **Configure SAM change password RPC methods policy**

- **Non-uniform Memory Access (NUMA) support**: AD DS now takes advantage of NUMA-capable hardware by using CPUs in all processor groups. Previously, Active Directory would only use CPUs in group 0. Active Directory can expand beyond 64 cores.
- **Performance counters**: Monitoring and troubleshooting the performance of the following counters are now available:

  - **DC Locator**: Counters specific to clients and DCs are available.
  - **LSA Lookups**: Name and SID Lookups through the `LsaLookupNames`, `LsaLookupSids`, and equivalent APIs. These counters are available on both client and server versions.
  - **LDAP client**: Available in Windows Server 2022 and later via the [KB 5029250](https://support.microsoft.com/topic/august-8-2023-kb5029250-os-build-20348-1906-2db4a1ac-8e18-443e-b4d6-ee17435cf94c) update.

- **Replication priority order**: Administrators can now increase the system-calculated replication priority with a particular replication partner for a particular naming context. This feature allows more flexibility in configuring the replication order to address specific scenarios.

#### Delegated Managed Service Account

This new type of account enables migration from a service account to a delegated Managed Service Account (dMSA). This account type comes with managed and fully randomized keys to ensure minimal application changes while the original service account passwords are disabled. To learn more, see [Delegated Managed Service Accounts overview](../identity/ad-ds/manage/delegated-managed-service-accounts/delegated-managed-service-accounts-overview.md).

### Windows Local Administrator Password Solution

Windows Local Administrator Password Solution (LAPS) helps organizations manage local administrator passwords on their domain-joined computers. It automatically generates unique passwords for each computer's local administrator account. It then stores them securely in Active Directory and updates them regularly. Automatically generated passwords help to improve security. They reduce the risk of attackers gaining access to sensitive systems by using compromised or easily guessable passwords.

Several features new to Microsoft LAPS introduce the following improvements:

- **New automatic account management**: IT admins can now create a managed local account with ease. With this feature, you can customize the account name and enable or disable the account. You can even randomize the account name for enhanced security. The update also includes improved integration with existing local account management policies from Microsoft. To learn more about this feature, see [Windows LAPS account management modes](/windows-server/identity/laps/laps-concepts-account-management-modes).
- **New image rollback detection**: Windows LAPS now detects when an image rollback occurs. If a rollback does happen, the password stored in Active Directory might no longer match the password stored locally on the device. Rollbacks can result in a *torn state*. In this case, the IT admin is unable to sign in to the device by using the persisted Windows LAPS password.

  To address this issue, a new feature was added that includes an Active Directory attribute called `msLAPS-CurrentPasswordVersion`. This attribute contains a random globally unique identifier (GUID) written by Windows LAPS every time a new password is persisted in Active Directory and saved locally. During every processing cycle, the GUID stored in `msLAPS-CurrentPasswordVersion` is queried and compared to the locally persisted copy. If they're different, the password is immediately rotated.

  To enable this feature, run the latest version of the `Update-LapsADSchema` cmdlet. Windows LAPS then recognizes the new attribute and begins to use it. If you don't run the updated version of the `Update-LapsADSchema` cmdlet, Windows LAPS logs a 10108 warning event in the event log but continues to function normally in all other respects.

  No policy settings are used to enable or configure this feature. The feature is always enabled after the new schema attribute is added.

- **New passphrase**: IT admins can now use a new feature in Windows LAPS that enables the generation of less-complex passphrases. An example is a passphrase such as **EatYummyCaramelCandy**. This phrase is easier to read, remember, and type compared to a traditional password like **V3r_b4tim#963?**.

  With this new feature, you can configure the `PasswordComplexity` policy setting to select one of three different word lists for passphrases. All of the lists are included in Windows and don't require a separate download. A new policy setting called `PassphraseLength` controls the number of words used in the passphrase.

  When you create a passphrase, the specified number of words are randomly selected from the chosen word list and concatenated. The first letter of each word is capitalized to enhance readability. This feature also fully supports backing up passwords to either Active Directory or Microsoft Entra ID.

  The passphrase word lists used in the three new `PasswordComplexity` passphrase settings are sourced from the Electronic Frontier Foundation article [Deep Dive: EFF's New Wordlists for Random Passphrases](https://www.eff.org/deeplinks/2016/07/new-wordlists-random-passphrases). The [Windows LAPS Passphrase Word Lists](https://go.microsoft.com/fwlink/?linkid=2255471) is licensed under the CC-BY-3.0 attribution license and is available for download.

  > [!NOTE]
  > Windows LAPS doesn't allow for customization of the built-in word lists or the use of customer-configured word lists.

- **Improved readability password dictionary**: Windows LAPS introduces a new `PasswordComplexity` setting that enables IT admins to create less complex passwords. You can use this feature to customize LAPS to use all four character categories (uppercase letters, lowercase letters, numbers, and special characters) like the existing complexity setting of `4`. With the new setting of `5`, the more complex characters are excluded to enhance password readability and minimize confusion. For example, the numeral **1** and the letter **I** are never used with the new setting.

  When `PasswordComplexity` is configured to `5`, the following changes are made to the default password dictionary character set:

  - **Don't use:** The letters **I**, **O**, **Q**, **l**, **o**
  - **Don't use:** The numbers **0**, **1**
  - **Don't use:** The special characters **,**, **.**, **&**, **{**, **}**, **[**, **]**, **(**, **)**, **;**
  - **Use:** The special characters **:**, **=**, **?**, **\***

  The ADUC snap-in (via Microsoft Management Console) now features an improved Windows LAPS tab. The Windows LAPS password now appears in a new font that enhances its readability when it appears in plain text.

- **Post-authentication action support for terminating individual processes**: A new option is added to the **Post-authentication actions** (PAA) Group Policy setting, `Reset the password, sign out the managed account, and terminate any remaining processes`, which is located in **Computer Configuration** > **Administrative Templates** > **System** > **LAPS** > **Post-authentication actions**.

  This new option is an extension of the previous option, `Reset the password and log off the managed account`. After configuration, the PAA notifies and then terminates any interactive sign-in sessions. It enumerates and terminates any remaining processes that are still running under the local account identity managed by Windows LAPS. No notification precedes this termination.

  The expansion of logging events during the execution of PAA provides deeper insights into the operation.

To learn more about Windows LAPS, see [What is Windows LAPS?](/windows-server/identity/laps/laps-overview).

### OpenSSH

In earlier versions of Windows Server, the OpenSSH connectivity tool required manual installation before use. The OpenSSH server-side component is installed by default in Windows Server 2025. The Server Manager UI also includes a one-step option under **Remote SSH Access** that enables or disables the `sshd.exe` service. Also, you can add users to the **OpenSSH Users** group to allow or restrict access to your devices. To learn more, see [OpenSSH for Windows overview](/windows-server/administration/openssh/openssh_overview).

### Security baseline

By implementing a customized security baseline, you can establish security measures right from the beginning for your device or VM role based on the recommended security posture. This baseline comes equipped with more than 350 preconfigured Windows security settings. You can use the settings to apply and enforce specific security settings that align with the best practices recommended by Microsoft and industry standards. To learn more, see [OSConfig overview](../security/osconfig/osconfig-overview.md).

### Virtualization-based security enclaves

A virtualization-based security (VBS) enclave is a software-based trusted execution environment inside the address space of a host application. VBS enclaves use underlying [VBS technology](/windows-hardware/design/device-experiences/oem-vbs) to isolate the sensitive portion of an application in a secure partition of memory. VBS enclaves enable isolation of sensitive workloads from both the host application and the rest of the system.

VBS enclaves enable applications to protect their secrets by removing the need to trust admins and hardening against malicious attackers. For more information, read the [VBS enclaves Win32 reference](/windows/win32/trusted-execution/vbs-enclaves).

### Virtualization-based security key protection

VBS key protection enables Windows developers to secure cryptographic keys by using VBS. VBS uses the virtualization extension capability of the CPU to create an isolated runtime outside of the normal OS.

When in use, VBS keys are isolated in a secure process. Key operations can occur without exposing the private key material outside of this space. At rest, a TPM key encrypts private key material, which binds VBS keys to the device. Keys protected in this way can't be dumped from process memory or exported in plain text from a user's machine.

VBS key protection helps prevent exfiltration attacks by any admin-level attacker. VBS must be enabled to use key protection. For information about how to enable VBS, see [Enable memory integrity](/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity).

### Secured connectivity

The following sections discuss security for connections.

#### Secure certificate management

Searching or retrieving certificates on Windows now supports SHA-256 hashes, as described in the functions [CertFindCertificateInStore](/windows/win32/api/wincrypt/nf-wincrypt-certfindcertificateinstore) and [CertGetCertificateContextProperty](/windows/win32/api/wincrypt/nf-wincrypt-certgetcertificatecontextproperty). TLS server authentication is more secure across Windows and now requires a minimum RSA key length of 2,048 bits. For more information, read [TLS server authentication: Deprecation of weak RSA certificates](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/tls-server-authentication-deprecation-of-weak-rsa-certificates/ba-p/4134028).

#### SMB over QUIC

The [SMB over QUIC](../storage/file-server/smb-over-quic.md) server feature, which was only available in Windows Server Azure Edition, is now available in both Windows Server Standard and Windows Server Datacenter versions. SMB over QUIC adds the benefits of the QUIC, which provides low-latency, encrypted connections over the internet.

##### SMB over QUIC enablement policy

Administrators can disable the SMB over QUIC client through Group Policy and PowerShell. To disable SMB over QUIC by using Group Policy, set the **Enable SMB over QUIC** policy in the following paths to **Disabled**:

- *Computer Configuration\Administrative Templates\Network\Lanman Workstation*
- *Computer Configuration\Administrative Templates\Network\Lanman Server*

To disable SMB over QUIC by using PowerShell, run this command in an elevated PowerShell prompt:

```powershell
Set-SmbClientConfiguration -EnableSMBQUIC $false
```

##### SMB signing and encryption auditing

Administrators can enable auditing of the SMB server and client for support of SMB signing and encryption. If a non-Microsoft client or server lacks support for SMB encryption or signing, it can be detected. When a non-Microsoft device or software states it supports SMB 3.1.1, but fails to support SMB signing, it violates the [SMB 3.1.1 Pre-authentication integrity](/archive/blogs/openspecification/smb-3-1-1-pre-authentication-integrity-in-windows-10) protocol requirement.

You can configure SMB signing and encryption auditing settings by using Group Policy or PowerShell. You can change these policies in the following Group Policy paths:

- *Computer Configuration\Administrative Templates\Network\Lanman Server\Audit client does not support encryption*
- *Computer Configuration\Administrative Templates\Network\Lanman Server\Audit client does not support signing*
- *Computer Configuration\Administrative Templates\Network\Lanman Workstation\Audit server does not support encryption*
- *Computer Configuration\Administrative Templates\Network\Lanman Workstation\Audit server does not support signing*

To perform these changes by using PowerShell, run these commands in an elevated prompt where `$true` enables and `$false` disables these settings:

```powershell
Set-SmbServerConfiguration -AuditClientDoesNotSupportEncryption $true
Set-SmbServerConfiguration -AuditClientDoesNotSupportSigning $true

Set-SmbClientConfiguration -AuditServerDoesNotSupportEncryption $true
Set-SmbClientConfiguration -AuditServerDoesNotSupportSigning $true
```

Event logs for these changes are stored in the following Event Viewer paths with their specific Event ID.

|Path|Event ID|
|-|-|
|Applications and Services Logs\Microsoft\Windows\SMBClient\Audit|31998 <br> 31999|
|Applications and Services Logs\Microsoft\Windows\SMBServer\Audit|3021 <br> 3022|

##### SMB over QUIC auditing

SMB over QUIC client connection auditing captures events that are written to an event log to include the QUIC transport in the Event Viewer. These logs are stored in the following paths with their specific Event ID.

|Path|Event ID|
|-|-|
|Applications and Services Logs\Microsoft\Windows\SMBClient\Connectivity|30832|
|Applications and Services Logs\Microsoft\Windows\SMBServer\Connectivity|1913|

##### SMB over QUIC client access control

Windows Server 2025 includes client access control for SMB over QUIC. SMB over QUIC is an alternative to TCP and RDMA that supplies secure connectivity to edge file servers over untrusted networks. Client access control introduces more controls to restrict access to your data by using certificates. To learn more, see [How client access control works](../storage/file-server/configure-smb-over-quic-client-access-control.md#how-client-access-control-works).

#### SMB alternative ports

You can use the SMB client to connect to alternative TCP, QUIC, and RDMA ports instead of their IANA/IETF defaults of 445, 5445, and 443. You can configure alternative ports via Group Policy or PowerShell. Previously, the SMB server in Windows mandated inbound connections to use the IANA-registered port TCP/445 while the SMB TCP client allowed only outbound connections to that same TCP port. Now, SMB over QUIC allows for SMB alternative ports where QUIC-mandated UDP/443 ports are available for both server and client devices. To learn more, see [Configure alternative SMB ports](../storage/file-server/smb-ports.md).

#### SMB firewall rule hardening

Previously, when a share was created, the SMB firewall rules were automatically configured to enable the **File and Printer Sharing** group for the relevant firewall profiles. Now the creation of an SMB share in Windows results in the automatic configuration of the new **File and Printer Sharing (Restrictive)** group, which no longer permits inbound NetBIOS ports 137-139. To learn more, see [Updated firewall rules](../storage/file-server/smb-secure-traffic.md#updated-firewall-rules).

#### SMB encryption

[Enforce SMB encryption](../storage/file-server/smb-security.md#smb-encryption) is enabled for all outbound SMB client connections. With this update, administrators can set a mandate that all destination servers support SMB 3.x and encryption. If a server lacks these capabilities, the client is unable to establish a connection.

#### SMB authentication rate limiter

The SMB authentication rate limiter limits the number of authentication attempts within a certain time period. The SMB authentication rate limiter helps combat brute-force authentication attacks. The service for the SMB server uses the authentication rate limiter to implement a delay between each failed NTLM- or PKU2U-based authentication attempt. The service is enabled by default. To learn more, see [How SMB authentication rate limiter works](../storage/file-server/configure-smb-authentication-rate-limiter.md#how-smb-authentication-rate-limiter-works).

#### Disable SMB NTLM

Beginning with Windows Server 2025, the SMB client supports NTLM blocking for remote outbound connections. Previously, the Windows Simple and Protected GSSAPI Negotiation Mechanism ([SPNEGO](/openspecs/windows_protocols/ms-spng/b16309d8-4a93-4fa6-9ee2-7d84b2451c84)) negotiated Kerberos, NTLM, and other mechanisms with the destination server to determine a supported security package. To learn more, see [Block NTLM connections on SMB](../storage/file-server/smb-ntlm-blocking.md).

#### SMB dialect control

You can now [manage SMB dialects in Windows](../storage/file-server/manage-smb-dialects.md). When configured, the SMB server determines which SMB 2 and SMB 3 dialects it negotiates compared to the previous behavior and matches only the highest dialect.

#### SMB signing

SMB signing is now required by default for all SMB outbound connections. Previously, it was required only when you connected to shares named **SYSVOL** and **NETLOGON** on Active Directory DCs. To learn more, see [How signing works](../storage/file-server/smb-signing-overview.md#how-signing-works).

#### Remote Mailslot

The Remote Mailslot protocol is disabled by default for SMB and for DC Locator protocol use with Active Directory. Remote Mailslot might be removed in a later release. To learn more, see [Features removed or no longer developed in Windows Server](../get-started/removed-deprecated-features-windows-server.md).

#### Routing and Remote Access Services hardening

By default, new Routing and Remote Access Services (RRAS) installations don't accept VPN connections based on PPTP and L2TP. You can still enable these protocols, if necessary. VPN connections based on SSTP and IKEv2 are still accepted without any change.

Existing configurations retain their behavior. For example, if you run Windows Server 2019 and accept PPTP and L2TP connections, and you upgrade to Windows Server 2025 by using an in-place upgrade, connections based on L2TP and PPTP are still accepted. This change doesn't affect Windows client operating systems. To learn more about how to reenable PPTP and L2TP, see [Configure VPN protocols](../remote/remote-access/configure-vpn-protocols.md).

### IPsec default keying protocol change

The default keying modules have been changed to IKEv1 and IKEv2 for IPsec connections authenticated with machine certificates. For other authentication methods, the default AuthIP and IKEv1 remain. This applies to both Windows Server 2025 and Windows 11 24H2 clients. In the registry path `HKLM:\SYSTEM\CurrentControlSet\Services\MpsSvc\Parameters`, the `IpsecRestoreLegacyKeyMod` entry with a value of **0** utilizes the new sequence, IKEv2 and IKEv1. A value of **1** utilizes the previous sequence, AuthIP and IKEv1. To revert to the previous behavior, add the following registry key on systems using the new default keying protocol sequence. A reboot is required for changes to take effect.

```powershell
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\MpsSvc\Parameters" -Name "IpsecRestoreLegacyKeyMod" -PropertyType "DWORD" -Value 1
```

## Hyper-V, AI, and performance

The following sections discuss Hyper-V, AI, and performance.

### Accelerated Networking (preview)

Accelerated Networking (AccelNet) simplifies the management of single root I/O virtualization (SR-IOV) for virtual machines (VMs) hosted on Windows Server 2025 clusters. This feature uses the high-performance SR-IOV data path to reduce latency, jitter, and CPU utilization. AccelNet also includes a management layer that handles prerequisite checking, host configuration, and VM performance settings. To learn more, see [Accelerated Networking (preview)](/windows-server/networking/technologies/accelerated-networking/accelerated-networking).

### Dynamic processor compatibility

The dynamic processor compatibility mode is updated to take advantage of new processor capabilities in a clustered environment. Dynamic processor compatibility uses the maximum number of processor features available across all servers in a cluster. The mode improves performance compared to the previous version of processor compatibility.

You can also use dynamic processor compatibility to save its state between virtualization hosts that use different generations of processors. The processor compatibility mode now provides enhanced, dynamic capabilities on processors capable of second-level address translation. To learn more about the updated compatibility mode, see [Processor compatibility for Hyper-V virtual machines](../virtualization/hyper-v/processor-compatibility-mode.md).

### Hyper-V Manager

When you create a new VM through Hyper-V Manager, **Generation 2** is now set as the default option in the **New Virtual Machine Wizard**.

### Hypervisor-enforced paging translation

Hypervisor-enforced paging translation (HVPT) is a security enhancement to enforce the integrity of linear address translations. HVPT protects critical system data from write-what-where attacks, where the attacker writes an arbitrary value to an arbitrary location, often as the result of a buffer overflow. HVPT guards page tables that configure critical system data structures. HVPT includes everything already secured with hypervisor-protected code integrity (HVCI). HVPT is enabled by default, where hardware support is available. HVPT isn't enabled when Windows Server runs as a guest in a VM.

### GPU partitioning

 You can share a physical GPU device with multiple VMs by using GPU partitioning. Instead of allocating the entire GPU to a single VM, GPU partitioning (GPU-P) assigns dedicated fractions of the GPU to each VM. With Hyper-V GPU-P high availability, a GPU-P VM is automatically enabled on another cluster node if there is unplanned downtime.

GPU-P Live Migration provides a solution to move a VM (for planned downtime or load balancing) with GPU-P to another node whether it's standalone or clustered. To learn more about GPU partitioning, see [GPU partitioning](../virtualization/hyper-v/gpu-partitioning.md).

### Network ATC

Network ATC streamlines the deployment and management of network configurations for Windows Server 2025 clusters. Network ATC uses an intent-based approach, where users specify their desired intents, such as management, compute, or storage for a network adapter. The deployment is automated based on the intended configuration.

This approach reduces the time, complexity, and errors associated with host networking deployment. It ensures configuration consistency across the cluster and also eliminates configuration drift. To learn more, see [Deploy host networking with Network ATC](/azure/azure-local/deploy/network-atc?tabs=22H2&pivots=windows-server).

### Scalability

With Windows Server 2025, Hyper-V now supports up to 4 petabytes of memory and 2,048 logical processors per host. This increase allows for greater scalability and performance for virtualized workloads.

Windows Server 2025 also supports up to 240 TB of memory and 2,048 virtual processors for generation 2 VMs, providing increased flexibility for running large workloads. To learn more, see [Plan for Hyper-V scalability in Windows Server](../virtualization/hyper-v/maximum-scale-limits.md).

### Workgroup clusters

Hyper-V workgroup clusters are a special type of Windows Server Failover Cluster where the Hyper-V cluster nodes aren't members of an Active Directory domain with the ability to live migrate VMs in a workgroup cluster.

## Storage

The following sections describe storage updates.

### Block cloning support

Dev Drive now supports block cloning starting with Windows 11 24H2 and Windows Server 2025. Because Dev Drive uses the Resilient File System (ReFS) format, block cloning support provides significant performance benefits when you copy files. With block cloning, the file system can copy a range of file bytes for an application as a low-cost metadata operation instead of performing expensive read-and-write operations to the underlying physical data.

The result is faster completion of file copying, reduced I/O to the underlying storage, and improved storage capacity by enabling multiple files to share the same logical clusters. To learn more, see [Block cloning on ReFS](/windows-server/storage/refs/block-cloning).

### Dev Drive

Dev Drive is a storage volume that aims to enhance the performance of crucial developer workloads. Dev Drive uses ReFS technology and incorporates specific file system optimizations to offer greater control over storage volume settings and security. Administrators now have the ability to designate trust, configure antivirus settings, and exercise administrative control over attached filters. To learn more, see [Set up a Dev Drive on Windows 11](/windows/dev-drive).

### NVMe

NVMe is a new standard for fast solid-state drives. NVMe storage performance is optimized in Windows Server 2025. The result is improved performance with an increase in IOPS and a decrease in CPU utilization.

### Storage Replica compression

Storage Replica compression reduces the amount of data transferred over the network during replication. To learn more about compression in Storage Replica, see [Storage Replica overview](../storage/storage-replica/storage-replica-overview.md).

### Storage Replica Enhanced Log

Storage Replica Enhanced Log helps with log implementation to eliminate the performance costs associated with file system abstractions. Block replication performance is improved. To learn more, see [Storage Replica Enhanced Log](../storage/storage-replica/storage-replica-enhanced-log.md).

### ReFS native storage deduplication and compression

ReFS native storage deduplication and compression are techniques used to optimize storage efficiency for both static and active workloads, such as file servers or virtual desktops. To learn more about ReFS deduplication and compression, see [Optimize storage with ReFS deduplication and compression in Azure Local](/azure/azure-local/manage/refs-deduplication-and-compression).

### Thin provisioned volumes

Thin provisioned volumes with Storage Spaces Direct are a way to allocate storage resources more efficiently and avoid costly overallocation by allocating from the pool only when needed in a cluster. You can also convert fixed to thin provisioned volumes. Converting from fixed to thin provisioned volumes returns any unused storage back to the pool for other volumes to use. To learn more about thin provisioned volumes, see [Storage thin provisioning](/azure/azure-local/manage/manage-thin-provisioning-23h2).

### Server Message Block

Server Message Block (SMB) is one of the most widely used protocols in networking. SMB provides a reliable way to share files and other resources between devices on your network. Windows Server 2025 includes SMB compression support for the industry standard LZ4 compression algorithm. LZ4 is in addition to SMB's existing support for XPRESS (LZ77), XPRESS Huffman (LZ77+Huffman), LZNT1, and PATTERN_V1.

## Azure Arc and hybrid

The following sections discuss Azure Arc and hybrid configurations.

### Simplified Azure Arc Setup

Azure Arc Setup is a Feature on Demand, so it's installed by default. A user-friendly wizard interface and a system tray icon in the taskbar help to facilitate the process of adding servers to Azure Arc. Azure Arc extends the capabilities of the Azure platform so that you can create applications and services that can operate in diverse environments. These environments include datacenters, the edge, and multicloud environments and provide increased flexibility. To learn more, see [Connect Windows Server machines to Azure through Azure Arc Setup](/azure/azure-arc/servers/onboard-windows-server).

### Pay-as-you-go licensing

The Azure Arc pay-as-you-go subscription licensing option is an alternative to the conventional perpetual licensing for Windows Server 2025. With the pay-as-you-go option, you can deploy a Windows Server device, license it, and pay for only as much as you use. This feature is facilitated through Azure Arc and billed via your Azure subscription. To learn more, see [Azure Arc pay-as-you-go licensing](windows-server-pay-as-you-go.md).

### Windows Server Management enabled by Azure Arc

Windows Server Management enabled by Azure Arc offers new benefits to customers with Windows Server licenses that have active Software Assurance or Windows Server licenses that are active subscription licenses. Windows Server 2025 has the following key benefits:

- **Windows Admin Center in Azure Arc**: Integrates Azure Arc with Windows Admin Center so that you can manage your Windows Server instances from the Azure Arc portal. This integration provides a unified management experience for your Windows Server instances, whether they're running on-premises, in the cloud, or at the edge.
- **Remote Support**: Offers customers with professional support the ability to grant just-in-time access with detailed execution transcripts and revocation rights.
- **Best Practices Assessment**: Collection and analysis of server data generates issues and remediation guidance and performance improvements.
- **Azure Site Recovery Configuration**: Configuration of Azure Site Recovery ensures business continuity and provides replication and data resilience for critical workloads.

To learn more about Windows Server Management enabled by Azure Arc and the available benefits, see [Windows Server Management enabled by Azure Arc](/azure/azure-arc/servers/windows-server-management-overview).

## Software-Defined Networking

Software-Defined Networking (SDN) is an approach to networking that network administrators can use to manage network services through abstraction of lower-level functionality. SDN enables the separation of the network control plane, which manages the network, from the data plane, which handles the traffic. This separation allows for increased flexibility and programmability in network management. SDN provides the following benefits in Windows Server 2025:

- **Network Controller**: This control plane for SDN is now hosted directly as Failover Cluster services on the physical host machines. Using a cluster role eliminates the need to deploy VMs, which simplifies deployment and management and conserves resources.
- **Tag-based segmentation**: Administrators can use custom service tags to associate network security groups (NSGs) and VMs for access control. Instead of specifying IP ranges, administrators can now use simple, self-explanatory labels to tag workload VMs and apply security policies based on these tags. Tags simplify the process of managing network security and eliminate the need to remember and retype IP ranges. To learn more, see [Configure network security groups with tags in Windows Admin Center](/azure/azure-local/manage/configure-network-security-groups-with-tags?pivots=windows-server).
- **Default network policies in Windows Server 2025**: These policies bring Azure-like protection options to NSGs for workloads deployed through Windows Admin Center. The default policy denies all inbound access, allowing selective opening of well-known inbound ports while permitting full outbound access from workload VMs. Default network policies ensure that workload VMs are secured from the point of creation. To learn more, see [Use default network access policies on virtual machines on Azure Local](/azure/azure-local/manage/manage-default-network-access-policies-virtual-machines-23h2?pivots=windows-server).
- **SDN Multisite**: This feature provides native layer 2 and layer 3 connectivity between applications across two locations without any extra components. With SDN Multisite, applications can move seamlessly without the need to reconfigure the application or networks. It also offers unified network policy management for workloads so that you don't need to update policies when a workload VM moves from one location to another. To learn more, see [What is SDN Multisite?](/azure/azure-local/concepts/sdn-multisite-overview?pivots=windows-server).
- **Enhanced performance of SDN layer 3 gateways**: Layer 3 gateways achieve higher throughput and reduced CPU cycles. These improvements are enabled by default. Users automatically experience better performance when an SDN gateway layer 3 connection is configured through PowerShell or Windows Admin Center.

## Windows Containers portability

Portability is a crucial aspect of container management and has the ability to simplify upgrades by applying enhanced flexibility and compatibility of containers in Windows.

Portability is a Windows Server feature that users can employ to move container images, and their associated data, between different hosts or environments without requiring any modifications. Users can create a container image on one host and then deploy it on another host without having to worry about compatibility issues. To learn more, see [Portability for containers](/virtualization/windowscontainers/deploy-containers/portability).

## Windows Server Insider Program

The [Windows Server Insider Program](get-started-with-windows-server-insiders-preview.md) provides early access to the latest Windows OS releases for a community of enthusiasts. As a member, you're among the first to try out new ideas and concepts that Microsoft is developing. After you register as a member, you can participate in different release channels. Go to **Start** > **Settings** > **Windows Update** > **Windows Insider Program**.

## Related content

[Windows Server Insider Community discussions](https://techcommunity.microsoft.com/t5/windows-server-insiders/bd-p/WindowsServerInsiders)

