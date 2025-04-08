---
title: Upgrade virtual machine version in Hyper-V on Windows or Windows Server
description: Gives instructions and considerations for upgrading the version of a virtual machine
ms.topic: article
ms.assetid: 897f2454-5aee-445c-a63e-f386f514a0f6
author: meaghanlewis
ms.author: mosagie
ms.date: 01/20/2025
---
# Upgrade virtual machine version in Hyper-V on Windows or Windows Server

Make the latest Hyper-V features available on your virtual machines by upgrading the configuration version. Don't do this until:

- You upgrade your Hyper-V hosts to the latest version of Windows or Windows Server.
- You upgrade the cluster functional level.
- You're sure that you won't need to move the virtual machine back to a Hyper-V host that runs a previous version of Windows or Windows Server.

For more information, see [Cluster Operating System Rolling Upgrade](../../../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md) and [Perform a rolling upgrade of a Hyper-V host cluster in VMM](/system-center/vmm/hyper-v-rolling-upgrade).

## Step 1: Check the virtual machine configuration versions

1. On the Windows desktop, select the Start button and type any part of the name **Windows PowerShell**.
2. Right-click Windows PowerShell and select **Run as Administrator**.
3. Use the [Get-VM](/powershell/module/hyper-v/get-vm)cmdlet. Run the following command to get the versions of your virtual machines.

```PowerShell
Get-VM * | Format-Table Name, Version
```

You can also see the configuration version in Hyper-V Manager by selecting the virtual machine and looking at the **Summary** tab.

## Step 2: Upgrade the virtual machine configuration version

1. Shut down the virtual machine in Hyper-V Manager.
2. Select Action > Upgrade Configuration Version. If this option isn't available for the virtual machine, then it's already at the highest configuration version supported by the Hyper-V host.

To upgrade the virtual machine configuration version by using Windows PowerShell, use the [Update-VMVersion](/powershell/module/hyper-v/update-vmversion) cmdlet. Run the following command where vmname is the name of the virtual machine.

```PowerShell
Update-VMVersion <vmname>
```

## Supported virtual machine configuration versions

Using the PowerShell cmdlet [Get-VMHostSupportedVersion](/powershell/module/hyper-v/get-vmhostsupportedversion) you can see what virtual machine configuration versions your Hyper-V Host supports. When you create a virtual machine, it's created with the default configuration version. To see which virtual machine configuration versions your Hyper-V Host supports and what the default is, run the following command.

```PowerShell
Get-VMHostSupportedVersion
```

If you need to create a virtual machine that you can move to a Hyper-V Host that runs an older version of Windows, use the [New-VM](/powershell/module/hyper-v/new-vm) cmdlet with the `-Version` parameter. For example, to create a virtual machine named "WindowsCV5" with configuration version 5.0, run the following command:

```PowerShell
New-VM -Name "WindowsCV5" -Version 5.0
```

>[!NOTE]
>You can only import a virtual machine if the Hyper-V host supports that configuration version. Typically, this means that you can import a virtual machine to a Hyper-V host running a newer version of Hyper-V, but you cannot import a virtual machine created on a newer version of Hyper-V to an older version of Hyper-V.
>
>If the VM's configuration version is not listed as supported for your Hyper-V host OS in the table below, you either have to upgrade the VM configuration version to a newer version or create a new VM of the same generation using the existing virtual hard disks before you can start the VM.

### Supported VM configuration versions for long-term servicing hosts

The following table lists the VM configuration versions for hosts running a long-term servicing version of Windows.

