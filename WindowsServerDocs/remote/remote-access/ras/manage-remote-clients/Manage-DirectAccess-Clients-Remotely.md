---
title: Manage DirectAccess Clients Remotely
description: This topic is part of the guide Manage DirectAccess Clients Remotely in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 36255d80-a13e-4af7-a5c0-ab4c8f302622
ms.author: pashort
author: shortpatti
---
# Manage DirectAccess Clients Remotely

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

Remote Access monitoring reports remote user activity and status for DirectAccess and VPN connections. It tracks the number and duration of client connections (among other statistics), and monitors the operations status of the server. An easy-to-use monitoring console provides a view of your entire Remote Access infrastructure. Monitoring views are available for single server, cluster, and multisite configurations.  
  
**Note:** Windows Server 2016 combines DirectAccess and Remote Access Service (RAS) into a single Remote Access role.  
  
## In this guide  
This document contains instructions for leveraging the monitoring capabilities of Remote Access by using the DirectAccess management console and the corresponding Windows PowerShell cmdlets, which are provided as part of the Remote Access server role.  
  
The following monitoring and accounting scenarios are explained:  
  
1.  Monitor the existing load on the Remote Access server  
  
2.  Monitor the configuration distribution status of the Remote Access server  
  
3.  Monitor the operations status of the Remote Access server and its components  
  
4.  Identify and resolve Remote Access server operations issues  
  
5.  Monitor connected remote clients for activity and status  
  
6.  Generate a usage report for remote clients by using historical data  
  
### Understand monitoring and accounting  
Before you begin monitoring and accounting tasks for remote clients, you need to understand the difference between the two.  
  
-   **Monitoring** shows actively connected users at a given point in time.  
  
-   **Accounting** keeps a history of users who have connected to the corporate network, and their usage details (for compliance and auditing purposes).  
  
Remote client monitoring is based on connections. There are two types of tunnel connections that are established by DirectAccess clients:  
  
-   **Machine tunnel traffic connections**: This tunnel is established by the computer, in system context, to access servers that are required for name resolution, authentication, remediation updating, and so on.  
  
-   **User tunnel traffic connections**: This tunnel is established by the user account on the computer, in a user context, when the user tries to access a resource on the corporate network. Depending on the deployment requirements, a user might have to provide strong credentials (for example, by using a smart card or providing a one-time password) to access the corporate network resources.  
  
For DirectAccess, a connection is uniquely identified by the IP address of the remote client. For example, if a machine tunnel is open for a client computer, and a user is connected from that computer, these would be using the same connection. In a situation where the user disconnects and connects again while the machine tunnel is still active, it is a single connection.  
  


