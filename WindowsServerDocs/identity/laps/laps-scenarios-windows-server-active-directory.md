---
title: Get started with Windows LAPS and Windows Server Active Directory
description: See how to get started with Windows Local Administrator Password Solution (Windows LAPS) and Windows Server Active Directory.
author: robinharwood
ms.author: roharwoo
ms.date: 04/11/2025
ms.topic: how-to
ms.custom: sfi-image-nochange
# customer intent: As an administrator, I want to see how to get started with Windows Local Administrator Password Solution (Windows LAPS) and Windows Server Active Directory so that I can manage and back up administrator passwords.
---

# Get started with Windows LAPS and Windows Server Active Directory

You can use Windows Local Administrator Password Solution (Windows LAPS) to manage the passwords of local administrator accounts and domain controller Directory Services Restore Mode (DSRM) accounts. This article shows you how to get started with Windows LAPS and Windows Server Active Directory. It describes basic procedures for using Windows LAPS to back up passwords to Windows Server Active Directory and to retrieve them.

## Domain functional level and domain controller operating system version requirements

If your domain functional level (DFL) is earlier than 2016, you can't enable Windows LAPS password encryption. Without password encryption:

- You can configure clients to store passwords only in clear text, secured by Windows Server Active Directory access control lists (ACLs).
- You can't configure domain controllers to manage their local DSRM account.

When your domain uses a DFL of 2016 or later, you can enable Windows LAPS password encryption. However, any Windows Server 2016 and earlier domain controllers that you run don't support Windows LAPS. As a result, those domain controllers can't use the DSRM account management feature.

It's fine to use Windows Server 2016 and earlier supported operating systems on your domain controllers as long as you're aware of these limitations.

The following table summarizes the functionality supported in various scenarios:

|Domain details|Clear-text password storage supported|Encrypted password storage supported (for domain-joined clients) |DSRM account management supported (for domain controllers)|
|--- |--- |--- |--- |
|DFL earlier than 2016|Yes|No|No|
|2016 DFL with one or more Windows Server 2016 or earlier domain controllers|Yes|Yes|Yes but only for Windows Server 2019 and later domain controllers|
|2016 DFL with only Windows Server 2019 and later domain controllers|Yes|Yes|Yes|

We strongly recommend that you upgrade to the latest available operating system on clients, servers, and domain controllers in order to take advantage of the latest features and security improvements.

### Prepare Active Directory

Follow these steps before configuring your Active Directory-joined or hybrid-joined devices to back up a managed account's passwords to Active Directory.

> [!NOTE]
> If you are planning to only backup passwords to Microsoft Entra ID, you do not need to perform any of these steps, including extending the AD schema.

