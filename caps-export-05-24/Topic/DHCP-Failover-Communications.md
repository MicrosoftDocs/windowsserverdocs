---
title: DHCP Failover Communications
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fe7c679e-3f90-4a1e-81bd-a6a8c33a5b36
---
# DHCP Failover Communications
Both DHCP servers in a failover relationship must maintain a persistent TCP connection with each other. DHCP failover partners establish and maintain this connection on port 647, and use it to exchange operational state information and lease information.  
  
![](../Image/DHCP_failover-connection.gif)  
  
The primary DHCP server will initiate one connection for every DHCP failover relationship that is configured on the server. The connection is used to ensure lease information is consistent across both servers, and to enable each server to monitor the operational state of its partner. DHCP servers are notified if the connection is broken for any reason.  
  
To ensure a persistent TCP connection between DHCP failover partners is maintained, it is important to use a static IP address on all DHCP server network interfaces. If the static IP address of a DHCP server needs to be changed, for example during DHCP migration, you must first delete all DHCP failover relationships that exist on that server, and then recreate the relationships when the new IP address is active.  
  
For examples of how DHCP failover partners communicate before and after service interruption, see [DHCP Failover Examples](../Topic/DHCP-Failover-Examples.md).  
  
## <a name="messages"></a>DHCP failover messages  
The following table provides a summary of DHCP failover message types defined by the Internet Engineering Task Force \(IETF\) DHCP Failover Protocol draft. A short description of each message is provided. For more information, see the IETF [DHCP Failover Protocol](http://www.ietf.org/proceedings/59/I-D/draft-ietf-dhc-failover-12.txt) draft.  
  
> [!IMPORTANT]  
> Microsoft’s implementation of DHCP failover does not display DHCP servers as primary or secondary in the DHCP console interface. In the following section, **primary** refers to the DHCP server on which a DHCP failover relationship is first configured, or the server specified to be the **active** server in a hot standby configuration.  
  
|Type|Function|Description|  
|--------|------------|---------------|  
|**BNDUPD**|Update a failover partner with binding information|The BNDUPD \(binding update\) message is used to send binding database changes \(also known as binding update transactions\) to a partner server. The partner server responds with a BNDACK \(binding acknowledgment\) message when it has successfully committed the requested changes to its own database. BNDUPD and BNDACK messages can contain multiple binding update transactions.<br /><br />The BNDUPD message is also used to distribute addresses for address allocation. Note: Microsoft’s implementation of DHCP failover does not use POOLREQ and POOLRESP messages as specified in the IETF DHCP failover protocol draft.|  
|**BNDACK**|Acknowledge receipt of a binding update|A server sends a BNDACK \(binding acknowledgment\) message when it has processed a BNDUPD message and successfully committed binding database changes \(made as a result of processing the BNDUPD message\).  A BNDACK message might be used to accept or to reject a BNDUPD message.  If a BNDACK message is used to reject a BNDUPD message, it will contain a reject reason. BNDUPD and BNDACK messages can contain multiple binding update transactions.<br /><br />A BNDACK message can only be sent in response to a BNDUPD message using the same TCP connection from which the BNDUPD message was received. If a connection to a partner server goes down, a server with unprocessed BNDUPD messages might discard these messages or it might process the messages. However, it will not send any BNDACK messages in response.|  
|**CONNECT**|Establish a connection with the failover partner|The connect message is used to establish a TCP connection between failover partners.  The connect message provides source information for the connection and required configuration information.  It is the first message sent using a newly established connection, and it is only sent only by the primary server.|  
|**CONNECTACK**|Respond to an attempt to establish a connection with the failover partner|The CONNECTACK \(connect acknowledgment\) message is sent to accept or reject a CONNECT message. It is sent by the secondary server which received a CONNECT message.|  
|**UPDREQALL**|Request a full transfer of binding information|The UPDREQALL \(update request all\) message is used by one server to request that its partner send it all of the IP address lease information.  This message is used to allow one server to restore its binding database in its entirety from the other server.|  
|**UPDDONE**|Indicate that all binding update information has been sent|The UPDDONE \(update done\) message is used by a server receiving an UPDREQ or UPDREQALL message to signify that it has sent all of the requested BNDUPD messages and that it has received a corresponding BNDACK for each of those messages.<br /><br />A BNDACK message must be received for each BNDUPD message prior to the transmission of the UPDDONE message.|  
|**UPDREQ**|Request transfer of new binding information|The UPDREQ \(update request\) message is used by one server to request that its partner send it all of the binding database information that it has not already seen. An UPDDONE message is sent after all UPDREQ messages have been received and processed.|  
|**STATE**|Inform the failover partner of the current state or of a state change|The state \(STATE\) message is used to communicate the current failover state to the partner server. No response is required from the partner server. For more information about failover states, see [DHCP Failover Settings](../Topic/DHCP-Failover-Settings.md).|  
|**CONTACT**|Probe communications integrity with the failover partner|The CONTACT message is sent to verify communications integrity with a failover partner.  The CONTACT message is sent when no messages have been sent to the failover partner for a default period of time.|  
  
## See also  
[What is DHCP Failover?](../Topic/What-is-DHCP-Failover-.md)  
  
[DHCP Failover Examples](../Topic/DHCP-Failover-Examples.md)  
  
[DHCP Failover Settings](../Topic/DHCP-Failover-Settings.md)  
  
[DHCP Failover Modes](../Topic/DHCP-Failover-Modes.md)  
  
[Deploy DHCP Failover](../Topic/Deploy-DHCP-Failover.md)  
  
