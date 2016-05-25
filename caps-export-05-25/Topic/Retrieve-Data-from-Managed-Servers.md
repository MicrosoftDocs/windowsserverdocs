---
title: Retrieve Data from Managed Servers
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: df66e3f3-eb1a-4859-8f71-1a20679d38d9
---
# Retrieve Data from Managed Servers
[Checklist: Deploy IPAM Server](../Topic/Checklist--Deploy-IPAM-Server.md) > [Install IPAM Server](../Topic/Install-IPAM-Server.md) > [Choose an IPAM Provisioning Method](../Topic/Choose-an-IPAM-Provisioning-Method.md) > [Configure Server Discovery](../Topic/Configure-Server-Discovery.md) > [Discover Servers on the Network](../Topic/Discover-Servers-on-the-Network.md) | [Manually Add a Server to Server Inventory](../Topic/Manually-Add-a-Server-to-Server-Inventory.md) > [Create IPAM Provisioning GPOs](../Topic/Create-IPAM-Provisioning-GPOs.md) | [Manually Configure DHCP Access Settings](../Topic/Manually-Configure-DHCP-Access-Settings.md) | [Manually Configure DNS Access Settings](../Topic/Manually-Configure-DNS-Access-Settings.md) | [Manually Configure DC and NPS Access Settings](../Topic/Manually-Configure-DC-and-NPS-Access-Settings.md) > [Choose Managed Servers](../Topic/Choose-Managed-Servers.md) > [Verify Managed Server Access](../Topic/Verify-Managed-Server-Access.md) > **Retrieve Data from Managed Servers**  
  
After you have verified the IPAM server has access to managed servers, you can retrieve data from managed servers to begin populating the IPAM database. You might also want to retrieve server data after a configuration change or just to obtain updated information. You do not have to manually retrieve data from managed servers because scheduled tasks on the IPAM server will perform this task automatically. Perform the following procedure if you do not want to wait for these scheduled tasks to run. For more information about IPAM scheduled data collection tasks, see [IPAM Architecture](../Topic/IPAM-Architecture.md).  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Retrieving data from managed servers  
Use the **SERVER INVENTORY** view to retrieve all server data. Specific types of server data can also be retrieved using views under **IP ADDRESS SPACE** \(for address space data\), **MONITOR AND MANAGE** \(for configuration and monitoring data\), and **EVENT CATALOG** \(for audit data\). You can retrieve data for a single managed server or for multiple managed servers.  
  
## <a name="discover"></a>  
#### To retrieve data from managed servers  
  
1.  In the upper IPAM navigation tree, click **SERVER INVENTORY**.  
  
2.  Select the managed servers from which you want to collect data. Press and hold CTRL or SHIFT to select multiple servers.  
  
3.  Right\-click the servers that are selected, and then click **Retrieve All Server Data**.  
  
4.  The following data collection tasks will run immediately on the selected servers: **AddressExpiry**, **AddressUtilization**, **Audit**, **ServerAvailability**, **ServiceMonitoring**, **ServerConfiguration**.  
  
5.  Wait for the data collection tasks to complete.  
  
