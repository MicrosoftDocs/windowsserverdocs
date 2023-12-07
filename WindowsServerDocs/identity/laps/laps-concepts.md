---
title: Key concepts in Windows LAPS
description: Review basic design and security concepts for Windows Local Administrator Password Solution (Windows LAPS).
author: jay98014
ms.author: jsimmons
ms.date: 07/04/2022
ms.topic: conceptual
---

# Key concepts in Windows LAPS

Learn about the basic design and security concepts for Windows Local Administrator Password Solution (Windows LAPS), including:

- Architecture
- Basic scenario flow
- Background policy processing cycle
- Microsoft Entra passwords
- Windows Server Active Directory passwords
- Password reset after authentication
- Account password tampering protection
- Windows safe mode

> [!IMPORTANT]
> For more information on specific OS updates required to use the Windows LAPS feature, and the current status of the Microsoft Entra LAPS scenario, see [Windows LAPS availability and Microsoft Entra LAPS public preview status](laps-overview.md).

## Windows LAPS architecture

The following figure depicts the Windows LAPS architecture:

:::image type="content" source="./media/laps-concepts/laps-concepts-architecture-diagram.png" border="false" alt-text="Diagram of Windows LAPS architecture that shows the managed device, Microsoft Entra ID, and Windows Server Active Directory.":::

The Windows LAPS architecture diagram has several key components:

- **IT admin**: Represents collectively the various IT admin roles that might be involved in a Windows LAPS deployment. The IT admin roles are involved with policy configuration, expiration or retrieval of stored passwords, and interacting with managed devices.

- **Managed device**: Represents a Microsoft Entra joined or Windows Server Active Directory-joined device on which you want to manage a local administrator account. The feature is composed of a few key binaries: *laps.dll* for core logic, *lapscsp.dll* for configuration service provider (CSP) logic, and *lapspsh.dll* for PowerShell cmdlet logic. You also can configure Windows LAPS by using Group Policy. Windows LAPS responds to Group Policy Object (GPO) change notifications. The managed device can be a Windows Server Active Directory domain controller and be configured to back up Directory Services Repair Mode (DSRM) account passwords.

- **Windows Server Active Directory**: An on-premises Windows Server Active Directory deployment.

- **Microsoft Entra ID**: a Microsoft Entra deployment running in the cloud.

- **Microsoft Intune** The preferred Microsoft device policy management solution, also running in the cloud.

## Basic scenario flow

The first step in a basic Windows LAPS scenario is to configure the Windows LAPS policy for your organization. We recommend that you use the following configuration options:

- **Microsoft Entra joined devices**: Use [Microsoft Intune](/mem/intune).

- **Windows Server Active Directory-joined devices**: Use Group Policy.

- **Microsoft Entra hybrid joined devices that are enrolled with Microsoft Intune**: Use [Microsoft Intune](/mem/intune).

After the managed device is configured with a policy that enables Windows LAPS, the device begins to manage the configured local account password. When the password expires, the device generates a new, random password that's compliant with the current policy's length and complexity requirements. The password is validated against the local device's password complexity policy.

When a new password is validated, the device stores the password in the configured directory, either Windows Server Active Directory or Microsoft Entra ID. An associated password expiration time that's based on the current policy's password age setting also is computed and stored in the directory. The device rotates the password automatically when the password expiration time is reached.

When the local account password is stored in the relevant directory, an authorized IT admin can access the password. Passwords that are stored in Microsoft Entra ID are secured via a role-based access control model. Passwords that are stored in Windows Server Active Directory are secured via access control lists (ACLs) and also optionally via password encryption.

You can rotate the password before the normally expected expiration time. Rotate a password before a scheduled expiration by using one of the following methods:

- Manually intervene on the managed device itself by using an admin account. For example, you can use the `Reset-LapsPassword` cmdlet.
- Invoke the ResetPassword Execute action in the [Windows LAPS CSP](/windows/client-management/mdm/laps-csp).
- Modify the password expiration time in the directory (applies only to Windows Server Active Directory).
- Trigger automatic rotation when the managed account is used to authenticate to the managed device.

## Background policy processing cycle

Windows LAPS uses a background task that wakes up every hour to process the currently active policy. This task isn't implemented by using Windows Task Scheduler.

When the background task runs, it executes the following basic flow:

:::image type="content" source="./media/laps-concepts/laps-concepts-processing-cycle.png" border="false" alt-text="Diagram of a flowchart that describes the Windows LAPS background processing cycle.":::

The obvious key difference between the Microsoft Entra ID flow and the Windows Server Active Directory flow is related to how password expiration time is checked. In both scenarios, password expiration time is stored side-by-side with the latest password in the directory.

In the Microsoft Entra scenario, the managed device doesn't poll Microsoft Entra ID. Instead, the current password expiration time is maintained locally on the device.

In the Windows Server Active Directory scenario, the managed device regularly polls the directory to query the password expiration time, and it acts when the password expires.

### Manually start the policy processing cycle

