---
ms.assetid: 05ded58e-8e65-4110-8a6f-4f4ca0c4f183
title: Windows Local Administrator Password Solution PowerShell
description: Windows Local Administrator Password Solution PowerShell
author: jsimmons
ms.author: jsimmons
manager: jsimmons
ms.date: 07/04/2022
ms.topic: article
---

# Windows LAPS PowerShell

Windows LAPS includes a new PowerShell module named 'LAPS'. This article provides an overview of the various cmdlets in this module.

## Cmdlet descriptions

|Cmdlet name|Description|
|---|---|
|`Get-LapsAADPassword`|Used for querying Azure Active Directory for LAPS passwords|
|`Get-LapsDiagnostics`|Used to collect diagnostic information for investigating problems|
|`Find-LapsADExtendedRights`|Used to discover which identities have been granted permissions on an OU in Windows Server Active Directory|
|`Get-LapsADPassword`|Used for querying Windows Server Active Directory for LAPS passwords|
|`Invoke-LapsPolicyProcessing`|Used to initiate a policy processing cycle|
|`Reset-LapsPassword`|Used to initiate an immediate password rotation; may be used when backing up the password to either Azure Active Directory or Windows Server Active Directory|
|`Set-LapsADAuditing`|Used to configure Windows LAPS-related auditing on OUs in Windows Server Active Directory|
|`Set-LapsADComputerSelfPermission`|Used to configure an OU in Windows Server Active Directory to allow computer objects to update their Windows LAPS passwords|
|`Set-LapsADPasswordExpirationTime`|Used to update a computer's Windows LAPS password expiration time in Windows Server Active Directory|
|`Set-LapsADReadPasswordPermission`|Used to grant permission to read the Windows LAPS password information in Windows Server Active Directory|
|`Set-LapsADResetPasswordPermission`|Used to grant permission to update the Windows LAPS password expiration time in Windows Server Active Directory|
|`Update-LapsADSchema`|Used to extend the Windows Server Active Directory schema with the Windows LAPS schema attributes|

> [!TIP]
> The `Invoke-LapsPolicyProcessing` and `Reset-LapsPassword` cmdlets are agnostic as to whether the password is currently being backed up to Azure Active Directory or Windows Server Active Directory. They are supported in both cases.

> [!TIP]
> All cmdlets in the Windows LAPS PowerShell module support detailed logging when the -Verbose parameter is specified.

## Comparison with legacy LAPS PowerShell

Legacy LAPS included a PowerShell module named `AdmPwd.PS`. There are many functional similarities across the two modules, but also many differences. This table provides a mapping between the two modules.

|Windows LAPS cmdlet|Legacy LAPS cmdlet|
|---|---|
|`Get-LapsAADPassword`|N\A|
|`Get-LapsDiagnostics`|N\A|
|`Find-LapsADExtendedRights`|`Find-AdmPwdExtendedRights`|
|`Get-LapsADPassword`|`Get-AdmPwdPassword`|
|`Invoke-LapsPolicyProcessing`|N\A|
|`Reset-LapsPassword`|N\A|
|`Set-LapsADAuditing`|`Set-AdmPwdAuditing`|
|`Set-LapsADComputerSelfPermission`|`Set-AdmPwdComputerSelfPermission`|
|`Set-LapsADPasswordExpirationTime`|`Reset-AdmPwdPassword`|
|`Set-LapsADReadPasswordPermission`|`Set-AdmPwdReadPasswordPermission`|
|`Set-LapsADResetPasswordPermission`|`Set-AdmPwdResetPasswordPermission`|
|`Update-LapsADSchema`|`Update-AdmPwdADSchema`|

In addition to naming-related changes, the Windows LAPS Windows Server Active Directory-related cmdlets operate over an entirely different set of schema extensions. For more information, see [Windows Server Active Directory Schema Extensions](../laps/laps-technical-reference.md#windows-server-active-directory-schema-extensions).

## See also

[Getting Started with Windows LAPS in Legacy LAPS Emulation Mode](..\laps\laps-scenarios-legacy.md)

[Windows LAPS Management](..\laps\laps-management.md)
