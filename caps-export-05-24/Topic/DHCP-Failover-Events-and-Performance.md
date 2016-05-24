---
title: DHCP Failover Events and Performance
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eda47bde-0bc8-40ff-8fba-6f9dd2dc3695
---
# DHCP Failover Events and Performance
[!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] introduces new event logging and performance counters to support monitoring and troubleshooting of DHCP failover. See the following sections in this topic for more information:  
  
1.  [DHCP server event channels](../Topic/DHCP-Failover-Events-and-Performance.md#channels)  
  
2.  [Performance counters](../Topic/DHCP-Failover-Events-and-Performance.md#perf)  
  
> [!NOTE]  
> DHCP failover\-related events are also logged to the [DHCP Audit Log](http://technet.microsoft.com/library/dd759178.aspx), which by default is located at **%windir%\\System32\\Dhcp**. A DHCP\-failover informational event that is commonly recorded in the DHCP Audit Log is event ID 36:  
>   
> **36,<date>,<time>,Packet dropped because of Client ID hash mismatch or standby server…**  
>   
> This event is only informational and can be safely ignored. It does not indicate an error.  
>   
> In DHCP failover, the client messages which are broadcast are received by both the DHCP failover servers. However, only one server responds to the client messages. In case of load balance mode, the servers will hash the MAC address of a DHCP client to establish which of them must respond. In hot standby mode, only the active server responds. In both cases, the DHCP server which does not respond to the client logs this message in the audit log.  
  
## <a name="channels"></a>DHCP server event channels  
The following DHCP Server event channels are available using Event Viewer with the path: **Applications and Services Logs\\Microsoft\\Windows\\DHCP\-Server**.  
  
1.  **Admin** channel \(Microsoft\-Windows\-DHCP Server Events\/Admin\): This channel provides DHCP server administrative event logging. For example, events are logged to this channel if a DHCP failover state of a server changes. For more information, see [Administrative event logging](../Topic/DHCP-Failover-Events-and-Performance.md#admin).  
  
2.  **FilterNotifications** channel \(Microsoft\-Windows\-DHCP Server Events\/FilterNotifications\): This channel provides DHCP server link\-layer based filtering event logging. This event channel is not used for DHCP failover related events.  
  
3.  **Operational** channel \(Microsoft\-Windows\-DHCP Server Events\/Operational\): This channel provides DHCP configuration auditing. For example, an event is logged if a scope on the DHCP server is added or removed from a DHCP failover relationship. For more information, see [Operational event logging](../Topic/DHCP-Failover-Events-and-Performance.md#ops).  
  
New DHCP failover\-specific events have been added to these channels for administrative and operational \(configuration audit\) event logging.  
  
### <a name="admin"></a>Administrative event logging  
Event Tracing for Windows \(ETW\) events are logged for state transition of the local server, or its partner server. These events are logged to the DHCP server **Admin** channel. The following data is provided as part of each state change event.  
  
1.  The previous state of the server  
  
2.  The current state of the server  
  
3.  The failover relationship name  
  
4.  The server host name or IP address  
  
In addition to logging its own state change, the server will log changes in the state of its failover partner server. This information is communicated by state messages from the failover partner. The following table lists the values populated for the various fields in the event log.  
  
|Event Field|Value|  
|---------------|---------|  
|Event ID|20252 \(example ID\)|  
|Date and Time|Time of the state change|  
|Computer|DHCP server host name or IP address|  
|User|NETWORK SERVICE|  
|Description|The failover state of server: <host name> for failover relationship: <relationship name> changed from: <previous state> to <current state>. The server IP address or host name corresponds to the server that has changed state. This can be the host name or IP address of the local DHCP server or the failover partner. **Note:** If the previous state of the server is not known \(this happens in the case of new relationship creation and when communication is interrupted\), the following description will be displayed for the event: The failover state of server: <host name> for failover relationship changed to <current state>.|  
|OpCode|FailoverStateChange|  
|Task Category|DHCP Failover|  
|Level|-   Error \(if transitioning out of the NORMAL state or when entering into the PARTNER DOWN state\)<br />-   Information \(if transitioning into the NORMAL state\)<br />-   Warning \(for transitions between other states\)|  
|Keywords||  
  
See the following example event.  
  
![](../Image/DHCP_event1.gif)  
  
The following type of event data is logged when a server detects that it is out of time synchronization with its partner server.  
  
|Event Field|Value|  
|---------------|---------|  
|Event ID|20253|  
|Date and Time|Time of detection of time being out of sync with partner server|  
|Computer|DHCP server host name|  
|User|NETWORK SERVICE|  
|Description|The server detected that it is out of time synchronization with partner server: <host name> for failover relationship: <relationship name>. The time is out of sync by: <\# of seconds> seconds.|  
|OpCode|TimeOutOfSync|  
|Task Category|DHCP Failover|  
|Level|Error|  
|Keywords||  
  
An event will also be logged when a connection is established and when a connection is lost between DHCP failover partners.  
  
|Level|Opcode|Task Category|Description|  
|---------|----------|-----------------|---------------|  
|Error|CommDown|DHCP Failover|Server has lost contact with failover partner server: <host name> for relationship: <relationship name>.|  
|Information|CommUp|DHCP Failover|Server has established contact with failover partner server: <host name> for relationship: <relationship name>.|  
  
### <a name="ops"></a>Operational event logging  
The following information\-level configuration audit events are logged to the DHCP server **Operational** channel.  
  
|Event Type|OpCode|Description|  
|--------------|----------|---------------|  
|Creation of Failover Relationship|CreateFailover|A failover relationship has been created between servers: <host name> and <host name> with the following configuration parameters: Name: <value> Mode: <mode>, Maximum Client Lead Time: <value> seconds, Load Balance percentage on this server\/Reserve Address percentage on standby server: <value>, Auto state switchover interval: <value> seconds Standby server: <host name>|  
|Deletion of Failover Relationship|DeleteFailover|Failover relationship <relationship name>  between <host name> and <host name> has been deleted|  
|Addition of a scope to an existing failover relationship|AddFailoverScope|Scope <scope ID> has been added to the failover relationship <relationship name> with server <host name>|  
|Removal of a scope from an existing failover relationship|RemoveFailoverScope|Scope <scope ID> has been removed from the failover relationship <relationship name> with server <host name>|  
|Change MCLT|ChangeFailoverConfig|The failover configuration parameter MCLT for failover relationship <relationship name> with server <host name> has been changed from <old value> seconds to <new value> seconds|  
|Change Auto state switchover interval|ChangeFailoverConfig|The failover configuration parameter Auto State switchover interval for failover relationship <relationship name> with server <host name> has been changed from <old value> seconds to <new value> seconds|  
|Change Reserve Address percentage|ChangeFailoverConfig|The failover configuration parameter Reserve Address Percentage on standby server for failover relationship <relationship name> with server <host name> has been changed from <old value> to <new value>|  
|Change Mode of failover relationship|ChangeFailoverConfig|The failover configuration parameter Mode for failover relationship <relationship name> with server <host name> has been changed from <old value> to <new value>|  
|Change Load Balance percentage|ChangeFailoverConfig|The failover configuration parameter Load Balance percentage for failover relationship <relationship name> with server <host name> has been changed from <old value> to <new value> on this server|  
  
See the following example event.  
  
![](../Image/DHCP_event2.gif)  
  
## <a name="perf"></a>Performance counters  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces the following new DHCP failover\-related performance counters to the DHCP server counters:  
  
-   Binding Updates sent per minute  
  
-   Binding Acks received per minute  
  
-   Binding Updates received per minute  
  
-   Binding Acks sent per minute  
  
-   Number of pending outbound binding updates on this server  
  
-   Number of transitions into COMMUNICATION INTERRUPTED state  
  
-   Number of transitions into PARTNER DOWN state  
  
-   Number of transitions into RECOVER state  
  
-   Number of Binding Update queue running at 90% of the maximum queue size  
  
-   Number of Binding Updates dropped  
  
## See also  
[What is DHCP Failover?](../Topic/What-is-DHCP-Failover-.md)  
  
[DHCP Failover Relationships](../Topic/DHCP-Failover-Relationships.md)  
  
[DHCP Failover Modes](../Topic/DHCP-Failover-Modes.md)  
  
[DHCP Failover Communications](../Topic/DHCP-Failover-Communications.md)  
  
[DHCP Failover Settings](../Topic/DHCP-Failover-Settings.md)  
  
[DHCP Failover Examples](../Topic/DHCP-Failover-Examples.md)  
  
[Deploy DHCP Failover](../Topic/Deploy-DHCP-Failover.md)  
  
