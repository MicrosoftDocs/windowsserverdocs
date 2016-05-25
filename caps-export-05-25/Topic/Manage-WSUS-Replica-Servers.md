---
title: Manage WSUS Replica Servers
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bbcd889e-3d5d-4e68-9357-fa85b4685fed
author: britw
---
# Manage WSUS Replica Servers
A WSUS replica server inherits update approvals and computer groups from the upstream WSUS server. A WSUS deployment that uses replica servers typically consists of a single WSUS root server that manages updates, and one or more downstream replica WSUS servers.  
  
You can perform limited administration on a WSUS replica server. This administration consists of the following tasks:  
  
-   Add and remove computers from computer groups.  
  
    You must assign the client computers that are serviced by the replica WSUS server to the computer groups that are inherited from the upstream WSUS server.   
    For more information about how to assign computers to computer groups, see [Manage WSUS client computers &#91;SP\_2&#93;](assetId:///1ee6068f-99c9-4cdd-a080-b236ea7adbd8).  
  
-   View approved updates.  
  
    On a replica WSUS server, you can view updates that are approved on the upstream WSUS server.   
    For more information about how to view approved updates, see [Viewing Updates](assetId:///e730a8e0-3c84-4a6f-b950-7fddd18051e8).  
  
-   Monitor update, synchronization, computer status, and WSUS settings.  
  
    You can view all standard WSUS reports on replica WSUS servers. You can also roll up replica server reports to an upstream WSUS server.   
    For more information about how to view and use reports, see [Use Reports in Windows Server Update Services 3.0 SP2](../Topic/Use-Reports-in-Windows-Server-Update-Services-3.0-SP2.md).  
  
## See Also  
[Replica mode \(centralized administration\)](../Topic/Design-the-WSUS-Server-Layout.md#replica)  
[Configure and Manage Replica Servers](../Topic/Configure-and-Manage-Replica-Servers.md)  
  
