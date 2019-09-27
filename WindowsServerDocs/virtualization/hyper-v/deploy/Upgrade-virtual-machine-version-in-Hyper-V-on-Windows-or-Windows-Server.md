---
title: Upgrade virtual machine version in Hyper-V on Windows 10 or Windows Server
description: "Gives instructions and considerations for upgrading the version of a virtual machine"
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 897f2454-5aee-445c-a63e-f386f514a0f6
author: jasongerend
ms.author: jgerend
ms.date: 05/22/2019
---
# Upgrade virtual machine version in Hyper-V on Windows 10 or Windows Server

>Applies To: Windows 10, Windows Server 2019, Windows Server 2016, Windows Server (Semi-Annual Channel)

Make the latest Hyper-V features available on your virtual machines by upgrading the configuration version. Don't do this until:

- You upgrade your Hyper-V hosts to the latest version of Windows or Windows Server.
- You upgrade the cluster functional level.
- You're sure that you won't need to move the virtual machine back to a Hyper-V host that runs a previous version of Windows or Windows Server.

For more information, see [Cluster Operating System Rolling Upgrade](../../../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md) and [Perform a rolling upgrade of a Hyper-V host cluster in VMM](https://docs.microsoft.com/system-center/vmm/hyper-v-rolling-upgrade).

## Step 1: Check the virtual machine configuration versions

1. On the Windows desktop, click the Start button and type any part of the name **Windows PowerShell**.
2. Right-click Windows PowerShell and select **Run as Administrator**.
3. Use the [Get-VM](https://docs.microsoft.com/powershell/module/hyper-v/get-vm)cmdlet. Run the following command to get the versions of your virtual machines.

```PowerShell
Get-VM * | Format-Table Name, Version
```

You can also see the configuration version in Hyper-V Manager by selecting the virtual machine and looking at the **Summary** tab.

## Step 2: Upgrade the virtual machine configuration version

1. Shut down the virtual machine in Hyper-V Manager.
2. Select Action > Upgrade Configuration Version. If this option isn't available for the virtual machine, then it's already at the highest configuration version supported by the Hyper-V host.

To upgrade the virtual machine configuration version by using Windows PowerShell, use the [Update-VMVersion](https://docs.microsoft.com/powershell/module/hyper-v/update-vmversion) cmdlet. Run the following command where vmname is the name of the virtual machine.

```PowerShell
Update-VMVersion <vmname>
```

## Supported virtual machine configuration versions

Run the PowerShell cmdlet [Get-VMHostSupportedVersion](https://docs.microsoft.com/powershell/module/hyper-v/get-vmhostsupportedversion) to see what virtual machine configuration versions your Hyper-V Host supports. When you create a virtual machine, it's created with the default configuration version. To see what the default is, run the following command.

```PowerShell
Get-VMHostSupportedVersion -Default
```

If you need to create a virtual machine that you can move to a Hyper-V Host that runs an older version of Windows, use the [New-VM](https://docs.microsoft.com/powershell/module/hyper-v/new-vm) cmdlet with the -version parameter. For example, to create a virtual machine that you can move to a Hyper-V host that runs Windows Server 2012 R2 , run the following command. This command will create a virtual machine named "WindowsCV5" with a configuration version 5.0.

```PowerShell
New-VM -Name "WindowsCV5" -Version 5.0
```

>[!NOTE]
>You can import virtual machines that have been created for a Hyper-V host running an older version of Windows or restore them from backup. If the VM's configuration version is not listed as supported for your Hyper-V host OS in the table below, you have to update the VM configuration version before you can start the VM.

### Supported VM configuration versions for long-term servicing hosts

The following table lists the VM configuration versions that are supported on hosts running a long-term servicing version of Windows.

| Hyper-V host Windows version | 9.1 | 9.0 | 8.3 | 8.2 | 8.1 | 8.0 | 7.1 | 7.0 | 6.2 | 5.0 |
| --- |---|---|---|---|---|---|---|---|---|---|
|Windows Server 2019|&#10006;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|
|Windows 10 Enterprise LTSC 2019|&#10006;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|
|Windows Server 2016|&#10006;|&#10006;|&#10006;|&#10006;|&#10006;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|
|Windows 10 Enterprise 2016 LTSB|&#10006;|&#10006;|&#10006;|&#10006;|&#10006;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|
|Windows 10 Enterprise 2015 LTSB|&#10006;|&#10006;|&#10006;|&#10006;|&#10006;|&#10006;|&#10006;|&#10006;|&#10004;|&#10004;|
|Windows Server 2012 R2|&#10006;|&#10006;|&#10006;|&#10006;|&#10006;|&#10006;|&#10006;|&#10006;|&#10006;|&#10004;|
|Windows 8.1|&#10006;|&#10006;|&#10006;|&#10006;|&#10006;|&#10006;|&#10006;|&#10006;|&#10006;|&#10004;|

### Supported VM configuration versions for semi-annual channel hosts

The following table lists the VM configuration versions for hosts running a currently supported semi-annual channel version of Windows. To get more information on semi-annual channel versions of Windows, visit the following pages for [Windows Server](../../../get-started-19/servicing-channels-19.md) and [Windows 10](https://docs.microsoft.com/windows/deployment/update/waas-overview#servicing-channels)

| Hyper-V host Windows version | 9.1 | 9.0 | 8.3 | 8.2 | 8.1 | 8.0 | 7.1 | 7.0 | 6.2 | 5.0 |
| --- |---|---|---|---|---|---|---|---|---|---|
| Windows 10 May 2019 Update (version 1903) |&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;| &#10004;|
| Windows Server, version 1903 |&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;| &#10004;|
|Windows Server, version 1809|&#10006;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|
|Windows 10 October 2018 Update (version 1809)|&#10006;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|
|Windows Server, version 1803|&#10006;|&#10006;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|
|Windows 10 April 2018 Update (version 1803)|&#10006;|&#10006;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|
|Windows 10 Fall Creators Update (version 1709)|&#10006;|&#10006;|&#10006;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|
|Windows 10 Creators Update (version 1703)|&#10006;|&#10006;|&#10006;|&#10006;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|
|Windows 10 Anniversary Update (version 1607)|&#10006;|&#10006;|&#10006;|&#10006;|&#10006;|&#10004;|&#10004;|&#10004;|&#10004;|&#10004;|

## Why should I upgrade the virtual machine configuration version?

When you move or import a virtual machine to a computer that runs Hyper-V on Windows Server 2019, Windows Server 2016, or Windows 10, the virtual machine"s configuration isn't automatically updated. This means that you can move the virtual machine back to a Hyper-V host that runs a previous version of Windows or Windows Server. But, this also means that you can't use some of the new virtual machine features until you manually update the configuration version. You can't downgrade the virtual machine configuration version after you've upgraded it.

The virtual machine configuration version represents the compatibility of the virtual machine's configuration, saved state, and snapshot files with the version of Hyper-V. When you update the configuration version, you change the file structure that is used to store the virtual machines configuration and the checkpoint files. You also update the configuration version to the latest version supported by that Hyper-V host. Upgraded virtual machines use a new configuration file format, which is designed to increase the efficiency of reading and writing virtual machine configuration data. The upgrade also reduces the potential for data corruption in the event of a storage failure.

The following table lists descriptions, file name extensions, and default locations for each type of file that's used for new or upgraded virtual machines.

 |Virtual machine file types | Description|
 |---|---|
|Configuration |Virtual machine configuration information that is stored in binary file format. <br /> File name extension: .vmcx <br /> Default location: C:\ProgramData\Microsoft\Windows\Hyper-V\Virtual Machines|
 |Runtime state|Virtual machine runtime state information that is stored in binary file format. <br />File name extension: .vmrs and .vmgs <br />Default location: C:\ProgramData\Microsoft\Windows\Hyper-V\Virtual Machines|
|Virtual hard disk|Stores virtual hard disks for the virtual machine. <br /> File name extension: .vhd or .vhdx <br />Default location: C:\ProgramData\Microsoft\Windows\Hyper-V\Virtual Hard Disks|
 |Automatic virtual hard disk |Differencing disk files used for virtual machine checkpoints. <br /> File name extension: .avhdx <br /> Default location: C:\ProgramData\Microsoft\Windows\Hyper-V\Virtual Hard Disks|
 |Checkpoint|Checkpoints are stored in multiple checkpoint files. Each checkpoint creates a configuration file and runtime state file. <br /> File name extensions: .vmrs and .vmcx <br />Default location: C:\ProgramData\Microsoft\Windows\Snapshots|

## What happens if I don't upgrade the virtual machine configuration version?

If you have virtual machines that you created with an earlier version of Hyper-V, some features that are available on the newer host OS may not work with those virtual machines until you update the configuration version.

As a general guidance, we recommend updating the configuration version once you have successfully upgraded the virtualization hosts to a newer version of Windows and feel confident that you do not need to roll back. When you are using the [cluster OS rolling upgrade](https://docs.microsoft.com/windows-server/failover-clustering/Cluster-Operating-System-Rolling-Upgrade) feature, this would typically be after updating the cluster functional level. This way, you will benefit from new features and internal changes and optimizations as well.

>[!NOTE]
>Once the VM configuration version is updated, the VM won't be able to start on hosts that do not support the updated configuration version.

The following table shows the minimum virtual machine configuration version required to use some Hyper-V features.

|Feature|Minimum VM configuration version|
|---|---|
|Hot Add/Remove Memory|6.2|
|Secure Boot for Linux VMs|6.2|
|Production Checkpoints|6.2|
|PowerShell Direct |6.2|
|Virtual Machine Grouping|6.2|
|Virtual Trusted Platform Module (vTPM)|7.0|
|Virtual machine multi queues (VMMQ)|7.1|
|XSAVE support|8.0|
|Key storage drive|8.0|
|Guest virtualization-based security support (VBS)|8.0|
|Nested virtualization|8.0|
|Virtual processor count|8.0|
|Large memory VMs|8.0|
|Increase the default maximum number for virtual devices to 64 per device (e.g. networking and assigned devices)|8.3|
|Allow additional processor features for Perfmon|9.0|
|Automatically expose [simultaneous multithreading](https://docs.microsoft.com/windows-server/virtualization/hyper-v/manage/manage-hyper-v-scheduler-types#background) configuration for VMs running on hosts using the [Core Scheduler](https://docs.microsoft.com/windows-server/virtualization/hyper-v/manage/manage-hyper-v-scheduler-types#windows-server-2019-hyper-v-defaults-to-using-the-core-scheduler)|9.0|
|Hibernation support|9.0|

For more information about these features, see [What's new in Hyper-V on Windows Server](../What-s-new-in-Hyper-V-on-Windows.md).

