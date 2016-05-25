---
title: IP Address Tracking
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 73f377be-019f-40f9-aa69-428870e09121
---
# IP Address Tracking
IPAM enables IP address tracking through correlation of DHCP lease events on managed DHCP servers with user and computer authentication events on managed domain controllers and NPS servers.  
  
IPAM supports searching IP address records using four parameters:  
  
-   [IP address](../Topic/IP-Address-Tracking.md#ip)  
  
-   [Client ID](../Topic/IP-Address-Tracking.md#id)  
  
-   [Host name](../Topic/IP-Address-Tracking.md#host)  
  
-   [User name](../Topic/IP-Address-Tracking.md#user)  
  
Searches using wildcards or regular expressions are not supported. Future dates are allowed when entering a date range to search. You can also choose to include or exclude user and computer logon events, and additional correlated events. If you exclude logon and correlated events, only DHCP lease data is searched. Search results can be exported to a text file in comma\-separated\-value \(.csv\) format. You can also save and reuse queries.  
  
To search the most recent lease and logon events, run IPAM data collection tasks on managed servers before performing a search of event data.  
  
## <a name="ip"></a>Tracking by IP address  
To search by IP address, click **By IP Address** and enter a complete IPv4 address and valid date range. IPv6 address tracking is not supported.  
  
#### To track by IP address  
  
1.  Click **EVENT CATALOG** in the upper navigation pane.  
  
2.  Under **IP Address tracking** in the lower navigation pane, click **By IP Address**.  
  
3.  Type an IPv4 address next to **Search**.  
  
4.  Type a start and end date next to **and DHCP lease events between these dates**.  
  
5.  Click **include** or **exclude** to view or not to view events, respectively, from domain controllers and NPS servers.  
  
6.  Click **Search**.  
  
For example, a search by IP address might reveal that a DHCP client received a DHCP lease from two different DHCP servers during a defined time frame, perhaps due to a DHCP failover relationship between the two DHCP servers. This could be verified by reviewing the **Server Availability** and **Duration in Current State** fields in the **DNS and DHCP Servers** node under **MONITOR AND MANAGE**.  
  
![](../Image/IPAM_failover.gif)  
  
## <a name="id"></a>Tracking by client ID  
To search by client ID \(MAC address\), click **By Client ID** and enter a client ID \(MAC address\) and valid date range. Dashes are allowed in the client ID, but are not required.  
  
#### To track by client ID  
  
1.  Click **EVENT CATALOG** in the upper navigation pane.  
  
2.  Under **IP Address tracking** in the lower navigation pane, click **By Client ID**.  
  
3.  Type a client ID next to **Search**.  
  
4.  Type a start and end date next to **and DHCP lease events between these dates**.  
  
5.  Click **include** or **exclude** to view or not to view events, respectively, from domain controllers and NPS servers.  
  
6.  Click **Search**.  
  
For example, a search by client ID can reveal different IP addresses that have been assigned to a specific device on the network during a defined time frame.  
  
![](../Image/IPAM_client-id.gif)  
  
## <a name="host"></a>Tracking by host name  
To search by host name, click **By Host Name** and enter a host name and valid date range. Case is ignored for host names.  
  
#### To track by host name  
  
1.  Click **EVENT CATALOG** in the upper navigation pane.  
  
2.  Under **IP Address tracking** in the lower navigation pane, click **By Host Name**.  
  
3.  Type a host name next to **Search**.  
  
4.  Type a start and end date next to **and DHCP lease events between these dates**.  
  
5.  Click **include** or **exclude** to view or not to view events, respectively, from domain controllers and NPS servers.  
  
6.  Click **Search**.  
  
For example, a search by host name can reveal the users that have signed into a specific device on the network during a defined time frame. To more easily view user data, sort by the **User Name** field.  
  
![](../Image/IPAM_host.gif)  
  
## <a name="user"></a>Tracking by user name  
To search by user name, click **By User Name** and enter a host name and valid date range. Case is ignored for user names. Since user names are not included in DHCP lease events, you must include logon events in the search.  
  
#### To track by user name  
  
1.  Click **EVENT CATALOG** in the upper navigation pane.  
  
2.  Under **IP Address tracking** in the lower navigation pane, click **By User Name**.  
  
3.  Type a host name next to **Search**.  
  
4.  Type a start and end date next to **and DHCP lease events between these dates**.  
  
5.  Click **Search**.  
  
For example, a search by user name can reveal when the domain Administrator account was used on the network.  
  
## See also  
[Operational Event Tracking](../Topic/Operational-Event-Tracking.md)  
  
[IPAM Audit Logic](http://social.technet.microsoft.com/wiki/contents/articles/15298.ipam-audit-logic.aspx)  
  
