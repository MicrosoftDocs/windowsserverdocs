---
title: Health monitoring in WSUS 3.0 SP2
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7f2a52af-1738-4320-9066-e58fa904fc70
author: britw
---
# Health monitoring in WSUS 3.0 SP2
WSUS monitors the health of the WSUS server and its components by using a service that runs at frequent intervals and logs the results as events in the event log. You can look at the events with the Event Viewer. You can get more information by downloading the WSUS 3.0 MOM Pack.  
  
## Health checks  
The WSUS health monitoring service automatically checks the health of WSUS components as long as WSUS server components are installed on the computer. The service does not run on computers where only the WSUS administration console or WSUS database is installed. The health check service has two cycles: *detect* and *refresh*.  
  
During the detect cycle, only detected changes are logged \(for example, a service was running but stopped\). During the refresh cycle, all errors and warnings are logged in addition to a log showing that WSUS is working properly. By default, the detect cycle polls WSUS components every ten minutes and the refresh cycle polls WSUS components every six hours. You can run the health check at other times \(for example, to verify a configuration change to WSUS or to configure the service to run more or less often\) by using the **wsusutil** tool. For more information about the **wsusutil** tool, see [Manage WSUS 3.0 SP2 from the Command Line](../Topic/Manage-WSUS-3.0-SP2-from-the-Command-Line.md).  
  
### Polling WSUS components  
During the health check, the following WSUS components are checked:  
  
-   **Core**: Disk space, permissions, email notifications, and catalog and content synchronization  
  
-   **Database**: Connectivity and availability  
  
-   **Web Services**: Permissions and web service health  
  
-   **Clients**: Client computers reporting or not reporting, client computer self\-updates, the update agent, client computer inventory, and the client computer’s ability to install updates  
  
### <a name="eventlogs"></a>Viewing event logs  
The health monitoring service logs error, warning, and informational events in the Application event log.  
  
-   Errors should be fixed immediately \(for example, available local storage space has dropped below a certain level\)  
  
-   Warnings are notifications of situations that can become problems \(for example, the WSUS service has stopped or synchronization has not occurred during the last 24 hours\)  
  
-   Informational events are notifications of situations that are interesting, but probably not problems \(for example, a service has stopped or started\)  
  
##### To view WSUS events  
  
1.  Start the Event Viewer \(click **Start**, click **Run**, and then type **eventvwr**\).  
  
2.  In the left pane, click **Application**.  
  
3.  Find the events with a source of Windows Server Update Services.  
  
