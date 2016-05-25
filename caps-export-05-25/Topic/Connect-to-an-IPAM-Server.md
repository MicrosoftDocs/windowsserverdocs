---
title: Connect to an IPAM Server
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2a2fbc0e-278d-400d-8a3b-ef26bb673a03
---
# Connect to an IPAM Server
[Checklist: Deploy IPAM Client](../Topic/Checklist--Deploy-IPAM-Client.md) > [Install RSAT](../Topic/Install-RSAT.md) > [Install IPAM Client](../Topic/Install-IPAM-Client.md) > **Connect to an IPAM Server**  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Connecting to an IPAM server  
An IPAM client computer can connect to any IPAM server that is available in the Server Manager server pool. To view the list of servers in the pool, click **All Servers** on the Server Manager navigation pane.  
  
## <a name="add_server"></a>  
#### To connect to an IPAM server  
  
1.  If the IPAM server is not already available in the Server Manager server pool, click **Manage** on the Server Manager menu, and then click **Add Servers**.  
  
2.  On the **Active Directory** tab, next to **Name \(CN\)**, type the hostname or FQDN of the IPAM server and then click **Find Now**.  
  
3.  Click the desired server in the list and add it to the list of selected computers.  
  
    ![](../Image/IPAM_add-server.gif)  
  
4.  Click **OK** and then wait for IPAM to be displayed in the Server Manager navigation pane.  
  
5.  When the desired IPAM server is available in the Server Manager server pool, click **IPAM**, and then on the **IPAM OVERVEW** page, click **Connect to IPAM server**.  
  
6.  In the Connect to IPAM server dialog box, click the name of the IPAM server and then click **OK**.  
  
7.  Verify that Connected to <IPAM server> is displayed under **Connect to IPAM server**.  
  
    ![](../Image/IPAM_connect.png)  
  
## See Also  
[Install IPAM Server](../Topic/Install-IPAM-Server.md)  
  
