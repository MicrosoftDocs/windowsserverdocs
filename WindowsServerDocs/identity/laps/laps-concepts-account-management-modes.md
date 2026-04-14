---
title: Windows LAPS account management modes
description: Documents account management modes for Windows Local Administrator Password Solution (Windows LAPS).
author: jay98014
ms.author: roharwoo
ms.date: 05/12/2025
ms.topic: concept-article
---

# Windows LAPS account management modes

Learn about the different account management modes supported by Windows Local Administrator Password Solution (Windows LAPS).

> [!IMPORTANT]
> The Windows LAPS automatic account management feature is only supported in Windows 11 24H2, Windows Server 2025 and later releases.

## Overview

The primary purpose of Windows LAPS is regularly rotate the password of a local Windows account. This account can either be the built-in Administrator account, or a custom new account. The IT admin has two different modes to choose from for configuring and managing the target account: manual and automatic. Both modes have their pros and cons.

There are two different modes available to manage the target account.

Manual account management mode is the default mode. In manual mode, the IT admin is responsible for configuration of all aspects of the managed account *except* the password, which Windows LAPS manages and controls.

Automatic account management mode is an optional mode. In automatic mode, Windows LAPS is responsible for configuration of *all* aspects of the managed account, including basic account creation and deletion as required, plus the account's password.

## Manual account management mode

Manual mode is the default mode. The IT admin has the choice of whether to target the built-in Administrator account, or a custom new account. This choice is configured via the AdministratorAccountName policy setting. If the AdministratorAccountName setting is empty, the built-in Administrator account is managed, otherwise AdministratorAccountName specifies the name of a custom local account.

When a custom local account is specified, the IT admin is responsible for creating that account before enabling Windows LAPS - Windows LAPS doesn't create the account in this mode. There are many ways to create a local account:

- Configuring the Accounts CSP
- Deploying custom policy-driven management scripts
- Adding the target account to a base OS image.

These mechanisms add extra complexity which can be avoided by using Automatic account management mode.

In this mode, the target account's *password* is protected against accidental or careless tampering. All other account configuration changes are allowed.

## Automatic account management mode

Automatic mode is an off-by-default mode. Once enabled the IT admin can choose from the following configuration details:

- Whether to target the built-in Administrator account or a custom new account
- The name of the account
- Whether to enable or disable the account
- Whether to randomize the name of the account

### Automatic account configuration details

When automatic mode is enabled, the managed account is configured as follows:

- The account is made a member of the local Administrators group
- The password-not-required setting is disabled
- The password-never-expires flag is disabled
- The account description is modified to indicate that Windows LAPS is controlling the account

### Automatic account management security improvements and considerations

Like any user account, Windows local accounts represent a potential vulnerability vector for attackers. This threat is present for Windows LAPS-managed accounts as well, although mitigated to a huge extent by the highly complex passwords generated (and regularly rotated) by Windows LAPS. Automatic account management offers two improvements which can further mitigate threats when more assurance is desired for high-threat environments.

- First, maintaining the managed account in a disabled state completely eliminates any chance that the account can be the target of a password spray or similar attack. Keeping the managed account in a disabled state does however introduce friction: the managed account must be enabled (via GPO or MDM policy manipulation) before the account can be used.

- Second, maintaining a unique managed account name per device (via account name randomization) makes an attacker's job harder. Instead of knowing in advance which account to attack on all devices, the attacker must somehow find out the name of the account on a given target device. There's more friction here as well since IT staff must be trained to not rely on knowing a common, organization-wide managed account name.

IT admins deploying Windows LAPS in security critical environment should consider these features. Whether the friction introduced by adopting these features is acceptable depends on how often the Windows LAPS-managed accounts need to be used, plus the security requirements of a given IT environment.

### Integration with local account management policies

Windows supports multiple policies for managing the membership of Windows local groups:

- [RestrictedGroups Policy CSP](/windows/client-management/mdm/policy-csp-restrictedgroups)
- [LocalUsersAndGroups Policy CSP](/windows/client-management/mdm/policy-csp-localusersandgroups)
- Local Users and Groups (Group Policy)
- Restricted Groups (Group Policy)

Each of the above policies supports a configuration mode that can be used to force the removal of all members of a specified local group. The above policies now ignore any attempt to remove the Windows LAPS automatically managed account from the local Administrators group.

### Account tampering protection

Account tampering protection is expanded in automatic mode. Windows LAPS controls *all* configuration aspects of an automatically managed account. External attempts to modify the managed account are blocked. IT admins shouldn't author policies or scripts that attempt to modify the managed account.

Windows LAPS rejects unexpected attempts to modify the account with a `STATUS_POLICY_CONTROLLED_ACCOUNT` (0xC000A08B) or `ERROR_POLICY_CONTROLLED_ACCOUNT` (0x21CE\8654) error. Each rejection has an associated event in the Windows LAPS event log channel. Events 10101-10104 are logged, corresponding to what type of modification was request (basic modify, modification of security descriptor, deletion, or removal from the local Administrators group).

## Choosing a mode

Manual mode is the best choice for situations that require unique and\or detailed configuration of the target account.

Automatic mode is the best choice for situations with less detailed requirements, for example you only need the managed account to be available and ready for use in a basic configuration with Administrator privileges. Automatic mode also supports creation of a custom new account.

|Feature|Manual mode|Automatic mode|
|---|:---:|:---:|
|Password controlled by Windows LAPS|Yes|Yes|
|IT admin can customize the account|Yes|No|
|Supports automatic account creation|No|Yes|
|Supports automatic account naming|No|Yes|
|Supports automatic account enablement\disablement|No|Yes|
|Supports automatic account name randomization|No|Yes|
|Supports integration with local account policies|No|Yes|

> [!IMPORTANT]
> Microsoft recommends that customers prefer automatic account management mode at all times, except for those (rare) situations that require unique configuration of the target management account. It is further recommended that automatic account management mode be configured to create\target a custom account, and that the built-in Administrator account be left unused and maintained in a disabled state.

## Directory Services Repair Mode account management

Windows LAPS supports managing the password of the Directory Services Repair Mode account (DSRM) on domain controllers. The manual and automatic account management modes described in this article don't apply to the DSRM account.

## See also

- [Key concepts in Windows LAPS](laps-concepts-overview.md)
- [Windows LAPS passwords and passphrases](laps-concepts-passwords-passphrases.md)

## Next steps

Now that you understand the different account management modes, take a look at these other sections.

- [Get started with Windows LAPS for Windows Server Active Directory](laps-scenarios-windows-server-active-directory.md)
- [Get started with Windows LAPS for Microsoft Entra ID](laps-scenarios-azure-active-directory.md)
