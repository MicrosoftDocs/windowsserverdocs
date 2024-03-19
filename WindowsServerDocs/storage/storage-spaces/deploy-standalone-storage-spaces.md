---
title: Deploy Storage Spaces on a stand-alone server
description: Learn the necessary prerequisites and processes for deploying Storage Spaces on a stand-alone Windows Server-based server.
ms.topic: article
author: JasonGerend
ms.author: jgerend
ms.date: 03/27/2023
---

# Deploy Storage Spaces on a stand-alone server

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This article describes how to deploy Storage Spaces on a stand-alone server. For information about how to create a clustered storage space, see [Deploy a Storage Spaces cluster on Windows Server 2012 R2](</previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/mt270997(v%3dws.11)>).

To create a storage space, you must first create one or more storage pools. A storage pool is a collection of physical disks. A storage pool enables storage aggregation, elastic capacity expansion, and delegated administration.

From a storage pool, you can create one or more virtual disks. These virtual disks are also referred to as *storage spaces*. A storage space appears to the Windows operating system as a regular disk from which you can create formatted volumes. When you create a virtual disk through the File and Storage Services user interface, you can configure the resiliency type (simple, mirror, or parity), the provisioning type (thin or fixed), and the size. Through Windows PowerShell, you can set other parameters such as the number of columns, the interleave value, and which physical disks in the pool to use. For information about these other parameters, see [New-VirtualDisk](/powershell/module/storage/new-virtualdisk) and the [Windows Server Storage](/answers/topics/windows-server-storage.html) forum.

> [!NOTE]
> You can't use a storage space to host the Windows operating system.

From a virtual disk, you can create one or more volumes. When you create a volume, you can configure the size, drive letter or folder, file system (NTFS file system or Resilient File System (ReFS)), allocation unit size, and an optional volume label.

The following figure illustrates the Storage Spaces workflow.

:::image type="content" source="media/deploy-standalone-storage-spaces/storage-spaces-workflow.png" alt-text="Diagram of the workflow for Windows Server storage spaces.":::

> [!NOTE]
> This topic includes sample Windows PowerShell cmdlets that you can use to automate some of the procedures described. For more information, see [What is PowerShell](/powershell/scripting/overview?view=powershell-7.2&preserve-view=true).

## Prerequisites

To use Storage Spaces on a stand-alone Windows Server−based server, make sure that the physical disks that you want to use meet the following prerequisites.

> [!IMPORTANT]
> If you want to learn how to deploy Storage Spaces on a failover cluster, see [Deploy a Storage Spaces cluster on Windows Server 2012 R2](</previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/mt270997(v%3dws.11)>). A failover cluster deployment has different prerequisites, such as supported disk bus types, supported resiliency types, and the required minimum number of disks.

|Area|Requirement|Notes|
|---|---|---|
|Disk bus types|- Serial Attached SCSI (SAS)<br>- Serial Advanced Technology Attachment (SATA)<br>- iSCSI and Fibre Channel Controllers. |You can also use USB drives. However, it's not optimal to use USB drives in a server environment.<br>Storage Spaces is supported on iSCSI and Fibre Channel (FC) controllers as long as the virtual disks created on top of them are nonresilient (Simple with any number of columns).<br>|
|Disk configuration|- Physical disks must be at least 4 GB<br>- Disks must be blank and not formatted. Don't create volumes.||
|HBA considerations|- Simple host bus adapters (HBAs) that don't support RAID functionality are recommended<br>- If RAID-capable, HBAs must be in non-RAID mode with all RAID functionality disabled<br>- Adapters must not abstract the physical disks, cache data, or obscure any attached devices. This guideline includes enclosure services that are provided by attached just-a-bunch-of-disks (JBOD) devices. |Storage Spaces is compatible only with HBAs where you can completely disable all RAID functionality.|
|JBOD enclosures|- JBOD enclosures are optional<br>- We recommend using Storage Spaces certified enclosures listed on the Windows Server Catalog<br>- If you're using a JBOD enclosure, verify with your storage vendor that the enclosure supports Storage Spaces to ensure full functionality<br>- To determine whether the JBOD enclosure supports enclosure and slot identification, run the following Windows PowerShell cmdlet:<br><br> ```Get-PhysicalDisk | ? {$_.BusType –eq "SAS"} | fc``` <br> | If the **EnclosureNumber** and **SlotNumber** fields contain values, then the enclosure supports these features.|

