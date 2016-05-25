---
title: Managing updates in Nano Server
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fff84002-d2f8-4f11-a603-624d824a030e
author: jaimeo
---
# Managing updates in Nano Server
  
Currently you can use the Windows Update provider for Windows Management Instrumentation (WMI) to find the list of applicable updates, and then install all or a subset of them. If you use Windows Server Update Services (WSUS), you can also configure Nano Server to contact the WSUS server to obtain updates.  
  
In all cases, first stablish a remote Windows PowerShell session to the Nano Server computer. These examples use *$sess* for the session; if you are using something else, replace that element as needed.  
  
  
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
  
See the "Windows Update Agent Environment Options Registry Keys" table in  [Configure Automatic Updates in a Non–Active Directory Environment](https://technet.microsoft.com/library/cc708449(v=ws.10).aspx)  
  
You should set at least the **WUServer** and **WUStatusServer** registry keys, but depending on how you have implemented WSUS, other values might be needed. You can always confirm these settings by examining another Windows Server in the same environment.  
  
Once these values are set for your WSUS, the commands in the section above will query that server for updates and use it the download source.  
  
Automatic Updates  
---  
Currently, the way to automate update installation is to convert the steps above into a local Windows PowerShell script and then create a scheduled task to run it and restart the system on your schedule.  
  
  
  
  
  
  

