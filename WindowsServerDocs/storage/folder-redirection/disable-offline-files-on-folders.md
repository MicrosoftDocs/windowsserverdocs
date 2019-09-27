---
title: Disable Offline Files on individual redirected folders
description: How to disable Offline Files caching on individual folders that are redirected to network shares by using Folder Redirection.
ms.prod: windows-server 
ms.topic: article 
author: JasonGerend 
ms.author: jgerend 
ms.technology: storage 
ms.date: 09/10/2018
ms.localizationpriority: medium
---
# Disable Offline Files on individual redirected folders

>Applies to: Windows 10, Windows 8, Windows 8.1, Windows Server 2019, Windows Server 2016, Windows Server 2012, Windows Server 2012 R2, Windows (Semi-annual Channel)

This topic describes how to disable Offline Files caching on individual folders that are redirected to network shares by using Folder Redirection. This provides the ability to specify which folders to exclude from caching locally, reducing the Offline Files cache size and time required to synchronize Offline Files.

>[!NOTE]
>This topic includes sample Windows PowerShell cmdlets that you can use to automate some of the procedures described. For more information, see [Windows PowerShell Basics](https://docs.microsoft.com/powershell/scripting/getting-started/fundamental/windows-powershell-basics?view=powershell-6).

## Prerequisites

To disable Offline Files caching of specific redirected folders, your environment must meet the following prerequisites.

- An Active Directory Domain Services (AD DS) domain, with client computers joined to the domain. There are no forest or domain functional-level requirements or schema requirements.
- Client computers running Windows 10, Windows 8.1, Windows 8, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012 or Windows (Semi-annual Channel).
- A computer with Group Policy Management installed.

## Disabling Offline Files on individual redirected folders

To disable Offline Files caching of specific redirected folders, use Group Policy to enable the **Do not automatically make specific redirected folders available offline** policy setting for the appropriate Group Policy Object (GPO). Configuring this policy setting to **Disabled** or **Not Configured** makes all redirected folders available offline.

>[!NOTE]
>Only domain administrators, enterprise administrators, and members of the Group Policy creator owners group can create GPOs.

### To disable Offline Files on specific redirected folders

1. Open **Group Policy Management**.
2. To optionally create a new GPO that specifies which users should have redirected folders excluded from being made available offline, right-click the appropriate domain or organizational unit (OU) and then select **Create a GPO in this domain, and Link it here**.
3. In the console tree, right-click the GPO for which you want to configure the Folder Redirection settings and then select **Edit**. The Group Policy Management Editor appears.
4. In the console tree, under **User Configuration**, expand **Policies**, expand **Administrative Templates**, expand **System**, and expand **Folder Redirection**.
5. Right-click **Do not automatically make specific redirected folders available offline** and then select **Edit**. The **Do not automatically make specific redirected folders available offline** window appears.
6. Select **Enabled**. In the **Options** pane select the folders that should not be made available offline by selecting the appropriate check boxes. Select **OK**.

### Windows PowerShell equivalent commands

The following Windows PowerShell cmdlet or cmdlets perform the same function as the procedure described in [Disabling Offline Files on individual redirected folders](#disabling-offline-files-on-individual-redirected-folders). Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.

This example creates a new GPO named *Offline Files Settings* in the *MyOu* organizational unit in the *contoso.com* domain (the LDAP distinguished name is "ou=MyOU,dc=contoso,dc=com"). It then disables Offline Files for the Videos redirected folder.

```PowerShell
New-GPO -Name "Offline Files Settings" | New-Gplink -Target "ou=MyOu,dc=contoso,dc=com" -LinkEnabled Yes

Set-GPRegistryValue –Name "Offline Files Settings" –Key
"HKCU\Software\Policies\Microsoft\Windows\NetCache\{18989B1D-99B5-455B-841C-AB7C74E4DDFC}" -ValueName DisableFRAdminPinByFolder –Type DWORD –Value 1
```

See the following table for a listing of registry key names (folder GUIDs) to use for each redirected folder.

|Redirected folder|Registry key name (folder GUID)|
|---|---|
|AppData(Roaming)|{3EB685DB-65F9-4CF6-A03A-E3EF65729F3D}|
|Desktop|{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}|
|Start Menu|{625B53C3-AB48-4EC1-BA1F-A1EF4146FC19}|
|Documents|{FDD39AD0-238F-46AF-ADB4-6C85480369C7}|
|Pictures|{33E28130-4E1E-4676-835A-98395C3BC3BB}|
|Music|{4BD8D571-6D19-48D3-BE97-422220080E43}|
|Videos|{18989B1D-99B5-455B-841C-AB7C74E4DDFC}|
|Favorites|{1777F761-68AD-4D8A-87BD-30B759FA33DD}|
|Contacts|{56784854-C6CB-462b-8169-88E350ACB882}|
|Downloads|{374DE290-123F-4565-9164-39C4925E467B}|
|Links|{BFB9D5E0-C6A9-404C-B2B2-AE6DB6AF4968}|
|Searches|{7D1D3A04-DEBB-4115-95CF-2F29DA2920DA}|
|Saved Games|{4C5C32FF-BB9D-43B0-B5B4-2D72E54EAAA4}|

## More information

- [Folder Redirection, Offline Files, and Roaming User Profiles overview](folder-redirection-rup-overview.md)
- [Deploy Folder Redirection with Offline Files](deploy-folder-redirection.md)