To plan for the number of physical disks and the desired resiliency type for a stand-alone server deployment, use the following guidelines.

|Resiliency type|Disk requirements|When to use|
|---|---|---|
|**Simple**<br><br>- Stripes data across physical disks<br>- Maximizes disk capacity and increases throughput<br>- No resiliency (doesn't protect from disk failure)<br><br><br><br><br><br><br>|Requires at least one physical disk.|Don't use to host irreplaceable data. Simple spaces don't protect against disk failure.<br><br>Use to host temporary or easily recreated data at a reduced cost.<br><br>Suited for high-performance workloads where resiliency isn't required or is already provided by the application.|
|**Mirror**<br><br>- Stores two or three copies of the data across the set of physical disks<br>- Increases reliability, but reduces capacity. Duplication occurs with every write. A mirror space also stripes the data across multiple physical drives.<br>- Greater data throughput and lower access latency than parity<br>- Uses dirty region tracking (DRT) to track modifications to the disks in the pool. When the system resumes from an unplanned shutdown and the spaces are brought back online, DRT makes disks in the pool consistent with each other.|Requires at least two physical disks to protect from single disk failure.<br><br>Requires at least five physical disks to protect from two simultaneous disk failures.|Use for most deployments. For example, mirror spaces are suited for a general-purpose file share or a virtual hard disk (VHD) library.|
|**Parity**<br><br>- Stripes data and parity information across physical disks<br>- Increases reliability when it's compared to a simple space, but somewhat reduces capacity<br>- Increases resiliency through journaling. This function helps prevent data corruption if an unplanned shutdown occurs.|Requires at least three physical disks to protect from single disk failure.|Use for workloads that are highly sequential, such as archive or backup.|

## Step 1: Create a storage pool

You must first group available physical disks into one or more storage pools.

1. In the Server Manager navigation pane, select **File and Storage Services**.

1. Under **Volumes**, select **Storage Pools**.

   By default, available disks are included in a pool that is named the *primordial* pool. If no primordial pool is listed under **STORAGE POOLS**, this situation indicates that the storage doesn't meet the requirements for Storage Spaces. Make sure that the disks meet the requirements that are outlined in the [Prerequisites](#prerequisites) section.

   > [!TIP]
   > If you select the **Primordial** storage pool, the available physical disks are listed under **PHYSICAL DISKS**.

1. Under **STORAGE POOLS**, select the **TASKS** list, and then select **New Storage Pool**. The New Storage Pool Wizard opens.

1. On the **Before you begin** page, select **Next**.

1. On the **Specify a storage pool name and subsystem** page, enter a name and optional description for the storage pool, select the group of available physical disks that you want to use, and then select **Next**.

1. On the **Select physical disks for the storage pool** page, do the following, and then select **Next**:

   1. Select the check box next to each physical disk that you want to include in the storage pool.

   1. If you want to designate one or more disks as hot spares, under **Allocation**, select the drop-down arrow, then select **Hot Spare**.

1. On the **Confirm selections** page, verify that the settings are correct, and then select **Create**.

1. On the **View results** page, verify that all tasks completed, and then select **Close**.

   > [!NOTE]
   > Optionally, to continue directly to the next step, you can select the **Create a virtual disk when this wizard closes** check box.

1. Under **STORAGE POOLS**, verify that the new storage pool is listed.

### Windows PowerShell equivalent commands for creating storage pools

The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.

The following example shows which physical disks are available in the primordial pool.

```PowerShell
Get-StoragePool -IsPrimordial $true | Get-PhysicalDisk -CanPool $True
```

The following example creates a new storage pool named *StoragePool1* that uses all available disks.

```PowerShell
New-StoragePool –FriendlyName StoragePool1 –StorageSubsystemFriendlyName "Windows Storage*" –PhysicalDisks (Get-PhysicalDisk –CanPool $True)
```

The following example creates a new storage pool, *StoragePool1*, that uses four of the available disks.

```PowerShell
New-StoragePool –FriendlyName StoragePool1 –StorageSubsystemFriendlyName "Windows Storage*" –PhysicalDisks (Get-PhysicalDisk PhysicalDisk1, PhysicalDisk2, PhysicalDisk3, PhysicalDisk4)
```

The following example sequence of cmdlets shows how to add an available physical disk *PhysicalDisk5* as a hot spare to the storage pool *StoragePool1*.

```PowerShell
$PDToAdd = Get-PhysicalDisk –FriendlyName PhysicalDisk5
Add-PhysicalDisk –StoragePoolFriendlyName StoragePool1 –PhysicalDisks $PDToAdd –Usage HotSpare
```

## Step 2: Create a virtual disk

Next, you must create one or more virtual disks from the storage pool. When you create a virtual disk, you can select how the data is laid out across the physical disks. This selection affects both reliability and performance. You can also select whether to create thin- or fixed-provisioned disks.

1. If the New Virtual Disk Wizard isn't open yet, on the **Storage Pools** page in Server Manager, under **STORAGE POOLS**, make sure that the desired storage pool is selected.

1. Under **VIRTUAL DISKS**, select the **TASKS** list, and then select **New Virtual Disk**. The New Virtual Disk Wizard opens.

1. On the **Before you begin** page, select **Next**.

1. On the **Select the storage pool** page, select the desired storage pool, and then select **Next**.

1. On the **Specify the virtual disk name** page, enter a name and optional description, then select **Next**.

1. On the **Select the storage layout** page, select the desired layout, then select **Next**.

   > [!NOTE]
   > If you select a layout where you do not have enough physical disks, you receive an error message when you select **Next**. For information about which layout to use and the disk requirements, see [Prerequisites](#prerequisites).

1. If you selected **Mirror** as the storage layout, and you've five or more disks in the pool, the **Configure the resiliency settings** page appears. Select one of the following options:

   - **Two-way mirror**
   - **Three-way mirror**

1. On the **Specify the provisioning type** page, select one of the following options, then select **Next**.

   - **Thin**

     With thin provisioning, space is allocated on an as-needed basis. This selection optimizes the use of available storage. However, because this setting enables you to over-allocate storage, you must carefully monitor how much disk space is available.

   - **Fixed**

     With fixed provisioning, the storage capacity is allocated immediately, at the time, a virtual disk is created. Therefore, fixed provisioning uses space from the storage pool that is equal to the virtual disk size.

     > [!TIP]
     > With Storage Spaces, you can create both thin- and fixed-provisioned virtual disks in the same storage pool. For example, you can use a thin-provisioned virtual disk to host a database and a fixed-provisioned virtual disk to host the associated log files.

1. On the **Specify the size of the virtual disk** page, perform one of the following actions:

   - If you selected thin provisioning in the previous step, follow these steps:

     1. In the **Virtual disk size** box, enter a virtual disk size.
     1. Select the units (**MB**, **GB**, or **TB**), and then select **Next**.

   - If you selected fixed provisioning in the previous step, select one of the following options:

     - **Specify size**

       To specify a size, enter a value in the **Virtual disk size** box, then select the units (**MB**, **GB**, or **TB**).

       > [!NOTE]
       > If you use a storage layout other than simple, the virtual disk uses more free space than the size that you specify. To avoid a potential error in which the size of the volume exceeds the storage pool free space, select the **Create the largest virtual disk possible, up to the specified size** check box.

     - **Maximum size**

       Select this option to create a virtual disk that uses the maximum capacity of the storage pool.

1. On the **Confirm selections** page, verify that the settings are correct, and then select **Create**.

1. On the **View results** page, verify that all tasks are completed, and then select **Close**.

   > [!TIP]
   > By default, the **Create a volume when this wizard closes** check box is selected. This takes you directly to the next step.

### Windows PowerShell equivalent commands for creating virtual disks

The following Windows PowerShell cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.

The following example creates a 50-GB virtual disk named *VirtualDisk1* on a storage pool named *StoragePool1*.

```PowerShell
New-VirtualDisk –StoragePoolFriendlyName StoragePool1 –FriendlyName VirtualDisk1 –Size (50GB)
```

The following example creates a mirrored virtual disk named *VirtualDisk1* on a storage pool named *StoragePool1*. The disk uses the storage pool's maximum storage capacity.

```PowerShell
New-VirtualDisk –StoragePoolFriendlyName StoragePool1 –FriendlyName VirtualDisk1 –ResiliencySettingName Mirror –UseMaximumSize
```

The following example creates a 50-GB virtual disk named *VirtualDisk1* on a storage pool that is named *StoragePool1*. The disk uses the thin provisioning type.

```PowerShell
New-VirtualDisk –StoragePoolFriendlyName StoragePool1 –FriendlyName VirtualDisk1 –Size (50GB) –ProvisioningType Thin
```

The following example creates a virtual disk named *VirtualDisk1* on a storage pool named *StoragePool1*. The virtual disk uses three-way mirroring and has a fixed size of 20 GB.

> [!NOTE]
> You must have at least five physical disks in the storage pool for this cmdlet to work. (This does not include any disks that are allocated as hot spares.)

```PowerShell
New-VirtualDisk -StoragePoolFriendlyName StoragePool1 -FriendlyName VirtualDisk1 -ResiliencySettingName Mirror -NumberOfDataCopies 3 -Size 20GB -ProvisioningType Fixed
```

## Step 3: Create a volume

Next, you must create a volume from the virtual disk. You can assign an optional drive letter or folder, then format the volume with a file system.

1. If the New Volume Wizard isn't open yet, on the **Storage Pools** page in Server Manager, under **VIRTUAL DISKS**, right-click the desired virtual disk, and then select **New Volume**.

   The New Volume Wizard opens.

1. On the **Before you begin** page, select **Next**.

1. On the **Select the server and disk** page, do the following, and then select **Next**.

   1. In the **Server** area, select the server on which you want to provision the volume.

   1. In the **Disk** area, select the virtual disk on which you want to create the volume.

1. On the **Specify the size of the volume** page, enter a volume size, specify the units (**MB**, **GB**, or **TB**), and then select **Next**.

1. On the **Assign to a drive letter or folder** page, configure the desired option, and then select **Next**.

1. On the **Select file system settings** page, do the following, and then select **Next**.

   1. In the **File system** list, select either **NTFS** or **ReFS**.

   1. In the **Allocation unit size** list, either leave the setting at **Default** or set the allocation unit size.

        > [!NOTE]
        > For more information about allocation unit size, see [Default cluster size for NTFS, FAT, and exFAT](https://support.microsoft.com/help/140365/default-cluster-size-for-ntfs-fat-and-exfat).

   1. Optionally, in the **Volume label** box, enter a volume label name, for example **HR Data**.

1. On the **Confirm selections** page, verify that the settings are correct, and then select **Create**.

1. On the **View results** page, verify that all tasks are completed, and then select **Close**.

1. To verify that the volume was created, in Server Manager, select the **Volumes** page. The volume is listed under the server where it was created. You can also verify that the volume was created in Windows Explorer.

### Windows PowerShell equivalent commands for creating volumes

The following Windows PowerShell cmdlet performs the same function as the previous procedure. Enter the command on a single line.

The following example initializes the disks for virtual disk *VirtualDisk1*, creates a partition with an assigned drive letter, and then formats the volume with the default NTFS file system.

```PowerShell
Get-VirtualDisk –FriendlyName VirtualDisk1 | Get-Disk | Initialize-Disk –Passthru | New-Partition –AssignDriveLetter –UseMaximumSize | Format-Volume
```

## Additional information

- [Storage Spaces overview](overview.md)
- Windows PowerShell cmdlets in [Storage](/powershell/module/storage/index)
- [Deploy Clustered Storage Spaces](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj822937(v%3dws.11))
- The forums at [Windows Server Storage](/answers/topics/windows-server-storage.html)
