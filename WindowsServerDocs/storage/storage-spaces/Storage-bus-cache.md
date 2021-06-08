---
title: Storage bus cache on Storage Spaces 
description: Enable storage bus cache on standalone servers for better read and write performance
author: TinaWu-Msft
ms.author: tinawu
ms.service: #Required; service per approved list. slug assigned by ACOM.
ms.topic: tutorial #Required; leave this attribute/value as-is.
ms.date: 05/25/2021
ms.custom: template-tutorial #Required; leave this attribute/value as-is.
---


# Tutorial: Enable storage bus cache with Storage Spaces on standalone servers 

<!-- 2. Introductory paragraph 
Required. Lead with a light intro that describes, in customer-friendly language, 
what the customer will learn, or do, or accomplish. Answer the fundamental “why 
would I want to do this?” question. Keep it short.
-->

If you are using Storage Spaces to manage a lot of frequently accessed and modified data, then this is a feature that you will want to learn more about! The storage bus cache (SBC) for standalone servers can return information and data to your customers fast, while maintaining storage efficiency and keeping the operational costs low. Take for example a SQL database or a mail hosting service, any application where performance is crucial, but storage efficiency is still prioritized. The admin would want a solution that balances resiliency (to combat data loss), speed (better user experience), and ease of management. Frequently accessed content will be cached so that reads return faster, while other content is efficiently stored and the system remains easily scalable.

|  |  |
|---------|---------|
|:::image type="content" source="media/storage-bus-cache/ReadPathMAP.png" alt-text="Read path in a mirror accelerated parity volume without storage bus cache":::|:::image type="content" source="media/storage-bus-cache/ReadPathMAPSBC.png" alt-text="Read oath with storage bus cache enabled on a mirror accelerated parity volume":::|
|Left: Read path in a mirror accelerated parity volume|Right: Read path with storage bus cache enabled and with a mirror accelerated parity volume|

Similar to its implementation for Storage Spaces Direct, this feature binds together faster media (e.g. SSD) with slower media (e.g. HDD), and reserves a portion (not the whole!) of the faster media tier for caching. If you are using simple spaces (no resiliency), both read and write caching is supported, any other resiliency setting will only have read caching capabilities for now. The best configuration is using the SBC in combination with ReFS [Mirror-accelerated parity](../refs/mirror-accelerated-parity.md). This set up maintains all the storage efficiency benefits of ReFS MAP and incorporates a read cache as a part of the faster media tier for better random read performance. Setup and maintenance is extremely streamlined, below is a step-by-step guide with screenshots to help you add this capability to your system and boost performance.

In this tutorial, you learn about:

> [!div class="checklist"]
> * What the storage bus cache is
> * How to enable the storage bus cache  
> * Managing the cache after deployment

## Prerequisites

### ![Green checkmark icon.](media/storage-bus-cache/supported.png) Consider storage bus cache if:

- Your cluster runs Windows Server 2022; and
- Your cluster has 2 media/ drive types (e.g. SSD + HDD or NVMe + HDD)
- Your cluster has failover cluster installed 

### ![Red X icon.](media/storage-bus-cache/unsupported.png) You can't use storage bus cache if:

- Your cluster runs Windows Server 2016 or 2019; or
- Your cluster has an all flash configuration  

<!-- 5. H2s
Required. Give each H2 a heading that sets expectations for the content that follows. 
Follow the H2 headings with a sentence about how the section contributes to the whole.
-->

## Feature overview

This section explains what each configurable field of the storage bus cache is and applicable values.

> [!NOTE]
> For general use, default settings are recommended. If a change is necessary, do so prior to enabling the feature.

```powershell
Get-StorageBusCache
```

The output should resemble the following:

```powershell
ProvisionMode                  : Shared
SharedCachePercent             : 15
CacheMetadataReserveBytes      : 34359738368
CacheModeHDD                   : ReadWrite
CacheModeSSD                   : WriteOnly
CachePageSizeKBytes            : 16
Enabled                        : True
```

### Provision Mode

This field determines if the entire fast media tier or only a portion of it will be used for caching. This field cannot be modified after enabling the SBC.

- Shared (default): The cache will only take up a portion of the faster media tier (e.g. all the SSDs). The exact percentage is configurable by the Shared Cache Percentage field below.
- Cache: Dedicate the entire faster media tier to caching as opposed to only a portion. This is currently only supported for simple spaces (no resiliency).

### Shared cache percentage

