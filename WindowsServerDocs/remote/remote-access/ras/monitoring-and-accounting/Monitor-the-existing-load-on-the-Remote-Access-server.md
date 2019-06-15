---
title: Monitor the existing load on the Remote Access server
description: This topic is part of the guide for Remote Access Monitoring and Accounting in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 62fa2895-62ae-42cf-817c-53e06ac2a26c
ms.author: pashort
author: shortpatti
---
# Monitor the existing load on the Remote Access server

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

**Note:** Windows Server 2012 combines DirectAccess and Routing and Remote Access Service (RRAS) into a single Remote Access role.  
  
The term **Load** refers to the statistics that relate to the number of connections on the Remote Access server. Following are the steps required to track the load on the Remote Access server.  
  
You can use the monitoring dashboard that is available in the management console on the Remote Access server to view the load statistics for the server, or you can use Performance Monitor counters to track the statistics.  
  
> [!NOTE]  
> You must be signed in as a member of the Domain Admins group or a member of the Administrators group on each computer to complete the tasks described in this topic. If you cannot complete a task while you are signed in with an account that is a member of the Administrators group, try performing the task while you are signed in with an account that is a member of the Domain Admins group.  
  
#### To use the monitoring dashboard to monitor the Remote Access server load  
  
1.  In **Server Manager**, click **Tools**, and then click **Remote Access Management**.  
  
2.  Click **DASHBOARD** to navigate to **Remote Access Dashboard** in the **Remote Access Management Console**.  
  
3.  On the monitoring dashboard, notice the **Remote Client Status** tile within the **Server Status** tile. This tile lists statistics such as the total number of remote clients that are connected, the total number of DirectAccess clients that are connected, and the maximum number of users who connected in last 24 hours.  
  
4.  You can click **Refresh** under **Tasks** in the right pane to reload the health status. To change the default refresh interval, click **Configure Refresh Interval** under **Tasks**.  
  
#### To use the Performance Monitor tool to monitor performance counters on the Remote Access server  
  
1.  Click **Start**, click **Administrative Tools**, and then double-click **Performance Monitor**.  
  
2.  Under **Performance**, click **Performance Monitor**.  
  
3.  Click the **Add** button (denoted by a green cross icon) in the **Performance Monitor** toolbar.  
  
4.  From the list of **Available Counters**, select all the counters in the **RAS** and **RAmgmtsvc** categories, and then click **Add>>**.  
  
5.  Again, from the list of **Available Counters**, select all the counters in the **IPsec Connections** category, and then click **Add>>.**  
  
6.  Click **OK** to add the selected counters in the **Performance Monitor** console for tracking.  
  
**Performance Monitor** will now graphically show the selected server load statistics.  
  
![Windows PowerShell](../../../media/Monitor-the-existing-load-on-the-Remote-Access-server/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
PS> Get-RemoteAccessConnectionStatisticsSummary  
```  
  


