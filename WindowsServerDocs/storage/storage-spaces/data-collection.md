---
title: Collect diagnostic data with Storage Spaces Direct
description: Understanding Storage Spaces Direct diagnostic data collection tools, with specific examples of how to run and use them.
ms.author: adagashe
ms.topic: article
author: adagashe
ms.date: 08/09/2021
---
# Collect diagnostic data with Storage Spaces Direct

>Applies to: Azure Stack HCI, version 20H2; Windows Server 2022, Windows Server 2019, Windows Server 2016

There are various diagnostic tools that can be used to collect the data needed to troubleshoot Storage Spaces Direct and Failover Clustering. In this article, we will focus on installing and using SDDC diagnostic tools to gather relevant information to help you diagnose your cluster.

Because the logs and other information are dense, the information presented in this article is helpful for troubleshooting advanced issues that have been escalated and that may require data to be sent to Microsoft for triage.

## Install and use diagnostic tools with Windows Admin Center

You can use Windows Admin Center (version 1812 onwards) to:

- Install SDDC diagnostic tools and keep them up to date
- Schedule daily diagnostic runs (these have a low impact on your system, usually take less than five minutes to run in the background, and won't take up more than 500MB on your cluster)
- View previously collected diagnostic information if you need to give it to support or analyze it yourself

To install SDDC diagnostic tools and begin collecting data, follow these steps:

1. Launch Windows Admin Center and select **Tools > Diagnostics**. If diagnostics tools are not already installed, click the **Install** button.
   
   :::image type="content" source="media/data-collection/install-diagnostic-tools.png" alt-text="Click Install to install SDDC diagnostic tools." lightbox="media/data-collection/install-diagnostic-tools.png":::
   
2. To begin collecting diagnostic data, click **Collect**. You should see a message that says "Collecting diagnostic information. This may take a few minutes." After the initial data collection, if you want to automatically collect data every 24 hours, change the slider to **On**.
   
   :::image type="content" source="media/data-collection/collect-diagnostic-data.png" alt-text="Click Collect to being collecting diagnostic data." lightbox="media/data-collection/collect-diagnostic-data.png":::
   
3. Data collection is not complete until you see the screenshot below. To view collected diagnostic information, choose **Download (.zip)** or **Open in Files tool**.
   
   :::image type="content" source="media/data-collection/view-diagnostic-information.png" alt-text="To view diagnostic information, you can either download a .zip file or open in Files tool." lightbox="media/data-collection/view-diagnostic-information.png":::
   
## Installing Get-SDDCDiagnosticInfo with PowerShell

You can use the `Get-SDDCDiagnosticInfo` PowerShell cmdlet (also known as `Get-PCStorageDiagnosticInfo`, previously known as `Test-StorageHealth`) to gather logs for and perform health checks for Failover Clustering (cluster, resources, networks, nodes), Storage Spaces (physical disks, enclosures, virtual disks), Cluster Shared Volumes, SMB file shares, and Deduplication.

There are two methods of installing the script: PowerShell Gallery and GitHub. Both are outlined below.

### PowerShell Gallery

The [PowerShell Gallery](https://www.powershellgallery.com/packages/PrivateCloud.DiagnosticInfo) is a snapshot of the GitHub Repo. Note that installing items from the PowerShell Gallery requires the latest version of the PowerShellGet module, which is available in Windows 10, in Windows Management Framework (WMF) 5.0, or in the MSI-based installer (for PowerShell 3 and 4).

We install the latest version of the [Microsoft Networking Diagnostics tools](https://www.powershellgallery.com/packages/MSFT.Network.Diag) during this process as well since `Get-SDDCDiagnosticInfo` relies on this. This manifest module contains network diagnostic and troubleshooting tool, which are maintained by the Microsoft Core Networking Product Group at Microsoft.

You can install the module by running following command in PowerShell as administrator:

``` PowerShell
Install-PackageProvider NuGet -Force
Install-Module PrivateCloud.DiagnosticInfo -Force
Import-Module PrivateCloud.DiagnosticInfo -Force
Install-Module -Name MSFT.Network.Diag
```

To update the module, run the following command in PowerShell:

``` PowerShell
Update-Module PrivateCloud.DiagnosticInfo
```

### GitHub

The [GitHub Repo](https://github.com/PowerShell/PrivateCloud.DiagnosticInfo/) is the most up-to-date version of the module, since we are continually iterating here. To install the module from GitHub, download the latest module from the [archive](https://github.com/PowerShell/PrivateCloud.DiagnosticInfo/archive/master.zip) and extract the PrivateCloud.DiagnosticInfo directory to the correct PowerShell modules path pointed by ```$env:PSModulePath```

``` PowerShell
# Allowing Tls12 and Tls11 -- e.g. github now requires Tls12
# If this is not set, the Invoke-WebRequest fails with "The request was aborted: Could not create SSL/TLS secure channel."
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$module = 'PrivateCloud.DiagnosticInfo'
Invoke-WebRequest -Uri https://github.com/PowerShell/$module/archive/master.zip -OutFile $env:TEMP\master.zip
Expand-Archive -Path $env:TEMP\master.zip -DestinationPath $env:TEMP -Force
if (Test-Path $env:SystemRoot\System32\WindowsPowerShell\v1.0\Modules\$module) {
    rm -Recurse $env:SystemRoot\System32\WindowsPowerShell\v1.0\Modules\$module -ErrorAction Stop
    Remove-Module $module -ErrorAction SilentlyContinue
} else {
    Import-Module $module -ErrorAction SilentlyContinue
}
if (-not ($m = Get-Module $module -ErrorAction SilentlyContinue)) {
    $md = "$env:ProgramFiles\WindowsPowerShell\Modules"
} else {
    $md = (gi $m.ModuleBase -ErrorAction SilentlyContinue).PsParentPath
    Remove-Module $module -ErrorAction SilentlyContinue
    rm -Recurse $m.ModuleBase -ErrorAction Stop
}
cp -Recurse $env:TEMP\$module-master\$module $md -Force -ErrorAction Stop
rm -Recurse $env:TEMP\$module-master,$env:TEMP\master.zip
Import-Module $module -Force

```

If you need to get this module on an offline cluster, download the zip, move it to your target server node, and install the module.

## Gathering logs with PowerShell

After you have enabled event channels and completed the installation process, you can use the `Get-SDDCDiagnosticInfo` PowerShell cmdlet in the module to get:

- Reports on storage health, plus details on unhealthy components
- Reports of storage capacity by pool, volume, and deduplicated volume
- Event logs from all cluster nodes and a summary error report

Assume that your storage cluster has the name *"CLUS01".*

To execute against a remote storage cluster:

``` PowerShell
Get-SDDCDiagnosticInfo -ClusterName CLUS01
```

To execute locally on clustered storage node:

``` PowerShell
Get-SDDCDiagnosticInfo
```

To save results to a specified folder:

``` PowerShell
Get-SDDCDiagnosticInfo -WriteToPath D:\Folder
```

Here is an example of how this looks on a real cluster:

``` PowerShell
New-Item -Name SDDCDiagTemp -Path d:\ -ItemType Directory -Force
Get-SddcDiagnosticInfo -ClusterName S2D-Cluster -WriteToPath d:\SDDCDiagTemp
```

As you can see, script will also do validation of current cluster state

![data collection powershell screenshot](media/data-collection/CollectData.png)

As you can see, all data are being written to SDDCDiagTemp folder

![data in file explorer screenshot](media/data-collection/CollectDataFolder.png)

After script will finish, it will create ZIP in your users directory

![data zip in powershell screenshot](media/data-collection/CollectDataResult.png)

Let's generate a report into a text file

```PowerShell
#find the latest diagnostic zip in UserProfile
    $DiagZip=(get-childitem $env:USERPROFILE | where Name -like HealthTest*.zip)
    $LatestDiagPath=($DiagZip | sort lastwritetime | select -First 1).FullName
#expand to temp directory
    New-Item -Name SDDCDiagTemp -Path d:\ -ItemType Directory -Force
    Expand-Archive -Path $LatestDiagPath -DestinationPath D:\SDDCDiagTemp -Force
#generate report and save to text file
    $report=Show-SddcDiagnosticReport -Path D:\SDDCDiagTemp
    $report | out-file d:\SDDCReport.txt

```

For reference, here is a link to the [sample report](https://github.com/Microsoft/WSLab/blob/dev/Scenarios/S2D%20Tools/Get-SDDCDiagnosticInfo/SDDCReport.txt) and [sample zip](https://github.com/Microsoft/WSLab/blob/dev/Scenarios/S2D%20Tools/Get-SDDCDiagnosticInfo/HealthTest-S2D-Cluster-20180522-1546.ZIP).

## Get-SDDCDiagnosticInfo output

The following are the files included in the zipped output of `Get-SDDCDiagnosticInfo`.

### Health summary Report

The health summary report is saved as:
- 0_CloudHealthSummary.log

This file is generated after parsing all the data collected and is meant to provide a quick summary of your system. It contains:

- System information
- Storage health overview (number of nodes up, resources online, cluster shared volumes online, unhealthy components, etc.)
- Details on unhealthy components (cluster resources that are offline, failed, or online pending)
- Firmware and driver information
- Pool, physical disk, and volume details
- Storage Performance (performance counters are collected)

This report is being continually updated to include more useful information. For the latest information, see the [GitHub README](https://github.com/PowerShell/PrivateCloud.DiagnosticInfo/edit/master/README.md).

### Logs and XML files

The script runs various log gathering scripts and saves the output as xml files. We collect cluster and health logs, system information (MSInfo32), unfiltered event logs (failover clustering, dis diagnostics, Hyper-V, storage spaces, and more), and storage diagnostics information (operational logs). For the latest information on what information is collected, see the [GitHub README (what we collect)](https://github.com/PowerShell/PrivateCloud.DiagnosticInfo/blob/master/README.md#what-does-the-cmdlet-output-include).

## How to consume XML files from Get-PCStorageDiagnosticInfo
You can consume the data from the XML files provided in data collected by the `Get-PCStorageDiagnosticInfo` cmdlet. These files have information about the virtual disks, physical disks, basic cluster info and other PowerShell related outputs.

To see the results of these outputs, open a PowerShell window and run the following steps.

```PowerShell
ipmo storage
$d = import-clixml <filename>
$d
```

## Next steps
Provide feedback on what you'd like to see by filing issues [here](https://github.com/PowerShell/PrivateCloud.DiagnosticInfo/issues). Also, feel free to contribute helpful changes to the script by submitting a [pull request](https://github.com/PowerShell/PrivateCloud.DiagnosticInfo/pulls).
