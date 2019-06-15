---
title: Updating Nano Server
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: DonGill
ms.technology: server-nano
ms.date: 09/06/2017
ms.tgt_pltfrm: na
ms.topic: get-started-article
author: jaimeo
ms.author: jaimeo
ms.localizationpriority: medium
---
# Updating Nano Server

> [!IMPORTANT]
> Starting in Windows Server, version 1709, Nano Server will be available only as a [container base OS image](/virtualization/windowscontainers/quick-start/using-insider-container-images#install-base-container-image). Check out [Changes to Nano Server](nano-in-semi-annual-channel.md) to learn what this means. 

Nano Server offers a variety of methods for staying up to date. Compared to other installation options of Windows Server, Nano Server follows a more active servicing model similar to that of Windows 10. These periodic releases are known as **Current Branch for Business (CBB)** releases. This approach supports customers who want to innovate more quickly and move at a cloud cadence of rapid development lifecycles. More information about CBB is available on the [Windows Server Blog](https://blogs.technet.microsoft.com/windowsserver/2016/07/12/windows-server-2016-new-current-branch-for-business-servicing-option/).

**Between these CBB releases**, Nano Server stays current with a series of *cumulative updates*. For example, the first cumulative update for Nano Server was released on September 26, 2016 with [KB4093120](https://support.microsoft.com/help/4093120/windows-10-update-kb4093120). With this and subsequent cumulative updates, we provide various options for installing these updates on Nano Server. In this article, we'll use the KB3192366 update as an example to illustrate how to obtain and apply cumulative updates to Nano Server. For more information on the cumulative update model, see the [Microsoft Update blog](https://blogs.technet.microsoft.com/mu/2016/10/25/patching-with-windows-server-2016/).

> [!NOTE]
> If you install an optional Nano Server package from media or online repository, it won't have recent security fixes included. To avoid a version mismatch between the optional packages and base operating system, you should install the latest cumulative update immediately after installing any optional packages and **before** restarting the server.

In the case of the Cumulative Update for Windows Server 2016: September 26, 2016 ([KB3192366](https://support.microsoft.com/en-us/kb/3192366)), you should first install the latest Servicing Stack Update for Windows 10 Version 1607: August 23, 2016 as a prerequisite ([KB3176936](https://support.microsoft.com/en-us/kb/3176936)). For most of the options below, you need the .msu files containing the .cab update packages. Visit the Microsoft Update Catalog to download each of these update packages:
- [https://catalog.update.microsoft.com/v7/site/Search.aspx?q=KB3192366](https://catalog.update.microsoft.com/v7/site/Search.aspx?q=KB3192366)
- [https://catalog.update.microsoft.com/v7/site/Search.aspx?q=KB3176936](https://catalog.update.microsoft.com/v7/site/Search.aspx?q=KB3176936)

After downloading the .msu files from the Microsoft Update Catalog, save them to a network share or local directory such as C:\ServicingPackages. You can rename the .msu files based on their KB number as we've done below to make them easier to identify. Then use the EXPAND utility to extract the .cab files from the .msu files into separate directories and copy the .cabs into a single folder.

```code
    mkdir C:\ServicingPackages_expanded
    mkdir C:\ServicingPackages_expanded\KB3176936
    mkdir C:\ServicingPackages_expanded\KB3192366
    Expand C:\ServicingPackages\KB3176936.msu -F:* C:\ServicingPackages_expanded\KB3176936
    Expand C:\ServicingPackages\KB3192366.msu -F:* C:\ServicingPackages_expanded\KB3192366
    mkdir C:\ServicingPackages_cabs
    copy C:\ServicingPackages_expanded\KB3176936\Windows10.0-KB3176936-x64.cab C:\ServicingPackages_cabs
    copy C:\ServicingPackages_expanded\KB3192366\Windows10.0-KB3192366-x64.cab C:\ServicingPackages_cabs
```

Now you can use the extracted .cab files to apply the updates to a Nano Server image in a few different ways, depending on your needs. The following options are presented in no particular order of preference - use the option that makes the most sense for your environment.

> [!NOTE]
> When using the DISM tools to service Nano Server, you must use a version of DISM that is the same as or newer than the version of Nano Server you're servicing. You can achieve this by running DISM from a matching version of Windows, installing a matching version of the [Windows Asssessment and Deployment Kit (ADK)](https://developer.microsoft.com/en-us/windows/hardware/windows-assessment-deployment-kit), or running DISM on Nano Server itself.

## Option 1: Integrate a cumulative update into a new image
If you are building a new Nano Server image, you can integrate the latest cumulative update directly into the image so that it's fully patched on first boot.

```powershell
New-NanoServerImage -ServicingPackagePath 'C:\ServicingPackages_cabs\Windows10.0-KB3176936-x64.cab', 'C:\ServicingPackages_cabs\Windows10.0-KB3192366-x64.cab' -<other parameters>
```

## Option 2: Integrate a cumulative update into an existing image
If you have an existing Nano Server image that you use as a baseline for creating specific instances of Nano Server, you can integrate the latest cumulative update directly into your existing baseline image so that machines created using the image are fully patched on first boot.

```powershell
Edit-NanoServerImage -ServicingPackagePath 'C:\ServicingPackages_cabs\Windows10.0-KB3176936-x64.cab', 'C:\ServicingPackages_cabs\Windows10.0-KB3192366-x64.cab' -TargetPath .\NanoServer.wim
```

## Option 3: Apply the cumulative update to an existing offline VHD or VHDX
If you have an existing virtual hard disk (VHD or VHDX), you can use the DISM tools to apply the update to the virtual hard disk. You need to make sure the disk is not in use either by shutting down any VMs using the disk or unmounting the virtual hard disk file.

- Using PowerShell

   ```powershell
   Mount-WindowsImage -ImagePath .\NanoServer.vhdx -Path .\MountDir -Index 1
   Add-WindowsPackage -Path .\MountDir -PackagePath  C:\ServicingPackages_cabs
   Dismount-WindowsImage -Path .\MountDir -Save
   ```

- Using dism.exe

   ```code
   dism.exe /Mount-Image /ImageFile:C:\NanoServer.vhdx /Index:1 /MountDir:C:\MountDir
   dism.exe /Image:C:\MountDir /Add-Package /PackagePath:C:\ServicingPackages_cabs
   dism.exe /Unmount-Image /MountDir:C:\MountDir /Commit
   ```

## Option 4: Apply the cumulative update to a running Nano Server
If you have a running Nano Server VM or physical host and you've downloaded the .cab file for the update, you can use the DISM tools to apply the update while the operating system is online. You will need to copy the .cab file locally on the Nano Server or to an accessible network location. If you're applying a servicing stack update, make sure to restart the server after applying the servicing stack update before applying additional updates.

> [!NOTE]
> If you've created the Nano Server VHD or VHDX image using the New-NanoServerImage cmdlet and didn't specify a MaxSize for the virtual hard disk file, the default size of 4GB is too small to apply the cumulative update. Prior to installing the update, use Hyper-V Manager, Disk Management, PowerShell, or other tool to expand the size of the virtual hard disk and system volume to at least 10GB, or use the ScratchDir parameter on the DISM tools to set the scratch directory to a volume with at least 10GB of free space.

```powershell
$s = New-PSSession -ComputerName (Read-Host "Enter Nano Server IP address") -Credential (Get-Credential)
Copy-Item -ToSession $s -Path C:\ServicingPackages_cabs -Destination C:\ServicingPackages_cabs -Recurse
Enter-PSSession $s
```

- Using PowerShell

   ```powershell
   # Apply the servicing stack update first and then restart
   Add-WindowsPackage -Online -PackagePath C:\ServicingPackages_cabs\Windows10.0-KB3176936-x64.cab
   Restart-Computer; exit

   # After restarting, apply the cumulative update and then restart
   Enter-PSSession -ComputerName (Read-Host "Enter Nano Server IP address") -Credential (Get-Credential)
   Add-WindowsPackage -Online -PackagePath C:\ServicingPackages_cabs\Windows10.0-KB3192366-x64.cab
   Restart-Computer; exit
   ```

- Using dism.exe
   ```powershell
   # Apply the servicing stack update first and then restart
   dism.exe /Online /Add-Package /PackagePath:C:\ServicingPackages_cabs\Windows10.0-KB3176936-x64.cab
   
   # After the operation completes successfully and you are prompted to restart, it's safe to
   # press Ctrl+C to cancel the pipeline and return to the prompt
   Restart-Computer; exit

   # After restarting, apply the cumulative update and then restart
   Enter-PSSession -ComputerName (Read-Host "Enter Nano Server IP address") -Credential (Get-Credential)
   dism.exe /Online /Add-Package /PackagePath:C:\ServicingPackages_cabs\Windows10.0-KB3192366-x64.cab
   Restart-Computer; exit
   ```

## Option 5: Download and install the cumulative update to a running Nano Server

If you have a running Nano Server VM or physical host, you can use the Windows Update WMI provider to download and install the update while the operating system is online. With this method, you don't need to download the .msu file separately from the Microsoft Update Catalog. The WMI provider will detect, download, and install all available updates at once.

```powershell
Enter-PSSession -ComputerName (Read-Host "Enter Nano Server IP address") -Credential (Get-Credential)
```

- Scan for available updates
   ```powershell
   $ci = New-CimInstance -Namespace root/Microsoft/Windows/WindowsUpdate -ClassName MSFT_WUOperationsSession  
   $result = $ci | Invoke-CimMethod -MethodName ScanForUpdates -Arguments @{SearchCriteria="IsInstalled=0";OnlineScan=$true}
   $result.Updates
   ```

- Install all available updates
   ```powershell
   $ci = New-CimInstance -Namespace root/Microsoft/Windows/WindowsUpdate -ClassName MSFT_WUOperationsSession
   Invoke-CimMethod -InputObject $ci -MethodName ApplyApplicableUpdates
   Restart-Computer; exit
   ```

- Get a list of installed updates
   ```powershell
   $ci = New-CimInstance -Namespace root/Microsoft/Windows/WindowsUpdate -ClassName MSFT_WUOperationsSession
   $result = $ci | Invoke-CimMethod -MethodName ScanForUpdates -Arguments @{SearchCriteria="IsInstalled=1";OnlineScan=$true}
   $result.Updates
   ```
   
## Additional Options
Other methods for updating Nano Server might overlap or complement the options above. Such options include using Windows Server Update Services (WSUS), System Center Virtual Machine Manager (VMM), Task Scheduler, or a non-Microsoft solution.
- [Configuring Windows Update for WSUS](https://msdn.microsoft.com/library/dd939844(v=ws.10).aspx) by setting the following registry keys:
  - WUServer
  - WUStatusServer (generally uses the same value as WUServer)
  - UseWUServer
  - AUOptions
- [Managing Fabric Updates in VMM](https://technet.microsoft.com/library/gg675084(v=sc.12).aspx)
- [Registering a Scheduled Task](https://technet.microsoft.com/library/jj649811.aspx)