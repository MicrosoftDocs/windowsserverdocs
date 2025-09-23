---
title: Windows LAPS PowerShell Cmdlets Overview
description: Explore Windows LAPS PowerShell cmdlets to manage passwords securely. Learn key features, benefits, and usage.
author: jay98014
ms.author: daknappe
ms.date: 05/06/2025
ms.topic: concept-article
ai-usage: ai-assisted
---

# Overview of Windows LAPS PowerShell Cmdlets

Windows Local Administrator Password Solution (Windows LAPS) includes the LAPS PowerShell module. Learn about its cmdlets, features, and how they compare to legacy Microsoft LAPS cmdlets to help you manage passwords securely.

## Cmdlet descriptions and usage

The following table describes the cmdlets that are available in the LAPS PowerShell module:

| Name | Description |
|--|--|
| [`Get-LapsAADPassword`](/powershell/module/laps/get-lapsaadpassword) | Query Microsoft Entra ID for Windows LAPS passwords. |
| [`Get-LapsDiagnostics`](/powershell/module/laps/get-lapsdiagnostics) | Collect diagnostic information for investigating issues. |
| [`Find-LapsADExtendedRights`](/powershell/module/laps/find-lapsadextendedrights) | Discover which identities have been granted permissions for an Organizational Unit (OU) in Windows Server Active Directory. |
| [`Get-LapsADPassword`](/powershell/module/laps/get-lapsadpassword) | Query Windows Server Active Directory for Windows LAPS passwords. |
| [`Invoke-LapsPolicyProcessing`](/powershell/module/laps/invoke-lapspolicyprocessing) | Initiate a policy processing cycle. |
| [`Reset-LapsPassword`](/powershell/module/laps/reset-lapspassword) | Initiate an immediate password rotation. Use when backing up the password to either Microsoft Entra ID or Windows Server Active Directory. |
| [`Set-LapsADAuditing`](/powershell/module/laps/set-lapsadauditing) | Configure Windows LAPS-related auditing on OUs in Windows Server Active Directory. |
| [`Set-LapsADComputerSelfPermission`](/powershell/module/laps/set-lapsadcomputerselfpermission) | Configure an OU in Windows Server Active Directory to allow computer objects to update their Windows LAPS passwords. |
| [`Set-LapsADPasswordExpirationTime`](/powershell/module/laps/set-lapsadpasswordexpirationtime) | Update a computer's Windows LAPS password expiration time in Windows Server Active Directory. |
| [`Set-LapsADReadPasswordPermission`](/powershell/module/laps/set-lapsadreadpasswordpermission) | Grant permission to read the Windows LAPS password information in Windows Server Active Directory. |
| [`Set-LapsADResetPasswordPermission`](/powershell/module/laps/set-lapsadresetpasswordpermission) | Grant permission to update the Windows LAPS password expiration time in Windows Server Active Directory. |
| [`Update-LapsADSchema`](/powershell/module/laps/update-lapsadschema) | Extend the Windows Server Active Directory schema with the Windows LAPS schema attributes. |

> [!TIP]
>
> - The `Invoke-LapsPolicyProcessing` and `Reset-LapsPassword` cmdlets aren't affected by whether the password currently is backed up to Microsoft Entra ID or Windows Server Active Directory. In this scenario, both options are supported.
>
> - All cmdlets in the Windows LAPS PowerShell module support detailed logging when you use the `-Verbose` parameter.

For more detailed information on each cmdlet, see [LAPS PowerShell Module](/powershell/module/laps/).

## Comparing Windows LAPS and legacy Microsoft LAPS PowerShell

Legacy Microsoft LAPS includes a PowerShell module named `AdmPwd.PS`. The two modules have many functional similarities, but they also have many differences. This table provides a mapping between the two modules:

| Windows LAPS cmdlet | Legacy Microsoft LAPS cmdlet |
|--|--|
| `Get-LapsAADPassword` | Not applicable |
| `Get-LapsDiagnostics` | Not applicable |
| `Find-LapsADExtendedRights` | `Find-AdmPwdExtendedRights` |
| `Get-LapsADPassword` | `Get-AdmPwdPassword` |
| `Invoke-LapsPolicyProcessing` | Not applicable |
| `Reset-LapsPassword` | Not applicable |
| `Set-LapsADAuditing` | `Set-AdmPwdAuditing` |
| `Set-LapsADComputerSelfPermission` | `Set-AdmPwdComputerSelfPermission` |
| `Set-LapsADPasswordExpirationTime` | `Reset-AdmPwdPassword` |
| `Set-LapsADReadPasswordPermission` | `Set-AdmPwdReadPasswordPermission` |
| `Set-LapsADResetPasswordPermission` | `Set-AdmPwdResetPasswordPermission` |
| `Update-LapsADSchema` | `Update-AdmPwdADSchema` |

In addition to naming-related changes, the Windows LAPS PowerShell cmdlets for Windows Server Active Directory operate over an entirely different set of schema extensions. For more information, see [Windows LAPS schema extensions reference](laps-technical-reference.md#schema-extensions).

## Next steps

- [Get started with Windows LAPS in legacy Microsoft LAPS emulation mode](laps-scenarios-legacy.md)
- [Use Windows LAPS event logs](laps-management-event-log.md)
- [Key concepts in Windows LAPS](laps-concepts-overview.md)
- [LAPS PowerShell module reference](/powershell/module/laps/)
