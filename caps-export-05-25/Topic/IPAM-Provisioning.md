---
title: IPAM Provisioning
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 24c903c7-37e6-452b-bb3a-72265d932870
---
# IPAM Provisioning
This topic provides a summary of IPAM provisioning methods. For more information, see [Choose an IPAM Provisioning Method](http://go.microsoft.com/fwlink/p/?linkid=244438) in the Windows Server Technical Library.  
  
## What is IPAM provisioning?  
To be managed by IPAM, group memberships, file shares, service access settings, and firewall ports on domain controllers, NPS, DNS, and DHCP servers must be configured to allow the IPAM server access to perform required monitoring and configuration functions. Application of these settings to managed servers is referred to as IPAM provisioning.  
  
When access settings are configured on managed servers, the IPAM server periodically collects configuration and monitoring information by using Windows remote management protocols. The IPAM server collects information by using data collection tasks that run periodically and can be viewed in Task Manager. These periodic data collection tasks run on the IPAM server under the Network Service account, which in turn uses the IPAM server computer account credentials for remote communication.  
  
The following table describes the settings that are required on managed servers to enable IPAM access.  
  
|Managed Server Role|IPAM Access Status|Access Settings|  
|-----------------------|----------------------|-------------------|  
|DHCP|DHCP RPC|The computer account for the IPAM server must be a member of the DHCP Users security group.<br /><br />The following firewall rules must be enabled:<br /><br />-   DHCP Server \(RPC\-In\)<br />-   DHCP Server \(RPCSS\-In\)|  
|DHCP|DHCP audit share|A network file share named **Dhcpaudit** must be created using the DHCP audit file folder, with Read access enabled for the computer account of the IPAM server.<br /><br />The following firewall rules must be enabled:<br /><br />-   File and Printer Sharing \(NB\-Session\-In\)<br />-   File and Printer Sharing \(SMB\-In\)|  
|DNS|DNS RPC|Read access for the computer account of the IPAM server must be added to DNS discretionary access control list \(DACL\).<br /><br />The following firewall rules must be enabled:<br /><br />-   DNS Service RPC<br />-   DNS Service RPC Endpoint Mapper|  
|DHCP, DNS, domain controller, NPS|Event log|The computer account of the IPAM server must be a member of the Event Log Readers security group.<br /><br />The computer account for the IPAM server must be granted read access in the ACL that is maintained by the following registry key on the DNS server: MACHINE\\System\\CurrentControlSet\\Services\\Eventlog\\DNS Server\\CustomSD. This only required on DNS servers.<br /><br />The following firewall rules must be enabled:<br /><br />-   Remote Event Log Management \(RPC\)<br />-   Remote Event Log Management \(RPC\-EPMAP\)|  
  
In addition to service management and event monitoring, IPAM performs service status monitoring for DNS and DHCP servers. To enable this service monitoring functionality, the computer account of the IPAM server must be granted read access to the DHCP Server service \(for DHCP service monitoring\) and to the DNS Server service \(for DNS service monitoring\). This access is controlled by the Windows service ACL and requires that the following firewall rules are enabled on target servers:  
  
-   Remote Service Management \(RPC\)  
  
-   Remote Service Management \(RPC\-EPMAP\)  
  
Service access status for DHCP and DNS servers can be viewed in the Server Availability column from the DHCP and DNS Servers view.  
  
## Provisioning methods  
Before you can begin using IPAM, you must choose a method to provision access settings on managed servers. The following IPAM provisioning methods are available:  
  
-   **Manual**: If you choose the manual method, security group membership, firewall rules, file shares, and service access settings must be configured individually on each managed server. Settings must also be removed manually if the server becomes unmanaged. This method is typically used when the number of managed servers is small.  
  
-   **Group Policy\-based**: If you choose the Group Policy\-based method, IPAM automatically adds managed servers to the appropriate Group Policy Object \(GPO\) when a server is marked as managed. If the server is marked as unmanaged it is removed from GPO security filtering. However, settings must be removed manually if you change a server from a managed status to unmanaged status. You must provide a Group Policy Object \(GPO\) prefix in the IPAM provisioning wizard, and the following GPOs must be created in the domains that contain managed servers:  
  
    -   **<GPO\-prefix>\_DHCP**: This GPO is used to apply policies and settings to allow IPAM to monitor, manage, and collect information from managed DHCP servers on the network. In addition to monitoring functions, several DHCP server and scope properties can be configured using IPAM.  
  
    -   **<GPO\-prefix>\_DNS**: This GPO is used to apply policies and settings to allow IPAM to monitor and collect information from managed DNS servers on the network. Zone status monitoring and a limited set of configuration functions are available for DNS servers.  
  
    -   **<GPO\-prefix>\_DC\_NPS**: This GPO is used to apply policies and settings to allow IPAM to collect information from managed domain controllers and network policy servers \(NPS\) on the network for IP address tracking purposes.  
  
> [!IMPORTANT]  
> The managed server provisioning method cannot be changed after you complete the IPAM provisioning wizard.  
  
If you use the Group Policy\-based method, GPOs must be created in the domains that will be managed by IPAM. To configure these GPOs, use the **Invoke\-IpamGpoProvisioning** Windows PowerShell cmdlet. To use the manual provisioning method, you must configure individual security group membership, firewall rules, file shares, and service access settings locally on each managed server.  
  
When you configure IPAM access settings on managed servers, the IPAM server communicates with these servers using Windows remote management connections. These are required for server management functions and periodic data collection tasks that run on the IPAM server.  
  
The following are typical steps that are used to initially configure IPAM using the Group Policy\-based provisioning method:  
  
1.  Complete the IPAM provisioning wizard, and select the Group Policy\-based provisioning method. Provide a GPO prefix that is unique to each IPAM server instance. GPOs are NOT created in this step.  
  
2.  Configure server discovery by selecting the domains that contain infrastructure servers you want to manage and monitor with IPAM.  
  
3.  Create IPAM GPOs in each of the chosen domains by using the Windows PowerShell **Invoke\-IpamGpoProvisioning** cmdlet. Membership in the Domain Admins group, or higher, is required to run this cmdlet. You can delegate subsequent IPAM GPO administration tasks to specified users or groups that are not domain administrators.  
  
4.  After you complete the server discovery task, select the servers to manage by setting their manageability status to Managed or Unmanaged. Credentials for the user that is signed in to the IPAM server are used to add these servers to the GPO filter list. The IPAM administrator who performs this operation must be a member of the Domain Admins or Enterprise Admins security group, or a delegated administrator.  
  
5.  Wait for Group Policy update to apply the settings on the managed servers. Refresh the server access status to ensure that all the required IPAM access settings are allowed on managed servers.  
  
6.  When IPAM access is verified, you can retrieve data from the managed servers.  
  
## Common management actions  
IPAM provides the following noncontextual actions from the Manage menu in the Server Manager console:  
  
-   **Connect to IPAM Server**: Enables you to select an IPAM server from the list of IPAM servers that are managed by the current instance of Server Manager.  
  
-   **IPAM Settings**: Provides the following configuration options:  
  
    -   **Configure Server Discovery**: Select domains in the Active Directory forest to run automatic server discovery for DHCP servers, DNS servers, and domain controllers.  
  
    -   **Configure Custom Fields**: Create new custom fields and values or extend existing custom fields.  
  
    -   **Configure Utilization Threshold**: Specify overutilization and underutilization threshold percentages to categorize the utilization status of IP address ranges, IP address blocks, and IP range groups as Over, Under, or Optimal.  
  
-   **Start Discovery**: Trigger the ServerDiscovery task on demand to refresh server information.  
  
-   **Retrieve All Server Data**: Trigger all data collection tasks on demand to refresh information.  
  
## See also  
[IP Address Management Overview](assetId:///9035778c-7ab3-42d0-8540-45a163c1d46b)  
  
