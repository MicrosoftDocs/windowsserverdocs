---
title: Managing Server Inventory
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c8642693-669e-424b-a00b-18589e9c9b77
---
# Managing Server Inventory
This topic contains information and procedures you can use to manage the server inventory in IPAM. To review best practices for server discovery and configuring managed server settings, see [Discovery](../Topic/Best-Practices.md#discovery) and [Provisioning](../Topic/Best-Practices.md#provisioning).  
  
Also see the following topics in the [Plan and Design IPAM](../Topic/Plan-and-Design-IPAM.md) for information about discovering, adding and removing servers from the server inventory, choosing a manageability status, and enabling IPAM access:  
  
-   [Scope of discovery](../Topic/Getting-Started-with-IPAM.md#scope_of_discovery)  
  
-   [Discovering servers](../Topic/Getting-Started-with-IPAM.md#discoverying_servers)  
  
-   [Configuring managed server access settings](../Topic/Getting-Started-with-IPAM.md#configure_method)  
  
-   [Select managed servers](../Topic/Getting-Started-with-IPAM.md#select_managed_servers)  
  
-   [Verify managed server access](../Topic/Getting-Started-with-IPAM.md#verify_access)  
  
See the following topics in the [Deploy IPAM](../Topic/Deploy-IPAM.md) to review step by step procedures for managing the server inventory:  
  
-   [Configure Server Discovery](../Topic/Configure-Server-Discovery.md)  
  
-   [Discover Servers on the Network](../Topic/Discover-Servers-on-the-Network.md)  
  
-   [Manually Add a Server to Server Inventory](../Topic/Manually-Add-a-Server-to-Server-Inventory.md)  
  
-   [Create IPAM Provisioning GPOs](../Topic/Create-IPAM-Provisioning-GPOs.md)  
  
-   [Manually Configuring Managed Server Access Settings](../Topic/Manually-Configuring-Managed-Server-Access-Settings.md)  
  
-   [Choose Managed Servers](../Topic/Choose-Managed-Servers.md)  
  
-   [Verify Managed Server Access](../Topic/Verify-Managed-Server-Access.md)  
  
-   [Retrieve Data from Managed Servers](../Topic/Retrieve-Data-from-Managed-Servers.md)  
  
## Server inventory  
The IPAM server inventory is not the same as the pool of computers that are available for remote management in Server Manager.  The IPAM server inventory is a list of computers located on IPAM’s managed network that have been discovered or manually added to the IPAM database. The server inventory can include computers that are managed, and computers that are not managed by the IPAM server.  
  
![](../Image/IPAM_svr-inventory.gif)  
  
Use the lower navigation pane to view only managed servers or unmanaged servers.  
  
### Adding servers to the inventory  
IPAM leverages Active Directory to discover and validate the computer accounts of servers in the server inventory. There are two methods to add servers:  
  
1.  **Discovery**: The IPAM **ServerDiscovery** task will automatically add domain controllers, DNS servers, and DHCP servers to the server inventory that are within the scope of discovery and found in Active Directory. NPS servers are not automatically discovered and must be added manually. By default, the task runs once every 60 minutes.  
  
    You can run the **ServerDiscovery** task on\-demand by clicking **Manage** and then clicking **Start Server Discovery**. To configure a different time interval for the **ServerDiscovery** task, open Task Scheduler on the IPAM server and navigate to **Microsoft>Windows>IPAM**.  
  
2.  **Manual**: If a computer account is present in Active Directory, it can be added to the server inventory. The computer’s fully qualified domain name must also resolve to an IPv4 or IPv6 address using DNS. If you add a server manually, at least one server role \(domain controller, DNS server, DHCP server, or NPS server\) must also be selected manually. To add a server to the inventory manually, click **TASKS** and then click **Add Server**.  
  
> [!IMPORTANT]  
> If IPAM Server is installed on the same computer with DHCP Server, then IPAM will not discover DHCP servers on the network. Other computers running DHCP Server must be added manually. Also, in order for IPAM to manage DHCP on the local server, **Network Service** \(instead of IPAMUG or the IPAM server’s computer account\) must be added to the local **DHCP Users** and **Event Log Readers** security groups.  
  
### Manageability status  
Servers that are added to the server inventory will have a default management status of **Unspecified**. Other choices for manageability status are **Managed** and **Unmanaged**. Choosing a manageability status for computers in the server inventory has the following effects:  
  
1.  **Access settings**: If you are using the automatic GPO\-based provisioning method, choosing a manageability status of **Managed** will automatically add the computer name to security filtering for the appropriate GPOs based on server roles that are selected next to **Server type**. Selecting a status of **Unmanaged** will remove the computer name from security filtering for all GPOs. Selecting a status of **Unspecified** will make no changes to the current security filtering configuration. If you are using the manual provisioning method, you are required to make these changes manually. Changes to Group Policy will not take effect until Group Policy is refreshed on managed or unmanaged servers.  
  
2.  **IPAM database**: When a computer is added to the server inventory, information about the computer is added to the IPAM database by data collection tasks. This information includes general posture data such as the computer’s IPAM access status and can also include role\-based details such as DHCP scope properties, IP address utilization statistics, DNS zone health, and event catalog data.  
  
    If a computer is assigned a manageability status of **Managed**, then IPAM gathers and stores historical role based data. If a computer is assigned a manageability status of **Unmanaged**, then IPAM does not store role based data and will purge any data that current exists for this computer. If a computer is marked as **Unspecified**, IPAM does not attempt to gather new role\-based data from the computer, but it will maintain all data that currently exists.  
  
### IPAM access status  
See [Verify managed server access](../Topic/Getting-Started-with-IPAM.md#verify_access) and [Troubleshooting IPAM](../Topic/Troubleshooting-IPAM.md) for information about applying and verifying IPAM managed server access settings.  
  
Use the details view to review specific information about computers in the server inventory.  
  
![](../Image/IPAM_inv-details.gif)  
  
Some quick fixes to unblock IPAM access on managed servers include:  
  
1.  Use Group Policy Management to verify that the computer’s domain and host name is listed in the appropriate GPOs under **Security Filtering**, or verify the configuration of manually configured settings.  
  
2.  Use Group Policy Results \(gpresult.exe\) to verify that Group Policy has been applied to managed servers.  
  
3.  Refresh server access status information by running the IPAM **ServerDiscovery** task. To run this task, right\-click the computer in server inventory and then click **Refresh Server Access Status**.  
  
4.  Refresh the IPAM client console view.  
  
5.  If DHCP or DNS security groups were modified, restart the DHCP Server or DNS Server services to apply new settings and permissions.  
  
## See also  
[Walkthrough: Demonstrate IPAM in Windows Server 2012](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012.md)  
  
