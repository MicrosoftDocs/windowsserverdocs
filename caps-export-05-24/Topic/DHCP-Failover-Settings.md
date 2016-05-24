---
title: DHCP Failover Settings
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e2c63f4f-795b-4a3c-9343-eb4ae4406f8c
---
# DHCP Failover Settings
The following table provides a summary of settings used with DHCP failover. Additional details about each setting are provided below.  
  
|Setting|Description|More Information|  
|-----------|---------------|--------------------|  
|Name|Name of the failover relationship. The name of the failover relationship must be unique on the local server.|[Name](../Topic/DHCP-Failover-Settings.md#name)|  
|Partner server|Name or IP address of the server that shares the failover relationship with the local DHCP server.|[Partner server](../Topic/DHCP-Failover-Settings.md#partner)|  
|Mode|The type of DHCP failover mode chosen.|[Mode](../Topic/DHCP-Failover-Settings.md#mode)|  
|Load balance percentage|The percentage of DHCP client leases that will be evaluated by the local server.|[Load balance percentage](../Topic/DHCP-Failover-Settings.md#load)|  
|Server role|The role of the local server in hot standby mode, either active or standby.|[Server role](../Topic/DHCP-Failover-Settings.md#role)|  
|Reserve percentage|The percentage of IP addresses in a scope that are reserved for the hot standby server.|[Reserve percentage](../Topic/DHCP-Failover-Settings.md#reserve)|  
|Maximum client lead time \(MCLT\)\)|The maximum amount of time that one server can extend a lease for a DHCP client beyond the time known by the partner server.|[Maximum client lead time \(MCLT\)\)](../Topic/DHCP-Failover-Settings.md#mclt)|  
|State switchover interval|The interval after which a DHCP server automatically transitions its failover partner to a partner down state after loss of communication.|[State switchover interval](../Topic/DHCP-Failover-Settings.md#interval)|  
|State|The current state of the local server.|[State](../Topic/DHCP-Failover-Settings.md#state)|  
|Scope IDs|A list of DHCP scope IDs that are associated with the failover relationship.|[Scope IDs](../Topic/DHCP-Failover-Settings.md#scopes)|  
|Automatic state transition|If a state switchover interval is configured, then automatic state transition is enabled. By default, automatic state transition is disabled.|[Automatic state transition](../Topic/DHCP-Failover-Settings.md#transition)|  
|Enable authentication|Whether or not a shared secret is required between failover partners.|[Enable authentication](../Topic/DHCP-Failover-Settings.md#auth)|  
  
## <a name="name"></a>Name  
You must provide a unique name for each failover relationship on a DHCP server. The name must be unique on both failover partner servers. The relationship name is limited to 126 characters. Special characters \(\!@\#$%^&\*\) and spaces are allowed, but if special characters are configured in a name using Windows PowerShell, the relationship name must be enclosed in quotes.  
  
## <a name="partner"></a>Partner server  
You can provide the NETBIOS name, DNS name, or IP address of the partner DHCP server. If the partner DHCP server is a member of a DHCP cluster, provide the name or IP address of the cluster. If you configure the partner DHCP server to be a cluster node, contact with the partner server will be lost if the DHCP service is moved to a different node in the cluster.  
  
If you use the DHCP console to configure DHCP failover, a drop\-down list of previously configured partner servers is provided. You can also choose to reuse existing failover relationships by selecting the checkbox next to **Reuse existing failover relationships configured with this server \(if any exist\)**.  
  
## <a name="mode"></a>Mode  
Choose load balance or hot standby mode. For more information see [DHCP Failover Modes](../Topic/DHCP-Failover-Modes.md).  
  
## <a name="load"></a>Load balance percentage  
If you choose the load balance mode, you must provide the percentage of DHCP client requests that will be serviced by each DHCP server. By default, a 50\-50 load balancing percentage is assigned.  
  
## <a name="role"></a>Server role  
If you choose the hot standby mode, you must designate the role of the partner server to be either active or standby. By default, the local server is active and the partner server is standby.  
  
## <a name="reserve"></a>Reserve percentage  
In a failover relationship configured in hot standby mode, administrators can specify a percentage of the address range of the scope as reserved for the hot standby server. A number of addresses, in proportion to the percentage value configured, are assigned to the hot standby server. The hot standby server will use these addresses to service new clients after the primary server goes down, during the time interval before the standby server assumes control over the entire IP address range of a scope. The hot standby server assumes control over the entire IP address range only after it transitions into partner down state and a certain time \(defined by MCLT\) has elapsed after moving into the partner down state.If an administrator sets this parameter to zero, no addresses are reserved for the hot standby server, and the failover partner server cannot grant new client leases until the time that the hot standby assumes control over the entire IP address range. The default value for reserve address percentage is 5%.  
  
## <a name="mclt"></a>Maximum client lead time \(MCLT\)  
The maximum amount of time that one server can extend a lease for a DHCP client beyond the time known by the partner server. The MCLT defines the temporary lease period given by a failover partner server, and also determines the amount of time that a server in a failover relationship will wait in partner down state before assuming control over the entire IP address range.  
  
The MCLT cannot be set to zero, and the default setting is 1 hour.  
  
## <a name="interval"></a>State switchover interval  
If automatic state transition is enabled, a DHCP server in communication interrupted state will automatically transition to partner down state after a defined period of time. This period of time is defined by the state switchover interval.  
  
A server that loses communication with a partner server transitions into a communication interrupted state. The loss of communication may be due to a network outage or the partner server may have gone offline. By default, since there is no way for the server to detect the reason for loss of communication with its partner, the server will continue to remain in communication interrupted state until the administrator manually changes the state to partner down. However, if you enable automatic state transition, DHCP failover will automatically transition to partner down state when the auto state switchover interval expires. The default value for auto state switchover interval is 60 minutes.  
  
## <a name="state"></a>State  
In Windows PowerShell, state refers to the condition of the local server, or the server specified using the **ComputerName** parameter. The DHCP console displays the state of both the local server and the partner server next to **State of this server** and **State of partner server** when you view or edit a DHCP failover relationship.  
  
The following table describes available states. These states are defined in section 5 \(Protocol Overview\) and section 9 \(Failover Endpoint States\), in the IETF [DHCP Failover Protocol](http://www.ietf.org/proceedings/59/I-D/draft-ietf-dhc-failover-12.txt) draft.  
  
|State|Description|  
|---------|---------------|  
|NORMAL|When operating in the NORMAL state, each DHCP server in a failover relationship services DHCP clients as defined by the failover mode that is configured and its associated parameters.|  
|COMMUNICATION INTERRUPTED|When operating in the COMMUNICATIONS INTERRUPTED state, each server functions independently. Servers do not assume that their partner is not operating, but only that they are unable to communicate. Each server responds to all DHCP client messages that it receives in a manner such that graceful reintegration its partner server is possible when communication is restored.|  
|PARTNER DOWN|When operating in PARTNER DOWN state, a server assumes that its failover partner is not operating. The server responds to all DHCP client requests that it receives.|  
|POTENTIAL CONFLICT|This state indicates that the two servers are attempting to reintegrate with each other, but at least one of them was running in a state that did not guarantee automatic reintegration would be possible. In the POTENTIAL CONFLICT state, the servers may determine that the same IP address has been offered and accepted by two different DHCP clients. It is a goal of DHCP failover to minimize occurrences of the POTENTIAL CONFLICT state.<br /><br />A server in the POTENTIAL CONFLICT state does not process any incoming DHCP requests.|  
|STARTUP|A server operating in STARTUP state assumes that failover is operational, and it spends a short time attempting to contact the failover partner. The server is unresponsive to DHCP client requests during this time. This state exists in order to give the server a chance to determine if its partner has changed state since it was last in communications, and to react to that changed state \(if any\) prior to responding to DHCP client requests.|  
|RESOLUTION INTERRUPTED|This state indicates that the two servers were attempting to reintegrate with each other in POTENTIAL\-CONFLICT state, but communications failed prior to completion of re\-integration. A server in this state will respond to DHCP client requests using its own IP address pool.|  
|CONFLICT DONE|This state indicates that the primary server has received all of the updates from the secondary server during the reintegration process. A server in the CONFLICT DONE state responds to all client requests, as opposed to the NORMAL state where it might be running under the load balancing algorithm.|  
|RECOVER|A server operating in RECOVER state assumes that it is reintegrating with a server that has been operating in PARTNER DOWN state, and that it needs to update its bindings database before it services DHCP client requests. A server may also operate in RECOVER state in order to fully recover its bindings database from its partner server.|  
|RECOVER WAIT|This state indicates that the server has done an UPDREQ or UPDREQALL and has received the UPDDONE message indicating that it has received all outstanding binding update information. In the RECOVER WAIT state the server will wait for the MCLT in order to ensure that any processing that this server might have done prior to losing its stable storage will not cause future difficulties. A server in RECOVER WAIT does not respond to DHCP client requests.|  
|RECOVER DONE|This state exists to allow an interlocked transition for one server from RECOVER state and another server from PARTNER DOWN or COMMUNICATIONS INTERRUPTED state into NORMAL state. A server in RECOVER DONE state MUST respond only to DHCPREQUEST\/RENEWAL and DHCPREQUEST\/REBINDING DHCP messages. When a server in RECOVER DONE state determines that its partner server has entered NORMAL or RECOVER DONE state, then it will transition into NORMAL state. If communications fail while in the RECOVER DONE state, a server will stay in the RECOVER DONE state.|  
|NO STATE|If a server’s state is unknown, it will be displayed as NO STATE.|  
  
## <a name="scopes"></a>Scope IDs  
A list of DHCP scope IDs that are associated with the selected failover relationship.  
  
## <a name="transition"></a>Automatic state transition  
If enabled, automatic state transition will occur from the COMMUNICATIONS INTERRUPTED state to PARTNER DOWN state when the state switchover interval expires.  
  
## <a name="auth"></a>Enable authentication  
You can choose to require authentication \(a shared secret\) in order to secure communications between failover partners. This is enabled in the DHCP console by selecting the checkbox next to **Enable Message Authentication**. If you choose to enable authentication, you must provide a shared secret.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] implements failover message authentication using the Secure Hash Algorithm 2 \(SHA\-2\) cryptographic standard. By default, DHCP failover uses the SHA\-256 algorithm.  
  
## See also  
[What is DHCP Failover?](../Topic/What-is-DHCP-Failover-.md)  
  
[DHCP Failover Modes](../Topic/DHCP-Failover-Modes.md)  
  
[DHCP Failover Communications](../Topic/DHCP-Failover-Communications.md)  
  
[DHCP Failover Examples](../Topic/DHCP-Failover-Examples.md)  
  
[Deploy DHCP Failover](../Topic/Deploy-DHCP-Failover.md)  
  
