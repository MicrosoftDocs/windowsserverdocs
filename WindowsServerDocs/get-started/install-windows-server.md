---
title: Create installation media for deploying Windows Server
description: Learn how to create a bootable USB flash drive or DVD media to deploy Windows Server on physical and virtual hardware.
ms.date: 01/15/2025
ms.topic: how-to
author: alalve
ms.author: xelu86
---

# How to install Windows Server from installation media

Follow the steps in this article to create a bootable USB drive or DVD that can be used to install Windows Server on your devices. Creating a Windows Server installation media is a crucial step in setting up a new server or upgrade from an existing one. This article aims to guide users on how to create a Windows Server installation media.

## Prerequisites

The following are required before installing Windows Server:

- Your device must meet the minimum hardware requirements. To learn more, see [Hardware requirements for Windows Server](/windows-server/get-started/hardware-requirements).
- A minimum of an 8 GB USB flash drive.
- An optical drive capable of burning a DVD+/-RW dual-layer disk
- A dual-layer 8.5 GB DVD

> [!NOTE]
> For users who desire to install Windows Server in a virtual environment through Windows Hyper-V, the minimum RAM requirements differ. To learn more, see the [Hardware requirements for Windows Server](/windows-server/get-started/hardware-requirements?tabs=ram&pivots=windows-server-2025#components) components tab.

## Create a bootable USB flash drive

An alternative to manually preparing your USB drive, users can run the following script to make the USB drive bootable. The Windows Server installation ISO file must be mounted before running this script. To mount the ISO file, perform the following steps:

1. Locate your Windows Server installation ISO file.
1. Right-click on your ISO file and select **Mount**.

Mounting the ISO file creates a virtual optical drive, with its own drive letter, where users can migrate the ISO contents to their USB drive.

Once you plug in your USB drive, it should provide you with a drive letter. Once you know the drive letter of both the USB drive and mounted ISO, run one of the following scripts. Each script accounts for three retries before skipping over to the next set of files.

# [Format as NTFS](#tab/format-ntfs)

This script makes your USB drive bootable in NTFS format.

```powershell
# Select USB drive letter
$usbDriveLetter = Read-Host "Enter USB drive letter (Ex: E)"

# Format USB drive
Format-Volume -DriveLetter $usbDriveLetter -FileSystem NTFS -NewFileSystemLabel "WinServerUSB" -Confirm:$false | Out-Null

# Select ISO file mount point
$isoMountPointDriveLetter = Read-Host "Enter ISO mount point drive letter (Ex: F)"

# Copy ISO files to USB drive
$source = "$($isoMountPointDriveLetter):\"
$destination = "$($usbDriveLetter):\"
robocopy $source $destination /COPYALL /Z /E /SEC /R:3 /W:3

# Make USB drive bootable
$usbDriveNumber = (Get-WmiObject -Class Win32_DiskDrive | Where-Object {$_.InterfaceType -eq "USB" -and $_.DeviceID -like "*$usbDriveLetter"}).Index
bootsect /nt60 $usbDriveLetter | Out-Null

# Task completion notification
Write-Host "Copy operation complete"
Start-Sleep -Seconds 2
```

# [Format as FAT32](#tab/format-fat32)

This script makes your USB drive bootable in FAT32 format. The FAT32 filesystem has a 4 GB limitation that requires the `install.wim` file to be split into multiple `SWM` files. This script accounts for this limitation and splits the `WIM` file accordingly.

```powershell
# Select USB drive letter
$usbDriveLetter = Read-Host "Enter USB drive letter (Ex: E)"

# Format USB drive
Format-Volume -DriveLetter $usbDriveLetter -FileSystem FAT32 -NewFileSystemLabel "ServerUSB" -Confirm:$false

# Select ISO file mount point
$isoMountPointDriveLetter = Read-Host "Enter ISO mount point drive letter (Ex: F)"

# Copy ISO files to USB drive
$source = "$($isoMountPointDriveLetter):\"
$destination = "$($usbDriveLetter):\"
robocopy $source $destination /COPYALL /Z /E /SEC /R:3 /W:3 /XF "$($isoMountPointDriveLetter):\sources\install.wim"

# Split install.wim file
Write-Host "[--- Splitting install.wim ---]"
Start-Sleep -Seconds 2
Dism /Split-Image /ImageFile:"$($isoMountPointDriveLetter):\sources\install.wim" /SWMFile:"$($usbDriveLetter):\sources\install.swm" /FileSize:3800

# Copy split install.wim files to USB drive
$source = "$($isoMountPointDriveLetter):\sources\"
$destination = "$($usbDriveLetter):\sources\"
robocopy $source $destination /COPYALL /Z /E /SEC /R:3 /W:3 *.swm

# Make USB drive bootable
$usbDriveNumber = (Get-WmiObject -Class Win32_DiskDrive | Where-Object {$_.InterfaceType -eq "USB" -and $_.DeviceID -like "*$usbDriveLetter"}).Index
bootsect /nt60 $usbDriveLetter | Out-Null

# Task completion notification
Write-Host "Copy operation complete"
Start-Sleep -Seconds 2
```

---

## Create a bootable DVD

1. Insert a dual-layer 8.5 GB DVD into your optical drive.
1. Locate your Windows Server installation ISO file.
1. Right-click on your ISO file and select **Burn disc image**.
1. The **Windows Disc Image Burner** wizard prompts you to select which **Disc burner** drive you'd like to use.
1. Select the appropriate drive and then select the **Burn** button.

> [!TIP]
> This step is optional, but recommended to ensure that data integrity is verified against any errors or discrepancies between the burned disk and the original ISO image. Select the **Verify disc after burning** checkbox to detect any differences.

## Install Windows Server via media

Before you can install Windows Server via USB or DVD, the computer's boot order in the BIOS must be changed to ensure that the system boots from either the USB or DVD. Accessing the BIOS can vary depending on your hardware. In most cases, you can access the BIOS by pressing a specific key while your device boots. Typically, the key is either **F2**, **F10**, **F12**, or **Delete**. Refer to the user manual for your device. Repeatedly press one of these keys as soon as you turn on your device.

Once you're in the BIOS settings, navigate through the menus until you see the **Boot Order** or **Boot Sequence** option. Refer to the user manual for your device to locate this setting. Once you select the boot order setting, you can edit the boot order priority based in top-down order. Move booting from the USB or optical drive to the top of the list depending on which media installation method you're using. Once appropriate changes are made, save and exit from the BIOS. Your device reboots automatically in applying these changes.

Once modifications are made to the boot order, follow these steps to install Windows Server:

# [Desktop Experience](#tab/desktop-experience)

1. Plug in your USB drive or DVD into your optical drive, then reboot your device.
1. Once your device boots, you're prompted to press any key to boot from your installation media.
1. Under **Select language settings**, select your language, time and currency format, then select **Next**.
1. Under **Select keyboard settings**, select your keyboard language, then select **Next**.
1. Under **Select setup option**, select **Install Windows Server**, select **I agree everything will be deleted including files, apps, and settings**, then select **Next**.
1. Under **Choose a licensing method**, select the option that best serves your environment, then select **Next**:
  
   1. **Use a product key** - This option is for users who have an OEM, Retail, or Volume License (VL) key. If this license type is selected, proceed with the next steps.
   1. **Pay-as-you-go** - This option is for users who desire to use their Azure subscription license. This option is only available for Windows Server 2025 and has its own set of [prerequisites](/windows-server/get-started/windows-server-pay-as-you-go?tabs=gui%2Cazureportal#prerequisites). If this license type is selected, see [Set up Windows Server Pay-as-you-go](/windows-server/get-started/windows-server-pay-as-you-go?tabs=gui%2Cazureportal#set-up-windows-server-pay-as-you-go) to continue the installation process.
  
1. Under **Select image**, select your Windows Server version, then select **Next**.
1. Under **Applicable notices and license terms**, review the software terms, then select **Accept**.
1. Under **Select location to install Windows Server**, select the disk which you want to install Windows Server, then select **Next**.
1. Under **Ready to install**, select **Install**.
1. Once your device reboots a few times, the **License terms** appear. Select **Accept** to proceed.
1. Under **Customize settings**, provide a complex password for the Administrator account, then select **Finish**.
1. Once you log into the Administrator account, review the **Send diagnostic data to Microsoft** information, then select **Accept**.

# [Server Core](#tab/server-core)

1. Plug in your USB drive or DVD into your optical drive, then reboot your device.
1. Once your device boots, you're prompted to press any key to boot from your installation media.
1. Under **Select language settings**, select your language, time and currency format, then select **Next**.
1. Under **Select keyboard settings**, select your keyboard language, then select **Next**.
1. Under **Select setup option**, select **Install Windows Server**, select **I agree everything will be deleted including files, apps, and settings**, then select **Next**.
1. Under **Choose a licensing method**, select the option that best serves your environment, then select **Next**:
  
   1. **Use a product key** - This option is for users who have an OEM, Retail, or Volume License (VL) key. If this license type is selected, proceed with the next steps.
   1. **Pay-as-you-go** - This option is for users who desire to use their Azure subscription license. This option is only available for Windows Server 2025 and has its own set of [prerequisites](/windows-server/get-started/windows-server-pay-as-you-go?tabs=gui%2Cazureportal#prerequisites). If this license type is selected, see [Set up Windows Server Pay-as-you-go](/windows-server/get-started/windows-server-pay-as-you-go?tabs=gui%2Cazureportal#set-up-windows-server-pay-as-you-go) to continue the installation process.
  
1. Under **Select image**, select your Windows Server version, then select **Next**.
1. Under **Applicable notices and license terms**, review the software terms, then select **Accept**.
1. Under **Select location to install Windows Server**, select the disk which you want to install Windows Server, then select **Next**.
1. Under **Ready to install**, select **Install**.
1. Once your device reboots a few times, you're prompted to change the Administrator password. Hit the **Enter** button.
1. Provide a complex password for the Administrator account, then hit the **Tab** button.
1. Type your password again to confirm, then hit the **Enter** button.
1. You're notified that the password was changed. Hit the **Enter** button.
1. Review the **Send Diagnostic data to Microsoft** information. Select one of the two options for how much diagnostic data is shared, then hit the **Enter** button:

   1. Required
   1. Required plus Optional

To manage and configure your Windows Server Core environment, you have the option of using the Server Configuration tool (SConfig). To learn more, see [Configure a Server Core installation of Windows Server and Azure Local with the Server Configuration tool (SConfig)](/windows-server/administration/server-core/server-core-sconfig) and [Administer a Server Core server](/windows-server/administration/server-core/server-core-administer).

---
