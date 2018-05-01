---
title: Storage Spaces Direct Data Collection Tools
description: Understanding Storage Spaces Direct Data Collection Tools, with specific examples of how to run and use them.
keywords: Storage Spaces,Data Collection,Troubleshooting,event channels,Get-SDDCDiagnosticInfo
ms.assetid: 
ms.prod: windows-server-threshold
ms.author: adagashe
ms.technology: storage-spaces
ms.topic: article
author: adagashe
ms.date: 04/18/2018
ms.localizationpriority: 
---
# Data Collection with Storage Spaces Direct

> Applies to: Windows Server 2016

There are various diagnostic tools that can be used to collect the data needed to troubleshoot Storage Spaces Direct and Failover Cluster. In this article, we will focus on **Get-SDDCDiagnosticInfo** - a one touch tool that will gather all relevant information to help you diagnose your cluster.

<!-- The health summary report is a great start to understanding the status of your system to start diagnosing an issue. -->

Given that the logs and other information that **Get-SDDCDiagnosticInfo** are dense, the information on troubleshooting presented below will be helpful for troubleshooting advanced issues that have been escalated and that may require data to be sent to Microsoft for triaging.

<!--
## Collecting live dumps

Windows will trigger the collection of a ``` LiveDump ``` when there are known resources that are hanging in kernel calls. ``` RHS ``` will trigger ```LiveDump``` collection if both the resource type and cluster ``` DumpPolicy ``` are set to 1. For physical disk it is set out of the box
-->

## Installing Get-SDDCDiagnosticInfo

The **Get-SDDCDiagnosticInfo** PowerShell cmdlet (a.k.a. **Get-PCStorageDiagnosticInfo**, previously known as **Test-StorageHealth**) can be used to gather logs for and perform health checks for Failover Clustering (Cluster, Resources, Networks, Nodes), Storage Spaces (Physical Disks, Enclosures, Virtual Disks), Cluster Shared Volumes, SMB File Shares, and Deduplication. 

There are two methods of installing the script, both of which are outlines below.

### PowerShell Gallery 

The [PowerShell Gallery](https://www.powershellgallery.com/packages/PrivateCloud.DiagnosticInfo) is a snapshot of the GitHub Repo. Note that installing items from the PowerShell Gallery requires the latest version of the PowerShellGet module, which is available in Windows 10, in Windows Management Framework (WMF) 5.0, or in the MSI-based installer (for PowerShell 3 and 4).

You can install the module by running following command in PowerShell with administrator privileges:

``` PowerShell
Install-PackageProvider NuGet -Force
Install-Module PrivateCloud.DiagnosticInfo -Force
Import-Module PrivateCloud.DiagnosticInfo -Force
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

## Gathering Logs

After you have enabled event channels and completed the installation process, you can use the Get-SDDCDiagnosticInfo PowerShell cmdlet in the module to get:

1. Reports on storage health, plus details on unhealthy components
2. Reports of storage capacity by pool, volume and deduplicated volume
3. Event logs from all cluster nodes and a summary error report

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

## Get-SDDCDiagnosticInfo output

The following are the files included in the zipped output of Get-SDDCDiagnosticInfo.

### Health Summary Report
The health summary report is saved as:
- 0_CloudHealthSummary.log

This file is generated after parsing all the data collected and is meant to provide a quick summary of your system. It contains:
1. System information
2. Storage health overview (number of nodes up, resources online, cluster shared volumes online, unhealthy components, etc.)
3. Details on unhealthy components (cluster resources that are offline, failed, or online pending)
4. Firmware and driver information
5. Pool, physical disk, and volume details
6. Storage Performance (performance counters are collected)

This report is being continually updated to include more useful information. For the latest information, see the [GitHub README](https://github.com/PowerShell/PrivateCloud.DiagnosticInfo/edit/master/README.md).

### Logs and XMLfiles

The script runs various log gathering scripts and saves the output as xml files. We collect cluster and health logs, system information (MSInfo32), unfiltered event logs (failover clustering, dis diagnostics, hyper-v, storage spaces, and more), and storage diagnostics information (operational logs). For the latest information on what information is collected, see the [GitHub README (what we collect)](https://github.com/PowerShell/PrivateCloud.DiagnosticInfo/blob/master/README.md#what-does-the-cmdlet-output-include).

## Enabling event channels

When Windows Server is installed, many event channels are enabled by default. But sometimes when diagnosing an issue, we want to be able to enable some of these event channels since it will help in triaging and diagnosing system issues.

You could enable additional event channels on each server node in your cluster as needed; however, this approach presents two problems:

1. You need to remember to enable the same event channels on every new server node that you add to your cluster.
2. When diagnosing, it can be tedious to enable specific event channels, reproduce the error, and repeat this process until you root cause.

To avoid these issues, you can enable event channels on cluster startup. The list of enabled event channels on your cluster can be configured using the public property **EnabledEventLogs**. By default, the following event channels are enabled:

```powershell
PS C:\Windows\system32> (get-cluster).EnabledEventLogs
```

Here's an example of the output:
```
Microsoft-Windows-Hyper-V-VmSwitch-Diagnostic,4,0xFFFFFFFD
Microsoft-Windows-SMBDirect/Debug,4
Microsoft-Windows-SMBServer/Analytic
Microsoft-Windows-Kernel-LiveDump/Analytic
```

The **EnabledEventLogs** property is a multistring, where each string is in the form: **channel-name, log-level, keyword-mask**. The **keyword-mask** can be a hexadecimal (prefix 0x), octal (prefix 0), or decimal number (no prefix) number that each event contains (so you can filter by it). For instance, to add a new event channel to the list and to configure both **log-level** and **keyword-mask** you can run:

```powershell
(get-cluster).EnabledEventLogs += "Microsoft-Windows-WinINet/Analytic,2,321"
```

If you want to set the **log-level** but keep the **keyword-mask** at its default value, you can use either of the following commands:

```powershell
(get-cluster).EnabledEventLogs += "Microsoft-Windows-WinINet/Analytic,2"
(get-cluster).EnabledEventLogs += "Microsoft-Windows-WinINet/Analytic,2,"
```

If you want to keep the **log-level** at its default value, but set the **keyword-mask** you can run the following command:

```powershell
(get-cluster).EnabledEventLogs += "Microsoft-Windows-WinINet/Analytic,,0xf1"
```

If you want to keep both the **log-level** and the **keyword-mask** at their default values, you can run any of the following commands:

```powershell
(get-cluster).EnabledEventLogs += "Microsoft-Windows-WinINet/Analytic"
(get-cluster).EnabledEventLogs += "Microsoft-Windows-WinINet/Analytic,"
(get-cluster).EnabledEventLogs += "Microsoft-Windows-WinINet/Analytic,,"
```

These event channels will be enabled on every cluster node when the cluster service starts or whenever the **EnabledEventLogs** property is changed.

## What to expect next?
A lot of improvements and new cmdlets to analyze SDDC system health.
Provide feedback on what you'd like to see by filing issues [here](https://github.com/PowerShell/PrivateCloud.DiagnosticInfo/issues). Also, feel free to contribute helpful changes to the script, by submitting a [pull request](https://github.com/PowerShell/PrivateCloud.DiagnosticInfo/pulls).