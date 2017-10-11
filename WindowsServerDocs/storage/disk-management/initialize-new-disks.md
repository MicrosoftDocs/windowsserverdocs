---
title: Initialize new disks
description: This article describe how to initialize new disks
ms.date: 10/12/2017
ms.prod: windows-server-threshold 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jgerend 
---

# Initialize new disks

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

> [!NOTE]
> You must be a member of the **Backup Operators** or **Administrators** group, at minimum, to complete these steps.

## To initialize new disks
1.  In Disk Management, right-click the disk you want to initialize, and then click **Initialize Disk**.

2.  In the **Initialize Disk** dialog box, select the disk(s) to initialize. You can select whether to use the Master Boot Record (MBR) or GUID Partition Table (GPT) partition style.

## Additional considerations

-   New disks appear as **Not Initialized**. Before you can use a disk, you must first initialize it. If you start Disk Management after adding a disk, the Initialize Disk Wizard appears so that you can initialize the disk.

> [!NOTE]
> The new disk is initialized as a basic disk.

