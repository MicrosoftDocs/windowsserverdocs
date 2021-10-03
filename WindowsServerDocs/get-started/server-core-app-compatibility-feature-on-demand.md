---
title: Server Core App Compatibility Feature on Demand (FOD) in Windows Server
description: The Server Core App Compatibility Feature on Demand is an optional feature package that can be added to Server Core installations of Windows Server (starting with Windows Server 2019) or Windows Server Semi-Annual Channel installations at any time.
ms.topic: conceptual
author: dknappettmsft
ms.author: daknappe
manager: femila
ms.date: 8/19/2021
ms.prod: windows-server
---

# Server Core App Compatibility Feature on Demand (FOD)

The Server Core App Compatibility Feature on Demand is an optional feature package that can be added to Server Core installations of Windows Server (starting with Windows Server 2019) or Windows Server Semi-Annual Channel installations at any time.

For more information on other Features on Demand (FOD), see [Features On Demand](/windows-hardware/manufacture/desktop/features-on-demand-v2--capabilities).

## Why install the App Compatibility FOD?

App Compatibility, a Feature on Demand for Server Core, significantly improves the app compatibility of the Server Core installation option by including a subset of binaries and packages from Server with Desktop Experience installation option, but without adding the Server with Desktop Experience graphical environment. This optional package is available on a separate ISO, or from Windows Update, but can only be added to Server Core installations and images.

The two primary values the App Compatibility FOD provides are:

- Increases the compatibility of Server Core for server applications that are already in market or have already been developed by organizations and deployed.
- Assists with providing OS components and increased app compatibility of software tools used in acute troubleshooting and debugging scenarios.

Operating system components that are available as part of the Server Core App Compatibility FOD include:

- Microsoft Management Console (mmc.exe)

- Event Viewer (Eventvwr.msc)

- Performance Monitor (PerfMon.exe)

- Resource Monitor (Resmon.exe)

- Device Manager (Devmgmt.msc)

- File Explorer (Explorer.exe)

- Windows PowerShell (Powershell_ISE.exe)

- Disk Management (Diskmgmt.msc)

- Failover Cluster Manager (CluAdmin.msc)

  > [!NOTE]
  > Failover Cluster Manager requires adding the Failover Clustering Windows Server feature first, which can be done by running the following command from an an elevated PowerShell session:
  >
  >```PowerShell
  >Install-WindowsFeature -Name Failover-Clustering -IncludeManagementTools
  >```

Starting with Windows Server, version 1903, the following components are also available (when using the same version of the App Compatibility FOD):

- Hyper-V Manager (virtmgmt.msc)

- Task Scheduler (taskschd.msc)

## Installing the App Compatibility Feature on Demand

The App Compatibility FOD can only be installed on Server Core. Don't attempt to add the Server Core App Compatibility FOD to the Server with Desktop Experience installation option.

1. If the server can connect to Windows Update, all you have to do is run the following command from an elevated PowerShell session and then restart Windows Server after the command finishes running:

    ```PowerShell
    Add-WindowsCapability -Online -Name ServerCore.AppCompatibility~~~~0.0.1.0
    ```

