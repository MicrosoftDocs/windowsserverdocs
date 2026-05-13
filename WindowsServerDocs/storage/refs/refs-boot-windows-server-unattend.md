---
title: Deploy a ReFS boot volume on Windows Server using Setup unattend
description: Learn how to deploy Windows Server with a Resilient File System (ReFS) boot volume by using a Windows Setup unattend (answer file) flow, including manually creating the Windows Recovery Environment (WinRE) partition.
author: chcurlet-msft
ms.author: chcurlet
ms.topic: how-to
ms.date: 04/30/2026
ms.service: windows-server
ms.subservice: storage-refs
---

# Deploy a ReFS boot volume on Windows Server using Setup unattend

> [!NOTE]
> ReFS as a boot volume is supported starting in **Windows Server 2025**.

This article describes how to install Windows Server 2025 (or later) with the operating system on a Resilient File System (ReFS) boot volume by using a [Windows Setup answer file (unattend.xml)](/windows-hardware/manufacture/desktop/windows-setup-automation-overview).It also covers how to pre-create the Windows Recovery Environment (WinRE) partition, which Setup does not create automatically when the OS volume is formatted as ReFS.

## When to use ReFS for the boot volume

ReFS is designed for data integrity, scale, and resiliency. Booting Windows Server from ReFS is useful when you want a single file system across the boot volume and data volumes — for example, on dedicated storage hosts where ReFS features such as block cloning and integrity streams are already used by your workloads.

Use NTFS for the boot volume in scenarios where you need features that ReFS does not support on the system volume (for example, file-level compression or features that depend on volume shrink).

## Prerequisites

Before you begin, make sure that the following prerequisites are met:

- A target server with a UEFI firmware and a GPT-partitioned system disk.
- Windows Server 2025 (or later) installation media (ISO or USB).
- A bootable Windows PE or Windows Setup environment.
- A valid `unattend.xml` answer file. You can author one with [Windows System Image Manager (Windows SIM)](/windows-hardware/customize/desktop/wsim/windows-system-image-manager-technical-reference).
- Familiarity with [Configure UEFI/GPT-Based Hard Drive Partitions](/windows-hardware/manufacture/desktop/configure-uefigpt-based-hard-drive-partitions).

## Partition layout

For ReFS boot on UEFI/GPT, use the following partition layout. Note that the WinRE (Recovery) partition must be **NTFS** even when the OS volume is ReFS — WinRE itself doesn't run from a ReFS volume.

| # | Partition | File system | Recommended size |
|---|-----------|-------------|------------------|
| 1 | EFI System Partition (ESP) | FAT32 | 100 MB |
| 2 | Microsoft Reserved (MSR) | (none) | 16 MB |
| 3 | Windows (OS) | **ReFS** | Remaining capacity, minus the recovery partition |
| 4 | Windows Recovery (WinRE) | **NTFS** | 2 GB |

