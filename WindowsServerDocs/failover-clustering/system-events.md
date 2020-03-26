---
title: Failover Clustering system log events
description: A list of Failover Clustering events in the Windows Server System log. These events can be used to troubleshoot a cluster.
ms.prod: windows-server 
ms.topic: article 
author: JasonGerend 
ms.author: jgerend 
ms.technology: storage-failover-clustering 
ms.date: 01/14/2020
---
# Failover Clustering system log events

>Applies to: Windows Server 2019, Windows Server 2016

This topic lists the Failover Clustering events from the Windows Server System
log (viewable in Event Viewer). These events all share the event source of
**FailoverClustering** and can be helpful when troubleshooting a cluster.

## Critical events

### Event 1000: UNEXPECTED_FATAL_ERROR

Cluster service suffered an unexpected fatal error at line %1 of source module
%2. The error code was %3.

### Event 1001: ASSERTION_FAILURE

Cluster service failed a validity check on line %1 of source module %2. '%3'

### Event 1006: NM_EVENT_MEMBERSHIP_HALT

Cluster service was halted due to incomplete connectivity with other cluster
nodes.

### Event 1057: DM_DATABASE_CORRUPT_OR_MISSING

The cluster database could not be loaded. The file may be missing or corrupt.
Automatic repair might be attempted.

### Event 1070: NM_EVENT_BEGIN_JOIN_FAILED

The node failed to join failover cluster '%1' due to error code '%2'.

### Event 1073: CS_EVENT_INCONSISTENCY_HALT

The Cluster service was halted to prevent an inconsistency within the failover
cluster. The error code was '%1'.

### Event 1080: CS_DISKWRITE_FAILURE

The Cluster service failed to update the cluster database (error code '%1').
Possible causes are insufficient disk space or file system corruption.

### Event 1090: CS_EVENT_REG_OPERATION_FAILED

The Cluster service cannot be started. An attempt to read configuration data
from the Windows registry failed with error '%1'. Please use the Failover
Cluster Management snap-in to ensure that this machine is a member of a cluster.
If you intend to add this machine to an existing cluster use the Add Node
Wizard. Alternatively, if this machine has been configured as a member of a
cluster, it will be necessary to restore the missing configuration data that is
necessary for the Cluster Service to identify that it is a member of a cluster.
Perform a System State Restore of this machine in order to restore the
configuration data.

### Event 1092: NM_EVENT_MM_FORM_FAILED

Failed to form cluster '%1' with error code '%2'. Failover cluster will not be
available.

### Event 1093: NM_EVENT_NODE_NOT_MEMBER

The Cluster service cannot identify node '%1' as a member of failover cluster
'%2'. If the computer name for this node was recently changed, consider
reverting to the previous name. Alternatively, add the node to the failover
cluster and if necessary, reinstall clustered applications.

### Event 1105: CS_EVENT_RPC_INIT_FAILED

The Cluster service failed to start because it was unable to register
interface(s) with the RPC service. The error code was '%1'.

### Event 1135: EVENT_NODE_DOWN

Cluster node '%1' was removed from the active failover cluster membership. The
Cluster service on this node may have stopped. This could also be due to the
node having lost communication with other active nodes in the failover cluster.
Run the Validate a Configuration wizard to check your network configuration. If
the condition persists, check for hardware or software errors related to the
network adapters on this node. Also check for failures in any other network
components to which the node is connected such as hubs, switches, or bridges.

### Event 1146: RCM_EVENT_RESMON_DIED

The cluster Resource Hosting Subsystem (RHS) process was terminated and will be
restarted. This is typically associated with cluster health detection and
recovery of a resource. Refer to the System event log to determine which
resource and resource DLL is causing the issue.

### Event 1177: MM_EVENT_ARBITRATION_FAILED

The Cluster service is shutting down because quorum was lost. This could be due
to the loss of network connectivity between some or all nodes in the cluster, or
a failover of the witness disk.

Run the Validate a Configuration wizard to check your network configuration. If
the condition persists, check for hardware or software errors related to the
network adapter. Also check for failures in any other network components to
which the node is connected such as hubs, switches, or bridges.

### Event 1181: NETRES_RESOURCE_START_ERROR

Cluster resource '%1' cannot be brought online because the associated service
failed to start. The service return code is '%2'. Please check for additional
events associated with the service and ensure the service starts correctly.

### Event 1247: CLUSTER_EVENT_INVALID_SERVICE_SID_TYPE

The Security Identifier (SID) type for the cluster service is configured as '%1'
but the expected SID type is 'Unrestricted'. The cluster service is
automatically modifying its SID type configuration with the Service Control
Manager (SCM) and will restart in order for this change to take effect.

### Event 1248: CLUSTER_EVENT_SERVICE_SID_MISSING

The Security Identifier (SID) '%1' associated with the cluster service is not
present in the process token. The cluster service will automatically correct
this problem and restart.

### Event 1282: SM_EVENT_HANDSHAKE_TIMEOUT

Security Handshake between local and remote endpoints '%2' did not complete in
'%1' seconds, node terminating the connection

### Event 1542: SERVICE_PRERESTORE_FAILED

The restore request for the cluster configuration data has failed. This restore
failed during the 'pre-restore' stage usually indicating that some nodes
comprising the cluster are not currently operational. Ensure that the cluster
service is running successfully on all nodes comprising this cluster.

### Event 1543: SERVICE_POSTRESTORE_FAILED

The restore operation of the cluster configuration data has failed. This restore
failed during the 'post-restore' stage usually indicating that some nodes
comprising the cluster are not currently operational. It is recommended that you
replace the current cluster configuration data file (ClusDB) with '%1'.

### Event 1546: SERVICE_FORM_VERSION_INCOMPATIBLE

Node '%1' failed to form a failover cluster. This was due to one or more nodes
executing incompatible versions of the cluster service software. If node '%1' or
a different node in the cluster has been recently upgraded, please re-verify
that all nodes are executing compatible versions of the cluster service
software.

### Event 1547: SERVICE_CONNECT_VERSION_INCOMPATIBLE

Node '%1' attempted to join a failover cluster but failed due to incompatibility
between versions of the cluster service software. If node '%1' or a different
node in the cluster has been recently upgraded, please verify that the changed
cluster deployment with different versions of the cluster service software is
supported.

### Event 1553: SERVICE_NO_NETWORK_CONNECTIVITY

This cluster node has no network connectivity. It cannot participate in the
cluster until connectivity is restored. Run the Validate a Configuration wizard
to check your network configuration. If the condition persists, check for
hardware or software errors related to the network adapter. Also check for
failures in any other network components to which the node is connected such as
hubs, switches, or bridges.

### Event 1554: SERVICE_NETWORK_CONNECTIVITY_LOST

This cluster node has lost all network connectivity. It cannot participate in
the cluster until connectivity is restored. The cluster service on this node
will be terminated.

### Event 1556: SERVICE_UNHANDLED_EXCEPTION_IN_WORKER_THREAD

The cluster service encountered an unexpected problem and will be shut down. The
error code was '%2'.

### Event 1561: SERVICE_NONSTORAGE_WITNESS_BETTER_TAG

Cluster service failed to start because this node detected that it does not have
the latest copy of cluster configuration data. Changes to the cluster occurred
while this node was not in membership and as a result was not able to receive
configuration data updates.

#### Guidance

Attempt to start the cluster service on all nodes in the cluster so that nodes
with the latest copy of the cluster configuration data can first form the
cluster. This node will then be able join the cluster and will automatically
obtain the updated cluster configuration data. If there are no nodes available
with the latest copy of the cluster configuration data, run the
'Start-ClusterNode -FQ' Windows PowerShell cmdlet. Using the ForceQuorum (FQ)
parameter will start the cluster service and mark this node's copy of the
cluster configuration data to be authoritative. Forcing quorum on a node with an
outdated copy of the cluster database may result in cluster configuration
changes that occurred while the node was not participating in the cluster to be
lost.

### Event 1564: RES_FSW_ARBITRATEFAILURE

File share witness resource '%1' failed to arbitrate for the file share '%2'.
Please ensure that file share '%2' exists and is accessible by the cluster.

### Event 1570: SERVICE_CONNECT_AUTHENTICATION_FAILURE

Node '%1' failed to establish a communication session while joining the cluster.
This was due to an authentication failure. Please verify that the nodes are
running compatible versions of the cluster service software.

### Event 1571: SERVICE_CONNECT_AUTHORIZAION_FAILURE

Node '%1' failed to establish a communication session while joining the cluster.
This was due to an authorization failure. Please verify that the nodes are
running compatible versions of the cluster service software.

### Event 1572: SERVICE_NETFT_ROUTE_INITIAL_FAILURE

Node '%1' failed to join the cluster because it could not send and receive
failure detection network messages with other cluster nodes. Please run the
Validate a Configuration wizard to ensure network settings. Also verify the
Windows Firewall 'Failover Clusters' rules.

### Event 1574: DM_DATABASE_UNLOAD_FAILED

The failover cluster database could not be unloaded. If restarting the cluster
service does not fix the problem, please restart the machine.

### Event 1575: DM_DATABASE_CORRUPT_OR_MISSING_FIXQUORUM

An attempt to forcibly start the cluster service has failed because the cluster
configuration data on this node is either missing or corrupt. Please first start
the cluster service on another node that has an intact and valid copy of the
cluster configuration data. Then, reattempt the start operation on this node
(which will attempt to obtain updated valid configuration information
automatically). If no other node is available, please use WBAdmin.msc to perform
a System State Restore of this node in order to restore the configuration data.

### Event 1593: DM_COULD_NOT_DISCARD_CHANGES

The failover cluster database could not be unloaded and any potentially
incorrect changes in memory could not be discarded. The cluster service will
attempt to repair the database by retrieving it from another cluster node. If
the cluster service does not come online, restart the cluster service on this
node. If restarting the cluster service does not fix the problem, please restart
the machine. If the cluster service fails to come online after a reboot, please
restore the cluster database from the last backup. The current database was
copied to '%1'. If no backups are available, please copy '%1' to '%2' and
attempt to start the cluster service. If the cluster service then comes online
on this node, some cluster configuration changes may be lost and the cluster may
not function properly. Run the Validate a Configuration wizard to check your
cluster configuration and verify that the hosted Services and Applications are
online and functioning correctly.

### Event 1672: EVENT_NODE_QUARANTINED

Cluster node '%1' has been quarantined. The node experienced '%2' consecutive
failures within a short amount of time and has been removed from the cluster to
avoid further disruptions. The node will be quarantined until '%3' and then the
node will automatically attempt to re-join the cluster.

Refer to the System and Application event logs to determine the issues on this
node. When the issue is resolved, quarantine can be manually cleared to allow
the node to rejoin with the 'Start-ClusterNode –ClearQuarantine' Windows
PowerShell cmdlet.

Node Name : %1

Number of consecutive cluster membership loses: %2

