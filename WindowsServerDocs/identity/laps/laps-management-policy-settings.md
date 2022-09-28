---
title: Windows Local Administrator Password Solution (Windows LAPS) policy settings
description: Learn about Windows Local Administrator Password Solution (Windows LAPS) policy settings.
author: jay98014
ms.author: jsimmons
ms.date: 07/04/2022
ms.topic: article
---

# Windows LAPS policy settings

Windows Local Administrator Password Solution (Windows LAPS) supports various settings you can control by using policy. Learn about the settings and how to administer them.

> [!IMPORTANT]
> Windows LAPS currently is available only in Windows 11 Insider Preview Build 25145 and later. Support for the Windows LAPS Azure Active Directory scenario currently is limited to a small group of Windows Insider users.

## Supported policy roots

Although we don't recommend it, you can administer a device by using multiple policy management mechanisms. To support this scenario in an understandable and predictable way, each Windows LAPS policy mechanism is assigned a distinct registry root key:

|Policy name|Policy registry key root|
|---|---|
|LAPS CSP|HKLM\Software\Microsoft\Policies\LAPS|
|LAPS Group Policy|HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\LAPS|
|LAPS Local Configuration|HKLM\Software\Microsoft\Windows\CurrentVersion\LAPS\Config|
|Microsoft LAPS|HKLM\Software\Policies\Microsoft Services\AdmPwd|

Windows LAPS queries all known registry key policy roots starting at the top and moving down. If no settings are found under a specific root, that root is skipped and the query proceeds to the next root. When a root that has at least one explicitly defined setting is found, that root is used as the active policy. If the chosen root is missing any settings, the settings are assigned their default values.

> [!IMPORTANT]
> Policy settings are never shared or inherited across policy key roots.

> [!TIP]
> The LAPS Local Configuration key is listed for completeness. You can use this key if necessary, but the key primarily is intended to be used for testing and development. No management tools or policy mechanisms target this key.

## Supported policy settings by join state

Windows LAPS supports multiple policy settings that you can administer via various policy management solutions, or even directly via the registry.

The following table specifies which settings are applicable on devices that have the specified join state:

|Setting name|Azure Active Directory-joined|Hybrid-joined|Windows Server Active Directory-joined|
|---|---|---|---|
|BackupDirectory|Yes|Yes|Yes|
|PasswordAgeDays|Yes|Yes|Yes|
|PasswordLength|Yes|Yes|Yes|
|PasswordComplexity|Yes|Yes|Yes|
|PasswordExpirationProtectionEnabled|No|Yes|Yes|
|AdministratorAccountName|Yes|Yes|Yes|
|ADPasswordEncryptionEnabled|No|Yes|Yes|
|ADPasswordEncryptionPrincipal|No|Yes|Yes|
|ADEncryptedPasswordHistorySize|No|Yes|Yes|
|ADBackupDSRMPassword|No|No|Yes|
|PostAuthenticationResetDelay|Yes|Yes|Yes|
|PostAuthenticationActions|Yes|Yes|Yes|

You can administer almost all settings by using any policy management mechanism. The [Windows LAPS CSP](/windows/client-management/mdm/laps-csp) has two exceptions to this rule. The Windows LAPS CSP supports two settings that aren't in the preceding table: ResetPassword and ResetPasswordStatus. The Windows LAPS CSP doesn't support the ADBackupDSRMPassword setting (domain controllers are never managed via CSP). For more information, see the LAPS CSP documentation for more info.

## LAPS Group Policy

Windows LAPS includes a new Group Policy Object that you can use to administer policy settings on Active Directory domain-joined devices. To access the Windows LAPS Group Policy, in Group Policy Management Editor, go to **Computer Configuration** > **Administrative Templates** > **System** > **LAPS**. The following figure shows an example:

:::image type="content" source="../laps/media/laps-management-policy-settings/laps-management-policy-settings-group-policy-editor.png" alt-text="Screenshot of the Group Policy Management Editor that shows the Windows LAPS policy settings.":::

## LAPS CSP

Windows LAPS includes a new CSP that you can use to administer policy settings on Azure Active Directory-joined devices. Manage the [Windows LAPS CSP](/windows/client-management/mdm/laps-csp) by using [Microsoft Endpoint Manager](/mem/endpoint-manager-overview).

## Policy settings

This section how to use and apply various policy settings for Windows LAPS.

### BackupDirectory

Use this setting to control which directory the password for the managed account is backed up to.