1. If the server can't connect to Windows Update, instead download the Windows Server Languages and Optional Features ISO image file, and copy the ISO to a shared folder on your local network:

   - If you have a volume license, you can download the Windows Server Languages and Optional Features ISO image file from the same portal where the operating system ISO image file is obtained: [Volume Licensing Service Center](https://www.microsoft.com/Licensing/servicecenter/default.aspx).
   - The Windows Server Languages and Optional Features ISO image file is also available on the [Microsoft Evaluation Center](https://www.microsoft.com/evalcenter/evaluate-windows-server) or on the [Visual Studio portal](https://visualstudio.microsoft.com) for subscribers.

    > [!NOTE]
    > The Languages and Optional Features ISO image file is new for Windows Server 2022. Previous versions of Windows Server use the Features on Demand (FOD) ISO.

1. Sign in with an administrator account on the Server Core computer that is connected to your local network and that you want to add the App Compatibility FOD to.

1. Use `New-PSDrive` from PowerShell, `net use` from Command Prompt, or some other method, to connect to the location of the FOD ISO.

1. Copy the FOD ISO to a local folder of your choosing.

1. Mount it by using the following command in an elevated PowerShell session, where E:\ is a drive letter not currently in use:

    ```PowerShell
    Mount-DiskImage -ImagePath E:\folder_where_ISO_is_saved\ISO_filename.iso
    ```

1. Run the following command (depending on the version):

    For Windows Server 2022:

    ```PowerShell
    Add-WindowsCapability -Online -Name ServerCore.AppCompatibility~~~~0.0.1.0 -Source E:\LanguagesAndOptionalFeatures\ -LimitAccess
     ```

    For previous versions of Windows Server:

    ```PowerShell
    Add-WindowsCapability -Online -Name ServerCore.AppCompatibility~~~~0.0.1.0 -Source E:\ -LimitAccess
     ```

1. After the progress bar completes, restart the operating system.

## Optionally add Internet Explorer 11 to Server Core

 >[!NOTE]
 > The Server Core App Compatibility FOD is required for the addition of Internet Explorer 11, but Internet Explorer 11 is not required to add the Server Core App Compatibility FOD.

 >[!NOTE]
 >Starting with Windows Server 2022, although Internet Explorer 11 can be added to Server Core installations of Windows Server, [Microsoft Edge](https://www.microsoft.com/edge) should be used instead. Microsoft Edge has [Internet Explorer mode](/deployedge/edge-ie-mode) ("IE mode") built in, so you can access legacy Internet Explorer-based websites and applications straight from Microsoft Edge. Please see [here](/lifecycle/faq/internet-explorer-microsoft-edge) for information on the lifecycle policy for Internet Explorer.

1. Sign in as Administrator on the Server Core computer that has the App Compatibility FOD already added and the Server FOD optional package ISO copied locally.

1. Mount the FOD ISO by using the following command in an elevated PowerShell session, where E:\ is a drive letter not currently in use:

    ```PowerShell
    Mount-DiskImage -ImagePath E:\folder_where_ISO_is_saved\ISO_filename.iso
    ```

1. Run the following commands (depending on the version), using the `$package_path` variable as the path to the Internet Explorer cab file:

    For Windows Server 2022:

    ```PowerShell
    $package_path = "E:\LanguagesAndOptionalFeatures\Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~~.cab"

    Add-WindowsPackage -Online -PackagePath $package_path
    ```

    For previous versions of Windows Server:

    ```PowerShell
    $package_path = "E:\Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~~.cab"

    Add-WindowsPackage -Online -PackagePath $package_path
    ```

1. After the progress bar completes, restart the operating system.

## Release notes and suggestions

> [!IMPORTANT]
> Features on Demand installed on Semi-Annual Channel versions of Windows Server won't remain in place after an in-place upgrade to a newer Semi-Annual Channel version, so you will have to install them again after the upgrade. Alternatively, you can add Features on Demand to the new Windows Server installation source prior to upgrading. This ensures that the new version of any Features on Demand are present after the upgrade completes. For more info, see the [Adding capabilities and optional packages to an offline WIM Server Core image](#adding-to-an-offline-wim-server-core-image) below.

- After installation of the App Compatibility FOD and reboot of the server, the command console window frame color will change to a different shade of blue.

- If you choose to also install the Internet Explorer 11 optional package, note that double-clicking to open locally saved .htm files is not supported. However, you can **right-click** and choose **Open with Internet Explorer**, or you can open it directly from Internet Explorer **File** -> **Open**.

- To further enhance the app compatibility of Server Core with the App Compatibility FOD, the IIS Management Console has been added to Server Core as an optional component.  However, it is necessary to first add the App Compatibility FOD to use the IIS Management Console. IIS Management Console relies on the Microsoft Management Console (mmc.exe), which is only available on Server Core with the addition of the App Compatibility FOD.  Use the PowerShell cmdlet [**Install-WindowsFeature**](/powershell/module/microsoft.windows.servermanager.migration/install-windowsfeature) to add IIS Management Console:

    ```PowerShell
    Install-WindowsFeature -Name Web-Mgmt-Console
    ```

- As a general point of guidance, when installing applications on Server Core (with or without these optional packages) it is sometimes necessary to use silent install options and instructions.

## Adding to an offline WIM Server Core image

1. Download the Windows Server and Languages and Optional Features ISO image files to a local folder on a Windows computer.

   - If you have a volume license, you can download the Windows Server Languages and Optional Features ISO image file from the same portal where the operating system ISO image file is obtained: [Volume Licensing Service Center](https://www.microsoft.com/Licensing/servicecenter/default.aspx).
   - The Windows Server Languages and Optional Features ISO image file is also available on the [Microsoft Evaluation Center](https://www.microsoft.com/evalcenter/evaluate-windows-server) or on the [Visual Studio portal](https://visualstudio.microsoft.com) for subscribers.

1. Mount the Languages and Optional Features ISO and Windows Server ISO by using the following commands in an elevated PowerShell session, where E:\ and F:\ are drive letters not currently in use:

   ```PowerShell
   Mount-DiskImage -ImagePath E:\folder_where_ISO_is_saved\Languages_and_Optional_Features_ISO_filename.iso
   Mount-DiskImage -ImagePath F:\folder_where_ISO_is_saved\Windows_Server_ISO_filename.iso
   ```

1. Copy the contents of the Windows Server ISO file to a local folder (for example, **C:\SetupFiles\WindowsServer**).

1. Get the image name you want to modify within the install.wim file by using the following command. Use the `$install_wim_path` variable to enter the path to the install.wim file, located inside the \sources folder of the Windows Server ISO file.

   ```PowerShell
   $install_wim_path = C:\SetupFiles\WindowsServer\sources\install.wim

   Get-WindowsImage -ImagePath $install_wim_path
   ```

1. Mount the install.wim file in a new folder by using the following command replacing the sample variable values with your own, and reusing the `$install_wim_path` variable from the previous command.

   - `$image_name` - Enter the name of the image you want to mount.
   - `$mount_folder` - Specify the folder to use when accessing the contents of the install.wim file.

   ```PowerShell
   $image_name = "Windows Server Datacenter"
   $mount_folder = c:\test\offline

   Mount-WindowsImage -ImagePath $install_wim_path -Name $image_name -path $mount_folder
   ```

1. Add capabilities and packages you want to the mounted install.wim image by using the following commands (depending on the version), replacing the sample variable values with your own.

   - `$capability_name` - Specify the name of the capability to install (in this case, the **AppCompatibility** capability).
   - `$package_path` - Specify the path to the package to install (in this case, to the **Internet Explorer** cab file).
   - `$fod_drive` - Specify the drive letter of the mounted Server FOD image.

   For Windows Server 2022:

   ```PowerShell
   $capability_name = "ServerCore.AppCompatibility~~~~0.0.1.0"
   $package_path = "E:\LanguagesAndOptionalFeatures\Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~~.cab"
   $fod_drive = "E:\LanguagesAndOptionalFeatures\"

   Add-WindowsCapability -Path $mount_folder -Name $capability_name -Source $fod_drive -LimitAccess
   Add-WindowsPackage -Path $mount_folder -PackagePath $package_path
   ```

   For previous versions of Windows Server:

   ```PowerShell
   $capability_name = "ServerCore.AppCompatibility~~~~0.0.1.0"
   $package_path = "E:\Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~~.cab"
   $fod_drive = "E:\"

   Add-WindowsCapability -Path $mount_folder -Name $capability_name -Source $fod_drive -LimitAccess
   Add-WindowsPackage -Path $mount_folder -PackagePath $package_path
   ```

1. Dismount and commit changes to the install.wim file by using the following command, which uses the `$mount_folder` variable from previous commands:

   ```PowerShell
   Dismount-WindowsImage -Path $mount_folder -Save
   ```

You can now upgrade your server by running setup.exe from the folder you created for the Windows Server installation files (in this example: **C:\SetupFiles\WindowsServer**). This folder now contains the Windows Server installation files with the additional capabilities and optional packages included.
