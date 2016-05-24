---
title: Delete a checkpoint
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 128d87e7-3a6f-4058-968d-ec33df32255a
author: cwatsonmsft
---
# Delete a checkpoint
For an overview of what happens when you delete a checkpoint, see the [Deleting a checkpoint](assetId:///b2f6bba9-f7b9-4fde-b046-7401cbdee93a#BKMK_delete) diagram in the [Checkpoints and Snapshots Overview](assetId:///b2f6bba9-f7b9-4fde-b046-7401cbdee93a).  
  
Checkpoints are stored as .avhdx files in the same location as the .vhdx for the virtual machine, but you should not delete the .avhdx files directly. You can use Windows Powershell to delete a checkpoint using the [Remove\-VMSnapshot](http://technet.microsoft.com/library/hh848601.aspx) cmdlet. To cleanly delete a checkpoint using Hyper\-V manager, follow these instructions:  
  
1.  In **Hyper\-V Manager**, select the virtual machine.  
  
2.  In the **Checkpoints** section, right click the checkpoint that you want to delete and click **Delete**. You can also a checkpoint and all subsequent checkpoints by right clicking the earliest checkpoint that you want to delete and then clicking **Delete Checkpoint Subtree**.  
  
3.  You might be asked to verify that you want to delete the checkpoint. Confirm that it is the correct checkpoint and then click **Delete**.  
  
4.  The .avhdx and the .vhdx will merge and when complete, the .avhdx will be deleted from the file system.  
  
## See also  
  
-   Checkpoints and Snapshots Overview: [Deleting a checkpoint](assetId:///b2f6bba9-f7b9-4fde-b046-7401cbdee93a#BKMK_delete)  
  
-   [Ben Armstrong's Virtualization Blog: What happens when I delete a snapshot?](http://blogs.msdn.com/b/virtual_pc_guy/archive/2009/04/15/what-happens-when-i-delete-a-snapshot-hyper-v.aspx)  
  
