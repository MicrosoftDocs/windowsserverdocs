---
ms.assetid: d1f03be1-261c-4cb3-ba08-c70e9b29284a
title: Local Administrator Password Solution Getting Started
description: Local Administrator Password Solution Getting Started
author: jsimmons
ms.author: jsimmons
manager: jsimmons
ms.date: 07/04/2022
ms.topic: article
---

# Getting started with Windows LAPS and Active Directory

## Overview

In this article, we're going to go over the basic procedures for using Windows LAPS to back up passwords to Active Directory, and also how to retrieve them.

Let's get started on backing up some passwords to Azure AD!

## Update the Active Directory schema

The Active Directory schema must be updated prior to using Windows LAPS. This action is performed using the `Update-LapsADSchema` cmdlet and is a one-time operation for the entire forest.

```PowerShell
PS C:\> Update-LapsADSchema
```

> [!TIP]
> Pass the -Verbose parameter to see detailed info on what the Update-LapsADSchema cmdlet (or any other cmdlet in the LAPS PowerShell module) is doing.

## Grant the managed device permission to update its password in Active Directory

The managed device needs to be granted permission to update its password. This action is performed by setting inheritable permissions on the Organizational Unit that the device is in. The `Set-LapsADComputerSelfPermission` is used for this purpose, for example:

```PowerShell
PS C:\> Set-LapsADComputerSelfPermission -Identity NewLaps
Name    DistinguishedName
----    -----------------
NewLAPS OU=NewLAPS,DC=laps,DC=com
```

## Remove Extended Rights permissions if necessary

Some users or groups may already be granted Extended Rights permission on the managed device's OU. This permission is problematic because it grants the ability to read confidential attributes (all of the Windows LAPS password attributes are marked as confidential). One way to check who is granted these permissions is by using the `Find-LapsADExtendedRights` cmdlet. For example:

```PowerShell
PS C:\> Find-LapsADExtendedRights -Identity newlaps
ObjectDN                  ExtendedRightHolders
--------                  --------------------
OU=NewLAPS,DC=laps,DC=com {NT AUTHORITY\SYSTEM, LAPS\Domain Admins}
```

In this example we can see that only very privileged entities (SYSTEM, Domain Admins) have the privilege so no other action is required.

## Configure device policy

### Choose policy deployment mechanism

The first step is to choose how you're going to apply policy to your devices.

Most environments will use [LAPS Group Policy](../laps/laps-management-policysettings#laps-group-policy) to deploy the necessary settings to their AD-domain-joined devices.

If your devices are also hybrid-joined to Azure AD, you may deploy policy using [Microsoft Endpoint Manager](https://docs.microsoft.com/mem/endpoint-manager-overview) in combination with the [LAPS CSP](https://docs.microsoft.com/windows/client-management/mdm/laps-csp).

### Configure specific policies

At minimum, you must configure the BackupDirectory setting to the value 2 (backup passwords to Active Directory).

If you don't configure AdministratorAccountName setting, Windows LAPS will default to managing the default built-in local Administrator account. This built-in account is automatically identified by its well-known Relative Identifier (also known as "RID") and should therefore never be identified by name. (The name of the built-in local Administrator account will vary depending on the default locale of the device.)

If you want to configure a custom local admin account, you should configure the AdministratorAccountName setting with the name of that account.

> [!IMPORTANT]
> If you configure Windows LAPS to manage a custom local admin account, you must ensure that the account is created - LAPS does not support creation of the account. Microsoft recommends using the [RestrictedGroups CSP](https://docs.microsoft.com/windows/client-management/mdm/policy-csp-restrictedgroups) for this purpose.

Finally, feel free to configure the other settings as needed or desired, for example PasswordLength, ADPasswordEncryptionEnabled, etc.

## Update the password in Active Directory

Windows LAPS will process the currently active policy on a periodic (every hour) basis, and will also respond to Group Policy change notifications, and will act immediately as needed.

Now look in the event log for 10018 event that verifies that the password was successfully updated in Active Directory.

:::image type="content" source="../laps/laps-scenarios-ad-pwdupdate-event.png" alt-text="Successful Active Directory password update event log message.":::

If there's any delay processing the policy, you can run the `Invoke-LapsPolicyProcessing` PowerShell cmdlet.

## Password retrieval from Active Directory

The `Get-LapsADPassword` cmdlet is used to retrieve passwords from Active Directory, for example:

```PowerShell
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

This output result indicates that we have enabled password encryption (see the Source field). AD password encryption requires that your domain is configured for Windows Server 2016 Domain Functional Level or later.

## Rotating the password

Windows LAPS will read the password expiration time from Active Directory during each policy processing cycle. If the password has expired, a new password will be generated and stored immediately.

In some situations (for example, after a security breach, or for ad-hoc testing purposes) it may be necessary to rotate the password early. To manually force a password rotation, you can use the `Reset-LapsPassword` cmdlet, for example:

You can use the `Set-LapsADPasswordExpirationTime` cmdlet to set the scheduled password expiration time as stored in Active Directory, for example:

```PowerShell
PS C:\> Set-LapsADPasswordExpirationTime -Identity lapsAD2
DistinguishedName                           Status
-----------------                           ------
CN=LAPSAD2,OU=NewLAPS,DC=laps,DC=com PasswordReset
```

The next time the Windows LAPS wakes up to process the current policy, it will see the modified password expiration time and rotate the password. And if you don't feel like waiting, you can run the `Invoke-LapsPolicyProcessing` cmdlet.

Finally, you can also use the `Reset-LapsPassword` cmdlet to locally force an immediate rotation of the password.

## Related articles

[LAPS Concepts](../laps/laps-concepts.md)

[Supported policy settings](../laps/laps-management-policysettings.md)
