---
title: Choose an IPAM Provisioning Method
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3381b37a-6d5f-4a41-ab11-b9ebd2dda7d4
---
# Choose an IPAM Provisioning Method
[Checklist: Deploy IPAM Server](../Topic/Checklist--Deploy-IPAM-Server.md) > [Install IPAM Server](../Topic/Install-IPAM-Server.md) > **Choose an IPAM Provisioning Method**  
  
Provisioning is the process of enabling required permissions, files shares, and access settings on managed servers so that the IPAM server can communicate with them. You can choose either the manual or Group Policy Based method.  
  
Both the manual provisioning method and the Group Policy based method require that the same settings be applied to managed servers. However, the Group Policy Based method is preferred due to its ease of use and consistency. When you choose the Group Policy based method, no settings are applied to managed servers unless you specifically assign a status of “managed” to the server.  Settings are also removed more easily when you use the Group Policy based method. For more information, see [Getting Started with IPAM](../Topic/Getting-Started-with-IPAM.md).  
  
> [!IMPORTANT]  
> The choice of a provisioning method is permanent for the current installation of IPAM Server. To change the provisioning method, you must uninstall and reinstall IPAM Server.  
>   
> This procedure assumes that you have already connected to the IPAM server that you will provision using the IPAM client console. To connect to a different IPAM server, click **Connect to IPAM server** on the IPAM Overview page.  
  
If you have installed IPAM Server without IPAM Client, you must perform the procedures in [Checklist: Deploy IPAM Client](../Topic/Checklist--Deploy-IPAM-Client.md) before you can connect to the IPAM server and choose a provisioning method. IPAM Client is installed by default when you install IPAM Server, but these features can be installed on separate computers.  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Choosing a provisioning method  
Use the following procedure to choose an IPAM provisioning method.  
  
#### To choose an IPAM provisioning method  
  
1.  On the IPAM Overview page, click **Provision the IPAM server**. The **Provision IPAM** wizard will open.  
  
2.  Click **Next** and then on the **Select provisioning method** page, choose either the **Manual** or **Group Policy Based** radio button.  
  
    > [!IMPORTANT]  
    > If the IPAM server is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or later, the Provision IPAM wizard will display an additional page where you can specify the location and type of IPAM database. If you will use Microsoft SQL Server with IPAM, see [Configure the SQL Database for IPAM](../Topic/Configure-the-SQL-Database-for-IPAM.md) and [Specify the IPAM Database](../Topic/Specify-the-IPAM-Database.md). If you will use Windows Internal Database \(WID\) with IPAM, see [Specify the IPAM Database](../Topic/Specify-the-IPAM-Database.md) for more information, or just select **WID** and click **Next**.  
  
3.  If the Group Policy Based method was chosen, type a GPO prefix next to **GPO name prefix**. The GPO prefix that you provide should allow you to identify GPOs that are created in the domain to be applicable to the current IPAM server. Write down the GPO prefix that you choose to reference later when creating IPAM provisioning GPOs. If the manual provisioning method is chosen, proceed to the next step.  
  
    ![](../Image/IPAM_prov_wiz.png)  
  
4.  Click **Next**, and then on the Summary page review the settings that will be applied below **Confirm the Settings**. If the Group Policy Based method was chosen, the unique GPO names that must be created in domains managed by the current IPAM server are displayed.  
  
5.  Click **Apply**, verify that **IPAM provisioning completed successfully** is displayed, and then click **Close**.  
  
## See Also  
[Configure Server Discovery](../Topic/Configure-Server-Discovery.md)  
  
