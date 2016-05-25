---
title: Configure Storage Quality of Service
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 367e56f6-5b9c-447f-8ef8-566a3ab6b588
author: cwatsonmsft
---
# Configure Storage Quality of Service
Hyper\-V enables an administrator to configure your virtual machine hard disks for Storage Quality of Service \(QoS\).  
  
> [!NOTE]  
> Storage QoS cannot be installed as a separate feature. It is only available when a user installs the Hyper\-V role. For more information about storage QoS, see [Storage Quality of Service  for Hyper-V](../Topic/Storage-Quality-of-Service--for-Hyper-V.md).  
  
## To configure a virtual hard disk for Storage Quality of Service  
You can configure the Storage QoS parameters for the bandwidth on the virtual hard disk of your virtual machine using the following procedure.  
  
1.  In **Server Manager**, point to **Tools**, and then click **Tools**.  
  
2.  Point to **Hyper\-V Manager** and then click **Hyper\-V Manager**.  
  
3.  Click **Start**, point to **Administrative Tools**, and then click **Hyper\-V Manager**  
  
4.  In the **Action** pane, click **Settings**.  
  
5.  Double click **SCSI Controller**.  
  
6.  Point to **SCSI Controller** and then click **SCSI Controller**.  
  
7.  Click **Hard Drive**. You will see **Hard Drive** settings displayed in the right pane.  
  
8.  To the left of the Hard Drive icon, click “**\+**”.  
  
9. Click **Advanced Features**.  
  
10. In the **Advanced Features** pane, click **Enable Quality of Service management**.  
  
11. Enter **Maximum** IOPS values. The default value is 0..  
  
12. Enter your **Minimum** IOPS values. The default value is 0.  
  
13. Click **OK**. .  
  
## See Also  
[Storage Quality of Service  for Hyper-V](../Topic/Storage-Quality-of-Service--for-Hyper-V.md)  
  
