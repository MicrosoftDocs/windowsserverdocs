---
title: Disable Offline Files on Individual Redirected Folders
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f54cb750-1a0a-4a0d-92cd-8dbb57e90ba8
---
# Disable Offline Files on Individual Redirected Folders
This topic describes how to disable Offline Files caching on individual folders that are redirected to network shares by using Folder Redirection. This provides the ability to specify which folders to exclude from caching locally, reducing the Offline Files cache size and time required to synchronize Offline Files.  
  
**In this document**  
  
-   [Prerequisites](#Test_Prerequisites)  
  
-   [Disabling Offline Files on individual redirected folders](#Test_Step1Stepname)  
  
> [!NOTE]  
> [!INCLUDE[wps_howtorun](../Token/wps_howtorun_md.md)]  
  
## <a name="Test_Prerequisites"></a>Prerequisites  
To disable Offline Files caching of specific redirected folders, your environment must meet the following prerequisites.  
  
-   An Active Directory Domain Services \(AD DS\) domain, with client computers joined to the domain. There are no forest or domain functional\-level requirements or schema requirements.  
  
-   Client computers running [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   A computer with Group Policy Management installed.  
  
## <a name="Test_Step1Stepname"></a>Disabling Offline Files on individual redirected folders  
To disable Offline Files caching of specific redirected folders, use Group Policy to enable the **Do not automatically make specific redirected folders available offline** policy setting for the appropriate Group Policy Object \(GPO\). Configuring this policy setting to **Disabled** or **Not Configured** makes all redirected folders available offline.  
  
> [!NOTE]  
> Only domain administrators, enterprise administrators, and members of the Group Policy creator owners group can create GPOs.  
  
#### To disable Offline Files on specific redirected folders  
  
1.  Open **Group Policy Management**.  
  
2.  To optionally create a new GPO that specifies which users should have redirected folders excluded from being made available offline, right\-click the appropriate domain or organizational unit \(OU\) and then click **Create a GPO in this domain, and Link it here**.  
  
3.  In the console tree, right\-click the GPO for which you want to configure the Folder Redirection settings and then click **Edit**. The Group Policy Management Editor appears.  
  
4.  In the console tree, under **User Configuration**, expand **Policies**, expand **Administrative Templates**, expand **System**, and expand **Folder Redirection**.  
  
5.  Right\-click **Do not automatically make specific redirected folders available offline** and then click **Edit**. The **Do not automatically make specific redirected folders available offline** window appears.  
  
6.  Click **Enabled**. In the **Options** pane select the folders that should not be made available offline by selecting the appropriate check boxes. Click **OK**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
This example creates a new GPO named *Offline Files Settings* in the *MyOu* organizational unit in the *contoso.com* domain \(the LDAP distinguished name is `"ou=MyOU,dc=contoso,dc=com"`\). It then disables Offline Files for the Videos redirected folder.  
  
```powershell  
New-GPO -Name "Offline Files Settings" | New-Gplink -Target "ou=MyOu,dc=contoso,dc=com" -LinkEnabled Yes  
  
Set-GPRegistryValue –Name "Offline Files Settings" –Key   
"HKCU\Software\Policies\Microsoft\Windows\NetCache\{18989B1D-99B5-455B-841C-AB7C74E4DDFC}" -ValueName DisableFRAdminPinByFolder –Type DWORD –Value 1  
```  
  
See the following table for a listing of registry key names \(folder GUIDs\) to use for each redirected folder.  
  
|Redirected folder|Registry key name \(folder GUID\)|  
|---------------------|-------------------------------------|  
|AppData\(Roaming\)|{3EB685DB\-65F9\-4CF6\-A03A\-E3EF65729F3D}|  
|Desktop|{B4BFCC3A\-DB2C\-424C\-B029\-7FE99A87C641}|  
|Start Menu|{625B53C3\-AB48\-4EC1\-BA1F\-A1EF4146FC19}|  
|Documents|{FDD39AD0\-238F\-46AF\-ADB4\-6C85480369C7}|  
|Pictures|{33E28130\-4E1E\-4676\-835A\-98395C3BC3BB}|  
|Music|{4BD8D571\-6D19\-48D3\-BE97\-422220080E43}|  
|Videos|{18989B1D\-99B5\-455B\-841C\-AB7C74E4DDFC}|  
|Favorites|{1777F761\-68AD\-4D8A\-87BD\-30B759FA33DD}|  
|Contacts|{56784854\-C6CB\-462b\-8169\-88E350ACB882}|  
|Downloads|{374DE290\-123F\-4565\-9164\-39C4925E467B}|  
|Links|{BFB9D5E0\-C6A9\-404C\-B2B2\-AE6DB6AF4968}|  
|Searches|{7D1D3A04\-DEBB\-4115\-95CF\-2F29DA2920DA}|  
|Saved Games|{4C5C32FF\-BB9D\-43B0\-B5B4\-2D72E54EAAA4}|  
  
## See Also  
[Folder Redirection, Offline Files, and Roaming User Profiles overview](../Topic/Folder-Redirection,-Offline-Files,-and-Roaming-User-Profiles-overview.md)  
[Deploy Folder Redirection with Offline Files](../Topic/Deploy-Folder-Redirection-with-Offline-Files.md)  
  
