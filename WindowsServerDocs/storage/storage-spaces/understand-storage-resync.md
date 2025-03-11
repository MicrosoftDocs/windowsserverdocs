---
title: Understand and monitor storage resync
description: This article provides information on when storage resync happens and how to monitor it in Windows Server.
ms.author: roharwoo
ms.topic: article
author: robinharwood
ms.date: 02/23/2024
---
# Understand and monitor storage resync

>Applies to: Azure Stack HCI, versions 22H2 and 21H2; Windows Server 2022, Windows Server 2019

Storage resync alert is a capability of [Storage Spaces Direct](/windows-server/storage/storage-spaces/storage-spaces-direct-overview) in Azure Stack HCI and Windows Server. It allows the Health Service to throw a fault, notifying you about the resync. This helps prevent you from accidentally taking down more servers, which could affect multiple fault domains resulting in your cluster going down.

This article provides an overview of storage resync and how you can monitor it in a failover cluster with Storage Spaces Direct.

## About storage resync

Let's start with a simple example to understand how storage could get out of sync. Keep in mind that any shared-nothing (local drives only) distributed storage solution exhibits this behavior. The following section demonstrates how storage gets out of sync when one server node goes down. Its drives don't get updated until it comes back online—this behavior is applicable to any hyperconverged architecture.

Suppose you want to store the string "HELLO".

:::image type="content" source="media/understand-storage-resync/hello-string.png" alt-text="Image of a s c i i of a hello string." lightbox="media/understand-storage-resync/hello-string.png":::

Assuming that you have three-way mirror resiliency, you have three copies of this string. If you take down server #1 temporarily (for maintenance), then you can't access copy #1.

:::image type="content" source="media/understand-storage-resync/copy-1.png" alt-text="Image showing you cannot access copy number 1 if you take down server number 1." lightbox="media/understand-storage-resync/copy-1.png":::

Suppose you update the string from "HELLO" to "HELP!" at this time.

:::image type="content" source="media/understand-storage-resync/help-string.png" alt-text="Image of a s c i i of a help! string." lightbox="media/understand-storage-resync/help-string.png":::

After you update the string, copy #2 and #3 are updated successfully. However, copy #1 can't be accessed because server #1 is down temporarily (for maintenance).

:::image type="content" source="media/understand-storage-resync/write-copies.gif" alt-text="GIF of writing to copy number 2 and 3." lightbox="media/understand-storage-resync/write-copies.gif":::

You now have copy #1 with out-of-sync data. The operating system uses granular dirty region tracking to keep track of the bits that are out of sync. This way when server #1 comes back online, you can sync the changes by reading the data from copy #2 or #3 and overwriting the data in copy #1. With this approach, you need to copy over only that data which is stale, instead of resyncing all of the data from server #2 or server #3.

:::image type="content" source="media/understand-storage-resync/overwrite-data.gif" alt-text="GIF of overwriting to copy number 1." lightbox="media/understand-storage-resync/overwrite-data.gif":::

The preceding section described how data could get out of sync. But what does this look like at a high level? Suppose you have a three-server, hyper-converged cluster. When server #1 is in maintenance, you see it as being down. When you bring server #1 back up, it starts resyncing all of its storage using the granular dirty region tracking (explained in the preceding section). Once the data is all back in sync, all servers are shown as up. 

The following GIF shows how storage resync works in a hyper-converged cluster:

:::image type="content" source="media/understand-storage-resync/admin-view.gif" alt-text="GIF of admin view of resync." lightbox="media/understand-storage-resync/admin-view.gif":::

## How to monitor storage resync

Starting with Windows Server 2019, we added a new fault to the [Health Service](/azure/azure-local/manage/health-service-overview) that shows up when your storage is resyncing.

To view this fault in PowerShell, run the following cmdlet:

``` PowerShell
Get-HealthFault
```

This new fault appears in PowerShell, in the cluster validation report, and anywhere else that builds on Health faults.

To get a deeper view, you can query the time series database in PowerShell, as follows:

```PowerShell
Get-ClusterNode | Get-ClusterPerf -ClusterNodeSeriesName ClusterNode.Storage.Degraded
```

Here's an example of the output:

```PowerShell
Object Description: ClusterNode Server1

Series                       Time                Value Unit
------                       ----                ----- ----
ClusterNode.Storage.Degraded 01/11/2019 16:26:48     214 GB
```

Windows Admin Center uses Health faults to set the status and color of the cluster nodes. On the HCI Dashboard, this new fault enables the cluster nodes to transition from red (down) to yellow (resyncing) to green (up), instead of going straight from red to green.

The following image compares how storage resync progresses in Windows Server 2016 vs. Windows Server 2019.

:::image type="content" source="media/understand-storage-resync/compare-view.png" alt-text="Image of Windows Server 2016 vs Window Server 2019 view of resync." lightbox="media/understand-storage-resync/compare-view.png":::

By showing the overall storage resync progress, you can accurately know how much data is out of sync and whether your system is making forward progress. In Windows Admin Center, go to the **Dashboard** to see the new alert, as shown in the following screenshot:

:::image type="content" source="media/understand-storage-resync/wac-alert.png" alt-text="Screen capture of alert in Windows Admin Center." lightbox="media/understand-storage-resync/wac-alert.png":::

The alert is useful in notifying you when resync is happening, so that you don't accidentally take down more servers (which could cause multiple fault domains to be affected, resulting in your cluster going down).

To get a detailed view of how storage resync appears on a per-server basis in Windows Admin Center, navigate to the **Servers** page, click **Inventory**, and then choose a specific server. Navigate to your server and look at the **Storage** chart to see the amount of data that needs to be repaired in a *purple* line with an exact number right above it. This amount increases when the server is down (more data needs to be resynced), and decreases gradually when the server comes back online (data is being synced). When the amount of data that needs to be repaired is 0, your storage is done resyncing—you're now free to take down a server if you need to.

The following screenshot displays the server view in Windows Admin Center:

:::image type="content" source="media/understand-storage-resync/server-view.png" alt-text="Screen capture of server view in Windows Admin Center." lightbox="media/understand-storage-resync/server-view.png":::

## How to monitor storage resync in Windows Server 2016

The alert available in Windows Server 2019 and later is helpful in getting a holistic view of what is happening at the storage layer. It summarizes the information that you can get from the `Get-StorageJob` cmdlet. This cmdlet returns information about long-running storage module jobs, such as a repair operation on a storage space, as shown in the following example output.

```PowerShell
Get-StorageJob
```

Here's an example output:

```PowerShell
Name                  ElapsedTime           JobState              PercentComplete       IsBackgroundTask
----                  -----------           --------              ---------------       ----------------
Regeneration          00:01:19              Running               50                    True

```

This view is more granular because the storage jobs are listed per volume. You can see the list of jobs that are running and you can track their individual progress. This cmdlet works on both Windows Server 2016 and 2019.

## Additional References

- [Taking a server offline for maintenance](/azure/azure-local/manage/maintain-servers)
- [Storage Spaces Direct overview](/windows-server/storage/storage-spaces/storage-spaces-direct-overview)
