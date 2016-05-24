---
title: Discover Servers on the Network
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4a3a6466-8095-4466-bd72-38cb2224eabf
---
# Discover Servers on the Network
[Checklist: Deploy IPAM Server](../Topic/Checklist--Deploy-IPAM-Server.md) > [Install IPAM Server](../Topic/Install-IPAM-Server.md) > [Choose an IPAM Provisioning Method](../Topic/Choose-an-IPAM-Provisioning-Method.md) > [Configure Server Discovery](../Topic/Configure-Server-Discovery.md) > **Discover Servers on the Network**  
  
After you have configured the scope of discovery, you can begin discovering servers on the network. When a server is discovered on the network, it is added to the IPAM database and displayed in the server inventory view of the IPAM client console.  
  
If this is the first time you are discovering servers, or a new server has recently been added to the network, you can discover servers by running the server discovery task. This task also runs regularly on the IPAM server with a default frequency of once per day, and will discover new servers automatically provided that they meet the conditions for discovery. Conditions for discovery depend on the type of role services that are installed and running on managed servers. For example, a DHCP server will not be discovered if it is not authorized in Active Directory or does not have any DHCP scopes configured. DHCP scopes do not need to be active to be discovered. A DNS server will not be discovered unless it is authoritative for an Active Directory domain configured in the scope of discovery. For more information about conditions for discovering servers on the network, see [Getting Started with IPAM](../Topic/Getting-Started-with-IPAM.md). For more information about the server discovery task and other IPAM data collection tasks, see [IPAM Architecture](../Topic/IPAM-Architecture.md).  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Discovering servers on the network  
Domain controllers, DHCP servers, and DNS servers can be discovered on the network, provided they are running [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)] or a later operating system. Computers running NPS must be added manually to the server inventory. To manually add a server to the server inventory, perform the steps in [Manually Add a Server to Server Inventory](../Topic/Manually-Add-a-Server-to-Server-Inventory.md).  
  
## <a name="discover"></a>  
#### To discover servers on the network  
  
1.  On the IPAM Overview page, click **Start server discovery**. This will start the IPAM **ServerDiscovery** task. Alternatively, you can click **Manage** on the IPAM console menu, and then click **Start Server Discovery**.  
  
2.  Wait for the task to complete. You can click the notification flag to view status of the **ServerDiscovery** task if desired.  
  
3.  When the task has completed running, view the **Server inventory** page to display the list of discovered servers.  
  
4.  If the list of discovered servers is incomplete, verify that the correct node is selected in the lower navigation pane. By default, IPv4 is selected. You can click **Refresh** to ensure the view is current.  
  
## See Also  
[Manually Add a Server to Server Inventory](../Topic/Manually-Add-a-Server-to-Server-Inventory.md)  
  
