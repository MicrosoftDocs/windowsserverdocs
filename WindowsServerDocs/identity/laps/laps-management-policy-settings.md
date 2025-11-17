---
title: Configure Policy Settings for Windows LAPS
description: Learn how to configure policy settings for Windows Local Administrator Password Solution (Windows LAPS) to enhance security and automate local administrator password management.
author: robinharwood
ms.author: roharwoo
ms.date: 06/26/2025
ms.topic: concept-article
ms.custom: sfi-image-nochange
---

# Configure policy settings for Windows LAPS

Windows Local Administrator Password Solution (Windows LAPS) lets you configure policy settings to manage local administrator passwords securely and automatically. This article explains each policy setting and how to administer them for improved security and compliance.

## Supported policy roots

Although we don't recommend it, you can administer a device by using multiple policy management mechanisms. To support this scenario in an understandable and predictable way, each Windows LAPS policy mechanism is assigned a distinct registry root key:

|Policy name|Policy registry key root|
|---|---|
|LAPS CSP|`HKLM\Software\Microsoft\Policies\LAPS`|
|LAPS Group Policy|`HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\LAPS`|
|LAPS Local Configuration|`HKLM\Software\Microsoft\Windows\CurrentVersion\LAPS\Config`|
|Legacy Microsoft LAPS|`HKLM\Software\Policies\Microsoft Services\AdmPwd`|

Windows LAPS queries all known registry key policy roots, starting at the top and moving down. If no settings are found under a root, that root is skipped and the query proceeds to the next root. When a root that has at least one explicitly defined setting is found, that root is used as the active policy. If the chosen root is missing any settings, the settings are assigned their default values.

Policy settings are never shared or inherited across policy key roots.

> [!TIP]
> The LAPS Local Configuration key is included in the preceding table for completeness. You can use this key if necessary, but the key is primarily intended to be used for testing and development. No management tools or policy mechanisms target this key.

## Supported policy settings by BackupDirectory

Windows LAPS supports multiple policy settings that you can administer via various policy management solutions, or even directly via the registry. Some of these settings only apply when backing up passwords to Active Directory, and some settings are common to both the Active Directory and Microsoft Entra scenarios.

The following table specifies which settings apply to devices that have the specified `BackupDirectory` setting:

|Setting name|Applicable when BackupDirectory=Microsoft Entra ID?|Applicable when BackupDirectory=AD?|
|---|---|---|
|AdministratorAccountName|Yes|Yes|
|PasswordAgeDays|Yes|Yes|
|PasswordLength|Yes|Yes|
|PassphraseLength|Yes|Yes|
|PasswordComplexity|Yes|Yes|
|PostAuthenticationResetDelay|Yes|Yes|
|PostAuthenticationActions|Yes|Yes|
|ADPasswordEncryptionEnabled|No|Yes|
|ADPasswordEncryptionPrincipal|No|Yes|
|ADEncryptedPasswordHistorySize|No|Yes|
|ADBackupDSRMPassword|No|Yes|
|PasswordExpirationProtectionEnabled|No|Yes|
|AutomaticAccountManagementEnabled|Yes|Yes|
|AutomaticAccountManagementTarget|Yes|Yes|
|AutomaticAccountManagementNameOrPrefix|Yes|Yes|
|AutomaticAccountManagementEnableAccount|Yes|Yes|
|AutomaticAccountManagementRandomizeName|Yes|Yes|

If `BackupDirectory` is set to Disabled, all other settings are ignored.

You can administer almost all settings by using any policy management mechanism. The [Windows LAPS configuration service provider (CSP)](/windows/client-management/mdm/laps-csp) has two exceptions to this rule. The Windows LAPS CSP supports two settings that aren't in the preceding table: `ResetPassword` and `ResetPasswordStatus`. Also, Windows LAPS CSP doesn't support the `ADBackupDSRMPassword` setting (domain controllers are never managed via CSP). For more information, see the LAPS CSP documentation.

## Windows LAPS Group Policy

Windows LAPS includes a new Group Policy Object that you can use to administer policy settings on Active Directory domain-joined devices. To access the Windows LAPS Group Policy, in Group Policy Management Editor, go to **Computer Configuration** > **Administrative Templates** > **System** > **LAPS**. The following figure shows an example:

:::image type="content" source="./media/laps-management-policy-settings/laps-management-policy-settings-group-policy-editor.png" alt-text="Screenshot of the Group Policy Management Editor that shows the Windows LAPS policy settings.":::

The template for this new Group Policy object is installed as part of Windows at *%windir%\PolicyDefinitions\LAPS.admx*.

## Group Policy Object Central Store

