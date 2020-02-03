---
title: PowerShell on Nano Server
description: "Differences in the reduced set of PowerShell features on Nano Server"
ms.prod: windows-server
ms.service: na
manager: DonGill
ms.technology: server-nano
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9b25b939-1e2c-4bed-a8d3-2a8e8e46b53d
author: jaimeo
ms.author: jaimeo
ms.localizationpriority: medium
---
# PowerShell on Nano Server

> Applies To: Windows Server 2016

> [!IMPORTANT]
> Starting in Windows Server, version 1709, Nano Server will be available only as a [container base OS image](/virtualization/windowscontainers/quick-start/using-insider-container-images#install-base-container-image). Check out [Changes to Nano Server](nano-in-semi-annual-channel.md) to learn what this means.

## PowerShell Editions

Starting with version 5.1, PowerShell is available in different editions which denote varying feature sets and platform compatibility.

- **Desktop Edition:** Built on .NET Framework and provides compatibility with scripts and modules targeting versions of PowerShell running on full footprint editions of Windows such as Server Core and Windows Desktop.
- **Core Edition:** Built on .NET Core and provides compatibility with scripts and modules targeting versions of PowerShell running on reduced footprint editions of Windows such as Nano Server and Windows IoT.

The running edition of PowerShell is shown in the PSEdition property of $PSVersionTable.
```powershell
$PSVersionTable

Name                           Value
----                           -----
PSVersion                      5.1.14300.1000
PSEdition                      Desktop
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0...}
CLRVersion                     4.0.30319.42000
BuildVersion                   10.0.14300.1000
WSManStackVersion              3.0
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1
```

Module authors can declare their modules to be compatible with one or more PowerShell editions using the CompatiblePSEditions module manifest key. This key is only supported on PowerShell 5.1 or later.
```powershell
New-ModuleManifest -Path .\TestModuleWithEdition.psd1 -CompatiblePSEditions Desktop,Core -PowerShellVersion 5.1
$moduleInfo = Test-ModuleManifest -Path \TestModuleWithEdition.psd1
$moduleInfo.CompatiblePSEditions
Desktop
Core

$moduleInfo | Get-Member CompatiblePSEditions

   TypeName: System.Management.Automation.PSModuleInfo

Name                 MemberType Definition
----                 ---------- ----------
CompatiblePSEditions Property   System.Collections.Generic.IEnumerable[string] CompatiblePSEditions {get;}

```
When getting a list of available modules, you can filter the list by PowerShell edition.
```powershell
Get-Module -ListAvailable | ? CompatiblePSEditions -Contains "Desktop"

    Directory: C:\Program Files\WindowsPowerShell\Modules


ModuleType Version    Name                                ExportedCommands
---------- -------    ----                                ----------------
Manifest   1.0        ModuleWithPSEditions

Get-Module -ListAvailable | ? CompatiblePSEditions -Contains "Core" | % CompatiblePSEditions
Desktop
Core

```
Script authors can prevent a script from executing unless it is run on a compatible edition of PowerShell using the PSEdition parameter on a #requires statement.
```powershell
Set-Content C:\script.ps1 -Value "#requires -PSEdition Core
Get-Process -Name PowerShell"
Get-Content C:\script.ps1
#requires -PSEdition Core
Get-Process -Name PowerShell

C:\script.ps1
C:\script.ps1 : The script 'script.ps1' cannot be run because it contained a "#requires" statement for PowerShell editions 'Core'. The edition of PowerShell that is required by the script does not match the currently running PowerShell Desktop edition.
At line:1 char:1
+ C:\script.ps1
+ ~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (script.ps1:String) [], RuntimeException
    + FullyQualifiedErrorId : ScriptRequiresUnmatchedPSEdition
```

## Differences in PowerShell on Nano Server
Nano Server includes PowerShell Core by default in all Nano Server installations. PowerShell Core is a reduced footprint edition of PowerShell that is built on .NET Core and runs on reduced footprint editions of Windows, such as Nano Server and Windows IoT Core. PowerShell Core functions in the same way as other editions of PowerShell, such as Windows PowerShell running on Windows Server 2016. However, the reduced footprint of Nano Server means that not all PowerShell features from Windows Server 2016 are available in PowerShell Core on Nano Server.


**Windows PowerShell features not available in Nano Server**
* ADSI, ADO, and WMI type adapters
* Enable-PSRemoting, Disable-PSRemoting (PowerShell remoting is enabled by default; see the "Using Windows PowerShell Remoting" section of [Install Nano Server](Getting-Started-with-Nano-Server.md)).
* Scheduled jobs and PSScheduledJob module
* Computer cmdlets for joining a domain { Add | Remove } (for different methods to join Nano Server to a domain, see the "Joining Nano Server to a domain" section of [Install Nano Server](Getting-Started-with-Nano-Server.md)).
* Reset-ComputerMachinePassword, Test-ComputerSecureChannel
* Profiles (you can add a startup script for incoming remote connections with `Set-PSSessionConfiguration`)
* Clipboard cmdlets
* EventLog cmdlets { Clear | Get | Limit | New | Remove | Show | Write } (use the New-WinEvent and Get-WinEvent cmdlets instead).
* Get-PfxCertificate cmdlet
* TraceSource cmdlets { Get | Set }
* Counter cmdlets { Get | Export | Import }
* Some web-related cmdlets  { New-WebServiceProxy, Send-MailMessage, ConvertTo-Html }
* Logging and tracing using PSDiagnostics module
* Get-HotFix (to obtain and manage updates on Nano Server, see [Manage Nano Server](Manage-Nano-Server.md)).
* Implicit remoting cmdlets { Export-PSSession | Import-PSSession }
* New-PSTransportOption
* PowerShell transactions and Transaction cmdlets { Complete | Get | Start | Undo | Use }
* PowerShell Workflow infrastructure, modules, and cmdlets
* Out-Printer
* Update-List
* WMI v1 cmdlets: Get-WmiObject, Invoke-WmiMethod, Register-WmiEvent, Remove-WmiObject, Set-WmiInstance (use CimCmdlets module instead.)

## Using Windows PowerShell Desired State Configuration with Nano Server

You can manage Nano Server as target nodes with Windows PowerShell Desired State Configuration (DSC). Currently, you can manage nodes running Nano Server with DSC in push mode only. Not all DSC features function with Nano Server.

For full details, see [Using DSC on Nano Server](https://docs.microsoft.com/powershell/scripting/dsc/getting-started/nanodsc).

