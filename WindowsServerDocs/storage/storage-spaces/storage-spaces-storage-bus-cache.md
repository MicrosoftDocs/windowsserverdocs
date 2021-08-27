---
title: Storage bus cache on Storage Spaces 
description: Enable storage bus cache on standalone servers for better read and write performance
author: TinaWu-Msft
ms.author: tinawu
ms.prod: windows-server
ms.topic: tutorial #Required; leave this attribute/value as-is.
ms.date: 05/25/2021
ms.custom: template-tutorial #Required; leave this attribute/value as-is.
---

# Tutorial: Enable storage bus cache with Storage Spaces on standalone servers

>Applies to: Windows Server 2022

The storage bus cache for standalone servers can significantly improve read and write performance, while maintaining storage efficiency and keeping the operational costs low. Similar to its [implementation for Storage Spaces Direct](understand-the-cache.md), this feature binds together faster media (for example, SSD) with slower media (for example, HDD) to create tiers. By default, only a portion of the faster media tier is reserved for the cache.

|Resiliency  |Cache type  |
|---------|---------|
|None (Simple space)     | Read and write         |
|Mirror accelerated parity     |Read       |

If your system does not require resiliency or has external backups, the storage bus cache will support both read and write caching. For resilient systems, the storage bus cache will only serve as a read cache and it is recommended to pick ReFS [Mirror-accelerated parity](../refs/mirror-accelerated-parity.md) as the volume resiliency. This combination improves random read performance as data is read from the parity tier and cached on the faster mirror tier. The mirror tier also provides write caching capabilities if the Provision Mode is set to Shared (default).

:::image type="content" source="media/storage-bus-cache/sbc-map.png" alt-text="Storage bus cache read and write paths":::

In this tutorial, you learn about:

> [!div class="checklist"]
> * What the storage bus cache is
> * How to enable the storage bus cache  
> * Managing the cache after deployment

## Prerequisites

### ![Green checkmark icon.](media/storage-bus-cache/supported.png) Consider storage bus cache if:

- Your server runs Windows Server 2022; and
- Your server has 2 media/ drive types, one of which must be HDD (for example: SSD+HDD or NVMe+HDD); and
- Your server has the Failover Clustering feature installed

### ![Red X icon.](media/storage-bus-cache/unsupported.png) You can't use storage bus cache if:

- Your server runs Windows Server 2016 or 2019; or
- Your server has an all flash configuration; or
- You server is a member of a Failover Cluster

## Feature overview

This section explains what each configurable field of the storage bus cache is and applicable values.

```PowerShell
Get-StorageBusCache
```

The output should resemble below when not enabled:

```PowerShell
ProvisionMode                  : Shared
SharedCachePercent             : 15
CacheMetadataReserveBytes      : 34359738368
CacheModeHDD                   : ReadWrite
CacheModeSSD                   : WriteOnly
CachePageSizeKBytes            : 16
Enabled                        : False
```

> [!NOTE]
> For general use, default settings are recommended. Any changes must be made prior to enabling the storage bus cache.

### Provision Mode

This field determines if the entire faster media tier or only a portion of it will be used for caching. This field cannot be modified after enabling the storage bus cache.

- Shared (default): The cache will only take up a portion of the faster media tier. The exact percentage is configurable by the Shared Cache Percentage field below.
- Cache: Dedicate majority of the faster media tier to caching as opposed to only a portion. The implementation is similar to the [storage bus cache in Storage Spaces Direct](understand-the-cache.md).

### Shared cache percentage

This field is only applicable when the Provision Mode is set to Shared. The default value is 15% and the field can be set from 5% to 90%. A value over 50% is not recommended when using mirror accelerated parity volumes as there needs to be a balance between the cache and the mirror tier.

### Enabled

This field refers to the state of the storage bus cache and can either be True or False.

### Advanced fields

> [!IMPORTANT]
> Changes to these fields are not recommended. Adjustments after enabling the storage bus cache cannot be made.

- **Cache metadata reserve bytes:** The amount of disk space (in bytes) reserved for Storage Spaces. This field is only applied if the Provision Mode is Cache.

- **Cache mode HDD:** The default is to allow the HDD capacity devices to cache reads and writes. For Simple spaces, this setting can be set to ReadWrite or WriteOnly.

- **Cache mode SSD:** For future use when all flash systems are supported. The default is to allow the SSD capacity devices to cache writes only.

- **Cache page size KBytes:** This field can be set to 8, 16 (default), 32 and 64.

