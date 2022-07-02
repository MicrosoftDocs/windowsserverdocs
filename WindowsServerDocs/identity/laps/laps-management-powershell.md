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

## Overview

Windows LAPS includes a new PowerShell module named 'LAPS'. This article provides an overview of the various cmdlets in this module.

## Cmdlet descriptions

|Cmdlet name|Description|
|---|---|
|`Get-LapsAADPassword`|Used for querying Azure AD for LAPS passwords|
|`Get-LapsDiagnostics`|Used to collect diagnostic information for investigating problems|
|`Find-LapsADExtendedRights`|Used to discover which identities have been granted permissions on an OU in Active Directory|
|`Get-LapsADPassword`|Used for querying Active Directory for LAPS passwords|
|`Invoke-LapsPolicyProcessing`|Used to initiate a policy processing cycle|
|`Reset-LapsPassword`|Used to initiate an immediate password rotation; may be used when backing up the password to either Azure AD or AD|
|`Set-LapsADAuditing`|Used to configure Windows LAPS-related auditing on OUs in AD|
|`Set-LapsADComputerSelfPermission`|Used to configure an OU in Active Directory to allow computer objects to update their Windows LAPS passwords|
|`Set-LapsADPasswordExpirationTime`|Used to update a computer's Windows LAPS password expiration time in Active Directory|
|`Set-LapsADReadPasswordPermission`|Used to grant permission to read the Windows LAPS password information in Active Directory|
|`Set-LapsADResetPasswordPermission`|Used to grant permission to update the Windows LAPS password expiration time in Active Directory|
|`Update-LapsADSchema`|Used to extend the Active Directory schema with the Windows LAPS schema attributes|

> [!TIP]
> The `Invoke-LapsPolicyProcessing` and `Reset-LapsPassword` cmdlets are agnostic as to whether the password is currently being backed up to Azure AD or Active Directory. They are supported in both cases.

## Use -Verbose for detailed output

All cmdlets in the Windows LAPS PowerShell module support detailed logging when the -Verbose parameter is specified.

## Related articles

[LAPS Management](..\laps\laps-management.md)
