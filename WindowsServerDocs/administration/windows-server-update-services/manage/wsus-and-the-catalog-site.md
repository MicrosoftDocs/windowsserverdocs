---
title: WSUS and the Microsoft Update Catalog
description: Windows Server Update Service (WSUS) article - How to import updates into WSUS using PowerShell and the Microsoft Update Catalog.
ms.topic: article
ms.assetid: f19a8659-5a96-4fdd-a052-29e4547fe51a
ms.author: wscontent
author: JasonGerend
manager: mtillman
ms.date: 08/08/2023
---
# WSUS and the Microsoft Update Catalog

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The [Microsoft Update Catalog](https://catalog.update.microsoft.com) is a service that provides a listing of updates that can be distributed over a corporate network. You can use the catalog for finding information about Microsoft software updates, drivers, and hotfixes. WSUS currently includes an option to **Import Updates** from the Microsoft Update Catalog. However, the **Import Updates** action in WSUS was built using ActiveX, which is now deprecated. This import functionality within WSUS has been replaced with a PowerShell script. The script allows you to import a single update, or multiple updates into WSUS. This article provides information about the catalog, the import script, and how to use the script.

## Prerequisites for importing updates into WSUS

The following prerequisites are required to import updates into WSUS with the PowerShell script:

- Any computer that has the WSUS administrative console installed, whether or not it's a WSUS server, can be used to import updates.
  - When importing from a WSUS server, use an account that's a member of the WSUS Administrators group or the Local Administrators group.
  - When importing from a remote computer, use an account that's a member of the WSUS Administrators group and has administrative permissions on the local computer. Remote computers must be able to reach the WSUS server over the network.

## The Microsoft Update Catalog

The [Microsoft Update Catalog](https://catalog.update.microsoft.com) lets you search on various update fields and categories. These update fields include:

- Update title
- Description
- Applicable products
- Classifications
- Knowledge base articles numbers in the format of `KB1234567`

When searching for hardware updates, or drivers, you can also search for the following fields:

- Driver model
- Manufacturer
- Class
- The four-part hardware ID, such as `PCI\VEN_14E4&DEV_1677&SUBSYS_01AD1028`.

You can narrow the scope of your search by adding additional search terms. To search a specific string, use double quotes.

> [!NOTE]
> The catalog also allows you to download updates directly from the site using the download button. However, updates downloaded this way are are in `.MSU` format.  WSUS can't import updates in `.MSU` format. This file type is commonly used by the [Windows Update Standalone installer](https://support.microsoft.com//topic/description-of-the-windows-update-standalone-installer-in-windows-799ba3df-ec7e-b05e-ee13-1cdae8f23b19), [DISM](/windows-hardware/manufacture/desktop/dism-operating-system-package-servicing-command-line-options), or other updates tools. Some tools require that you extract the files from the `.MSU` before they can be used.

## Import updates into WSUS using PowerShell

Use the below instructions to import updates into WSUS:

1. Copy the [PowerShell script to import updates into WSUS](#powershell-script-to-import-updates-into-wsus) from this article into a text editor and save it as `ImportUpdateToWSUS.ps1`. Use a location you can easily access, such as `C:\temp`.
1. Open the Microsoft Update Catalog, [https://catalog.update.microsoft.com](https://catalog.update.microsoft.com), in a browser.
1. Search for an update you want to import into WSUS.
1. From the returned list, select the update you want to import into WSUS. The update details page opens.
1. Use the **Copy** button on the update details page to copy the **UpdateID**.
1. The script can be used to import a single update, or multiple updates.
    - To import multiple updates into WSUS, paste the updateIDs for each update you want to import into a text file. List one update ID per line then save the text file when you're done. Use a location you can easily access, such as `C:\temp\UpdateIDs.txt`.
    - To import a single update, you only need to copy the single updateID.
1. To import updates, open a PowerShell console as an administrator and run the script with the following syntax using any needed [parameters](#script-parameters):

   ```powershell
   C:\temp\ImportUpdateToWSUS.ps1 [-WsusServer] <String> [-PortNumber] <Int32> [-UseSsl] [-UpdateId] <String> [-UpdateIdFilePath] <string> [<CommonParameters>]
   ```

    **Example 1**: While signed into a WSUS server that uses the default port, import a single update using the following syntax:
   
    ```powershell
    .\ImportUpdateToWSUS.ps1 -UpdateId 12345678-90ab-cdef-1234-567890abcdef
    ```

   **Example 2**: Using a remote computer, import multiple updates into a WSUS server using SSL with the following syntax:
   
    ```powershell
    .\ImportUpdateToWSUS.ps1 -WsusServer WSUSServer.contoso.com -PortNumber 8531 -UseSsl -UpdateIdFilePath C:\temp\UpdateIDs.txt
    ```

1. The update files for updates that are imported are downloaded based on your **Update files** settings. For instance, if you use the option to **Download update files to this serer only when updates are approved**, the update files are downloaded when the update is approved. For more information about options for storing updates, see section [1.3 Choose a WSUS storage strategy](../plan/plan-your-wsus-deployment.md#13-choose-a-wsus-storage-strategy).

## PowerShell script to import updates into WSUS

```powershell
<#
.SYNOPSIS
Powershell script to import an update, or multiple updates into WSUS based on the UpdateID from the catalog.

.DESCRIPTION
This script takes user input and attempts to connect to the WSUS server.
Then it tries to import the update using the provided UpdateID from the catalog.

.INPUTS
The script takes WSUS server Name/IP, WSUS server port, SSL configuration option and UpdateID as input. UpdateID can be viewed and copied from the update details page for any update in the catalog, https://catalog.update.microsoft.com. 

.OUTPUTS
Writes logging information to standard output.

.EXAMPLE
# Use with remote server IP, port and SSL
.\ImportUpdateToWSUS.ps1 -WsusServer 127.0.0.1 -PortNumber 8531 -UseSsl -UpdateId 12345678-90ab-cdef-1234-567890abcdef

.EXAMPLE
# Use with remote server Name, port and SSL
.\ImportUpdateToWSUS.ps1 -WsusServer WSUSServer1.us.contoso.com -PortNumber 8531 -UseSsl -UpdateId 12345678-90ab-cdef-1234-567890abcdef

.EXAMPLE
# Use with remote server IP, defaultport and no SSL
.\ImportUpdateToWSUS.ps1 -WsusServer 127.0.0.1  -UpdateId 12345678-90ab-cdef-1234-567890abcdef

.EXAMPLE
# Use with localhost default port
.\ImportUpdateToWSUS.ps1 -UpdateId 12345678-90ab-cdef-1234-567890abcdef

.EXAMPLE
# Use with localhost default port, file with updateID's
.\ImportUpdateToWSUS.ps1 -UpdateIdFilePath .\file.txt


.NOTES  
# On error, try enabling TLS: https://learn.microsoft.com/mem/configmgr/core/plan-design/security/enable-tls-1-2-client

# Sample registry add for the WSUS server from command line. Restarts the WSUSService and IIS after adding:
reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319 /V SchUseStrongCrypto /T REG_DWORD /D 1

## Sample registry add for the WSUS server from PowerShell. Restarts WSUSService and IIS after adding:
$registryPath = "HKLM:\Software\Microsoft\.NETFramework\v4.0.30319"
$Name = "SchUseStrongCrypto"
$value = "1" 
if (!(Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}
New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null
Restart-Service WsusService, w3svc

# Update import logs/errors are under %ProgramFiles%\Update Services\LogFiles\SoftwareDistribution.log

#>

param(
    [Parameter(Mandatory = $false, HelpMessage = "Specifies the name of a WSUS server, if not specified connects to localhost")]
    # Specifies the name of a WSUS server, if not specified connects to localhost.
    [string]$WsusServer,

    [Parameter(Mandatory = $false, HelpMessage = "Specifies the port number to use to communicate with the upstream WSUS server, default is 8530")]
    # Specifies the port number to use to communicate with the upstream WSUS server, default is 8530.
    [ValidateSet("80", "443", "8530", "8531")]
    [int32]$PortNumber = 8530,

    [Parameter(Mandatory = $false, HelpMessage = "Specifies that the WSUS server should use Secure Sockets Layer (SSL) via HTTPS to communicate with an upstream server")]
    # Specifies that the WSUS server should use Secure Sockets Layer (SSL) via HTTPS to communicate with an upstream server.  
    [Switch]$UseSsl,

    [Parameter(Mandatory = $true, HelpMessage = "Specifies the update Id we should import to WSUS", ParameterSetName = "Single")]
    # Specifies the update Id we should import to WSUS
    [ValidateNotNullOrEmpty()]
    [String]$UpdateId,

    [Parameter(Mandatory = $true, HelpMessage = "Specifies path to a text file containing a list of update ID's on each line", ParameterSetName = "Multiple")]
    # Specifies path to a text file containing a list of update ID's on each line.
    [ValidateNotNullOrEmpty()]
    [String]$UpdateIdFilePath
)

Set-StrictMode -Version Latest

# set server options
$serverOptions = "Get-WsusServer"
if ($psBoundParameters.containsKey('WsusServer')) { $serverOptions += " -Name $WsusServer -PortNumber $PortNumber" }
if ($UseSsl) { $serverOptions += " -UseSsl" }

# empty updateID list
$updateList = @()

# get update id's
if ($UpdateIdFilePath) {
    if (Test-Path $UpdateIdFilePath) {
        foreach ($id in (Get-Content $UpdateIdFilePath)) {
            $updateList += $id.Trim()
        }
    }
    else {
        Write-Error "[$UpdateIdFilePath]: File not found"
		return
    }
}
else {
    $updateList = @($UpdateId)
}

# get WSUS server
Try {
    Write-Host "Attempting WSUS Connection using $serverOptions... " -NoNewline
    $server = invoke-expression $serverOptions
    Write-Host "Connection Successful"
}
Catch {
    Write-Error $_
    return
}

# empty file list
$FileList = @()

# call ImportUpdateFromCatalogSite on WSUS
foreach ($uid in $updateList) {
    Try {
        Write-Host "Attempting WSUS update import for Update ID: $uid... " -NoNewline
        $server.ImportUpdateFromCatalogSite($uid, $FileList)
        Write-Host "Import Successful"
    }
    Catch {
        Write-Error "Failed. $_"
    }
}

```

### Script parameters

**WsusServer**: &lt;string> </br>
Specifies the name of a WSUS server. If not specified, the script connects to localhost. 

- **Required**: false
- **Default value**: localhost

**PortNumber**: &lt;Int32> </br>
Specifies the port number to use to communicate with the upstream WSUS server. 
- **Required**: false
- **Default value**: 8530
- **Allowed values**: 80, 443, 8530, 8531

**UseSsl**: &lt;switch>  </br>
Specifies if Secure Sockets Layer (SSL) via HTTPS should be used to communicate with the WSUS server. If this parameter name is present the parameter tests `$true` and the connection is made to the WSUS server using SSL, otherwise, `false`. When using the **USeSSL** parameter, set the **PortNumber** to either 443 or 8531.

- **Required**: false

**UpdateId**: &lt;string> </br>
Specifies the update ID you want to import to WSUS. This parameter is required if you're importing a single update. **UpdateId** can't be used with **UpdateIdFilePath**. 

- **Required**: true, when importing a single updateID specified as a script parameter

**UpdateIdFilePath**: &lt;string> </br>
Specifies the path to a text file containing a list of update IDs on each line. This parameter is required if you're importing multiple updates. **UpdateIdFilePath** can't be used with **UpdateId**.

- **Required**: true, when using a text file to import multiple updates

**CommonParameters**: </br>
Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see [About CommonParameters](/powershell/module/microsoft.powershell.core/about/about_commonparameters)

## Restricting access to hotfixes

WSUS administrators might consider restricting access to the hotfixes they've downloaded from the Microsoft Update Catalog. To restrict the available hotfixes complete the following steps:

1. Start the **Internet Information Services (IIS) Manager** console.
1. Navigate to the **Content** node under **WSUS Administration** web site.
1. On the **Content Home** pane, double-click in the **Authentication** option.
1. Select **Anonymous Authentication** and select **Disable** in the **Actions** pane on the right.
1. Select **Windows Authentication** and select **Enable** in the **Actions** pane on the right.
1. In the WSUS administrative console, create a WSUS target group for the computers that need the hotfix, and add them to the group. For more information about computers and groups, see [Managing WSUS Client computers and WSUS computer Groups](managing-wsus-client-computers-and-wsus-computer-groups.md) in this guide, and [Configure WSUS computer groups](../deploy/2-configure-wsus.md#24-configure-wsus-computer-groups) in the WSUS deployment guide.
1. Download the files for the hotfix.
1. Set the permissions of these files so that only machine accounts of those machines can read them. You'll also need to allow the Network Service account full access to the files.
1. Approve the hotfix for the WSUS target group created in Step 2.

> [!NOTE]
> You can remove updates that are imported from the Microsoft Update Catalog that are set as either **Not Approved** or **Declined**, by running the WSUS Server cleanup Wizard. You can re-import updates that have been previously removed from your WSUS systems.

## Importing updates in different languages

The catalog includes updates that support multiple languages.

> [!IMPORTANT]
> Match the languages supported by the WSUS server with the languages supported by the imported updates.

If the WSUS server doesn't support all the languages included in the update, the update won't be deployed to client computers. If an update supporting multiple languages has been downloaded to the WSUS server but not yet deployed to client computers, and an administrator deselects one of the languages included in the update, the update won't be deployed to the clients.
