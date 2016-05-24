---
title: Verify Managed Server Access
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f4f79a8e-17c7-4155-8818-1dd9124f8e69
---
# Verify Managed Server Access
[Checklist: Deploy IPAM Server](../Topic/Checklist--Deploy-IPAM-Server.md) > [Install IPAM Server](../Topic/Install-IPAM-Server.md) > [Choose an IPAM Provisioning Method](../Topic/Choose-an-IPAM-Provisioning-Method.md) > [Configure Server Discovery](../Topic/Configure-Server-Discovery.md) > [Discover Servers on the Network](../Topic/Discover-Servers-on-the-Network.md) | [Manually Add a Server to Server Inventory](../Topic/Manually-Add-a-Server-to-Server-Inventory.md) > [Create IPAM Provisioning GPOs](../Topic/Create-IPAM-Provisioning-GPOs.md) | [Manually Configure DHCP Access Settings](../Topic/Manually-Configure-DHCP-Access-Settings.md) | [Manually Configure DNS Access Settings](../Topic/Manually-Configure-DNS-Access-Settings.md) | [Manually Configure DC and NPS Access Settings](../Topic/Manually-Configure-DC-and-NPS-Access-Settings.md) > [Choose Managed Servers](../Topic/Choose-Managed-Servers.md) > **Verify Managed Server Access**  
  
After you have selected servers that will be managed by IPAM, you can verify IPAM access settings. If the automatic, GPO\-based provisioning method is used, selecting a manageability status of **Managed** will automatically add a managed server to security filtering in the appropriate role\-based IPAM GPOs. If the manual provisioning method is chosen, you can manually apply IPAM provisioning GPOs, or manually configure managed server access settings. In some cases, application of IPAM access settings requires that role services are restarted. For more information about applying and verifying IPAM access settings, see [Getting Started with IPAM](../Topic/Getting-Started-with-IPAM.md).  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Verifying managed server access  
The **SERVER INVENTORY** view is used to display the IPAM access status for managed and unmanaged servers. Servers will display a status of **Blocked**, **Unblocked**, or **Not checked**. Depending on the manageability status that is selected, a recommended action is also displayed. If the recommended action is **Unblock IPAM Access**, review information in the **Details View** to understand what type of access status is currently blocked, verify that the correct access settings are applied, and refresh server access status.  
  
## <a name="discover"></a>  
#### To verify managed server access  
  
1.  In the upper IPAM navigation tree, click **SERVER INVENTORY**. The list of servers that have been discovered or manually added is displayed.  
  
2.  Under **Recommended Action**, verify that **IPAM Access Unblocked** is displayed.  
  
3.  If **Unblock IPAM Access** is displayed, verify that IPAM access settings have been applied and refresh server access status.  
  
4.  Verify IPAM access settings.  
  
    ###### To verify IPAM access settings  
  
    1.  If IPAM access settings are applied using GPOs, update Group Policy and display the Resultant Set of Policy \(RSoP\) information on the target managed server by typing the following commands at an elevated command prompt on the target server, and then pressing ENTER:  
  
        ```  
        gpupdate /force  
        ```  
  
        In the command output, verify that **Computer Policy update has completed successfully** is displayed.  
  
        ```  
        gpresult /r  
        ```  
  
        In the command output, under **COMPUTER SETTINGS**, verify that the GPO name that is applicable to the managed server is displayed under **Applied Group Policy Objects**. For example, if the Group Policy based provisioning method is used with a GPO prefix of IPAM1, and the managed server type is DHCP, then IPAM1\_DHCP should be displayed.  
  
5.  Refresh server access status.  
  
    ###### To refresh server access status  
  
    1.  In the **SERVER INVENTORY** view, select one or more servers to refresh. Hold down CTRL or SHIFT to select multiple servers.  
  
    2.  Right\-click the selection and then click **Refresh Server Access Status**. The IPAM **ServerDiscovery** task will run.  
  
    3.  Wait for the IPAM **ServerDiscovery** task to complete, and then refresh the **SERVER INVENTORY** view \(click **Refresh** next to the notification flag in Server Manager\).  
  
## See Also  
[Retrieve Data from Managed Servers](../Topic/Retrieve-Data-from-Managed-Servers.md)  
  