| Hyper-V host Windows version    | 12.0 | 11.0 | 10.0 | 9.3 | 9.2 | 9.1 | 9.0 | 8.3 | 8.2 | 8.1 | 8.0 | 7.1 | 7.0 | 6.2 | 5.0 |
|---------------------------------|------|------|------|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|
| Windows Server 2025             | ✅   | ✅    | ✅   | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ❌   | ❌  | ❌   | ❌  |
| Windows 11, version 24H2        | ✅   | ✅    | ✅   | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ❌   | ❌  | ❌   | ❌  |
| Windows 11, version 22H2 & 23H2 | ❌   | ✅    | ✅   | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ❌   | ❌  | ❌   | ❌  |
| Windows Server 2022             | ❌   | ❌    | ✅   | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ❌   | ❌  | ❌   | ❌  |
| Windows 10 Enterprise LTSC 2021 | ❌   | ❌    | ❌   | ❌   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ❌   | ❌  | ❌   | ❌  |
| Windows Server 2019             | ❌   | ❌    | ❌   | ❌   | ❌  | ❌   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  |
| Windows 10 Enterprise LTSC 2019 | ❌   | ❌    | ❌   | ❌   | ❌  | ❌   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  |
| Windows Server 2016             | ❌   | ❌    | ❌   | ❌   | ❌  | ❌   | ❌  | ❌   | ❌  | ❌   | ✅  | ✅   | ✅  | ✅   | ✅  |
| Windows 10 Enterprise 2016 LTSB | ❌   | ❌    | ❌   | ❌   | ❌  | ❌   | ❌  | ❌   | ❌  | ❌   | ✅  | ✅   | ✅  | ✅   | ✅  |
| Windows 10 Enterprise 2015 LTSB | ❌   | ❌    | ❌   | ❌   | ❌  | ❌   | ❌  | ❌   | ❌  | ❌   | ❌  | ❌   | ❌  | ✅   | ✅  |
| Windows Server 2012 R2          | ❌   | ❌    | ❌   | ❌   | ❌  | ❌   | ❌  | ❌   | ❌  | ❌   | ❌  | ❌   | ❌  | ❌   | ✅  |
| Windows 8.1                     | ❌   | ❌    | ❌   | ❌   | ❌  | ❌   | ❌  | ❌   | ❌  | ❌   | ❌  | ❌   | ❌  | ❌   | ✅  |



### Upgrade support matrix

>[!WARNING]
>When migrating from Windows Server 2012 R2 or older please note that Windows Server 2019 is last OS that can interpret or upgrade from VM version 5.0 to any later recent version, which then can be continued to be used, if necessary,  or upgraded to a more recent VM version.
>
>You cannot import or upgrade VM Version 5.0 to the new format using Windows Server 2022 or newer.
>
>Operating system in-place upgrades from Windows Server 2019 to Windows Server 2022 or 2025 will not upgrade VM Version 5.0 to a newer version automatically.
>Reasons: Microsoft has revised the VM metadata to improve security and to avoid tampering and corruptions of the VM config file.
>

The following table lists the VM configuration versions upgrade compatibility based on the existing VM version and ability to upgrade these

| Hyper-V host Windows version    | new VM config version | legacy XML based config | can upgrade from XML
|---------------------------------|------|------|------|
| Windows Server 2025             | ✅   | ✅    | ❌   |
| Windows 11, version 24H2        | ✅   | ✅    | ❌   |
| Windows 11, version 22H2 & 23H2 | ✅   | ✅    | ❌   |
| Windows Server 2022             | ✅   | ❌    | ❌   |
| Windows 10 Enterprise LTSC 2021 | ✅   | ❌    | ✅   |
| Windows Server 2019             | ✅   | ❌    | ✅   |
| Windows 10 Enterprise LTSC 2019 | ✅   | ❌    | ✅   |
| Windows Server 2016             | ✅   | ❌    | ✅   |
| Windows 10 Enterprise 2016 LTSB | ✅   | ❌    | ✅   |
| Windows 10 Enterprise 2015 LTSB | ✅   | ❌    | ✅   |
| Windows Server 2012 R2          | ❌   | ✅    | ❌   |
| Windows 8.1                     | ❌   | ✅    | ❌   |


### Supported VM configuration versions for Semi-Annual Channel hosts

