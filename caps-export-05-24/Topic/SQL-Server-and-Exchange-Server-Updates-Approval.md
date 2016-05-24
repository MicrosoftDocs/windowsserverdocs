---
title: SQL Server and Exchange Server Updates Approval
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4eaca848-f733-4956-970c-684df2655439
author: britw
---
# SQL Server and Exchange Server Updates Approval
Microsoft SQL Server® installations can become quite complex, with multiple instances or even versions of SQL Server on a single computer. You need to make sure that when you specify your synchronization options, you account for all the versions of the SQL Server that you have on the computer. For more information about configuring synchronization options, see [Schedule WSUS synchronizations using the WSUS Administration Console](../Topic/Schedule-WSUS-synchronizations-using-the-WSUS-Administration-Console.md).  
  
## Updating Microsoft SQL Server and Microsoft Exchange Servers that are part of a cluster  
Microsoft SQL Server and Microsoft Exchange Server can be installed in a *clustered environment*. If there is an update available for clustered servers, each server in the cluster must be updated individually. We recommend that you update passive cluster nodes individually. You will need to stop the cluster service for each server while you update it, and then restart the service.  
  
> [!NOTE]  
> You can have a stand\-alone instance and a clustered instance of SQL Server on the same server. If you are updating a server that is running both a stand\-alone instance and a clustered instance of SQL Server, both SQL Server instances will be updated if you have specified the correct synchronization options.  
  
