---
title: Get started with Windows Admin Center
description: Get started with Windows Admin Center
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.localizationpriority: medium
ms.prod: windows-server-threshold
ms.date: 02/15/2019
---

# Get Started with Windows Admin Center

>Applies To: Windows Admin Center, Windows Admin Center Preview

> [!Tip]
> New to Windows Admin Center?
> [Learn more about Windows Admin Center](../understand/windows-admin-center.md) or [Download now](https://aka.ms/windowsadmincenter).

## Windows Admin Center installed on Windows 10

> [!IMPORTANT]
> You must be a member of the local administrator's group to use Windows Admin Center on Windows 10

### Selecting a client certificate

The first time you open Windows Admin Center on Windows 10, make sure to select the *Windows Admin Center Client* certificate (otherwise you'll get an HTTP 403 error saying "can't get to this page").

In Microsoft Edge, when you are prompted with this dialog:
 
1. Click **More choices**

    ![](../media/launch-cert-1.png)

2. Select the certificate labeled **Windows Admin Center Client** and click **OK**

    ![](../media/launch-cert-2.png)

3. Make sure **Always Allow Access** is selected and click **Allow**

    ![](../media/launch-cert-3.png)

## Connecting to managed nodes and clusters

After you have completed the installation of Windows Admin Center, you can add servers or clusters to manage from the main overview page.

 **Add a single server or a cluster as a managed node**

1. Click **+ Add** under **All Connections**.

   ![](../media/launch/addserver0.png)

2. Choose to add a Server, Failover Cluster or Hyper-Converged Cluster connection:
    
   ![](../media/launch/addserver1.png)

3. Type the name of the server or cluster to manage and click **Submit**. The server or cluster will be added to your connection list on the overview page.

   ![](../media/launch/addserver2.png)

   **-- OR --**

**Bulk import multiple servers**

 1. On the **Add Server Connection** page, choose the **Import Servers** tab.

    ![](../media/launch/import-servers.png)

 2. Click **Browse** and select a text file that contains a comma, or new line separated, list of FQDNs for the servers you want to add.

> [!Note]
> The .csv file created by [exporting your connections with PowerShell](#use-powershell-to-import-or-export-your-connections-with-tags) contains additional information beyond the server names and is not compatible with this import method.

  **-- OR --**

**Add servers by searching Active Directory**

 1. On the **Add Server Connection** page, choose the **Search Active Directory** tab.

    ![](../media/launch/search-ad.png)

 2. Enter your search criteria and click **Search**. Wildcards (*) are supported.

 3. After the search completes - select one or more of the results, optionally add tags, and click **Add**.

## Authenticate with the managed node ##

Windows Admin Center supports several mechanisms for authenticating with a managed node. Single sign-on is the default.

**Single Sign-on**

You can use your current Windows credentials to authenticate with the managed node. This is the default, and Windows Admin Center attempts the sign-on when you add a server. 

**Single sign-on when deployed as a Service on Windows Server**

If you have installed Windows Admin Center on Windows Server, additional configuration is required for single sign-on.  [Configure your environment for delegation](../configure/user-access-control.md)

**-- OR --**

**Use *Manage As* to Specify credentials**

Under **All Connections**, select a server from the list and choose **Manage As** to specify the credentials that you will use to authenticate to the managed node:

![](../media/launch-use-6.png)

If Windows Admin Center is running in service mode on Windows Server, but you do not have Kerberos delegation configured, you must re-enter your Windows credentials:

![](../media/launch-use-7.png)

You may apply the credentials to all connections, which will cache them for that
specific browser session. If you reload your browser, you must re-enter your
**Manage As** credentials.

**Local Administrator Password Solution (LAPS)**

If your environment uses [LAPS](https://technet.microsoft.com/mt227395.aspx), and you have Windows Admin Center installed on your Windows 10 PC, you can use LAPS credentials to authenticate with the managed node. **If you use this scenario, please** [provide feedback](http://aka.ms/WACFeedback).

## Using tags to organize your connections

You can use tags to identify and filter related servers in your connection list.  This allows you to see a subset of your servers in the connection list.  This is especially useful if you have many connections.

### Edit tags

* Select a server or multiple servers in the All Connections list
* Under **All Connections**, click **Edit Tags**

![](../media/launch/tags-5.png)

The **Edit Connection Tags** pane allows you to modify, add, or remove tags from your selected connection(s):

* To add a new tag to your selected connection(s), select **Add tag** and enter the tag name you would like to use.

* To tag the selected connections with an existing tag name, check the box next to the tag name you wish to apply.

* To remove a tag from all selected connections, uncheck the box next to the tag you wish to remove.

* If a tag is applied to a subset of the selected connections, the check box is shown in an intermediate state. You can click the box to check it and apply the tag to all selected connections, or click again to uncheck it and remove the tag from all selected connections.

![](../media/launch/tags-6.png)

### Filter connections by tag

Once tags have been added to one or more server connections, you can view the tags on the connection list, and filter the connection list by tags.

* To filter by a tag, select the filter icon next to the search box.
![](../media/launch/tags-7.png)
* You can select "or", "and", or "not" to modify the filter behavior of the selected tags.
![](../media/launch/tags-8.png)

## Use PowerShell to import or export your connections (with tags)

```powershell
# Load the module
Import-Module "$env:ProgramFiles\windows admin center\PowerShell\Modules\ConnectionTools"
# Available cmdlets: Export-Connection, Import-Connection

# Export connections (including tags) to .csv files
Export-Connection "https://wac.contoso.com" -fileName "WAC-connections.csv"
# Import connections (including tags) from .csv files
Import-Connection "https://wac.contoso.com" -fileName "WAC-connections.csv"
```

### CSV file format for importing connections

The format of the CSV file starts with the four headings ```"name","type","tags","groupId"```, followed by each connection on a new line.

**name** is the FQDN of the connection

**type** is the connection type. For the default connections included with Windows Admin Center, you will use one of the following:

| Connection type | Connection string |
|------|-------------------------------|
| Windows Server | msft.sme.connection-type.server |
| Windows 10 PC | msft.sme.connection-type.windows-client |
| Failover Cluster | msft.sme.connection-type.cluster |
| Hyper-Converged Cluster | msft.sme.connection-type.hyper-converged-cluster |

**tags** are pipe-separated.

**groupId** is used for shared connections. Use the value ```global``` in this column to make this a shared connection.

### Example CSV file for importing connections

```
"name","type","tags","groupId"
"myServer.contoso.com","msft.sme.connection-type.server","hyperv"
"myDesktop.contoso.com","msft.sme.connection-type.windows-client","hyperv"
"teamcluster.contoso.com","msft.sme.connection-type.cluster","legacyCluster|WS2016","global"
"myHCIcluster.contoso.com,"msft.sme.connection-type.hyper-converged-cluster","myHCIcluster|hyperv|JIT|WS2019"
"teamclusterNode.contoso.com","msft.sme.connection-type.server","legacyCluster|WS2016","global"
"myHCIclusterNode.contoso.com","msft.sme.connection-type.server","myHCIcluster|hyperv|JIT|WS2019"
```

## Import RDCman connections

Use the script below to export saved connections in [RDCman](https://blogs.technet.microsoft.com/rmilne/2014/11/19/remote-desktop-connection-manager-download-rdcman-2-7/) to a file. You can then import the file into Windows Admin Center, maintaining your RDCMan grouping hierarchy using tags. Try it out!

1. Copy and paste the code below into your PowerShell session:

   ```powershell
   #Helper function for RdgToWacCsv
   function AddServers {
    param (
    [Parameter(Mandatory = $true)]
    [Xml.XmlLinkedNode]
    $node,
    [Parameter()]
    [String[]]
    $tags,
    [Parameter(Mandatory = $true)]
    [String]
    $csvPath
    )
    if ($node.LocalName -eq 'server') {
        $serverName = $node.properties.name
        $tagString = $tags -join "|"
        Add-Content -Path $csvPath -Value ('"'+ $serverName + '","msft.sme.connection-type.server","'+ $tagString +'"')
    } 
    elseif ($node.LocalName -eq 'group' -or $node.LocalName -eq 'file') {
        $groupName = $node.properties.name
        $tags+=$groupName
        $currNode = $node.properties.NextSibling
        while ($currNode) {
            AddServers -node $currNode -tags $tags -csvPath $csvPath
            $currNode = $currNode.NextSibling
        }
    } 
    else {
        # Node type isn't relevant to tagging or adding connections in WAC
    }
    return
   }

   <#
   .SYNOPSIS
   Convert an .rdg file from Remote Desktop Connection Manager into a .csv that can be imported into Windows Admin Center, maintaining groups via server tags. This will not modify the existing .rdg file and will create a new .csv file

    .DESCRIPTION
    This converts an .rdg file into a .csv that can be imported into Windows Admin Center.

    .PARAMETER RDGfilepath
    The path of the .rdg file to be converted. This file will not be modified, only read.

    .PARAMETER CSVdirectory
    Optional. The directory you wish to export the new .csv file. If not provided, the new file is created in the same directory as the .rdg file.

    .EXAMPLE
    C:\PS> RdgToWacCsv -RDGfilepath "rdcmangroup.rdg"
    #>
   function RdgToWacCsv {
    param(
        [Parameter(Mandatory = $true)]
        [String]
        $RDGfilepath,
        [Parameter(Mandatory = $false)]
        [String]
        $CSVdirectory
    )
    [xml]$RDGfile = Get-Content -Path $RDGfilepath
    $node = $RDGfile.RDCMan.file
    if (!$CSVdirectory){
        $csvPath = [System.IO.Path]::GetDirectoryName($RDGfilepath) + [System.IO.Path]::GetFileNameWithoutExtension($RDGfilepath) + "_WAC.csv"
    } else {
        $csvPath = $CSVdirectory + [System.IO.Path]::GetFileNameWithoutExtension($RDGfilepath) + "_WAC.csv"
    }
    New-item -Path $csvPath
    Add-Content -Path $csvPath -Value '"name","type","tags"'
    AddServers -node $node -csvPath $csvPath
    Write-Host "Converted $RDGfilepath `nOutput: $csvPath"
   }
   ```

2. To create a .CSV file, run the following command:

   ```powershell
   RdgToWacCsv -RDGfilepath "path\to\myRDCManfile.rdg"
   ```

3. Import the resulting .CSV file in to Windows Admin Center, and all your RDCMan grouping hierarchy will be represented by tags in the connection list. For details, see [Use PowerShell to import or export your connections (with tags)](#use-powershell-to-import-or-export-your-connections-with-tags).

## View PowerShell scripts used in Windows Admin Center

Once you've connected to a server, cluster, or PC, you can look at the PowerShell scripts that power the UI actions available in Windows Admin Center. From within a tool, click the PowerShell icon in the top application bar. Select a command of interest from the dropdown to navigate to the corresponding PowerShell script.

![](../media/launch/showscript.png)