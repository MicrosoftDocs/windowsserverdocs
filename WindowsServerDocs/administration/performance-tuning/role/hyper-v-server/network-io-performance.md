---
title: Hyper-V Network I/O Performance
description: Network i/o performance considerations in Hyper-V performance tuning
ms.prod: windows-server
ms.technology: performance-tuning-guide
ms.topic: article
ms.author: Asmahi; SandySp; JoPoulso
author: phstee
ms.date: 10/16/2017
---

# Hyper-V Network I/O Performance

Server 2016 contains several improvements and new functionality to optimize network performance under Hyper-V.  Documentation on how to optimize network performance will be included in a future version of this article.

## Live Migration

Live Migration lets you to transparently move running virtual machines from one node of a failover cluster to another node in the same cluster without a dropped network connection or perceived downtime.

> [!NOTE]
> Failover Clustering requires shared storage for the cluster nodes.

The process of moving a running virtual machine can be divided into two major phases. The first phase copies the memory of the virtual machine from the current host to the new host. The second phase transfers the virtual machine state from the current host to the new host. The durations of both phases is greatly determined by the speed at which data can be transferred from the current host to the new host.

Providing a dedicated network for live migration traffic helps minimize the time that is required to complete a live migration, and it ensures consistent migration times.

![example hyper-v live migration configuration](../../media/perftune-guide-live-migration.png)

Additionally, increasing the number of send and receive buffers on each network adapter that is involved in the migration can improve migration performance.

Windows Server 2012 R2 introduced an option to speed up Live Migration by compressing memory before transferring over the network or use Remote Direct Memory Access (RDMA), if your hardware supports it.

## See also

-   [Hyper-V terminology](terminology.md)

-   [Hyper-V architecture](architecture.md)

-   [Hyper-V server configuration](configuration.md)

-   [Hyper-V processor performance](processor-performance.md)

-   [Hyper-V memory performance](memory-performance.md)

-   [Hyper-V storage I/O performance](storage-io-performance.md)

-   [Detecting bottlenecks in a virtualized environment](detecting-virtualized-environment-bottlenecks.md)

-   [Linux Virtual Machines](linux-virtual-machine-considerations.md)
