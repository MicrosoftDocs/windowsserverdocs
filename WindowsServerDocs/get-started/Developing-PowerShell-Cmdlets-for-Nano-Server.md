---
title: Developing PowerShell Cmdlets for Nano Server
description: "porting CIM, .NET cmdlets, C++ "
ms.prod: windows-server
ms.service: na
manager: DonGill
ms.technology: server-nano
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7b4267f0-1c91-4a40-9262-5daf4659f686
author: jaimeo
ms.author: jaimeo
ms.date: 09/06/2017
ms.localizationpriority: medium
---
# Developing PowerShell Cmdlets for Nano Server

>Applies To: Windows Server 2016

> [!IMPORTANT]
> Starting in Windows Server, version 1709, Nano Server will be available only as a [container base OS image](/virtualization/windowscontainers/quick-start/using-insider-container-images#install-base-container-image). Check out [Changes to Nano Server](nano-in-semi-annual-channel.md) to learn what this means. 
  
## Overview  
Nano Server includes PowerShell Core by default in all Nano Server installations. PowerShell Core is a reduced-footprint edition of PowerShell that is built on .NET Core and runs on reduced-footprint editions of Windows, such as Nano Server and Windows IoT Core. PowerShell Core functions in the same way as other editions of PowerShell, such as Windows PowerShell running on Windows Server 2016. However, the reduced footprint of Nano Server means that not all PowerShell features from Windows Server 2016 are available in PowerShell Core on Nano Server.  
  
If you have existing PowerShell cmdlets that you'd like to run on Nano Server, or are developing new ones for that purpose, this topic includes tips and suggestions that should help make that easier.  

## PowerShell editions  
  
  
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
  
  
## Installing Nano Server  
Quick-start and detailed steps for installing Nano Server on virtual or physical machines are provided in [Install Nano Server](Getting-Started-with-Nano-Server.md), which is the parent topic for this one.  
  
> [!NOTE]  
> For development work on Nano Server, you might find it useful to install Nano Server by using  the -Development parameter of New-NanoServerImage. This will enable installation of unsigned drivers, copy debugger binaries, open a port for debugging, enable test signing and enable installation of AppX packages without a developer license. For example:  
>  
>`New-NanoServerImage -DeploymentType Guest -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\NanoServer.wim -Development`  
  
## Determining the type of cmdlet implementation  
PowerShell supports a number of implementation types for cmdlets, and the one you've used determines the process and tools involved in creating or porting it to work on Nano Server. Supported implementation types are:  
* CIM - consists of CDXML files layered over CIM (WMIv2) providers   
* .NET - consists of .NET assemblies implementing managed cmdlet interfaces, typically written in C#   
* PowerShell Script - consists of script modules (.psm1) or scripts (.ps1) written in the PowerShell language   
  
If you're not sure which implementation you've used for existing cmdlets you want to port, install your product or feature and then look for the PowerShell module folder in one of the following locations:   
  
* %windir%\system32\WindowsPowerShell\v1.0\Modules   
* %ProgramFiles%\WindowsPowerShell\Modules   
* %UserProfile%\Documents\WindowsPowerShell\Modules   
* \<your product installation location>   
    
  Check in these locations for these details:  
  * CIM cmdlets have .cdxml file extensions.  
  * .NET cmdlets have .dll file extensions, or have assemblies installed to the GAC listed in the .psd1 file under the RootModule, ModuleToProcess, or NestedModules fields.  
* PowerShell script cmdlets have .psm1 or .ps1 file extensions.   
  
## Porting CIM cmdlets  
Generally, these cmdlets should work in Nano Server without any conversion necessary. However, you must port the underlying WMI v2 provider to run on Nano Server if that has not already been done.  
  
### Building C++ for Nano Server  
To get C++ DLLs working on Nano Server, compile them for Nano Server rather than for a specific edition.  
  
For prerequisites and a walkthrough of developing C++ on Nano Server, see [Developing Native Apps on Nano Server](https://blogs.technet.com/b/nanoserver/archive/2016/04/27/developing-native-apps-on-nano-server.aspx).  
  
  
## Porting .NET cmdlets  
Most C# code is supported on Nano Server. You can use [ApiPort](https://github.com/Microsoft/dotnet-apiport) to scan for incompatible APIs.  
  
### Powershell Core SDK  
The module "Microsoft.PowerShell.NanoServer.SDK" is available in the [PowerShell Gallery](https://www.powershellgallery.com/packages/Microsoft.PowerShell.NanoServer.SDK/) to facilitate developing .NET cmdlets using Visual Studio 2015 Update 2 that target the versions of CoreCLR and PowerShell Core available in Nano Server. You can install the module using PowerShellGet with this command:  
  
`Find-Module Microsoft.PowerShell.NanoServer.SDK -Repository PSGallery | Install-Module -Scope <scope>`  
  
The PowerShell Core SDK module exposes cmdlets to set up the correct CoreCLR and PowerShell Core reference assemblies, create a C# project in Visual Studio 2015 targeting those reference assemblies, and set up the remote debugger on a Nano Server machine so that developers can debug their .NET cmdlets running on Nano Server remotely in Visual Studio 2015.  
  
The PowerShell Core SDK module requires Visual Studio 2015 Update 2. If you do not have Visual Studio 2015 installed, you can install [Visual Studio Community 2015](https://www.visualstudio.com/products/visual-studio-community-vs.aspx).  
  
The SDK module also depends on the following feature to be installed in Visual Studio 2015:  
  
- Windows and Web Development -> Universal Windows App Development Tools -> Tools (1.3.1) and Windows 10 SDK  
  
Review your Visual Studio installation before using the SDK module to ensure these prerequisites are satisfied. Make sure you select to install the above feature during the Visual Studio installation, or modify your existing Visual Studio 2015 installation to install it.  
  
The PowerShell Core SDK module includes the following cmdlets:  
- New-NanoCSharpProject: Creates a new Visual Studio C# project targeting CoreCLR and PowerShell Core included in the Windows Server 2016 release of Nano Server.  
- Show-SdkSetupReadMe: Opens the SDK root folder in File Explorer and opens the README.txt file for manual setup.  
- Install-RemoteDebugger: Installs and configures the Visual Studio remote debugger on a Nano Server machine.  
- Start-RemoteDebugger: Starts the remote debugger on a remote machine running Nano Server.  
- Stop-RemoteDebugger: Stops the remote debugger on a remote machine running Nano Server.  
  
For detailed information about how to use those cmdlets, run Get-Help on each cmdlet after installing and importing the module as follows:  
  
`Get-Command -Module Microsoft.PowerShell.NanoServer.SDK | Get-Help -Full`   
  
  
### Searching for compatible APIs  
  
You can search in the API catalog for .NET Core or disassemble Core CLR reference assemblies. For more information about platform portability of .NET APIs, see [Platform Portability](https://github.com/Microsoft/dotnet-apiport/blob/master/docs/HowTo/PlatformPortability.md)  
  
### PInvoke  
In the Core CLR that Nano Server uses, some fundamental DLLs such as kernel32.dll and advapi32.dll were split into numerous API sets, so you'll need to ensure that your PInvokes reference the correct API. Any incompatibility will manifest as a runtime error.  
  
For a list of native APIs supported on Nano Server, see [Nano Server APIs](https://msdn.microsoft.com/library/mt588480(v=vs.85).aspx).  
  
### Building C# for Nano Server  
  
Once a C# project is created in Visual Studio 2015 by using `New-NanoCSharpProject`, you can simply build it in Visual Studio by clicking the **Build** menu and selecting **Build Project** or **Build Solution**. The generated assemblies will be targeting the correct CoreCLR and PowerShell Core shipped in Nano Server, and you can just copy the assemblies to a computer running Nano Server and use them.  
  
### Building managed C++ (CPP/CLI) for Nano Server  
Managed C++ is not supported for CoreCLR. When porting to CoreCLR, rewrite managed C++ code in C# and make all native calls through PInvoke.  
  
## Porting PowerShell script cmdlets  
  
PowerShell Core has full PowerShell language parity with other editions of PowerShell, including the edition running on Windows Server 2016 and Windows 10. However, when porting PowerShell script cmdlets to Nano Server, keep these factors in mind:  
* Are there dependencies on other cmdlets? If so, are those cmdlets available on Nano Server. See [PowerShell on Nano Server](PowerShell-on-Nano-Server.md) for information about what is not available.  
* If you have dependencies on assemblies that are loaded at runtime, will they still work?   
* How can you debug the script remotely?   
* How can you migrate from WMI .Net to MI .Net?  
  
### Dependency on built-in cmdlets  
Not all cmdlets in Windows Server 2016 are available on Nano Server (see [PowerShell on Nano Server](PowerShell-on-Nano-Server.md)). The best approach is to set up a Nano Server virtual machine and discover whether the cmdlets you need are available. To do this, run `Enter-PSSession` to connect to the target Nano Server and then run `Get-Command -CommandType Cmdlet, Function` to get the list of available cmdlets.  
  
### Consider using PowerShell classes  
Add-Type is supported on Nano Server for compiling inline C# code. If you're writing new code or porting existing code, you might also consider using PowerShell classes to define custom types. You can use PowerShell classes for property bag scenarios as well as for Enums. If you need to do a PInvoke, do this via C# using Add-Type or in a pre-compiled assembly.  
Here's a sample showing the use of Add-Type:  
  
```  
Add-Type -ReferencedAssemblies ([Microsoft.Management.Infrastructure.Ciminstance].Assembly.Location) -TypeDefinition @'  
public class TestNetConnectionResult  
{  
   // The compute name  
   public string ComputerName = null;  
   // The Remote IP address used for connectivity  
   public System.Net.IPAddress RemoteAddress = null;  
}  
'@  
# Create object and set properties  
$result = New-Object TestNetConnectionResult  
$result.ComputerName = "Foo"  
$result.RemoteAddress = 1.1.1.1  
  
```  
 This sample shows using PowerShell classes on Nano Server:  
   
```  
class TestNetConnectionResult    
{    
   # The compute name  
  [string] $ComputerName    
  
  #The Remote IP address used for connectivity    
  [System.Net.IPAddress] $RemoteAddress  
}  
# Create object and set properties  
$result = [TestNetConnectionResult]::new()  
$result.ComputerName = "Foo"  
$result.RemoteAddress = 1.1.1.1  
  
```  
  
### Remotely debugging scripts  
  
To remotely debug a script, connect to the remote computer using `Enter-PSsession` from the PowerShell ISE. Once inside the session, you can run `psedit <file_path>` and a copy of the file will be open in your local PowerShell ISE. Then, you can debug the script as if it were running locally by setting breakpoints. Also, any changes you make to this file will be saved in the remote version.   
  
### Migrating from WMI .NET to MI .NET  
  
[WMI .NET](https://msdn.microsoft.com/library/mt481551(v=vs.110).aspx) is not supported, so all cmdlets using the old API must migrate to the supported WMI API: [MI. NET](https://msdn.microsoft.com/library/dn387184(v=vs.85).aspx). You can access MI .NET directly through C# or through the cmdlets in the CimCmdlets module.   
  
### CimCmdlets module  
  
The WMI v1 cmdlets (e.g., Get-WmiObject) are not supported on Nano Server. However, the CIM cmdlets (e.g., Get-CimInstance) in the CimCmdlets module are supported. The CIM cmdlets map pretty closely to the WMI v1 cmdlets. For example, Get-WmiObject correlates with Get-CimInstance using very similar parameters. Method invocation syntax is slightly different, but is well documented via Invoke-CimMethod. Be careful regarding parameter typing. MI .NET has stricter requirements regarding method parameter types.  
  
### C# API  
  
WMI .NET wraps the WMIv1 interface, while MI .NET wraps the WMIv2 (CIM) interface. The classes exposed might be different, but the underlying operations are very similar. You enumerate or get instances of objects and invoke operations on them to accomplish tasks.   
  
  


