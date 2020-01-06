---
title: Choose between standard or production checkpoints in Hyper-V
description: "Gives instructions for configuring a virtual machine to use standard or production checkpoints"
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 92bb573b-03b7-470e-b72e-e35edf52b349
author: KBDAzure
ms.author: kathydav
ms.date: 10/04/2016
---
# Choose between standard or production checkpoints in Hyper-V

>Applies To: Windows 10, Windows Server 2016, Microsoft Hyper-V Server 2016, Windows Server 2019, Microsoft Hyper-V Server 2019

  
Starting with Windows Server 2016 and Windows 10, you can choose between standard and production checkpoints for each virtual machine. Production checkpoints are the default for new virtual machines.
  
- Production checkpoints are "point in time" images of a virtual machine, which can be restored later on in a way that is completely supported for all production workloads. This is achieved by using backup technology inside the guest to create the checkpoint, instead of using saved state technology.  
  
- Standard checkpoints capture the state, data, and hardware configuration of a running virtual machine and are intended for use in development and test scenarios. Standard checkpoints can be useful if you need to recreate a specific state or condition of a running virtual machine so that you can troubleshoot a problem.  
 
  ## Change checkpoints to production or standard checkpoints  
  
1.  In **Hyper-V Manager**, right-click the virtual machine and click **Settings**.  
  
2.  Under the **Management** section, select **Checkpoints**.  
  
3.  Select either production checkpoints or standard checkpoints.  
  
    If you choose production checkpoints, you can also specify whether the host should take a standard checkpoint if a production checkpoint can't be taken. If you clear this checkbox and a production checkpoint can't be taken, then no checkpoint is taken.  
  
4.  If you want to store the checkpoint configuration files in a different place, change it in the **Checkpoint File Location** section.  
  
5.  Click **Apply** to save your changes. If you're done, click **OK** to close the dialog box.  
  
> [!NOTE]
> Only **Production Checkpoints** are supported on guests that run Active Directory Domain Services role (Domain Controller) or Active Directory Lightweight Directory Services role.

## See also  
  
-   [Production checkpoints](../What-s-new-in-Hyper-V-on-Windows.md#production-checkpoints-new)  
  
-   [Enable or disable checkpoints](Enable-or-disable-checkpoints-in-Hyper-V.md)  
  


