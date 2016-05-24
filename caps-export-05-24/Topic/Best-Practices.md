---
title: Best Practices
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a810d897-e8b8-45d0-bc41-f3416adbe28e
---
# Best Practices
  
## <a name="best_practices"></a>IPAM best practices  
The following are some best practices for deploying and operating IPAM.  
  
-   [General](../Topic/Best-Practices.md#general)  
  
-   [Provisioning](../Topic/Best-Practices.md#provisioning)  
  
-   [Discovery](../Topic/Best-Practices.md#discovery)  
  
-   [IP address management](../Topic/Best-Practices.md#ip_mgmt)  
  
-   [Monitor and manage](../Topic/Best-Practices.md#msm)  
  
-   [Event catalog](../Topic/Best-Practices.md#event_catalog)  
  
### <a name="general"></a>General  
  
-   IPAM users and administrators should be added to the appropriate IPAM security groups based on their roles and administrative privileges. Do not make all users a member of the IPAM Administrators group unless this is required.  
  
-   User\-defined custom fields that are required to be used for a logical grouping must be added as multivalue fields.  
  
-   Refresh the IPAM user interface periodically to ensure that the view is up\-to\-date with any changes in the database. Changes can occur due to periodic data collection tasks and concurrent user sessions.  
  
-   Leverage advanced features like logical grouping, saving and loading filter queries, group by, and viewing customizations to visualize and track entities and fields of interest.  
  
-   The IPAM database should be backed up periodically using Windows Server Backup.  
  
-   Tasks that require a long time to complete and operations such as database purging should be scheduled during non\-business hours when the load on the network is low.  
  
### <a name="provisioning"></a>Provisioning  
  
-   The Group Policy based provisioning method is recommended over the manual provisioning method due to the number of security settings that need to be enabled for each server role that is managed by IPAM. Using Group Policy also ensures that settings are regularly updated.  
  
-   A domain\-wide group named **IpamGpoAdmins** should be created, and IPAM GPO administration should be delegated to this group at the time of GPO creation. Any user who needs to mark servers as managed or unmanaged can be added to this group.  
  
-   Ensure that there are no conflicting Group Policies in your environment for the settings that are required by IPAM. IPAM access can be disabled if a firewall port that is required by IPAM is blocked by another Group Policy, or if membership in a security group that is required by IPAM is overwritten.  
  
-   When multiple servers are being selected for management, such as during initial IPAM provisioning, select all servers simultaneously to set their manageability status. This ensures that incremental edits to IPAM GPOs are minimal.  
  
-   For large deployments, linking the GPO to the root of the domain may not be ideal. Administrators should use organizational units to deploy Group Policy for infrastructure servers.  
  
-   Rollback of IPAM access settings is recommended from the servers that are being marked as unmanaged. However, updating the domain\-wide DNS ACL will enable DNS RPC access for the IPAM server on all domain controllers that are co\-located with DNS servers in the domain. This setting is not updated on a per\-server basis.  
  
-   For standalone DNS servers that are not co\-located on domain controller, the computer for the IPAM server must be added to the local Administrators group because the domain\-wide DNS ACL will not be applicable on these servers. If this is not done, the standalone DNS server will display an IPAM access status of blocked.  
  
### <a name="discovery"></a>Discovery  
  
-   Do not install the IPAM feature on a server that is running the on a DHCP Server role service because it affects IPAM’s discovery of DHCP servers in the network.  
  
-   Do not add servers individually \(for roles other than NPS\), to avoid having to manually maintain the server inventory. Leverage the automated discovery mechanism as much as possible.  
  
-   Avoid keeping the server manageability status as **Unspecified** except when the server is temporarily out of service. Ideally the server should be marked as **Managed** or **Unmanaged**.  
  
-   If only a subset of the roles that are discovered on a physical server need to be managed, make sure that only the roles that are actively managed are selected on the server. Other roles should be cleared. IPAM periodic data collection tasks will collect data from all roles that are selected.  
  
### <a name="ip_mgmt"></a>IP address management  
  
-   Configure utilization thresholds appropriately to select the most effective checkpoints to identify under and over utilized address space.  
  
-   Over utilization threshold crossing events that are logged by IPAM should be monitored for timely detection of potential address space exhaustion.  
  
-   Overutilized and underutilized address space must be identified and effectively redistributed to achieve optimal utilization across the entire address space. Utilization trends can be used as effective tools to predict the short and long term address space requirements.  
  
-   If exclusion ranges are being used within DHCP scopes to make static allocations or reservations, then IPAM recommends explicitly creating a static IP address range that corresponds to the exclusion range to track the utilization statistics for the entire subnet.  
  
-   For a homogenous and consistent rollout of address space allocations, arrange IPv4 address ranges in size units of between \/22 and \/24 and IPv6 ranges of \/64. Use IPv4 address blocks of size \/16, and IPv6 address blocks of \/48.  
  
-   Create static IP addresses with a finite expiry date to ensure that stale addresses can be reclaimed from address ranges at the correct intervals. When an IP address transitions to the expiry due state, administrators must try to ensure that the address is alive in the network and extend the address life or reclaim the address.  
  
-   Leverage IPAM’s overlap and duplicate detection feature to identify and track intentional and unintentional IP address ranges on your network.  
  
-   If you have multiple instances of overlapping address space configured in your environment, then using logical groups will be more effective to track overall utilization. Address blocks only map one overlapping range for utilization roll\-up.  
  
-   For tracking IP address leases in the network, the IP address tracking feature in the Event Catalog view can be more efficient than pulling all dynamic DHCP lease records into IPAM.  
  
-   Leverage IPAM’s Find an Available IP Address feature with in\-line DHCP reservation and DNS record updates to simplify static IP address allocations.  
  
### <a name="msm"></a>Monitor and manage  
  
-   Create and save queries to quickly identify services and zones that are not in a healthy state.  
  
-   Leverage advanced constructs in multiedit scenarios to add, overwrite, delete, or find\-and\-replace to cater to the exact scenario requirement when you edit options across multiple DHCP scopes and servers.  
  
-   Leverage advanced constructs in multiedit scenarios to add, overwrite, or delete to cater to the exact scenario requirement when you configure vendor and user classes across multiple DHCP servers.  
  
-   Use the duplicate scope functionality to create new scopes with similar settings. The typical scenarios where this can be leveraged are migrating scopes from one server to another and configuring split scopes.  
  
-   Use the overall forward lookup zone view to identify potential issues and to identify servers that might have a problem. Isolate whether the issue is due to a zone event or server availability state.  
  
-   Monitor DHCP scope utilization percentage and utilization status to identify overutilized and underutilized scopes. Take necessary actions to align scope utilization to an optimal state, keeping utilization trend history in mind.  
  
-   For settings that are not supported by IPAM, launch the DHCP or DNS MMC from within the IPAM console to complete the configuration scenario.  
  
### <a name="event_catalog"></a>Event catalog  
  
-   For best performance and disk space management, an IPAM event catalog data purge should be performed periodically, to maintain a six\-month old database.  
  
-   Auditing of account logon events should be enabled on domain controllers and NPS servers, and the security event log size should be large enough to allow the periodic audit task to complete data collection before it is rolled over.  
  
-   The DHCP audit log file size must be large enough to hold the audit events for one day, to ensure that no lease events are lost because of size overruns.  
  
-   The audit log file location for both DHCP IPv4 and IPv6 leases must be configured in a common folder. The IPAM audit task selects the log files from one network share per server.  
  
-   The time period that is selected for a query should be optimal. Typically, a query interval between 3 days to 15 days is optimal.  
  
## See also  
[Troubleshooting IPAM](../Topic/Troubleshooting-IPAM.md)  
  