|Value|Description of setting|
|--- |--- |
|0|Disabled (password won't be backed up)|
|1|Back up the password to Azure Active Directory only|
|2|Back up the password to Windows Server Active Directory only|

If not specified, this setting defaults to 0 (Disabled).

### PasswordAgeDays

This setting controls the length of the password. Supported values are:

- **Minimum**: 1 day (When the backup directory is configured to be Azure Active Directory, the minimum is 7 days.)
- **Maximum**: 365 days

If not specified, this setting defaults to 30 days.

### PasswordLength

Use this setting to configure the length of the password of the managed local administrator account. Supported values are:

- **Minimum**: 8 characters
- **Maximum**: 64 characters

If not specified, this setting defaults to 14 characters.
  
### PasswordComplexity

Use this setting to configure the required password complexity of the managed local administrator account.

|Value|Description of setting|
|--- |--- |
|1|Large letters|
|2|Large letters + small letters|
|3|Large letters + small letters + numbers|
|4|Large letters + small letters + numbers + special characters|

If not specified, this setting defaults to 4.

> [!IMPORTANT]
> Windows supports the lower password complexity settings (1, 2, and 3) only for backward compatibility with earlier versions of Microsoft LAPS. We recommend that you always configure this setting to 4.

### PasswordExpirationProtectionEnabled

Use this setting to configure enforcement of maximum password age for the managed local administrator account.

Supported values are either 1 (True) or 0 (False).

If not specified, this setting defaults to 1 (True).

> [!TIP]
> In Microsoft LAPS mode, this setting defaults to False for backward compatibility.

### AdministratorAccountName

Use this setting to configure the name of the managed local administrator account.

If not specified, this setting defaults to managing the built-in local administrator account.

> [!IMPORTANT]
> Don't specify this setting unless you want to manage an account other than the built-in local administrator account. The local administrator account is automatically identified by its well-known relative identifier (RID).

### ADPasswordEncryptionEnabled

Use this setting to enable encryption of passwords in Active Directory.

Supported values are either 1 (True) or 0 (False).

> [!IMPORTANT]
> Enabling this setting requires that your Active Directory domain be running at Domain Functional Level 2016 or later.

### ADPasswordEncryptionPrincipal

Use this setting to configure the name or security identifier (SID) of a user or group that can decrypt the password that's stored in Active Directory.

This setting is ignored if the password currently is stored in Azure.

If not specified, only members of the Domain Admins group in the device's domain can decrypt the password.

If specified, the specified user or group can decrypt the password that's stored in Active Directory.

> [!IMPORTANT]
> The string that's stored in this setting must be either an SID in string form or the fully qualified name of a user or group. Valid examples include:
>
> - `S-1-5-21-2127521184-1604012920-1887927527-35197`
> - `contoso\LAPSAdmins`
> - `lapsadmins@contoso.com`
>
> The principal identified (either by SID or by user or group name) must exist and be resolvable by the device.
>
> This setting is ignored unless ADPasswordEncryptionEnabled is configured to True and all other prerequisites are met.
>
> This setting is ignored when DSRM account passwords are backed up on a domain controller. In that scenario, this setting always defaults to the Domain Admins group of the domain controller's domain.

### ADEncryptedPasswordHistorySize

Use this setting to configure how many previous encrypted passwords is remembered in Active Directory. Supported values are:

- **Minimum** : 0 passwords
- **Maximum**: 12 passwords

If not specified, this setting defaults to 0 passwords (disabled).

> [!IMPORTANT]
> This setting is ignored unless ADPasswordEncryptionEnabled is configured to True and all other prerequisites are met.
>
> This setting also takes effect on on domain controllers that back up their DSRM passwords.

### ADBackupDSRMPassword

Use this setting to enable backup of the DSRM account password on Windows Server Active Directory domain controllers.

Supported values are either 1 (True) or 0 (False).

This setting defaults to 0 (False).

> [!IMPORTANT]
> This setting is ignored unless ADPasswordEncryptionEnabled is configured to True and all other prerequisites are met.

### PostAuthenticationResetDelay

Use this setting to specify the amount of time (in hours) to wait after an authentication before executing the specified post-authentication actions (see the PostAuthenticationActions setting below). Supported values are:

- **Minimum** : 0 hours (setting this value to 0 disables all post-authentication actions)
- **Maximum**: 24 hours

If not specified, this setting defaults to 24 hours.

### PostAuthenticationActions

Use this setting to specify the actions to take upon expiration of the configured grace period (see the PostAuthenticationResetDelay setting above).

This setting can have one of the following values:

|Value|Name|Actions taken upon expiry of the grace period|
|--- |--- |--- |
|1|Reset password|The managed account password is reset.|
|3|Reset password and sign out|The managed account password is reset and any interactive sign-in sessions that use the managed account are terminated.|
|5|Reset password and reboot|The managed account password is reset and the managed device is immediately restarted.|

If not specified, this setting defaults to 3.

> [!IMPORTANT]
> The allowed post-authentication actions are intended to help limit the amount of time a Windows LAPS password can be used before it is reset. Logging off the managed account or restarting the device are options to help ensure this. Abrupt termination of logon sessions, or rebooting the device, may result in data loss.
>
> From a security perspective, a malicious user who acquires administrative privileges on a device using a valid LAPS password does have the ultimate ability to prevent or circumvent these mechanisms.

## See also

- [Windows LAPS CSP](/windows/client-management/mdm/laps-csp)
- [Microsoft Endpoint Manager](/mem/endpoint-manager-overview)