> [!NOTE]
> Place the recovery partition immediately after the Windows partition. This makes future WinRE updates that need a larger partition easier to apply. For details, see [Windows Recovery Environment (WinRE) — Hard drive partitions](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference#hard-drive-partitions).

## Why you must create the WinRE partition explicitly

When Setup installs Windows on an NTFS boot volume, it can shrink the OS volume on first boot to carve out a recovery partition. **ReFS does not support volume shrink**, so Setup can't fall back to that behavior on a ReFS boot volume. As a result, your unattend answer file must:

1. Create the WinRE partition explicitly during the `windowsPE` configuration pass, and
2. Format it as NTFS, mark it as a recovery partition, and hide its drive letter.

If you skip these steps, the OS will install successfully on ReFS, but WinRE features (push-button reset, automatic repair, BitLocker recovery boot) won't be available.

## Author the unattend.xml answer file

The relevant settings live under [`Microsoft-Windows-Setup`](/windows-hardware/customize/desktop/unattend/microsoft-windows-setup) in the `windowsPE` pass:

- [`DiskConfiguration`](/windows-hardware/customize/desktop/unattend/microsoft-windows-setup-diskconfiguration) > [`Disk`](/windows-hardware/customize/desktop/unattend/microsoft-windows-setup-diskconfiguration-disk) — defines the disk layout.
- [`CreatePartitions`](/windows-hardware/customize/desktop/unattend/microsoft-windows-setup-diskconfiguration-disk-createpartitions) — creates the EFI, MSR, OS, and recovery partitions.
- [`ModifyPartitions`](/windows-hardware/customize/desktop/unattend/microsoft-windows-setup-diskconfiguration-disk-modifypartitions) — formats each partition, including setting `Format` to `REFS` for the OS partition. Use the `TypeID` attribute to mark the recovery partition as a Windows Recovery Tools partition.
- [`ImageInstall`](/windows-hardware/customize/desktop/unattend/microsoft-windows-setup-imageinstall) > [`OSImage`](/windows-hardware/customize/desktop/unattend/microsoft-windows-setup-imageinstall-osimage) > [`InstallTo`](/windows-hardware/customize/desktop/unattend/microsoft-windows-setup-imageinstall-osimage-installto) — points Setup at the ReFS OS partition.

### Example unattend.xml (UEFI/GPT, ReFS boot, NTFS WinRE)

The following example installs Windows Server to a ReFS partition on disk 0 and creates an NTFS recovery partition for WinRE.

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
            <!-- 1. EFI System Partition -->
            <CreatePartition wcm:action="add">
              <Order>1</Order>
              <Type>EFI</Type>
              <Size>100</Size>
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
              <!-- Set this to (total disk size in MB) - 2048 to leave room for the 2 GB recovery partition that follows. -->
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

            <!-- Recovery partition: NTFS, marked as Windows Recovery Tools -->
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

> [!IMPORTANT]
> The `Format` element of `ModifyPartition` accepts `REFS` as a value starting in Windows Server 2025. On earlier Windows Server releases, Setup fails the answer-file pass with an invalid format error.

## Alternative: pre-partition with DiskPart, then run Setup

If you'd rather lay out the disk explicitly (for example, in a Windows PE script) and only use unattend for the install step, run the following DiskPart script before launching Setup. This produces the same layout as the unattend example.

```diskpart
rem === ReFS-boot UEFI/GPT layout ===
select disk 0
clean
convert gpt

rem 1. EFI System Partition
create partition efi size=100
format quick fs=fat32 label="System"
assign letter="S"

rem 2. Microsoft Reserved
create partition msr size=16

rem 3. Windows (OS) partition - ReFS
create partition primary size=120000
format quick fs=refs label="Windows"
assign letter="C"

rem 4. Windows Recovery (WinRE) partition - NTFS, 2 GB, marked as recovery
create partition primary size=2048
format quick fs=ntfs label="Recovery"
assign letter="R"
set id="de94bba4-06d1-4d40-a16a-bfd50179d6ac"
gpt attributes=0x8000000000000001

list partition
exit
```

Notes:

- `set id="de94bba4-06d1-4d40-a16a-bfd50179d6ac"` marks the partition with the `PARTITION_MSFT_RECOVERY_GUID` so Windows recognizes it as a recovery partition.
- `gpt attributes=0x8000000000000001` combines `GPT_BASIC_DATA_ATTRIBUTE_NO_DRIVE_LETTER` and `GPT_ATTRIBUTE_PLATFORM_REQUIRED`, which hides the drive letter and prevents accidental modification.

After the layout is in place, run Setup against the ReFS partition. For example, from Windows PE:

```cmd
setup.exe /unattend:X:\unattend.xml
```

Where `X:\unattend.xml` is an answer file that contains only the `ImageInstall` portion of the example above (omit `DiskConfiguration`, since you've already partitioned the disk).

## Register WinRE on the recovery partition

After Setup completes and Windows boots, register the WinRE image so the recovery tools target the dedicated recovery partition.

1. Sign in to the new Windows Server installation as an administrator and open an elevated command prompt.

1. Confirm the current WinRE state:

    ```cmd
    reagentc /info
    ```

1. If WinRE is disabled or pointing at the wrong location, copy `winre.wim` to the recovery partition and re-register it. Substitute the recovery partition's drive letter (for example, `R:`) for `<RecoveryDrive>`:

    ```cmd
    mkdir <RecoveryDrive>:\Recovery\WindowsRE
    xcopy /h C:\Windows\System32\Recovery\Winre.wim <RecoveryDrive>:\Recovery\WindowsRE\
    reagentc /setreimage /path <RecoveryDrive>:\Recovery\WindowsRE /target C:\Windows
    reagentc /enable
    reagentc /info
    ```

1. Verify that `Windows RE status` is `Enabled` and that the location matches the recovery partition.

For more information, see [Deploy Windows RE](/windows-hardware/manufacture/desktop/deploy-windows-re).

## Verify the deployment

After the server reboots into Windows for the first time, confirm the boot volume is ReFS:

```powershell
Get-Volume -DriveLetter C | Format-List DriveLetter, FileSystemType, Size, SizeRemaining
```

The `FileSystemType` should be `ReFS`. You can also check from the command line:

```cmd
fsutil fsinfo volumeinfo C:
```

Look for the `File System Name : ReFS` line in the output.

## Limitations and considerations

- **WinRE partition must be NTFS.** WinRE doesn't boot from a ReFS volume.
- **No volume shrink on ReFS.** You can't recover space from the OS partition after install to grow the recovery partition. Size partitions correctly up front.
- **Third-party tooling.** Antivirus, backup, and disk-management agents may have NTFS-only assumptions about the system volume. Validate them before broad deployment.

## Next steps

- [Resilient File System (ReFS) overview](/windows-server/storage/refs/refs-overview)
- [Windows Setup automation overview](/windows-hardware/manufacture/desktop/windows-setup-automation-overview)
- [Configure UEFI/GPT-based hard drive partitions](/windows-hardware/manufacture/desktop/configure-uefigpt-based-hard-drive-partitions)
- [Deploy Windows RE](/windows-hardware/manufacture/desktop/deploy-windows-re)
