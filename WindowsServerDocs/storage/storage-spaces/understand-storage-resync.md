---
title: Understand and see storage resync
description: Detailed info on when storage resync happens and how to see it in Windows Server 2019.
keywords: Storage Spaces Direct,storage resync,resync, storage, S2D
ms.assetid: 
ms.prod: 
ms.author: adagashe
ms.technology: storage-spaces
ms.topic: article
author: adagashe
ms.date: 11/26/2018 
ms.localizationpriority: 
---
---
# Understand and see storage resync

>Applies to: Windows Server 2019

This topic provides background and steps to understand and see storage resync in a Windows Server failover cluster with storage spaces direct.

## Understanding resync

Let's start with a simple example to understand storage gets out of sync. Suppose that we want to store the string "HELLO". 

![ASCII of string "hello"](media/understand-storage-resync/hello.png)

Asssuming that we have three-way mirror resiliency, we have three copies of this string. Now, if we take server #1 down temporarily (for maintanence), then we cannot access copy #1.

![Can't access copy #1](media/understand-storage-resync/copy1.png)

Suppose we update our string from "HELLO" to "HELP!" at this time.

![ASCII of string "help!"](media/understand-storage-resync/help.png)

Once we update the string, copy #2 and #3 will be succesfully updated. However, copy #1 still cannot be accessed because server #1 is down temporarily (for maintanence). 

![Gif of writing to copy #2 and #2"](media/understand-storage-resync/write.gif)

Now, we have copy #1 which has data that is out of sync. The operating system uses granular dirty region tracking to keep track of the bits that are out of sync. This way when server #1 comes back online, we can sync the changes by reading the data from copy #2 or #3 and overwriting the data in copy #1.

![Gif of overwriting to copy #1"](media/understand-storage-resync/overwrite.gif)

So, this explains how data gets out of sync. But what does this look like at a high level? Assume for this example that we have a three server hyper-coinverged cluster. When server #1 is in maintenance, you will see it as being down. When you bring server #1 back up, it will start resyncing all of its storage using the granular dirty region tracking (explained above). Once the data is all back in sync, all servers will be shown as up.

![Gif of admin view of resync"](media/understand-storage-resync/admin.gif)

## How to see storage resync

Now that you understand how storage resync works, let's look at how this shows up. We have added a new fault to the Health Service that will show up when your storage is resyncing. More information on the Health Service can be found [here](../../failover-clustering/health-service-overview.md).

To view this fault in PowerShell, run:

``` PowerShell
Get-HealthFault
```

This is a new fault in Windows Server 2019, and will appear in PowerShell, in the cluster validation report, and anywhere else that builds on Health faults, such as the Azure Stack portal. 

Notably, Windows Admin Center uses Health faults to set the status and color of cluster nodes. So, this new fault will cause cluster nodes to transition from red (down) to yellow (resyncing) to green (up), instead of going straight from red to green, on the HCI Dashboard.

![Image of 2016 vs 20198 view of resync"](media/understand-storage-resync/compare.png)

This alert is particularly helpful in getting a holistic view of what is happening at the storage layer. Previously, in PowerShell, you would have ran:

``` PowerShell
Get-StorageJob
```

This would have given you a list of the jobs that were running and their individual progress, and you would have had to wait for each one to finish. Now, by showing the overall storage resync progress, you can accurately know how much data is out of sync and whether your system is making forward progress.

Below is an image of how the new alert shows up in Windows Admin Center:

![Image of alert in Windows Admin Center"](media/understand-storage-resync/alert.png)

The alert is useful in notifying you when resync is happening, so that you don't accidentally take more servers down (which could cause multiple fault domains to be affected, resulting in your cluster going down). 

You can also get a more detailed view of how this storage resync looks on a per-server basis. If you navigate to your server and look at the *Storage* chart, you will see the amount of data that needs to be repaired in a *purple* line. This amount will increase when the server is down (more data needs to be resynced), and gradually decreased when the server comes back online (data is being synced). A screenshot of this experience in Windows Admin Center is shown below:

![Image of server view in Windows Admin Center"](media/understand-storage-resync/server.png)