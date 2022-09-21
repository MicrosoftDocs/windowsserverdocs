---
ms.assetid: d4a54de1-fd53-4470-b551-2341ccd6c210
title: Local Administrator Password Solution Policy Settings
description: Local Administrator Password Solution Policy Settings
author: jsimmons
ms.author: jsimmons
manager: jsimmons
ms.date: 07/04/2022
ms.topic: article
---

# Windows LAPS Policy Settings

Windows LAPS supports various policy-controllable settings. This article describes the various settings and ways to administer them.

## Supported policy roots

While not a recommended practice, it's possible for a device to be administered via multiple policy management mechanisms. To support this situation in an understandable and predictable way, each LAPS policy mechanism is assigned a distinct registry root key:

|Policy name|Policy registry key root|
|---|---|
|LAPS CSP|HKLM\Software\Microsoft\Policies\LAPS|
|LAPS Group Policy|HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\LAPS|
|LAPS Local Configuration|HKLM\Software\Microsoft\Windows\CurrentVersion\LAPS\Config|
|Legacy LAPS|HKLM\Software\Policies\Microsoft Services\AdmPwd|

Windows LAPS will query all known registry key policy roots starting at the top and moving down. If no settings are found under a given root, that root will be skipped and the query will proceed to the next root. As soon as a root is found with at least one explicitly defined setting, that root will be used as the active policy. If the chosen root is missing any settings, those settings will be assigned their default values.

> [!IMPORTANT]
> Policy settings are never shared or inherited across policy key roots.

> [!TIP]
> The LAPS Local Configuration key is listed for completeness. This key may be used if necessary but is primarily intended for testing and development purposes. There are no management tools or policy mechanisms which target this key.

## Supported policy settings by join-state

Windows Local Administrator Password Solution (LAPS) supports multiple policy settings that can be administered via various policy management solutions, or even directly via the registry.

The following table specifies which settings are applicable on devices with the specified join states:

|Setting name|Azure-joined|Hybrid-joined|AD-joined|
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

Almost all settings can be administered via any policy management mechanism. The [Windows LAPS CSP](/windows/client-management/mdm/laps-csp) has two exceptions to this rule. The LAPS CSP supports two settings not in the above table, ResetPassword and ResetPasswordStatus, and it doesn't support the ADBackupDSRMPassword setting (domain controllers are never managed via CSP). See the LAPS CSP documentation for more info.

## LAPS Group Policy

Windows LAPS includes a new Group Policy object that can be used to administer policy settings on AD-domain-joined devices. The Windows LAPS Group Policy can be found by opening the Group Policy editor and navigating to:

`Computer Configuration > Administrative Templates > System > LAPS`

For example:

:::image type="content" source="../laps/media/laps-management-policy-settings/laps-management-policy-settings-group-policy-editor.png" alt-text="Screenshot of the Group Policy Management Editor showing the Windows LAPS policy settings.":::

## LAPS Configuration Service Provider

Windows LAPS includes a new Configuration Service Provider (CSP) that can be used to administer policy settings on Azure Active Directory-joined devices. The [Windows LAPS CSP](/windows/client-management/mdm/laps-csp) is managed using [Microsoft Endpoint Manager](/mem/endpoint-manager-overview).

## Policy setting details

This section specifies the details of the various settings.

### BackupDirectory

Use this setting to control which directory the password for the managed account is backed up to.