Windows LAPS does respond to Group Policy change notifications. You can manually start the policy processing cycle in two ways:

- Force a Group Policy refresh. Here's an example:

   ```powershell
   gpupdate.exe /target:computer /force
   ```

- Run the `Invoke-LapsPolicyProcessing` cmdlet. This method is preferred because it's more scoped.

> [!TIP]
> The earlier released Microsoft LAPS (legacy Microsoft LAPS) was built as a Group Policy (GPO) Client Side Extension (CSE). GPO CSEs are loaded and invoked in every Group Policy refresh cycle. The frequency of the legacy Microsoft LAPS polling cycle is the same as the frequency of the Group Policy refresh cycle. Windows LAPS is not built as a CSE, so its polling cycle is hard-coded to once per hour. Windows LAPS is not affected by the Group Policy refresh cycle.

<a name='azure-active-directory-passwords'></a>

## Microsoft Entra passwords

When you back up passwords to Microsoft Entra ID, managed local account passwords are stored on the Microsoft Entra device object. Windows LAPS authenticates to Microsoft Entra ID by using the device identity of the managed device. Data that's stored in Microsoft Entra ID is highly secure, but for extra protection, the password is further encrypted before it's persisted. This extra encryption layer is removed before the password is returned to authorized clients.

By default, only members of the Global Administrator, Cloud Device Administrator, and Intune Administrator roles can retrieve the clear-text password.

## Windows Server Active Directory passwords

The following sections give you important information about using Windows LAPS with Windows Server Active Directory.

### Password security

When you back up passwords to Windows Server Active Directory, managed local account passwords are stored on the computer object. Windows LAPS secures these passwords by using two mechanisms:

- ACLs
- Encrypted passwords

#### ACLs

The first line of password security in Windows Server Active Directory uses ACLs that are set up on the computer object that contains an Organizational Unit (OU). The ACLs are inherited to the computer object itself. You can specify who can read various password attributes by using the `Set-LapsADReadPasswordPermission` cmdlet. Similarly, you can specify who can read and set the password expiration time attribute by using the `Set-LapsADResetPasswordPermission` cmdlet.

#### Encrypted passwords

The second line of password security uses the Windows Server Active Directory password encryption feature. To use Windows Server Active Directory password encryption, your domain must run at the Windows Server 2016 Domain Functional Level (DFL) or later. When enabled, the password is first encrypted so that only a specific security principal (a group or user) can decrypt it. The password encryption occurs on the managed device itself before the device sends the password to the directory.

> [!IMPORTANT]
>
> - We highly recommend that you enable password encryption when you store your Windows LAPS passwords in Windows Server Active Directory.
> - Microsoft doesn't support retrieval of previously decrypted LAPS passwords in a domain running a DFL earlier than the Windows Server 2016 DFL. The operation might or might not succeed depending on whether domain controllers running versions earlier than Windows Server 2016 were promoted into the domain.

### User group permissions

When you design your password retrieval security model, consider the information in the following figure:

:::image type="content" source="./media/laps-concepts/laps-concepts-password-security-layers.png" border="false" alt-text="Diagram that shows the Windows LAPS password security layers.":::

The diagram illustrates the suggested Windows Server Active Directory password security layers and their relationship to each other.

The outermost circle (green) is composed of security principals that have been granted permission to read or set the password expiration time attribute on computer objects in the directory. This ability is a sensitive permission but is considered nondestructive. An attacker who acquires this permission can force managed devices to rotate their managed devices more frequently.

The middle circle (yellow) is composed of security principals that have been granted permission to read or set password attributes on computer objects in the directory. This ability is a sensitive permission and should be carefully monitored. The most secure approach is to reserve this level of permission for members of the Domain Admins security group.

The inner circle (red) applies only when password encryption is enabled. It's composed of groups or users that have been granted decryption permissions for encrypted password attributes on computer objects in the directory. Like the permission in the middle circle, this ability is a sensitive permission and should be carefully monitored. The most secure approach is to reserve this level of permission for members of the Domain Admins group.

> [!IMPORTANT]
> Consider customizing your security layers to match the sensitivity of the managed machines in your organization. For example, it might be acceptable for front-line IT worker devices to be accessible to help desk administrators, but you likely will want to set tighter boundaries for corporate executive laptops.

### Password encryption

The Windows LAPS password encryption feature is based on the [Cryptography API: Next Generation Data Protection API (CNG DPAPI)](/windows/win32/seccng/cng-dpapi). CNG DPAPI supports multiple encryption modes, but Windows LAPS supports encrypting passwords against only a single Windows Server Active Directory security principal (user or group). The underlying encryption is based on Advanced Encryption Standard 256-bit key (AES-256) encryption.

You can use the ADPasswordEncryptionPrincipal policy setting to set a specific security principal for encrypting the password. If ADPasswordEncryptionPrincipal isn't specified, Windows LAPS encrypts the password against the Domain Admins group of the managed device's domain. Before a managed device encrypts a password, the device always verifies that the specified user or group is resolvable.