This field is only applicable when the Provision Mode is set to Shared. The default value is 15% and the field can be set from 5% to 90%. A value of over 50% is not recommended – due to balancing the mirror tier of ReFS MAP and read cache. There is a tradeoff when going over 50%.  

### Enabled

This field refers to the state of the storage bus cache and can either be True or False. 

### Advanced fields

> [!IMPORTANT]
> Changes to these fields are not recommended. Adjustments after enabling the storage bus cache cannot be made.

- Cache metadata reserve bytes: The amount of disk space, in bytes, to reserve for the cache of a flash drive when using Storage Spaces. Changes to this field is only allowed if the Provision Mode is Cache.

- Cache mode HDD: The default is to allow the HDD capacity devices to cache reads and writes. For simple spaces, this setting can be set to ReadWrite or WriteOnly.

- Cache mode SSD: For future use. Comes in when all flash system is supported. The default is to allow the SSD capacity devices to cache writes only.

- Cache page size bytes: This field can be set to 8, 16 (default), 32 and 64.

## Enable storage bus cache in PowerShell

This section is a step by step guide on how to enable the storage bus cache for your stand-alone server in PowerShell. 

1. Import the module

```powerShell
Import-Module StorageBusCache 
```

2. Configure storage bus cache settings

Default settings are recommended, skip this step to continue with the defaults. If configuration is needed, do so before enabling the storage bus cache. Refer to Feature overview section for information.

```powershell
#Example: change the provision mode from Shared (default) to Cache 
Set-StorageBusCache -ProvisionMode Cache

#Example: change the shared cache percentage from 15% (default) to 25% 
Set-StorageBusCache -SharedCachePercent 25
```

3. Check the drive status

Ensure that all expected drives show up and are Healthy and True for CanPool

```PowerShell
Get-PhysicalDisk
```

The output should look something like:
:::image type="content" source="media/storage-bus-cache/Get-PhysicalDisk.png" alt-text="Result from Get-PhysicalDisk cmdlet":::

4. Enable storage bus cache

```powershell
Enable-StorageBusCache
```

This step will:
> [!div class="checklist"]
> * Create a storage pool with all the available drives
> * Bind the fast and slow media to form storage tiers
> * Add the storage bus cache with default or custom settings

You can run the cmdlet in Step 3 again to see the effects of enabling storage bus cache.

5. Check the storage bus cache state

Check that the fields are correct and the Enabled field is now set to true.

```PowerShell
Get-StorageBusCache 
```

## Create a volume 

# Volumes with resiliency: 
The storage bus cache performs best when combined with a ReFS mirror accelerated parity volume.This combination offers read caching and write caching as writes are stored on the mirror tier, while maintaining storage efficiency as cold data gets rotated to the slower tier as parity. 

The PowerShell cmdlet below creates a mirror-accelerated parity volume with a Mirror:Parity ratio of 20:80, which is the recommended configuration for most workloads. For more information, see [Mirror-accelerated parity](../refs/mirror-accelerated-parity.md). 

```powershell
New-Volume – FriendlyName “TestVolume” -FileSystem CSVFS_ReFS -StoragePoolFriendlyName “StoragePoolName” -StorageTierFriendlyNames Performance, Capacity -StorageTierSizes 200GB, 800GB
```

# Volumes without resiliency:
Use the following to create a volume that cannot tolerate node and disk failures, both read and write caching is supported.

```powershell
New-Volume -FriendlyName "TestVolume" -FileSystem CSVFS_ReFS -StoragePoolFriendlyName “StoragePoolName”-ResiliencySettingName simple -Size Size
```

## Making changes after enabling storage bus cache
After running ``Enable-StorageBusCache``, limited changes can be made to the setup, below are some common scenarios for reference.

# Adding or replacing capacity drives (HDDs)

Once the drive has been manually added, run the cmdlet below to finish the intake process.

```powershell
Update-StorageBusCache
```

# Adding or replacing cache drives (NVMes or SSDs)
There is no cmdlet to intake a new cache drive and balance out the bindings. This process will cause the existing read cache to be lost. 

```powershell
Remove-StorageBusBinding
New-StorageBusBinding 
```

# Balance cache and capacity bindings 
Use the following cmdlet to check for existing cache and capacity bindings:

```powershell
Get-StorageBusBinding
```

In the example below, the first column lists out capacity drives and the third column lists out the cache drives that they are bound to. Follow the instructions in Adding or replacing cache drives to balance, note that this is at the expense of loosing the existing cache.
:::image type="content" source="media/storage-bus-cache/Get-StorageBusBinding.png" alt-text="Output of Get-StorageBusBinding":::
