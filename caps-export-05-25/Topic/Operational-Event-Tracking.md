---
title: Operational Event Tracking
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 67523e2d-8856-4d44-ac6c-a2684059440e
---
# Operational Event Tracking
This topic contains detailed information and procedures you can use to review DHCP server and IPAM server operational events in IPAM. To review best practices for managing the event catalog in IPAM, see [Event catalog](../Topic/Best-Practices.md#event_catalog).  
  
You can use the **EVENT CATALOG** node in the upper navigation pane to monitor configuration events on managed DHCP servers and the IPAM server. Configuration event monitoring is not available for DNS servers.  
  
## DHCP configuration events  
Click **DHCP Configuration Events** in the lower navigation pane to display events from all managed DHCP servers. Events are displayed from the **Operational** event log. These events can also be viewed in Event Viewer on individual DHCP servers by navigating to **Applications and Services Logs>Microsoft>Windows>DHCP\-Server>Microsoft\-Windows\-DHCP Server Events\/Operational**.  
  
Events are retrieved from managed DHCP servers by the IPAM **Audit** task, which runs every 24 hours by default. To retrieve events immediately, click **TASKS** and then click **Retrieve Event Catalog Data**. To search event log data, type a search term next to **Search** and press ENTER. Searching with wildcards or regular expressions is not supported, but you can search for part of a name in the server FQDN.  
  
![](../Image/IPAM_search.gif)  
  
You can also use several different criteria to limit the scope of search results. To add criteria, click the expand icon in the right\-hand corner of the DHCP Configuration Events window and choose from the following criteria:  
  
-   Event ID  
  
-   Server Name  
  
-   Time of the Event  
  
-   User Name  
  
-   User Domain Name  
  
-   Scope Name \(in description\)  
  
-   Scope ID \(in description\)  
  
-   Option Number \(in description\)  
  
-   Option Name \(in description\)  
  
-   Reservation Address \(in description\)  
  
To purge event log data, click **TASKS** and then click **Purge Event Catalog Data**. The Purge Event Catalog Data dialog box allows you to choose the type of events to purge and the age of events to purge.  
  
![](../Image/IPAM_purge-events.gif)  
  
After choosing the data type and time window to use for purging data, click **OK** and then click **Yes** to confirm data deletion. After the IPAM Purge Event Catalog task completes, refresh the console view to only events that were not purged.  
  
> [!TIP]  
> Purging events from the IPAM database does not clear events from Event Viewer on managed DHCP servers. However, subsequent event catalog data retrieval only adds newly generated events in IPAM. Data that was purged is not re\-introduced.  
  
## IPAM configuration events  
Click **IPAM Configuration Events** in the lower navigation pane to display events from the current IPAM server. Events are displayed from the **ConfigurationChange** event log. These events can also be viewed in Event Viewer on the IPAM server by navigating to **Applications and Services Logs>Microsoft>Windows>IPAM>ConfigurationChange**.  
  
You cannot add criteria when searching IPAM configuration events.  
  
Retrieval and purging of event catalog data is the same for IPAM configuration events as for DHCP configuration events.  
  
## See also  
[IP Address Tracking](../Topic/IP-Address-Tracking.md)  
  
