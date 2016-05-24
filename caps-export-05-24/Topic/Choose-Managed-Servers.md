---
title: Choose Managed Servers
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c8804e7e-0405-404c-980b-00f4bee4fd0c
---
# Choose Managed Servers
[Checklist: Deploy IPAM Server](../Topic/Checklist--Deploy-IPAM-Server.md) > [Install IPAM Server](../Topic/Install-IPAM-Server.md) > [Choose an IPAM Provisioning Method](../Topic/Choose-an-IPAM-Provisioning-Method.md) > [Configure Server Discovery](../Topic/Configure-Server-Discovery.md) > [Discover Servers on the Network](../Topic/Discover-Servers-on-the-Network.md) | [Manually Add a Server to Server Inventory](../Topic/Manually-Add-a-Server-to-Server-Inventory.md) > [Create IPAM Provisioning GPOs](../Topic/Create-IPAM-Provisioning-GPOs.md) | [Manually Configure DHCP Access Settings](../Topic/Manually-Configure-DHCP-Access-Settings.md) | [Manually Configure DNS Access Settings](../Topic/Manually-Configure-DNS-Access-Settings.md) | [Manually Configure DC and NPS Access Settings](../Topic/Manually-Configure-DC-and-NPS-Access-Settings.md) > **Choose Managed Servers**  
  
After you have discovered servers on the network and configured IPAM access settings, you can choose managed servers. Choosing a managed server is done by assign manageability status. If the automatic, GPO\-based provisioning method is used, a manageability status of **Managed** means that the server will automatically be added to security filtering in the appropriate IPAM GPO. If the manual provisioning method is chosen, the manageability status of servers must still be selected to enable IPAM data collection and management functions.  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Choosing managed servers  
The **SERVER INVENTORY** view is used to choose managed servers and to specify managed role services. All discovered servers are displayed in this view, together with the current manageability status and IPAM access status. By default, manageability status of servers is **Unspecified**. For more information about manageability settings and IPAM access status, see [Getting Started with IPAM](../Topic/Getting-Started-with-IPAM.md).  
  
## <a name="discover"></a>  
#### To choose managed servers  
  
1.  In the upper IPAM navigation tree, click **SERVER INVENTORY**. The list of servers that have been discovered or manually added is displayed.  
  
2.  Select one or more servers by clicking the appropriate row in the list. To select multiple servers, hold down SHIFT or CTRL when clicking.  
  
3.  Right\-click the server or servers that are selected and then click **Edit Server**.  
  
4.  In the **Add or Edit Server** dialog box next to **Manageability status**, select **Managed** from the drop\-down list if the server will be managed by the current IPAM server. Select **Unmanaged** if the server will not be managed by the current IPAM server, and then click **OK**.  
  
#### To choose managed services  
  
1.  From the **SERVER INVENTORY** view, right\-click a single server in the list and then click **Edit Server**.  
  
2.  In the **Add or Edit Server** dialog box next to **Server type**, select one or more checkboxes next to the role services that will be managed by the current IPAM server, and then click **OK**.  
  
## See Also  
[Verify Managed Server Access](../Topic/Verify-Managed-Server-Access.md)  
[Retrieve Data from Managed Servers](../Topic/Retrieve-Data-from-Managed-Servers.md)  
  