Time quarantine will be automatically cleared: %3

## Error events

### Event 1024: CP_REG_CKPT_RESTORE_FAILED

The registry checkpoint for cluster resource '%1' could not be restored to
registry key HKEY_LOCAL_MACHINE\\%2. The resource may not function correctly.
Make sure that no other processes have open handles to registry keys in this
registry subtree.

### Event 1034: RES_DISK_MISSING

Cluster physical disk resource '%1' cannot be brought online because the
associated disk could not be found. The expected signature of the disk was '%2'.
If the disk was replaced or restored, in the Failover Cluster Manager snap-in,
you can use the Repair function (in the properties sheet for the disk) to repair
the new or restored disk. If the disk will not be replaced, delete the
associated disk resource.

### Event 1035: RES_DISK_MOUNT_FAILED

While disk resource '%1' was being brought online, access to one or more volumes
failed with error '%2'. Run the Validate a Configuration wizard to check your
storage configuration. Optionally you may want to run Chkdsk to verify the
integrity of all volumes on this disk.

### Event 1037: RES_DISK_FILESYSTEM_FAILED

The file system for one or more partitions on the disk for resource '%1' may be
corrupt. Run the Validate a Configuration wizard to check your storage
configuration. Optionally, you may want to run Chkdsk to verify the integrity of
all volumes on this disk.

### Event 1038: RES_DISK_RESERVATION_LOST

Ownership of cluster disk '%1' has been unexpectedly lost by this node. Run the
Validate a Configuration wizard to check your storage configuration.

### Event 1039: RES_GENAPP_CREATE_FAILED

Generic application '%1' could not be brought online (with error '%2') during an
attempt to create the process. Possible causes include: the application may not
be present on this node, the path name may have been specified incorrectly, the
binary name may have been specified incorrectly.

### Event 1040: RES_GENSVC_OPEN_FAILED

Generic service '%1' could not be brought online (with error '%2') during an
attempt to open the service. Possible causes include: the service is either not
installed or the specified service name is invalid.

### Event 1041: RES_GENSVC_START_FAILED

Generic service '%1' could not be brought online (with error '%2') during an
attempt to start the service. Possible cause: the specified service parameters
might be invalid.

### Event 1042: RES_GENSVC_FAILED_AFTER_START

Generic service '%1' failed with error '%2'. Please examine the application
event log.

### Event 1044: RES_IPADDR_NBT_INTERFACE_CREATE_FAILED

Encountered a failure when attempting to create a new NetBIOS interface while
bringing resource '%1' online (error code '%2'). The maximum number of NetBIOS
names may have been exceeded.

### Event 1046: RES_IPADDR_INVALID_SUBNET

Cluster IP address resource '%1' cannot be brought online because the subnet
mask value is invalid. Please check your IP address resource properties.

### Event 1047: RES_IPADDR_INVALID_ADDRESS

Cluster IP address resource '%1' cannot be brought online because the address
value is invalid. Please check your IP address resource properties.

### Event 1048: RES_IPADDR_INVALID_ADAPTER

Cluster IP address resource '%1' failed to come online. Configuration data for
the network adapter corresponding to cluster network interface '%2' could not be
determined (error code was '%3'). Please check that the IP address resource is
configured with the correct address and network properties.

### Event 1049: RES_IPADDR_IN_USE

Cluster IP address resource '%1' cannot be brought online because a duplicate IP
address '%2' was detected on the network. Please ensure all IP addresses are
unique.

### Event 1050: RES_NETNAME_DUPLICATE

Cluster network name resource '%1' cannot be brought online because name '%2'
matches this cluster node name. Ensure that network names are unique.

### Event 1051: RES_NETNAME_NO_IP_ADDRESS

Cluster network name resource '%1' cannot be brought online. Ensure that the
network adapters for dependent IP address resources have access to at least one
DNS server. Alternatively, enable NetBIOS for dependent IP addresses.

### Event 1052: RES_NETNAME_CANT_ADD_NAME_STATUS

Cluster Network Name resource '%1' cannot be brought online because the name
could not be added to the system. The associated error code is stored in the
data section.

### Event 1053: RES_SMB_CANT_CREATE_SHARE

Cluster File Share '%1' cannot be brought online because the share could not be
created.

### Event 1054: RES_SMB_SHARE_NOT_FOUND

Health check for file share resource '%1' failed. Retrieving information for
share '%2' (scoped to network name %3) returned error code '%4'. Ensure the
share exists and is accessible.

### Event 1055: RES_SMB_SHARE_FAILED

Health check for file share resource '%1' failed. Retrieving information for
share '%2' (scoped to network name %3) indicated that the share does not exist
(error code '%4'). Please ensure the share exists and is accessible.

### Event 1069: RCM_RESOURCE_FAILURE

Cluster resource '%1' in clustered role '%2' failed.

### Event 1069: RCM_RESOURCE_FAILURE_WITH_TYPENAME

Cluster resource '%1' of type '%3' in clustered role '%2' failed.<br><br>Based on
the failure policies for the resource and role, the cluster service may try to
bring the resource online on this node or move the group to another node of the
cluster and then restart it. Check the resource and group state using Failover
Cluster Manager or the Get-ClusterResource Windows PowerShell cmdlet.

### Event 1069: RCM_RESOURCE_FAILURE_WITH_CAUSE

Cluster resource '%1' of type '%3' in clustered role '%2' failed. The error code
was '%5' ('%4').<br><br>Based on the failure policies for the resource and role, the
cluster service may try to bring the resource online on this node or move the
group to another node of the cluster and then restart it. Check the resource and
group state using Failover Cluster Manager or the Get-ClusterResource Windows
PowerShell cmdlet.

### Event 1069: RCM_RESOURCE_FAILURE_WITH_ERROR_CODE

Cluster resource '%1' of type '%3' in clustered role '%2' failed. The error code
was '%4'.<br><br>Based on the failure policies for the resource and role, the
cluster service may try to bring the resource online on this node or move the
group to another node of the cluster and then restart it. Check the resource and
group state using Failover Cluster Manager or the Get-ClusterResource Windows
PowerShell cmdlet.

### Event 1069: RCM_RESOURCE_FAILURE_DUE_TO_VETO

Cluster resource '%1' of type '%3' in clustered role '%2' failed due to an
attempt to block a required state change in that cluster resource.

### Event 1077: RES_IPADDR_IPV4_ADDRESS_INTERFACE_FAILED

Health check for IP interface '%1' (address '%2') failed (status is '%3'). Run
the Validate a Configuration wizard to ensure that the network adapter is
functioning properly.

### Event 1078: RES_IPADDR_WINS_ADDRESS_FAILED

Cluster IP address resource '%1' cannot be brought online because WINS
registration failed on interface '%2' with error '%3'. Ensure that a valid,
accessible WINS server has been specified.

### Event 1121: CP_CRYPTO_CKPT_RESTORE_FAILED

Encrypted settings for cluster resource '%1' could not be successfully applied
to the container name '%2' on this node.

### Event 1127: TM_EVENT_CLUSTER_NETINTERFACE_FAILED

Cluster network interface '%1' for cluster node '%2' on network '%3' failed. Run
the Validate a Configuration wizard to check your network configuration. If the
condition persists, check for hardware or software errors related to the network
adapter. Also check for failures in any other network components to which the
node is connected such as hubs, switches, or bridges.

### Event 1129: TM_EVENT_CLUSTER_NETWORK_PARTITIONED

Cluster network '%1' is partitioned. Some attached failover cluster nodes cannot
communicate with each other over the network. The failover cluster was not able
to determine the location of the failure. Run the Validate a Configuration
wizard to check your network configuration. If the condition persists, check for
hardware or software errors related to the network adapter. Also check for
failures in any other network components to which the node is connected such as
hubs, switches, or bridges.

### Event 1130: TM_EVENT_CLUSTER_NETWORK_DOWN

Cluster network '%1' is down. None of the available nodes can communicate using
this network. Run the Validate a Configuration wizard to check your network
configuration. If the condition persists, check for hardware or software errors
related to the network adapter. Also check for failures in any other network
components to which the node is connected such as hubs, switches, or bridges.

### Event 1137: RCM_DRAIN_MOVE_FAILED

Move of cluster role '%1' for drain could not be completed. The operation failed
with error code %2.

### Event 1138: RES_SMB_CANT_CREATE_DFS_ROOT

Cluster file share resource '%1' cannot be brought online. Creation of DFS
namespace root failed with error '%3'. This may be due to failure to start the
'DFS Namespace' service or failure to create the DFS-N root for share '%2'.

### Event 1141: RES_SMB_CANT_INIT_DFS_SVC

Cluster file share resource '%1' cannot be brought online. Resynchronization of
DFS root target '%2' failed with error '%3'.

### Event 1142: RES_SMB_CANT_ONLINE_DFS_ROOT

Cluster file share resource '%1' for DFS Namespace cannot be brought online due
to error '%2'.

### Event 1182: NETRES_RESOURCE_STOP_ERROR

Cluster resource '%1' cannot be brought online because the associated service
failed an attempted restart. The error code is '%2'. The service required a
restart in order to update parameters. However, the service failed before it
could be stopped and restarted. Please check for additional events associated
with the service and ensure the service is functioning correctly.

### Event 1183: RES_DISK_INVALID_MP_SOURCE_NOT_CLUSTERED

Cluster disk resource '%1' contains an invalid mount point. Both the source and
target disks associated with the mount point must be clustered disks, and must
be members of the same group. <br>Mount point '%2' for volume '%3' references an
invalid source disk. Please ensure that the source disk is also a clustered disk
and in the same group as the target disk (hosting the mount point).

### Event 1191: RES_NETNAME_DELETE_COMPUTER_ACCOUNT_FAILED_STATUS

Cluster network name resource '%1' failed to delete its associated computer
object in domain '%2'. The error code was '%3'. <br>Please have a domain
administrator manually delete the computer object from the Active Directory
domain.

### Event 1192: RES_NETNAME_DELETE_COMPUTER_ACCOUNT_FAILED

Cluster network name resource '%1' failed to delete its associated computer
object in domain '%2' for the following reason:<br>%3. <br><br>Please have a domain
administrator manually delete the computer object from the Active Directory
domain.

### Event 1193: RES_NETNAME_ADD_COMPUTER_ACCOUNT_FAILED_STATUS

Cluster network name resource '%1' failed to create its associated computer
object in domain '%2' for the following reason: %3.<br><br>The associated error code
is: %5<br><br>
Please work with your domain administrator to ensure that:

- The cluster identity '%4' can create computer objects. By default all computer
objects are created in the 'Computers' container; consult the domain
administrator if this location has been changed.
- The quota for computer objects has not been reached.
- If there is an existing computer object, verify
the Cluster Identity '%4' has 'Full Control' permission to that computer object
using the Active Directory Users and Computers tool.

### Event 1194: RES_NETNAME_ADD_COMPUTER_ACCOUNT_FAILED

