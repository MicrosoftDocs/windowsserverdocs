---
title: AD Forest Recovery - Verify Replication 
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 07/07/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.assetid: 302e522a-fb40-43bc-bc63-83dcc87ebde5
ms.technology: identity-adfs
---




# Resources to verify replication is working 

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2
 
 After you have restored or re-installed all DCs, you can verify that AD DS and SYSVOL are recovered and replicating correctly by using **repadmin /replsum**, which runs on any version of Windows Server.  
  
> [!TIP]
>  You can also download and run the [Active Directory Replication Status Tool](http://www.microsoft.com/download/details.aspx?id=30005) (ADReplStatus), a free tool that monitors replication status of DCs and reports errors. ADReplStatus requires .NET Framework 4, which will be installed if it is not already present.  
  
 Check the DFS Replication log in Event Viewer for Event ID 4602 (or File Replication Service event ID 13516), which indicates SYSVOL has been initialized.  
  
 If the first recovered DC logs Event ID 4614 (“the domain controller is waiting to perform initial replication. The replicated folder will remain in the initial synchronization state until it has replicated with its partner”) in the DFS Replication log, then Event ID 4602 does not appear and you need to perform the following manual steps to recover SYSVOL if it is replicated by DFSR:  
  
1.  When DFSR Event 4612 appears on the first restored DC perform a manual authoritative restore as described in [2218556: How to force an authoritative and non-authoritative synchronization for DFSR-replicated SYSVOL (like "D4/D2" for FRS)](http://support.microsoft.com/kb/2218556) (http://support.microsoft.com/kb/2218556).  
  
2.  Set **SysvolReady Flag** to 1 manually, as described in [947022 The NETLOGON share is not present after you install Active Directory Domain Services on a new full or read-only Windows Server 2008-based domain controller](http://support.microsoft.com/kb/947022).  
  
 You can also create a diagnostic report DFS Replication. For more information, see [Create a Diagnostic Report for DFS Replication](http://technet.microsoft.com/library/cc754227.aspx) and [DFS Step-by-Step Guide for Windows Server 2008](http://technet.microsoft.com/library/cc732863\(WS.10\).aspx). If the server is running Windows Server 2008 R2, you can use [dfsrdiag.exe ReplicationState command line switch](http://blogs.technet.com/b/filecab/archive/2009/05/28/dfsrdiag-exe-replicationstate-what-s-dfsr-up-to.aspx).  
  
 You can also run the Replications test using dcdiag.exe to check for replication errors. For more information, see Knowledge Base [article 249256](http://support.microsoft.com/kb/249256).

## Next Steps

- [AD Forest Recovery Guide](AD-Forest-Recovery-Guide.md)
- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)
