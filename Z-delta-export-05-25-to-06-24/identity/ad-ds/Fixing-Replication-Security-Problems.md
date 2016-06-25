---
title: Fixing Replication Security Problems
H1: na
ms.custom: 
  - x
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: b1edd538-2fc4-4a24-bd28-440d02922585
---
# Fixing Replication Security Problems
This section provides a description of security problems that you might experience when Active Directory replication is enabled. When security problems cause replication to fail, various event log messages and Repadmin messages contain error codes that identify the problems.  
  
 The Dcdiag.exe tool reports on the overall health of replication with respect to Active Directory Domain Services \(AD DS\). Dcdiag detects common causes of "Access denied" events, "Account unknown" events, and similar events. The Dcdiag security test was introduced in Windows Server 2003 with Service Pack 1 \(SP1\). It is not available in earlier versions of Windows Server.  
  
 The error codes that Dcdiag detects are described in the following table. Error codes that are marked with an asterisk \(\*\) are not always caused by a security problem.  
  
|Error code|Description|  
|----------------|-----------------|  
|5|Access is denied.|  
|1314\*|A required privilege is not held by the client.|  
|1326|Logon failure: unknown user name or bad password.|  
|1396|Logon failure: The target account name is incorrect.|  
|1908|Could not find the domain controller for this domain.|  
|1397\*|Mutual authentication failed. The server's password is out of date at the domain controller.|  
|1398\*|There is a time and\/or date difference between the client and server.|  
|1722\*|The remote procedure call \(RPC\) server is unavailable.|  
|2202\*|The specified username is invalid.|  
|8453|Replication access was denied.|  
  
 Use the procedures in [An "Access denied" or other security error has caused replication problems](../Topic/An%20%22Access%20denied%22%20or%20other%20security%20error%20has%20caused%20replication%20problems.md) to diagnose and fix replication security problems.