Cluster network name resource '%1' failed to create its associated computer
object in domain '%2' during: %3.<br><br>The text for the associated error code is:
%4

Please work with your domain administrator to ensure that:

- The cluster identity '%5' has Create Computer Objects permissions. By default all computer
objects are created in the same container as the cluster identity '%5'.
- The quota for computer objects has not been reached.
- If there is an existing computer object, verify the Cluster Identity '%5' has 'Full Control' permission
to that computer object using the Active Directory Users and Computers tool.

### Event 1195: RES_NETNAME_DNS_REGISTRATION_FAILED_STATUS

Cluster network name resource '%1' failed registration of one or more associated
DNS name(s). The error code was '%2'. Ensure that the network adapters
associated with dependent IP address resources are configured with access to at
least one DNS server.

### Event 1196: RES_NETNAME_DNS_REGISTRATION_FAILED

Cluster network name resource '%1' failed registration of one or more associated
DNS name(s) for the following reason:<br>%2.<br><br>Ensure that the network adapters
associated with dependent IP address resources are configured with at least one
accessible DNS server.

### Event 1205: RCM_EVENT_GROUP_FAILED_ONLINE_OFFLINE

The Cluster service failed to bring clustered role '%1' completely online or
offline. One or more resources may be in a failed state. This may impact the
availability of the clustered role.

### Event 1206: RES_NETNAME_UPDATE_COMPUTER_ACCOUNT_FAILED_STATUS

The computer object associated with the cluster network name resource '%1' could
not be updated in domain '%2'. The error code was '%3'. The cluster identity
'%4' may lack permissions required to update the object. Please work with your
domain administrator to ensure that the cluster identity can update computer
objects in the domain.

### Event 1207: RES_NETNAME_UPDATE_COMPUTER_ACCOUNT_FAILED

The computer object associated with the cluster network name resource '%1' could
not be updated in domain '%2' during the <br>%3 operation.<br><br>The text for the
associated error code is: %4<br> <br>The cluster identity '%5' may lack permissions
required to update the object. Please work with your domain administrator to
ensure that the cluster identity can update computer objects in the domain.

### Event 1208: RES_DISK_INVALID_MP_TARGET_NOT_CLUSTERED

Cluster disk resource '%1' contains an invalid mount point. Both the source and
target disks associated with the mount point must be clustered disks, and must
be members of the same group. <br>Mount point '%2' for volume '%3' references an
invalid target disk. Please ensure that the target disk is also a clustered disk
and in the same group as the source disk (hosting the mount point).

### Event 1211: RES_NETNAME_NO_WRITEABLE_DC_STATUS

Cluster network name resource '%1' cannot be brought online. Attempt to locate a
writeable domain controller (in domain %2) in order to create or update a
computer object associated with the resource failed. The error code was '%3'.
Ensure that a writeable domain controller is accessible to this node within the
configured domain. Also ensure that the DNS server is running in order to
resolve the name of the domain controller.

### Event 1212: RES_NETNAME_NO_WRITEABLE_DC

Cluster network name resource '%1' cannot be brought online. Attempt to locate a
writeable domain controller (in domain %2) in order to create or update a
computer object associated with the resource failed for the following
reason:<br>%3.<br><br> The error code was '%4'. Ensure that a writeable domain
controller is accessible to this node within the configured domain. Also ensure
that the DNS server is running in order to resolve the name of the domain
controller.

### Event 1213: RES_NETNAME_RENAME_RESTORE_FAILED

Cluster network name resource '%1' could not completely rename the associated
computer object on domain controller '%2'. Attempting to rename the computer
object from new name '%3' back to its original name '%4' has also failed. The
error code was '%5'. This may affect client connectivity until the network name
and its associated computer object name are consistent. Contact your domain
administrator to manually rename the computer object.

### Event 1214: RES_NETNAME_CANT_ADD_NAME2

Cluster Network Name resource cannot be registered with Netbios. <br><br>Network
Name: '%3' <br>Reason for failure: %2 <br>Resource name:'%1' <br><br> Run nbtstat for
the network name to ensure that the name is not already registered with Netbios.

### Event 1215: RES_NETNAME_NOT_REGISTERED_WITH_RDR

Cluster network name resource '%1' failed a health check. Network name '%2' is
no longer registered on this node. The error code was '%3'. Check for hardware
or software errors related to the network adapter. Also, you can run the
Validate a Configuration wizard to check your network configuration.

### Event 1218: RES_NETNAME_ONLINE_RENAME_RECOVERY_MISSING_ACCOUNT

Cluster network name resource '%1' failed to perform a name change operation
(attempting to change original name '%3' to name '%4'). The computer object
could not be found on the domain controller '%2' (where it was created). An
attempt will be made to recreate the computer object the next time the resource
is brought online. Additionally, please work with your domain administrator to
ensure that the computer object exists in the domain.

### Event 1219: RES_NETNAME_ONLINE_RENAME_DC_NOT_FOUND

Cluster network name resource '%1' failed to perform a name change operation.
The domain controller '%2' where computer object '%3' was being renamed, could
not be contacted. The error code was '%4'. Ensure a writeable domain controller
is accessible and check for any connectivity issue.

### Event 1220: RES_NETNAME_ONLINE_RENAME_RECOVERY_FAILED

The computer account for resource '%1' failed to be renamed from %2 to %3 using
Domain Controller %4. The associated error code is stored in the data section.<br>
<br>The computer account for this resource was in the process of being renamed and
did not complete. This was detected during the online process for this resource.
In order to recover, the computer account must be renamed to the current value
of the Name property, i.e., the name presented on the network.<br> <br>The Domain
Controller where the renamed was attempted might not be available; if this is
the case, wait for the Domain Controller to be available again. The Domain
Controller could be denying access to the account; after resolving access, try
to bring the name online again.<br> <br>If this is not possible, disable and
re-enable Kerberos Authentication and an attempt will be made to find the
computer account on a different DC. You need to change the Name property to %2
in order to use the existing computer account.

### Event 1223: RES_IPADDR_INVALID_NETWORK_ROLE

Cluster IP address resource '%1' cannot be brought online because the cluster
network '%2' is not configured to allow client access. Please use the Failover
Cluster Manager snap-in to check the configured properties of the cluster
network.

### Event 1226: RES_NETNAME_TCB_NOT_HELD

Network Name resource '%1' (with associated network name '%2') has Kerberos
Authentication support enabled. Failed to add required credentials to the LSA -
the associated error code '%3' indicates insufficient privileges normally
required for this operation. The required privilege is 'Trusted Computing Base'
and must be locally enabled on each node comprising the cluster.

### Event 1227: RES_NETNAME_LSA_ERROR

Network Name resource '%1' (with associated network name '%2') has Kerberos
Authentication support enabled. Failed to add required credentials to the LSA -
the associated error code is '%3'.

### Event 1228: RES_NETNAME_CLONE_FAILURE

Cluster network name resource '%1' encountered an error enabling the network
name on this node. The reason for the failure was: <br> '%2'.<br><br> The error code
was '%3'. <br><br> You may take the network name resource offline and online again
to retry.

### Event 1229: RES_NETNAME_NO_IPS_FOR_DNS

Cluster network name resource '%1' was unable to identify any IP addresses to
register with a DNS server. Ensure that there is one or more networks that are
enabled for cluster use with the 'Allow clients to connect through this network'
setting, and that each node has a valid IP address configured for the networks.

### Event 1230: RCM_DEADLOCK_OR_CRASH_DETECTED

A component on the server did not respond in a timely fashion. This caused the
cluster resource '%1' (resource type '%2', DLL '%3') to exceed its time-out
threshold. As part of cluster health detection, recovery actions will be taken.
The cluster will try to automatically recover by terminating and restarting the
Resource Hosting Subsystem (RHS) process that is running this resource. Verify
that the underlying infrastructure (such as storage, networking, or services)
that are associated with the resource are functioning correctly.

### Event 1230: RCM_RESOURCE_CONTROL_DEADLOCK_DETECTED

A component on the server did not respond in a timely fashion. This caused the
cluster resource '%1' (resource type '%2', DLL '%3') to exceed its time-out
threshold while processing control code '%4;'. As part of cluster health
detection, recovery actions will be taken. The cluster will try to automatically
recover by terminating and restarting the Resource Hosting Subsystem (RHS)
process that is running this resource. Verify that the underlying infrastructure
(such as storage, networking, or services) that are associated with the resource
are functioning correctly.

### Event 1231: RES_NETNAME_LOGON_FAILURE

Cluster network name resource '%1' encountered an error logging on to the
domain. The reason for the failure was: <br> '%2'.<br><br> The error code was '%3'.
<br><br> Ensure that a domain controller is accessible to this node within the
configured domain.

### Event 1232: RES_GENSCRIPT_TIMEOUT

Entry point '%2' in cluster generic script resource '%1' did not complete
execution in a timely manner. This could be due to an infinite loop or other
issues possibly resulting in an infinite wait. Alternatively, the specified
pending timeout value may be too short for this resource. Please review the '%2'
script entry point to ensure all possible infinite waits in the script code have
been corrected. Then, consider increasing the pending timeout value if deemed
necessary.

### Event 1233: RES_GENSCRIPT_HANGMODE

Cluster generic script resource '%1': request to perform the '%2' operation will
not be processed. This is due to a previously failed attempt to execute the '%3'
entry point in a timely fashion. Please review the script code for this entry
point to ensure there does not exist any infinite loop or other issues possibly
resulting in an infinite wait. Then, consider increasing the resource pending
timeout value if deemed necessary.

### Event 1234: CLUSTER_EVENT_ACCOUNT_MISSING_PRIVS

The Cluster service has detected that its service account is missing one or more
of the required privileges. The missing privilege list is: '%1' and is not
currently granted to the service account. Use the 'sc.exe qprivs clussvc' to
verify the privileges of the Cluster service (ClusSvc). Additionally check for
any security policies or group policies in Active Directory Domain Services that
may have altered the default privileges. Type the following command to grant the
Cluster service the necessary privileges to function correctly:

```
sc.exe privs
clussvc
SeBackupPrivilege/SeRestorePrivilege/SeIncreaseQuotaPrivilege/SeIncreaseBasePriorityPrivilege/SeTcbPrivilege/SeDebugPrivilege/SeSecurityPrivilege/SeAuditPrivilege/SeImpersonatePrivilege/SeChangeNotifyPrivilege/SeIncreaseWorkingSetPrivilege/SeManageVolumePrivilege/SeCreateSymbolicLinkPrivilege/SeLoadDriverPrivilege
```

### Event 1242: RES_IPADDR_LEASE_EXPIRED

Lease of IP address '%2' associated with cluster IP address resource '%1' has
expired or is about to expire, and currently cannot be renewed. Ensure that the
associated DHCP server is accessible and properly configured to renew the lease
on this IP address.

### Event 1245: RES_IPADDR_LEASE_RENEWAL_FAILED

