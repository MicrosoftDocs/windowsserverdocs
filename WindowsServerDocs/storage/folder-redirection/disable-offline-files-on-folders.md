---
---
# Disable Offline Files on Individual Redirected Folders

 


Applies To: Windows 10, Windows 8, Windows 8.1, Windows Server 2012, Windows Server 2012 R2

This topic describes how to disable Offline Files caching on individual folders that are redirected to network shares by using Folder Redirection. This provides the ability to specify which folders to exclude from caching locally, reducing the Offline Files cache size and time required to synchronize Offline Files.

**In this document**

  - [Prerequisites]()

  - [Disabling Offline Files on individual redirected folders]()


> [!NOTE]
> This topic includes sample Windows PowerShell cmdlets that you can use to automate some of the procedures described. For more information, see <A href="http://go.microsoft.com/fwlink/p/?linkid=230693">Using Cmdlets</A>.


## Prerequisites

To disable Offline Files caching of specific redirected folders, your environment must meet the following prerequisites.

  - An Active Directory Domain Services (AD DS) domain, with client computers joined to the domain. There are no forest or domain functional-level requirements or schema requirements.

  - Client computers running Windows 8.1, Windows 8, Windows Server 2012 R2, or Windows Server 2012.

  - A computer with Group Policy Management installed.

## Disabling Offline Files on individual redirected folders

To disable Offline Files caching of specific redirected folders, use Group Policy to enable the **Do not automatically make specific redirected folders available offline** policy setting for the appropriate Group Policy Object (GPO). Configuring this policy setting to **Disabled** or **Not Configured** makes all redirected folders available offline.


> [!NOTE]
> Only domain administrators, enterprise administrators, and members of the Group Policy creator owners group can create GPOs.


### To disable Offline Files on specific redirected folders

1.  Open **Group Policy Management**.

2.  To optionally create a new GPO that specifies which users should have redirected folders excluded from being made available offline, right-click the appropriate domain or organizational unit (OU) and then click **Create a GPO in this domain, and Link it here**.

3.  In the console tree, right-click the GPO for which you want to configure the Folder Redirection settings and then click **Edit**. The Group Policy Management Editor appears.

4.  In the console tree, under **User Configuration**, expand **Policies**, expand **Administrative Templates**, expand **System**, and expand **Folder Redirection**.

5.  Right-click **Do not automatically make specific redirected folders available offline** and then click **Edit**. The **Do not automatically make specific redirected folders available offline** window appears.

6.  Click **Enabled**. In the **Options** pane select the folders that should not be made available offline by selecting the appropriate check boxes. Click **OK**.

![](images\Hh831478.eda3e676-68d6-4a56-90af-dd29179cfd9b(WS.11).jpeg)****Windows PowerShell equivalent commands****

The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.

This example creates a new GPO named *Offline Files Settings* in the *MyOu* organizational unit in the *contoso.com* domain (the LDAP distinguished name is "ou=MyOU,dc=contoso,dc=com"). It then disables Offline Files for the Videos redirected folder.

    New-GPO -Name "Offline Files Settings" | New-Gplink -Target "ou=MyOu,dc=contoso,dc=com" -LinkEnabled Yes
    
    Set-GPRegistryValue –Name "Offline Files Settings" –Key 
    "HKCU\Software\Policies\Microsoft\Windows\NetCache\{18989B1D-99B5-455B-841C-AB7C74E4DDFC}" -ValueName DisableFRAdminPinByFolder –Type DWORD –Value 1

See the following table for a listing of registry key names (folder GUIDs) to use for each redirected folder.

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Redirected folder</p></th>
<th><p>Registry key name (folder GUID)</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>AppData(Roaming)</p></td>
<td><p>{3EB685DB-65F9-4CF6-A03A-E3EF65729F3D}</p></td>
</tr>
<tr class="even">
<td><p>Desktop</p></td>
<td><p>{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}</p></td>
</tr>
<tr class="odd">
<td><p>Start Menu</p></td>
<td><p>{625B53C3-AB48-4EC1-BA1F-A1EF4146FC19}</p></td>
</tr>
<tr class="even">
<td><p>Documents</p></td>
<td><p>{FDD39AD0-238F-46AF-ADB4-6C85480369C7}</p></td>
</tr>
<tr class="odd">
<td><p>Pictures</p></td>
<td><p>{33E28130-4E1E-4676-835A-98395C3BC3BB}</p></td>
</tr>
<tr class="even">
<td><p>Music</p></td>
<td><p>{4BD8D571-6D19-48D3-BE97-422220080E43}</p></td>
</tr>
<tr class="odd">
<td><p>Videos</p></td>
<td><p>{18989B1D-99B5-455B-841C-AB7C74E4DDFC}</p></td>
</tr>
<tr class="even">
<td><p>Favorites</p></td>
<td><p>{1777F761-68AD-4D8A-87BD-30B759FA33DD}</p></td>
</tr>
<tr class="odd">
<td><p>Contacts</p></td>
<td><p>{56784854-C6CB-462b-8169-88E350ACB882}</p></td>
</tr>
<tr class="even">
<td><p>Downloads</p></td>
<td><p>{374DE290-123F-4565-9164-39C4925E467B}</p></td>
</tr>
<tr class="odd">
<td><p>Links</p></td>
<td><p>{BFB9D5E0-C6A9-404C-B2B2-AE6DB6AF4968}</p></td>
</tr>
<tr class="even">
<td><p>Searches</p></td>
<td><p>{7D1D3A04-DEBB-4115-95CF-2F29DA2920DA}</p></td>
</tr>
<tr class="odd">
<td><p>Saved Games</p></td>
<td><p>{4C5C32FF-BB9D-43B0-B5B4-2D72E54EAAA4}</p></td>
</tr>
</tbody>
</table>

## See Also

[Folder Redirection, Offline Files, and Roaming User Profiles overview](hh848267\(v=ws.11\).md)  
[Deploy Folder Redirection with Offline Files](jj649078\(v=ws.11\).md)