---
title: Manage Nano Server
description: "updates, servicing packages, networking tracing, performance monitoring"
ms.prod: windows-server-threshold
ms.service: na
manager: DonGill
ms.technology: server-nano
ms.date: 09/06/2017
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 599d6438-a506-4d57-a0ea-1eb7ec19f46e
author: jaimeo
ms.author: jaimeo
ms.localizationpriority: medium
---
# Manage Nano Server

>Applies To: Windows Server 2016

> [!IMPORTANT]
> Starting in Windows Server, version 1709, Nano Server will be available only as a [container base OS image](/virtualization/windowscontainers/quick-start/using-insider-container-images#install-base-container-image). Check out [Changes to Nano Server](nano-in-semi-annual-channel.md) to learn what this means.   

Nano Server is managed remotely. There is no local logon capability at all, nor does it support Terminal Services. However, you have a wide variety of options for managing Nano Server remotely, including Windows PowerShell, Windows Management Instrumentation (WMI), Windows Remote Management, and Emergency Management Services (EMS).  

To use any remote management tool, you will probably need to know the IP address of the Nano Server. Some ways to find out the IP address include:  
  
-   Use the Nano Recovery Console (see the Using the Nano Server Recovery Console section of this topic for details).  
  
-   Connect a serial cable to the computer and use EMS.  
  
-   Using the computer name you assigned to the Nano Server while configuring it, you can get the IP address with ping. For example, `ping NanoServer-PC /4`.  
  
## Using Windows PowerShell remoting  
To manage Nano Server with Windows PowerShell remoting, you need to add the IP address of the Nano Server to your management computer's list of trusted hosts, add the account you are using to the Nano Server's administrators, and enable CredSSP if you plan to use that feature.  

> [!NOTE]
> If the target Nano Server and your management computer are in the same AD DS forest (or in forests with a trust relationship), you should not add the Nano Server to the trusted hosts list--you can connect to the Nano Server by using its fully qualified domain name, for example:
>     PS C:\> Enter-PSSession -ComputerName nanoserver.contoso.com -Credential (Get-Credential)
  
  
To add the Nano Server to the list of trusted hosts, run this command at an elevated Windows PowerShell prompt:  
  
`Set-Item WSMan:\localhost\Client\TrustedHosts "<IP address of Nano Server>"`  
  
To start the remote Windows PowerShell session, start an elevated local Windows PowerShell session, and then run these commands:  
  
  
```  
$ip = "<IP address of Nano Server>"  
$user = "$ip\Administrator"  
Enter-PSSession -ComputerName $ip -Credential $user  
```  
  
  
You can now run Windows PowerShell commands on the Nano Server as normal.  
  
> [!NOTE]  
> Not all Windows PowerShell commands are available in this release of Nano Server. To see which are available, run `Get-Command -CommandType Cmdlet`  
  
Stop the remote session with the command `Exit-PSSession`  
  
## Using Windows PowerShell CIM sessions over WinRM  
You can use CIM sessions and instances in Windows PowerShell to run WMI commands over Windows Remote Management (WinRM).  
  
Start the CIM session by running these commands in a Windows PowerShell prompt:  
  
  
```  
$ip = "<IP address of the Nano Server\>"  
$user = $ip\Administrator  
$cim = New-CimSession -Credential $user -ComputerName $ip  
```  
  
  
With the session established, you can run various WMI commands, for example:  
  
  
```  
Get-CimInstance -CimSession $cim -ClassName Win32_ComputerSystem | Format-List *  
Get-CimInstance -CimSession $Cim -Query "SELECT * from Win32_Process WHERE name LIKE 'p%'"  
```  
  
  
## Windows Remote Management  
You can run programs remotely on the Nano Server with Windows Remote Management (WinRM). To use WinRM, first configure the service and set the code page with these commands at an elevated command prompt:  
  
```
winrm quickconfig
winrm set winrm/config/client @{TrustedHosts="<ip address of Nano Server>"}
chcp 65001
```
  
Now you can run commands remotely on the Nano Server. For example:  

```
winrs -r:<IP address of Nano Server> -u:Administrator -p:<Nano Server administrator password> ipconfig
```
  
For more information about Windows Remote Management, see [Windows Remote Management (WinRM) Overview](https://technet.microsoft.com/library/dn265971.aspx).  
   
   
  
## Running a network trace on Nano Server  
 Netsh trace, Tracelog.exe, and Logman.exe are not available in Nano Server. To capture network packets, you can use these Windows PowerShell cmdlets:  
   
   
```  
New-NetEventSession [-Name]  
Add-NetEventPacketCaptureProvider -SessionName  
Start-NetEventSession [-Name]  
Stop-NetEventSession [-Name]  
```  
These cmdlets are documented in detail at [Network Event Packet Capture Cmdlets in Windows PowerShell](https://technet.microsoft.com/library/dn268520(v=wps.630).aspx)  

## Installing servicing packages  
If you want install a servicing packages, use the -ServicingPackagePath parameter (you can pass an array of paths to .cab files):  
  
`New-NanoServerImage -DeploymentType Guest -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\NanoServer.wim -ServicingPackagePath \\path\to\kb123456.cab`  
  
Often, a servicing package or hotfix is downloaded as a KB item which contains a .cab file. Follow these steps to extract the .cab file, which you can then install with the -ServicingPackagePath parameter:  
  
1.  Download the servicing package (from the associated Knowledge Base article or from [Microsoft Update Catalog](https://catalog.update.microsoft.com/v7/site/home.aspx). Save it to a local directory or network share, for example: C:\ServicingPackages  
2.  Create a folder in which you will save the extracted servicing package.  Example: c:\KB3157663_expanded  
3.  Open a Windows PowerShell console and use the `Expand` command specifying the path to the .msu file of the servicing package, including the `-f:*` parameter and the path where you want servicing package to be extracted to.  For example:  `Expand "C:\ServicingPackages\Windows10.0-KB3157663-x64.msu" -f:* "C:\KB3157663_expanded"`  
  
    The expanded files should look similar to this:  
C:>dir C:\KB3157663_expanded   
Volume in drive C is OS  
Volume Serial Number is B05B-CC3D  
   
      Directory of C:\KB3157663_expanded  
   
      04/19/2016  01:17 PM    \<DIR>          .  
      04/19/2016  01:17 PM    \<DIR>          ..  
        04/17/2016  12:31 AM               517 Windows10.0-KB3157663-x64-pkgProperties.txt  
04/17/2016  12:30 AM        93,886,347 Windows10.0-KB3157663-x64.cab  
04/17/2016  12:31 AM               454 Windows10.0-KB3157663-x64.xml  
04/17/2016  12:36 AM           185,818 WSUSSCAN.cab  
               4 File(s)     94,073,136 bytes  
               2 Dir(s)  328,559,427,584 bytes free  
4.  Run `New-NanoServerImage` with the -ServicingPackagePath parameter pointing to the .cab file in this directory, for example: `New-NanoServerImage -DeploymentType Guest -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\NanoServer.wim -ServicingPackagePath C:\KB3157663_expanded\Windows10.0-KB3157663-x64.cab`  

## Managing updates in Nano Server

Currently you can use the Windows Update provider for Windows Management Instrumentation (WMI) to find the list of applicable updates, and then install all or a subset of them. If you use Windows Server Update Services (WSUS), you can also configure Nano Server to contact the WSUS server to obtain updates.  

In all cases, first establish a remote Windows PowerShell session to the Nano Server computer. These examples use *$sess* for the session; if you are using something else, replace that element as needed.  


### View all available updates  
---  
Obtain the full list of applicable updates with these commands:  
```  
$sess = New-CimInstance -Namespace root/Microsoft/Windows/WindowsUpdate -ClassName MSFT_WUOperationsSession  

$scanResults = Invoke-CimMethod -InputObject $sess -MethodName ScanForUpdates -Arguments @{SearchCriteria="IsInstalled=0";OnlineScan=$true}  
```  
**Note:**  
If no updates are available, this command will return the following error:  
```  
Invoke-CimMethod : A general error occurred that is not covered by a more specific error code.  

At line:1 char:16  

+ ... anResults = Invoke-CimMethod -InputObject $sess -MethodName ScanForUp ...  

+                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  

    + CategoryInfo          : NotSpecified: (MSFT_WUOperatio...-5b842a3dd45d")  

   :CimInstance) [Invoke-CimMethod], CimException  

    + FullyQualifiedErrorId : MI RESULT 1,Microsoft.Management.Infrastructure.  

   CimCmdlets.InvokeCimMethodCommand  
```  

### Install all available updates  
---  
You can detect, download, and install **all** available updates at one time by using these commands:  

```  
$sess = New-CimInstance -Namespace root/Microsoft/Windows/WindowsUpdate -ClassName MSFT_WUOperationsSession  

$scanResults = Invoke-CimMethod -InputObject $sess -MethodName ApplyApplicableUpdates  

Restart-Computer  
```  
**Note:**  
Windows Defender will prevent updates from installing. To work around this, uninstall Windows Defender, install the updates, and then reinstall Windows Defender. Alternately, you can download the updates on another computer, copy them to the Nano Server, and then apply them with DISM.exe.  


### Verify installation of updates  
---  
Use these commands to get a list of the updates currently installed:  
```  
$sess = New-CimInstance -Namespace root/Microsoft/Windows/WindowsUpdate -ClassName MSFT_WUOperationsSession  

$scanResults = Invoke-CimMethod -InputObject $sess -MethodName ScanForUpdates -Arguments @{SearchCriteria="IsInstalled=1";OnlineScan=$true}  
```  

**Note:**  
These commands list what is installed, but do not specifically quote "installed" in the output. If you need output including that, such as for a report, you can run  
```  
Get-WindowsPackage--Online  
```  

### Using WSUS  
---  
The commands listed above will query the Windows Update and Microsoft Update serviceon the Internet to find and download updates. If you use WSUS, you can set registry keys on the Nano Server to use your WSUS server instead.  
  
See the "Windows Update Agent Environment Options Registry Keys" table in  [Configure Automatic Updates in a Non-Active-Directory Environment](https://technet.microsoft.com/library/cc708449(v=ws.10).aspx)  
  
You should set at least the **WUServer** and **WUStatusServer** registry keys, but depending on how you have implemented WSUS, other values might be needed. You can always confirm these settings by examining another Windows Server in the same environment.  

Once these values are set for your WSUS, the commands in the section above will query that server for updates and use it the download source.  

### Automatic Updates  
---  
Currently, the way to automate update installation is to convert the steps above into a local Windows PowerShell script and then create a scheduled task to run it and restart the system on your schedule.


## Performance and event monitoring on Nano Server
[comment]: # (from Venkat Yalla.)
Nano Server fully supports the [Event Tracing for Windows](https://aka.ms/u2pa0i) (ETW) framework, but some familiar tools used to manage tracing and performance counters are not currently available on Nano Server. However, Nano Server has tools and cmdlets to accomplish most common performance analysis scenarios.

The high-level workflow remains the same as on any Window Server installation -- low-overhead tracing is performed on the target (Nano Server) computer, and the resulting trace files and/or logs are post-processed offline on a separate computer using tools such as [Windows Performance Analyzer](https://msdn.microsoft.com/library/windows/hardware/hh448170.aspx), [Message Analyzer](https://www.microsoft.com/download/details.aspx?id=44226), or others.

> [!NOTE]
> Refer to [How to copy files to and from Nano Server](https://aka.ms/nri9c8) for a refresher on how to transfer files using PowerShell remoting.

The following sections list the most common performance data collection activities along with a supported way to accomplish them on Nano Server.

### Query available event providers
[Windows Performance Recorder](https://msdn.microsoft.com/library/hh448229.aspx) is tool to query available event providers as follows:
```
wpr.exe -providers
```

You can filter the output on the type of events that are of interest. For example:
```
PS C:\> wpr.exe -providers | select-string "Storage"

       595f33ea-d4af-4f4d-b4dd-9dacdd17fc6e                              : Microsoft-Windows-StorageManagement-WSP-Host
       595f7f52-c90a-4026-a125-8eb5e083f15e                              : Microsoft-Windows-StorageSpaces-Driver
       69c8ca7e-1adf-472b-ba4c-a0485986b9f6                              : Microsoft-Windows-StorageSpaces-SpaceManager
       7e58e69a-e361-4f06-b880-ad2f4b64c944                              : Microsoft-Windows-StorageManagement
       88c09888-118d-48fc-8863-e1c6d39ca4df                              : Microsoft-Windows-StorageManagement-WSP-Spaces
```

### Record traces from a single ETW provider
You can use new [Event Tracing Management cmdlets](https://technet.microsoft.com/library/dn919247.aspx) for this. Here is an example workflow:

Create and start the trace, specifying a file name for storing the events.
```
PS C:\> New-EtwTraceSession -Name "ExampleTrace" -LocalFilePath c:\etrace.etl
```

Add a provider GUID to the trace. Use ```wpr.exe -providers``` for Provider Name to GUID translation. 
```
PS C:\> wpr.exe -providers | select-string "Kernel-Memory"

       d1d93ef7-e1f2-4f45-9943-03d245fe6c00                              : Microsoft-Windows-Kernel-Memory

PS C:\> Add-EtwTraceProvider -Guid "{d1d93ef7-e1f2-4f45-9943-03d245fe6c00}" -SessionName "ExampleTrace"
```

Remove the trace -- this stops the trace session, flushing events to the associated log file.
```
PS C:\> Remove-EtwTraceSession -Name "ExampleTrace"

PS C:\> dir .\etrace.etl

    Directory: C:\

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        9/14/2016  11:17 AM       16515072 etrace.etl
```
> [!NOTE]
> This example shows adding a single trace provider to the session, but you can also use the ```Add-EtwTraceProvider``` cmdlet multiple times on a trace session with different provider GUIDs to enable tracing from multiple sources. Another alternative is to use ```wpr.exe``` profiles described below.

### Record traces from multiple ETW providers
The ```-profiles``` option of [Windows Performance Recorder](https://msdn.microsoft.com/library/hh448229.aspx) enables tracing from multiple providers at the same time. There are a number of built-in profiles like CPU, Network, and DiskIO to choose from:
```
PS C:\Users\Administrator\Documents> wpr.exe -profiles 

Microsoft Windows Performance Recorder Version 10.0.14393 (CoreSystem)
Copyright (c) 2015 Microsoft Corporation. All rights reserved.

        GeneralProfile              First level triage
        CPU                         CPU usage
        DiskIO                      Disk I/O activity
        FileIO                      File I/O activity
        Registry                    Registry I/O activity
        Network                     Networking I/O activity
        Heap                        Heap usage
        Pool                        Pool usage
        VirtualAllocation           VirtualAlloc usage
        Audio                       Audio glitches
        Video                       Video glitches
        Power                       Power usage
        InternetExplorer            Internet Explorer
        EdgeBrowser                 Edge Browser
        Minifilter                  Minifilter I/O activity
        GPU                         GPU activity
        Handle                      Handle usage
        XAMLActivity                XAML activity
        HTMLActivity                HTML activity
        DesktopComposition          Desktop composition activity
        XAMLAppResponsiveness       XAML App Responsiveness analysis
        HTMLResponsiveness          HTML Responsiveness analysis
        ReferenceSet                Reference Set analysis
        ResidentSet                 Resident Set analysis
        XAMLHTMLAppMemoryAnalysis   XAML/HTML application memory analysis
        UTC                         UTC Scenarios
        DotNET                      .NET Activity
        WdfTraceLoggingProvider     WDF Driver Activity
```

For detailed guidance on creating custom profiles, see the [WPR.exe documentation](https://msdn.microsoft.com/library/windows/hardware/hh448223.aspx).

### Record ETW traces during operating system boot time
Use the ```New-AutologgerConfig``` cmdlet to collect events during system boot. Usage is very similar to the ```New-EtwTraceSession``` cmdlet, but providers added to the Autologger's configuration will only be enabled early at next boot. The overall workflow looks like this:

First, create a new Autologger config.
```
PS C:\> New-AutologgerConfig -Name "BootPnpLog" -LocalFilePath c:\bootpnp.etl 
```

Add a ETW provider to it. This example uses the Kernel PnP provider. Invoke ```Add-EtwTraceProvider``` again, specifying the same Autologger name but a different GUID to enable boot trace collection from multiple sources.
```
Add-EtwTraceProvider -Guid "{9c205a39-1250-487d-abd7-e831c6290539}" -AutologgerName BootPnpLog
```

This does not start an ETW session immediately, but rather configures one to start at next boot. After rebooting, a new ETW session with the Autologger configuration name is automatically started with the added trace providers enabled. After Nano Server boots, the following command will stop the trace session after flushing the logged events to the associated trace file:
```
PS C:\> Remove-EtwTraceSession -Name BootPnpLog
```

To prevent another trace session from being auto-created at next boot, remove the Autologger configuration as follows:
```
PS C:\> Remove-AutologgerConfig -Name BootPnpLog
```

To collect boot and setup traces across a number of systems or on a diskless system, consider using [Setup and Boot Event Collection](../administration/get-started-with-setup-and-boot-event-collection.md).

### Capture performance counter data
Usually, you monitor performance counter data with Perfmon.exe GUI. On Nano Server, use the ```Typeperf.exe```  command-line equivalent. For example:

Query available counters--you can filter the output to easily find the ones of interest.
```
PS C:\> typeperf.exe -q | Select-String "UDPv6"

\UDPv6\Datagrams/sec
\UDPv6\Datagrams Received/sec
\UDPv6\Datagrams No Port/sec
\UDPv6\Datagrams Received Errors
\UDPv6\Datagrams Sent/sec
```

Options allow specifying the number of times and the interval at which counter values are collected. In the example below, Processor Idle Time is collected 5 times every 3 seconds.
```
PS C:\> typeperf.exe "\Processor Information(0,0)\% Idle Time" -si 3 -sc 5

"(PDH-CSV 4.0)","\\ns-g2\Processor Information(0,0)\% Idle Time"
"09/15/2016 09:20:56.002","99.982990"
"09/15/2016 09:20:59.002","99.469634"
"09/15/2016 09:21:02.003","99.990081"
"09/15/2016 09:21:05.003","99.990454"
"09/15/2016 09:21:08.003","99.998577"
Exiting, please wait...
The command completed successfully.
```

Other command-line options allow you to specify performance counter names of interest in a configuration file, redirecting output to a log file, among other things. See the [typeperf.exe documentation](https://technet.microsoft.com/library/bb490960.aspx) for details.

You can also use Perfmon.exe's graphical interface remotely with Nano Server targets. When adding performance counters to the view, specify the Nano Server target in the computer name instead of the default *<Local computer>*.

### Interact with the Windows Event Log

Nano Server supports the ```Get-WinEvent``` cmdlet, which provides Windows Event Log filtering and querying capabilities, both locally as well as on a remote computer. Detailed options and examples are available at the [Get-WinEvent documentation page](https://technet.microsoft.com/library/hh849682.aspx). This simple example retrieves the *Errors* noted in the *System* log during the past two days.
```
PS C:\> $StartTime = (Get-Date) - (New-TimeSpan -Day 2)
PS C:\> Get-WinEvent -FilterHashTable @{LogName='System'; Level=2; StartTime=$StartTime} | select TimeCreated, Message

TimeCreated           Message
-----------           -------
9/15/2016 11:31:19 AM Task Scheduler service failed to start Task Compatibility module. Tasks may not be able to reg...
9/15/2016 11:31:16 AM The Virtualization Based Security enablement policy check at phase 6 failed with status: {File...
9/15/2016 11:31:16 AM The Virtualization Based Security enablement policy check at phase 0 failed with status: {File...
```

Nano Server also supports ```wevtutil.exe``` which allows retrieving information about event logs and publishers. See [wevtutil.exe documentation](https://aka.ms/qvod7p) for more details. 

### Graphical interface tools
[Web-based server management tools](https://blogs.technet.microsoft.com/servermanagement/2016/08/17/deploy-setup-server-management-tools/) can be used to remotely manage Nano Server targets and present a Nano Server Event Log by using a web browser. Finally, the MMC snap-in Event Viewer (eventvwr.msc) can also be used to view logs -- just open it on a computer with a desktop and point it to a remote Nano Server.




## Using Windows PowerShell Desired State Configuration with Nano Server  
  
You can manage Nano Server as target nodes with Windows PowerShell Desired State Configuration (DSC). Currently, you can manage nodes running Nano Server with DSC in push mode only. Not all DSC features function with Nano Server.  
  
For full details, see [Using DSC on Nano Server](https://msdn.microsoft.com/powershell/dsc/nanoDsc).  
