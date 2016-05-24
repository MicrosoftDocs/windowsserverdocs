---
title: Apply a checkpoint to revert to a previous point in time
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c8f7beed-30f7-4c70-871c-6b8c453f9091
author: cwatsonmsft
---
# Apply a checkpoint to revert to a previous point in time
If you want to revert your virtual machine to a previous point in time, you can apply an existing checkpoint.  
  
Powershell http:\/\/technet.microsoft.com\/en\-us\/library\/hh848480.aspx  
  
1.  Select the virtual machine.  
  
2.  In the **Checkpoints** section, right\-click the checkpoint that you want to use and click **Apply**.  
  
3.  You will get a dialog with the following options:  
  
    -   **Create Checkpoint and Apply** – creates a new checkpoint of the machine before applying the earlier checkpoint.  
  
    -   **Apply** – only applies that checkpoint that you have chosen. You cannot undo this action.  
  
    -   **Cancel** – closes the pop\-up without doing anything.  
  
## See also  
[Working with Checkpoints](assetId:///b2a678b7-515b-4809-9f58-8ecba8b0b122)  
  
