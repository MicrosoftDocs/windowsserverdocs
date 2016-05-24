---
title: Step 1: Preseed Files for DFS Replication
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 22c2f0c7-75f0-4e4c-811f-1f4c87b05f0c
---
# Step 1: Preseed Files for DFS Replication
The topics in this section provide detailed walkthroughs of three methods for preseeding files on the destination server before you set up Distributed File System \(DFS\) Replication \(also known as DFSR or DFS\-R\), add a new replication partner, or replace a server. By preseeding files, you can speed up initial synchronization for DFS Replication significantly and enable cloning of the DFS Replication database in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
Step\-by\-step procedures are provided for the following methods:  
  
-   [Use Robocopy to Preseed Files for DFS Replication](assetId:///3222139a-4f85-4111-9e74-52befb6fedbc)  
  
-   [Use Windows Server Backup to Preseed Files for DFS Replication](../Topic/Use-Windows-Server-Backup-to-Preseed-Files-for-DFS-Replication.md)  
  
-   [Use Windows NTBackup to Preseed Files for DFS Replication](../Topic/Use-Windows-NTBackup-to-Preseed-Files-for-DFS-Replication.md)  
  
The best method to use depends on your environment, the operating systems on your source and destination computers, and the data set that you plan to replicate. For a comparison of these and other tools and an overview of the preseeding process, see [DFS Replication: Copying Files to Preseed or Stage Initial Synchronization](../Topic/DFS-Replication--Copying-Files-to-Preseed-or-Stage-Initial-Synchronization.md).  
  
> [!IMPORTANT]  
> To maximize the chances of preseeding successfully, we recommend that you test the procedures in your lab before you attempt production changes. Testing can also demonstrate which method of preseeding is best for your environment and data set.  
  
