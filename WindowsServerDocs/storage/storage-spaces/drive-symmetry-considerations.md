---
title: Drive symmetry considerations for Azure Local and Windows Server clusters
description: This article explains drive symmetry constraints in Storage Spaces Direct. It also provides examples of supported and unsupported configurations.
author: robinharwood
ms.author: roharwoo
ms.topic: concept-article
ms.date: 02/10/2025
appliesto: [
            "✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2025</a>",
            "✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2022</a>",
            "✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2019</a>",
            "✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2016</a>",
            "✅ <a href=\"https://learn.microsoft.com/azure/azure-local/release-information-23h2\" target=\"_blank\">Azure Local 2311.2 and later</a>"
           ]
---

# Drive symmetry considerations for Azure Local and Windows Server clusters

Azure Local and Windows Server clusters work best when every server has exactly the same drives.

In reality, we recognize this isn't always practical. Today, you may buy spacious 3 TB hard drives; next year, it may become impossible to find drives that small. Therefore, some amount of mixing-and-matching is expected and supported. Keep in mind, however, that more symmetry is always better.

Storage Spaces Direct is the underlying storage virtualization technology behind Azure Local and Windows Server. This article explains the constraints and provides examples of supported and unsupported configurations in Storage Spaces Direct.

## Constraints

This section explains constraints in terms of drive type, model, size, and number of drives.

### Type