Cluster IP address resource '%1' failed to renew the lease for IP address '%2'.
Ensure that the DHCP server is accessible and properly configured to renew the
lease on this IP address.

### Event 1250: RCM_RESOURCE_EMBEDDED_FAILURE

Cluster resource '%1' in clustered role '%2' has received a critical state
notification. For a virtual machine this indicates that an application or
service inside the virtual machine is in an unhealthy state. Verify the
functionality of the service or application being monitored within the virtual
machine.

### Event 1254: RCM_GROUP_TERMINAL_FAILURE

Clustered role '%1' has exceeded its failover threshold. It has exhausted the
configured number of failover attempts within the failover period of time
allotted to it and will be left in a failed state. No additional attempts will
be made to bring the role online or fail it over to another node in the cluster.
Please check the events associated with the failure. After the issues causing
the failure are resolved the role can be brought online manually or the cluster
may attempt to bring it online again after the restart delay period.

### Event 1255: RCM_RESOURCE_NETWORK_FAILURE

Cluster resource '%1' in clustered role '%2' has received a critical state
notification. For a virtual machine this indicates that a critical network of
the virtual machine is in an unhealthy state. Verify the network connectivity of
the virtual machine and the virtual networks that the virtual machine is
configured to use.

### Event 1256: RES_NETNAME_DNS_REGISTRATION_FAILED_DYNAMIC_DNS_ZONE

Cluster network name resource failed registration of one or more associated DNS
names(s) because the corresponding DNS Zone does not accept dynamic
updates.<br><br>Cluster Network name: '%1'<br>DNS Zone: '%2'

#### Guidance

Ensure that the DNS is configured as a Dynamic DNS zone. If the DNS server does not accept
dynamic updates uncheck the 'Register this connection's' addresses in DNS' in
the properties of the network adapter.

### Event 1257: RES_NETNAME_DNS_REGISTRATION_FAILED_SECURE_DNS_ZONE

Cluster network name resource failed registration of one or more associated DNS
names(s) because the access to update the secure DNS Zone was denied.<br><br>Cluster
Network name: '%1'<br>DNS Zone: '%2'<br><br>Ensure that cluster name object (CNO) is
granted permissions to the Secure DNS Zone.

### Event 1258: RES_NETNAME_DNS_REGISTRATION_FAILED_TIMEOUT

Cluster network name resource failed registration of one or more associated DNS
name(s) because the a DNS server could not be reached.<br><br>Cluster Network name:
'%1'<br>DNS Zone: '%2'<br>DNS Server: '%3'<br><br>Ensure that the network adapters
associated with dependent IP address resources are configured with at least one
accessible DNS server.

### Event 1259: RES_NETNAME_DNS_REGISTRATION_FAILED_CLEANUP

Cluster network name resource failed registration of one or more associated DNS
name(s) because the cluster service failed clean up the existing records
corresponding to the network name.<br><br>Cluster Network name: '%1'<br>DNS Zone:
'%2'<br><br>Ensure that cluster name object (CNO) is granted permissions to the
Secure DNS Zone.

### Event 1260: RES_NETNAME_DNS_REGISTRATION_MODIFY_FAILED

Cluster network name resource failed to modify the DNS registration.<br><br>Cluster
Network name: '%1'<br>Error code: '%2'

#### Guidance

Ensure that the network adapters associated with dependent IP address resources are configured with
access to at least one DNS server.

### Event 1261: RES_NETNAME_DNS_REGISTRATION_MODIFY_FAILED_STATUS

Cluster network name resource failed to modify the DNS registration.<br><br>Cluster
Network name: '%1'<br>Reason: '%2'

#### Guidance

Ensure that the network adapters associated with dependent IP address resources are configured with access to at least one DNS server.

### Event 1262: RES_NETNAME_DNS_REGISTRATION_PUBLISH_PTR_FAILED

Cluster network name resource failed to publish the PTR record in the DNS
reverse lookup zone.<br><br>Cluster Network name: '%1'<br>Error Code:
'%2'

#### Guidance

Ensure that the network adapters associated with dependent
IP address resources are configured with access to at least one DNS server and
that the DNS reverse lookup zone exists.

### Event 1264: RES_NETNAME_DNS_REGISTRATION_PUBLISH_PTR_FAILED_STATUS

Cluster network name resource failed to publish the PTR record in the DNS
reverse lookup zone.<br><br>Cluster Network name: '%1'<br>Reason:
'%2'

#### Guidance

Ensure that the network adapters associated with dependent IP address resources are configured with access to at least one DNS server and that the DNS reverse lookup zone exists.

### Event 1265: RES_TYPE_CONTROL_TIMED_OUT

Cluster resource type '%1' timed out while processing the control code %2. The
cluster will try to automatically recover by terminating and restarting the
Resource Hosting Subsystem (RHS) process that was processing the call.

### Event 1289: NETFT_ADAPTER_NOT_FOUND

The Cluster Service was unable to access network adapter '%1'. Verify that other
network adapters are functioning properly and check the device manager for
errors associated with adapter '%1'. If the configuration for adapter '%1' has
been changed, it may become necessary to reinstall the failover clustering
feature on this computer.

### Event 1360: RES_IPADDR_INVALID_NETWORK

Cluster IP address resource '%1' failed to come online. Ensure the network
property '%2' matches a cluster network name or the address property '%3'
matches one of the subnets on a cluster network. If this is an IPv6 Address
type, please verify that the cluster network matching this resource has at least
one IPv6 prefix that is not link-local or tunnel.

### Event 1361: RES_IPADDR_MISSING_DEPENDANT

IPv6 Tunnel address resource '%1' failed to come online because it does not
depend on an IP Address (IPv4) resource. Dependency on at least one IP Address
(IPv4) resource is required.

### Event 1362: RES_IPADDR_MISSING_DATA

Cluster IP address resource '%1' failed to come online because the '%2' property
could not be read. Please ensure that the resource is correctly configured.

### Event 1363: RES_IPADDR_NO_ISATAP_SUPPORT

IPv6 tunnel address resource '%1' failed to come online. Cluster network '%2'
associated with dependent IP address (IPv4) resource '%3' does not support
ISATAP tunneling. Please ensure that the cluster network supports ISATAP
tunneling.

### Event 1540: SERVICE_BACKUP_NOQUORUM

The backup operation for the cluster configuration data has been aborted because
quorum for the cluster has not yet been achieved. Please retry this backup
operation after the cluster achieves quorum.

### Event 1554: SERVICE_RESTORE_INVALIDUSER

The restore operation for the cluster configuration data has failed. This was
due to insufficient privileges associated with the user account performing the
restore. Please ensure that the user account has local administrator privileges.

### Event 1557: SERVICE_WITNESS_ATTACH_FAILED

Cluster service failed to update the cluster configuration data on the witness
resource. Please ensure that the witness resource is online and accessible.

### Event 1559: RES_WITNESS_NEW_NODE_CONFLICT

File share '%1' associated with the file share witness resource is currently
hosted by server '%2'. This server '%2' has just been added as a new node within
the failover cluster. Hosting of the file share witness by any node comprising
the same cluster is not recommended. Please choose a file share witness that is
not hosted by any node within the same cluster and modify settings of the file
share witness resource accordingly.

### Event 1560: RES_SMB_SHARE_CONFLICT

Cluster file share resource '%1' has detected shared folder conflicts. As a
result, some of these shared folders may not be accessible. To rectify this
situation, ensure multiple shared folders do not have the same share name.

### Event 1563: RES_FSW_ONLINEFAILURE

File share witness resource '%1' failed to come online. Please ensure that file
share '%2' exists and is accessible by the cluster.

### Event 1566: RES_NETNAME_TIMEDOUT

Cluster network name resource '%1' cannot be brought online. The network name
resource was terminated by the resource host subsystem because it did not
complete an operation in an acceptable time. The operation timed out while
performing:<br> '%2'

### Event 1567: SERVICE_FAILED_TO_CHANGE_LOG_SIZE

Cluster service failed to change the trace log size. Please verify the
ClusterLogSize setting with the 'Get-Cluster \| Format-List \*' PowerShell
cmdlet. Also, use the Performance Monitor snapin to verify the event trace
session settings for FailoverClustering.

### Event 1567: RES_VIPADDR_ADDRESS_INTERFACE_FAILED

Health check for IP interface '%1'(address '%2') failed (status is '%3'). Check
for hardware or software errors related to the physical or virtual network
adapters.

### Event 1568: RES_CLOUD_WITNESS_CANT_COMMUNICATE_TO_AZURE

Cloud witness resource could not reach Microsoft Azure storage
services.<br><br>Cluster resource: %1 <br>Cluster node: %2 

#### Guidance

This could be due to network communication between the cluster node and the Microsoft
Azure service being blocked. Verify the node's internet connectivity to
Microsoft Azure. Connect to the Microsoft Azure portal and verify that the
storage account exists.

### Event 1569: SERVICE_USING_RESTRICTED_NETWORK

Network '%1' which has been disabled for failover cluster use, was found to be
the only currently possible network that node '%2' can use to communicate with
other nodes in the cluster. This may impact the node's ability to participate in
the cluster. Please verify network connectivity of node '%2' and enable at least
one network for cluster communication. Run the Validate a Configuration wizard
to check your network configuration.

### Event 1569: RES_CLOUD_WITNESS_TOKEN_EXPIRED

Cloud witness resource failed to authenticate with Microsoft Azure storage
services. An access denied error was returned while attempting to contact the
Microsoft Azure storage account. <br><br>Cluster resource: %1 

#### Guidance

The storage account's access key may no longer be valid. Use the Configure
Cluster Quorum Wizard in the Failover Cluster Manager or the Set-ClusterQuorum
Windows PowerShell cmdlet, to configure the Cloud witness resource with the
updated storage account access key.

### Event 1573: SERVICE_FORM_WITNESS_FAILED

Node '%1' failed to form a cluster. This was because the witness was not
accessible. Please ensure that the witness resource is online and available.

### Event 1580: RES_NETNAME_DNS_REGISTRATION_SECURE_ZONE_FAILED

Cluster network name resource '%1' failed to register the name '%2' over adapter
'%4' in a secure DNS zone. This was due to an existing record with this name and
the cluster identity does not have the sufficient privileges to update that
record. The error code was '%3'. Please contact your DNS server administrator to
verify the cluster identity has permissions on DNS record '%2'.

### Event 1580: RES_NETNAME_DNS_REGISTRATION_SECURE_ZONE_FAILED

Cluster network name resource '%1' failed to register the name '%2' over adapter
'%4' in a secure DNS zone. This was due to an existing record with this name and
the cluster identity does not have the sufficient privileges to update that
record. The error code was '%3'. Please contact your DNS server administrator to
verify the cluster identity has permissions on DNS record '%2'.

### Event 1585: RES_FILESERVER_FSCHECK_SRVSVC_STOPPED

