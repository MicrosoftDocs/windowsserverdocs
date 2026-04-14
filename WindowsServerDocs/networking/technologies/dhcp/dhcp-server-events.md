---
title: DHCP server events in Windows Server
description: View a summary of DHCP server events for operational, administrative, system, filter, and audit events.
ms.topic: troubleshooting-general
author: robinharwood
ms.author: roharwoo
ms.date: 03/12/2025
---

# DHCP server events

DHCP server logs events for all changes that are made. In this article, learn where to view DHCP server events, and see the ID, category, and text for each event.

## View DHCP server event logs

DHCP audit logs are enabled by default, and don't significantly affect DNS server performance. To view DHCP Server event logs:

1. Select the Start button, type Event viewer, open Event viewer from the best match list.

1. In Event Viewer, navigate to **Applications and Services Logs** > **Microsoft** > **Windows** > **DHCP-Server**.

1. Depending on the kind of issue, an event is logged to one of the following event channels:

- [DHCP Server Operational Events](#dhcp-server-operational-events)
- [DHCP Server Administrative Events](#dhcp-server-administrative-events)
- [DHCP Server System Events](#dhcp-server-system-events)
- [DHCP Server Filter Notification Events](#dhcp-server-filter-notification-events)
- [DHCP Server Audit Events](#dhcp-server-audit-events)

## DHCP server operational events

DHCP server operational events log information about the server's operation. Whenever a scope is changed, an event is added.

<br />
<details>
    <summary>To view all server operational events, expand this section.</summary>

| Event ID | Event category | Event text |
|----------|----------------|------------|
| 70       | DHCPv4.ScopeConfigured | Scope: %1 for IPv4 is Configured by %2. |
| 71       | DHCPv4.ScopeModified | Scope: %1 for IPv4 is Modified by %2. |
| 72       | DHCPv4.ScopeDeleted | Scope: %1 for IPv4 is Deleted by %2. |
| 73       | DHCPv4.ScopeActivated | Scope: %1 for IPv4 is Activated by %2. |
| 74       | DHCPv4.ScopeDeActivated | Scope: %1 for IPv4 is Deactivated by %2. |
| 75       | DHCPv4.ScopeLeaseUpdate | Scope: %1 for IPv4 is Updated with Lease Duration: %2 seconds by %3. The previous configured Lease Duration was: %4 seconds. |
| 76       | DHCPv4.ScopeOptionUpdate | Scope: %1 for IPv4 is Updated with Option Settings: %2 by %3 |
| 77       | DHCPv4.ScopeDNSEnable | Scope: %1 for IPv4 is Enabled for DNS Dynamic updates by %2. |
| 78       | DHCPv4.ScopeDNSDisable | Scope: %1 for IPv4 is Disabled for DNS Dynamic updates by %2. |
| 79       | DHCPv4.ScopeDNSUpdate_Req_by_Client | Scope: %1 for IPv4 is Updated with DNS Settings by %2: to dynamically update DNS A and PTR records on request by the DHCP Clients. |
| 80       | DHCPv4.ScopeDNSUpdate_Always | Scope: %1 for IPv4 is Updated with DNS Settings by %2: to always dynamically update DNS A and PTR records. |
| 81       | DHCPv4.ScopeDNSEnable_Discard | Scope: %1 for IPv4 is Enabled for DNS Settings by %2: to discard DNS A and PTR records when lease is deleted. |
| 82       | DHCPv4.ScopeDNSDisable_Discard | Scope: %1 for IPv4 is Disabled for DNS Settings by %2: to discard DNS A and PTR records when lease is deleted. |
| 83       | DHCPv4.ScopeDNSEnable_Update_Client_NoReq | Scope: %1 for IPv4 is Enabled for DNS Settings by %2: to dynamically update DNS A and PTR records for DHCP Clients that don't request updates. |
| 84       | DHCPv4.ScopeDNSDisable_Update_Client_NoReq | Scope: %1 for IPv4 is Disabled for DNS Settings by %2: to dynamically update DNS A and PTR records for DHCP Clients that don't request updates. |
| 85       | DHCPv4.ScopePBA_DeActivated | Policy based assignment has been disabled for scope %1. |
| 86       | DHCPv4.ScopePBA_Activated | Policy based assignment has been enabled for scope %1. |
| 87       | DHCPv4.ScopeDHCIDEnable | Name Protection setting is Enabled on Scope: %1 for IPv4 by %2. |
| 88       | DHCPv4.ScopeDHCIDDisable | Name Protection setting is Disabled on Scope: %1 for IPv4 by %2. |
| 89       | DHCPv4.ScopeSupportType | Scope: %1 for IPv4 is Updated with support type: %2 by %3. The previous configured state was: %4. |
| 90       | DHCPv4.ScopeNAPEnabled | NAP Enforcement is Enabled on Scope: %1 for IPv4 by %2. |
| 91       | DHCPv4.ScopeNAPDisabled | NAP Enforcement is Disabled on Scope: %1 for IPv4 by %2. |
| 92       | DHCPv4.ScopeNAPProfileConfigured | NAP Profile is configured on Scope: %1 for IPv4 with the following NAP Profile: %2 by %3. |
| 93       | DHCPv4.ScopeNAPProfileModified | NAP Profile is Updated on Scope: %1 for IPv4 with the following NAP Profile: %2 by %3. The previous configured NAP Profile was: %4. |
| 94       | DHCPv4.ScopeNAPProfileDeleted | The following NAP Profile: %1 is deleted on Scope: %2 by %3. |
| 95       | DHCPv4.MulticastScopeConfigured | Scope: %1 for Multicast IPv4 is Configured by %2. |
| 96       | DHCPv4.MulticastScopeDeleted | Scope: %1 for Multicast IPv4 is Deleted by %2. |
| 98       | DHCPv4.SuperScopeConfigured | SuperScope: %1 for IPv4 is Configured by %2. |
| 99       | DHCPv4.SuperScopeDeleted | SuperScope: %1 for IPv4 is Deleted by %2. |
| 100      | DHCPv4.SuperScopeActivated | Scope: %1 within SuperScope: %2 for IPv4 is Activated by %3. |
| 101      | DHCPv4.SuperScopeDeActivated | Scope: %1 within SuperScope: %2 for IPv4 is DeActivated by %3. |
| 102      | DHCPv4.SuperScopeDeleteTemp | Scope: %1 for IPv4 is Removed in Superscope: %2 by %3. However, the Scope exists outside the Superscope. |
| 103      | DHCPv4.SuperScopeDeletePerm | Scope: %1 for IPv4 is Deleted in Superscope: %2 as well as Deleted permanently by %3. |
| 105      | DHCPv4.ServerOptionUpdate | Server level option %1 for IPv4 has been updated by %2. |
| 106      | DHCPv4.ReservationConfigured | Reservation: %1 for IPv4 is Configured under Scope %2 by %3. |
| 107      | DHCPv4.ReservationDeleted | Reservation: %1 for IPv4 is Deleted under Scope %2 by %3. |
| 108      | DHCPv4.ReservationDNSEnable | Reservation: %1 for IPv4 under Scope: %2 is Enabled for DNS Dynamic updates by %3. |
| 109      | DHCPv4.ReservationDNSDisable | Reservation: %1 for IPv4 under Scope: %2 is Disabled for DNS Dynamic updates by %3. |
| 110      | DHCPv4.ReservationDNSUpdate_Req_by_Client | Reservation: %1 for IPv4 under Scope: %2 is Updated with DNS Settings by %3: to dynamically update DNS A and PTR records on request by the DHCP Clients. |
| 111      | DHCPv4.ReservationDNSUpdate_Always | Reservation: %1 for IPv4 under Scope: %2 is Updated with DNS Settings by %3: to always dynamically update DNS A and PTR records. |
| 112      | DHCPv4.ReservationDNSEnable_Discard | Reservation: %1 for IPv4 under Scope: %2 is Enabled for DNS Settings by %3: to discard DNS A and PTR records when lease is deleted. |
| 113      | DHCPv4.ReservationDNSDisable_Discard | Reservation: %1 for IPv4 under Scope: %2 is Disabled for DNS Settings by %3: to discard DNS A and PTR records when lease is deleted. |
| 114      | DHCPv4.ReservationDNSEnableUpdate_No_Req_by_Client | Reservation: %1 for IPv4 under Scope: %2 is Enabled for DNS Settings by %3: to dynamically update DNS A and PTR records for DHCP Clients that don't request updates. |
| 115      | DHCPv4.ReservationDNSDisableUpdate_No_Req_by_Client | Reservation: %1 for IPv4 under Scope: %2 is Disabled for DNS Settings by %3: to dynamically update DNS A and PTR records for DHCP Clients that don't request updates. |
| 116      | DHCPv4.ReservationOptionUpdate | Reservation: %1 for IPv4 under Scope: %2 is Updated with Option Setting: %3 by %4. |
| 117      | DHCPv4.ServerPBA_DeActivated | Policy based assignment has been disabled at server level. |
| 118      | DHCPv4.ServerPBA_Activated | Policy based assignment has been enabled at server level. |
| 119      | DHCPv4.ScopeExclusionAdded | Added exclusion IP Address range %1 in the Address Pool for IPv4 under Scope: %2 by %3. |
| 120      | DHCPv4.ScopeExclusionDeleted | Deleted exclusion IP Address range %1 in the Address Pool for IPv4 under Scope: %2 by %3. |
| 121      | DHCPv4.ScopeEnableAllow | Link Layer based filtering is Enabled in the allowlist of the IPv4 by %1 |
| 122      | DHCPv4.ScopeDisableAllow | Link Layer based filtering is Disabled in the allowlist of the IPv4 by %1 |
| 123      | DHCPv4.ScopeAllow_AddFilter | Filter for physical address: %1, hardware type: %3 added to the IPv4 allowlist by %2. |
| 124      | DHCPv4.ScopeAllow_DeleteFilter | Filter for physical address: %1, hardware type: %3 removed from the IPv4 allowlist by %2. |
| 125      | DHCPv4.ScopeEnableDeny | Link Layer based filtering is Enabled in the blocklist of the IPv4 by %1 |
| 126      | DHCPv4.ScopeDisableDeny | Link Layer based filtering is Disabled in the blocklist of the IPv4 by %1 |
| 127      | DHCPv4.ScopeDeny_AddFilter | Filter for physical address: %1, hardware type: %3 added to the IPv4 blocklist by %2. |
| 128      | DHCPv4.ScopeDeny_DeleteFilter | Filter for physical address: %1, hardware type: %3 removed from the IPv4 blocklist by %2. |
| 130      | DHCPv6.ScopeDeleted | Scope: %1 for IPv6 is Deleted by %2. |
| 131      | DHCPv6.ScopeActivated | Scope: %1 for IPv6 is Activated by %2. |
| 132      | DHCPv6.ScopeDeActivated | Scope: %1 for IPv6 is DeActivated by %2. |
| 133      | DHCPv6.ScopeLeasePreferredUpdate | Scope: %1 for IPv6 is Updated with Lease Preferred Lifetime: %2 by %3. The previous configured Lease Preferred Lifetime was: %4. |
| 134      | DHCPv6.ScopeLeaseValidUpdate | Scope: %1 for IPv6 is Updated with Lease Valid Lifetime: %2 by %3. The previous configured Lease Valid Lifetime was: %4. |
| 135      | DHCPv6.ScopeOptionUpdate | Scope: %1 for IPv6 is Updated with Option Setting: %2 by %3. |
| 136      | DHCPv6.ScopeDNSEnable | Scope: %1 for IPv6 is Enabled for DNS Dynamic updates by %2. |
| 137      | DHCPv6.ScopeDNSDisable | Scope: %1 for IPv6 is Disabled for DNS Dynamic updates by %2. |
| 138      | DHCPv6.ScopeDNSUpdate_Req_by_Client | Scope: %1 for IPv6 is Updated with DNS Settings by %2: to dynamically update DNS AAAA and PTR records on request by the DHCP Clients. |
| 139      | DHCPv6.ScopeDNSUpdate_Always | Scope: %1 for IPv6 is Updated with DNS Settings by %2: to always dynamically update DNS AAAA and PTR records. |
| 140      | DHCPv6.ScopeDNSEnable_Discard | Scope: %1 for IPv6 is Enabled for DNS Settings by %2: to discard DNS AAAA and PTR records when lease is deleted. |
| 141      | DHCPv6.ScopeDNSDisable_Discard | Scope: %1 for IPv6 is Disabled for DNS Settings by %2: to discard DNS AAAA and PTR records when lease is deleted. |
| 142      | DHCPv6.ScopeDHCIDEnable | Name Protection setting is Enabled on Scope: %1 for IPv6 by %2. |
| 143      | DHCPv6.ScopeDHCIDDisable | Name Protection setting is Disabled on Scope: %1 for IPv6 by %2. |
| 145      | DHCPv6.ReservationConfigured | Reservation: %1 for IPv6 is Configured under Scope %2 by %3. |
| 147      | DHCPv6.ReservationDeleted | Reservation: %1 for IPv6 is Deleted under Scope %2 by %3. |
| 148      | DHCPv6.ReservationDNSEnable | Reservation: %1 for IPv6 under Scope: %2 is Enabled for DNS Dynamic updates by %3. |
| 149      | DHCPv6.ReservationDNSDisable | Reservation: %1 for IPv6 under Scope: %2 is Disabled for DNS Dynamic updates by %3. |
| 150      | DHCPv6.ReservationDNSUpdate_Req_by_Client | Reservation: %1 for IPv6 under Scope: %2 is Updated with DNS Settings by %3: to dynamically update DNS AAAA and PTR records on request by the DHCP Clients. |
| 151      | DHCPv6.ReservationDNSUpdate_Always | Reservation: %1 for IPv6 under Scope: %2 is Updated with DNS Settings by %3: to always dynamically update DNS AAAA and PTR records. |
| 152      | DHCPv6.ReservationDNSEnable_Discard | Reservation: %1 for IPv6 under Scope: %2 is Enabled for DNS Settings by %3: to discard DNS AAAA and PTR records when lease is deleted. |
| 153      | DHCPv6.ReservationDNSDisable_Discard | Reservation: %1 for IPv6 under Scope: %2 is Disabled for DNS Settings by %3: to discard DNS AAAA and PTR records when lease is deleted. |
| 154      | DHCPv6.ReservationOptionUpdate | Reservation: %1 for IPv6 under Scope: %2 is Updated with Option Setting: %3 by %4. |
| 155      | DHCPv6.ScopeExclusionAdded | Added exclusion IP Address range %1 in the Address Pool for IPv6 under Scope: %2 by %3. |
| 156      | DHCPv6.ScopeExclusionDeleted | Deleted exclusion IP Address range %1 in the Address Pool for IPv6 under Scope: %2 by %3. |
| 157      | DHCPv6.ScopeModified | Scope: %1 for IPv6 is Modified by %2. |
| 158      | DHCPv6.ScopeStatelessEnabled | DHCPv6 Stateless client inventory has been enabled for the scope %1. |
| 159      | DHCPv6.ScopeStatelessDisabled | DHCPv6 Stateless client inventory has been disabled for the scope %1. |
| 160      | DHCPv6.ServerStatelessEnabled | DHCPv6 Stateless client inventory has been enabled for the server. |
| 161      | DHCPv6.ServerStatelessDisabled | DHCPv6 Stateless client inventory has been disabled for the server. |
| 162      | DHCPv6.ScopeStatelessPurgeInterval | Purge time interval for DHCPv6 stateless client inventory for scope %1 has been set to %2 hours. |
| 163      | DHCPv6.ServerStatelessPurgeInterval | Purge time interval for DHCPv6 stateless client inventory for server has been set to %1 hours. |
| 165      | DHCPv4.ScopeDNSDisable_DisablePtrUpdates | Scope: %1 for IPv4 is Disabled for DNS Settings by %2: to disable dynamic updates for DNS PTR records. |
| 166      | DHCPv6.ServerOptionUpdate | Server level option %1 for IPv6 has been updated by %2. |
| 20220    | DHCPv4.UpdateServerPolicyState | Policy %2 for server is %1. |
| 20221    | DHCPv4.UpdateScopePolicyState | Policy %2 for scope %3 is %1. |
| 20222    | DHCPv4.UpdateServerPolicyExpr | The conditions for server policy %3 have been set to %1. The conditions are grouped by logical operator %2. |
| 20223    | DHCPv4.UpdateScopePolicyExpr | The conditions for scope %4 policy %3 have been set to %1. The conditions are grouped by logical operator %2. |
| 20226    | DHCPv4.DeleteServerPolicy | Policy %1 was deleted from server. |
| 20227    | DHCPv4.DeleteScopePolicy | Policy %1 was deleted from scope %2. |
| 20228    | DHCPv4.SetScopePolicyRange | The IP address range from %1 was set for the scope %3 policy %2. |
| 20229    | DHCPv4.RemoveScopePolicyRange | The IP address range from %1 was removed from the scope %3 policy %2. |
| 20230    | DHCPv4.SetServerPolicyOption | The value %2 was set for the option %1 for the server policy %3. |
| 20231    | DHCPv4.SetScopePolicyOption | The value %2 was set for the option %1 for the scope %4 policy %3. |
| 20232    | DHCPv4.UnsetServerPolicyOption | The value %2 was removed from the option %1 for the server policy %3. |
| 20233    | DHCPv4.UnsetScopePolicyOption | The value %2 was removed from the option %1 for the scope %4 policy %3. |
| 20234    | DHCPv4.UpdateServerPolicyName | Server policy %2 has been renamed to %1. |
| 20235    | DHCPv4.UpdateScopePolicyName | Scope %3 policy %2 has been renamed to %1. |
| 20236    | DHCPv4.UpdateServerPolicyDescription | Description of server policy %2 was set to %1. |
| 20237    | DHCPv4.UpdateScopePolicyDescription | Description of scope %3 policy %2 was set to %1. |
| 20238    | DHCPv4.UpdateServerPolicyProcOrder | Processing order of server policy %3 was changed to %1 from %2. |
| 20239    | DHCPv4.UpdateScopePolicyProcOrder | Processing order of scope %4 policy %3 was changed to %1 from %2. |
| 20241    | DHCPv4.CreateFailoverRelationshipHotStandby | A failover relationship has been created between servers %1 and %2 with the following configuration parameters: name: %3, mode: hot standby, maximum client lead time: %4 seconds, reserve address percentage on standby server: %5, auto state switchover interval: %6 seconds, standby server: %7. |
| 20242    | DHCPv4.DeleteFailoverRelationship | Failover relationship %1 between %2 and %3 has been deleted. |
| 20243    | DHCPv4.AddScopeRelationship | Scope %1 has been added to the failover relationship %2 with server %3. |
| 20244    | DHCPv4.DeleteScopeRelationship | Scope %1 has been removed from the failover relationship %2 with server %3. |
| 20245    | DHCPv4.UpdateRelationshipParamMclt | The failover configuration parameter MCLT for failover relationship %1 with server %2 has been changed from %3 seconds to %4 seconds. |
| 20246    | DHCPv4.UpdateRelationshipParamAutoSwitchOverInterval | The failover configuration parameter auto switch over interval for failover relationship %1 with server %2 has been changed from %3 seconds to %4 seconds. |
| 20247    | DHCPv4.UpdateRelationshipParamPercentageHS | The failover configuration parameter reserve address percentage for failover relationship %1 with server %2 has been changed from %3 to %4. |
| 20248    | DHCPv4.UpdateRelationshipParamPercentageLB | The failover configuration parameter load balance percentage for failover relationship %1 with server %2 has been changed from %3 to %4 on this server. |
| 20249    | DHCPv4.UpdateRelationshipParamModeHStoLB | The failover configuration parameter mode for failover relationship %1 with server %2 has been changed from hot standby to load balance. |
| 20250    | DHCPv4.UpdateRelationshipParamModeLBtoHS | The failover configuration parameter mode for failover relationship %1 with server %2 has been changed from load balance to hot standby. |
| 20311    | DHCPv4.UpdateSharedSecret | The shared secret for failover relationship %2 with server %1 has been changed. |
| 20312    | DHCPv4.EnabledSharedSecret | Message authentication for failover relationship %2 with server %1 has been enabled. |
| 20313    | DHCPv4.DisabledSharedSecret | Message authentication for failover relationship %2 with server %1 has been disabled. |
| 20315    | DHCPv4.UpdateScopePolicyDNSSuffix | DNSSuffix of scope %3 policy %2 was set to %1. |
| 20316    | DHCPv4.UpdateServerPolicyDNSSuffix | DNSSuffix of server policy %2 was set to %1. |

</details>

## DHCP server administrative events

DHCP server administrative events log information about administrative tasks that are performed on the DHCP server.

<br />
<details>
    <summary>To view all server administrative events, expand this section.</summary>

| Event ID | Event category | Event text |
|----------|----------------|------------|
| 1000     | EVENT_SERVER_UNKNOWN_OPTION | The DHCP service received the unknown option %1, with a length of %2. The raw option data is given below. |
| 1001     | EVENT_SERVER_FAILED_REGISTER_SC | The DHCP service failed to register with Service Controller. The following error occurred: %n%1. |
| 1002     | EVENT_SERVER_INIT_DATA_FAILED | The DHCP service failed to initialize its global parameters. The following error occurred: %n%1 |
| 1003     | EVENT_SERVER_INIT_REGISTRY_FAILED | The DHCP service failed to initialize its registry parameters. The following error occurred: %n%1 |
| 1004     | EVENT_SERVER_INIT_DATABASE_FAILED | The DHCP service failed to initialize the database. The following error occurred: %n%1 |
| 1005     | EVENT_SERVER_INIT_WINSOCK_FAILED | The DHCP service failed to initialize Winsock startup. The following error occurred: %n%1 |
| 1006     | EVENT_SERVER_INIT_RPC_FAILED | The DHCP service failed to start as an RPC server. The following error occurred: %n%1 |
| 1007     | EVENT_SERVER_INIT_SOCK_FAILED | The DHCP service failed to initialize Winsock data. The following error occurred: %n%1 |
| 1008     | EVENT_SERVER_SHUTDOWN | The DHCP service is shutting down due to the following error: %n%1 |
| 1009     | EVENT_SERVER_CLIENT_CLEANUP | The DHCP service encountered the following error while cleaning up the pending client records: %n%1 |
| 1010     | EVENT_SERVER_DATABASE_CLEANUP | The DHCP service encountered the following error while cleaning up the database: %n%1 |
| 1011     | EVENT_SERVER_LEASE_NACK | The DHCP service issued a NACK (negative acknowledgment message) to the client, %2, for the address, %1. |
| 1012     | EVENT_SERVER_LEASE_DECLINED | The DHCP client, %2, declined the address %1. |
| 1013     | EVENT_SERVER_LEASE_RELEASE | The DHCP Client, %2, released the address %1. |
| 1016     | EVENT_SERVER_DATABASE_BACKUP | The DHCP service encountered the following error when backing up the database: %n%1 |
| 1017     | EVENT_SERVER_CONFIG_BACKUP | The DHCP service encountered the following error when backing up the registry configuration: %n%1 |
| 1018     | EVENT_SERVER_DATABASE_RESTORE_FAILED | The DHCP service failed to restore the database. The following error occurred: %n%1 |
| 1019     | EVENT_SERVER_CONFIG_RESTORE_FAILED | The DHCP service failed to restore the DHCP registry configuration. The following error occurred: %n%1 |
| 1020     | EVENT_SERVER_LOW_ADDRESS_WARNING | Scope, %1, is %2 percent full with only %3 IP addresses remaining. |
| 1021     | EVENT_SERVER_LOAD_JET_FAILED | The DHCP service couldn't load the JET database library successfully. |
| 1022     | EVENT_SERVER_JET_CONV_REQUIRED | The DHCP service couldn't use the database. If this service was started for the first time after the upgrade from NT 3.51 or earlier, you need to run the utility, upg351db.exe, on the DHCP database to convert it to the new JET database format. Restart the DHCP service after you have upgraded the database. |
| 1023     | EVENT_SERVER_JET_CONV_IN_PROGRESS | The DHCP service will now terminate because the existing database needs conversion to Windows 2000 format. The conversion via the jetconv process has initiated. Don't reboot or stop the jetconv process. The conversion may take up to 10 minutes depending on the size of the database. Terminate DHCP now by clicking OK. This is required for the database conversion to succeed. NOTE: The DHCP service will be restarted automatically when the conversion is completed. To check conversion status, look at the Application event log for the jetconv process. |
| 1024     | EVENT_SERVER_INIT_AND_READY | The DHCP service has initialized and is ready |
| 1025     | EVENT_SERVER_BOOT_FILE_TABLE | The DHCP service was unable to read the BOOTP file table from the registry. The DHCP service will be unable to respond to BOOTP requests that specify the boot file name. |
| 1026     | EVENT_SERVER_BOOT_FILE_NAME | The DHCP service was unable to read the global BOOTP file name from the registry. |
| 1027     | EVENT_SERVER_AUDIT_LOG_APPEND_FAILED | The audit log file can't be appended. |
| 1028     | EVENT_SERVER_INIT_AUDIT_LOG_FAILED | The DHCP service failed to initialize the audit log. The following error occurred: %n%1 |
| 1029     | EVENT_SERVER_PING_FAILED | The DHCP service was unable to ping for a new IP address. The address was leased to the client. |
| 1030     | EVENT_SERVER_MOVE_AUDIT_LOG_FAILED | The audit log file couldn't be backed up. The following error occurred: %n%1 |
| 1031     | EVENT_SERVER_CALLOUT_UNHANDLED_EXCEPTION | The installed server callout .dll file has caused an exception. The exception was: %n%1. The server has ignored this exception. All further exceptions will be ignored. |
| 1032     | EVENT_SERVER_CALLOUT_LOAD_EXCEPTION | The installed server callout .dll file has caused an exception. The exception was: %n%1. The server has ignored this exception and the .dll file couldn't be loaded. |
| 1033     | EVENT_SERVER_CALLOUT_LOAD_SUCCESS | The DHCP service has successfully loaded one or more callout DLLs. |
| 1034     | EVENT_SERVER_READ_ONLY_GROUP_ERROR | The DHCP service has failed to load one or more callout DLLs. The following error occurred: %n%1 |
| 1035     | EVENT_SERVER_READ_ONLY_GROUP_ERROR | The DHCP service was unable to create or look up the DHCP Users local group on this computer. The error code is in the data. |
| 1036     | EVENT_SERVER_ADMIN_GROUP_ERROR | The DHCP server was unable to create or look up the DHCP Administrators local group on this computer. The error code is in the data. |
| 1037     | EVENT_SERVER_CLEANUP_STARTED | The DHCP service has started to clean up the database. |
| 1038     | EVENT_SERVER_IPCLEANUP_FINISHED | The DHCP service has cleaned up the database for unicast IP addresses--%1 leases have been recovered and %2 records have been removed from the database. |
| 1039     | EVENT_SERVER_MCASTCLEANUP_FINISHED | The DHCP service has cleaned up the database for multicast IP addresses--%1 leases have expired (been marked for deletion) and %2 records have been removed from the database. |
| 1040     | EVENT_SERVER_DATABASE_RESTORE_SUCCEEDED | The DHCP service successfully restored the database. |
| 1041     | DHCP_ROGUE_EVENT_NO_NETWORK | The DHCP service isn't servicing any DHCPv4 clients because none of the active network interfaces have statically configured IPv4 addresses, or there are no active interfaces. |
| 1042     | DHCP_ROGUE_EVENT_UNAUTHORIZED_INFO | The DHCP/BINL service running on this machine has detected a server on the network. If the server doesn't belong to any domain, the domain is listed as empty. The IP address of the server is listed in parentheses. %1 |
| 1043     | DHCP_ROGUE_EVENT_STARTED | The DHCP/BINL service on the local machine has determined that it's authorized to start. It's servicing clients now. |
| 1044     | DHCP_ROGUE_EVENT_STARTED_DOMAIN | The DHCP/BINL service on the local machine, belonging to the Windows Administrative domain %2, has determined that it's authorized to start. It's servicing clients now. |
| 1045     | DHCP_ROGUE_EVENT_STOPPED | The DHCP/BINL service on the local machine has determined that it isn't authorized to start. It has stopped servicing clients. The following are some possible reasons for this: %n%tThis machine belongs to a workgroup and has encountered another DHCP Server (belonging to a Windows Administrative Domain) servicing the same network. %n%n%tAn unexpected network error occurred. |
| 1046     | DHCP_ROGUE_EVENT_STOPPED_DOMAIN | The DHCP/BINL service on the local machine, belonging to the Windows Administrative domain %2, has determined that it isn't authorized to start. It has stopped servicing clients. The following are some possible reasons for this: %n%tThis machine is part of a directory service enterprise and isn't authorized in the same domain. For more information, see the DHCP Service Management Tool. %n%n%tThis machine can't reach its directory service enterprise and it has encountered another DHCP service on the network belonging to a directory service enterprise on which the local machine isn't authorized. %n%n%tSome unexpected network error occurred. |
| 1047     | DHCP_ROGUE_EVENT_JUST_UPGRADED | The DHCP/BINL service on the local machine has determined that it's authorized to start. It's servicing clients now. %nThe DHCP/BINL service has determined that the machine was recently upgraded. If the machine is intended to belong to a directory service enterprise, the DHCP service must be authorized in the directory service for it to start servicing clients. (See help on DHCP Service Management Tool for authorizing the server). |
| 1048     | DHCP_ROGUE_EVENT_JUST_UPGRADED_DOMAIN | The DHCP/BINL Service on the local machine, belonging to Windows Domain %2, has determined that it's authorized to start. It's servicing clients now. It has determined that the computer was recently upgraded. It has also determined that either there's no directory service enterprise for the domain or that the computer isn't authorized in the directory service. All DHCP services that belong to a directory service enterprise should be authorized in the directory service to service clients. (See help on the DHCP Service Management Tool for authorizing a DHCP service in the directory service). |
| 1049     | DHCP_ROGUE_EVENT_CANT_FIND_DOMAIN | The DHCP/BINL service on the local machine encountered an error while trying to find the domain of the local machine. The error was: %3. |
| 1050     | DHCP_ROGUE_EVENT_NETWORK_FAILURE | The DHCP/BINL service on the local machine encountered a network error. The error was: %3. |
| 1051     | DHCP_ROGUE_EVENT_UNAUTHORIZED | The DHCP/BINL service has determined that it isn't authorized to service clients on this network for the Windows domain: %2. All DHCP services that belong to a directory service enterprise must be authorized in the directory service to service clients. (See help on the DHCP Service Management Tool for authorizing a DHCP server in the directory service). |
| 1052     | DHCP_ROGUE_EVENT_OTHER_SERVER | The DHCP/BINL service on this workgroup server has encountered another server with IP Address, %1, belonging to the domain %2. |
| 1053     | DHCP_ROGUE_EVENT_SAM_OTHER_SERVER | The DHCP/BINL service has encountered another server on this network with IP Address, %1, belonging to the domain: %2. |
| 1054     | DHCP_ROGUE_EVENT_SHUTDOWN | The DHCP/BINL service on this computer is shutting down. See the previous event log messages for reasons. |
| 1055     | DHCP_EVENT_DNS_REGPARAMS_FAILURE | The DHCP service was unable to impersonate the credentials necessary for DNS registrations: %n%1. The local system credentials are being used. |
| 1056     | DHCP_EVENT_NO_DNSCREDENTIALS_ON_DC | The DHCP service has detected that it's running on a DC and has no credentials configured for use with Dynamic DNS registrations initiated by the DHCP service. This isn't a recommended security configuration. Credentials for Dynamic DNS registrations may be configured using the command line, or via the DHCP Administrative tool. |
| 1057     | EVENT_SERVER_DATABASE_CONVERSION | The DHCP service was unable to convert the temporary database to ESE format: %n%1. |
| 1058     | EVENT_SERVER_INIT_CONFIG_FAILED | The DHCP service failed to initialize its configuration parameters. The following error occurred: %n%1 |
| 1059     | VENT_SERVER_COULDNT_SEE_DS | The DHCP service failed to see a directory server for authorization. |
| 1060     | EVENT_SERVER_AUDITLOG_PATH_NOT_ACCESSIBLE | The DHCP service was unable to access path specified for the audit log. |
| 1061     | EVENT_SERVER_BACKUP_PATH_NOT_ACCESSIBLE | The DHCP service was unable to access path specified for the database backups. |
| 1062     | EVENT_SERVER_DB_PATH_NOT_ACCESSIBLE | The DHCP service was unable to access path specified for the database |
| 1063     | EVENT_SERVER_SCOPE_FULL | There are no IP addresses available for lease in the scope or superscope %1. |
| 1064     | EVENT_SERVER_BOOTP_FULL | There are no IP addresses available for BOOTP clients in the scope or superscope %1. |
| 1065     | EVENT_SERVER_ORPHONED_ENTRIES_DELETED | There were some orphaned entries deleted in the configuration due to the deletion of a class or an option definition. Please recheck the server configuration. |
| 1144     | EVENT_SERVER_NEED_STATIC_IP | This computer has at least one dynamically assigned IP address. For reliable DHCP Server operation, you should use only static IP addresses. |
| 1338     | EVENT_SERVER_OFFER_QUEUE_FULL | The number of pending DHCPOFFER messages for delayed transmission to the client has exceeded the server's capacity of 1,000 pending messages. The DHCP server will drop all subsequent DHCPDISCOVER messages for which the DHCPOFFER message response needs to be delayed as per the server configuration. The DHCP server will continue to process DHCPDISCOVER messages for which the DHCPOFFER message responses don't need to be delayed. The DHCP server will resume processing all DHCPDISCOVER messages once the number of pending DHCPOFFER messages for delayed transmission to the client is below the server's capacity. |
| 1339     | EVENT_SERVER_OFFER_QUEUE_FUNCTIONAL | The number pending DHCPOFFER messages for delayed transmission to the client are now below the server's capacity of 1,000. The DHCP server will now resume processing all DHCPDISCOVER messages. |
| 1340     | EVENT_SERVER_DNSDHCID_FAIL | The DNS registration for DHCPv4 Client IP address %1, FQDN %2, and DHCID %3 has been denied as there's probably an existing client with same FQDN already registered with DNS. |
| 1341     | EVENT_SERVER_POLICY_RANGES_FULL | There are no IP addresses available for lease in IP address range(s) of the policy %1 in scope %2. |
| 1342     | EVENT_SERVER_RESIDUAL_RANGES_FULL | IP address range of scope %1 is out of IP addresses. |
| 1343     | EVENT_SERVER_POLICY_RANGES_LOW_ADDRESS_WARNING | Ip address range(s) for the scope %1 policy %2 is %3 percent full with only %4 IP addresses available. |
| 1344     | EVENT_SERVER_DNS_VALIDATION_FAILED | The DNS IP Address %1 isn't a valid DNS Server Address. |
| 1376     | EVENT_SERVER_RESIDUAL_RANGES_LOW_ADDRESS_WARNING | IP address range of scope %1 is %2 percent full with only %3 IP addresses available. |
| 1377     | EVENT_SERVER_SUPERSCOPE_LOW_ADDRESS_WARNING | SuperScope, %1, is %2 percent full with only %3 IP addresses remaining. This superscope has the following scopes %4 |
| 10000    | EVENT_DHCPV6_ADDERESS_NACKED | DHCPv6 confirmation has been declined because the address wasn't appropriate to the link or DHCPv6 renew request has a Zero lifetime for Client Address %1. |
| 10001    | EVENT_DHCPV6_REQUEST_RECEIVED_FOR_ADDRESSES_NOT_LEASED | Renew, rebind, or confirm received for IPv6 addresses %1 for which there are no active lease available. |
| 10002    | EVENT_DHCPV6_SERVER_UNKNOWN_OPTION | DHCPv6 service received the unknown option %1, with a length of %2. The raw option data is given below. |
| 10003    | EVENT_DHCPV6_SERVER_SCOPE_FULL | There are no IPv6 addresses available to lease in the scope serving the network with Prefix %1. |
| 10004    | EVENT_DHCPV6_SERVER_LEASE_DECLINED | The DHCPv6 client, %2, declined the address %1. |
| 10005    | EVENT_DHCPV6_SERVER_LOW_ADDRESS_WARNING | DHCPv6 Scope serving the network with prefix %1, is %2 percent full with only %3 IP addresses remaining. |
| 10006    | EVENT_DHCPV6_CLIENT_DELETE | A DHCPV6 client %1 has been deleted from DHCPV6 database. |
| 10007    | EVENT_DHCPV6_DROP_TIMEOUT | A DHCPV6 message that was in the queue for more than 30 seconds has been dropped because it's too old to process. |
| 10008    | EVENT_DHCPV6_DROP_INVALID | An invalid DHCPV6 message has been dropped. |
| 10009    | EVENT_DHCPV6_DROP_WRONG_SERVER | A DHCPV6 message that wasn't meant for this server has been dropped. |
| 10010    | EVENT_DHCPV6_DROP_UNICAST | DHCV6 message has been dropped because it was received on a Unicast address and unicast support is disabled on the server. |
| 10011    | EVENT_DHCPV6_SERVER_AUDIT_LOG_APPEND_FAILED | DHCPV6 audit log file can't be appended, Error Code returned %1. |
| 10012    | EVENT_DHCPV6_DROP_UNAUTH | A DHCPV6 message has been dropped because the server isn't authorized to process the message. |
| 10013    | EVENT_DHCPv6_SERVER_INIT_AUDIT_LOG_FAILED | The DHCPv6 service failed to initialize the audit log. The following error occurred: %n%1 |
| 10014    | EVENT_DHCPV6_SERVER_MOVE_AUDIT_LOG_FAILED | DHCPv6 audit log file couldn't be backed up. Error code %1 |
| 10015    | EVENT_DHCPV6_SERVER_AUDITLOG_PATH_NOT_ACCESSIBLE | The DHCPv6 service was unable to access path specified for the audit log. |
| 10016    | EVENT_DHCPV6_SERVER_INIT_WINSOCK_FAILED | The DHCPv6 service failed to initialize Winsock startup. The following error occurred %1. |
| 10017    | EVENT_DHCPV6_NO_DNSCREDENTIALS_ON_DC | The DHCPv6 service has detected that it's running on a DC and has no credentials configured for use with Dynamic DNS registrations initiated by the DHCPv6 service. This isn't a recommended security configuration. |
| 10018    | EVENT_DHCPV6_SERVER_INTERFACE_NOTIFICATION | The DHCPv6 Server failed to receive a notification of interface list changes. Some of the interfaces won't be enabled in the DHCPv6 service. |
| 10019    | EVENT_DHCPV6_SERVER_INIT_CONFIG_FAILED | The DHCPv6 service failed to initialize its configuration parameters. The following error occurred: %n%1. |
| 10020    | EVENT_DHCPV6_SERVER_NEED_STATIC_IP | This computer has at least one dynamically assigned IPv6 address. For reliable DHCPv6 server operation, you should use only static IPv6 addresses. |
| 10021    | EVENT_DHCPV6_SERVER_INIT_DATABASE_FAILED | DHCPv6 service failed to initialize the database. The following error occurred: %n%1. |
| 10022    | EVENT_DHCPV6_SERVER_INIT_AND_READY | The DHCPv6 service has initialized and is ready to serve. |
| 10023    | EVENT_DHCPV6_PORT_UNAVAILABLE | DHCPv6 Server is unable to bind to UDP port number %1 as it's used by another application. This port must be made available to DHCPv6 Server to start servicing the clients. |
| 10024    | ERROR_LAST_DHCPV6_SERVER_ERROR | ERROR_LAST_DHCPV6_SERVER_ERROR |
| 10025    | EVENT_DHCPV6_DNSDHCID_FAIL | The DNS registration for DHCPv6 Client IPv6 address %1, FQDN %2 and DHCID %3 have been denied as there's probably an existing client with same FQDN already registered with DNS. |
| 20090    | EVENT_DHCP_PORT_UNAVAILABLE | DHCP Server is unable to bind to UDP port number %1 as it's used by another application. This port must be made available to DHCP Server to start servicing the clients. |
| 20098    | EVENT_FILTER_EMPTY_ALLOW_LIST | No DHCP clients are being served, as the allowlist is empty and the server was configured to provide DHCP services, to clients whose hardware addresses are present in the allowlist. |
| 20251    | DHCPv4.ChangeFailoverRelationState | The failover state of server: %1 for failover relationship: %2 changed from: %3 to %4. |
| 20252    | DHCPv4.ChangeFailoverRelationStateError | The failover state of server: %1 for failover relationship: %2 changed from: %3 to %4. |
| 20253    | DHCPv4.FailoverServerTimeSync | The server detected that it's out of time synchronization with partner server: %1 for failover relationship: %2. The time is out of sync by: %3 seconds. |
| 20254    | DHCPv4.FailoverCommUp | Server has established contact with failover partner server %1 for relationship %2. |
| 20255    | DHCPv4.FailoverCommDown | Server has lost contact with failover partner server %1 for relationship %2. |
| 20256    | DHCPv4.AuthFailedBndUpdMsgDigestFailedToCompare | Failover protocol message BINDING-UPDATE from server %1 for failover relationship %2 was rejected because message digest failed to compare. |
| 20257    | DHCPv4.AuthFailedBndUpdMsgDigestNotConfigured | Failover protocol message BINDING-UPDATE from server %1 for failover relationship %2 was rejected because message digest wasn't configured. |
| 20258    | DHCPv4.AuthFailedBndUpdMsgDigestNotPresent | Failover protocol message BINDING-UPDATE from server %1 for failover relationship %2 is rejected because message digest wasn't present. |
| 20259    | DHCPv4.ChangeFailoverRelationStateNoPrevState | The failover state of server: %1 for failover relationship: %2 changed to: %3. |
| 20260    | DHCPv4.ChangeFailoverRelationStateErrorNoPrevState | The failover state of server: %1 for failover relationship: %2 changed to: %3. |
| 20261    | DHCPv4.AuthFailedBndAckMsgDigestFailedToCompare | Failover protocol message BINDING-ACK from server %1 for failover relationship %2 was rejected because message digest failed to compare. |
| 20262    | DHCPv4.AuthFailedBndAckMsgDigestNotConfigured | Failover protocol message BINDING-ACK from server %1 for failover relationship %2 was rejected because message digest wasn't configured. |
| 20263    | DHCPv4.AuthFailedBndAckMsgDigestNotPresent | Failover protocol message BINDING-ACK from server %1 for failover relationship %2 is rejected because message digest wasn't present. |
| 20264    | DHCPv4.AuthFailedConnectMsgDigestFailedToCompare | Failover protocol message CONNECT from server %1 for failover relationship %2 was rejected because message digest failed to compare. |
| 20265    | DHCPv4.AuthFailedConnectMsgDigestNotConfigured | Failover protocol message CONNECT from server %1 for failover relationship %2 was rejected because message digest wasn't configured. |
| 20266    | DHCPv4.AuthFailedConnectMsgDigestNotPresent | Failover protocol message CONNECT from server %1 for failover relationship %2 is rejected because message digest wasn't present. |
| 20267    | DHCPv4.AuthFailedConnectAckMsgDigestFailedToCompare | Failover protocol message CONNECTACK from server %1 for failover relationship %2 was rejected because message digest failed to compare. |
| 20268    | DHCPv4.AuthFailedConnectAckMsgDigestNotConfigured | Failover protocol message CONNECTACK from server %1 for failover relationship %2 was rejected because message digest wasn't configured. |
| 20269    | DHCPv4.AuthFailedConnectAckMsgDigestNotPresent | Failover protocol message CONNECTACK from server %1 for failover relationship %2 is rejected because message digest wasn't present. |
| 20270    | DHCPv4.AuthFailedUpdReqAllMsgDigestFailedToCompare | Failover protocol message UPDREQALL from server %1 for failover relationship %2 was rejected because message digest failed to compare. |
| 20271    | DHCPv4.AuthFailedUpdReqAllMsgDigestNotConfigured | Failover protocol message UPDREQALL from server %1 for failover relationship %2 was rejected because message digest wasn't configured. |
| 20272    | DHCPv4.AuthFailedUpdReqAllMsgDigestNotPresent | Failover protocol message UPDREQALL from server %1 for failover relationship %2 is rejected because message digest wasn't present. |
| 20273    | DHCPv4.AuthFailedUpdDoneMsgDigestFailedToCompare | Failover protocol message UPDDONE from server %1 for failover relationship %2 was rejected because message digest failed to compare. |
| 20274    | DHCPv4.AuthFailedUpdDoneMsgDigestNotConfigured | Failover protocol message UPDDONE from server %1 for failover relationship %2 was rejected because message digest wasn't configured. |
| 20275    | DHCPv4.AuthFailedUpdDoneMsgDigestNotPresent | Failover protocol message UPDDONE from server %1 for failover relationship %2 is rejected because message digest wasn't present. |
| 20276    | DHCPv4.AuthFailedUpdReqMsgDigestFailedToCompare | Failover protocol message UPDREQ from server %1 for failover relationship %2 was rejected because message digest failed to compare. |
| 20277    | DHCPv4.AuthFailedUpdReqMsgDigestNotConfigured | Failover protocol message UPDREQ from server %1 for failover relationship %2 was rejected because message digest wasn't configured. |
| 20278    | DHCPv4.AuthFailedUpdReqMsgDigestNotPresent | Failover protocol message UPDREQ from server %1 for failover relationship %2 is rejected because message digest wasn't present. |
| 20279    | DHCPv4.AuthFailedStateMsgDigestFailedToCompare | Failover protocol message STATE from server %1 for failover relationship %2 was rejected because message digest failed to compare. |
| 20280    | DHCPv4.AuthFailedStateMsgDigestNotConfigured | Failover protocol message STATE from server %1 for failover relationship %2 was rejected because message digest wasn't configured. |
| 20281    | DHCPv4.AuthFailedStateMsgDigestNotPresent | Failover protocol message STATE from server %1 for failover relationship %2 is rejected because message digest wasn't present. |
| 20282    | DHCPv4.AuthFailedContactMsgDigestFailedToCompare | Failover protocol message CONTACT from server %1 for failover relationship %2 was rejected because message digest failed to compare. |
| 20283    | DHCPv4.AuthFailedContactMsgDigestNotConfigured | Failover protocol message CONTACT from server %1 for failover relationship %2 was rejected because message digest wasn't configured. |
| 20284    | DHCPv4.AuthFailedContactMsgDigestNotPresent | Failover protocol message CONTACT from server %1 for failover relationship %2 is rejected because message digest wasn't present. |
| 20285    | DHCPv4.InvalidAlgorithmProvider | An invalid cryptographic algorithm %1 was specified for failover message authentication in FailoverCryptoAlgorithm under registry key HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DHCPServer\Parameters\Failover. The operation is halted. |
| 20286    | DHCPv4.FailoverClientLeaseDropped | BINDING UPDATE message for IP address %1 couldn't be replicated to the partner server %2 of failover relation %3 as the internal BINDING UPDATE queue is full. |
| 20287    | DHCPv4.ClientRequestDropped | DHCP client request from %1 was dropped since the applicable IP address ranges in scope/superscope %2 are out of available IP addresses. This could be because of IP address ranges of a policy being out of available IP addresses. |
| 20291    | DHCPv4.SendBndAckMessageRejectReason | A BINDING-ACK message with transaction ID: %1 was sent for IP address: %2 with reject reason: (%3) to partner server: %4 for failover relationship: %5. |
| 20292    | DHCPv4.RecvBndAckMessageRejectReason | A BINDING-ACK message with transaction ID: %1 was received for IP address: %2 with reject reason: (%3) from partner server: %4 for failover relationship: %5. |

</details>

## DHCP server system events

DHCP server system events log information about the DHCP server’s system.

<br />
<details>
    <summary>To view all server system events, expand this section.</summary>

| Event ID | Event category | Event text |
|----------|----------------|------------|
| 20035    | EVENT_SERVER_INTERFACE_NOTIFICATION | %1 %3 |
| 20058    | DHCPv4HA.BndUpd | %1 %3 |
| 20059    | DHCPv4HA.BndAck | %1 %3 |
| 20060    | DHCPv4HA.Connect | %1 %3 |
| 20061    | DHCPv4HA.ConnectAck | %1 %3 |
| 20062    | DHCPv4HA.UpdReqAll | %1 %3 |
| 20063    | DHCPv4HA.UpdDone | %1 %3 |
| 20064    | DHCPv4HA.UpdReq | %1 %3 |
| 20065    | DHCPv4HA.State | %1 %3 |
| 20066    | DHCPv4HA.Contact | %1 %3 |
| 20067    | DHCPv4HA.Disconnect | %1 %3 |
| 20068    | DHCPv4HA.ScavengerStart | Scavenger started. |
| 20069    | DHCPv4HA.ScavengerEnd | Scavenger ended. |
| 20161    | DHCPv4HA.AddrAllocationTriggered | Address allocation triggered for the failover relationship %1. |
| 20163    | DHCPv4Stateless.ScavengerEnd | Scavenger finished purging stateless entries. |
| 20164    | DHCPv4HA.TotalLeasesDeleted | The total leases deleted in scavenger are %1 |
| 20165    | DHCPv4HA.FailoverScopeDeleted | Scope %1 which was part of failover relationship %2 wasn't found in DHCP server database. Please restore the DHCP server database. |

</details>

## DHCP server filter notification events

DHCP server filter notification events log information about link-layer based filtering.

<br />
<details>
    <summary>To view all server filter notification events, expand this section.</summary>

| Event ID | Event category | Event text |
|----------|----------------|------------|
| 20096    | EVENT_FILTER_DENIED_IN_DENY_LIST | DHCP Services denied to machine with hardware address %1, hardware type %4, and FQDN/Hostname %2 because it matched entry %3 in the blocklist. |
| 20097    | EVENT_FILTER_DENIED_NOT_IN_ALLOW_LIST | DHCP Services denied to machine with hardware address %1, hardware type %3, and FQDN/Hostname %2 because it didn't match any entry in the allowlist. |
| 20099    | EVENT_FILTER_DENIED_IN_DENY_LIST_UNSPECIFIED | DHCP Services denied to machine with hardware address %1, hardware type %4, and unspecified FQDN/Hostname%2 because it matched entry %3 in the blocklist. |
| 20100    | EVENT_FILTER_DENIED_NOT_IN_ALLOW_LIST_UNSPECIFIED | DHCP Services denied to machine with hardware address %1, hardware type %3, and unspecified FQDN/Hostname%2 because it didn't match any entry in the allowlist. |

</details>

## DHCP server audit events

DHCP server audit events log information about security-related events.

<br />
<details>
    <summary>To view all server audit events, expand this section.</summary>

| Event ID | Event category | Event text |
|----------|----------------|------------|
| 20289    | DHCPv4.SendBndUpdMessage | A BINDING-UPDATE message with transaction ID: %1 was sent for IP address: %2 with binding status: %3 to partner server: %4 for failover relationship: %5. |
| 20290    | DHCPv4.RecvBndUpdMessage | A BINDING-UPDATE message with transaction ID: %1 was received for IP address: %2 with binding status: %3 from partner server: %4 for failover relationship: %5. |
| 20293    | DHCPv4.SendUpdReqMessage | A UPDREQ message with transaction ID: %1 was sent to partner server: %2 for failover relationship: %3. |
| 20294    | DHCPv4.RecvUpdReqMessage | A UPDREQ message with transaction ID: %1 was received from partner server: %2 for failover relationship: %3. |
| 20295    | DHCPv4.SendUpdDoneMessage | A UPDDONE message with transaction ID: %1 was sent to partner server: %2 for failover relationship: %3. |
| 20296    | DHCPv4.RecvUpdDoneMessage | A UPDDONE message with transaction ID: %1 was received from partner server: %2 for failover relationship: %3. |
| 20297    | DHCPv4.SendUpdReqAllMessage | A UPDREQALL message with transaction ID: %1 was sent to partner server: %2 for failover relationship: %3. |
| 20298    | DHCPv4.RecvUpdReqAllMessage | A UPDREQALL message with transaction ID: %1 was received from partner server: %2 for failover relationship: %3. |
| 20299    | DHCPv4.SendContactMessage | A CONTACT message with transaction ID: %1 was sent to partner server: %2 for failover relationship: %3. |
| 20300    | DHCPv4.RecvContactMessage | A CONTACT message with transaction ID: %1 was received from partner server: %2 for failover relationship: %3. |
| 20301    | DHCPv4.SendConnectMessage | A CONNECT message with transaction ID: %1 was sent to partner server: %2 for failover relationship: %3. |
| 20302    | DHCPv4.RecvConnectMessage | A CONNECT message with transaction ID: %1 was received from partner server: %2 for failover relationship: %3. |
| 20303    | DHCPv4.SendStateMessage | A STATE message with transaction ID: %1 was sent to partner server: %2 for failover relationship %3 with state: %4 and start time of state: %5. |
| 20304    | DHCPv4.RecvStateMessage | A STATE message with transaction ID: %1 was received from partner server: %2 for failover relationship %3 with state: %4 and start time of state %5. |
| 20305    | DHCPv4.SendConnectAckMessage | A CONNECTACK message with transaction ID %1 was sent to partner server: %2 for failover relationship: %3. |
| 20306    | DHCPv4.RecvConnectAckMessage | A CONNECTACK message with transaction ID %1 was received from partner server: %2 for failover relationship: %3. |
| 20307    | DHCPv4.SendBndAckMessageNoRejectReason | A BINDING-ACK message with transaction ID: %1 was sent for IP address: %2 to partner server: %3 for failover relationship: %4. |
| 20308    | DHCPv4.RecvBndAckMessageNoRejectReason | A BINDING-ACK message with transaction ID: %1 was received for IP address: %2 from partner server: %3 for failover relationship: %4. |
| 20309    | DHCPv4.SendConnectAckMessageRejectReason | A CONNECTACK message with transaction ID %1 was sent to partner server: %2 for failover relationship: %3 with reject reason: %4. |
| 20310    | DHCPv4.RecvConnectAckMessageRejectReason | A CONNECTACK message with transaction ID %1 was received from partner server: %2 for failover relationship: %3 with reject reason: %4. |

</details>


