---
title: IPAM Troubleshooting and Best Practices
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3288f3a8-3b3a-4baa-a9b0-41c8d58d6131
---
# IPAM Troubleshooting and Best Practices
This topic provides general troubleshooting guidance for IPAM server. For more information, see [Troubleshooting and Best Practices](http://go.microsoft.com/fwlink/p/?linkid=244445) in the Windows Server Technical Library.  
  
## Troubleshooting tools  
IPAM event logs are available in Event Viewer using the following path: Application and Services Logs > Microsoft > Windows > IPAM. The following log channels are available:  
  
-   **Admin**: This channel captures events that are related to IPAM user actions and IPAM periodic tasks.  
  
-   **ConfigurationChange**: This channel captures events that are related to configuration changes made to the IPAM server.  
  
-   **Operational**: This channel captures informational events that are related to IPAM periodic tasks. Event logging on this channel is disabled by default.  
  
-   **Analytic and Debug**: These channels are hidden and disabled by default. Use these channels for debugging purposes. To show them, click **View** and then click **Show Analytic and Debug Logs**.  
  
Events in the Admin and Operational channels can also be viewed from the IPAM tile in the Server Manager Dashboard.  
  
## Common problems and solutions  
The following section lists common problems and solutions for IPAM.  
  
### Connecting to the IPAM server  
  
-   Problem: You are not able to connect to the IPAM server.  
  
-   Solution: View the **Description** field on Task Manager’s **Services** tab, and verify that the following services are running on the IPAM server:  
  
    -   Windows Process Activation Service  
  
    -   Windows Internal Database  
  
    If they are not running, start these services. Also verify that you are a signed in as a domain user and that you are a member of either the local Administrators security group on the IPAM server, or a member of the appropriate IPAM security group on the IPAM server.  
  
### Server access  
  
-   Problem: The access status of a managed server does not change to Unblocked after completing IPAM provisioning.  
  
-   Solution: Review the details pane in Server Inventory view to identify the types of access status that are blocked. If you are using the manual IPAM provisioning method, verify that the access settings that correspond to this status are enabled. For Group Policy\-based provisioning, verify that the required GPOs have been created and linked, and that the managed server is a member of the security filter list of appropriate GPOs. This issue can also occur if Group Policy has not been updated on the target servers. Open an elevated command prompt on the managed server and type **gpupdate \/force** to force the application of Group Policy.  
  
-   Problem: You are unable to add a managed server to an IPAM GPO.  
  
-   Solution: Verify that you are signed in as a member of the Domain Admins security group, or higher, or that you have been delegated privileges to edit the GPO. GPO delegation for users or groups can be enabled from the IPAM **Invoke\-IpamGpoProvisioning** cmdlet at the time the GPO is created, or from the Group Policy Management Console if the GPO is already created.  
  
### Server discovery  
  
-   Problem: You are unable to configure server discovery.  
  
-   Solution: Verify that you are signed in as a domain user and not as a local user on the IPAM server.  
  
-   Problem: A DNS server is not discovered.  
  
-   Solution: Verify that the DNS server configured on the IPAM server’s network interface can query name server \(NS\) records for the domain zone, and that an NS record exists for the DNS server. All NS records for the domain zone and NS records for allowed DNS suffixes are queried during the DNS server discovery operation.  
  
-   Problem: A DHCP server is not discovered.  
  
-   Solution: Verify that the DHCP server role is not installed on the IPAM server. Verify that at least one IPv4 scope is configured on a DHCP server, and that the IPAM server has a TCP\/IP connection to the DHCP server. Also verify that DHCP INFORM request messages sent by IPAM server are not filtered on the network.  
  
-   Problem: You are unable to manually add a server to IPAM.  
  
-   Solution: Verify DNS resolution of the IP address of the server. Also verify that the server name is present in the Active Directory Global Catalog.  
  
### IP address space management  
  
-   Problem: You are unable to find an available IP address from a Microsoft DHCP\-managed IP address range.  
  
-   Solution: Verify that DHCP RPC firewall ports are enabled on the target DHCP server, and that your user account is a member of the DHCP Users group on the DHCP server.  
  
-   Problem: You are unable to import a comma\-separated value file with IP address records into IPAM.  
  
-   Solution: Verify that all the header field names in the file match the existing built\-in and custom field names in IPAM. Create new custom field names in IPAM if required.  
  
-   Problem: Importing records from a comma\-separated value file is successful, but some of the records are not displayed in IPAM.  
  
-   Solution: Review the error log for the import operation. By default, this log is created in the Documents folder, and it contains details of any records that failed to import. Use the error information provided to fix each failed record instance, and then repeat the import operation.  
  
-   Problem: You are unable to select DHCP servers or DNS zones in the IP address add or edit dialog box.  
  
-   Solution: Verify that the DHCP and DNS servers that are hosting the scope or zone are managed by IPAM. Also verify that you have administrative privileges on the target DHCP or DNS server.  
  
### Monitoring and management  
  
-   Problem: A managed server availability state is not reachable.  
  
-   Solution: Verify TCP\/IP connectivity between the IPAM server and the target server. Verify that the DNS Server service or DHCP Server service is running on the target server, and that the IPAM server has been successfully provisioned with Read access on the service ACLs. Also verify that remote service management ports are open on the target server.  
  
-   Problem: You are unable to make configuration changes on a DHCP server or scope.  
  
-   Solution: Verify that DHCP RPC firewall ports are enabled on the target DHCP server, and that you are signed in with an account that has DHCP Administrators privileges on the target DHCP server.  
  
## Best practices  
The following are some best practices for deploying and operating IPAM.  
  
### General  
  
-   The IPAM server should be installed as a standalone feature. For optimal performance, do not locate IPAM with other server roles or features.  
  
-   The recommended hardware configuration for an IPAM server is: A dual\-core 2 GHz CPU, RAM in excess of 4 GB, and disk space of 120 GB or greater.  
  
-   IPAM users and administrators must be added to the appropriate IPAM security groups based on their roles and administrative privileges.  
  
-   User\-defined custom fields that are required to be used for a logical grouping must be added as multivalue fields.  
  
-   Refresh the IPAM user interface periodically to ensure that the view is up\-to\-date with any changes in the database. Changes can occur due to periodic data collection tasks and concurrent user sessions.  
  
-   Leverage advanced features like logical grouping, saving and loading filter queries, group by, and viewing customizations to visualize and track entities and fields of interest.  
  
-   The IPAM database should be backed up periodically using Windows Server Backup.  
  
-   Tasks that require a long time to complete, and operations such as database purging, should be scheduled during nonbusiness hours when the load on the network is low.  
  
### Provisioning  
  
-   The Group Policy\-based provisioning method is recommended over the manual provisioning method due to the number of security settings that need to be enabled for each server role that is managed by IPAM. Using Group Policy also ensures that settings are regularly updated.  
  
-   A domain\-wide group named **IpamGpoAdmins** should be created, and IPAM GPO administration should be delegated to this group at the time of GPO creation. Any user who needs to mark servers as managed or unmanaged can be added to this group.  
  
-   Ensure that there are no conflicting Group Policies in your environment for the settings that are required by IPAM. IPAM access can be disabled if a firewall port that is required by IPAM is blocked by another Group Policy, or if membership in a security group that is required by IPAM is overwritten.  
  
-   When multiple servers are being selected for management, such as during initial IPAM provisioning, select all servers simultaneously to set their manageability status. This ensures that incremental edits to IPAM GPOs are minimal.  
  
-   For large deployments, linking the GPO to the root of the domain may not be ideal. Administrators should use organizational units to deploy Group Policy for infrastructure servers.  
  
-   Rollback of IPAM access settings is recommended from the servers that are being marked as unmanaged. However, updating the domain\-wide DNS ACL will enable DNS RPC access for the IPAM server on all domain controllers that are co\-located with DNS servers in the domain. This setting is not updated on a per\-server basis.  
  
-   For standalone DNS servers that are not co\-located on domain controller, the computer for the IPAM server must be added to the local Administrators group because the domain\-wide DNS ACL will not be applicable on these servers.  
  
### Discovery  
  
-   Do not install the IPAM feature on a server that is running the on a DHCP Server role service because it affects IPAM’s discovery of DHCP servers in the network.  
  
-   Do not add servers individually \(for roles other than NPS\), to avoid having to manually maintain the server inventory. Leverage the automated discovery mechanism as much as possible.  
  
-   Avoid keeping the server manageability status as Unspecified except when the server is temporarily out of service. Ideally the server should be marked as Managed or Unmanaged.  
  
-   If only a subset of the roles that are discovered on a physical server need to be managed, make sure that only the roles that are actively managed are selected on the server. Other roles should be cleared. IPAM periodic data collection tasks will collect data from all roles that are selected.  
  
### IP address management  
  
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
  
### Monitor and manage  
  
-   Create and save queries to quickly identify services and zones that are not in a healthy state.  
  
-   Leverage advanced constructs in multiedit scenarios to add, overwrite, delete, or find\-and\-replace to cater to the exact scenario requirement when you edit options across multiple DHCP scopes and servers.  
  
-   Leverage advanced constructs in multiedit scenarios to add, overwrite, or delete to cater to the exact scenario requirement when you configure vendor and user classes across multiple DHCP servers.  
  
-   Use the duplicate scope functionality to create new scopes with similar settings. The typical scenarios where this can be leveraged are migrating scopes from one server to another and configuring split scopes.  
  
-   Use the overall forward lookup zone view to identify potential issues and to identify servers that might have a problem. Isolate whether the issue is due to a zone event or server availability state.  
  
-   Monitor DHCP scope utilization percentage and utilization status to identify overutilized and underutilized scopes. Take necessary actions to align scope utilization to an optimal state, keeping utilization trend history in mind.  
  
-   For settings that are not supported by IPAM, launch the DHCP or DNS MMC from within the IPAM console to complete the configuration scenario.  
  
### Event catalog  
  
-   For best performance and disk space management, an IPAM event catalog data purge should be performed periodically, to maintain a six\-month old database.  
  
-   Auditing of account logon events should be enabled on domain controllers and NPS servers, and the security event log size should be large enough to allow the periodic audit task to complete data collection before it is rolled over.  
  
-   The DHCP audit log file size must be large enough to hold the audit events for one day, to ensure that no lease events are lost because of size overruns.  
  
-   The audit log file location for both DHCP IPv4 and IPv6 leases must be configured in a common folder. The IPAM audit task selects the log files from one network share per server.  
  
-   The time period that is selected for a query should be optimal. Typically, a query interval between 3 days to 15 days is optimal.  
  
## See also  
[IP Address Management Overview](assetId:///9035778c-7ab3-42d0-8540-45a163c1d46b)  
  