Cluster file server resource '%1' failed a health check. This was due to the
Server service not being started. Please use Server Manager to confirm the state
of the Server service on this cluster node.

### Event 1586: RES_FILESERVER_FSCHECK_SCOPED_NAME_NOT_REGISTERED

Cluster file server resource '%1' failed a health check. This was because some
of its shared folders were inaccessible. Verify that the folders are accessible
from clients. Additionally, confirm the state of the Server service on this
cluster node using Server Manager and look for other events related to the
Server service on this cluster node. It may be necessary to restart the network
name resource '%2' in this clustered role.

### Event 1587: RES_FILESERVER_FSCHECK_FAILED

Cluster file server resource '%1' failed a health check. This was because some
of its shared folders were inaccessible. Verify that the folders are accessible
from clients. Additionally, confirm the state of the Server service on this
cluster node using Server Manager and look for other events related to the
Server service on this cluster node.

### Event 1588: RES_FILESERVER_SHARE_CANT_ADD

Cluster file server resource '%1' cannot be brought online. The resource failed
to create file share '%2' associated with network name '%3'. The error code was
'%4'. Verify that the folders exist and are accessible. Additionally, confirm
the state of the Server service on this cluster node using Server Manager and
look for other related events on this cluster node. It may be necessary to
restart the network name resource '%3' in this clustered role.

### Event 1600: CLUSAPI_CREATE_CANNOT_SET_AD_DACL

Cluster service failed to set the permissions on the cluster computer object
'%1'. Please contact your network administrator to check the cluster security
descriptor of the computer object in Active Directory, verify that the DACL is
not too big, and remove any unnecessary extra ACE(s) on the object if necessary.

### Event 1603: RES_FILESERVER_CLONE_FAILED

File Server could not start because expected dependency on 'Network Name'
resource was not found or it was not configured properly. Error=0x%2.

### Event 1606: RES_DISK_CNO_CHECK_FAILED

Cluster disk resource '%1' contains a BitLocker-protected volume, '%2', but for
this volume, the Active Directory cluster name account (also called the cluster
name object or CNO) is not a BitLocker protector for the volume. This is
required for BitLocker-protected volumes. To correct this, first remove the disk
from the cluster. Next, use the Manage-bde.exe command-line tool to add the
cluster name as an ADAccountOrGroup protector, using the format
domain\\ClusterName\$ for the cluster name. Then add the disk back to the
cluster. For more information, see the documentation for Manage-bde.exe

### Event 1607: RES_DISK_CNO_UNLOCK_FAILED

Cluster disk resource '%1' was unable to unlock the BitLocker-protected volume
'%2'. The cluster name object (CNO) is not set to be a valid BitLocker protector
for this volume. To correct this, remove the disk from the cluster. Then use the
Manage-bde.exe command-line tool to add the cluster name as an ADAccountOrGroup
protector, using the format domain\\ClusterName\$, and add the disk back to the
cluster. For more information, see the documentation for Manage-bde.exe.

### Event 1608: RES_FILESERVER_LEADER_FAILED

File Server could not start because expected dependency on 'Network Name'
resource was not found or it was not configured properly. Error=0x%2.

### Event 1609: RES_SODA_FILESERVER_LEADER_FAILED

Scale Out File Server could not start because expected dependency on
'Distributed Network Name' resource was not found or it was not configured
properly. Error=0x%2.

### Event 1632: CLUSAPI_CREATE_MISMATCHED_OU

The creation of the cluster failed. Unable to create the cluster name object
'%1' in active directory organizational unit '%2'. The object already exists in
organizational unit '%3'. Verify that the specified distinguished name path and
the cluster name object are correct. If the distinguished name path is not
specified, the existing computer object '%1' will be used.

### Event 1652: SERVICE_TCP_CONNECTION_FAILURE

Cluster node '%1' failed to join the cluster. A TCP connection could not be
established to node(s) '%2'. Verify network connectivity and configuration of
any network firewalls.

### Event 1652: SERVICE_UDP_CONNECTION_FAILURE

Cluster node '%1' failed to join the cluster. A UDP connection could not be
established to node(s) '%2'. Verify network connectivity and configuration of
any network firewalls.

### Event 1652: SERVICE_VIRTUAL_TCP_CONNECTION_FAILURE

Cluster node '%1' failed to join the cluster. A TCP connection using the
Microsoft Failover Cluster Virtual Adapter could not be established to node(s)
'%2'. Verify network connectivity and configuration of any network firewalls.

### Event 1653: SERVICE_NO_CONNECTIVITY

Cluster node '%1' failed to join the cluster because it could not communicate
over the network with any other node in the cluster. Verify network connectivity
and configuration of any network firewalls.

### Event 1654: RES_VIPADDR_INVALID_ADAPTERNAME

Cluster Disjoint IP address resource '%1' failed to come online. Configuration
data for the network adapter corresponding to network adapter '%2' could not be
determined (error code was '%3'). Check that the IP address resource is
configured with the correct address and network properties.

### Event 1655: RES_VIPADDR_INVALID_VSID

Cluster Disjoint IP address resource '%1' failed to come online. Configuration
data for the network adapter corresponding to Virtual Subnet Id '%2' and Routing
Domain Id '%3' could not be determined (error code was '%4'). Check that the IP
address resource is configured with the correct address and network properties.

### Event 1656: RES_VIPADDR_ADDRESS_CREATE_FAILED

Failed to add the IP Address '%2' for Disjoint IP address resource '%1' (error
code was '%3'). Check for hardware or software errors related to the physical or
virtual network adapters.

### Event 1664: CLUSTER_UPGRADE_INCOMPLETE

Upgrading the functional level of the cluster failed. Check that all nodes of
the cluster are currently running and are the same version of Windows Server,
then run the Update-ClusterFunctionalLevel Windows PowerShell cmdlet again.

### Event 1676: EVENT_LOCAL_NODE_QUARANTINED

Local cluster node has been quarantined by '%1'. The node will be quarantined
until '%2' and then the node will automatically attempt to re-join the cluster.
<br><br>Refer to the System and Application event logs to determine the issues on
this node. When the issue is resolved, quarantine can be manually cleared to
allow the node to rejoin with the 'Start-ClusterNode –ClearQuarantine' Windows
PowerShell cmdlet.<br><br>QuarantineType : Quarantined by %1<br>Time quarantine will
be automatically cleared: %2

### Event 1677: EVENT_NODE_DRAIN_FAILED

Node drain failed on Cluster node %1. <br><br>Reference the node's System and
Application event logs and cluster logs to investigate the cause of the drain
failure. When the problem is resolved, you can retry the drain operation.

### Event 1683: RES_NETNAME_COMPUTER_ACCOUNT_NO_DC

The cluster service was unable to reach any available domain controller on the
domain. This may impact functionality that is dependent on Cluster network name
authentication.<br><br>DC Server: %1 

#### Guidance

Verify that domain controllers are accessible on the network to the cluster nodes.

### Event 1684: RES_NETNAME_COMPUTER_OBJECT_VCO_NOT_FOUND

Cluster network name resource failed to find the associated computer object in
Active Directory. This may impact functionality that is dependent on Cluster
network name authentication.<br><br>Network Name: %1<br>Organizational Unit:
%2

#### Guidance

Restore the computer object for the network name from the
Active Directory recycle bin. Alternately, offline the cluster network name
resource and run the Repair action to recreate the computer object in Active
Directory.

### Event 1685: RES_NETNAME_COMPUTER_OBJECT_CNO_NOT_FOUND

Cluster network name resource failed to find the associated computer object in
Active Directory. This may impact functionality that is dependent on Cluster
network name authentication.<br><br>Network Name: %1<br>Organizational Unit:
%2
#### Guidance

Restore the computer object for the network name from the Active Directory recycle bin.

### Event 1686: RES_NETNAME_COMPUTER_OBJECT_VCO_DISABLED

Cluster network name resource found the associated computer object in Active
Directory to be disabled. This may impact functionality that is dependent on
Cluster network name authentication.<br><br>Network Name: %1<br>Organizational Unit:
%2

#### Guidance

Enable the computer object for the network name in Active Directory.

### Event 1687: RES_NETNAME_COMPUTER_OBJECT_CNO_DISABLED

Cluster network name resource found the associated computer object in Active
Directory to be disabled. This may impact functionality that is dependent on
Cluster network name authentication.<br><br>Network Name: %1<br>Organizational Unit:
%2

#### Guidance

Enable the computer object for the network name in Active Directory. Alternately, offline the cluster network name resource and run the
Repair action to enable the computer object in Active Directory.

### Event 1688: RES_NETNAME_COMPUTER_OBJECT_FAILED

Cluster network name resource detected that the associated computer object in
Active Directory was disabled and failed in its attempt to enable it. This may
impact functionality that is dependent on Cluster network name
authentication.<br><br>Network Name: %1<br>Organizational Unit:
%2

#### Guidance

Enable the computer object for the network name in Active Directory.

### Event 4608: NODECLEANUP_GET_CLUSTERED_DISKS_FAILED

Cluster service failed to retrieve the list of clustered disks while destroying
the cluster. The error code was '%1'. If these disks are not accessible, execute
the 'Clear-ClusterDiskReservation' PowerShell cmdlet.

### Event 4611: NODECLEANUP_RELEASE_CLUSTERED_DISKS_FROM_PARTMGR_FAILED

Clustered disk with ID '%2' was not released by the Partition Manager while
destroying the cluster. The error code was '%1'. Restarting the machine will
ensure the disk is released by the Partition Manager.

### Event 4613: NODECLEANUP_CLEAR_CLUSDISK_DATABASE_FAILED

The cluster service failed to properly cleanup a clustered disk with ID '%2'
while destroying the cluster. The error code was '%1'. You may unable to access
this disk until cleanup has been successfully completed. For manual cleanup,
delete the 'AttachedDisks' value of the
'HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\ClusDisk\\Parameters'
key in the Windows registry.

### Event 4615: NODECLEANUP_DISABLE_CLUSTER_SERVICE_FAILED

The cluster service has been stopped and set as disabled as part of cluster node
cleanup.

### Event 4616: NODECLEANUP_DISABLE_CLUSTER_SERVICE_TIMEOUT

Termination of the cluster service during cluster node cleanup has not completed
within the expected time period. Please restart this machine to ensure the
cluster service is no longer running.

### Event 4618: NODECLEANUP_RESET_CLUSTER_REGISTRY_ENTRIES_FAILED

Resetting cluster service registry entries during cluster node cleanup failed.
The error code was '%1'. You may be unable to create or join a cluster with this
machine until cleanup has been successfully completed. For manual cleanup,
execute the 'Clear-ClusterNode' PowerShell cmdlet on this machine.

### Event 4620: NODECLEANUP_UNLOAD_CLUSTER_HIVE_FAILED