> [!IMPORTANT]
> The Windows LAPS GPO template files aren't automatically copied to your GPO central store as part of a Windows Update patching operation, assuming you implemented that approach. Instead, you must manually copy the *LAPS.admx* to the GPO central store location. See [Create and manage Central Store](/troubleshoot/windows-client/group-policy/create-and-manage-central-store).

## Windows LAPS CSP

Windows LAPS includes a specific CSP that you can use to administer policy settings on Microsoft Entra joined devices. Manage the [Windows LAPS CSP](/windows/client-management/mdm/laps-csp) by using [Microsoft Intune](/mem/intune).

## Apply policy settings

The following sections describe how to use and apply various policy settings for Windows LAPS.

### BackupDirectory

Use this setting to control which directory the password for the managed account is backed up to.

|Value|Description of setting|
|--- |--- |
|0|Disabled (password isn't backed up)|
|1|Back up the password to Microsoft Entra only|
|2|Back up the password to Windows Server Active Directory only|

If not specified, this setting defaults to *0* (Disabled).

### AdministratorAccountName

Use this setting to configure the name of the managed local administrator account.

If not specified, this setting defaults to managing the built-in local administrator account.

> [!IMPORTANT]
> Don't specify this setting unless you want to manage an account other than the built-in local administrator account. The local administrator account is automatically identified by its well-known relative identifier (RID).

> [!IMPORTANT]
> You can configure the specified account (built-in or custom) as either enabled or disabled. Windows LAPS manages that account's password in either state. If left in a disabled state, however, the account must first be enabled in order to be used.

> [!IMPORTANT]
> If you configure Windows LAPS to manage a custom local administrator account, you must ensure that the account is created. Windows LAPS doesn't create the account.

> [!IMPORTANT]
> This setting is ignored when `AutomaticAccountManagementEnabled` is enabled.

### PasswordAgeDays

This setting controls the maximum password age of the managed local administrator account. Supported values are:

- **Minimum**: One day (When the backup directory is configured to be Microsoft Entra ID, the minimum is seven days.)
- **Maximum**: 365 days

If not specified, this setting defaults to 30 days.

> [!IMPORTANT]
> Changes to the `PasswordAgeDays` policy setting have no effect on the expiration time of the current password. Similarly, changes to the `PasswordAgeDays` policy setting don't cause the managed device to initiate a password rotation.

### PasswordLength

Use this setting to configure the length of the password of the managed local administrator account. Supported values are:

- **Minimum**: 8 characters
- **Maximum**: 64 characters

If not specified, this setting defaults to 14 characters.
  
> [!IMPORTANT]
> Don't configure `PasswordLength` to a value that's incompatible with the managed device's local password policy. Doing so results in Windows LAPS failing to create a new compatible password. (Look for a 10027 event in the Windows LAP event log.)

The `PasswordLength` setting is ignored unless `PasswordComplexity` is configured to one of the password options.

### PassphraseLength

Use this setting to configure the number of words in the passphrase of the managed local administrator account. Supported values are:

- **Minimum**: 3 words
- **Maximum**: 10 words

If not specified, this setting defaults to 6 words.

The `PassphraseLength` setting is ignored unless `PasswordComplexity` is configured to one of the passphrase options.

> [!IMPORTANT]
> `PassphraseLength` is only supported in Windows 11 24H2, Windows Server 2025, and later releases.

### PasswordComplexity

Use this setting to configure the required password complexity of the managed local administrator account, or to specify that a passphrase is created.

|Value|Description of setting|
|--- |--- |
|1|Large letters|
|2|Large letters + small letters|
|3|Large letters + small letters + numbers|
|4|Large letters + small letters + numbers + special characters|
|5|Large letters + small letters + numbers + special characters (improved readability)|
|6|Passphrase (long words)|
|7|Passphrase (short words)|
|8|Passphrase (short words with unique prefixes)|

If not specified, this setting defaults to *4*.

> [!IMPORTANT]
> Windows supports the lower password complexity settings (1, 2, and 3) only for backward compatibility with legacy Microsoft LAPS. We recommend that you always configure this setting to 4 (or a higher value if supported).

> [!IMPORTANT]
> Don't configure `PasswordComplexity` to a setting that's incompatible with the managed device's local password policy. Doing so results in Windows LAPS failing to create a new compatible password. (Look for a 10027 event in the Windows LAPS event log.)

> [!IMPORTANT]
> `PasswordComplexity` values 5 through 8 are only supported in Windows 11 24H2, Windows Server 2025, and later releases.

### PasswordExpirationProtectionEnabled

Use this setting to configure enforcement of maximum password age for the managed local administrator account.

Supported values are either *1* (True) or *0* (False).

If not specified, this setting defaults to *1* (True).

> [!TIP]
> In legacy Microsoft LAPS mode, this setting defaults to *False* for backward compatibility.

### ADPasswordEncryptionEnabled

Use this setting to enable encryption of passwords in Active Directory.

Supported values are either *1* (True) or *0* (False).

> [!IMPORTANT]
> Enabling this setting requires that your Active Directory domain is running at Domain Functional Level 2016 or later.

### ADPasswordEncryptionPrincipal

Use this setting to configure the name or security identifier (SID) of a user or group that can decrypt the password stored in Active Directory.

This setting is ignored if the password is currently stored in Azure.

If this setting isn't specified, only members of the Domain Admins group in the device's domain can decrypt the password.

If this setting is specified, the specified user or group can decrypt the password stored in Active Directory.

> [!IMPORTANT]
> The string stored in this setting is either an SID in string form or the fully qualified name of a user or group. Valid examples include:
>
> - `S-1-5-21-2127521184-1604012920-1887927527-35197`
> - `contoso\LAPSAdmins`
> - `lapsadmins@contoso.com`
>
> The principal identified (either by SID or by user or group name) must exist and be resolvable by the device.
>
> The data specified in this setting is entered as-is; for example, don't add enclosing quotes or parentheses.
>
> This setting is ignored unless `ADPasswordEncryptionEnabled` is configured to *True* and all other prerequisites are met.
>
> This setting is ignored when Directory Services Repair Mode (DSRM) account passwords are backed up on a domain controller. In that scenario, this setting always defaults to the Domain Admins group of the domain controller's domain.

### ADEncryptedPasswordHistorySize

Use this setting to configure how many previous encrypted passwords are remembered in Active Directory. Supported values are:

- **Minimum** : 0 passwords
- **Maximum**: 12 passwords

If not specified, this setting defaults to 0 passwords (disabled).

> [!IMPORTANT]
> This setting is ignored unless `ADPasswordEncryptionEnabled` is configured to True and all other prerequisites are met.
>
> This setting also takes effect on domain controllers that back up their DSRM passwords.

### ADBackupDSRMPassword

Use this setting to enable backup of the DSRM account password on Windows Server Active Directory domain controllers.

Supported values are either *1* (True) or *0* (False).

This setting defaults to *0* (False).

> [!IMPORTANT]
> This setting is ignored unless `ADPasswordEncryptionEnabled` is configured to True and all other prerequisites are met.

### PostAuthenticationResetDelay

Use this setting to specify the amount of time (in hours) to wait after an authentication before running the specified post-authentication actions (see `PostAuthenticationActions`). Supported values are:

- **Minimum** : 0 hours (setting this value to 0 disables all post-authentication actions)
- **Maximum**: 24 hours

If not specified, this setting defaults to 24 hours.

### PostAuthenticationActions

Use this setting to specify the actions to take upon expiration of the configured grace period (see `PostAuthenticationResetDelay`).

This setting can have one of the following values:

|Value|Name|Actions taken when the grace period expires|Comments|
|--- |--- |--- |--- |
|1|Reset password|The managed account password is reset.||
|3|Reset password and sign out|The managed account password is reset, interactive sign-in sessions using the managed account are terminated, and SMB sessions using the managed account are deleted.|Interactive sign-in sessions receive a nonconfigurable two-minute warning to save their work and sign out.|
|5|Reset password and reboot|The managed account password is reset and the managed device is restarted.|The managed device is restarted after a nonconfigurable one-minute delay.|
|11|Reset password and sign out|The managed account password is reset, interactive sign-in sessions using the managed account are terminated, SMB sessions using the managed account are deleted, and any remaining processes running under the managed account identity are terminated.|Interactive sign-in sessions receive a nonconfigurable two-minute warning to save their work and sign out.|

If not specified, this setting defaults to *3*.

> [!IMPORTANT]
> The allowed post-authentication actions are intended to help limit the amount of time a Windows LAPS password can be used before it's reset. Signing out of the managed account or restarting the device are options that help ensure the time is limited. Abruptly terminating signed-in sessions or restarting the device might result in data loss.
>
> From a security perspective, a malicious user who acquires administrative privileges on a device using a valid Windows LAPS password does have the ultimate ability to prevent or circumvent these mechanisms.

> [!IMPORTANT]
> `PostAuthenticationActions` value 11 is only supported in Windows 11 24H2, Windows Server 2025, and later releases.

### AutomaticAccountManagementEnabled

Use this setting to enable automatic account management.

Supported values are either *1* (True) or *0* (False).

This setting defaults to *0* (False).

> [!IMPORTANT]
> `AutomaticAccountManagementEnabled` is only supported in Windows 11 24H2, Windows Server 2025, and later releases.

### AutomaticAccountManagementTarget

Use this setting to specify whether the built-in Administrator account or a new custom account is automatically managed.

|Value|Description of setting|
|--- |--- |
|0|Automatically manage the built-in Administrator account|
|1|Automatically manage a new custom account|

This setting defaults to *1*.

This setting is ignored unless `AutomaticAccountManagementEnabled` is enabled.

> [!IMPORTANT]
> `AutomaticAccountManagementTarget` is only supported in Windows 11 24H2, Windows Server 2025, and later releases.

### AutomaticAccountManagementNameOrPrefix

Use this setting to specify the name or the name prefix of the automatically managed account.

This setting defaults to `WLapsAdmin`.

This setting is treated as a name if `AutomaticAccountManagementRandomizeName` is *0* (False).

This setting is treated as a name prefix if `AutomaticAccountManagementRandomizeName` is *1* (True).

This setting is ignored unless `AutomaticAccountManagementEnabled` is enabled.

> [!IMPORTANT]
> `AutomaticAccountManagementNameOrPrefix` is only supported in Windows 11 24H2, Windows Server 2025, and later releases.

### AutomaticAccountManagementEnableAccount

Use this setting to enable or disable the automatically managed account.

|Value|Description of setting|
|--- |--- |
|0|Disable the automatically managed account|
|1|Enable the automatically managed account|

This setting defaults to *0*.

This setting is ignored unless `AutomaticAccountManagementEnabled` is enabled.

> [!IMPORTANT]
> `AutomaticAccountManagementEnableAccount` is only supported in Windows 11 24H2, Windows Server 2025, and later releases.

### AutomaticAccountManagementRandomizeName

Use this setting to enable randomization of the name of the automatically managed account.

When this setting is enabled, the name of the managed account (determined by the `AutomaticAccountManagementNameOrPrefix` setting) is suffixed with a random six-digit suffix every time the password is rotated.

Windows local account names have a maximum length of 20 characters, which means the name component must be 14 characters long at most to have sufficient space for the random suffix. Account names specified by `AutomaticAccountManagementNameOrPrefix` that are longer than 14 characters are  truncated.

|Value|Description of setting|
|--- |--- |
|0|Don't randomize the name of the automatically managed account|
|1|Randomize the name of the automatically managed account|

This setting defaults to *0*.

This setting is ignored unless `AutomaticAccountManagementEnabled` is enabled.

> [!IMPORTANT]
> `AutomaticAccountManagementRandomizeName` is only supported in Windows 11 24H2, Windows Server 2025, and later releases.

## Windows LAPS default policy values

All Windows LAPS policy settings have a default value. The default value is applied whenever an administrator doesn't configure a particular setting. The default value is also applied whenever an administrator configures a particular setting with an unsupported value.

|Setting name|Default value|
|---|---|
|BackupDirectory|Disabled|
|AdministratorAccountName|Null\empty|
|PasswordAgeDays|30|
|PasswordLength|14|
|PassphraseLength|6|
|PasswordComplexity|4|
|PostAuthenticationResetDelay|24|
|PostAuthenticationActions|3 (Reset password and sign out)|
|ADPasswordEncryptionEnabled|True|
|ADPasswordEncryptionPrincipal|Domain Admins|
|ADEncryptedPasswordHistorySize|0|
|ADBackupDSRMPassword|False|
|PasswordExpirationProtectionEnabled|True|
|AutomaticAccountManagementEnabled|False|
|AutomaticAccountManagementTarget|Yes|
|AutomaticAccountManagementNameOrPrefix|Yes|
|AutomaticAccountManagementEnableAccount|False|
|AutomaticAccountManagementRandomizeName|False|

> [!IMPORTANT]
> ADPasswordEncryptionPrincipal is an exception to the misconfigured setting rule. This setting defaults to 'Domain Admins' only when the setting isn't configured. When an invalid user or group name is specified, a policy processing failure occurs and the managed account's password isn't backed up.

Keep these defaults in mind when configuring new Windows LAPS features, for example, passphrase support. If you configure a policy with a PasswordComplexity value of 6 (long word passphrases) and then apply that policy to an older OS that doesn't support that value, the target OS uses the default value of 4. To avoid this outcome, create two different policies: one for the older OS and one for the newer OS.

## Related content

- [Use event logs for Windows LAPS](laps-management-event-log.md)
- [Use Windows LAPS PowerShell cmdlet](laps-management-powershell.md)
- [Windows LAPS schema extensions reference](laps-technical-reference.md)


