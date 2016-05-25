---
title: Monitor the operations status of the Remote Access server and its components_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dc05c74f-aa37-463c-af6d-18d71ef63ed7
author: vhorne
---
# Monitor the operations status of the Remote Access server and its components_1
[!INCLUDE[remote_access_combo](../Token/remote_access_combo_md.md)]  
  
The management console in the Remote Access server can be used to monitor its operations status.  
  
> [!NOTE]  
> You must be signed in as a member of the Domain Admins group or a member of the Administrators group on each computer to complete the task described in this topic. If you cannot complete a task while you are signed in with an account that is a member of the Administrators group, try performing the task while you are signed in with an account that is a member of the Domain Admins group.  
  
#### To monitor the Remote Access server operations status  
  
1.  In **Server Manager**, click **Tools**, and then click **Remote Access Management**.  
  
2.  Click **DASHBOARD** to navigate to **Remote Access Reporting** in the **Remote Access Management Console**.  
  
3.  On the monitoring dashboard, notice the **Operations Status** tile within the **Server Status** tile. This tile lists the server operations status and the status of all the server’s components.  
  
4.  Click **Refresh** under **Tasks** in the right pane to reload the operations status. The operations status is automatically refreshed every five minutes, which is the default refresh interval. To change the default refresh interval, click **Configure Refresh Interval**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
> [!NOTE]  
> The command for operations status of a cluster is included for reference.  
  
```  
PS> Get-RemoteAccessHealth  
PS> Get-RemoteAccessHealth –Cluster  
  
```  
  
