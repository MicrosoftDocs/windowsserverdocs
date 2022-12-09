---
title: Get started with Windows LAPS in legacy Microsoft LAPS emulation mode
description: Learn how to get started with Windows Local Administrator Password Solution (Windows LAPS) in legacy Microsoft LAPS emulation mode.
author: jay98014
ms.author: jsimmons
ms.date: 07/04/2022
ms.topic: conceptual
---

# Get started with Windows LAPS in legacy Microsoft LAPS emulation mode

You can set up Windows Local Administrator Password Solution (Windows LAPS) to honor legacy Microsoft LAPS Group Policy settings, but with some restrictions and limitations. The feature is called *legacy Microsoft LAPS emulation mode*. You might use emulation mode if you migrate an existing deployment of legacy Microsoft LAPS to Windows LAPS.

Like Microsoft LAPS, emulation mode supports storage of passwords in Windows Server Active Directory only in clear-text form. To increase security, we recommend that you migrate to using Windows LAPS natively so that you can take advantage of password encryption.

> [!IMPORTANT]
> Windows LAPS currently is available only in [Windows 11 Insider Preview Build 25145 and later](/windows-insider/flight-hub/#active-development-builds-of-windows-11). Support for the Windows LAPS Azure Active Directory scenario is currently in private preview, and limited to a small number of customers who have a direct engagement with engineering. Once public preview is declared in 2023, all customers will be able to evaluate this AAD scenario.

## Setup and configuration

When you configure Windows LAPS in legacy Microsoft LAPS emulation mode, Windows LAPS assumes that your Windows Server Active Directory environment is set up to run legacy Microsoft LAPS. For more information about legacy Microsoft LAPS configuration, see the legacy Microsoft LAPS documentation.

## Requirements and limitations

The following requirements and limitations apply to legacy Microsoft LAPS emulation mode support:

- Windows LAPS doesn't support adding the legacy Microsoft LAPS Windows Server Active Directory schema.

  You must install legacy Microsoft LAPS on a domain controller or another management client to extend your Windows Server Active Directory schema with the legacy Microsoft LAPS schema elements. Use the `Update-AdmPwdADSchema` cmdlet to extend the schema. The Windows LAPS `Update-LapsADSchema` cmdlet doesn't add the legacy Microsoft LAPS schema elements.

- Windows LAPS doesn't install the legacy Microsoft LAPS Group Policy definition files.

  To define and administer legacy Microsoft LAPS group policies, you must install legacy Microsoft LAPS on a domain controller or another management client.

- Windows LAPS doesn't support managing legacy Microsoft LAPS Active Directory access control lists (ACLs).

  To manage the legacy Microsoft LAPS Windows Server Active Directory ACLs, you must install legacy Microsoft LAPS on a domain controller or another management client. For example, to use the `Set-AdmPwdComputerSelfPermissions` cmdlet.

- No other Windows LAPS policies can be applied to the machine.

  If a Windows LAPS policy is present on the machine, it always takes precedence, regardless of how it was applied (configuration service provider, Group Policy Object, or raw registry modification). If a Windows LAPS policy is present, a legacy Microsoft LAPS policy is always ignored. For more information, see [Windows LAPS policy settings](laps-management-policy-settings.md).

- Legacy Microsoft LAPS must not be installed on the machine.

  This restriction avoids a scenario in which Windows LAPS and legacy Microsoft LAPS simultaneously try to manage the same local administrator account. Having two entities manage the same account is a security risk and isn't supported.
  
  For the emulation feature, legacy Microsoft LAPS is considered installed if the legacy Microsoft LAPS Group Policy Client Side Extension is installed. To detect the extension, query the `DllName` registry value under this registry key:

  `HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions\{D76B9641-3288-4f75-942D-087DE603E3EA}`

  When the DllName value is present and the value refers to a file on disk (the file isn't loaded or otherwise verified), legacy Microsoft LAPS is considered to be installed.

- The Windows Server Active Directory Users and Computer management console doesn't support reading or writing legacy Microsoft LAPS schema attributes.

- Windows LAPS always ignores a legacy Microsoft LAPS policy when Windows LAPS is configured on a Windows Server Active Directory domain controller, even if all other conditions are met.

- All Windows LAPS policy knobs that aren't supported by legacy Microsoft LAPS default to their disabled or default settings.

  For example, when you run Windows LAPS in legacy Microsoft LAPS emulation mode, you can't configure Windows LAPS to do tasks like encrypt passwords or save passwords to Azure Active Directory.

If all these constraints are satisfied, Windows LAPS honors legacy Microsoft LAPS Group Policy settings. The specified managed local administrator account is managed identically to how it's managed in legacy Microsoft LAPS.

## Limited administrative support

The `Get-LapsADPassword` cmdlet supports retrieval of the legacy Microsoft LAPS password attribute (`ms-Mcs-AdmPwd`). The `Account` and `PasswordUpdateTime` fields in the resulting output are always blank. For example:

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

The `Set-LapsADPasswordExpirationTime` cmdlet doesn't support expiring or modifying the legacy Microsoft LAPS password expiration attribute (`ms-Mcs-AdmPwdExpirationTime`).

The Windows LAPS property page in the Windows Server Active Directory Users and Computers management console doesn't support displaying or administering legacy Microsoft LAPS attributes.

## Logging

When Windows LAPS runs in legacy Microsoft LAPS emulation mode, a 10023 event is logged to detail the current policy configuration:

:::image type="content" source="./media/laps-scenarios-legacy/laps-scenarios-legacy-gpo-event.png" alt-text="Screenshot of the event log that shows a Microsoft LAPS configuration event log message.":::

Otherwise, the same events that are logged by Windows LAPS when it doesn't run in legacy Microsoft LAPS emulation mode are also logged when it runs in legacy Microsoft LAPS emulation mode.

## See also

This article doesn't go into detail about managing other aspects of legacy Microsoft LAPS. For more information, see the legacy Microsoft LAPS documentation on the download page:

- [Legacy Microsoft LAPS](https://www.microsoft.com/download/details.aspx?id=46899)

## Next steps

- [Configure Windows LAPS policy settings](laps-management-policy-settings.md)
