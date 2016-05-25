---
title: Delete DNS Resource Records
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 366e6fd5-d563-4de3-9551-5614cbb8f2cb
author: vhorne
---
# Delete DNS Resource Records
You can use this topic to delete one or more DNS resource records by using the IPAM client console.  
  
Membership in **Administrators**, or equivalent, is the minimum required to perform this procedure.  
  
### To delete DNS resource records  
  
1.  In Server Manager, click  **IPAM**. The IPAM client console appears.  
  
2.  In the navigation pane, in **MONITOR AND MANAGE**, click **DNS Zones**.  The navigation pane divides into an upper navigation pane and a lower navigation pane.  
  
3.  Click to expand **Forward Lookup** and the domain where the zone and resource records that you want to delete are located. Click on the zone, and in the display pane, click **Current view**. Click **Resource Records**.  
  
4.  In the display pane, locate and select the resource records that you want to delete.  
  
    ![](media/ipam_DeleteRR_01.jpg)  
  
5.  Right\-click the selected records, and then click **Delete DNS resource record**.  
  
    ![](media/ipam_DeleteRR_02.jpg)  
  
6.  The **Delete DNS Resource Record** dialog box opens. Verify that the correct DNS server is selected. If it is not, click **DNS server** and select the server from which you want to delete the resource records. Click **OK**. IPAM deletes the resource records from the DNS server.  
  
    ![](media/ipam_DeleteRR_03.jpg)  
  
## See Also  
[DNS Resource Record Management](DNS-Resource-Record-Management.md)  
[Manage IPAM](Manage-IPAM.md)  
  