|Value|Description of setting|
|--- |--- |
|0|Disabled (password won't be backed up)|
|1|Back up the password to Azure Active Directory only|
|2|Back up the password to Windows Server Active Directory only|

If not specified, this setting will default to 0 (Disabled).

### PasswordAgeDays

This setting controls the length of the password. Supported values are:

  Minimum: One day (seven days when backup directory is configured to be Azure AD)

  Maximum: 365 days

If not specified, this setting will default to 30 days.

### PasswordLength

Use this setting to configure the length of the password of the managed local administrator account. Supported values are:

  Minimum: eight (8) characters
  Maximum: 64 characters

If not specified, this setting will default to 14 characters.
  
### PasswordComplexity

Use this setting to configure password complexity of the managed local administrator account.

|Value|Description of setting|
|--- |--- |
|One (1) |Large letters|
|Two (2)|Large letters + small letters|
|Three (3)|Large letters + small letters + numbers|
|Four (4)|Large letters + small letters + numbers + special characters|

If not specified, this setting will default to four (4).

> [!IMPORTANT]
> Windows supports the lower password complexity settings (1, 2, and 3) only for backwards compatibility with older versions of LAPS. Microsoft recommends that this setting always be configured to 4.

### PasswordExpirationProtectionEnabled

Use this setting to configure enforcement of maximum password age for the managed local administrator account.

Supported values are either one (True) or zero (False).

If not specified, this setting will default to one (True).

> [!TIP]
> In legacy LAPS mode this setting will default to zero (False) for backward compatibility.

### AdministratorAccountName

Use this setting to configure the name of the managed local administrator account.

If not specified, this setting will default to managing the built-in local administrator account.

> [!IMPORTANT]
> Do not specify this setting unless you want to manage an account other than the built-in local administrator account. The local administrator account is automatically identified by its well-known Relative Identifier (RID).

### ADPasswordEncryptionEnabled

Use this setting to enable encryption of passwords in AD.

Supported values are either one (True) or zero (False).

> [!IMPORTANT]
> Enabling this setting requires that your Active Directory domain be running at Domain Functional Level 2016 or later.

### ADPasswordEncryptionPrincipal

Use this setting to configure the name or SID of a user or group that can decrypt the password stored in Active Directory.

This setting is ignored if the password is currently being stored in Azure.

If not specified, the password can only be decrypted by the Domain Admins group in the device's domain.

If specified, the specified user or group will be able to decrypt the password stored in Active Directory.

> [!IMPORTANT]
> The string stored in this setting must be either a SID in string form or the fully qualified name of a user or group. Valid examples include:
>
> "S-1-5-21-2127521184-1604012920-1887927527-35197"
>
> "contoso\LAPSAdmins"
>
> "lapsadmins@contoso.com"
>
> The principal identified (either by SID or user\group name) must exist and be resolvable by the device.

> [!IMPORTANT]
> This setting is ignored unless ADPasswordEncryptionEnabled is configured to True and all other prerequisites are met.

> [!IMPORTANT]
> This setting is ignored when backing up DSRM account passwords on a domain controller. In that case this setting will always default to the Domain Admins group of the domain controller's domain.

### ADEncryptedPasswordHistorySize

Use this setting to configure how many previous encrypted passwords will be remembered in Active Directory.

This setting has a minimum allowed value of zero (0) passwords.

This setting has a maximum allowed value of 12 passwords.

If not specified, this setting will default to zero (0) passwords (disabled).

> [!IMPORTANT]
> This setting is ignored unless ADPasswordEncryptionEnabled is configured to True and all other prerequisites are met.

> [!TIP]
> This setting also takes effect on on domain controllers that are backing up their DSRM passwords.

### ADBackupDSRMPassword

Use this setting to enable backup of the DSRM account password on Windows Server Active Directory domain controllers.

Supported values are either 1 (True) or 0 (False).

This setting defaults to 0 (False).

> [!IMPORTANT]
> This setting is ignored unless ADPasswordEncryptionEnabled is configured to True and all other prerequisites are met.

### PostAuthenticationResetDelay

Use this setting to specify the amount of time (in hours) to wait after an authentication before executing the specified post-authentication actions (see the PostAuthenticationActions setting below).

This setting has a minimum allowed value of 0 hours (setting this value to 0 disables all post-authentication actions).

This setting has a maximum allowed value of 24 hours.

If not specified, this setting will default to 24 hours.

### PostAuthenticationActions

Use this setting to specify the actions to take upon expiration of the configured grace period (see the PostAuthenticationResetDelay setting above).

This setting can have ONE of the following values:

|Value|Name|Action(s) taken upon expiry of the grace period|
|--- |--- |--- |
|1|Reset password|The managed account password will be reset|
|3|Reset password and sign out|The managed account password will be reset and any interactive sign-in sessions using the managed account will be terminated|
|5|Reset password and reboot|The managed account password will be reset and the managed device will be immediately rebooted.|

If not specified, this setting will default to 3.

> [!IMPORTANT]
> The allowed post-authentication actions are intended to help limit the amount of time that a LAPS password may be used before being reset. Logging off the managed account - or rebooting the device - are options to help ensure this. Abrupt termination of logon sessions, or rebooting the device, may result in data loss.

> [!IMPORTANT]
> From a security perspective, a malicious user who acquires administrative privileges on a device using a valid LAPS password does have the ultimate ability to prevent or circumvent these mechanisms.

## See also

[Windows LAPS CSP](/windows/client-management/mdm/laps-csp)

[Microsoft Endpoint Manager](/mem/endpoint-manager-overview)
