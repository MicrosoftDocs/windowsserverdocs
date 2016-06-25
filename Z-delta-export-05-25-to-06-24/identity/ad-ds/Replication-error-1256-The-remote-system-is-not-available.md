---
title: Replication error 1256 The remote system is not available
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
ms.assetid: eb8f6b88-a7fe-4e58-bf5f-b9b2ece15d1e
---
# Replication error 1256 The remote system is not available
This article describes the symptoms, cause, and resolution steps for cases when Active Directory replication fails with error 1256: The remote system is not available.  
  
-   [Symptoms](../../identity/ad-ds/Replication-error-1256-The-remote-system-is-not-available.md#BKMK_Symptoms)  
  
-   [Cause](../../identity/ad-ds/Replication-error-1256-The-remote-system-is-not-available.md#BKMK_Cause)  
  
-   [Resolution](../../identity/ad-ds/Replication-error-1256-The-remote-system-is-not-available.md#BKMK_Resolution)  
  
##  <a name="BKMK_Symptoms"></a> Symptoms  
  
1.  The DCDIAG reports that the Active Directory Replications test has failed with error 1256: "The remote system is not available."  
  
    ```  
    Starting test: Replications  
    [Replications Check, <Destination DC>] A recent replication attempt failed:  
    From <source DC> to <destination DC>  
    Naming Context: <directory partition DN path>  
    The replication generated an error (1256):The remote system is not available. For information about network troubleshooting, see Windows Help.  
    The failure occurred at <date> <time>  
    The last success occurred at <date> <time>  
  
    ```  
  
2.  REPADMIN.EXE reports that a replication attempt has failed with status 1256.  
  
     REPADMIN commands that commonly cite the 1256 status include but are not limited to:  
  
    |||  
    |-|-|  
    |-   REPADMIN \/REPLSUM<br />-   REPADMIN \/SHOWREPL|-   REPADMIN \/SHOWREPS<br />-   REPADMIN \/FAILCACHE|  
  
     Sample output from "REPADMIN \/SHOWREPS" depicting inbound replication from LonEMEADC to LonContosoDC failing with "The remote system is not available" error is shown below:  
  
    ```  
    Repadmin: running command /showrepl against full DC localhost  
    London\LONCONTOSODC  
    DSA Options: IS_GC   
    Site Options: (none)  
    DSA object GUID: a29bbfda-8425-4cb9-9c66-8e07d505a5c6  
    DSA invocationID: d58a6322-6a28-4708-82d3-53b7dcc13c1a  
    ==== INBOUND NEIGHBORS ==========  
    <snip>  
    DC=ForestDnsZones,DC=Contoso,DC=com  
    London\LONEMEADC via RPC  
    DSA object GUID: cd691606-63d1-4cc8-b77a-055674ba569d  
    Last attempt @ 2010-06-10 17:35:46 failed, result 1256 (0x4e8):The remote system is not available. For information about network troubleshooting, see Windows Help.  
    <#> consecutive failure(s).  
    Last success @ <date> <time>.  
  
    ```  
  
3.  NTDS KCC, NTDS Replication, or ActiveDirectory\_DomainService events with the 1256 status are logged in the directory service event log.  
  
    |Event ID|Event Source|Event String|  
    |--------------|------------------|------------------|  
    |1085 **Note:**  Event 1085 is logged only if the NTDS Diagnostics value **"5 Replication Events"** has been set to a value of 1 or higher.|NTDS Replication<br /><br /> ActiveDirectory\_DomainService|Internal event: Active Directory Domain Services could not synchronize the following directory partition with the directory service at the following network address.|  
    |1308|NTDS KCC<br /><br /> ActiveDirectory\_DomainService|The Knowledge Consistency Checker \(KCC\) has detected that successive attempts to replicate with the following domain controller has consistently failed.<br /><br /> The Knowledge Consistency Checker \(KCC\) has detected that successive attempts to replicate with the following directory service has consistently failed.|  
  
##  <a name="BKMK_Cause"></a> Cause  
 When the destination DC fails to bind to the source DC using RPC, a win32 error code appears in the **Repsfrom** status for that partition \- usually Schema or Configuration partitions because they are replicated at a higher priority. After an RPC bind failure has occurred, a cleanup routine will run to clear the destination DCs queue from that same source DC. This is done to avoid wasting time attempting to replicate with a DC that it cannot connect to. Because it has not attempted a sync for the partitions that have been cleared from the queue, a status 1256 is logged. In a scenario where destination DC replicates Schema, Configuration, and several GC non\-writable partitions from the source DC, the win32 error status for the Schema and Configuration partitions that caused the RPC bind failure is logged. The destination DC will then cancel the pending replication tasks for the remaining partitions and log win32 error 1256 for the status.  
  
 In summary: 1256 is logged as the replication status per partition as a result of the destination DC cancelling the sync request from the source DC due to a connectivity failure previously encountered.  
  
##  <a name="BKMK_Resolution"></a> Resolution  
 The win32 error 1256 should not be the focus of troubleshooting efforts, instead find the replication status that led to the RPC bind failure and then follow the corresponding article on TechNet.   
Microsoft Knowledge Base article [2498185](http://support.microsoft.com/kb/2498185) contains a list of Active Directory Replication troubleshooting articles.  
  
 In order to determine the actual win32 error to troubleshoot use *one* of the following methods:  
  
1.  View **repadmin \/showreps** or **\/showrepl** output on the destination DC.  
  
    1.  Identify Source DC in the output and list all win32 status messages per partition.  
  
    2.  The win32 status that is listed that is not a 1256 should be the focus of troubleshooting efforts.  
  
2.  Using **repadmin \/showrepl \* \/csv** output:  
  
    1.  Filter column K, **Last Failure Status:**, clear **0** and **\(Blanks\)**.  
  
    2.  Filter column C, Destination DSA: Clear **\(Select All\)** and select just the DC where the 1256 status is logged.  
  
    3.  If 1256 is logged on more than one Source DC, Filter column F, **Source DSA:**, clear  **\(Select All\)** and Select just one DC to narrow the focus.  
  
    4.  Column K, **Last Failure Status** will list the 1256s along with the real win32 error that led to the RPC bind failure.  
  
         In the following example, win32 error 1722 is logged for the Configuration and Schema partitions and should be the focus of troubleshooting.  
  
        ||||||||||  
        |-|-|-|-|-|-|-|-|-|  
        |B|C|D|E|F|H|I|J|K|  
        |Destination DSA Site|Destination DSA|Naming Context|Source DSA Site|Source DSA|Number of Failures|Last Failure Time|Last Success Time|Last Success Status|  
        |London|LONCONTOSODC|CN\=Configuration,DC\=Contoso,DC\=com|London|LONEMEADC|11|6\/10\/2010 17:35|6\/10\/2010 14:50|1722|  
        |London|LONCONTOSODC|CN\=Schema,CN\=Configuration,DC\=Contoso,DC\=com|London|LONEMEADC|11|6\/10\/2010 17:35|6\/10\/2010 14:50|1722|  
        |London|LONCONTOSODC|DC\=ForestDnsZones,DC\=Contoso,DC\=com|London|LONEMEADC|11|6\/10\/2010 17:35|6\/10\/2010 14:50|**1256**|  
        |London|LONCONTOSODC|DC\=corp,DC\=Contoso,DC\=com|London|LONEMEADC|11|6\/10\/2010 17:35|6\/10\/2010 14:50|1256|  
        |London|LONCONTOSODC|DC\=EMEA,DC\=Contoso,DC\=com|London|LONEMEADC|11|6\/10\/2010 17:35|6\/10\/2010 14:50|1256|  
        |London|LONCONTOSODC|DC\=apac,DC\=Contoso,DC\=com|London|LONEMEADC|11|6\/10\/2010 17:35|6\/10\/2010 14:50|1256|  
  
3.  Initiate a manual replication sync between source and destination DCs using repadmin.  
  
    ```  
    Repadmin /replicate DestinationDC SourceDC DN of partition reporting status 1256  
    ```  
  
     \(use **\/readonly** switch for GC partition or **\/selsecrets** switch if destination is an RODC\)  
  
    ```  
    repadmin /replicate loncontosodc lonemeadc.emea.contoso.com dc=forestdnszones,dc=contoso,dc=com   
    DsReplicaSync() failed with status 1722 (0x6ba):  
    The RPC server is unavailable.  
  
    ```  
  
     Take note that after manually initiating replication for the partition that the status has changed from 1256 to 1722:  
  
    ||||||||||  
    |-|-|-|-|-|-|-|-|-|  
    |B|C|D|E|F|H|I|J|K|  
    |Destination DSA Site|Destination DSA|Naming Context|Source DSA Site|Source DSA|Number of Failures|Last Failure Time|Last Success Time|Last Success Status|  
    |London|LONCONTOSODC|CN\=Configuration,DC\=Contoso,DC\=com|London|LONEMEADC|11|6\/10\/2010 17:35|6\/10\/2010 14:50|1722|  
    |London|LONCONTOSODC|CN\=Schema,CN\=Configuration,DC\=Contoso,DC\=com|London|LONEMEADC|11|6\/10\/2010 17:35|6\/10\/2010 14:50|1722|  
    |London|LONCONTOSODC|DC\=ForestDnsZones,DC\=Contoso,DC\=com|London|LONEMEADC|12|6\/10\/2010 17:35|6\/10\/2010 14:50|**1722**|  
    |London|LONCONTOSODC|DC\=corp,DC\=Contoso,DC\=com|London|LONEMEADC|11|6\/10\/2010 17:35|6\/10\/2010 14:50|1256|  
    |London|LONCONTOSODC|DC\=EMEA,DC\=Contoso,DC\=com|London|LONEMEADC|11|6\/10\/2010 17:35|6\/10\/2010 14:50|1256|  
    |London|LONCONTOSODC|DC\=apac,DC\=Contoso,DC\=com|London|LONEMEADC|11|6\/10\/2010 17:35|6\/10\/2010 14:50|1256|  
  
## See Also  
 [Troubleshooting Active Directory operations that fail with error 1256: The remote system is not available.](http://support.microsoft.com/kb/2200187)