1. If you're using Group Policy Central Store, manually copy the Windows LAPS Group Policy template files to the central store. For more information, see [Configure policy settings for Windows LAPS](laps-management-policy-settings.md#group-policy-object-central-store).
1. Analyze, determine, and configure the appropriate AD permissions for password expiration and password retrieval. See [Windows Server Active Directory passwords](laps-concepts-overview.md#windows-server-active-directory-passwords).
1. Analyze and determine the appropriate authorized groups for decrypting passwords. See [Windows Server Active Directory passwords](laps-concepts-overview.md#windows-server-active-directory-passwords).
1. Create a new Windows LAPS policy that targets the managed device(s) with the appropriate settings as determined in the previous steps.

## Update the Windows Server Active Directory schema

Before you can use Windows LAPS, you must update the Windows Server Active Directory schema. You can perform this action by using the `Update-LapsADSchema` cmdlet. It's a one-time operation for the entire forest. You can run the `Update-LapsADSchema` cmdlet locally on a Windows Server 2019 or later domain controller updated with Windows LAPS. But you can also run this cmdlet on a server that's not a domain controller as long as the server supports the Windows LAPS PowerShell module.

```powershell
PS C:\> Update-LapsADSchema
```

> [!TIP]
> Include the `-Verbose` parameter in the command line to see detailed information about the progress of the cmdlet during processing. You can use the `-Verbose` parameter with any cmdlet in the LAPS PowerShell module.

## Grant the managed device permission to update its password

When you use Windows LAPS to manage a password on a device, that managed device needs to be granted permission to update its password. You can perform this action by setting inheritable permissions on the organizational unit (OU) that contains the device. You can use the `Set-LapsADComputerSelfPermission` cmdlet for this purpose as shown in the following code:

```powershell
PS C:\> Set-LapsADComputerSelfPermission -Identity NewLaps
```

```output
Name    DistinguishedName
----    -----------------
NewLAPS OU=NewLAPS,DC=laps,DC=com
```

> [!TIP]
> If you prefer to set the inheritable permissions on the root of the domain, you can specify the entire domain root by using the distinguished name (DN) input format. For example, you can use the `-Identity` parameter with an argument of `DC=laps,DC=com`.

## Grant password query permissions

Users must be granted permission in order to query the passwords from Active Directory. You can perform this action by setting inheritable permissions on the organizational unit (OU) that contains the device. You can use the `Set-LapsADReadPasswordPermission` cmdlet for this purpose as shown in the following code:

```powershell
PS C:\> Set-LapsADReadPasswordPermission -Identity NewLAPS -AllowedPrincipals @("laps\LapsPasswordReadersGroup")
```

```output
Name    DistinguishedName
----    -----------------
NewLAPS OU=NewLAPS,DC=laps,DC=com
```

> [!TIP]
> Members of the Domain Admins group already have password query permission by default.

> [!TIP]
> When a user is granted permission to query a password from Active Directory that doesn't automatically imply that the user has permission to decrypt an encrypted password. Permission to decrypt an encrypted password is configured using the [`ADPasswordEncryptionPrincipal`](laps-management-policy-settings.md#adpasswordencryptionprincipal) policy setting at the time the device stores the password in Active Directory. The default policy setting for `ADPasswordEncryptionPrincipal` is the Domain Admins group.

## Grant password expiration permissions

Users must be granted permission in order to set the expiration time of passwords stored in Active Directory. When a password is marked as expired in Active Directory, the device will rotate the password at the next processing cycle. Users can use this mechanism to shorten (or extend) the remaining time to the next expected password rotation.

You can perform this action by setting inheritable permissions on the organizational unit (OU) that contains the device. You can use the `Set-LapsADResetPasswordPermission` cmdlet for this purpose as shown in the following code:

```powershell
PS C:\> Set-LapsADResetPasswordPermission -Identity NewLAPS -AllowedPrincipals @("laps\LapsPasswordExpirersGroup")
```

```output
Name    DistinguishedName
----    -----------------
NewLAPS OU=NewLAPS,DC=laps,DC=com
```

> [!TIP]
> Members of the Domain Admins group already have password expiration permission by default.

> [!TIP]
> The `Set-LapsADPasswordExpirationTime` cmdlet can be used to set the password expiration time for a given device in Active Directory, once permissions are granted.

## Query extended rights permissions

Some users or groups might have the extended rights permission on the OU of the managed device. This situation is problematic, because users who have this permission can read confidential attributes, and all the Windows LAPS password attributes are marked as confidential.

You can use the `Find-LapsADExtendedRights` cmdlet to see who has this permission as shown in the following code:

```powershell
PS C:\> Find-LapsADExtendedRights -Identity newlaps
```

```output
ObjectDN                  ExtendedRightHolders
--------                  --------------------
OU=NewLAPS,DC=laps,DC=com {NT AUTHORITY\SYSTEM, LAPS\Domain Admins}
```

In the output, only the trusted entities SYSTEM and Domain Admins have the permission. No other action is required in this case.

## Configure device policy

The following sections show you how to configure the device policy.

### Choose a policy deployment mechanism

The first step is to choose how to apply policy on your devices.

Most environments use [Windows LAPS Group Policy](laps-management-policy-settings.md#windows-laps-group-policy) to deploy the required settings to their Windows Server Active Directory-domain-joined devices.

If your devices are also hybrid-joined to Microsoft Entra ID, you can deploy policy by using [Microsoft Intune](/intune/intune-service/) with the [Windows LAPS configuration service provider (CSP)](/windows/client-management/mdm/laps-csp).

### Configure specific policies

At a minimum, you must configure the `BackupDirectory` setting by assigning it the value `2`. This value is used to back up passwords to Windows Server Active Directory.

If you don't configure the `AdministratorAccountName` setting, Windows LAPS manages the default built-in local administrator account by default. This built-in account is automatically identified by using its well-known relative identifier (RID). It should never be identified by using its name. The name of the built-in local administrator account varies depending on the default locale of the device.

If you want to configure a custom local administrator account, you should configure the `AdministratorAccountName` setting with the name of that account.

> [!IMPORTANT]
> If you configure Windows LAPS to manage a custom local administrator account, you must ensure that the account is created. Windows LAPS doesn't create the account. We recommend that you use the [RestrictedGroups CSP](/windows/client-management/mdm/policy-csp-restrictedgroups) to create the account.

You can configure other settings, like `PasswordLength`, as needed for your organization.

When you don't configure a given setting, the default value is applied. Make sure you understand the default values of settings. For example, if you enable password encryption but don't configure the `ADPasswordEncryptionPrincipal` setting, the password is encrypted so that only Domain Admins can decrypt it. You can configure `ADPasswordEncryptionPrincipal` with a different setting if you want users besides Domain Admins to be able to decrypt it.

## Update a password in Windows Server Active Directory

Windows LAPS processes the active policy every hour. You can also start the processing cycle manually, because Windows LAPS responds to Group Policy change notifications.

To verify that a password is successfully updated in Windows Server Active Directory, look in the event log for an event with ID 10018:

:::image type="content" source="./media/laps-scenarios-windows-server-active-directory/laps-scenarios-windows-server-active-directory-password-update-event.png" alt-text="Screenshot of the event log. An event with ID 10018 is selected. Its log shows a password was successfully updated in Windows Server Active Directory.":::

To avoid waiting after you apply the policy, you can run the `Invoke-LapsPolicyProcessing` PowerShell cmdlet to process the policy immediately.

## Retrieve a password from Windows Server Active Directory

You can use the `Get-LapsADPassword` cmdlet to retrieve passwords from Windows Server Active Directory, as shown in the following code:

```powershell
PS C:\> Get-LapsADPassword -Identity lapsAD2 -AsPlainText
```

```output
ComputerName        : LAPSAD2
DistinguishedName   : CN=LAPSAD2,OU=NewLAPS,DC=laps,DC=com
Account             : Administrator
Password            : <password>
PasswordUpdateTime  : 7/1/2022 1:23:19 PM
ExpirationTimestamp : 7/31/2022 1:23:19 PM
Source              : EncryptedPassword
DecryptionStatus    : Success
AuthorizedDecryptor : LAPS\Domain Admins
```

In this output, the `Source` line indicates that password encryption is enabled. Password encryption requires that your domain is configured for a Windows Server 2016 or later DFL.

If you're denied access to query the password, you can adjust the password read permissions. See [Grant password query permissions](#grant-password-query-permissions).

## Rotate a password

Windows LAPS reads the password expiration time from Windows Server Active Directory during each policy processing cycle. If the password is expired, a new password is generated and stored immediately.

In some situations, you might want to rotate the password early, for instance, after a security breach or during impromptu testing. To manually force a password rotation, you can use the `Reset-LapsPassword` cmdlet.

You can use the `Set-LapsADPasswordExpirationTime` cmdlet to set the scheduled password expiration time stored in Windows Server Active Directory. The following code sets the expiration time to the current time:

```powershell
PS C:\> Set-LapsADPasswordExpirationTime -Identity lapsAD2
```

```output
DistinguishedName                           Status
-----------------                           ------
CN=LAPSAD2,OU=NewLAPS,DC=laps,DC=com PasswordReset
```

The next time Windows LAPS processes the current policy, it sees the modified password expiration time and rotates the password. If you don't want to wait for the next processing cycle, you can run the `Invoke-LapsPolicyProcessing` cmdlet to process the policy immediately.

You can use the `Reset-LapsPassword` cmdlet to locally force an immediate rotation of the password.

## Retrieve passwords during Windows Server Active Directory disaster recovery scenarios

To retrieve Windows LAPS passwords (including DSRM passwords), you normally need at least one Windows Server Active Directory domain controller to be available. In a catastrophic scenario, all the domain controllers in a domain might be down. How do you recover passwords in that situation?

Best practices for the management of Windows Server Active Directory advise regularly backing up all domain controllers. You can query Windows LAPS passwords stored in a mounted backup Windows Server Active Directory database by using the `Get-LapsADPassword` PowerShell cmdlet and specifying the `-Port` parameter.

In Windows Insider build 27695 and later, the `Get-LapsADPassword` cmdlet offers improved password retrieval capabilities. Specifically, when you use the `Get-LapsADPassword` cmdlet and specify both the `-Port` and `-RecoveryMode` parameters, password recovery succeeds with no need to contact a domain controller. Also, you can run `Get-LapsADPassword` in this mode on a workgroup (non-domain-joined) machine. This functionality is available in client and server operating systems.

> [!TIP]
> You can use the `dsamain.exe` utility to mount Windows Server Active Directory backup media and query it over Lightweight Directory Access Protocol (LDAP). The `dsamain.exe` tool isn't installed by default, so it has to be added. You can use the `Enable-WindowsOptionalFeature` cmdlet to enable it.
>
> - On Windows Client machines, you can run `Enable-WindowsOptionalFeature -Online -FeatureName DirectoryServices-ADAM-Client`.
> - On a Windows Server machine, you can run `Enable-WindowsOptionalFeature -Online -FeatureName DirectoryServices-ADAM`.

The following code queries Windows LAPS passwords that are stored in a Windows Server Active Directory backup database that's locally mounted on port 50000:

```powershell
PS C:\> Get-LapsADPassword -Identity lapsDC -AsPlainText -Port 50000 -RecoveryMode
```

```output
ComputerName        : LAPSDC
DistinguishedName   : CN=LAPSDC,OU=Domain Controllers,DC=laps,DC=com
Account             : Administrator
Password            : <password>
PasswordUpdateTime  : 8/15/2024 10:31:51 AM
ExpirationTimestamp : 9/14/2024 10:31:51 AM
Source              : EncryptedDSRMPassword
DecryptionStatus    : Success
AuthorizedDecryptor : S-1-5-21-2127521184-1604012920-1887927527-35197
```

> [!IMPORTANT]
> When encrypted Windows LAPS passwords are retrieved from a Windows Server Active Directory backup database that's mounted on a workgroup machine, the `AuthorizedDecryptor` field is always displayed in raw security identifier (SID) format. The workgroup machine is unable to translate the SID into a friendly name.

## See also

- [Introducing Windows Local Administrator Password Solution with Microsoft Entra ID (Azure AD)](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/introducing-windows-local-administrator-password-solution-with-microsoft-entra-a/1942487)
- [Windows Local Administrator Password Solution in Microsoft Entra ID](https://aka.ms/cloudlaps)
- [RestrictedGroups CSP](/windows/client-management/mdm/policy-csp-restrictedgroups)
- [Microsoft Intune](/intune/intune-service/)
- [Microsoft Intune support for Windows LAPS](/intune/intune-service/protect/windows-laps-overview)
- [Windows LAPS CSP](/windows/client-management/mdm/laps-csp)
- [Windows LAPS troubleshooting guidance](/troubleshoot/windows-server/windows-security/windows-laps-troubleshooting-guidance)

## Next steps

- [Configure policy settings for Windows LAPS](laps-management-policy-settings.md)
- [Use Windows LAPS event logs](laps-management-event-log.md)
- [Use Windows LAPS PowerShell cmdlets](laps-management-powershell.md)
- [Key concepts in Windows LAPS](laps-concepts-overview.md)


