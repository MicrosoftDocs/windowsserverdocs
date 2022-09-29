---
title: Get started with Windows LAPS and Windows Server Active Directory
description: Learn how to get started with Windows Local Administrator Password Solution (Windows LAPS) and Windows Server Active Directory.
author: jay98014
ms.author: jsimmons
ms.date: 07/04/2022
ms.topic: conceptual
---

# Get started with Windows LAPS and Windows Server Active Directory

Learn how to get started with Windows Local Administrator Password Solution (Windows LAPS) and Windows Server Active Directory. The article describes the basic procedures for using Windows LAPS to back up passwords to Windows Server Active Directory and how to retrieve them.

> [!IMPORTANT]
> Windows LAPS currently is available only in Windows 11 Insider Preview Build 25145 and later. Support for the Windows LAPS Azure Active Directory scenario currently is limited to a small group of Windows Insider users.

## Update the Windows Server Active Directory schema

The Windows Server Active Directory schema must be updated prior to using Windows LAPS. This action is performed by using the `Update-LapsADSchema` cmdlet. It's a one-time operation for the entire forest.

```powershell
PS C:\> Update-LapsADSchema
```

> [!TIP]
> Pass the `-Verbose` parameter to see detailed info on what the `Update-LapsADSchema` cmdlet (or any other cmdlet in the LAPS PowerShell module) is doing.

## Grant the managed device permission to update its password

The managed device needs to be granted permission to update its password. This action is performed by setting inheritable permissions on the Organizational Unit (OU) the device is in. The `Set-LapsADComputerSelfPermission` is used for this purpose, for example:

```powershell
PS C:\> Set-LapsADComputerSelfPermission -Identity NewLaps
```

```output
Name    DistinguishedName
----    -----------------
NewLAPS OU=NewLAPS,DC=laps,DC=com
```

## Remove Extended Rights permissions

Some users or groups might already be granted Extended Rights permission on the managed device's OU. This permission is problematic because it grants the ability to read confidential attributes (all of the Windows LAPS password attributes are marked as confidential). One way to check to see who is granted these permissions is by using the `Find-LapsADExtendedRights` cmdlet. For example:

```powershell
PS C:\> Find-LapsADExtendedRights -Identity newlaps
```

```output
ObjectDN                  ExtendedRightHolders
--------                  --------------------
OU=NewLAPS,DC=laps,DC=com {NT AUTHORITY\SYSTEM, LAPS\Domain Admins}
```

In the output in this example, only trusted entities (SYSTEM and Domain Admins) have the privilege. No other action is required.

## Configure device policy

Complete a few steps to configure the device policy.

### Choose a policy deployment mechanism

The first step is to choose how you're going to apply policy to your devices.

Most environments use [Windows LAPS Group Policy](laps-management-policy-settings.md#windows-laps-group-policy) to deploy the required settings to their Windows Server Active Directory-domain-joined devices.

If your devices are also hybrid-joined to Azure Active Directory, you can deploy policy by using [Microsoft Endpoint Manager](/mem/endpoint-manager-overview) in combination with the [Windows LAPS CSP](/windows/client-management/mdm/laps-csp).

### Configure specific policies

At minimum, you must configure the BackupDirectory setting to the value 2 (backup passwords to Windows Server Active Directory).

If you don't configure the AdministratorAccountName setting, Windows LAPS defaults to managing the default built-in local Administrator account. This built-in account is automatically identified by its well-known Relative Identifier (also known as "RID") and should therefore never be identified by name. (The name of the built-in local Administrator account will vary depending on the default locale of the device.)

If you want to configure a custom local admin account, you should configure the AdministratorAccountName setting with the name of that account.

> [!IMPORTANT]
> If you configure Windows LAPS to manage a custom local admin account, you must ensure that the account is created - LAPS does not support creation of the account. Microsoft recommends using the [RestrictedGroups CSP](/windows/client-management/mdm/policy-csp-restrictedgroups) for this purpose.

Finally, feel free to configure the other settings as needed or desired, for example PasswordLength, ADPasswordEncryptionEnabled, etc.

## Update the password in the directory

Windows LAPS processes the currently active policy on a periodic (every hour) basis and responds to Group Policy change notifications. It responds based on the policy and change notifications.

Next, look in the event log for 10018 event. This event verifies that the password was successfully updated in Windows Server Active Directory.

:::image type="content" source="../laps/media/laps-scenarios-windows-server-active-directory/laps-scenarios-windows-server-active-directory-password-update-event.png" alt-text="Screenshot of the event log showing a successful Windows Server Active Directory password update event log message.":::

If there's any delay processing the policy, you can run the `Invoke-LapsPolicyProcessing` PowerShell cmdlet.

## Retrieve a password from the directory

The `Get-LapsADPassword` cmdlet is used to retrieve passwords from Windows Server Active Directory. For example:

```powershell
PS C:\> Get-LapsADPassword -Identity lapsAD2 -AsPlainText
ComputerName        : LAPSAD2
DistinguishedName   : CN=LAPSAD2,OU=NewLAPS,DC=laps,DC=com
Account             : Administrator
Password            : Zlh+lzC[0e0/VU
PasswordUpdateTime  : 7/1/2022 1:23:19 PM
ExpirationTimestamp : 7/31/2022 1:23:19 PM
Source              : EncryptedPassword
DecryptionStatus    : Success
AuthorizedDecryptor : LAPS\Domain Admins
```

This output result indicates that we have enabled password encryption (see the Source field). Password encryption requires that your domain is configured for Windows Server 2016 Domain Functional Level or later.

## Rotate the password

Windows LAPS reads the password expiration time from Windows Server Active Directory during each policy processing cycle. If the password has expired, a new password is generated and stored immediately.

In some situations (for example, after a security breach, or for ad-hoc testing purposes) it may be necessary to rotate the password early. To manually force a password rotation, you can use the `Reset-LapsPassword` cmdlet.

You can use the `Set-LapsADPasswordExpirationTime` cmdlet to set the scheduled password expiration time as stored in Windows Server Active Directory. For example:

```powershell
PS C:\> Set-LapsADPasswordExpirationTime -Identity lapsAD2
```

```output
DistinguishedName                           Status
-----------------                           ------
CN=LAPSAD2,OU=NewLAPS,DC=laps,DC=com PasswordReset
```

The next time the Windows LAPS wakes up to process the current policy, it sees the modified password expiration time and rotate the password. If you don't want to wait, you can run the `Invoke-LapsPolicyProcessing` cmdlet.

Finally, you can use the `Reset-LapsPassword` cmdlet to locally force an immediate rotation of the password.

## See also

- [Windows LAPS concepts](../laps/laps-concepts.md)
- [Windows LAPS policy settings](../laps/laps-management-policy-settings.md)
- [RestrictedGroups CSP](/windows/client-management/mdm/policy-csp-restrictedgroups)
- [Windows LAPS CSP](/windows/client-management/mdm/laps-csp)
- [Microsoft Endpoint Manager](/mem/endpoint-manager-overview)

## Next steps

- Review [Windows LAPS concepts](../laps/laps-concepts.md).
