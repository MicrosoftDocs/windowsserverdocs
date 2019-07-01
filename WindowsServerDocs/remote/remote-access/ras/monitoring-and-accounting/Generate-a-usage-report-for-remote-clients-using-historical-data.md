---
title: Generate a usage report for remote clients using historical data
description: This topic is part of the guide for Remote Access Monitoring and Accounting in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0305467b-ce39-4532-a05a-2cc5ff946f55
ms.author: pashort
author: shortpatti
---
# Generate a usage report for remote clients using historical data

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

**Note:** Windows Server 2012 combines DirectAccess and Routing and Remote Access Service (RRAS) into a single Remote Access role.  
  
The management console on the Remote Access server can be used to generate a usage report for the remote clients that are accessing the server. To generate a usage report for remote clients, you first enable accounting on the Remote Access server. After you generate the report, you can use the monitoring dashboard that is available in the management console on the Remote Access server to view the load statistics on the server.  
  
> [!NOTE]  
> You must be signed in as a member of the Domain Admins group or a member of the Administrators group on each computer to complete the tasks described in this topic. If you cannot complete a task while you are signed in with an account that is a member of the Administrators group, try performing the task while you are signed in with an account that is a member of the Domain Admins group.  
  
#### To enable accounting on the Remote Access Server  
  
1.  In **Server Manager**, click **Tools**, and then click **Remote Access Management**.  
  
2.  Click **REPORTING** to navigate to **Remote Access Reporting** in the **Remote Access Management Console**.  
  
3.  Click **Configure Accounting** in the **Remote Access Reporting** task pane.  
  
4.  Select the **Use inbox accounting** check box to enable accounting on the Remote Access server.  
  
5.  Click **Apply** to enable the accounting configuration on the server, and then click **Close** after the server has applied the configuration successfully.  
  
#### To generate the usage report  
  
1.  In **Server Manager**, click **Tools**, and then click **Remote Access Management**.  
  
2.  Click **REPORTING** to navigate to **Remote Access Reporting** in the **Remote Access Management Console**.  
  
3.  In the middle pane, click dates in the calendar to select the report duration **Start date:** and **End date:**, and then click **Generate Report**.  
  
4.  You will see the list of users that have connected to the Remote Access server within the selected time and detailed statistics about them. Click the first row in the list. When you select a row, the remote user activity is shown in the preview pane. Now select the **Server Load Statistics** tab in the preview pane to see the historical load on the server.  
  
    Click the **Server Load Statistics** tab in the preview pane to see the historical load on the server.  
  
> [!NOTE]  
> **Understanding sessions**  
>   
> Remote Access accounting is based on the concept of **sessions**. In contrast to a **connection**, a **session** is uniquely identified by a combination of remote client IP address and user name. For example, if a machine tunnel is formed from the remote client, named Client1, a session will be created and stored in the accounting database. When a user named User1 connects from that client after some time passes (but the machine tunnel is still active), the session is recorded as a separate session. The distinction of sessions is to retain the distinction between machine tunnel and user tunnel.  
  
![Windows PowerShell](../../../media/Generate-a-usage-report-for-remote-clients-using-historical-data/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
In the following script, change the date range for which you want a report in the **-StartDateTime** and **-EndDateTime** parameters.  
  
```  
PS> Get-RemoteAccessConnectionStatisticsSummary -StartDateTime "1 October 2010 00:00:00" -EndDateTime "14 October 2010 00:00:00"  
Shows server load statistics.  
PS> Get-RemoteAccessUserActivity -HostIPAddress 10.0.0.1 -StartDateTime "1 October 2010 00:00:00" -EndDateTime "14 October 2010 00:00:00"  
```  
  


