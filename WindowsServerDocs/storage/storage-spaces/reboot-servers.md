---
title: Taking a Storage Spaces Direct server offline for maintenance
ms.prod: windows-server-threshold
ms.author: eldenc
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: eldenchristensen
ms.date: 03/17/2017
---

# Taking a Storage Spaces Direct server offline for maintenance

> Applies To: Windows Server 2016

This topic provides guidance on how to properly shutdown or restart a server that is a member of a [Storage Spaces Direct](storage-spaces-direct-overview.md) cluster.

When bringing down a server for maintenance or restarting to apply an update, there are special considerations with Storage Spaces Direct: bringing down a server also means bringing down pieces of the storage, which is shared across all the servers. This requires properly draining both the compute and storage from the server, and ensuring there are sufficient copies of the data available elsewhere so it remains online and available throughout.

We recommend using [Cluster Aware Updating (CAU)](https://technet.microsoft.com/library/hh831694.aspx) to automate the process of patching Storage Spaces Direct clusters. It is integrated with Storage Spaces Direct and will automate all of the below steps below, including checking volume health and resync progress before patching the next server.

## Verifying it's safe to take the server down

Before bringing a server down for maintenance, verify that your volumes are healthy.

In Failover Cluster Manager, go to **Storage** -> **Disks** and look at the **Status** column:

(IMAGE)

In PowerShell, run the following cmdlet as Administrator:

```PowerShell
PS C:\> Get-VirtualDisk 

FriendlyName ResiliencySettingName OperationalStatus HealthStatus IsManualAttach Size
------------ --------------------- ----------------- ------------ -------------- ----
MyVolume1    Mirror                OK                Healthy      True           1 TB
MyVolume2    Mirror                OK                Healthy      True           1 TB
MyVolume3    Mirror                OK                Healthy      True           1 TB
```

Check that the **HealthStatus** property for every volume (virtual disk) is **Healthy**.

## Pause and drain the server

When shutting down or restarting a server, first drain (move off) any roles such as virtual machines running on that server. This also gives Storage Spaces Direct an opportunity to gracefully flush and commit data to ensure the shutdown is graceful to any applications running on that server.

In Failover Cluster Manager, go to **Nodes**. Right-click, or use the **Actions** pane on the right, and select **Pause** -> **Drain Roles**.

(IMAGE)

In PowerShell, you can pause and drain with the following cmdlet (run as Administrator):

```PowerShell
PS C:\> Suspend-ClusterNode -Drain
```

All roles will begin moving (for virtual machines, this means live migrating) to other servers in the cluster. This can take a few minutes.

   > [!NOTE]
   > When you pause and drain the cluster node properly, Windows performs an automatic safety check to ensure the volumes are healthy. If there are unhealthy volumes, it will alert you that it's not safe to perform the requested action.

## Shutting down the server

Once the server has completed draining, it will show as **Paused** in Failover Cluster Manager and PowerShell.

(IMAGE)

You can safely restart it or shut it down, just like you would normally.

   > [!IMPORTANT]
   > While the server is paused, storage IO does not flow to its drives. This means that although your volumes remains online and accessible, they will show as **Incomplete** in Failover Cluster Manager or PowerShell. This is expected.

```PowerShell
PS C:\> Get-VirtualDisk 

FriendlyName ResiliencySettingName OperationalStatus HealthStatus IsManualAttach Size
------------ --------------------- ----------------- ------------ -------------- ----
MyVolume1    Mirror                Incomplete        Warning      True           1 TB
MyVolume2    Mirror                Incomplete        Warning      True           1 TB
MyVolume3    Mirror                Incomplete        Warning      True           1 TB
```

## Resume the server

When you are ready for the server to begin hosting workloads again and allowing storage IO to its drives, resume it.

In Failover Cluster Manager, go to **Nodes**. Right-click, or use the **Actions** pane on the right, and select **Resume**. If you want to move roles that were previously running on this server back, choose **Failback Roles** (optional).

(IMAGE)

In PowerShell, you can resume with the following cmdlet (run as Administrator):

```PowerShell
PS C:\> Resume-ClusterNode
```

To move the roles that were previously running on this server back run:

```PowerShell
PS C:\> Resume-ClusterNode –Failback Immediate
```

## Wait for storage to resync

When the server resumes, all data that changed (new writes) while its drives were inaccessible needs to be synchronized ("resync"). This happens automatically. Because change tracking monitors what new writes happened while the server was paused, it's not necessary for *all* data to be scanned or overwritten; only the changes. This process is throttled to mitigate impact to production workloads, and can take several minutes. 

To help ensure the availability of your data, wait for synchronization to complete before pausing or shutting any others servers in the cluster.

In PowerShell, check the status of your volumes.

```PowerShell
PS C:\> Get-VirtualDisk 

FriendlyName ResiliencySettingName OperationalStatus HealthStatus IsManualAttach Size
------------ --------------------- ----------------- ------------ -------------- ----
MyVolume1    Mirror                InService         Warning      True           1 TB
MyVolume2    Mirror                InService         Warning      True           1 TB
MyVolume3    Mirror                InService         Warning      True           1 TB
```

You can also monitor the progress of the resync ("Repair") jobs themselves with this PowerShell cmdlet (run as Administrator):

```PowerShell
PS C:\> Get-StorageJob

Name   IsBackgroundTask ElapsedTime JobState  PercentComplete BytesProcessed BytesTotal
----   ---------------- ----------- --------  --------------- -------------- ----------
Repair True             00:06:23    Running   65              11477975040    17448304640
Repair True             00:06:40    Running   66              15987900416    23890755584
Repair True             00:06:52    Running   68              20104802841    22104819713
```

If any jobs are listed, wait for them to complete. The **PercentComplete** will display progress.   

Once no jobs are displayed and the volumes are healthy, the server has resumed full functionality, and the volumes are  healthy.

It's now safe to pause and restart other servers in the cluster.

## See also

- [Storage Spaces Direct overview](storage-spaces-direct-overview.md)
- [Fault tolerance and storage efficiency](storage-spaces-fault-tolerance.md)
