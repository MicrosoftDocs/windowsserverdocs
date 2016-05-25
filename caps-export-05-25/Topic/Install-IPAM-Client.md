---
title: Install IPAM Client
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7f0de891-deb8-40ec-8420-57c3f3207253
---
# Install IPAM Client
[Checklist: Deploy IPAM Client](../Topic/Checklist--Deploy-IPAM-Client.md) > [Install RSAT](../Topic/Install-RSAT.md) > **Install IPAM Client**  
  
IPAM Client is installed by default on the local computer when you install IPAM Server. IPAM Client is also available by default on a computer running [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)] when you install the Remote Server Administration Tools \(RSAT\) for Windows 8. If you are using a remote computer running [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] to connect to an IPAM server, use the following procedure to install IPAM Client.  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## The server pool and IPAM Client  
If the local computer is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the local server is available in the server pool by default. If the local computer is running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], you must add at least one server to the pool that supports remote management.  
  
If the IPAM Server computer is already available in the Server Manager server pool, you can skip the procedure below to add a server to the pool, and proceed directly to install IPAM Client. If the IPAM server is not currently available in the server pool, you can use the following basic procedure to add a server to the pool. For detailed information about adding servers to Server Manager, see [Add Servers to Server Manager](http://technet.microsoft.com/library/hh831453.aspx) \(http:\/\/technet.microsoft.com\/library\/hh831453.aspx\).  
  
## <a name="add_server"></a>  
#### To add a server to the server pool  
  
1.  On the Server Manager menu, click **Manage** and then click **Add Servers**.  
  
2.  In **Add Servers**, on the **Active Directory** tab, next to **Location** choose the domain of the destination server, next to **Operating System** choose **All**, type the name of the server next to **Name \(CN\)**, and then click **Find Now**.  
  
3.  Click the name of the server under **Name**, click the add icon, verify the server name is displayed under **Selected**, and then click **OK**.  
  
    ![](../Image/IPAM_add-server.gif)  
  
## <a name="install_client"></a>  
#### To install IPAM Client  
  
1.  In the Server Manager welcome tile, click **Add roles and features**.  
  
2.  In the Add Roles and Features Wizard, click **Next**, choose **Role\-based or feature\-based installation**, and then click **Next**.  
  
3.  On the **Select destination server** page, choose the server you will use to run IPAM Client and then click **Next** twice \(skip the select roles page\).  
  
4.  On the **Select features** page, select the checkbox next to **Remote Server Administration Tools\\Feature Administration Tools\\IP Address Management \(IPAM\) Client**.  
  
5.  If a popup dialog box is displayed requesting additional features to be installed, click **Add Features**.  
  
6.  Click **Next**, and then click **Install**.  
  
> [!TIP]  
> To view the IPAM Client console, there must be at least one computer running IPAM Server available in the Server Manager server pool.  
  
## See also  
[Install IPAM Server](../Topic/Install-IPAM-Server.md)  
  