## Enable storage bus cache in PowerShell

This section is a step-by-step guide on how to enable the storage bus cache for your stand-alone server in PowerShell.

1. Import the module

    ```PowerShell
    Import-Module StorageBusCache 
    ```

2. Configure storage bus cache settings
    
    Default settings are recommended, skip this step to continue with the defaults.

    > [!IMPORTANT]
    > If configuration is needed, do so before enabling the storage bus cache. Refer to Feature overview section for details of the fields.

3. Check the drive status

    ```PowerShell
    Get-PhysicalDisk
    ```

    The output should resemble the image below, where the Number column shows values under 500 and the CanPool column shows True for all non-boot drives.
    
    :::image type="content" source="media/storage-bus-cache/get-physical-disk.png" alt-text="Result from Get-PhysicalDisk before enabling the storage bus cache":::

4. Enable storage bus cache

    ```PowerShell
    Enable-StorageBusCache
    ```

    This step will:
    > [!div class="checklist"]
    > * Create a storage pool with all the available drives
    > * Bind the fast and slow media and form the cache
    > * Add the storage bus cache with default or custom settings

    You can run ``Get-StoragePool`` to see the name of the storage pool and ``Get-PhysicalDisk`` again to see the effects of enabling storage bus cache. The output should resemble the image below, where the Number column shows values over 500 (indicating the drive is claimed by the storage bus) and the CanPool column now shows False for all non-boot drives. If the ProvisionMode was set to Cache prior to enabling, the Usage column will show as Journal for the faster drives.  
    
    :::image type="content" source="media/storage-bus-cache/get-physicaldisk-2.png" alt-text="Results of Get-StoragePool and Get-PhysicalDisk after enabling the storage bus cache":::

5. Check the storage bus cache state

    Check that the fields are correct and the Enabled field is now set to true.
    
    ```PowerShell
    Get-StorageBusCache 
    ```

    The output should resemble below:
    
    ```PowerShell
    ProvisionMode                  : Shared
    SharedCachePercent             : 15
    CacheMetadataReserveBytes      : 34359738368
    CacheModeHDD                   : ReadWrite
    CacheModeSSD                   : WriteOnly
    CachePageSizeKBytes            : 16
    Enabled                        : True
    ```
    
Now the storage bus cache has been successfully enabled, the next step is to create a volume.

## Create a volume

### Volumes with resiliency:
The PowerShell cmdlet below creates a 1TiB mirror-accelerated parity volume with a Mirror:Parity ratio of 20:80, which is the recommended configuration for most workloads. For more information, see [Mirror-accelerated parity](../refs/mirror-accelerated-parity.md).

```PowerShell
New-Volume –FriendlyName "TestVolume" -FileSystem ReFS -StoragePoolFriendlyName Storage* -StorageTierFriendlyNames Performance, Capacity -StorageTierSizes 200GB, 800GB
```

### Volumes without resiliency:
The PowerShell cmdlet below creates a 1TB Simple volume that cannot tolerate any disk failure. Both read and write caching is supported.

```PowerShell
New-Volume -FriendlyName "TestVolume" -FileSystem ReFS -StoragePoolFriendlyName Storage* -ResiliencySettingName Simple -Size 1TB
```

## Making changes after enabling storage bus cache
After running ``Enable-StorageBusCache``, the Provision mode, Shared cache percent, Cache metadata reserve bytes, Cache mode HDD, Cache mode SSD, and Cache page size cannot be modified. Limited changes can be made to the physical setup, below are some common scenarios.

### Adding or replacing capacity drives (HDDs)

Once the drive has been manually added, run the cmdlet below to finish the intake process.

```PowerShell
Update-StorageBusCache
```

### Adding or replacing cache drives (NVMes or SSDs)
There is no cmdlet to unbind/rebind existing bindings and balance out the relationship. The steps below will cause the existing read cache to be lost.

```PowerShell
Remove-StorageBusBinding
New-StorageBusBinding 
```

### Check and balance cache and capacity bindings 
Use the following cmdlet to check the existing cache and capacity bindings.

```PowerShell
Get-StorageBusBinding
```

In the example below, the first column lists out capacity drives and the third column lists out the cache drives that they are bound to. Follow the instructions in Adding or replacing cache drives to balance, the existing cache will not be preserved.

:::image type="content" source="media/storage-bus-cache/get-storagebusbinding.png" alt-text="Output of Get-StorageBusBinding":::