> [!TIP]
>
> - Windows LAPS supports encrypting passwords against only a single security principal. CNG DPAPI does support encryption against multiple security principals, but this mode isn't supported by Windows LAPS because it causes size bloat of the encrypted password buffers. If you need to grant decryption permissions to multiple security principals, to resolve the constraint, you can create a wrapper group that has all the relevant security principals as members.
> - The security principal that's authorized to decrypt the password can't be changed after a password is encrypted.

### Encrypted password history

Windows LAPS supports a password history feature for Windows Server Active Directory domain-joined clients and domain controllers. Password history is supported only when password encryption is enabled. Password history isn't supported if you store clear-text passwords in Windows Server Active Directory.

When encrypted password history is enabled and it's time to rotate the password, the managed device first reads the current version of the encrypted password from Windows Server Active Directory. The current password is then added to the password history. Earlier versions of the password in the history are deleted as needed to comply with the configured maximum history limitation.

> [!TIP]
> For the password history feature to work, the managed device must be granted SELF permissions to read the current version of the encrypted password from Windows Server Active Directory. This requirement is handled automatically when you run the `Set-LapsADComputerSelfPermission` cmdlet.

> [!IMPORTANT]
> We recommend that you never grant permissions to a managed device to decrypt an encrypted password for any device, including for the device itself.

### DSRM password support

Windows LAPS supports backing up the DSRM account password on Windows Server domain controllers. DSRM account passwords can be backed up only to Windows Server Active Directory and if password encryption is enabled. Otherwise, this feature works almost identically to how encrypted password support works for Windows Server Active Directory-joined clients. 

Backing up DSRM passwords to Microsoft Entra ID isn't supported.

> [!IMPORTANT]
> When DSRM password backup is enabled, the current DSRM password for any domain controller is retrievable if at least one domain controller in that domain is accessible.
>
> But consider a catastrophic scenario in which all the domain controllers in a domain are down. In this scenario, no DSRM passwords will be available. For this reason, we recommend that you use Windows LAPS DSRM support as only the first component of a larger domain backup and recovery strategy. We strongly recommend that DSRM passwords be regularly extracted from the directory and backed up to a secure store outside Windows Server Active Directory. Windows LAPS doesn't include an external store backup strategy.

## Password reset after authentication

Windows LAPS supports automatically rotating the local administrator account password if it detects that the local administrator account was used for authentication. This feature is intended to bound the amount of time that the clear-text password is usable. You can configure a grace period to give a user time to complete their intended actions.

Password reset after authentication isn't supported for the DSRM account on domain controllers.

## Account password tampering protection

When Windows LAPS is configured to manage a local administrator account password, that account is protected against accidental or careless tampering. This protection extends to the DSRM account when the account is managed by Windows LAPS on a Windows Server Active Directory domain controller.

Windows LAPS rejects unexpected attempts to modify the account's password with a `STATUS_POLICY_CONTROLLED_ACCOUNT` (0xC000A08B) or `ERROR_POLICY_CONTROLLED_ACCOUNT` (0x21CE\8654) error. Each such rejection is noted with a 10031 event in the Windows LAPS event log channel.

## Disabled in Windows safe mode

When Windows is started in safe mode, DSRM mode, or in any other non-default boot mode, Windows LAPS is disabled and no passwords are backed up.

## Windows LAPS integration with smart card policy

The Windows LAPS-managed account is exempted when the "Interactive logon: Require Windows Hello for Business or smart card" policy (also known as SCForceOption) is enabled. See [Additional smart card Group Policy settings and registry keys](/windows/security/identity-protection/smart-cards/smart-card-group-policy-and-registry-settings#additional-smart-card-group-policy-settings-and-registry-keys).

Windows LAPS integration with the smart-card-auth-only policy is available on the following OS platforms with the specified update or later installed:

- [Windows 11 22H2 - October 10 2023 Update](https://support.microsoft.com/help/5031354)
- [Windows 11 21H2 - October 10 2023 Update](https://support.microsoft.com/help/5031358)
- [Windows 10 - October 10 2023 Update](https://support.microsoft.com/help/5031356)
- [Windows Server 2022 - October 10 2023 Update](https://support.microsoft.com/help/5031364)
- [Windows Server 2019 - October 10 2023 Update](https://support.microsoft.com/help/5031361)

## See also

- [Legacy Microsoft LAPS](https://www.microsoft.com/download/details.aspx?id=46899)
- [CNG DPAPI](/windows/win32/seccng/cng-dpapi)
- [Microsoft Intune](/mem/intune)

## Next steps

Now that you understand the basic concepts of the Windows LAPS design, get started with one of the following scenarios:

- [Get started with Windows LAPS for Windows Server Active Directory](laps-scenarios-windows-server-active-directory.md)
- [Get started with Windows LAPS for Microsoft Entra ID](laps-scenarios-azure-active-directory.md)
- [Get started with Windows LAPS in legacy Microsoft LAPS emulation mode](laps-scenarios-legacy.md)
