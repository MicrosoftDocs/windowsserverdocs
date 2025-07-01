---
title: Install Server Core App Compatibility Feature on Demand
description: Learn how to install the Server Core App Compatibility Feature on Demand to enhance app compatibility in Windows Server.
ms.topic: how-to
ai-usage: ai-assisted
author: dknappettmsft
ms.author: daknappe
ms.date: 07/01/2025
---

# Install Server Core App Compatibility Feature on Demand

The Server Core App Compatibility Feature on Demand (FOD) is an optional feature package designed to enhance the compatibility of Server Core installations in Windows Server. Starting with Windows Server 2019, you can install this feature at any time to improve app compatibility and provide extra tools for daily tasks. This article explains the benefits of App Compatibility, outlines its installation process, and provides instructions for adding it to a server or a custom Windows image.

For more information on other Features on Demand, see [Features On Demand](/windows-hardware/manufacture/desktop/features-on-demand-v2--capabilities).

## Why install App Compatibility

App Compatibility for Server Core improves app compatibility by including a subset of binaries and packages from the Server with Desktop Experience installation option. This optional package is available from Windows Update or on a separate ISO, but it can only be added to Server Core installations and images.

The two primary benefits App Compatibility provides are:

- Increased compatibility of Server Core for server applications.

- Adding OS components not normally included with Server Core that can help with administration tasks and compatibility for software tools used in acute troubleshooting and debugging scenarios.

The operating system components that are available as part of the App Compatibility include:

| Component | Filename | First available |
|--|--|--|
| Device Manager | `devmgmt.msc` | Windows Server 2019 |
| Disk Management | `diskmgmt.msc` | Windows Server 2019 |
| Event Viewer | `eventvwr.msc` | Windows Server 2019 |
| Failover Cluster Manager | `cluadmin.msc` | Windows Server 2019 |
| File Explorer | `explorer.exe` | Windows Server 2019 |
| Hyper-V Manager | `virtmgmt.msc` | Windows Server 2022 |
| Microsoft Management Console | `mmc.exe` | Windows Server 2019 |
| Performance Monitor | `perfmon.exe` | Windows Server 2019 |
| Resource Monitor | `resmon.exe` | Windows Server 2019 |
| Task Scheduler | `taskschd.msc` | Windows Server 2022 |
| Windows PowerShell Integrated Scripting Environment (ISE) | `powershell_ise.exe` | Windows Server 2019 |

## Prerequisites

Before you begin, ensure that you meet the following prerequisites:

- App Compatibility can only be installed on Server Core installations of Windows Server. Don't attempt to add App Compatibility to the Server with Desktop Experience installation option.

- You need to be signed in with an administrator account on the Server Core computer that you want to add the App Compatibility FOD to.

- The following Windows Server features require extra configuration:
  - Failover Cluster Manager (`cluadmin.msc`) requires the Failover Clustering Windows Server feature to be installed first.
  - IIS Management Console (`Web-Mgmt-Console`) relies on App Compatibility to be installed, as it requires the Microsoft Management Console (`mmc.exe`) to run.

- If you want to add App Compatibility to a custom Windows image (WIM), you need the ISO image file for the version of Windows Server you want to create a custom image for.

## Install App Compatibility on a Server Core installation

Installing the App Compatibility Feature on Demand involves adding a specialized package to your Server Core installation that provides extra tools and compatibility features normally found in Server with Desktop Experience.

The installation process depends on whether you want to install App Compatibility from Windows Update or an ISO image. You can install the feature directly from Windows Update by running a PowerShell command. For an ISO image, you need to download the relevant Windows Server Languages and Optional Features ISO, mount it locally, and install the feature from that source.

After you install App Compatibility and restart of the server, the command console window frame color changes to a different shade of blue.

# [Windows Update](#tab/windows-update)

To install App Compatibility on a Server Core installation of Windows Server from Windows Update:

1. Sign in to the server with an administrator account.

1. In `SConfig`, use option **15** to exit `SConfig` to PowerShell.

1. Install the App Compatibility Feature on Demand by running the following command. The command takes several minutes to complete.

   ```PowerShell
   Add-WindowsCapability -Online -Name ServerCore.AppCompatibility~~~~0.0.1.0
   ```

   The output is similar to the following example:

   ```output
   Path          :
   Online        : True
   RestartNeeded : True
   ```

1. Once the command completes, restart the server to apply the changes.

# [ISO image](#tab/iso-image)

To install App Compatibility on a Server Core installation of Windows Server from an ISO image:

1. Sign in to a server with an administrator account.

1. In `SConfig`, use option **15** to exit `SConfig` to PowerShell.

