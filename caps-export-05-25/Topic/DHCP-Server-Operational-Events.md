---
title: DHCP Server Operational Events
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2193cd81-31ab-4ac2-85b2-ba37d750b53c
---
# DHCP Server Operational Events
The following tables summarize Windows DHCP Server events. Events are displayed in tables based on their channel.  
  
-   [DHCP Server Operational Events](../Topic/DHCP-Server-Operational-Events.md#op)  
  
-   [DHCP Server Administrative Events](../Topic/DHCP-Server-Operational-Events.md#admin)  
  
-   [DHCP Server System Events](../Topic/DHCP-Server-Operational-Events.md#sys)  
  
-   [DHCP Server Filter Notification Events](../Topic/DHCP-Server-Operational-Events.md#filter)  
  
-   [DHCP Server Audit Events](../Topic/DHCP-Server-Operational-Events.md#audit)  
  
## <a name="op"></a>DHCP Server Operational Events  
  
||||  
|-|-|-|  
|**Event ID**|**Event category**|**Event text**|  
|70|DHCPv4.ScopeConfigured|Scope: %1 for IPv4 is Configured by %2.|  
|71|DHCPv4.ScopeModified|Scope: %1 for IPv4 is Modified by %2.|  
|72|DHCPv4.ScopeDeleted|Scope: %1 for IPv4 is Deleted by %2.|  
|73|DHCPv4.ScopeActivated|Scope: %1 for IPv4 is Activated by %2.|  
|74|DHCPv4.ScopeDeActivated|Scope: %1 for IPv4 is Deactivated by %2.|  
|75|DHCPv4.ScopeLeaseUpdate|Scope: %1 for IPv4 is Updated with Lease Duration: %2 seconds by %3. The previous configured Lease Duration was: %4 seconds.|  
|76|DHCPv4.ScopeOptionUpdate|Scope: %1 for IPv4 is Updated with Option Settings: %2 by %3|  
|77|DHCPv4.ScopeDNSEnable|Scope: %1 for IPv4 is Enabled for DNS Dynamic updates by %2.|  
|78|DHCPv4.ScopeDNSDisable|Scope: %1 for IPv4 is Disabled for DNS Dynamic updates by %2.|  
|79|DHCPv4.ScopeDNSUpdate\_Req\_by\_Client|Scope: %1 for IPv4 is Updated with DNS Settings by %2: to dynamically update DNS A and PTR records on request by the DHCP Clients .|  
|80|DHCPv4.ScopeDNSUpdate\_Always|Scope: %1 for IPv4 is Updated with DNS Settings by %2: to always dynamically update DNS A and PTR records.|  
|81|DHCPv4.ScopeDNSEnable\_Discard|Scope: %1 for IPv4 is Enabled for DNS Settings by %2: to discard DNS A and PTR records when lease is deleted.|  
|82|DHCPv4.ScopeDNSDisable\_Discard|Scope: %1 for IPv4 is Disabled for DNS Settings by %2: to discard DNS A and PTR records when lease is deleted.|  
|83|DHCPv4.ScopeDNSEnable\_Update\_Client\_NoReq|Scope: %1 for IPv4 is Enabled for DNS Settings by %2: to dynamically update DNS A and PTR records for DHCP Clients that do not request updates.|  
|84|DHCPv4.ScopeDNSDisable\_Update\_Client\_NoReq|Scope: %1 for IPv4 is Disabled for DNS Settings by %2: to dynamically update DNS A and PTR records for DHCP Clients that do not request updates.|  
|85|DHCPv4.ScopePBA\_DeActivated|Policy based assignment has been disabled for scope %1.|  
|86|DHCPv4.ScopePBA\_Activated|Policy based assignment has been enabled for scope %1.|  
|87|DHCPv4.ScopeDHCIDEnable|Name Protection setting is Enabled on Scope: %1 for IPv4 by %2.|  
|88|DHCPv4.ScopeDHCIDDisable|Name Protection setting is Disabled on Scope: %1 for IPv4 by %2.|  
|89|DHCPv4.ScopeSupportType|Scope: %1 for IPv4 is Updated with support type: %2 by %3. The previous configured state was: %4.|  
|90|DHCPv4.ScopeNAPEnabled|NAP Enforcement is Enabled on Scope: %1 for IPv4 by %2.|  
|91|DHCPv4.ScopeNAPDisabled|NAP Enforcement is Disabled on Scope: %1 for IPv4 by %2.|  
|92|DHCPv4.ScopeNAPProfileConfigured|NAP Profile is configured on Scope: %1  for IPv4 with the following NAP Profile: %2 by %3.|  
|93|DHCPv4.ScopeNAPProfileModified|NAP Profile is Updated on Scope: %1 for IPv4 with the following NAP Profile: %2 by %3. The previous configured NAP Profile was: %4.|  
|94|DHCPv4.ScopeNAPProfileDeleted|The following NAP Profile: %1 is deleted on Scope: %2 by %3.|  
|95|DHCPv4.MulticastScopeConfigured|Scope: %1 for Multicast IPv4 is Configured by %2.|  
|96|DHCPv4.MulticastScopeDeleted|Scope: %1 for Multicast IPv4 is Deleted by %2.|  
|98|DHCPv4.SuperScopeConfigured|SuperScope: %1 for IPv4 is Configured by %2.|  
|99|DHCPv4.SuperScopeDeleted|SuperScope: %1 for IPv4 is Deleted by %2.|  
|100|DHCPv4.SuperScopeActivated|Scope: %1 within SuperScope: %2 for IPv4 is Activated by %3.|  
|101|DHCPv4.SuperScopeDeActivated|Scope: %1 within SuperScope: %2 for IPv4 is DeActivated by %3.|  
|102|DHCPv4.SuperScopeDeleteTemp|Scope: %1 for IPv4 is Removed in Superscope: %2 by %3. However, the Scope exists outside the Superscope.|  
|103|DHCPv4.SuperScopeDeletePerm|Scope: %1 for IPv4 is Deleted in Superscope: %2 as well as Deleted permanently by %3.|  
|105|DHCPv4.ServerOptionUpdate|Server level option %1 for IPv4 has been updated by %2.|  
|106|DHCPv4.ReservationConfigured|Reservation: %1 for IPv4 is Configured under Scope %2 by %3.|  
|107|DHCPv4.ReservationDeleted|Reservation: %1 for IPv4 is Deleted under Scope %2 by %3.|  
|108|DHCPv4.ReservationDNSEnable|Reservation: %1 for IPv4 under Scope: %2 is Enabled for DNS Dynamic updates by %3.|  
|109|DHCPv4.ReservationDNSDisable|Reservation: %1 for IPv4 under Scope: %2 is Disabled for DNS Dynamic updates by %3.|  
|110|DHCPv4.ReservationDNSUpdate\_Req\_by\_Client|Reservation: %1 for IPv4 under Scope: %2  is Updated with DNS Settings by %3: to dynamically update DNS A and PTR records on request by the DHCP Clients.|  
|111|DHCPv4.ReservationDNSUpdate\_Always|Reservation: %1 for IPv4 under Scope: %2 is Updated with DNS Settings by %3: to always dynamically update DNS A and PTR records.|  
|112|DHCPv4.ReservationDNSEnable\_Discard|Reservation: %1 for IPv4 under Scope: %2 is Enabled for DNS Settings by %3: to discard DNS A and PTR records when lease is deleted.|  
|113|DHCPv4.ReservationDNSDisable\_Discard|Reservation: %1 for IPv4 under Scope: %2 is Disabled for DNS Settings by %3: to discard DNS A and PTR records when lease is deleted.|  
|114|DHCPv4.ReservationDNSEnableUpdate\_No\_Req\_by\_Client|Reservation: %1 for IPv4 under Scope: %2 is Enabled for DNS Settings by %3: to dynamically update DNS A and PTR records for DHCP Clients that do not request updates.|  
|115|DHCPv4.ReservationDNSDisableUpdate\_No\_Req\_by\_Client|Reservation: %1 for IPv4 under Scope: %2 is Disabled for DNS Settings by %3: to dynamically update DNS A and PTR records for DHCP Clients that do not request updates.|  
|116|DHCPv4.ReservationOptionUpdate|Reservation: %1 for IPv4 under Scope: %2 is Updated with Option Setting: %3 by %4.|  
|117|DHCPv4.ServerPBA\_DeActivated|Policy based assignment has been disabled at server level.|  
|118|DHCPv4.ServerPBA\_Activated|Policy based assignment has been enabled at server level.|  
|119|DHCPv4.ScopeExclusionAdded|Added exclusion IP Address range %1 in the Address Pool for IPv4 under Scope: %2 by %3.|  
|120|DHCPv4.ScopeExclusionDeleted|Deleted exclusion IP Address range %1 in the Address Pool for IPv4 under Scope: %2 by %3.|  
|121|DHCPv4.ScopeEnableAllow|Link Layer based filtering is Enabled in the Allow List of the IPv4 by %1|  
|122|DHCPv4.ScopeDisableAllow|Link Layer based filtering is Disabled in the Allow List of the IPv4 by %1|  
|123|DHCPv4.ScopeAllow\_AddFilter|Filter for physical address: %1, hardware type: %3 added to the IPv4 Allow List by %2.|  
|124|DHCPv4.ScopeAllow\_DeleteFilter|Filter for physical address: %1, hardware type: %3 removed from the IPv4 Allow List by %2.|  
|125|DHCPv4.ScopeEnableDeny|Link Layer based filtering is Enabled in the Deny List of the IPv4 by %1|  
|126|DHCPv4.ScopeDisableDeny|Link Layer based filtering is Disabled in the Deny List of the IPv4 by %1|  
|127|DHCPv4.ScopeDeny\_AddFilter|Filter for physical address: %1, hardware type: %3 added to the IPv4 Deny List by %2.|  
|128|DHCPv4.ScopeDeny\_DeleteFilter|Filter for physical address: %1, hardware type: %3 removed from the IPv4 Deny List by %2.|  
|130|DHCPv6.ScopeDeleted|Scope: %1 for IPv6 is Deleted by %2.|  
|131|DHCPv6.ScopeActivated|Scope: %1 for IPv6 is Activated by %2.|  
|132|DHCPv6.ScopeDeActivated|Scope: %1 for IPv6 is DeActivated by %2.|  
|133|DHCPv6.ScopeLeasePreferredUpdate|Scope: %1 for IPv6 is Updated with Lease Preferred Lifetime:  %2 by %3. The previous configured Lease Preferred Lifetime was: %4.|  
|134|DHCPv6.ScopeLeaseValidUpdate|Scope: %1 for IPv6 is Updated with Lease Valid Lifetime: %2 by %3. The previous configured Lease Valid Lifetime was: %4.|  
|135|DHCPv6.ScopeOptionUpdate|Scope: %1 for IPv6 is Updated with Option Setting: %2 by %3.|  
|136|DHCPv6.ScopeDNSEnable|Scope: %1 for IPv6 is Enabled for DNS Dynamic updates by %2.|  
|137|DHCPv6.ScopeDNSDisable|Scope: %1 for IPv6 is Disabled for DNS Dynamic updates by %2.|  
|138|DHCPv6.ScopeDNSUpdate\_Req\_by\_Client|Scope: %1 for IPv6 is Updated with DNS Settings by %2: to dynamically update DNS AAAA and PTR records on request by the DHCP Clients.|  
|139|DHCPv6.ScopeDNSUpdate\_Always|Scope: %1 for IPv6 is Updated with DNS Settings by %2: to always dynamically update DNS AAAA and PTR records.|  
|140|DHCPv6.ScopeDNSEnable\_Discard|Scope: %1 for IPv6 is Enabled for DNS Settings by %2: to discard DNS AAAA and PTR records when lease is deleted.|  
|141|DHCPv6.ScopeDNSDisable\_Discard|Scope: %1 for IPv6 is Disabled for DNS Settings by %2: to discard DNS AAAA and PTR records when lease is deleted.|  
|142|DHCPv6.ScopeDHCIDEnable|Name Protection setting is Enabled on Scope: %1 for IPv6 by %2.|  
|143|DHCPv6.ScopeDHCIDDisable|Name Protection setting is Disabled on Scope: %1 for IPv6 by %2.|  
|145|DHCPv6.ReservationConfigured|Reservation: %1 for IPv6 is Configured under Scope %2 by %3.|  
|147|DHCPv6.ReservationDeleted|Reservation: %1 for IPv6 is Deleted under Scope %2 by %3.|  
|148|DHCPv6.ReservationDNSEnable|Reservation: %1 for IPv6 under Scope: %2 is Enabled for DNS Dynamic updates by %3.|  
|149|DHCPv6.ReservationDNSDisable|Reservation: %1 for IPv6 under Scope: %2 is Disabled for DNS Dynamic updates by %3.|  
|150|DHCPv6.ReservationDNSUpdate\_Req\_by\_Client|Reservation: %1 for IPv6 under Scope: %2  is Updated with DNS Settings by %3: to dynamically update DNS AAAA and PTR records on request by the DHCP Clients.|  
|151|DHCPv6.ReservationDNSUpdate\_Always|Reservation: %1 for IPv6 under Scope: %2 is Updated with DNS Settings by %3: to always dynamically update DNS AAAA and PTR records.|  
|152|DHCPv6.ReservationDNSEnable\_Discard|Reservation: %1 for IPv6 under Scope: %2 is Enabled for DNS Settings by %3: to discard DNS AAAA and PTR records when lease is deleted.|  
|153|DHCPv6.ReservationDNSDisable\_Discard|Reservation: %1 for IPv6 under Scope: %2 is Disabled for DNS Settings by %3: to discard DNS AAAA and PTR records when lease is deleted.|  
|154|DHCPv6.ReservationOptionUpdate|Reservation: %1 for IPv6 under Scope: %2 is Updated with Option Setting: %3 by %4.|  
|155|DHCPv6.ScopeExclusionAdded|Added exclusion IP Address range %1 in the Address Pool for IPv6 under Scope: %2 by %3.|  
|156|DHCPv6.ScopeExclusionDeleted|Deleted exclusion IP Address range %1 in the Address Pool for IPv6 under Scope: %2 by %3.|  
|157|DHCPv6.ScopeModified|Scope: %1 for IPv6 is Modified by %2.|  
|158|DHCPv6.ScopeStatelessEnabled|DHCPv6 Stateless client inventory has been enabled for the scope %1.|  
|159|DHCPv6.ScopeStatelessDisabled|DHCPv6 Stateless client inventory has been disabled for the scope %1.|  
|160|DHCPv6.ServerStatelessEnabled|DHCPv6 Stateless client inventory has been enabled for the server.|  
|161|DHCPv6.ServerStatelessDisabled|DHCPv6 Stateless client inventory has been disabled for the server.|  
|162|DHCPv6.ScopeStatelessPurgeInterval|Purge time interval for DHCPv6 stateless client inventory for scope %1 has been set to %2 hours.|  
|163|DHCPv6.ServerStatelessPurgeInterval|Purge time interval for DHCPv6 stateless client inventory for server has been set to %1 hours.|  
|165|DHCPv4.ScopeDNSDisable\_DisablePtrUpdates|Scope: %1 for IPv4 is Disabled for DNS Settings by %2: to disable dynamic updates for DNS PTR records.|  
|166|DHCPv6.ServerOptionUpdate|Server level option %1 for IPv6 has been updated by %2.|  
|20220|DHCPv4.UpdateServerPolicyState|Policy %2 for server is %1.|  
|20221|DHCPv4.UpdateScopePolicyState|Policy %2 for scope %3 is %1.|  
|20222|DHCPv4.UpdateServerPolicyExpr|The conditions for server policy %3 have been set to %1. The conditions are grouped by logical operator %2.|  
|20223|DHCPv4.UpdateScopePolicyExpr|The conditions for scope %4 policy %3 have been set to %1. The conditions are grouped by logical operator %2.|  
|20226|DHCPv4.DeleteServerPolicy|Policy %1 was deleted from server.|  
|20227|DHCPv4.DeleteScopePolicy|Policy %1 was deleted from scope %2.|  
|20228|DHCPv4.SetScopePolicyRange|The IP address range from %1 was set for the scope %3 policy %2.|  
|20229|DHCPv4.RemoveScopePolicyRange|The IP address range from %1 was removed from the scope %3 policy %2.|  
|20230|DHCPv4.SetServerPolicyOption|The value %2 was set for the option %1 for the server policy %3.|  
|20231|DHCPv4.SetScopePolicyOption|The value %2 was set for the option %1 for the scope %4 policy %3.|  
|20232|DHCPv4.UnsetServerPolicyOption|The value %2 was removed from the option %1 for the server policy %3.|  
|20233|DHCPv4.UnsetScopePolicyOption|The value %2 was removed from the option %1 for the scope %4 policy %3.|  
|20234|DHCPv4.UpdateServerPolicyName|Server policy %2 has been renamed to %1.|  
|20235|DHCPv4.UpdateScopePolicyName|Scope %3 policy %2 has been renamed to %1.|  
|20236|DHCPv4.UpdateServerPolicyDescription|Description of server policy %2 was set to %1.|  
|20237|DHCPv4.UpdateScopePolicyDescription|Description of scope %3 policy %2 was set to %1.|  
|20238|DHCPv4.UpdateServerPolicyProcOrder|Processing order of server policy %3 was changed to %1 from %2.|  
|20239|DHCPv4.UpdateScopePolicyProcOrder|Processing order of scope %4 policy %3 was changed to %1 from %2.|  
|20241|DHCPv4.CreateFailoverRelationshipHotStandby|A failover relationship has been created between servers %1 and %2 with the following configuration parameters: name: %3, mode: hot standby, maximum client lead time: %4 seconds, reserve address percentage on standby server: %5, auto state switchover interval: %6 seconds, standby server: %7.|  
|20242|DHCPv4.DeleteFailoverRelationship|Failover relationship %1 between %2 and %3 has been deleted.|  
|20243|DHCPv4.AddScopeRelationship|Scope %1 has been added to the failover relationship %2 with server %3.|  
|20244|DHCPv4.DeleteScopeRelationship|Scope %1 has been removed from the failover relationship %2 with server %3.|  
|20245|DHCPv4.UpdateRelationshipParamMclt|The failover configuration parameter MCLT for failover relationship %1 with server %2 has been changed from %3 seconds to %4 seconds.|  
|20246|DHCPv4.UpdateRelationshipParamAutoSwitchOverInterval|The failover configuration parameter auto switch over interval for failover relationship %1 with server %2 has been changed from %3 seconds to %4 seconds.|  
|20247|DHCPv4.UpdateRelationshipParamPercentageHS|The failover configuration parameter reserve address percentage for failover relationship %1 with server %2 has been changed from %3 to %4.|  
|20248|DHCPv4.UpdateRelationshipParamPercentageLB|The failover configuration parameter load balance percentage for failover relationship %1 with server %2 has been changed from %3 to %4 on this server.|  
|20249|DHCPv4.UpdateRelationshipParamModeHStoLB|The failover configuration parameter mode for failover relationship %1 with server %2 has been changed from hot standby to load balance.|  
|20250|DHCPv4.UpdateRelationshipParamModeLBtoHS|The failover configuration parameter mode for failover relationship %1 with server %2 has been changed from load balance to hot standby.|  
|20311|DHCPv4.UpdateSharedSecret|The shared secret for failover relationship %2 with server %1 has been changed.|  
|20312|DHCPv4.EnabledSharedSecret|Message authentication for failover relationship %2 with server %1 has been enabled.|  
|20313|DHCPv4.DisabledSharedSecret|Message authentication for failover relationship %2 with server %1 has been disabled.|  
|20315|DHCPv4.UpdateScopePolicyDNSSuffix|DNSSuffix of scope %3 policy %2 was set to %1.|  
|20316|DHCPv4.UpdateServerPolicyDNSSuffix|DNSSuffix of server policy %2 was set to %1.|  
  
## <a name="admin"></a>DHCP Server Administrative Events  
  
||||  
|-|-|-|  
|**Event ID**|**Event category**|**Event text**|  
|1000|EVENT\_SERVER\_UNKNOWN\_OPTION|The DHCP service received the unknown option %1, with a length of %2. The raw option data is given below.|  
|1001|EVENT\_SERVER\_FAILED\_REGISTER\_SC|The DHCP service failed to register with Service Controller. The following error occurred: %n%1.|  
|1002|EVENT\_SERVER\_INIT\_DATA\_FAILED|The DHCP service failed to initialize its global parameters. The following error occurred: %n%1|  
|1003|EVENT\_SERVER\_INIT\_REGISTRY\_FAILED|The DHCP service failed to initialize its registry parameters. The following error occurred: %n%1|  
|1004|EVENT\_SERVER\_INIT\_DATABASE\_FAILED|The DHCP service failed to initialize the database. The following error occurred: %n%1|  
|1005|EVENT\_SERVER\_INIT\_WINSOCK\_FAILED|The DHCP service failed to initialize Winsock startup. The following error occurred: %n%1|  
|1006|EVENT\_SERVER\_INIT\_RPC\_FAILED|The DHCP service failed to start as a RPC server. The following error occurred : %n%1|  
|1007|EVENT\_SERVER\_INIT\_SOCK\_FAILED|The DHCP service failed to initialize Winsock data. The following error occurred: %n%1|  
|1008|EVENT\_SERVER\_SHUTDOWN|The DHCP service is shutting down due to the following error: %n%1|  
|1009|EVENT\_SERVER\_CLIENT\_CLEANUP|The DHCP service encountered the following error while cleaning up the pending client records: %n%1|  
|1010|EVENT\_SERVER\_DATABASE\_CLEANUP|The DHCP service encountered the following error while cleaning up the database: %n%1|  
|1011|EVENT\_SERVER\_LEASE\_NACK|The DHCP service issued a NACK \(negative acknowledgement message\) to the client, %2, for the address, %1.|  
|1012|EVENT\_SERVER\_LEASE\_DECLINED|The DHCP client, %2, declined the address %1.|  
|1013|EVENT\_SERVER\_LEASE\_RELEASE|The DHCP Client, %2, released the address %1.|  
|1016|EVENT\_SERVER\_DATABASE\_BACKUP|The DHCP service encountered the following error when backing up the database: %n%1|  
|1017|EVENT\_SERVER\_CONFIG\_BACKUP|The DHCP service encountered the following error when backing up the registry configuration: %n%1|  
|1018|EVENT\_SERVER\_DATABASE\_RESTORE\_FAILED|The DHCP service failed to restore the database. The following error occurred: %n%1|  
|1019|EVENT\_SERVER\_CONFIG\_RESTORE\_FAILED|The DHCP service failed to restore the DHCP registry configuration. The following error occurred: %n%1|  
|1020|EVENT\_SERVER\_LOW\_ADDRESS\_WARNING|Scope, %1, is %2 percent full with only %3 IP addresses remaining.|  
|1021|EVENT\_SERVER\_LOAD\_JET\_FAILED|The DHCP service could not load the JET database library successfully.|  
|1022|EVENT\_SERVER\_JET\_CONV\_REQUIRED|The DHCP service could not use the database. If this service was started for the first time after the upgrade from NT 3.51 or earlier, you need to run the utility, upg351db.exe, on the DHCP database to convert it to the new JET database format. Restart the DHCP service after you have upgraded the database.|  
|1023|EVENT\_SERVER\_JET\_CONV\_IN\_PROGRESS|The DHCP service will now terminate because the existing database needs conversion to Windows 2000 format.  The conversion via the jetconv process, has initiated.  Do not reboot or stop the jetconv process.  The conversion may take up to 10 minutes depending on the size of the database.  Terminate DHCP now by clicking OK. This is required for the database conversion to succeed.  NOTE: The DHCP service will be restarted automatically when the conversion is completed.  To check conversion status, look at the Application event log for the jetconv process.|  
|1024|EVENT\_SERVER\_INIT\_AND\_READY|The DHCP service has initialized and is ready|  
|1025|EVENT\_SERVER\_BOOT\_FILE\_TABLE|The DHCP service was unable to read the BOOTP file table from the registry.  The DHCP service will be unable to respond to BOOTP requests that specify the boot file name.|  
|1026|EVENT\_SERVER\_BOOT\_FILE\_NAME|The DHCP service was unable to read the global BOOTP file name from the registry.|  
|1027|EVENT\_SERVER\_AUDIT\_LOG\_APPEND\_FAILED|The audit log file cannot be appended.|  
|1028|EVENT\_SERVER\_INIT\_AUDIT\_LOG\_FAILED|The DHCP service failed to initialize the audit log. The following error occurred: %n%1|  
|1029|EVENT\_SERVER\_PING\_FAILED|The DHCP service was unable to ping for a new IP address. The address was leased to the client.|  
|1030|EVENT\_SERVER\_MOVE\_AUDIT\_LOG\_FAILED|The audit log file could not be backed up.  The following error occurred: %n%1|  
|1031|EVENT\_SERVER\_CALLOUT\_UNHANDLED\_EXCEPTION|The installed server callout .dll file has caused an exception. The exception was: %n%1.  The server has ignored this exception. All further exceptions will be ignored.|  
|1032|EVENT\_SERVER\_CALLOUT\_LOAD\_EXCEPTION|The installed server callout .dll file has caused an exception. The exception was: %n%1.  The server has ignored this exception and the .dll file could not be loaded.|  
|1033|EVENT\_SERVER\_CALLOUT\_LOAD\_SUCCESS|The DHCP service has successfully loaded one or more callout DLLs.|  
|1034|EVENT\_SERVER\_READ\_ONLY\_GROUP\_ERROR|The DHCP service has failed to load one or more callout DLLs. The following error occured: %n%1|  
|1035|EVENT\_SERVER\_READ\_ONLY\_GROUP\_ERROR|The DHCP service was unable to create or lookup the DHCP Users local group on this computer.  The error code is in the data.|  
|1036|EVENT\_SERVER\_ADMIN\_GROUP\_ERROR|The DHCP server was unable to create or lookup the DHCP Administrators local group on this computer.  The error code is in the data.|  
|1037|EVENT\_SERVER\_CLEANUP\_STARTED|The DHCP service has started to clean up the database.|  
|1038|EVENT\_SERVER\_IPCLEANUP\_FINISHED|The DHCP service has cleaned up the database for unicast IP addresses \-\- %1 leases have been recovered and %2 records have been removed from the database.|  
|1039|EVENT\_SERVER\_MCASTCLEANUP\_FINISHED|The DHCP service has cleaned up the database for multicast IP addresses \-\- %1 leases have expired \(been marked for deletion\) and %2 records have been removed from the database.|  
|1040|EVENT\_SERVER\_DATABASE\_RESTORE\_SUCCEEDED|The DHCP service successfully restored the database.|  
|1041|DHCP\_ROGUE\_EVENT\_NO\_NETWORK|The DHCP service is not servicing any DHCPv4 clients because none of the active network interfaces have statically configured IPv4 addresses, or there are no active interfaces.|  
|1042|DHCP\_ROGUE\_EVENT\_UNAUTHORIZED\_INFO|The DHCP\/BINL service running on this machine has detected a server on the network. If the server does not belong to any domain, the domain is listed as empty.  The IP address of the server is listed in parentheses.  %1|  
|1043|DHCP\_ROGUE\_EVENT\_STARTED|The DHCP\/BINL service on the local machine has determined that it is authorized to start.  It is servicing clients now.|  
|1044|DHCP\_ROGUE\_EVENT\_STARTED\_DOMAIN|The DHCP\/BINL service on the local machine, belonging to the Windows Administrative domain %2, has determined that it is authorized to start. It is servicing clients now.|  
|1045|DHCP\_ROGUE\_EVENT\_STOPPED|The DHCP\/BINL service on the local machine has determined that it is not authorized to start.  It has stopped servicing clients.  The following are some possible reasons for this: %n%tThis machine belongs to a workgroup and has encountered another DHCP Server \(belonging to a Windows Administrative Domain\) servicing the same network. %n%n%tAn unexpected network error occurred.|  
|1046|DHCP\_ROGUE\_EVENT\_STOPPED\_DOMAIN|The DHCP\/BINL service on the local machine, belonging to the Windows Administrative domain %2, has determined that it is not authorized to start.  It has stopped servicing clients.  The following are some possible reasons for this: %n%tThis machine is part of a directory service enterprise and is not authorized in the same domain.  \(See help on the DHCP Service Management Tool for additional information\). %n%n%tThis machine cannot reach its directory service enterprise and it has encountered another DHCP service on the network belonging to a directory service enterprise on which the local machine is not authorized. %n%n%tSome unexpected network error occurred.|  
|1047|DHCP\_ROGUE\_EVENT\_JUST\_UPGRADED|The DHCP\/BINL service on the local machine has determined that it is authorized to start.  It is servicing clients now. %nThe DHCP\/BINL service has determined that the machine was recently upgraded.  If the machine is intended to belong to a directory service enterprise, the DHCP service must be authorized in the directory service for it to start servicing clients.  \(See help on DHCP Service Management Tool for authorizing the server\).|  
|1048|DHCP\_ROGUE\_EVENT\_JUST\_UPGRADED\_DOMAIN|The DHCP\/BINL Service on the local machine, belonging to Windows Domain %2, has determined that it is authorized to start.  It is servicing clients now.  It has determined that the computer was recently upgraded.  It has also determined that either there is no directory service enterprise for the domain or that the computer is not authorized in the directory service.  All DHCP services that belong to a directory service enterprise should be authorized in the directory service to service clients.   \(See help on the DHCP Service Management Tool for authorizing a DHCP service in the directory service\).|  
|1049|DHCP\_ROGUE\_EVENT\_CANT\_FIND\_DOMAIN|The DHCP\/BINL service on the local machine encountered an error while trying to find the domain of the local machine.  The error was: %3.|  
|1050|DHCP\_ROGUE\_EVENT\_NETWORK\_FAILURE|The DHCP\/BINL service on the local machine encountered a network error. The error was: %3.|  
|1051|DHCP\_ROGUE\_EVENT\_UNAUTHORIZED|The DHCP\/BINL service has determined that it is not authorized to service clients on this network for the Windows domain: %2.  All DHCP services that belong to a directory service enterprise must be authorized in the directory service to service clients.   \(See help on the DHCP Service Management Tool for authorizing a DHCP server in the directory service\).|  
|1052|DHCP\_ROGUE\_EVENT\_OTHER\_SERVER|The DHCP\/BINL service on this workgroup server has encountered another server with IP Address, %1, belonging to the domain %2.|  
|1053|DHCP\_ROGUE\_EVENT\_SAM\_OTHER\_SERVER|The DHCP\/BINL service has encountered another server on this network with IP Address, %1, belonging to the domain: %2.|  
|1054|DHCP\_ROGUE\_EVENT\_SHUTDOWN|The DHCP\/BINL service on this computer is shutting down. See the previous event log messages for reasons.|  
|1055|DHCP\_EVENT\_DNS\_REGPARAMS\_FAILURE|The DHCP service was unable to impersonate the credentials necessary for DNS registrations: %n%1.  The local system credentials is being used.|  
|1056|DHCP\_EVENT\_NO\_DNSCREDENTIALS\_ON\_DC|The DHCP service has detected that it is running on a DC and has no credentials configured for use with Dynamic DNS registrations initiated by the DHCP service.   This is not a recommended security configuration.  Credentials for Dynamic DNS registrations may be configured using the command line &quot;netsh dhcp server set dnscredentials&quot; or via the DHCP Administrative tool.|  
|1057|EVENT\_SERVER\_DATABASE\_CONVERSION|The DHCP service was unable to convert the temporary database to ESE format: %n%1.|  
|1058|EVENT\_SERVER\_INIT\_CONFIG\_FAILED|The DHCP service failed to initialize its configuration parameters. The following error occurred: %n%1|  
|1059|VENT\_SERVER\_COULDNT\_SEE\_DS|The DHCP service failed to see a directory server for authorization.|  
|1060|EVENT\_SERVER\_AUDITLOG\_PATH\_NOT\_ACCESSIBLE|The DHCP service was unable to access path specified for the audit log.|  
|1061|EVENT\_SERVER\_BACKUP\_PATH\_NOT\_ACCESSIBLE|The DHCP service was unable to access path specified for the database backups.|  
|1062|EVENT\_SERVER\_DB\_PATH\_NOT\_ACCESSIBLE|The DHCP service was unable to access path specified for the database|  
|1063|EVENT\_SERVER\_SCOPE\_FULL|There are no IP addresses available for lease in the scope or superscope &quot;%1&quot;.|  
|1064|EVENT\_SERVER\_BOOTP\_FULL|There are no IP addresses available for BOOTP clients in the scope or superscope &quot;%1&quot;.|  
|1065|EVENT\_SERVER\_ORPHONED\_ENTRIES\_DELETED|There were some orphaned entries deleted in the configuration due to the deletion of a class or an option definition. Please recheck the server configuration.|  
|1144|EVENT\_SERVER\_NEED\_STATIC\_IP|This computer has at least one dynamically assigned IP address. For reliable DHCP Server operation, you should use only static IP addresses.|  
|1338|EVENT\_SERVER\_OFFER\_QUEUE\_FULL|The number of pending DHCPOFFER messages for delayed transmission to the client has exceeded the server&apos;s capacity of 1000 pending messages. The DHCP server will drop all subsequent DHCPDISCOVER messages for which the DHCPOFFER message response needs to be delayed as per the server configuration. The DHCP server will continue to process DHCPDISCOVER messages for which the DHCPOFFER message responses do not need to be delayed. The DHCP server will resume processing all DHCPDISCOVER messages once the number of pending DHCPOFFER messages for delayed transmission to the client is below the server&apos;s capacity.|  
|1339|EVENT\_SERVER\_OFFER\_QUEUE\_FUNCTIONAL|The number pending DHCPOFFER messages for delayed transmission to the client is now below the server&apos;s capacity of 1000. The DHCP server will now resume processing all DHCPDISCOVER messages.|  
|1340|EVENT\_SERVER\_DNSDHCID\_FAIL|The DNS registration for DHCPv4 Client IP address %1 , FQDN %2 and DHCID %3 has been denied as there is probably an existing client with same FQDN already registered with DNS.|  
|1341|EVENT\_SERVER\_POLICY\_RANGES\_FULL|There are no IP addresses available for lease in IP address range\(s\) of the policy %1 in scope %2.|  
|1342|EVENT\_SERVER\_RESIDUAL\_RANGES\_FULL|IP address range of scope %1 is out of IP addresses.|  
|1343|EVENT\_SERVER\_POLICY\_RANGES\_LOW\_ADDRESS\_WARNING|Ip address range\(s\) for the scope %1 policy %2 is %3 percent full with only %4 IP addresses available .|  
|1344|EVENT\_SERVER\_DNS\_VALIDATION\_FAILED|The DNS IP Address %1 is not a valid DNS Server Address.|  
|1376|EVENT\_SERVER\_RESIDUAL\_RANGES\_LOW\_ADDRESS\_WARNING|IP address range of scope %1 is %2 percent full with only %3 IP addresses available.|  
|1377|EVENT\_SERVER\_SUPERSCOPE\_LOW\_ADDRESS\_WARNING|SuperScope, %1, is %2 percent full with only %3 IP addresses remaining. This superscope has the following scopes %4|  
|10000|EVENT\_DHCPV6\_ADDERESS\_NACKED|DHCPv6 confirmation has been declined because the address was not appropriate to the link or DHCPv6 renew request has a Zero lifetime for Client Address %1.|  
|10001|EVENT\_DHCPV6\_REQUEST\_RECEIVED\_FOR\_ADDRESSES\_NOT\_LEASED|Renew, rebind or confirm received for IPv6 addresses %1 for which there are no active lease available.|  
|10002|EVENT\_DHCPV6\_SERVER\_UNKNOWN\_OPTION|DHCPv6 service received the unknown option %1, with a length of %2. The raw option data is given below.|  
|10003|EVENT\_DHCPV6\_SERVER\_SCOPE\_FULL|There are no IPv6 addresses available to lease in the scope serving the network with Prefix %1.|  
|10004|EVENT\_DHCPV6\_SERVER\_LEASE\_DECLINED|The DHCPv6 client, %2, declined the address %1.|  
|10005|EVENT\_DHCPV6\_SERVER\_LOW\_ADDRESS\_WARNING|DHCPv6 Scope serving the network with prefix %1, is %2 percent full with only %3 IP addresses remaining.|  
|10006|EVENT\_DHCPV6\_CLIENT\_DELETE|A DHCPV6 client %1 has been deleted from DHCPV6 database.|  
|10007|EVENT\_DHCPV6\_DROP\_TIMEOUT|A DHCPV6 message that was in the queue for more than 30 seconds has been dropped because it is too old to process.|  
|10008|EVENT\_DHCPV6\_DROP\_INVALID|An invalid DHCPV6 message has been dropped.|  
|10009|EVENT\_DHCPV6\_DROP\_WRONG\_SERVER|A DHCPV6 message that was not meant for this server has been dropped.|  
|10010|EVENT\_DHCPV6\_DROP\_UNICAST|DHCV6 message has been dropped because it was received on a Uni\-cast address and unicast support is disabled on the server.|  
|10011|EVENT\_DHCPV6\_SERVER\_AUDIT\_LOG\_APPEND\_FAILED|DHCPV6 audit log file cannot be appended, Error Code returned %1.|  
|10012|EVENT\_DHCPV6\_DROP\_UNAUTH|A DHCPV6 message has been dropped because the server is not authorized to process the message.|  
|10013|EVENT\_DHCPv6\_SERVER\_INIT\_AUDIT\_LOG\_FAILED|The DHCPv6 service failed to initialize the audit log. The following error occurred: %n%1|  
|10014|EVENT\_DHCPV6\_SERVER\_MOVE\_AUDIT\_LOG\_FAILED|DHCPv6 audit log file could not be backed up.  Error code %1|  
|10015|EVENT\_DHCPV6\_SERVER\_AUDITLOG\_PATH\_NOT\_ACCESSIBLE|The DHCPv6 service was unable to access path specified for the audit log.|  
|10016|EVENT\_DHCPV6\_SERVER\_INIT\_WINSOCK\_FAILED|The DHCPv6 service failed to initialize Winsock startup. The following error occurred %1.|  
|10017|EVENT\_DHCPV6\_NO\_DNSCREDENTIALS\_ON\_DC|The DHCPv6 service has detected that it is running on a DC and has no credentials configured for use with Dynamic DNS registrations initiated by the DHCPv6 service.   This is not a recommended security configuration.|  
|10018|EVENT\_DHCPV6\_SERVER\_INTERFACE\_NOTIFICATION|The DHCPv6 Server failed to receive a notification of interface list changes.  Some of the interfaces will not be enabled in the DHCPv6 service.|  
|10019|EVENT\_DHCPV6\_SERVER\_INIT\_CONFIG\_FAILED|The DHCPv6 service failed to initialize its configuration parameters. The following error occurred: %n%1.|  
|10020|EVENT\_DHCPV6\_SERVER\_NEED\_STATIC\_IP|This computer has at least one dynamically assigned IPv6 address. For reliable DHCPv6 server operation, you should use only static IPv6 addresses.|  
|10021|EVENT\_DHCPV6\_SERVER\_INIT\_DATABASE\_FAILED|DHCPv6 service failed to initialize the database. The following error occurred: %n%1.|  
|10022|EVENT\_DHCPV6\_SERVER\_INIT\_AND\_READY|The DHCPv6 service has initialized and is ready to serve.|  
|10023|EVENT\_DHCPV6\_PORT\_UNAVAILABLE|DHCPv6 Server is unable to bind to UDP port number %1 as it is used by another application. This port must be made available to DHCPv6 Server to start servicing the clients.|  
|10024|ERROR\_LAST\_DHCPV6\_SERVER\_ERROR|ERROR\_LAST\_DHCPV6\_SERVER\_ERROR|  
|10025|EVENT\_DHCPV6\_DNSDHCID\_FAIL|The DNS registration for DHCPv6 Client IPv6 address %1, FQDN %2 and DHCID %3 has been denied as there is probably an existing client with same FQDN already registered with DNS.|  
|20090|EVENT\_DHCP\_PORT\_UNAVAILABLE|DHCP Server is unable to bind to UDP port number %1 as it is used by another application. This port must be made available to DHCP Server to start servicing the clients.|  
|20098|EVENT\_FILTER\_EMPTY\_ALLOW\_LIST|No DHCP clients are being served,  as the Allow list is empty and the server was configured to provide DHCP services, to clients whose hardware addresses are present in the Allow List.|  
|20251|DHCPv4.ChangeFailoverRelationState|The failover state of server: %1 for failover relationship: %2 changed from: %3 to %4.|  
|20252|DHCPv4.ChangeFailoverRelationStateError|The failover state of server: %1 for failover relationship: %2 changed from: %3 to %4.|  
|20253|DHCPv4.FailoverServerTimeSync|The server detected that it is out of time synchronization with partner server: %1 for failover relationship: %2.  The time is out of sync by: %3 seconds .|  
|20254|DHCPv4.FailoverCommUp|Server has established contact with failover partner server %1 for relationship %2 .|  
|20255|DHCPv4.FailoverCommDown|Server has lost contact with failover partner server  %1 for relationship %2 .|  
|20256|DHCPv4.AuthFailedBndUpdMsgDigestFailedToCompare|Failover protocol message BINDING\-UPDATE from server %1 for failover relationship %2 was rejected because message digest failed to compare.|  
|20257|DHCPv4.AuthFailedBndUpdMsgDigestNotConfigured|Failover protocol message  BINDING\-UPDATE from server %1 for failover relationship %2 was rejected because message digest was not configured.|  
|20258|DHCPv4.AuthFailedBndUpdMsgDigestNotPresent|Failover protocol message  BINDING\-UPDATE from server %1 for failover relationship %2 is rejected because message digest was not present.|  
|20259|DHCPv4.ChangeFailoverRelationStateNoPrevState|The failover state of server: %1 for failover relationship: %2 changed to : %3.|  
|20260|DHCPv4.ChangeFailoverRelationStateErrorNoPrevState|The failover state of server: %1 for failover relationship: %2 changed to: %3.|  
|20261|DHCPv4.AuthFailedBndAckMsgDigestFailedToCompare|Failover protocol message BINDING\-ACK from server %1 for failover relationship %2 was rejected because message digest failed to compare.|  
|20262|DHCPv4.AuthFailedBndAckMsgDigestNotConfigured|Failover protocol message  BINDING\-ACK from server %1 for failover relationship %2 was rejected because message digest was not configured.|  
|20263|DHCPv4.AuthFailedBndAckMsgDigestNotPresent|Failover protocol message  BINDING\-ACK from server %1 for failover relationship %2 is rejected because message digest was not present.|  
|20264|DHCPv4.AuthFailedConnectMsgDigestFailedToCompare|Failover protocol message CONNECT from server %1 for failover relationship %2 was rejected because message digest failed to compare.|  
|20265|DHCPv4.AuthFailedConnectMsgDigestNotConfigured|Failover protocol message  CONNECT from server %1 for failover relationship %2 was rejected because message digest was not configured.|  
|20266|DHCPv4.AuthFailedConnectMsgDigestNotPresent|Failover protocol message  CONNECT from server %1 for failover relationship %2 is rejected because message digest was not present.|  
|20267|DHCPv4.AuthFailedConnectAckMsgDigestFailedToCompare|Failover protocol message CONNECTACK from server %1 for failover relationship %2 was rejected because message digest failed to compare.|  
|20268|DHCPv4.AuthFailedConnectAckMsgDigestNotConfigured|Failover protocol message  CONNECTACK from server %1 for failover relationship %2 was rejected because message digest was not configured.|  
|20269|DHCPv4.AuthFailedConnectAckMsgDigestNotPresent|Failover protocol message  CONNECTACK from server %1 for failover relationship %2 is rejected because message digest was not present.|  
|20270|DHCPv4.AuthFailedUpdReqAllMsgDigestFailedToCompare|Failover protocol message UPDREQALL from server %1 for failover relationship %2 was rejected because message digest failed to compare.|  
|20271|DHCPv4.AuthFailedUpdReqAllMsgDigestNotConfigured|Failover protocol message  UPDREQALL from server %1 for failover relationship %2 was rejected because message digest was not configured.|  
|20272|DHCPv4.AuthFailedUpdReqAllMsgDigestNotPresent|Failover protocol message  UPDREQALL from server %1 for failover relationship %2 is rejected because message digest was not present.|  
|20273|DHCPv4.AuthFailedUpdDoneMsgDigestFailedToCompare|Failover protocol message UPDDONE from server %1 for failover relationship %2 was rejected because message digest failed to compare.|  
|20274|DHCPv4.AuthFailedUpdDoneMsgDigestNotConfigured|Failover protocol message  UPDDONE from server %1 for failover relationship %2 was rejected because message digest was not configured.|  
|20275|DHCPv4.AuthFailedUpdDoneMsgDigestNotPresent|Failover protocol message  UPDDONE from server %1 for failover relationship %2 is rejected because message digest was not present.|  
|20276|DHCPv4.AuthFailedUpdReqMsgDigestFailedToCompare|Failover protocol message UPDREQ from server %1 for failover relationship %2 was rejected because message digest failed to compare.|  
|20277|DHCPv4.AuthFailedUpdReqMsgDigestNotConfigured|Failover protocol message  UPDREQ from server %1 for failover relationship %2 was rejected because message digest was not configured.|  
|20278|DHCPv4.AuthFailedUpdReqMsgDigestNotPresent|Failover protocol message  UPDREQ from server %1 for failover relationship %2 is rejected because message digest was not present.|  
|20279|DHCPv4.AuthFailedStateMsgDigestFailedToCompare|Failover protocol message STATE from server %1 for failover relationship %2 was rejected because message digest failed to compare.|  
|20280|DHCPv4.AuthFailedStateMsgDigestNotConfigured|Failover protocol message  STATE from server %1 for failover relationship %2 was rejected because message digest was not configured.|  
|20281|DHCPv4.AuthFailedStateMsgDigestNotPresent|Failover protocol message  STATE from server %1 for failover relationship %2 is rejected because message digest was not present.|  
|20282|DHCPv4.AuthFailedContactMsgDigestFailedToCompare|Failover protocol message CONTACT from server %1 for failover relationship %2 was rejected because message digest failed to compare.|  
|20283|DHCPv4.AuthFailedContactMsgDigestNotConfigured|Failover protocol message  CONTACT from server %1 for failover relationship %2 was rejected because message digest was not configured.|  
|20284|DHCPv4.AuthFailedContactMsgDigestNotPresent|Failover protocol message  CONTACT from server %1 for failover relationship %2 is rejected because message digest was not present.|  
|20285|DHCPv4.InvalidAlgorithmProvider|An invalid cryptographic algorithm %1 was specified for failover message authentication in FailoverCryptoAlgorithm under registry key HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\DHCPServer\\Parameters\\Failover. The operation is halted.|  
|20286|DHCPv4.FailoverClientLeaseDropped|BINDING UPDATE message for IP address %1 could not be replicated to the partner server %2 of failover relation %3 as the internal BINDING UPDATE queue is full.|  
|20287|DHCPv4.ClientRequestDropped|DHCP client request from %1 was dropped since the applicable IP address ranges in scope\/superscope %2 are out of available IP addresses. This could be because of IP address ranges of a policy being out of available IP addresses.|  
|20291|DHCPv4.SendBndAckMessageRejectReason|A BINDING\-ACK message with transaction id: %1 was sent for IP address: %2 with reject reason: \(%3\) to partner server: %4 for failover relationship: %5.|  
|20292|DHCPv4.RecvBndAckMessageRejectReason|A BINDING\-ACK message with transaction id: %1 was received for IP address: %2 with reject reason:  \(%3 \) from partner server: %4 for failover relationship: %5.|  
  
## <a name="sys"></a>DHCP Server System Events  
  
||||  
|-|-|-|  
|**Event ID**|**Event category**|**Event text**|  
|20035|EVENT\_SERVER\_INTERFACE\_NOTIFICATION|%1 %3|  
|20058|DHCPv4HA.BndUpd|%1 %3|  
|20059|DHCPv4HA.BndAck|%1 %3|  
|20060|DHCPv4HA.Connect|%1 %3|  
|20061|DHCPv4HA.ConnectAck|%1 %3|  
|20062|DHCPv4HA.UpdReqAll|%1 %3|  
|20063|DHCPv4HA.UpdDone|%1 %3|  
|20064|DHCPv4HA.UpdReq|%1 %3|  
|20065|DHCPv4HA.State|%1 %3|  
|20066|DHCPv4HA.Contact|%1 %3|  
|20067|DHCPv4HA.Disconnect|%1 %3|  
|20068|DHCPv4HA.ScavengerStart|Scavenger started.|  
|20069|DHCPv4HA.ScavengerEnd|Scavenger ended.|  
|20161|DHCPv4HA.AddrAllocationTriggered|Address allocation triggered for the failover relationship %1.|  
|20163|DHCPv4Stateless.ScavengerEnd|Scavenger finished purging stateless entries.|  
|20164|DHCPv4HA.TotalLeasesDeleted|The total leases deleted in scavenger are %1|  
|20165|DHCPv4HA.FailoverScopeDeleted|Scope %1 which was part of failover relationship %2 was not found in DHCP server database. Please restore the DHCP server database.|  
  
## <a name="filter"></a>DHCP Server Filter Notification Events  
  
||||  
|-|-|-|  
|**Event ID**|**Event category**|**Event text**|  
|20096|EVENT\_FILTER\_DENIED\_IN\_DENY\_LIST|DHCP Services were denied to machine with hardware address %1, hardware type %4 and FQDN\/Hostname %2 because it matched entry %3 in the Deny List.|  
|20097|EVENT\_FILTER\_DENIED\_NOT\_IN\_ALLOW\_LIST|DHCP Services were denied to machine with hardware address %1, hardware type %3 and FQDN\/Hostname %2 because it did not match any entry in the Allow List.|  
|20099|EVENT\_FILTER\_DENIED\_IN\_DENY\_LIST\_UNSPECIFIED|DHCP Services were denied to machine with hardware address %1, hardware type %4 and unspecified FQDN\/Hostname%2 because it matched entry %3 in the Deny List.|  
|20100|EVENT\_FILTER\_DENIED\_NOT\_IN\_ALLOW\_LIST\_UNSPECIFIED|DHCP Services were denied to machine with hardware address %1, hardware type %3 and unspecified FQDN\/Hostname%2 because it did not match any entry in the Allow List.|  
  
## <a name="audit"></a>DHCP Server Audit Events  
  
||||  
|-|-|-|  
|**Event ID**|**Event category**|**Event text**|  
|20289|DHCPv4.SendBndUpdMessage|A BINDING\-UPDATE message with transaction id: %1 was sent for IP address: %2 with binding status: %3 to partner server: %4 for failover relationship: %5.|  
|20290|DHCPv4.RecvBndUpdMessage|A BINDING\-UPDATE message with transaction id: %1 was received for IP address: %2 with binding status: %3 from partner server: %4 for failover relationship: %5.|  
|20293|DHCPv4.SendUpdReqMessage|A UPDREQ message with transaction id: %1 was sent to partner server: %2 for failover relationship: %3.|  
|20294|DHCPv4.RecvUpdReqMessage|A UPDREQ message with transaction id: %1 was received from partner server: %2 for failover relationship: %3|  
|20295|DHCPv4.SendUpdDoneMessage|A UPDDONE message with transaction id: %1 was sent to partner server: %2 for failover relationship: %3.|  
|20296|DHCPv4.RecvUpdDoneMessage|A UPDDONE message with transaction id: %1 was received from partner server: %2 for failover relationship: %3.|  
|20297|DHCPv4.SendUpdReqAllMessage|A UPDREQALL message with transaction id: %1 was sent to partner server: %2 for failover relationship: %3|  
|20298|DHCPv4.RecvUpdReqAllMessage|A UPDREQALL message with transaction id: %1 was received from partner server: %2 for failover relationship: %3|  
|20299|DHCPv4.SendContactMessage|A CONTACT message with transaction id: %1 was sent to partner server: %2 for failover relationship: %3.|  
|20300|DHCPv4.RecvContactMessage|A CONTACT message with transaction id: %1 was received from partner server: %2 for failover relationship: %3.|  
|20301|DHCPv4.SendConnectMessage|A CONNECT message with transaction id: %1 was sent to partner server: %2 for failover relationship: %3.|  
|20302|DHCPv4.RecvConnectMessage|A CONNECT message with transaction id: %1 was received from partner server: %2 for failover relationship: %3.|  
|20303|DHCPv4.SendStateMessage|A STATE message with transaction id: %1 was sent to partner server : %2 for failover relationship %3 with state: %4 and start time of state: %5.|  
|20304|DHCPv4.RecvStateMessage|A STATE message with transaction id: %1 was received from partner server : %2 for failover relationship %3 with state: %4 and start time of state %5.|  
|20305|DHCPv4.SendConnectAckMessage|A CONNECTACK message with transaction id %1 was sent to partner server : %2  for failover relationship: %3.|  
|20306|DHCPv4.RecvConnectAckMessage|A CONNECTACK message with transaction id %1 was received from partner server : %2  for failover relationship: %3.|  
|20307|DHCPv4.SendBndAckMessageNoRejectReason|A BINDING\-ACK message with transaction id: %1 was sent for IP address: %2  to partner server: %3 for failover relationship: %4.|  
|20308|DHCPv4.RecvBndAckMessageNoRejectReason|A BINDING\-ACK message with transaction id: %1 was received for IP address: %2 from partner server: %3 for failover relationship: %4.|  
|20309|DHCPv4.SendConnectAckMessageRejectReason|A CONNECTACK message with transaction id %1 was sent to partner server : %2  for failover relationship: %3 with reject reason: %4.|  
|20310|DHCPv4.RecvConnectAckMessageRejectReason|A CONNECTACK message with transaction id %1 was received from partner server : %2  for failover relationship: %3 with reject reason: %4.|  
  
## See also  
[DHCP Diagnostics](../Topic/DHCP-Diagnostics.md)  
  
[DHCP Overview \[blue\]](../Topic/DHCP-Overview.md)  
  
