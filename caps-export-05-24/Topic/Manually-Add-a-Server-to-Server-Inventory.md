---
title: Manually Add a Server to Server Inventory
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6c1ca77e-ca5f-41fa-991b-fa6499189409
---
# Manually Add a Server to Server Inventory
[Checklist: Deploy IPAM Server](../Topic/Checklist--Deploy-IPAM-Server.md) > [Install IPAM Server](../Topic/Install-IPAM-Server.md) > [Choose an IPAM Provisioning Method](../Topic/Choose-an-IPAM-Provisioning-Method.md) > [Configure Server Discovery](../Topic/Configure-Server-Discovery.md) > [Discover Servers on the Network](../Topic/Discover-Servers-on-the-Network.md) | **Manually Add a Server to Server Inventory**  
  
After you have configured the scope of discovery, you can add servers to the server inventory. Domain controllers, DNS servers, and DHCP servers are automatically discovered by IPAM if they are running [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)] or a later operating system. Network Policy Servers \(NPS\) must be manually added to the server inventory.  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Manually adding a server  
When you manually add a managed server to the server inventory, IPAM checks that the server name exists in Active Directory, and that the name or IP address does not already exist in the IPAM database.  
  
## <a name="discover"></a>  
#### To manually add a server  
  
1.  Click **SERVER INVENTORY** in the upper IPAM navigation tree, click **TASKS**, and then click **Add Server**.  
  
2.  In the **Add or Edit Server** dialog box, next to **Server name \(FQDN\)** type the name or IP address of the managed server and then click **Verify**.  
  
    > [!NOTE]  
    > The IP address of the server is automatically added when you click **Verify**, and the name will be resolved to a fully qualified domain name when you close the **Add or Edit Server** dialog box. The DNS server that is configured on the IPAM server’s network interface must be able to resolve the name or IP address that you provide.  
  
3.  Next to **Server type**, select at least one role for the managed server.  
  
4.  Optionally, type information next to **Owner** and **Description**, and provide a custom configuration.  
  
5.  Click **OK** to finish.  
  
## See Also  
[Choose Managed Servers](../Topic/Choose-Managed-Servers.md)  
  
