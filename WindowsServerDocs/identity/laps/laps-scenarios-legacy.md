---
title: Get started with Windows LAPS in Microsoft LAPS emulation mode
description: Learn how to get started in Windows Local Administrator Password Solution (Windows LAPS) legacy emulation.
author: jay98014
ms.author: jsimmons
ms.date: 07/04/2022
ms.topic: conceptual
---

# Get started with Windows LAPS in Microsoft LAPS emulation mode

You can configure Windows LAPS so that it honors Microsoft LAPS Group Policy settings, but with some restrictions and limitations. This feature is called *Microsoft LAPS emulation mode*. It might be useful to use emulation mode if you migrate an existing deployment from Microsoft LAPS to Windows LAPS.

> [!IMPORTANT]
> Windows LAPS currently is available only in Windows 11 Insider Preview Build 25145 and later. Support for the Windows LAPS Azure Active Directory scenario currently is limited to a small group of Windows Insider users.

> [!IMPORTANT]
> Like when you use Microsoft LAPS, Microsoft LAPS emulation mode supports storage of passwords only in clear-text form in Windows Server Active Directory. For security reasons, we recommend that you migrate to using Windows LAPS natively so that you can take advantage of password encryption.

## Setup and configuration

When Windows LAPS is configured in Microsoft LAPS emulation mode, Windows LAPS assumes that your Windows Server Active Directory environment is already configured and enabled for running Microsoft LAPS. For more information, see the Microsoft LAPS documentation.

## Requirements and limitations

The following requirements and limitations apply to Microsoft LAPS emulation support:

- Windows LAPS doesn't support adding the Microsoft LAPS Windows Server Active Directory schema

  You must install Microsoft LAPS on a domain controller or other management client in order to extend your Windows Server Active Directory schema with the Microsoft LAPS schema elements (using the `Update-AdmPwdADSchema` cmdlet). The Windows LAPS `Update-LapsADSchema` cmdlet doesn't add the Microsoft LAPS schema elements.

- Windows LAPS doesn't install the Microsoft LAPS Group Policy definition files.

  To define and administer Microsoft LAPS group policies, you must install Microsoft LAPS on a domain controller or another management client.

- Windows LAPS doesn't support managing the Microsoft LAPS Active Directory ACLs.

  To manage the Microsoft LAPS Windows Server Active Directory ACLs, you must install Microsoft LAPS on a domain controller or another management client. For example, to use the `Set-AdmPwdComputerSelfPermissions` cmdlet.

- No other Windows LAPS policies can be applied to the machine.

  If a Windows LAPS policy is present on the machine, it always take precedence, regardless of application method (for example, via CSP, GPO, or raw registry modification). If a Windows LAPS policy is present, a Microsoft LAPS policy is always ignored. For more information, see [Windows LAPS policy settings](../laps/laps-management-policy-settings.md).

- Microsoft LAPS must not be installed on the machine.

  The reason for this restriction is that otherwise Windows LAPS and Microsoft LAPS would simultaneously try to manage the same local administrator account. Having two parties manage the same account is a bad idea and also not supported. For the purposes of this emulation feature, Microsoft LAPS is considered installed if the Microsoft LAPS Group Policy Client Side Extension is installed. This detection is done by querying the DllName registry value under this registry key:

  `HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions\{D76B9641-3288-4f75-942D-087DE603E3EA}`

  When the DllName value is present and the value refers to a file on disk (note: the file isn't loaded or otherwise verified), Microsoft LAPS is considered to be installed.

- The Windows Server Active Directory Users and Computer management console doesn't support reading or writing the Microsoft LAPS schema attributes.

- Windows LAPS will always ignore a Microsoft LAPS policy when configured on a Windows Server Active Directory domain controller, even if all other conditions are met.

- All Windows LAPS policy knobs not supported by Microsoft LAPS will be defaulted to their disabled or default settings.

  This point should be obvious, but just to be sure: for example, when running in Microsoft LAPS emulation mode you can't configure Windows LAPS to encrypt passwords, or save passwords to Azure Active Directory, etc.

Assuming all of the above constraints are satisfied, Windows LAPS will honor the Microsoft LAPS Group Policy settings. The specified managed local administrator account is managed identically to Microsoft LAPS.

## Limited administrative support

The `Get-LapsADPassword` cmdlet supports retrieval of the Microsoft LAPS password attribute (`ms-Mcs-AdmPwd`). The `Account` and `PasswordUpdateTime` fields in the resulting output will always be blank however, for example:

```powershell
PS C:\> Get-LapsADPassword -Identity lapsAD2 -AsPlainText
````

```output
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

The `Set-LapsADPasswordExpirationTime` cmdlet doesn't support expiring or modifying the Microsoft LAPS password expiration attribute (`ms-Mcs-AdmPwdExpirationTime`).

The Windows LAPS property page in the Windows Server Active Directory Users and Computers management console doesn't support displaying or administering the Microsoft LAPS attributes.

## Logging

When Windows LAPS runs in Microsoft LAPS emulation mode, a 10023 event is logged to detail the current policy configuration:

:::image type="content" source="../laps/media/laps-scenarios-legacy/laps-scenarios-legacy-gpo-event.png" alt-text="Screenshot of the event log showing a Microsoft LAPS configuration event log message.":::

Otherwise, the same events that are logged by Windows LAPS when it doesn't run in Microsoft LAPS emulation mode are also logged when it runs in Microsoft LAPS emulation mode.

## See also

This article doesn't go into detail about managing other aspects of Microsoft LAPS. For full details, see the Microsoft LAPS documentation available at the download link:

- [Microsoft LAPS](https://www.microsoft.com/download/details.aspx?id=46899)
- [Windows LAPS policy settings](../laps/laps-management-policy-settings.md)
