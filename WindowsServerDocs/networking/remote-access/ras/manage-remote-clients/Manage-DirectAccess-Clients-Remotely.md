---
title: Manage DirectAccess Clients Remotely
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 36255d80-a13e-4af7-a5c0-ab4c8f302622
ms.author: coreyp
author: coreyp-at-msft
---
# Manage DirectAccess Clients Remotely

>Applies To: Windows Server&reg; 2016

Remote Access monitoring reports remote user activity and status for DirectAccess and VPN connections. It tracks the number and duration of client connections (among other statistics), and monitors the operations status of the server. An easy-to-use monitoring console provides a view of your entire Remote Access infrastructure. Monitoring views are available for single server, cluster, and multisite configurations.  
  
**Note:** Windows Server 2012 combines DirectAccess and Routing and Remote Access Service (RRAS) into a single Remote Access role.  
  
> [!NOTE]  
> In addition to this topic, the following topics on monitoring Remote Access are available.  
>   
> -   [Monitor the existing load on the Remote Access server](assetId:///fa62d1f8-cf61-4db9-b6e8-9e2ec27d169a)  
> -   [Monitor the configuration distribution status of the Remote Access server](assetId:///f16d1ae7-e016-4781-b2a0-e4590ae9c44b)  
> -   [Monitor the Operations Status of the Remote Access server and its components](assetId:///dc05c74f-aa37-463c-af6d-18d71ef63ed7)  
> -   [Identify and resolve Remote Access server operations problems](assetId:///01913def-a5fe-48d0-b687-eec40b268bb2)  
> -   [Monitor connected remote clients for activity and status](assetId:///203afd16-8def-4ed1-94f8-dc4484089d74)  
> -   [Generate a usage report for remote clients using historical data](assetId:///6c1a2aff-2055-4e24-b834-e73269cf0fa4)  
> -   Blog post: [Additional way to monitor DirectAccess machine/user activity on Windows 2012 and 2012R2 DirectAccess with component event logging](http://blogs.technet.com/b/martin_j_solis/archive/2015/03/20/additional-way-to-monitor-directaccess-machine-user-activity-on-windows-2012-and-2012r2-directaccess-with-component-even-logging.aspx)  
  
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
  