Unloading the cluster service registry hive during cluster node cleanup failed.
The error code was '%1'. You may be unable to create or join a cluster with this
machine until cleanup has been successfully completed. For manual cleanup,
execute the 'Clear-ClusterNode' PowerShell cmdlet on this machine.

### Event 4622: NODECLEANUP_ERRORS

The Cluster service encountered an error during node cleanup. You may be unable
to create or join a cluster with this machine until cleanup has been
successfully completed. Use the 'Clear-ClusterNode' PowerShell cmdlet on this
node.

### Event 4624: NODECLEANUP_RESET_NLBSFLAGS_FAILED

Resetting the IPSec security association timeout registry value failed during
cluster node cleanup. The error code was '%1'. For manual cleanup, execute the
'Clear-ClusterNode' PowerShell cmdlet on this machine. Alternatively, you may
reset the IPSec security association timeout by deleting the '%2' value and the
'%3' value from HKEY_LOCAL_MACHINE in the Windows registry.

### Event 4627: NODECLEANUP_DELETE_CLUSTER_TASKS_FAILED

Deletion of clustered tasks during node cleanup failed. The error code was '%1'.
Use Windows Task Scheduler to delete any remaining clustered tasks.

### Event 4629: NODECLEANUP_DELETE_LOCAL_ACCOUNT_FAILED

During node cleanup, the local user account that is managed by the cluster was
not deleted. The error code was '%1'. Open Local Users and Groups (lusrmgr.msc)
to delete the account.

### Event 4864: RES_VSSTASK_OPEN_FAILED

Volume shadow copy service task resource '%1' creation failed. The error code
was '%2'.

### Event 4865: RES_VSSTASK_TERMINATE_TASK_FAILED

Volume shadow copy service task resource '%1' failed. The error code was '%2'.
This is because the associated task could not be stopped as part of an offline
operation. You may need to stop it manually using the Task Scheduler snapin.

### Event 4866: RES_VSSTASK_DELETE_TASK_FAILED

Volume shadow copy service task resource '%1' failed. The error code was '%2'.
This is because the associated task could not be deleted as part of an offline
operation. You may need to delete it manually using the Task Scheduler snapin.

### Event 4867: RES_VSSTASK_ONLINE_FAILED

Volume shadow copy service task resource '%1' failed. The error code was '%2'.
This is because the associated task could not be added as part of an online
operation. Please use the Task Scheduler snapin to ensure your tasks are
properly configured.

### Event 4868: UNABLE_TO_START_AUTOLOGGER

Cluster service failed to start the cluster log trace session. The error code
was '%2'. The cluster will function properly, but supplemental logging
information will be missing. Use the Performance Monitor snapin to verify the
event channel settings for '%1'.

### Event 4869: NETFT_WATCHDOG_PROCESS_HUNG

User mode health monitoring has detected that the system is not being
responsive. The Failover cluster virtual adapter has lost contact with the '%1'
process with a process ID '%2', for '%3' seconds. Please use Performance Monitor
to evaluate the health of the system and determine which process may be
negatively impacting the system.

### Event 4870: NETFT_WATCHDOG_PROCESS_TERMINATED

User mode health monitoring has detected that the system is not being
responsive. The Failover cluster virtual adapter has lost contact with the '%1'
process with a process ID '%2', for '%3' seconds. Recovery action will be taken.

### Event 4871: NETFT_MINIPORT_INITIALIZATION_FAILURE

The cluster service failed to start. This was because the failover cluster
virtual adapter failed to initialize the miniport adapter. The error code was
'%1'. Verify that other network adapters are functioning properly and check the
device manager for errors. If the configuration was changed, it may be necessary
to reinstall the failover clustering feature on this computer.

### Event 4872: NETFT_MISSING_DATALINK_ADDRESS

The failover cluster virtual adapter failed to generate a unique MAC address.
Either it was unable to find a physical Ethernet adapter from which to generate
a unique address or the generated address conflicts with another adapter on this
machine. Please run the Validate a Configuration wizard to check your network
configuration.

### Event 5122: DCM_EVENT_ROOT_CREATION_FAILED

Cluster service failed to create the Cluster Shared Volumes root directory '%2'.
The error message was '%1'.

### Event 5142: DCM_VOLUME_NO_ACCESS

Cluster Shared Volume '%1' ('%2') is no longer accessible from this cluster node
because of error '%3'. Please troubleshoot this node's connectivity to the
storage device and network connectivity.

### Event 5143: DCM_VETO_RESOURCE_MOVE_DUE_TO_CC

Move of the disk ('%2') is vetoed based on the current state of the Cache
Manager on the node '%1' to prevent a potential deadlock. 'Cache Manager Dirty
Pages Theshold' is %3, and 'Cache Manager Dirty Pages' is %4. Move is allowed if
'Cache Manager Dirty Pages' is less than 70% of 'Cache Manager Dirty Pages
Theshold' or if 'Cache Manager Dirty Pages Theshold' minus 'Cache Manager Dirty
Pages' is greater than 128000 pages (about 500MB if a page size is 4096 bytes).
Cluster vetoed resource move to prevent potential deadlock due to Cache Manager
throttling buffered writes while Cluster Shared Volumes on this disk are being
paused.

### Event 5144: DCM_SNAPSHOT_DIFF_AREA_FAILURE

While adding the disk ('%1') to Cluster Shared Volumes, setting explicit
snapshot diff area association for volume ('%2') failed with error '%3'. The
only supported software snapshot diff area association for Cluster Shared
Volumes is to self.

### Event 5145: DCM_SNAPSHOT_DIFF_AREA_DELETE_FAILURE

Cluster disk resource '%1' failed to delete a software snapshot. The diff area
on volume '%3' could not be dissociated from volume '%2'. This may be caused by
active snapshots. Cluster Shared Volumes requires that the software snapshot be
located on the same disk.

### Event 5146: DCM_VETO_RESOURCE_MOVE_DUE_TO_DISMOUNT

Move of the Cluster Shared Volume resource '%1' is vetoed because one
of the volumes belonging to the resource is in dismounted state. Please retry
the action after the dismount operation is completed.

### Event 5147: DCM_VETO_RESOURCE_MOVE_DUE_TO_SNAPSHOT

Move of the Cluster Shared Volume resource '%1' is vetoed because one of the
volumes belonging to the resource is in dismounted state. Please retry the
action after the dismount operation is completed.

### Event 5148: DCM_VETO_RESOURCE_MOVE_DUE_TO_IO_MODE_CHANGE

Move of the Cluster Shared Volume resource '%1' is vetoed because an IO mode
change operation (Direct IO to Redirected IO or vice versa) is in progress on
one of the volumes belonging to the resource. Please retry the action after the
operation is completed.

### Event 5150: DCM_SET_RESOURCE_IN_FAILED_STATE

Cluster physical disk resource '%1' failed. The Cluster Shared Volume was put in
failed state with the following error: '%2'

### Event 5200: CAM_CANNOT_CREATE_CNO_TOKEN

Cluster service failed to create a cluster identity token for Cluster Shared
Volumes. The error code was '%1'. Ensure the domain controller is accessible and
check for connectivity issues. Until connection to the domain controller is
recovered, some operations on this node against the Cluster Shared Volumes might
fail.

### Event 5216: CSV_SW_SNAPSHOT_FAILED

Software snapshot creation on Cluster Shared Volume '%1' ('%2') failed with
error %3. The resource must be online to support snapshot creation. Please check
the state of the resource.

### Event 5217: CSV_SW_SNAPSHOT_SET_FAILED

Software snapshot creation on Cluster Shared Volume(s) ('%1') with snapshot set
id '%2' failed with error '%3'. Please check the state of the CSV resources and
the system events of the resource owner nodes.

### Event 5219: CSV_REGISTER_SNAPSHOT_PROV_WITH_VSS_FAILED

Cluster service failed to register the Cluster Shared Volumes snapshot provider
with the Volume Shadow Service (VSS). This may be due to the VSS service
shutting down or may be a problem with the VSS service having a problem that
causes it to not accept incoming requests. <br>Error: %1

### Event 5377: OPERATION_EXCEEDED_TIMEOUT

An internal Cluster service operation exceeded the defined threshold of '%2'
seconds. The Cluster service has been terminated to recover. Service Control
Manager will restart the Cluster service and the node will rejoin the cluster.

### Event 5396: TWO_PARTITIONS_HAVE_QUORUM

The Cluster service on this node is shutting down because it has detected that
there are other cluster nodes that have quorum. This occurs when the Cluster
service detects another node that was started with the Force Quorum switch
(/fq). The node which was started with the Force Quorum Switch will remain
running. Use Failover Cluster Manager to verify that this node automatically
joined the cluster when the cluster service restarted.

### Event 5397: RLUA_ACCOUNT_FAILED

The cluster resource '%1' could not create or modify the replicated local user
account '%2' on this node. Check the cluster logs for more information.

### Event 5398: NM_EVENT_CLUSTER_FAILED_TO_FORM

Cluster failed to start. The latest copy of cluster configuration data was not
available within the set of nodes attempting to start the cluster. Changes to
the cluster occurred while the set of nodes were not in membership and as a
result were not able to receive configuration data updates. .<br><br>Votes required
to start cluster: %1<br>Votes available: %2<br>Nodes with votes:
%3

#### Guidance

Attempt to start the cluster service on all nodes in the cluster so that nodes with the latest copy of the cluster configuration data can first form the cluster. The cluster will be able to start and the nodes will
automatically obtain the updated cluster configuration data. If there are no
nodes available with the latest copy of the cluster configuration data, run the
'Start-ClusterNode -FQ' Windows PowerShell cmdlet. Using the ForceQuorum (FQ)
parameter will start the cluster service and mark this node's copy of the
cluster configuration data to be authoritative. Forcing quorum on a node with an
outdated copy of the cluster database may result in cluster configuration
changes that occurred while the node was not participating in the cluster to be
lost.

## Warning events

### Event 1011: NM_NODE_EVICTED

Cluster node %1 has been evicted from the failover cluster.

### Event 1045: RES_IPADDR_IPV4_ADDRESS_CREATE_FAILED

No matching network interface found for resource '%1' IP address '%2' (return
code was '%3'). If your cluster nodes span different subnets, this may be
normal.

### Event 1066: RES_DISK_CORRUPT_DISK

Cluster disk resource '%1' indicates corruption for volume '%2'. Chkdsk is being
run to repair problems. The disk will be unavailable until Chkdsk completes.
Chkdsk output will be logged to file '%3'.<br> Chkdsk may also write information
to the Application Event Log.

### Event 1068: RES_SMB_SHARE_CANT_ADD

Cluster file share resource '%1' cannot be brought online. Creation of file
share '%2' (scoped to network name %3) failed due to error '%4'. This operation
will be automatically retried.

### Event 1071: RCM_RESOURCE_ONLINE_BLOCKED_BY_LOCKED_MODE

The operation attempted on cluster resource '%1' of type '%3' in clustered role
'%2' could not be completed because the resource or one of its providers has
locked status.

