---
title: DHCP Failover Examples
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 215701b0-287f-41d3-b2a9-c1ecb26ff75c
---
# DHCP Failover Examples
The examples in this topic demonstrate behavior when a DHCP server in a DHCP failover relationship enters the communication interrupted state. In the third example, a DHCP server enters the communication interrupted state and subsequently passes from this state to the partner down state.  
  
The communication interrupted state can occur due to interruption of the network link between DHCP failover partners, or it can occur because the DHCP Server service on a failover partner is unresponsive. The examples in this topic assume that a DHCP client can communicate with both DHCP servers in a failover relationship, but only one DHCP server is able to respond for a given time period.  
  
-   [Hot standby example](../Topic/DHCP-Failover-Examples.md#standby_example)  
  
-   [Load balancing example](../Topic/DHCP-Failover-Examples.md#balancing_example)  
  
-   [Partner down example](../Topic/DHCP-Failover-Examples.md#partner_down)  
  
**Dual communication interrupted state**  
  
In the special case where there is a loss of the network connection between DHCP failover partners but each DHCP server can still respond to lease requests from local DHCP clients, such as where DHCP failover partners are in different branch offices and the link between branch offices is broken, both DHCP servers will enter the communications interrupted state.  
  
In this scenario, both DHCP servers will renew DHCP client leases that were issued by the local DHCP server. DHCP servers will not respond to a DHCP renewal request if the lease was issued by the partner DHCP server. However, both DHCP servers will grant new IP address leases for clients that have entered a rebinding state. To avoid IP address conflicts, the two DHCP servers will each use a different portion of the free IP address pool when issuing new DHCP leases.  
  
**Dual partner down state**  
  
If the network connection between DHCP failover partners is broken for an extended period of time and a state switchover interval is configured, it is possible for both DHCP servers to enter the partner down state. This should be avoided. In this scenario, both DHCP servers will provide new IP address leases from the entire free IP address pool, resulting in possible IP address conflicts. For this reason, it is recommended to increase the state switchover interval under the following conditions:  
  
1.  The scope is running at a very high utilization percentage.  
  
2.  The reserve IP address percentage that is configured for a standby server is inadequate to meet the need for new DHCP lease requests.  
  
> [!NOTE]  
> The first lease issued by a DHCP server from a scope that belongs to a DHCP failover relationship is always for the MCLT duration. After this lease is renewed at half the lease duration \(MCLT\) a lease is granted for the full scope lease duration.  
  
For information about the types of messages exchanged between DHCP failover partner servers, see [DHCP Failover Communications](../Topic/DHCP-Failover-Communications.md).  
  
## <a name="standby_example"></a>Hot standby example  
The following illustration and its corresponding steps provide a detailed description of the processes involved when a DHCP client acquires a DHCP lease from DHCP servers configured for DHCP failover in hot standby mode.  
  
|||  
|-|-|  
|1.  A DHCP client in the INIT state broadcasts a DHCP discover message.<br />2.  Since DHCP2 is in standby status, it does not respond to the client. DHCP1 is in active status and responds by offering a lease to the client.<br />3.  The client requests a lease from DHCP1.<br />4.  DHCP1 provides an IP address lease to the client for the MCLT \(not the full scope lease duration\).<br />5.  DHCP1 sends a binding update \(BNDUPD\) message to DHCP2 letting it know about the new lease.<br />6.  DHCP2 responds to DHCP1 and acknowledges that it received the binding update \(BNDACK\).<br />7.  At 50% of the lease time \(MCLT\/2\), the client requests a renewal for its lease from DHCP1.<br />8.  DHCP1 renews the client’s DHCP lease for the full scope lease duration.<br />9. DHCP1 sends a binding update \(BNDUPD\) message to DHCP2 informing it of the lease renewal.<br />10. DHCP2 acknowledges that it received the binding update message from DHCP1 \(BNDACK\).<br />11. DHCP1 becomes unavailable.<br />12. DHCP2 receives an error when attempting to communicate with DHCP1 or a timer expires because no messages have been received from DHCP1.<br />    DHCP2 drops the connection, enters the communication interrupted state, and switches to an active status.<br />13. DHCP2 attempts and fails to reestablish a connection with DHCP1.<br />14. At 50% of the scope lease time, the client requests a renewal for its lease from DHCP1, but DHCP1 is not available so the lease it not renewed.<br />15. At 7\/8 of the scope lease time, the client moves into a REBINDING state and broadcasts a lease renewal request.<br />16. DHCP2 receives the lease request from the client and responds with a DHCPACK. The client renews its lease using the same IP address as previously assigned for the duration of the MCLT. **Note:**     For clients that did not previously have a lease on either the active or standby server, DHCP2 will use an IP address from the reserve percentage. For clients that previously had a lease on its failover partner, DHCP2 will renew the same IP address for the client.<br />17. DHCP1 becomes available again and attempts to reestablish communications with DHCP2. DHCP1 waits a short time to ensure communications with DHCP2 are fully reestablished, then enters a normal state and becomes the active DHCP server again. DHCP1 begins communications by sending and update request \(UPDREQ\) to DHCP2.<br />18. DHCP2 sends binding update \(BNDUPD\) messages and DHCP1 sends binding acknowledgment \(BNDACK\) messages until the lease database is fully synchronized \(not shown\), then DHCP2 then sends an UPDDONE message. DHCP2 is assigned standby status.<br />19. At 50% of the lease time \(MCLT\/2\), the client attempts to renew its lease with DHCP2, but DHCP does not respond because it is in standby status.<br />20. At 7\/8 of lease expiration the client enters a REBINDING state and broadcasts a DHCPREQUEST message.<br />21. DHCP2 does not respond because it is in standby status. DHCP1 responds with a DHCPACK and the client renews its lease with DHCP1 for the full scope lease time. This is the same as step \#8 above and the process repeats.|![](../Image/DHCP_hot-standby-example.gif)|  
  
## <a name="balancing_example"></a>Load balancing example  
The following illustration and its corresponding steps provide a detailed description of the processes involved when a DHCP client acquires a DHCP lease from DHCP servers configured for DHCP failover in load balancing mode.  
  
|||  
|-|-|  
|1.  A DHCP client in the INIT state broadcasts a DHCP discover message.<br />2.  DHCP1 and DHCP2 each compute a hash of the client ID in the range 0\-255. It is determined that the hash value belongs to the hash bucket assignment for DHCP1, so only DHCP1 responds to the client.<br />3.  The client requests a lease from DHCP1.<br />4.  DHCP1 provides an IP address lease to the client for the MCLT \(not the full scope lease duration\).<br />5.  DHCP1 sends a binding update \(BNDUPD\) message to DHCP2 letting it know about the new lease.<br />6.  DHCP2 responds to DHCP1 and acknowledges that it received the binding update \(BNDACK\).<br />7.  At 50% of the lease time \(MCLT\/2\), the client requests a renewal for its lease from DHCP1.<br />8.  DHCP1 renews the client’s DHCP lease for the full scope lease duration.<br />9. DHCP1 sends a binding update \(BNDUPD\) message to DHCP2 informing it of the lease renewal.<br />10. DHCP2 acknowledges that it received the binding update message from DHCP1 \(BNDACK\).<br />11. DHCP1 becomes unavailable.<br />12. DHCP2 receives an error when attempting to communicate with DHCP1 or a timer expires because no messages have been received from DHCP1.<br />    DHCP2 drops the connection, enters the communication interrupted state, and begins accepting leases requests for all clients.<br />13. DHCP2 attempts and fails to reestablish a connection with DHCP1.<br />14. At 50% of the scope lease time, the client requests a renewal for its lease from DHCP1, but DHCP1 is not available so the lease it not renewed.<br />15. At 7\/8 of the scope lease time, the client moves into a REBINDING state and broadcasts a lease renewal request.<br />16. DHCP2 determines that the client belongs to DHCP1, but since DHCP2 is in communications interrupted state, it offers a temporary lease to the client for the duration of the MCLT. **Note:**     For clients that did not previously have a lease on either DHCP1 or DHCP2, DHCP2 will use an IP address from its assigned address pool. For clients that previously had a lease on its failover partner, DHCP2 will renew the same IP address to the client.<br />17. DHCP1 becomes available again and attempts to reestablish communications with DHCP2. DHCP1 begins communications by sending an update request \(UPREQ\) to DHCP2. When communications are fully reestablished, both DHCP servers enter a NORMAL state and DHCP1 becomes responsible for the client again according to its hash bucket. DHCP2 begins ignoring lease requests from clients that are not assigned to it.<br />18. DHCP2 sends binding update messages and DHCP1 sends binding acknowledgment messages until the lease database is synchronized. DHCP2 then sends an update done message \(UPDDONE\).<br />19. At 50% of the MCLT lease time, the client attempts to renew its lease with DHCP2, but DHCP does not respond because the client is assigned to DHCP1.<br />20. At 7\/8 of the MCLT lease time, the client moves into a REBINDING state and broadcasts a lease renewal request.<br />21. DHCP1 determines that the client belongs to its hash bucket and offers a lease to the client for the full scope lease duration. This is the same as step \#8 above, and the process repeats.|![](../Image/DHCP_load-balance-example.gif)|  
  
## <a name="partner_down"></a>Partner down example  
The following illustration and its corresponding steps provide a detailed description of the processes involved when a DHCP failover partner server enters the partner down state in load balance mode.  
  
|||  
|-|-|  
|1.  A DHCP client in the INIT state broadcasts a DHCP discover message.<br />2.  DHCP1 and DHCP2 each compute a hash of the client ID in the range 0\-255. It is determined that the hash value belongs to the hash bucket assignment for DHCP1, so only DHCP1 responds to the client.<br />3.  The client requests a lease from DHCP1.<br />4.  DHCP1 provides an IP address lease to the client for the MCLT \(not the full scope lease duration\).<br />5.  DHCP1 sends a binding update \(BNDUPD\) message to DHCP2 letting it know about the new lease.<br />6.  DHCP2 responds to DHCP1 and acknowledges that it received the binding update \(BNDACK\).<br />7.  At 50% of the lease time \(MCLT\), the client requests a renewal for its lease from DHCP1.<br />8.  DHCP1 renews the client’s DHCP lease for the full scope lease duration.<br />9. DHCP1 sends a binding update \(BNDUPD\) message to DHCP2 informing it of the lease renewal.<br />10. DHCP2 acknowledges that it received the binding update message from DHCP1 \(BNDACK\).<br />11. DHCP1 becomes unavailable.<br />12. DHCP2 receives an error when attempting to communicate with DHCP1 or a timer expires because no messages have been received from DHCP1.<br />    DHCP2 drops the connection, enters the communication interrupted state, and begins accepting leases requests for all clients.<br />13. DHCP2 attempts and fails to reestablish a connection with DHCP1.<br />14. At 50% of the scope lease time, the client requests a renewal for its lease from DHCP1, but DHCP1 is not available so the lease it not renewed.<br />15. At 7\/8 of the scope lease time, the client moves into a REBINDING state and broadcasts a lease renewal request.<br />16. DHCP2 determines that the client belongs to DHCP1, but since DHCP2 is in communications interrupted state, it offers a temporary lease to the client for the duration of the MCLT. **Note:**     For clients that did not previously have a lease on either DHCP1 or DHCP2, DHCP2 will use an IP address from its assigned free address pool. For clients that previously had a lease on its failover partner, DHCP2 will renew the same IP address.<br />17. DHCP2 is moved into partner down state manually, or due to the state switchover interval expiring. Another timer begins for the duration of the MCLT. After expiry of the MCLT, DHCP2 takes over the remaining 50% of the free IP address pool that was previously owned by DHCP1.<br />18. The client requests a DHCP lease from DHCP2.<br />19. DHCP2 grants a lease for the duration of the MCLT. **Note:**     For clients that did not previously have a lease on either DHCP1 or DHCP2, DHCP2 will use an IP address from its assigned free IP address pool until that is exhausted, and then it will begin granting leases from the failover partner’s free IP address pool. For clients that previously had a lease, DHCP2 will renew the same IP address for the client. All leases are granted for the MCLT duration.<br />20. DHCP1 becomes available again and enters the RECOVER state. DHCP1 sends update request \(UPREQ\) messages to DHCP2.<br />21. DHCP2 sends an UPDDONE message and DHCP1 enters the NORMAL state. **Note:**     If DHCP1 was unavailable for a time shorter than the MCLT, it will transition to the RECOVER WAIT state until the MCLT duration expires. DHCP1 does not respond to lease requests while in the RECOVER WAIT state.<br />22. DHCP1 enters the NORMAL state and begins servicing DHCP lease requests again.<br />23. At 50% of the MCLT lease time, the client attempts to renew its lease with DHCP2, but DHCP does not respond because the client is assigned to DHCP1.<br />24. At 7\/8 of the MCLT lease time, the client moves into a REBINDING state and broadcasts a lease renewal request.<br />25. DHCP1 determines that the client belongs to its hash bucket and offers a lease to the client for the full scope lease duration. This is the same as step \#8 above, and the process repeats.|![](../Image/DHCP_partner-down-example.gif)|  
  
## See also  
[What is DHCP Failover?](../Topic/What-is-DHCP-Failover-.md)  
  
[DHCP Failover Relationships](../Topic/DHCP-Failover-Relationships.md)  
  
[DHCP Failover Modes](../Topic/DHCP-Failover-Modes.md)  
  
[DHCP Failover Communications](../Topic/DHCP-Failover-Communications.md)  
  
[DHCP Failover Settings](../Topic/DHCP-Failover-Settings.md)  
  
[DHCP Failover Events and Performance](../Topic/DHCP-Failover-Events-and-Performance.md)  
  
[Deploy DHCP Failover](../Topic/Deploy-DHCP-Failover.md)  
  
