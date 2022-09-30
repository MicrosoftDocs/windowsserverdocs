---
title: Use Windows LAPS PowerShell cmdlets
description: Learn about Windows Local Administrator Password Solution (Windows LAPS) PowerShell cmdlets and how to use them.
author: jay98014
ms.author: jsimmons
ms.date: 07/04/2022
ms.topic: conceptual
---

# Use Windows LAPS PowerShell cmdlets

Windows Local Administrator Password Solution (Windows LAPS) includes a specific PowerShell module named LAPS. Learn how to use the cmdlets in this module and what they do.

> [!IMPORTANT]
> Windows LAPS currently is available only in Windows 11 Insider Preview Build 25145 and later. Support for the Windows LAPS Azure Active Directory scenario currently is limited to a small number of Windows Insider users.

## Cmdlet descriptions

The following table describes the cmdlets that are available in the LAPS PowerShell module:

|Name|Description|
|---|---|
|`Get-LapsAADPassword`|Use to query Azure Active Directory for Windows LAPS passwords.|
|`Get-LapsDiagnostics`|Use to collect diagnostic information for investigating issues.|
|`Find-LapsADExtendedRights`|Use to discover which identities have been granted permissions for an Organization Unit (OU) in Windows Server Active Directory.|
|`Get-LapsADPassword`|Use to query Windows Server Active Directory for Windows LAPS passwords.|
|`Invoke-LapsPolicyProcessing`|Use to initiate a policy processing cycle.|
|`Reset-LapsPassword`|Use to initiate an immediate password rotation. Use when backing up the password to either Azure Active Directory or Windows Server Active Directory.|
|`Set-LapsADAuditing`|Use to configure Windows LAPS-related auditing on OUs in Windows Server Active Directory.|
|`Set-LapsADComputerSelfPermission`|Use to configure an OU in Windows Server Active Directory to allow computer objects to update their Windows LAPS passwords.|
|`Set-LapsADPasswordExpirationTime`|Use to update a computer's Windows LAPS password expiration time in Windows Server Active Directory.|
|`Set-LapsADReadPasswordPermission`|Use to grant permission to read the Windows LAPS password information in Windows Server Active Directory.|
|`Set-LapsADResetPasswordPermission`|Use to grant permission to update the Windows LAPS password expiration time in Windows Server Active Directory.|
|`Update-LapsADSchema`|Use to extend the Windows Server Active Directory schema with the Windows LAPS schema attributes.|

> [!TIP]
>
> - The `Invoke-LapsPolicyProcessing` and `Reset-LapsPassword` cmdlets aren't affected by whether the password currently is backed up to Azure Active Directory or Windows Server Active Directory. In this scenario, both options are supported.
>- All cmdlets in the Windows LAPS PowerShell module support detailed logging when you use the  `-Verbose` parameter.

## Windows LAPS PowerShell vs. legacy Microsoft LAPS PowerShell

Legacy Microsoft LAPS includes a PowerShell module named AdmPwd.PS. The two modules have many functional similarities, but they also have many differences. This table provides a mapping between the two modules:

|Windows LAPS cmdlet|Legacy Microsoft LAPS cmdlet|
|---|---|
|`Get-LapsAADPassword`|Doesn't apply|
|`Get-LapsDiagnostics`|Doesn't apply|
|`Find-LapsADExtendedRights`|`Find-AdmPwdExtendedRights`|
|`Get-LapsADPassword`|`Get-AdmPwdPassword`|
|`Invoke-LapsPolicyProcessing`|Doesn't apply|
|`Reset-LapsPassword`|Doesn't apply|
|`Set-LapsADAuditing`|`Set-AdmPwdAuditing`|
|`Set-LapsADComputerSelfPermission`|`Set-AdmPwdComputerSelfPermission`|
|`Set-LapsADPasswordExpirationTime`|`Reset-AdmPwdPassword`|
|`Set-LapsADReadPasswordPermission`|`Set-AdmPwdReadPasswordPermission`|
|`Set-LapsADResetPasswordPermission`|`Set-AdmPwdResetPasswordPermission`|
|`Update-LapsADSchema`|`Update-AdmPwdADSchema`|

In addition to naming-related changes, the Windows LAPS PowerShell cmdlets for Windows Server Active Directory operate over an entirely different set of schema extensions. For more information, see [Windows LAPS schema extensions reference](laps-technical-reference.md#schema-extensions).

## Next steps

- [Get started with Windows LAPS in legacy Microsoft LAPS emulation mode](laps-scenarios-legacy.md)
- [Use Windows LAPS event logs](laps-management-event-log.md)
- [Key concepts in Windows LAPS](laps-concepts.md)
