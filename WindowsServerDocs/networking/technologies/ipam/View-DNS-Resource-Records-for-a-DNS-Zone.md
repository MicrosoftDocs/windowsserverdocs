---
title: View DNS Resource Records for a DNS Zone
description: This topic is part of the IP Address Management (IPAM) Management guide in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ipam
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 375feefc-949e-47c3-9e61-35b79e021966
ms.author: pashort
author: shortpatti
---
# View DNS Resource Records for a DNS Zone

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to view DNS resource records for a DNS zone in the IPAM client console.  
  
Membership in **Administrators**, or equivalent, is the minimum required to perform this procedure.  
  
### To view DNS resource records for a zone  
  
1.  In Server Manager, click  **IPAM**. The IPAM client console appears.  
  
2.  In the navigation pane, in **MONITOR AND MANAGE**, click **DNS Zones**.  The navigation pane divides into an upper navigation pane and a lower navigation pane.  
  
3.  In the lower navigation pane, click **Forward Lookup**, and then expand the domain and zone list to locate and select the zone you want to view. For example, if you have a zone named dublin, click **dublin**.  
  
    ![Select the zone you want to view](../../media/View-DNS-Resource-Records-for-a-DNS-Zone/ipam_DNSzones_01a.jpg)  

  
4.  In the display pane, the default view is of the DNS servers for the zone. To change the view, click **Current view**, and then click **Resource Records**.  
  
    ![Change the view to Resource Records](../../media/View-DNS-Resource-Records-for-a-DNS-Zone/ipam_Zone_RR_02.jpg)  
  
5.  The DNS resource records for the zone are displayed. To filter the records, type the text you want to find in **Filter**.  
  
    ![Type text to filter records](../../media/View-DNS-Resource-Records-for-a-DNS-Zone/ipam_DNSzones_01c.jpg)  
  
6.  To filter the resource records by record type, access scope, or other criteria, click **Add criteria**, and then make selections from the criteria list and click **Add**.  
  
    ![Use criteria to filter records](../../media/View-DNS-Resource-Records-for-a-DNS-Zone/ipam_DNSzones_01d.jpg)  
  
## See Also  
[DNS Zone Management](DNS-Zone-Management.md)  
[Manage IPAM](Manage-IPAM.md)  
  


