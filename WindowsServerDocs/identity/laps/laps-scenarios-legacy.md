---
ms.assetid: 26445d45-8d2c-4cbb-be3d-0dc0bf7c7753
title: Local Administrator Password Solution Legacy Emulation Scenario
description: Local Administrator Password Solution Legacy Emulation Scenario
author: jsimmons
ms.author: jsimmons
manager: jsimmons
ms.date: 07/04/2022
ms.topic: article
---

# Getting started with Windows LAPS in Legacy LAPS emulation mode

> [!IMPORTANT]
> Windows LAPS is currently only available in Windows Insider builds as of 25145 and later. Support for the Windows LAPS Azure Active Directory scenario is currently limited to a small group of Windows Insiders.

## Overview

Windows LAPS can be configured so that it will honor the legacy LAPS Group Policy settings subject to certain restrictions and limitations. This feature is referred to as "legacy LAPS emulation". This feature can be useful when migrating an existing deployment from legacy LAPS to Windows LAPS.

> [!IMPORTANT]
> Just like in legacy LAPS proper, legacy LAPS emulation mode only supports storage of passwords in clear-text form in Windows Server Active Directory. For security reasons, Microsoft recommends that you migrate to using Windows LAPS natively so you can take advantage of password encryption.

## Setup and configuration

When Windows LAPS has been configured in legacy LAPS emulation mode, Windows LAPS assumes that your Windows Server Active Directory environment is already configured and enabled for running legacy LAPS. Refer to the existing legacy LAPS documentation for full details.

## Requirements and limitations

The following requirements and limitations apply to legacy LAPS emulation support:

* Windows LAPS doesn't support adding the legacy LAPS Windows Server Active Directory schema

  You must install legacy LAPS on a domain controller or other management client in order to extend your Windows Server Active Directory schema with the legacy LAPS schema elements (using the `Update-AdmPwdADSchema` cmdlet). The Windows LAPS `Update-LapsADSchema` cmdlet doesn't add the legacy LAPS schema elements.

* Windows LAPS doesn't install the legacy LAPS Group Policy definition files.

  You must install legacy LAPS on a domain controller or other management client in order to define and administer legacy LAPS group policies.

* Windows LAPS doesn't support managing the legacy LAPS Active Directory ACLs.

  You must install legacy LAPS on a domain controller or other management client in order to manage the legacy LAPS Windows Server Active Directory ACLS, for example using the `Set-AdmPwdComputerSelfPermissions` cmdlet.

* No other Windows LAPS policies can be applied to the machine.

  If present, a Windows LAPS policy will always take precedence regardless of application method (for example, via CSP, GPO, or raw registry modification). If a Windows LAPS policy is present, a legacy LAPS policy will always be ignored. For more info, see [Windows LAPS Policy Settings](../laps/laps-management-policy-settings.md).

* Legacy LAPS must not be installed on the machine.

  The reason for this restriction is that otherwise Windows LAPS and legacy LAPS would simultaneously try to manage the same local administrator account. Having two parties manage the same account is a bad idea and also not supported. For the purposes of this emulation feature, legacy LAPS is considered installed if the legacy LAPS Group Policy Client Side Extension is installed. This detection is done by querying the DllName registry value under this registry key:

    `HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions\{D76B9641-3288-4f75-942D-087DE603E3EA}`

  When the DllName value is present, and refers to a file on disk (note: the file isn't loaded or otherwise verified), legacy LAPS is considered to be installed.

* The Windows Server Active Directory Users and Computer management console doesn't support reading or writing the legacy LAPS schema attributes.

* Windows LAPS will always ignore a legacy LAPS policy when configured on a Windows Server Active Directory domain controller, even if all other conditions are met.

* All Windows LAPS policy knobs not supported by legacy LAPS will be defaulted to their disabled or default settings.

  This point should be obvious, but just to be sure: for example, when running in legacy LAPS emulation mode you can't configure Windows LAPS to encrypt passwords, or save passwords to Azure Active Directory, etc.

Assuming all of the above constraints are satisfied, Windows LAPS will honor the legacy LAPS Group Policy settings. The specified managed local administrator account will be managed identically to legacy LAPS.

## Limited administrative support

The `Get-LapsADPassword` cmdlet supports retrieval of the legacy LAPS password attribute (`ms-Mcs-AdmPwd`). The Account and PasswordUpdateTime fields in the resulting output will always be blank however, for example:

```PowerShell
PS C:\> Get-LapsADPassword -Identity lapsAD2 -AsPlainText
ComputerName        : LAPSAD2
DistinguishedName   : CN=LAPSAD2,OU=LapsTestOU,DC=laps,DC=com
Account             :
Password            : SV6[y1n3JG+3l8
PasswordUpdateTime  :
ExpirationTimestamp : 7/31/2022 12:43:10 PM
Source              : CleartextPassword
DecryptionStatus    : NotApplicable
AuthorizedDecryptor : NotApplicable
```

The `Set-LapsADPasswordExpirationTime` cmdlet doesn't support expiring or modifying the legacy LAPS password expiration attribute (`ms-Mcs-AdmPwdExpirationTime`).

The Windows LAPS property page in the Windows Server Active Directory Users and Computers management console doesn't support displaying or administering the legacy LAPS attributes.

## Logging

When Windows LAPS runs in legacy LAPS emulation mode, a 10023 event will be logged to detail the current policy configuration:

:::image type="content" source="../laps/media/laps-scenarios-legacy/laps-scenarios-legacy-gpo-event.png" alt-text="Screenshot of the event log showing a legacy LAPS configuration event log message.":::

Otherwise, the same events logged by Windows LAPS when running in non-legacy-LAPS-emulation mode, will also be logged when running in legacy-LAPS-emulation.

## See also

This article doesn't go into detail on managing other aspects of legacy LAPS. For full details, see the legacy LAPS documentation available at the download link:

[Legacy LAPS](https://www.microsoft.com/download/details.aspx?id=46899)

[Windows LAPS Policy Settings](../laps/laps-management-policy-settings.md)