### Event 1071: RCM_RESOURCE_OFFLINE_BLOCKED_BY_LOCKED_MODE

The operation attempted on cluster resource '%1' of type '%3' in clustered role
'%2' could not be completed because the resource or one of its dependents has
locked status.

### Event 1094: SM_INVALID_SECURITY_LEVEL

The cluster common property SecurityLevel cannot be changed on this cluster. The
cluster security level cannot be changed because the cluster is currently
configured for no authentication mode.

### Event 1119: RES_NETNAME_DNS_REGISTRATION_MISSING

Cluster network name resource '%1' failed to register DNS name '%2' over adapter
'%4' for the following reason: <br><br>'%3'

### Event 1125: TM_EVENT_CLUSTER_NETINTERFACE_UNREACHABLE

Cluster network interface '%1' for cluster node '%2' on network '%3' is
unreachable by at least one other cluster node attached to the network. The
failover cluster was not able to determine the location of the failure. Run the
Validate a Configuration wizard to check your network configuration. If the
condition persists, check for hardware or software errors related to the network
adapter. Also check for failures in any other network components to which the
node is connected such as hubs, switches, or bridges.

### Event 1149: RES_NETNAME_CANT_DELETE_DNS_RECORDS

The DNS Host (A) and Pointer (PTR) records associated with Cluster resource '%1'
were not removed from the resource's associated DNS server. If necessary, they
can be deleted manually. Contact your DNS administrator to assist with this
effort.

### Event 1150: RES_NETNAME_DNS_PTR_RECORD_DELETE_FAILED

The removal of the DNS Pointer (PTR) record '%2' for host '%3' which is
associated with the cluster network name resource '%1' failed with error '%4'.
If necessary, the record can be deleted manually. Contact your DNS administrator
for assistance.

### Event 1151: RES_NETNAME_DNS_A_RECORD_DELETE_FAILED

The removal of the DNS Host (A) record '%2' associated with the cluster network
name resource '%1' failed with error '%3'. If necessary, the record can be
deleted manually. Contact your DNS administrator for assistance.

### Event 1155: RCM_EVENT_EXITED_QUEUING

The pending move for the role '%1' did not complete.

### Event 1197: RES_NETNAME_DELETE_DISABLE_FAILED

Cluster network name resource '%1' failed to delete or disable its associated
computer object '%2' during resource deletion. The error code was '%3'. <br>Please
check if the site is Read-Only. Ensure that the cluster name object has the
appropriate permissions on the '%2' object in Active Directory.

### Event 1198: RES_NETNAME_DELETE_VCO_GUID_FAILED

Cluster network name resource '%1' failed to delete computer object with guid
'%2'. The error code was '%3'. <br>Please check if the site is Read-Only. Ensure
that the cluster name object has the appropriate permissions on the '%2' object
in Active Directory.

### Event 1216: SERVICE_NETNAME_CHANGE_WARNING

A name change operation on the cluster core netname resource has failed.
Attempting to revert the name change operation back to the original name has
also failed. The error code was '%1'. You may not be able to remotely manage the
cluster using the cluster name until this situation has been manually corrected.

### Event 1221: RES_NETNAME_RENAME_OUT_OF_SYNCH_WITH_COMPOBJ

Cluster network name resource '%1' has a name '%2' which does not match the
corresponding computer object name '%3'. It is likely that a previous name
change of the computer object has not replicated to all domain controllers in
the domain. You will be unable to rename the network name resource until the
names become consistent. If the computer object has not been recently changed,
please contact your domain administrator to rename the computer object and
thereby make it consistent. Also, ensure that replication across domain
controllers has been successfully completed.

### Event 1222: RES_NETNAME_SET_PERMISSIONS_FAILED

The computer object associated with cluster network name resource '%1' could not
be updated.<br><br>The text for the associated error code is: %2<br> <br>The cluster
identity '%3' may lack permissions required to update the object. Please work
with your domain administrator to ensure that the cluster identity can update
computer objects in the domain.

### Event 1240: RES_IPADDR_OBTAIN_LEASE_FAILED

Cluster IP address resource '%1' failed to obtain a leased IP address.

### Event 1243: RES_IPADDR_RELEASE_LEASE_FAILED

Cluster IP address resource '%1' failed to release the lease for IP address
'%2'.

### Event 1251: RCM_GROUP_PREEMPTED

Clustered role '%2' was taken offline. This role was preempted by the higher
priority clustered role '%1'. The cluster service will attempt to bring
clustered role '%2' online later when system resources are available.

### Event 1544: SERVICE_VSS_ONABORT

The backup operation for the cluster configuration data has been canceled. The
cluster Volume Shadow Copy Service (VSS) writer received an abort request.

### Event 1548: SERVICE_CONNECT_VERSION_COMPATIBLE

Node '%1' established communication with node '%2' and detected that it is
running a different, but compatible, version of the operating system. We
recommend that all nodes run the same version of the operating system. After all
nodes have been upgraded, run the Update-ClusterFunctionalLevel Windows
PowerShell cmdlet to complete upgrading the cluster.

### Event 1550: SERVICE_CONNECT_NOVERCHECK

Node '%1' established a communication session with node '%2' without performing
a version compatibility check because version compatibility checking is
disabled. Disabling version compatibility checking is not supported.

### Event 1551: SERVICE_FORM_NOVERCHECK

Node '%1' formed a failover cluster without performing a version compatibility
check because version compatibility checking is disabled. Disabling version
compatibility checking is not supported.

### Event 1555: SERVICE_NETFT_DISABLE_AUTOCONFIG_FAILED

Attempting to use IPv4 for '%1' network adapter failed. This was due to a
failure to disable IPv4 auto-configuration and DHCP. This may be expected if the
DHCP Client service is already disabled. IPv6 will be used if enabled, otherwise
this node may not be able to participate in a failover cluster.

### Event 1558: SERVICE_WITNESS_FAILOVER_ATTEMPT

The cluster service detected a problem with the witness resource. The witness
resource will be failed over to another node within the cluster in an attempt to
reestablish access to cluster configuration data.

### Event 1562: RES_FSW_ALIVEFAILURE

File share witness resource '%1' failed a periodic health check on file share
'%2'. Please ensure that file share '%2' exists and is accessible by the
cluster.

### Event 1576: RES_NETNAME_DNS_REGISTRATION_SECURE_ZONE_REFUSED

Cluster network name resource '%1' failed to register the name '%2' over adapter
'%4' in a secure DNS zone. This was due to an existing record with this name and
the cluster identity does not have the sufficient privileges to update that
record. The error code was '%3'. Please contact your DNS server administrator to
verify the cluster identity has permissions on DNS record '%2'.

### Event 1576: RES_NETNAME_DNS_REGISTRATION_SECURE_ZONE_REFUSED

Cluster network name resource '%1' failed to register the name '%2' over adapter
'%4' in a secure DNS zone. This was due to an existing record with this name and
the cluster identity does not have the sufficient privileges to update that
record. The error code was '%3'. Please contact your DNS server administrator to
verify the cluster identity has permissions on DNS record '%2'.

### Event 1577: RES_NETNAME_DNS_SERVER_COULD_NOT_BE_CONTACTED

Cluster network name resource '%1' failed to register the name '%2' over adapter
'%4'. The DNS server could not be contacted. The error code was '%3.' Ensure
that a DNS server is accessible from this cluster node. The DNS registration
will be retried later.

### Event 1577: RES_NETNAME_DNS_SERVER_COULD_NOT_BE_CONTACTED

Cluster network name resource '%1' failed to register the name '%2' over adapter
'%4'. The DNS server could not be contacted. The error code was '%3.' Ensure
that a DNS server is accessible from this cluster node. The DNS registration
will be retried later.

### Event 1578: RES_NETNAME_DNS_TEST_FOR_DYNAMIC_UPDATE_FAILED

Cluster network name resource '%1' failed to register dynamic updates for name
'%2' over adapter '%4'. The DNS server may not be configured to accept dynamic
updates. The error code was '%3'. Please contact your DNS server administrator
to verify that the DNS server is available and configured for dynamic
updates.<br><br>Alternatively, you can disable dynamic DNS updates by unchecking the
'Register this connection's addresses in DNS' setting in the advanced TCP/IP
settings for adapter '%4' under the DNS tab.

### Event 1578: RES_NETNAME_DNS_TEST_FOR_DYNAMIC_UPDATE_FAILED

Cluster network name resource '%1' failed to register dynamic updates for name
'%2' over adapter '%4'. The DNS server may not be configured to accept dynamic
updates. The error code was '%3'. Please contact your DNS server administrator
to verify that the DNS server is available and configured for dynamic
updates.<br><br>Alternatively, you can disable dynamic DNS updates by unchecking the
'Register this connection's addresses in DNS' setting in the advanced TCP/IP
settings for adapter '%4' under the DNS tab.

### Event 1579: RES_NETNAME_DNS_RECORD_UPDATE_FAILED

Cluster network name resource '%1' failed to update the DNS record for name '%2'
over adapter '%4'. The error code was '%3'. Ensure that a DNS server is
accessible from this cluster node and contact your DNS server administrator to
verify the cluster identity can update the DNS record '%2'.

### Event 1579: RES_NETNAME_DNS_RECORD_UPDATE_FAILED

Cluster network name resource '%1' failed to update the DNS record for name '%2'
over adapter '%4'. The error code was '%3'. Ensure that a DNS server is
accessible from this cluster node and contact your DNS server administrator to
verify the cluster identity can update the DNS record '%2'.

### Event 1581: CLUSSVC_UNABLE_TO_MOVE_HIVE_TO_SAFE_FILE

The restore request for the cluster configuration data failed to make a copy of
the existing cluster configuration data file (ClusDB). While attempting to
preserve the existing configuration, the restore operation was unable to create
a copy at location '%1'. This might be expected if the existing configuration
data file was corrupt. The restore operation has continued but attempts to
revert to the existing cluster configuration may not be possible.

### Event 1582: CLUSSVC_UNABLE_TO_MOVE_RESTORED_HIVE_TO_CURRENT

Cluster Service failed to move the restored cluster hive at '%1' to '%2'. This
may prevent the restore operation from succeeding successfully. If the cluster
configuration was not properly restored, please retry the restore action.

### Event 1583: CLUSSVC_NETFT_DISABLE_CONNECTIONSECURITY_FAILED

Cluster service failed to disable Internet Protocol security (IPsec) on the
Failover cluster virtual adapter '%1'. This could have a negative impact on
cluster communication performance. If this problem persists, please verify your
local and domain connection security policies applying to IPSec and the Windows
Firewall. Additionally, please check for events related to the Base Filtering
Engine service.

### Event 1584: SHARED_VOLUME_NOT_READY_FOR_SNAPSHOT

A backup application initiated a VSS snapshot on Cluster Shared Volume '%1'
('%3') without properly preparing the volume for snapshot. This snapshot may be
invalid and the backup may not be usable for restore operations. Please contact
your backup application vendor to verify compatibility with Cluster Shared
Volumes.

