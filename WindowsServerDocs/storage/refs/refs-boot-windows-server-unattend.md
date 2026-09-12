---
title: ReFS Boot Volume Setup for Windows Server (preview)
description: Deploy Windows Server Insider Preview on a ReFS boot volume by using a Setup unattend answer file, and learn how to pre-create the required NTFS WinRE partition.
author: robinharwood
ai-usage: ai-assisted
ms.author: roharwoo
ms.topic: how-to
ms.date: 07/03/2026
ms.reviewer: chcurlet
#customer intent: As a Windows Server administrator, I want to install Windows Server with a ReFS boot volume by using an unattend answer file so that I can deploy a unified ReFS-based storage host with a working recovery environment.
---

# Deploy Windows Server on a ReFS boot volume by using Setup unattend (preview)

> [!IMPORTANT]
> ReFS boot is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

In Windows Server Insider Preview, you can use Resilient File System (ReFS) as the boot volume so that a single file system spans both the operating system and your data volumes. This setup is useful on dedicated storage hosts that already rely on ReFS features such as block cloning and integrity streams. For background on the file system itself, see [Resilient File System (ReFS) overview](refs-overview.md).

ReFS doesn't support volume shrink, so Windows Setup can't create the Windows Recovery Environment (WinRE) partition automatically when you format the OS volume as ReFS. Your unattend answer file must create the WinRE partition explicitly and format it as NTFS.

This article shows you how to author a Windows Setup answer file (unattend.xml) that installs Windows Server Insider Preview onto a ReFS boot volume on a Unified Extensible Firmware Interface (UEFI) and GUID Partition Table (GPT) disk, and how to pre-create the NTFS WinRE partition so the recovery environment works.

## Prerequisites

Before you begin, make sure you have the following items:

- Windows Server Insider Preview build 29531 or later. ReFS boot is available in Insider Preview builds from February 11, 2026 (minimum build 29531.1000.260206-1841). If you're not enrolled, see [Get started with Windows Server Insider Preview](https://insider.windows.com/for-business-getting-started-server).
- A target server with Unified Extensible Firmware Interface (UEFI) firmware and a GUID Partition Table (GPT)-partitioned system disk. ReFS boot requires UEFI and isn't available for legacy BIOS or Generation 1 virtual machines.
- Windows Server Insider Preview installation media (ISO or USB).
- A bootable [Windows PE](/windows-hardware/manufacture/desktop/winpe-intro) or Windows Setup environment. To build WinPE media, see [Create bootable WinPE media](/windows-hardware/manufacture/desktop/winpe-create-usb-bootable-drive).
- A valid `unattend.xml` answer file. To author one, use [Windows System Image Manager (Windows SIM)](/windows-hardware/customize/desktop/wsim/windows-system-image-manager-technical-reference).
- Familiarity with [Configure UEFI/GPT-Based Hard Drive Partitions](/windows-hardware/manufacture/desktop/configure-uefigpt-based-hard-drive-partitions).

## When to use ReFS for the boot volume

ReFS provides data integrity, scale, and resiliency. Boot Windows Server from ReFS when you want a single file system across the boot volume and data volumes. For example, dedicated storage hosts already rely on ReFS features such as block cloning and integrity streams for their workloads, so extending ReFS to the boot volume keeps the entire host on one file system.

Use NTFS for the boot volume when you need features that ReFS doesn't support on the OS volume. Examples include file-level compression and features that depend on volume shrink.

Validate third-party tooling before broad deployment. Antivirus, backup, and disk-management agents might assume the OS volume is NTFS and fail or behave unexpectedly on a ReFS boot volume.

## Plan the partition layout

For a ReFS boot volume on UEFI and GPT, use the following partition layout. The WinRE (Recovery) partition must be **NTFS** even when the OS volume is ReFS. WinRE itself doesn't run from a ReFS volume.

| Order | Partition | File system | Recommended size |
|-------|-----------|-------------|------------------|
| 1 | EFI System Partition (ESP) | FAT32 | 200 MB (512/512e disks) or 300 MB (4Kn disks) |
| 2 | Microsoft Reserved (MSR) | (none) | 16 MB |
| 3 | Windows (OS) | **ReFS** | Remaining capacity, minus the recovery partition |
| 4 | Windows Recovery (WinRE) | **NTFS** | 2 GB |

