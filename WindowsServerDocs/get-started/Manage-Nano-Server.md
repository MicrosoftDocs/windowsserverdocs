---
title: Manage Nano Server
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: DonGill
ms.technology: server-nano
ms.date: 09/27/2016
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: c2be4bbf-5022-4bd7-aabb-dbe58fb1f7bb
author: jaimeo
ms.author: jaimeo
---
# Manage Nano Server

>Applies To: Windows Server 2016

Nano Server is managed remotely. There is no local logon capability at all, nor does it support Terminal Services. However, you have a wide variety of options for managing Nano Server remotely, including Windows PowerShell, Windows Management Instrumentation (WMI), Windows Remote Management, and Emergency Management Services (EMS).  
  
To use any remote management tool, you will probably need to know the IP address of the Nano Server. Some ways to find out the IP address include:  
  
-   Use the Nano Recovery Console (see the Using the Nano Server Recovery Console section of this topic for details).  
  
-   Connect a serial cable to the computer and use EMS.  
  
-   Using the computer name you assigned to the Nano Server while configuring it, you can get the IP address with ping. For example, `ping NanoServer-PC /4`.  
  
## Using Windows PowerShell remoting  
To manage Nano Server with Windows PowerShell remoting, you need to add the IP address of the Nano Server to your management computer's list of trusted hosts, add the account you are using to the Nano Server's administrators, and enable CredSSP if you plan to use that feature.  

 >[!NOTE]  
    > If the target Nano Server and your management computer are in the same AD DS forest (or in forests with a trust relationship), you should not add the Nano Server to the trusted hosts list--you can connect to the Nano Server by using its fully qualified domain name, for example:
    PS C:\> Enter-PSSession -ComputerName nanoserver.contoso.com -Credential (Get-Credential)
  
  
To add the Nano Server to the list of trusted hosts, run this command at an elevated Windows PowerShell prompt:  
  
`Set-Item WSMan:\localhost\Client\TrustedHosts "<IP address of Nano Server>"`  
  
To start the remote Windows PowerShell session, start an elevated local Windows PowerShell session, and then run these commands:  
  
  
```  
$ip = "\<IP address of Nano Server>"  
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
$ip\Administrator  
$cim = New-CimSession -Credential $user -ComputerName $ip  
```  
  
  
With the session established, you can run various WMI commands, for example:  
  
  
```  
Get-CimInstance -CimSession $cim -ClassName Win32_ComputerSystem | Format-List *  
Get-CimInstance -CimSession $Cim -Query "SELECT * from Win32_Process WHERE name LIKE 'p%'"  
```  
  
  
## Windows Remote Management  
You can run programs remotely on the Nano Server with Windows Remote Management (WinRM). To use WinRM, first configure the service and set the code page with these commands at an elevated command prompt:  
  
**winrm quickconfig**  
  
**winrm set winrm/config/client @{TrustedHosts="<ip address of Nano Server"}**  
  
**chcp 65001**  
  
Now you can run commands remotely on the Nano Server. For example:  
  
**winrs -r:\<IP address of Nano Server> -u:Administrator -p:\<Nano Server administrator password> ipconfig**  
  
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

##Installing servicing packages  
If you want install a servicing packages, use the -ServicingPackages parameter (you can pass an array of paths to .cab files):  
  
`New-NanoServerImage -DeploymentType Guest -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\NanoServer.wim -ServicingPackages \\path\to\kb123456.cab`  
  
Often, a servicing package or hotfix is downloaded as a KB item which contains a .cab file. Follow these steps to extract the .cab file, which you can then install with the -ServicingPackages parameter:  
  
1.  Download the servicing package (from the associated Knowledge Base article or from [Microsoft Update Catalog](http://catalog.update.microsoft.com/v7/site/home.aspx). Save it to a local directory or network share, for example: C:\ServicingPackages  
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
4.  Run `New-NanoServerImage` with the -ServicingPackages parameter pointing to the .cab file in this directory, for example: `New-NanoServerImage -DeploymentType Guest -Edition Standard -MediaPath \\Path\To\Media\en_us -BasePath .\Base -TargetPath .\NanoServer.wim -ServicingPackages C:\KB3157663_expanded\Windows10.0-KB3157663-x64.cab`  

## Managing updates in Nano Server

Currently you can use the Windows Update provider for Windows Management Instrumentation (WMI) to find the list of applicable updates, and then install all or a subset of them. If you use Windows Server Update Services (WSUS), you can also configure Nano Server to contact the WSUS server to obtain updates.  

In all cases, first establish a remote Windows PowerShell session to the Nano Server computer. These examples use *$sess* for the session; if you are using something else, replace that element as needed.  


View all available updates  
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

Install all available updates  
---  
You can detect, download, and install **all** available updates at one time by using these commands:  

```  
$sess = New-CimInstance -Namespace root/Microsoft/Windows/WindowsUpdate -ClassName MSFT_WUOperationsSession  

$scanResults = Invoke-CimMethod -InputObject $sess -MethodName ApplyApplicableUpdates  

Restart-Computer  
```  
**Note:**  
Windows Defender will prevent updates from installing. To work around this, uninstall Windows Defender, install the updates, and then reinstall Windows Defender. Alternately, you can download the updates on another computer, copy them to the Nano Server, and then apply them with DISM.exe.  


Verify installation of updates  
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

Using WSUS  
---  
The commands listed above will query the Windows Update and Microsoft Update serviceon the Internet to find and download updates. If you use WSUS, you can set registry keys on the Nano Server to use your WSUS server instead.  
  
See the "Windows Update Agent Environment Options Registry Keys" table in  [Configure Automatic Updates in a Non-Active Directory Environment](https://technet.microsoft.com/library/cc708449(v=ws.10).aspx)  
  
You should set at least the **WUServer** and **WUStatusServer** registry keys, but depending on how you have implemented WSUS, other values might be needed. You can always confirm these settings by examining another Windows Server in the same environment.  

Once these values are set for your WSUS, the commands in the section above will query that server for updates and use it the download source.  

Automatic Updates  
---  
Currently, the way to automate update installation is to convert the steps above into a local Windows PowerShell script and then create a scheduled task to run it and restart the system on your schedule.



[comment]: # (## Performance monitoring on Nano Server: Content goes here for OneView bug #68672.)



## Using Windows PowerShell Desired State Configuration with Nano Server  
  
You can manage Nano Server as target nodes with Windows PowerShell Desired State Configuration (DSC). Currently, you can manage nodes running Nano Server with DSC in push mode only. Not all DSC features function with Nano Server.  
  
For full details, see [Using DSC on Nano Server](https://msdn.microsoft.com/powershell/dsc/nanoDsc).  