### Event 1589: RES_NETNAME_DNS_RETURNING_IP_THAT_IS_NOT_PROVIDER

Cluster network name resource '%1' found one or more IP addresses associated
with DNS name '%2' that are not dependent IP address resources. The additional
addresses found were '%3'. This may affect client connectivity until the network
name and its associated DNS records are consistent. Please contact your DNS
server administrator to verify the records associated with name '%2'.

### Event 1604: RES_DISK_CHKDSK_SPOTFIX_NEEDED

Cluster disk resource '%1' detected corruption for volume '%2'. Spotfix Chkdsk
is required to repair problems.

### Event 1605: RES_DISK_SPOTFIX_PERFORMED

Cluster disk resource '%1' completed running ChkDsk.exe /spotfix on volume '%2'.
The return code was '%4'. Output from the ChkDsk has been logged to file '%3'.<br>
Check the application event log for additional information from ChkDsk.

### Event 1671: RES_DISK_ONLINE_SET_ATTRIBUTES_COMPLETED_FAILURE

Cluster physical disk resource cannot be brought online.<br><br>Physical Disk
resource name: %1<br>Error Code: %2<br>Time Elapsed (seconds): %3

#### Guidance

Run the Validate a Configuration wizard to check your storage configuration. If the
error code was ERROR_CLUSTER_SHUTDOWN then the Online Pending state was
cancelled by an administrator. If this is a replicated volume then this could be
the result of a failure to set the disk attributes. Review the Storage
Replication events for additional information.

### Event 1673: CLUSTER_NODE_ENTERED_ISOLATED_STATE

Cluster node '%1' has entered the isolated state.

### Event 1675: EVENT_JOINING_NODE_QUARANTINED

Cluster node '%1' has been quarantined by '%2' and cannot join the cluster. The
node will be quarantined until '%3' and then the node will automatically attempt
to re-join the cluster. <br><br>Refer to the System and Application event logs to
determine the issues on this node. When the issue is resolved, quarantine can be
manually cleared to allow the node to rejoin with the 'Start-ClusterNode
–ClearQuarantine' Windows PowerShell cmdlet.<br><br>Node Name : %1<br>QuarantineType :
Quarantine by %2<br>Time quarantine will be automatically cleared: %3

### Event 1681: CLUSTER_GROUPS_UNMONITORED_ON_NODE

Virtual machines on node '%1' have entered an unmonitored state. The virtual
machines health will be monitored again once the node returns from an isolated
state or may failover if the node does not return. The virtual machine no longer
being monitored are: %2.

### Event 1689: EVENT_DISABLE_AND_STOP_OTHER_SERVICE

The cluster service detected a service which is not compatible with Failover
Clustering. The service has been disabled to avoid possible problems with the
Failover Cluster.<br><br>Service name: '%1'

### Event 4625: NODECLEANUP_RESET_NLBSFLAGS_PRESERVED

Resetting the IPSec security association timeout registry value failed during
cluster node cleanup. This is because the IPSec security association timeout was
modified after this machine was configured to be a member of a cluster. For
manual cleanup, execute the 'Clear-ClusterNode' PowerShell cmdlet on this
machine. Alternatively, you may reset the IPSec security association timeout by
deleting the '%1' value and the '%2' value from HKEY_LOCAL_MACHINE in the
Windows registry.

### Event 4873: NETFT_CLUSSVC_TERMINATE_BECAUSE_OF_WATCHDOG

The cluster service has detected that the failover cluster virtual adapter has
stopped. This is expected when hot replace CPU is performed on this node.
Cluster service will stop and should automatically restart after the operation
is complete. Please check for additional events associated with the service and
ensure that the cluster service has been restarted on this node.

### Event 5120: DCM_VOLUME_AUTO_PAUSE_AFTER_FAILURE

Cluster Shared Volume '%1' ('%2') has entered a paused state because of '%3'.
All I/O will temporarily be queued until a path to the volume is reestablished.

### Event 5123: DCM_EVENT_ROOT_RENAME_SUCCESS

Cluster Shared Volumes root directory '%1' already exists. The directory '%1'
was renamed to '%2'. Please verify that applications accessing data in this
location have been updated as necessary.

### Event 5124: DCM_UNSAFE_FILTERS_FOUND

Cluster Shared Volume '%1' ('%3') has identified one or more active filter
drivers on this device stack that could interfere with CSV operations. I/O
access will be redirected to the storage device over the network through another
Cluster node. This may result in degraded performance. Please contact the filter
driver vendor to verify interoperability with Cluster Shared Volumes. <br><br>Active
filter drivers found:<br>%2

### Event 5125: DCM_UNSAFE_VOLFILTER_FOUND

Cluster Shared Volume '%1' ('%3') has identified one or more active volume
drivers on this device stack that could interfere with CSV operations. I/O
access will be redirected to the storage device over the network through another
Cluster node. This may result in degraded performance. Please contact the volume
driver vendor to verify interoperability with Cluster Shared Volumes. <br><br>Active
volume drivers found:<br>%2

### Event 5126: DCM_EVENT_CANNOT_DISABLE_SHORT_NAMES

Physical disk resource '%1' does not allow disabling short name generation. This
may cause application compatibility issues. Please use 'fsutil 8dot3name set 2'
to allow disabling short name generation and then offline/online the resource.

### Event 5128: DCM_EVENT_CANNOT_DISABLE_SHORT_NAMES

Physical disk resource '%1' does not allow disabling short name generation. This
may cause application compatibility issues. Please use 'fsutil 8dot3name set 2'
to allow disabling short name generation and then offline/online the resource.

### Event 5133: DCM_CANNOT_RESTORE_DRIVE_LETTERS

Cluster Disk '%1' has been removed and placed back in the 'Available Storage'
cluster group. During this process an attempt to restore the original drive
letter(s) has taken longer than expected, possibly due to those drive letters
being already in use.

### Event 5134: DCM_CANNOT_SET_ACL_ON_ROOT

Cluster service failed to set the permissions (ACL) on the Cluster Shared
Volumes root directory '%1'. The error was '%2'.

### Event 5135: DCM_CANNOT_SET_ACL_ON_VOLUME_FOLDER

Cluster service failed to set the permissions on the Cluster Shared Volume
directory '%1' ('%2'). The error was '%3'.

### Event 5136: DCM_CSV_INTO_REDIRECTED_MODE

Cluster Shared Volume '%1' ('%2') redirected access was turned on. Access to the
storage device will be redirected over the network from all cluster nodes that
are accessing this volume. This may result in degraded performance. Turn off
redirected access for this volume to resume normal operations.

### Event 5149: DCM_CSV_BLOCK_CACHE_RESIZED

Cache size resized to '%1' based on populated memory, user setsize is too high.

### Event 5156: DCM_VOLUME_AUTO_PAUSE_AFTER_SNAPSHOT_FAILURE

Cluster Shared Volume '%1' ('%2') has entered a paused state because of '%3'.
This error is encountered when the volsnap snapshots underlying the CSV volume
are deleted outside of a user request. Possible causes of the snapshots getting
deleted are lack of space in the volume for the snapshots to grow, or IO failure
while trying to update the snapshot data. All I/O will temporarily be queued
until the snapshot state is synchronized with volsnap.

### Event 5157: DCM_VOLUME_AUTO_PAUSE_AFTER_FAILURE_EXPECTED

Cluster Shared Volume '%1' ('%2') has entered a paused state because of '%3'.
All I/O will temporarily be queued until a path to the volume is reestablished.
This error is usually caused by an infrastructure failure. For example, losing
connectivity to storage or the node owning the Cluster Shared Volume being
removed from active cluster membership.

### Event 5394: POOL_ONLINE_WARNINGS

The Cluster service encountered some storage errors while trying to bring
storage pool online. Run cluster storage validation to troubleshoot the issue.

### Event 5395: RCM_GROUP_AUTO_MOVE_STORAGE_POOL

Cluster is moving the group for storage pool '%1' because current node '%3' does
not have optimal connectivity to the storage pool physical disks.

## Informational events

### Event 1592: CLUSSVC_TCP_RECONNECT_CONNECTION_REESTABLISHED

Cluster node '%1' lost communication with cluster node '%2'. Network
communication was reestablished. This could be due to communication temporarily
being blocked by a firewall or connection security policy update. If the problem
persists and network communication are not reestablished, the cluster service on
one or more nodes will stop. If that happens, run the Validate a Configuration
wizard to check your network configuration. Additionally, check for hardware or
software errors related to the network adapters on this node, and check for
failures in any other network components to which the node is connected such as
hubs, switches, or bridges.

### Event 1594: CLUSTER_FUNCTIONAL_LEVEL_UPGRADE_COMPLETE

Cluster service successfully upgraded the cluster functional level. <br><br>
Functional Level: %1 <br> Upgrade Version: %2

### Event 1635: RCM_RESOURCE_FAILURE_INFO_WITH_TYPENAME

Cluster resource '%1' of type '%3' in clustered role '%2' failed.

### Event 1636: CLUSSVC_PASSWORD_CHANGED

The Cluster service has changed the password of account '%1' on node '%2'.

### Event 1680: CLUSTER_NODE_EXITED_ISOLATED_STATE

Cluster node '%1' has exited the isolated state.

### Event 1682: CLUSTER_GROUP_MOVED_NO_LONGER_UNMONITORED

Virtual machine '%2' which was unmonitored on the isolated node '%1' has been
failed over to another node. The health of the virtual machine is once again
being monitored.

### Event 1682: CLUSTER_MULTIPLE_GROUPS_NO_LONGER_UNMONITORED

Node '%1' has rejoined the cluster and the following virtual machines running on
that node are once again having their health state monitored: %2.

### Event 4621: NODECLEANUP_SUCCESS

This node was successfully removed from the cluster.

### Event 5121: DCM_VOLUME_NO_DIRECT_IO_DUE_TO_FAILURE

Cluster Shared Volume '%1' ('%2') is no longer directly accessible from this
cluster node. I/O access will be redirected to the storage device over the
network to the node that owns the volume. If this results in degraded
performance, please troubleshoot this node's connectivity to the storage device
and I/O will resume to a healthy state once connectivity to the storage device
is reestablished.

### Event 5218: CSV_OLD_SW_SNAPSHOT_DELETED

Cluster physical disk resource '%1' deleted a software snapshot. The software
snapshot on Cluster Shared Volume '%2' was deleted because it was older than
'%3' day(s). The snapshot ID was '%4' and it was created from node '%5' at '%6'.
It is expected that snapshots are deleted by a backup application after a backup
job is completed. This snapshot exceeded the time that is expected for a
snapshot to exist. Verify with the backup application that backup jobs are
completing successfully.

## See also

-   [Detailed event info for Failover Clustering components in Windows Server
    2008](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753362(v%3dws.10))
