---
title: Identify and resolve Remote Access server operations problems
description: This topic is part of the guide for Remote Access Monitoring and Accounting in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7ce84c9f-fd1f-4463-8fc7-d2f33344a2c9
ms.author: pashort
author: shortpatti
---
# Identify and resolve Remote Access server operations problems

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

**Note:** Windows Server 2012 combines DirectAccess and Routing and Remote Access Service (RRAS) into a single Remote Access role.  
  
You can using the following procedures to identify Remote Access server operations issues, their root causes, and the resolution required to fix the issues.  
  
> [!NOTE]  
> You must be signed in as a member of the Domain Admins group or a member of the Administrators group on each computer to complete the tasks described in this topic. If you cannot complete a task while you are signed in with an account that is a member of the Administrators group, try performing the task while you are signed in with an account that is a member of the Domain Admins group.  
  
This topic includes information about performing the following tasks:  
  
- Simulate an operations issue  
  
- Identify the operations issue and take corrective action  
  
- Restore the IP Helper service  
  
### <a name="BKMK_Simulate"></a>Simulate an operations issue  
  
> [!CAUTION]  
> Because your Remote Access server is probably configured properly and not experiencing any issues, you can use the following procedure to simulate an operations issue. If your server is currently servicing clients in a production environment, you may not want to take these actions at this time. Rather, you can read through the steps to understand how to address issues that might arise on your Remote Access server in the future.  
  
The IP Helper service (IPHlpSvc)  hosts IPv6 transitioning technologies (such as IP-HTTPS, 6to4, or Teredo), and it is required for the DirectAccess server to function properly. To demonstrate a simulated operations issue on the Remote Access server, you must stop the (IPHlpSvc) network service.  
  
##### To stop the IP Helper service  
  
1.  On the **Start** screen of the Remote Access server, click **Administrative Tools**, and then double-click **Services**.  
  
2.  In the list of **Services**, scroll down and right-click **IP Helper**, and then click **Stop**.  
  
### <a name="BKMK_Identify"></a>Identify the operations issue and take corrective action  
Turning off the IP Helper service will cause a serious error on the Remote Access server. The monitoring dashboard will show the operations status of the server and the details of the issue.  
  
##### To identify the details and take corrective action  
  
1.  In **Server Manager**, click **Tools**, and then click **Remote Access Management**.  
  
2.  Click **DASHBOARD** to navigate to **Remote Access Dashboard** in the **Remote Access Management Console**.  
  
3.  Make sure your Remote Access server is selected in the left pane, and then in the middle pane, click **Operations Status**.  
  
4.  You will see the list of components with green or red icons, which indicate their operational status. Click the **IP-HTTPS** row in the list. When you selected a row, the details for the operation are shown in the **Details** pane as follows:  
  
    **Error**  
  
    The IP Helper service (IPHlpSvc) has stopped. DirectAccess might not function as expected. The IP Helper service provides tunnel connectivity by using the connectivity platform, IPv6 transition technologies, and IP-HTTPS.  
  
    **Causes**  
  
    1.  The IP Helper service has stopped.  
  
    2.  The IP Helper service is not responding.  
  
    **Resolution**  
  
    1.  To ensure that the service is running, type **Get-Service iphlpsc** at a Windows PowerShell prompt.  
  
    2.  To enable the service, type **Start-Service iphlpsvc** from an elevated Windows PowerShell prompt.  
  
    3.  To restart the service, type **Restart-Service iphlpsvc** from an elevated Windows PowerShell prompt.  
  
### <a name="BKMK_Restart"></a>Restore the IP Helper service  
To restore the IP Helper service on your Remote Access server, you can follow the Resolution steps above to start or restart the service, or you can use the following procedure to reverse the procedure that you used to simulate the IP Helper service failure.  
  
##### To restart the IP Helper service on the Remote Access server  
  
1.  On the **Start** screen, click **Administrative Tools**, and then double-click **Services**.  
  
2.  In the list of **Services**, scroll down and right-click **IP Helper**, and then click **Start**.  
  
![Windows PowerShell](../../../media/Identify-and-resolve-Remote-Access-server-operations-problems/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
PS> Get-RemoteAccessHealth | Where-Object {$_.Component -eq "IP-HTTPS"} | Format-List -Property *  
```  
  


