---
title: Changing the Quota That Is Allocated to the SYSVOL Staging Area
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 1c60034e-95d8-4f04-adb1-b34c50fda078
author: Femila
---
# Changing the Quota That Is Allocated to the SYSVOL Staging Area
  The staging folder in SYSVOL, a subfolder of the staging areas folder, stores updates before they are replicated. It also stores updates that it has just received through replication before it updates the copy of the files in SYSVOL. DFS Replication compresses the data to save space in the staging folder and to reduce the time that is necessary to replicate the files.  
  
 The default quota that is allocated to the staging folder is 4096 megabytes \(MB\), or 4 gigabytes \(GB\). The minimum quota is 10 MB and the maximum quota that can be allocated is 4096 GB, or 4 terabytes \(TB\). If you need more space in the staging folder and space is available on the volume, you can adjust the staging folder quota by using DFS Management.  
  
 **Task requirements**  
  
 The following tool is required to perform the procedures for this task:  
  
-   DFS Management  
  
 To complete this task, perform the following procedure:  
  
-   [Change the Quota That Is Allocated to the SYSVOL Staging Folder](../Topic/Change-the-Quota-That-Is-Allocated-to-the-SYSVOL-Staging-Folder.md)  
  
  