The following table lists the VM configuration versions for hosts running a Semi-Annual Channel version of Windows. To get more information on Semi-Annual Channel versions of Windows, visit the following pages for [Windows Server](../../../get-started/servicing-channels-comparison.md) and [Windows](/windows/deployment/update/waas-overview#servicing-channels).

> [!IMPORTANT]
> Windows Server Semi-Annual Channel releases have been retired. For more information current releases, see [Windows Server release information](/windows/release-health/windows-server-release-info).

| Hyper-V host Windows version                   | 12.0 | 10.0 | 9.3 | 9.2 | 9.1 | 9.0 | 8.3 | 8.2 | 8.1 | 8.0 | 7.1 | 7.0 | 6.2 | 5.0 |
|------------------------------------------------|------|------|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|
| Windows 11 (version 22H2), Windows Server 2025 | ✅   | ✅   | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ❌   | ❌  | ❌   | ❌  |
| Windows 11 (version 21H2)                      | ❌   | ✅   | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ❌   | ❌  | ❌   | ❌  |
| Windows 10 November 2021 Update (version 21H2) | ❌   | ❌   | ❌   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ❌   | ❌  | ❌   | ❌  |
| Windows 10 May 2021 Update (version 21H1)      | ❌   | ❌   | ❌   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ❌   | ❌  | ❌   | ❌  |
| Windows Server, version 20H2                   | ❌   | ❌   | ❌   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ❌   | ❌  | ❌   | ❌  |
| Windows 10 October 2020 Update (version 20H2)  | ❌   | ❌   | ❌   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ❌   | ❌  | ❌   | ❌  |
| Windows Server, version 2004                   | ❌   | ❌   | ❌   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ❌   | ❌  | ❌   | ❌  |
| Windows 10 May 2020 Update (version 2004)      | ❌   | ❌   | ❌   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ❌   | ❌  | ❌   | ❌  |
| Windows Server, version 1909                   | ❌   | ❌   | ❌   | ❌  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  |
| Windows 10 November 2019 Update (version 1909) | ❌   | ❌   | ❌   | ❌  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  |
| Windows Server, version 1903                   | ❌   | ❌   | ❌   | ❌  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  |
| Windows 10 May 2019 Update (version 1903)      | ❌   | ❌   | ❌   | ❌  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  |
| Windows Server, version 1809                   | ❌   | ❌   | ❌   | ❌  | ❌   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  |
| Windows 10 October 2018 Update (version 1809)  | ❌   | ❌   | ❌   | ❌  | ❌   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  |
| Windows Server, version 1803                   | ❌   | ❌   | ❌   | ❌  | ❌   | ❌  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  |
| Windows 10 April 2018 Update (version 1803)    | ❌   | ❌   | ❌   | ❌  | ❌   | ❌  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  |
| Windows 10 Fall Creators Update (version 1709) | ❌   | ❌   | ❌   | ❌  | ❌   | ❌  | ❌   | ✅  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  |
| Windows 10 Creators Update (version 1703)      | ❌   | ❌   | ❌   | ❌  | ❌   | ❌  | ❌   | ❌  | ✅   | ✅  | ✅   | ✅  | ✅   | ✅  |
| Windows 10 Anniversary Update (version 1607)   | ❌   | ❌   | ❌   | ❌  | ❌   | ❌  | ❌   | ❌  | ❌   | ✅  | ✅   | ✅  | ✅   | ✅  |

## Why should I upgrade the virtual machine configuration version?

When you move or import a virtual machine to a computer that runs Hyper-V on Windows Server 2019, Windows Server 2016, or Windows 10, the virtual machine's configuration isn't automatically updated. This means that you can move the virtual machine back to a Hyper-V host that runs a previous version of Windows or Windows Server. But, this also means that you can't use some of the new virtual machine features until you manually update the configuration version.

>[!IMPORTANT]
>You can't downgrade a virtual machine configuration version after you've upgraded it.
>We encourage you to remove existing snapshots and your upgrade VM versions, as soon as possible, to take advantage from new features and improvements, described below.

The virtual machine configuration version represents the compatibility of the virtual machine's configuration, saved state, and snapshot files with the version of Hyper-V. When you update the configuration version, you change the file structure that is used to store the virtual machines configuration and the checkpoint files. You also update the configuration version to the latest version supported by that Hyper-V host. Upgraded virtual machines use a new configuration file format, which is designed to increase the efficiency of reading and writing virtual machine configuration data. The upgrade also reduces the potential for data corruption in the event of a storage failure.

The following table lists descriptions file name extensions, and default locations for each type of file that's used for new or upgraded virtual machines.

| Virtual machine file types | Description |
|--|--|
| Configuration | Virtual machine configuration information that is stored in binary file format. <br /> File name extension: .vmcx <br /> Default location: `C:\ProgramData\Microsoft\Windows\Hyper-V\Virtual Machines` |
| Runtime state | Virtual machine runtime state information that is stored in binary file format. <br />File name extension: `.vmrs` and `.vmgs` <br />Default location: `C:\ProgramData\Microsoft\Windows\Hyper-V\Virtual Machines` |
| Virtual hard disk | Stores virtual hard disks for the virtual machine. <br /> File name extension: `.vhd` or `.vhdx` <br />Default location: `C:\ProgramData\Microsoft\Windows\Hyper-V\Virtual Hard Disks` |
| Automatic virtual hard disk | Differencing disk files used for virtual machine checkpoints. <br /> File name extension: `.avhdx` <br /> Default location: `C:\ProgramData\Microsoft\Windows\Hyper-V\Virtual Hard Disks` |
| Checkpoint | Checkpoints are stored in multiple checkpoint files. Each checkpoint creates a configuration file and runtime state file. <br /> File name extensions: `.vmrs` and `.vmcx` <br />Default location: `C:\ProgramData\Microsoft\Windows\Snapshots` |

## What happens if I don't upgrade the virtual machine configuration version?

If you have virtual machines that you created with an earlier version of Hyper-V, some features that are available on the newer host OS might not work with those virtual machines until you update the configuration version.

As a general guidance, we recommend updating the configuration version once you have successfully upgraded the virtualization hosts to a newer version of Windows and feel confident that you don't need to roll back. When you're using the [cluster OS rolling upgrade](../../../failover-clustering/cluster-operating-system-rolling-upgrade.md) feature, this would typically be after updating the cluster functional level. This way, you'll benefit from new features and internal changes and optimizations as well.

>[!NOTE]
>Once the VM configuration version is updated, the VM won't be able to start on hosts that do not support the updated configuration version.

The following table shows the minimum virtual machine configuration version required to use some Hyper-V features.

|Minimum VM configuration version|Feature|OS Version|
|---|---|---|
|12.0|GPU partitioning|Windows Server 2025 / Windows 11 24H2|
|11.2|undocumented change|Windows 11 23H2 "Zinc"|
|11.1|undocumented change|Windows 11 "Copper"|
|11.0|undocumented change|Windows 11 22H2|
|10.5|undocumented change|Host OS "Cobalt+"|
|10.0|undocumented change|Windows Server 2022|
|9.3|undocumented change|Windows 10 "Manganese"|
|9.2|undocumented change|Windows 10 May 2020 Update/Server 2004|
|9.1|undocumented change|Windows 10 May 2019 Update/Server 1903|
|9.0|Allow additional processor features for Perfmon|Windows 10 Oct. Update (19H2), Windows Server 2019|
|9.0|Automatically expose [simultaneous multithreading](../manage/manage-hyper-v-scheduler-types.md#background) configuration for VMs running on hosts using the [Core Scheduler](../manage/manage-hyper-v-scheduler-types.md#hyper-v-defaults-to-using-the-core-scheduler)|Windows 10 Oct. Update (19H2), Windows Server 2019|
|9.0|Hibernation support|Windows 10 Oct. Update (19H2), Windows Server 2019|
|8.3|Increase the default maximum number for virtual devices to 64 per device (for example, networking and assigned devices)|Windows 10 1709|
|8.0|Guest Virtualization-Based Security support (VBS)|Windows 10 1607, Windows Server 2016|
|8.0|Key storage drive|Windows 10 1607, Windows Server 2016|
|8.0|Large memory VMs|Windows 10 1607, Windows Server 2016|
|8.0|Nested Virtualization|Windows 10 1607, Windows Server 2016|
|8.0|Virtual processor count|Windows 10 1607, Windows Server 2016|
|8.0|XSAVE support|Windows 10 1607, Windows Server 2016|
|7.1|Virtual Machine Multi Queues (VMMQ)|
|7.0|Virtual Trusted Platform Module (vTPM)|
|6.2|Hot Add/Remove Memory|
|6.2|PowerShell Direct|
|6.2|Production Checkpoints|
|6.2|Secure Boot for Linux VMs|
|6.2|Virtual Machine Grouping|

For more information about these features, see [What's new in Hyper-V on Windows Server](../What-s-new-in-Hyper-V-on-Windows.md).