Place the recovery partition immediately after the Windows partition. This placement makes it easier to apply future WinRE updates that need a larger partition. For details, see [Windows Recovery Environment (WinRE) - Hard drive partitions](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference#hard-drive-partitions).

Size each partition correctly up front. ReFS doesn't support volume shrink, so you can't recover space from the OS partition after install to grow the recovery partition.

## Create the disk layout

Windows Setup creates the WinRE partition automatically only on NTFS boot volumes, where it shrinks the OS volume on first boot. ReFS doesn't support volume shrink, so on a ReFS boot volume you must lay out all four partitions yourself, including the NTFS WinRE partition.

If you don't create an explicit WinRE partition, Setup installs the OS successfully on ReFS, but WinRE features (automatic repair and BitLocker recovery boot) don't work.

Create the layout in one of two ways. Use the unattend approach (recommended) so Setup performs every step from one answer file. Use the DiskPart approach if you already stage Windows PE on your build hosts and prefer to run Setup by using a minimal answer file.

## Author the unattend.xml answer file for a ReFS boot volume

To create an `unattend.xml` answer file that targets a ReFS boot volume, add the following elements to the [`Microsoft-Windows-Setup`](/windows-hardware/customize/desktop/unattend/microsoft-windows-setup) component in the `windowsPE` configuration pass:

1. Add a [`DiskConfiguration`](/windows-hardware/customize/desktop/unattend/microsoft-windows-setup-diskconfiguration) > [`Disk`](/windows-hardware/customize/desktop/unattend/microsoft-windows-setup-diskconfiguration-disk) element that targets disk 0 and sets `WillWipeDisk` to `true`.

1. Under [`CreatePartitions`](/windows-hardware/customize/desktop/unattend/microsoft-windows-setup-diskconfiguration-disk-createpartitions), define the EFI, MSR, OS, and recovery partitions in the order shown in [Plan the partition layout](#plan-the-partition-layout).

1. Under [`ModifyPartitions`](/windows-hardware/customize/desktop/unattend/microsoft-windows-setup-diskconfiguration-disk-modifypartitions), format the OS partition by setting `Format` to `REFS`.

1. In the `ModifyPartition` element for the recovery partition, set `Format` to `NTFS` and set the `TypeID` attribute to `DE94BBA4-06D1-4D40-A16A-BFD50179D6AC` to mark it as a Windows Recovery Tools partition.

1. Under [`ImageInstall`](/windows-hardware/customize/desktop/unattend/microsoft-windows-setup-imageinstall) > [`OSImage`](/windows-hardware/customize/desktop/unattend/microsoft-windows-setup-imageinstall-osimage) > [`InstallTo`](/windows-hardware/customize/desktop/unattend/microsoft-windows-setup-imageinstall-osimage-installto), point Setup at the ReFS OS partition (`DiskID 0`, `PartitionID 3`).

The following example installs Windows Server to a ReFS partition on disk 0 and creates an NTFS recovery partition for WinRE. Expand the section to view the full answer file.

The 120-GB OS partition size in the following examples is an example configuration, not a requirement. In a typical deployment, size the OS partition to use the remaining disk capacity minus the recovery partition. Adjust the value to suit your hardware.

<details>
<summary>Example unattend.xml for UEFI and GPT, ReFS boot, and NTFS WinRE</summary>

```xml
<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
  <settings pass="windowsPE">
    <component name="Microsoft-Windows-Setup"
               processorArchitecture="amd64"
               publicKeyToken="31bf3856ad364e35"
               language="neutral"
               versionScope="nonSxS"
               xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State">

      <DiskConfiguration>
        <Disk wcm:action="add">
          <DiskID>0</DiskID>
          <WillWipeDisk>true</WillWipeDisk>

          <CreatePartitions>
            <!-- 1. EFI System Partition. Use 200 MB on 512/512e disks; use 300 MB on 4Kn disks. -->
            <CreatePartition wcm:action="add">
              <Order>1</Order>
              <Type>EFI</Type>
              <Size>200</Size>
            </CreatePartition>

            <!-- 2. Microsoft Reserved Partition -->
            <CreatePartition wcm:action="add">
              <Order>2</Order>
              <Type>MSR</Type>
              <Size>16</Size>
            </CreatePartition>

            <!-- 3. Windows (OS) partition -->
            <CreatePartition wcm:action="add">
              <Order>3</Order>
              <Type>Primary</Type>
              <!-- Example size only, not a requirement. To fill the disk, set this to (total disk size in MB) - 200 (ESP) - 16 (MSR) - 2048 (recovery). Don't leave trailing unallocated space after the recovery partition. -->
              <Size>120000</Size>
            </CreatePartition>

            <!-- 4. Windows Recovery (WinRE) partition - 2 GB -->
            <CreatePartition wcm:action="add">
              <Order>4</Order>
              <Type>Primary</Type>
              <Size>2048</Size>
            </CreatePartition>
          </CreatePartitions>

          <ModifyPartitions>
            <ModifyPartition wcm:action="add">
              <Order>1</Order>
              <PartitionID>1</PartitionID>
              <Label>System</Label>
              <Format>FAT32</Format>
            </ModifyPartition>

            <ModifyPartition wcm:action="add">
              <Order>2</Order>
              <PartitionID>2</PartitionID>
            </ModifyPartition>

            <!-- OS partition formatted as ReFS -->
            <ModifyPartition wcm:action="add">
              <Order>3</Order>
              <PartitionID>3</PartitionID>
              <Label>Windows</Label>
              <Letter>C</Letter>
              <Format>REFS</Format>
            </ModifyPartition>

            <!-- Recovery partition: NTFS, marked as Windows Recovery Tools. No <Letter> is set, and the recovery TypeID keeps Windows from assigning a drive letter. -->
            <ModifyPartition wcm:action="add">
              <Order>4</Order>
              <PartitionID>4</PartitionID>
              <Label>Recovery</Label>
              <Format>NTFS</Format>
              <TypeID>DE94BBA4-06D1-4D40-A16A-BFD50179D6AC</TypeID>
            </ModifyPartition>
          </ModifyPartitions>
        </Disk>

        <WillShowUI>OnError</WillShowUI>
      </DiskConfiguration>

      <ImageInstall>
        <OSImage>
          <InstallTo>
            <DiskID>0</DiskID>
            <PartitionID>3</PartitionID>
          </InstallTo>
          <InstallToAvailablePartition>false</InstallToAvailablePartition>
        </OSImage>
      </ImageInstall>

    </component>
  </settings>
</unattend>
```

</details>

> [!IMPORTANT]
> The `Format` element of `ModifyPartition` accepts `REFS` as a value only in Windows Server Insider Preview builds that include ReFS boot. On other builds, Setup fails the answer-file pass with an invalid format error.

The unattend `ModifyPartition` schema doesn't set GPT attributes directly. The example doesn't assign a drive letter to the recovery partition and relies on the recovery `TypeID` (`DE94BBA4-06D1-4D40-A16A-BFD50179D6AC`) to mark it as a Windows Recovery Tools partition, which Windows doesn't assign a drive letter. To match the DiskPart flow exactly and also set `GPT_BASIC_DATA_ATTRIBUTE_NO_DRIVE_LETTER` and `GPT_ATTRIBUTE_PLATFORM_REQUIRED`, apply `gpt attributes=0x8000000000000001` to the recovery partition after installation by using DiskPart.

## Prepartition the ReFS disk by using DiskPart

Instead of using the unattend `DiskConfiguration` section, you can lay out the disk yourself in Windows PE by using a DiskPart script. Use the answer file only for the install step. This approach produces the same layout as the unattend example in [Author the unattend.xml answer file for a ReFS boot volume](#author-the-unattendxml-answer-file-for-a-refs-boot-volume).

To prepartition the disk by using DiskPart, create a script with the following commands and run it from Windows PE before starting Setup. Adjust partition sizes as needed.

> [!WARNING]
> The following script runs `clean` against `disk 0`, which permanently deletes all partitions and data on that disk. Before you run it, confirm the target disk number by using `list disk` in DiskPart and update `select disk 0` if your boot disk has a different number.

1. Save the following script as `X:\layout.txt` in your Windows PE image. The `set id` command marks the partition with `PARTITION_MSFT_RECOVERY_GUID` so Windows recognizes it as a recovery partition. The `gpt attributes` command combines `GPT_BASIC_DATA_ATTRIBUTE_NO_DRIVE_LETTER` and `GPT_ATTRIBUTE_PLATFORM_REQUIRED`, which hides the drive letter and prevents accidental modification.

    ```diskpart
    rem === ReFS boot layout for UEFI and GPT ===
    select disk 0
    clean
    convert gpt

    rem 1. EFI System Partition (use size=200 on 512/512e disks; use size=300 on 4Kn disks)
    create partition efi size=200
    format quick fs=fat32 label="System"
    assign letter=S

    rem 2. Microsoft Reserved
    create partition msr size=16

    rem 3. Windows (OS) partition - ReFS (size=120000 is an example only, not a requirement; to fill the disk use (total disk size in MB) - 200 (ESP) - 16 (MSR) - 2048 (recovery), leaving no trailing unallocated space)
    create partition primary size=120000
    format quick fs=refs label="Windows"
    assign letter=C

    rem 4. Windows Recovery (WinRE) partition - NTFS, 2 GB, marked as recovery
    create partition primary size=2048
    format quick fs=ntfs label="Recovery"
    assign letter=R
    set id="DE94BBA4-06D1-4D40-A16A-BFD50179D6AC"
    gpt attributes=0x8000000000000001

    list partition
    exit
    ```

1. Copy `layout.txt` onto your Windows PE media (for example, to the root of the USB drive so it's available as `X:\layout.txt` in WinPE), and then boot the target server from that media into Windows PE. For details on creating WinPE media, see [WinPE intro](/windows-hardware/manufacture/desktop/winpe-intro) and [Copype command-line options](/windows-hardware/manufacture/desktop/copype-command-line-options).

1. From the Windows PE command prompt, run DiskPart against the script:

    ```cmd
    diskpart /s X:\layout.txt
    ```

1. Run Setup against the ReFS OS partition:

    ```cmd
    setup.exe /unattend:X:\unattend.xml
    ```

    `X:\unattend.xml` is an answer file that contains only the `ImageInstall` section of the example in [Author the unattend.xml answer file for a ReFS boot volume](#author-the-unattendxml-answer-file-for-a-refs-boot-volume). Omit `DiskConfiguration` because you already partitioned the disk.

## Register WinRE on the recovery partition

After Setup completes and Windows boots, register the WinRE image so the recovery tools target the dedicated recovery partition.

1. Sign in to the new Windows Server installation as an administrator and open an elevated command prompt.

1. Confirm the current WinRE state:

    ```cmd
    reagentc /info
    ```

1. If you laid out the disk with the unattend.xml or DiskPart examples in this article, the recovery partition is hidden and has no drive letter. Temporarily assign one with DiskPart so you can copy files to it. Adjust `disk` and `partition` numbers to match your layout:

    ```diskpart
    select disk 0
    select partition 4
    assign letter=R
    exit
    ```

1. If WinRE is disabled or points to the wrong location, copy `winre.wim` to the recovery partition and re-register it. Substitute the temporary drive letter you assigned (for example, `R`) for `<RecoveryDrive>`. Use the drive letter only, without a colon, because the commands already include the colon:

    ```cmd
    mkdir <RecoveryDrive>:\Recovery\WindowsRE
    xcopy /h C:\Windows\System32\Recovery\Winre.wim <RecoveryDrive>:\Recovery\WindowsRE\
    reagentc /setreimage /path <RecoveryDrive>:\Recovery\WindowsRE /target C:\Windows
    reagentc /enable
    reagentc /info
    ```

1. Remove the temporary drive letter so the recovery partition stays hidden. Use the same `disk` and `partition` numbers as before:

    ```diskpart
    select disk 0
    select partition 4
    remove letter=R
    exit
    ```

1. Verify that `Windows RE status` is `Enabled` and that the location matches the recovery partition.

For more information, see [Deploy Windows RE](/windows-hardware/manufacture/desktop/deploy-windows-re).

## Verify the ReFS boot volume

After the server reboots into Windows for the first time, confirm the boot volume is ReFS by using the [Get-Volume](/powershell/module/storage/get-volume) cmdlet in PowerShell:

```powershell
Get-Volume -DriveLetter C | Format-List DriveLetter, FileSystemType, Size, SizeRemaining
```

The `FileSystemType` value should be `ReFS`. Alternatively, check from the command line:

```cmd
fsutil fsinfo volumeinfo C:
```

Confirm that the output includes the line `File System Name : ReFS`.

## Related content

- [Resilient File System (ReFS) overview](refs-overview.md)
- [Windows Setup automation overview](/windows-hardware/manufacture/desktop/windows-setup-automation-overview)
- [Configure UEFI/GPT-based hard drive partitions](/windows-hardware/manufacture/desktop/configure-uefigpt-based-hard-drive-partitions)
- [Deploy Windows RE](/windows-hardware/manufacture/desktop/deploy-windows-re)