1. Download the ISO image file that contains Features on Demand for the version of Windows Server you installed. Save the ISO image to a folder on the server.

   - [Windows Server 2025](https://go.microsoft.com/fwlink/?linkid=2273506)
   - [Windows Server 2022](https://go.microsoft.com/fwlink/?linkid=2195333)
   - [Windows Server 2019](https://go.microsoft.com/fwlink/?linkid=2195335)

1. Mount the ISO image by running the following command. Be sure to replace `<ISO Path>` with the full file path of your ISO. Alternatively, you can mount the ISO from your hypervisor.

   ```powershell
   $fodPath = '<ISO Path>'

   $fodMount = Mount-DiskImage -ImagePath "$fodPath"
   ```

1. Run the following command to get the drive letter that the FOD ISO is mounted to:

    ```PowerShell
    $fodDriveLetter = ($fodMount | Get-Volume).DriveLetter
    ```

1. Run the following command, depending on the operating system version you're using:

   - For Windows Server 2022 and later:

      ```PowerShell
      Add-WindowsCapability -Online -Name ServerCore.AppCompatibility~~~~0.0.1.0 -Source ${fodDriveLetter}:\LanguagesAndOptionalFeatures\ -LimitAccess
      ```

   - For previous versions of Windows Server:

      ```PowerShell
      Add-WindowsCapability -Online -Name ServerCore.AppCompatibility~~~~0.0.1.0 -Source ${fodDriveLetter}:\ -LimitAccess
      ```

   The output is similar to the following example:

   ```output
   Path          :
   Online        : True
   RestartNeeded : True
   ```

1. Once the command completes, restart the server to apply the changes.

---

> [!IMPORTANT]
>
> If you do an in-place upgrade of Windows Server to a newer version, App Compatibility doesn't remain in place. You need to install it again after the upgrade. Alternatively, you can add App Compatibility to a custom Windows image (WIM) that you use to install Windows Server. Adding App Compatibility to a custom image ensures that it's present after the upgrade completes. For more information, see [Add App Compatibility to a custom WIM image](#add-app-compatibility-to-a-custom-wim-image) section.

## Add App Compatibility to a custom WIM image

If you add App Compatibility to a custom Windows image (WIM) and use that image to install Windows Server, App Compatibility is automatically installed during the installation process. It remains in place after an in-place upgrade of Windows Server to a newer version.

To add App Compatibility to a custom WIM image, follow these steps. Be sure to change `<values>` with your own.

1. Download the ISO image file that contains Features on Demand for the version of Windows Server you want to create a custom image. Save the ISO image to a folder to the same folder where you have the Windows Server ISO image file. The ISO image is available for the following versions of Windows Server:

   - [Windows Server 2025](https://go.microsoft.com/fwlink/?linkid=2273506)
   - [Windows Server 2022](https://go.microsoft.com/fwlink/?linkid=2195333)
   - [Windows Server 2019](https://go.microsoft.com/fwlink/?linkid=2195335)

1. Mount both the Languages and Optional Features ISO and the Windows Server ISO by running the following commands in an elevated PowerShell session:

    ```PowerShell
    $isoFolder = "<ISO folder path>"
    $fodIsoFilename = "<FOD_ISO_filename.iso>"
    $wsIsoFilename = "<Windows_Server_ISO_filename.iso>"

    $fodIso = Mount-DiskImage -ImagePath "$isoFolder\$fodIsoFilename"
    $wsIso = Mount-DiskImage -ImagePath "$isoFolder\$wsIsoFilename"
    ```

1. Run the following command to get the drive letters that the FOD ISO and Windows Server ISO are mounted to:

    ```PowerShell
    $fodDriveLetter = ($fodIso | Get-Volume).DriveLetter
    $wsDriveLetter = ($wsIso | Get-Volume).DriveLetter
    ```

1. Copy the contents of the Windows Server ISO image to a local folder, for example, **C:\SetupFiles\WindowsServer\Files**, by running the following commands. The copy operation might take some time.

    ```powershell
    $wsFiles = "<Windows Server files path>"
    New-Item -ItemType Directory -Path $wsFiles

    Copy-Item -Path ${wsDriveLetter}:\* -Destination $wsFiles -Recurse
    ```

1. Get the image name you want to modify within the `install.wim` file by running the following command. The `install.wim` file is located inside the **sources** folder of the Windows Server ISO image. The names of the images available in this `install.wim` file are in the output.

    ```PowerShell
    $installWimPath = "<Windows Server Files Path>\sources\install.wim"

    Get-WindowsImage -ImagePath $installWimPath
    ```

1. Mount the `install.wim` file in a new folder by running the following command:

   - `$wimImageName` - Enter the name of the image you want to mount from the output of the previous command. The example here uses **Windows Server 2022 Datacenter**.
   - `$wimMountFolder` - Specify an empty folder to use when accessing the contents of the install.wim file.

    ```PowerShell
    $wimImageName = "<Image name, for example Windows Server 2022 Datacenter>"
    $wimMountFolder = "<WIM folder path>"

    New-Item -ItemType Directory -Path $wimMountFolder
    Set-ItemProperty -Path $installWimPath -Name IsReadOnly -Value $false
    Mount-WindowsImage -ImagePath $installWimPath -Name $wimImageName -Path $wimMountFolder
    ```

1. Add the capabilities and packages you want to the mounted `install.wim` image by running the following commands (depending on the version), replacing the sample variable values with your own.

   - For Windows Server 2022 and later:

      ```PowerShell
      $capabilityName = "ServerCore.AppCompatibility~~~~0.0.1.0"

      Add-WindowsCapability -Path $wimMountFolder -Name $capabilityName -Source "${fodDriveLetter}:\LanguagesAndOptionalFeatures" -LimitAccess
      ```

   - For previous versions of Windows Server:

      ```PowerShell
      $capabilityName = "ServerCore.AppCompatibility~~~~0.0.1.0"
   
      Add-WindowsCapability -Path $wimMountFolder -Name $capabilityName -Source "${fodDriveLetter}:\" -LimitAccess
      ```

1. Dismount and commit changes to the `install.wim` file by running the following command:

   ```PowerShell
   Dismount-WindowsImage -Path $wimMountFolder -Save
   ```

You can now install Windows Server using the custom WIM image that has the App Compatibility feature included and it remains in place after an in-place upgrade of Windows Server to a newer version.