All servers should have the same [types of drives](choose-drives.md#drive-types).

For example, if one server has NVMe, they should *all* have NVMe.

### Number

All servers should have the same number of drives of each type.

For example, if one server has six SSD, they should *all* have six SSD.

   > [!NOTE]
   > It's okay for the number of drives to differ temporarily during failures or while adding or removing drives.

### Model

We recommend using drives of the same model and firmware version whenever possible. If you can't, carefully select drives that are as similar as possible. We discourage mixing-and-matching drives of the same type with sharply different performance or endurance characteristics (unless one is cache and the other is capacity) because Storage Spaces Direct distributes IO evenly and doesn't discriminate based on model.

   > [!NOTE]
   > It's okay to mix-and-match similar SATA and SAS drives.

### Size

We recommend using drives of the same sizes whenever possible. Using capacity drives of different sizes may result in some unusable capacity, and using cache drives of different sizes may not improve cache performance. See the next section for details.

   > [!WARNING]
   > Differing capacity drives sizes across servers may result in stranded capacity.

## Understand: capacity imbalance

Storage Spaces Direct is robust enough to handle capacity imbalance across drives and across servers. Even if the imbalance is severe, everything continues to work. However, depending on several factors, capacity that isn't available in every server may not be usable.

To see why this happens, consider the following simplified illustration. Each colored box represents one copy of mirrored data. For example, the boxes marked A, A', and A'' are three copies of the same data. To honor server fault tolerance, these copies *must* be stored in different servers.

### Stranded capacity

As drawn, Server 1 (10 TB) and Server 2 (10 TB) are full. Server 3 has larger drives, therefore its total capacity is larger (15 TB). However, to store more three-way mirror data on Server 3 would require copies on Server 1 and Server 2 too, which are already full. The remaining 5 TB capacity on Server 3 can't be used – it's *stranded* capacity.

:::image type="content" source="media/drive-symmetry-considerations/size-asymmetry-3n-stranded.png" alt-text="Three-way mirror, three servers, stranded capacity.":::

### Optimal placement

Conversely, with four servers of 10 TB, 10 TB, 10 TB, and 15 TB capacity and three-way mirror resiliency, it's possible to validly place copies in a way that uses all available capacity, as drawn. Whenever this is possible, the Storage Spaces Direct allocator finds and uses the optimal placement, leaving no stranded capacity.

:::image type="content" source="media/drive-symmetry-considerations/size-asymmetry-4n-no-stranded.png" alt-text="Three-way mirror, four servers, no stranded capacity.":::

The number of servers, the resiliency, the severity of the capacity imbalance, and other factors affect whether there's stranded capacity. **The most prudent general rule is to assume that only capacity available in every server is guaranteed to be usable.**

## Understand: cache imbalance

Storage Spaces Direct can also withstand a cache imbalance across drives and across servers. Even if the imbalance is severe, everything continues to work. Moreover, it always uses all available cache to the fullest.

Using cache drives of different sizes may not improve cache performance uniformly or predictably: only IO to [drive bindings](cache.md#server-side-architecture) with larger cache drives may see improved performance. Storage Spaces Direct distributes IO evenly across bindings and doesn't discriminate based on cache-to-capacity ratio.

:::image type="content" source="media/drive-symmetry-considerations/cache-asymmetry.png" alt-text="Cache imbalance.":::

   > [!TIP]
   > See [Understanding the storage pool cache](cache.md) to learn more about cache bindings.

## Example configurations

Here are some supported and unsupported configurations:

### :::image type="icon" source="media/drive-symmetry-considerations/supported.png" border="false"::: Supported: different models between servers

The first two servers use NVMe model "X" but the third server uses NVMe model "Z", which is very similar.

| Server 1                    | Server 2                    | Server 3                    |
|-----------------------------|-----------------------------|-----------------------------|
| 2 x NVMe Model X (cache)    | 2 x NVMe Model X (cache)    | 2 x NVMe Model Z (cache)    |
| 10 x SSD Model Y (capacity) | 10 x SSD Model Y (capacity) | 10 x SSD Model Y (capacity) |

This is supported.

### :::image type="icon" source="media/drive-symmetry-considerations/supported.png" border="false"::: Supported: different models within server

Every server uses some different mix of HDD models "Y" and "Z", which are very similar. Every server has 10 total HDD.

| Server 1                   | Server 2                   | Server 3                   |
|----------------------------|----------------------------|----------------------------|
| 2 x SSD Model X (cache)    | 2 x SSD Model X (cache)    | 2 x SSD Model X (cache)    |
| 7 x HDD Model Y (capacity) | 5 x HDD Model Y (capacity) | 1 x HDD Model Y (capacity) |
| 3 x HDD Model Z (capacity) | 5 x HDD Model Z (capacity) | 9 x HDD Model Z (capacity) |

This is supported.

### :::image type="icon" source="media/drive-symmetry-considerations/supported.png" border="false"::: Supported: different sizes across servers

The first two servers use 4 TB HDD but the third server uses similar 6 TB HDD.

| Server 1                | Server 2                | Server 3                |
|-------------------------|-------------------------|-------------------------|
| 2 x 800 GB NVMe (cache) | 2 x 800 GB NVMe (cache) | 2 x 800 GB NVMe (cache) |
| 4 x 4 TB HDD (capacity) | 4 x 4 TB HDD (capacity) | 4 x 6 TB HDD (capacity) |

This is supported, although it results in stranded capacity.

### :::image type="icon" source="media/drive-symmetry-considerations/supported.png" border="false"::: Supported: different sizes within server

Every server uses some different mix of 1.2 TB and similar 1.6 TB SSD. Every server has 4 total SSD.

| Server 1                 | Server 2                 | Server 3                 |
|--------------------------|--------------------------|--------------------------|
| 3 x 1.2 TB SSD (cache)   | 2 x 1.2 TB SSD (cache)   | 4 x 1.2 TB SSD (cache)   |
| 1 x 1.6 TB SSD (cache)   | 2 x 1.6 TB SSD (cache)   | -                        |
| 20 x 4 TB HDD (capacity) | 20 x 4 TB HDD (capacity) | 20 x 4 TB HDD (capacity) |

This is supported.

### :::image type="icon" source="media/drive-symmetry-considerations/unsupported.png" border="false"::: Not supported: different types of drives across servers

Server 1 has NVMe but the others don't.

| Server 1            | Server 2            | Server 3            |
|---------------------|---------------------|---------------------|
| 6 x NVMe (cache)    | -                   | -                   |
| -                   | 6 x SSD (cache)     | 6 x SSD (cache)     |
| 18 x HDD (capacity) | 18 x HDD (capacity) | 18 x HDD (capacity) |

This isn't supported. The types of drives should be the same in every server.

### :::image type="icon" source="media/drive-symmetry-considerations/unsupported.png" border="false"::: Not supported: different number of each type across servers

Server 3 has more drives than the others.

| Server 1            | Server 2            | Server 3            |
|---------------------|---------------------|---------------------|
| 2 x NVMe (cache)    | 2 x NVMe (cache)    | 4 x NVMe (cache)    |
| 10 x HDD (capacity) | 10 x HDD (capacity) | 20 x HDD (capacity) |

This isn't supported. The number of drives of each type should be the same in every server.

### :::image type="icon" source="media/drive-symmetry-considerations/unsupported.png" border="false"::: Not supported: only HDD drives

All servers have only HDD drives connected.

|Server 1|Server 2|Server 3|
|-|-|-|
|18 x HDD (capacity) |18 x HDD (capacity)|18 x HDD (capacity)|

This isn't supported. You need to add a minimum of two cache drives (NvME or SSD) attached to each of the servers.

## Summary

To recap, every server in the cluster should have the same types of drives and the same number of each type. It's supported to mix-and-match drive models and drive sizes as needed, with the considerations above.

| Constraint | State |
|--|--|
| Same types of drives in every server | **Required** |
| Same number of each type in every server | **Required** |
| Same drive models in every server | Recommended |
| Same drive sizes in every server | Recommended |

## Next steps

For related information, see also:

- [Choose drives](choose-drives.md)
