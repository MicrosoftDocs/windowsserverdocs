---
title: Replace failed drives on Azure Stack HCI
description: How to replace failed drives on Azure Stack HCI.
ms.topic: how-to
author: alkohli
ms.author: alkohli
ms.reviewer: jgerend
ms.date: 04/19/2023
---

# Replace failed drives on Azure Stack HCI

> Applies to: Azure Stack HCI, versions 22H2 and 21H2; Windows Server 2022, Windows Server 2019

Azure Stack HCI works with direct-attached SATA, SAS, NVMe, and persistent memory drives that are physically attached to a single server. Storage Spaces Direct automatically retires and evacuates failed drives. When this happens, the drive status is **Retired**, and its storage capacity bar is empty.

If a drive fails, you need access to the physical server hardware to replace it.

## Find the alert

When a drive fails, an alert appears in the upper **Alerts** area of the Windows Admin Center Dashboard.

1. In Windows Admin Center, select the alert to see details, like the drive's physical location.
1. To see more details, select **Drives** under **Tools** in the left pane to browse drives and see their status. On the **Inventory** tab, you can sort, group, and search across drives.
1. If your hardware supports it, you can select **Light On** or **Light Off** to control the drive's indicator light.
1. Physically remove the failed drive and insert its replacement.

## Wait for the alert to clear

In Windows Admin Center, under the **Drives > Inventory** tab, the new drive will appear. In time, the alert clears, volumes repair back to OK status, and storage rebalances onto the new drive automatically.

## Troubleshooting

If the new drive is not added to the pool, it may be because AutoPool is disabled. To determine this, run the following PowerShell command as administrator:

```powershell
Get-StorageSubsystem Cluster* | Get-StorageHealthSetting | select "System.Storage.PhysicalDisk.AutoPool.Enabled"
```

If the value is **True**, AutoPool is enabled.  If the value is **False**, AutoPool is disabled.  You have two options to resolve this issue:

### Option A

This option leaves AutoPool disabled and manually adds the disk(s) to the storage pool. Run the following series of PowerShell commands as administrator:

Run the following and verify the new physical disk is listed with `OperationalStatus` is **OK**, and `HealthStatus` is **Healthy**.

```powershell
Get-PhysicalDisk -CanPool $true
```

Next, run the following command and make a note of the **FriendlyName** of the storage pool that you want to add the disk to. If this is a stretched cluster, you should see more than one pool name:

```powershell
Get-StoragePool -IsPrimordial $False
```

Next, run the following command:

```powershell
$disks = Get-PhysicalDisk -CanPool $true
```

Lastly, run the following command:
```powershell
Add-PhysicalDisk -StoragePoolFriendlyName "FriendlyName_from_step2" -PhysicalDisks $disks
```

### Option B

This option enables AutoPool and lets the Health service add the disk to the pool. Run the following PowerShell command as administrator:

```powershell
Get-StorageSubsystem Cluster* | Set-StorageHealthSetting -Name "System.Storage.PhysicalDisk.AutoPool.Enabled" -Value True
```

## Next steps

- To learn about how storage health is tracked at different levels, including at the drive level, see [Health and operational states](/windows-server/storage/storage-spaces/storage-spaces-states).
- If you're using PMem, see [Understand and deploy persistent memory](/windows-server/storage/storage-spaces/deploy-pmem)
