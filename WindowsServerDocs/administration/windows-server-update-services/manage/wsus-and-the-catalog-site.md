---
title: WSUS and the Catalog Site
description: Windows Server Update Service (WSUS) article - How to import hotfixes into WSUS by accessing the Microsoft Update catalog site
ms.topic: article
ms.assetid: f19a8659-5a96-4fdd-a052-29e4547fe51a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 07/26/2023
---
# WSUS and the Microsoft Update Catalog site

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The [Microsoft Update Catalog](https://www.catalog.update.microsoft.com) is a service that provides a listing of updates that can be distributed over a corporate network. You can use the catalog for finding information about Microsoft software updates, drivers, and hotfixes. WSUS currently includes an option to **Import Updates** from the Microsoft Update Catalog. However, the **Import Updates** action in WSUS was built using ActiveX, which is now deprecated. This import functionality within WSUS has been replaced with a PowerShell script.

## Prerequisites for importing updates into WSUS

In order to import hotfixes into WSUS with the PowerShell script, you must be able to access the Microsoft Update Catalog site from a computer that has the WSUS console installed. Any computer that has the WSUS administrative console installed, whether or not it's a WSUS server, can be used to import from the catalog. You must be signed in to the computer as an administrator to import hotfixes with PowerShell.

## The Microsoft Update Catalog site

The [Microsoft Update Catalog](https://www.catalog.update.microsoft.com) lets you search on a variety of update fields and categories. These update fields include:
- Update title
- Description
- Applicable products
- Classifications
- Knowledge base articles numbers in the format of `KB1234567`

When searching for hardware updates, or drivers, you can also search for the following fields:
- Driver model
- Manufacturer
- Class
- The 4-part hardware id, such as `PCI\VEN_14E4&DEV_1677&SUBSYS_01AD1028`.

You can narrow the scope of your search by adding additional search terms. 

> [!Note]
> The catalog also allows you to download updates directly from the site using the download button. However, updates downloaded this way are are in `.MSU` format.  WSUS can't import updates in `.MSU` format. This file type is commonly used by the [Windows Update Standalone installer](https://support.microsoft.com//topic/description-of-the-windows-update-standalone-installer-in-windows-799ba3df-ec7e-b05e-ee13-1cdae8f23b19), [DISM](/windows-hardware/manufacture/desktop/dism-operating-system-package-servicing-command-line-options), or other updates tools. Some tools require that you extract the files from the `.MSU` before they can be used.

## Import updates into WSUS using PowerShell

Use the below instructions to import updates into WSUS:

1. Open the Microsoft Update Catalog site, [https://www.catalog.update.microsoft.com](https://www.catalog.update.microsoft.com), in a browser window.
1. Search for an update you want to import into WSUS.
1. From the returned list, select the update you want to import into WSUS. The update details page will open.
1. Use the **Copy** button to copy the update ID. The update ID is also the GUID located after the `?id=` in the URL of the update details page. For example, in the URL `https://www.catalog.update.microsoft.com/ScopedViewInline.aspx?updateid=12345678-90ab-cdef-1234-567890abcdef` the update ID is `12345678-90ab-cdef-1234-567890abcdef`.
1. 

Usage: C:\temp\ImportUpdateToWSUS.ps1 [-WsusServer] <String> [-PortNumber] <Int32> [-UseSsl] [-UpdateId] <String> [<CommonParameters>] 

## PowerShell script to import updates into WSUS

```powershell
param(
    [Parameter()][String]
    # Specifies the name of a WSUS server, if not specified connects to localhost.
    $WsusServer,

    [Parameter()][Int32]
    # Specifies the port number to use to communicate with the upstream WSUS server, default is 8530.
    [ValidateSet("80","443","8530","8531")] 
    $PortNumber = 8530,   
    
    [Parameter()][Switch]
    # Specifies that the WSUS server should use Secure Sockets Layer (SSL) via HTTPS to communicate with an upstream server.
    $UseSsl,
    
    [Parameter(Mandatory)][String]
    [ValidateNotNullOrEmpty()]
    # Specifies the update Id we should import to WSUS
    $UpdateId
)

set-strictMode -version latest

#Empty file list
$FileList = @()

#set server options 
$serverOptions = "Get-WsusServer"
if($psBoundParameters.containsKey('WsusServer')) { $serverOptions += " -Name $WsusServer -PortNumber $PortNumber" }
if($UseSsl) { $serverOptions += " -UseSsl" }

#Get WSUS Server and Import Update
Try
{
    Write-Host "Attempting WSUS Connection"

    #Attempt server connection
    $server = invoke-expression $serverOptions

    Write-Host "WSUS Connection Successful:" $server.Name
    Write-Host "Attempting WSUS update import:" $UpdateId

    #Call ImportUpdateFromCatalogSite on WSUS
    $server.ImportUpdateFromCatalogSite($UpdateId,$FileList)

    Write-Host "WSUS update import Successful"
}
Catch
{
    Write-Host $_
}


```

### 

<!--



1. In the WSUS administrative console, select either the top server node or **Updates**, and in the **Actions** pane select **Import Updates**. A browser window will open at the Microsoft Update Catalog Web site.

1. You can browse this site for Windows hotfixes and hardware drivers. When you have found the ones you want, add them to your basket.

1. When you have finished browsing, go to the basket and select import to import your updates. To download the updates without importing them, clear the **Import directly into Windows Server Update Services** checkbox.

Approved updates imported from the Microsoft Update Catalog Site are downloaded the next time the WSUS server synchronizes. They aren't downloaded at the time of import from the Microsoft Update Catalog Site.

You must access the Microsoft Update Catalog Site through the WSUS console to ensure that the updates are imported in a WSUS-compatible format. If you access the Microsoft Update Catalog website manually, any updates that you download aren't imported into the WSUS server, but instead are downloaded as individual `.MSU` files. WSUS doesn't currently have a supported mechanism for importing files in the `.MSU` format.

-->

> [!NOTE]
> You can remove updates that are imported from the Microsoft Update Catalog that are set as either **Not Approved** or **Declined**, by running the WSUS Server cleanup Wizard. You can re-import updates that have been previously removed from your WSUS systems through the Microsoft Update Catalog.


## Restricting access to hotfixes

WSUS administrators might consider restricting access to the hotfixes they've downloaded from the Microsoft Update Catalog Site. To restriction the available hotfixes complete the following steps:

1. Start the **Internet Information Services (IIS) Manager** console.

1. Navigate to the **Content** node under **WSUS Administration** web site.

1. On the **Content Home** pane, double-click in the **Authentication** option.

1. Select **Anonymous Authentication** and select **Disable** in the **Actions** pane on the right.

1. Select **Windows Authentication** and select **Enable** in the **Actions** pane on the right.

1. In the WSUS administrative console, create a WSUS target group for the computers that need the hotfix, and add them to the group. For more information about computers and groups, see [Managing WSUS Client computers and WSUS computer Groups](managing-wsus-client-computers-and-wsus-computer-groups.md) in this guide, and [Configure WSUS computer groups](../deploy/2-configure-wsus.md#24-configure-wsus-computer-groups) in the WSUS deployment guide.

1. Download the files for the hotfix.

1. Set the permissions of these files so that only machine accounts of those machines can read them. You'll also need to allow the Network Service account full access to the files.

1. Approve the hotfix for the WSUS target group created in Step 2.

## Importing updates in different languages

The Microsoft Update Catalog Web site includes updates that support multiple languages.

> [!IMPORTANT]
> Match the languages supported by the WSUS server with the languages supported by the imported updates.

If the WSUS server doesn't support all the languages included in the update, the update won't be deployed to client computers. If an update supporting multiple languages has been downloaded to the WSUS server but not yet deployed to client computers, and an administrator deselects one of the languages included in the update, the update won't be deployed to the clients.
