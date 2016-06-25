---
title: Replication error 8452 The naming context is in the process of being removed or is not replicated from the specified server
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
ms.assetid: 0b8174c6-62bd-47ba-ac46-01f8cf3c5e8c
---
# Replication error 8452 The naming context is in the process of being removed or is not replicated from the specified server
This topic explains symptoms, causes and how to resolve Active Directory replication error 8452: The naming context is in the process of being removed or is not replicated from the specified server.  
  
-   [Symptoms](../../identity/ad-ds/Replication-error-8452-The-naming-context-is-in-the-process-of-being-removed-or-is-not-replicated-from-the-specified-server.md#BKMK_Symptoms)  
  
-   [Causes](../../identity/ad-ds/Replication-error-8452-The-naming-context-is-in-the-process-of-being-removed-or-is-not-replicated-from-the-specified-server.md#BKMK_Causes)  
  
-   [Resolutions](../../identity/ad-ds/Replication-error-8452-The-naming-context-is-in-the-process-of-being-removed-or-is-not-replicated-from-the-specified-server.md#BKMK_Resolutions)  
  
##  <a name="BKMK_Symptoms"></a> Symptoms  
  
1.  DCDIAG reports that Active Directory Replications test has failed with error status code \(8452\): "The naming context is in the process of being removed or is not replicated from the specified server."  
  
    ```  
    Testing server: <site name>\<destination dc name>  
    Starting test: Replications  
    * Replications Check  
    [Replications Check,<destination DC name] A recent replication attempt failed:  
    From <source DC> to <destination DC>  
    Naming Context: <directory partition DN path>  
    The replication generated an error (8452):  
    The naming context is in the process of being removed or is not replicated from the specified  
    server. The failure occurred at <date> <time>.  
    The last success occurred at <date> <time>.  
    3 failures have occurred since the last success.  
    ```  
  
2.  REPADMIN.EXE reports that the last replication attempt has failed with status 8452.  
  
     REPADMIN commands that commonly cite the 8452 status include but are not limited to:  
  
    |||  
    |-|-|  
    |-   REPADMIN \/SHOWREPS<br />-   REPADMIN \/REPLSUM|-   REPADMIN \/SYNCALL|  
  
     The following sample output from "REPADMIN \/SHOWREPS" shows inbound replication from CONTOSO\-DC2 to CONTOSO\-DC1 failing with the "The naming context is in the process of being removed or is not replicated from the specified server" error:  
  
    ```  
    Default-First-Site-Name\CONTOSO-DC1  
    DSA Options: IS_GC   
    Site Options: (none)  
    DSA object GUID: b6dc8589-7e00-4a5d-b688-045aef63ec01  
    DSA invocationID: b6dc8589-7e00-4a5d-b688-045aef63ec01  
    ==== INBOUND NEIGHBORS ==========  
    DC=contoso,DC=com  
    Default-First-Site-Name\CONTOSO-DC2 via RPC  
    DSA object GUID: 74fbe06c-932c-46b5-831b-af9e31f496b2  
    Last attempt @ <date> <time> failed, result 8452 (0x2104):  
    The naming context is in the process of being removed or is not replicated from the specified server.  
    <#> consecutive failure(s).  
    Last success @ <date> <time>.  
  
    ```  
  
3.  In Active Directory Sites and Services, if you right\-click the connection object and click **Replicate now**, the error "The naming context is in the process of being removed or is not replicated from the specified server."  
  
     Right\-clicking on the connection object from a source DC and choosing "replicate now" fails with "The naming context is in the process of being removed or is not replicated from the specified server.". The on\-screen error message text and screenshot is shown below:  
  
     Dialog title text: Replicate Now  
  
     Dialog message text:  
  
     The following error occurred during the attempt to synchronize naming context \<%directory partition name%\> from Domain Controller \<Source DC\> to Domain Controller \<Destination DC\>:  
  
     The naming context is in the process of being removed or is not replicated from the specified server.  
  
     The operation will not continue.  
  
4.  NTDS KCC, NTDS General or Microsoft\-Windows\-ActiveDirectory\_DomainService events with the 8452 status are logged in the directory service event log.  
  
     Active Directory events that commonly cite the 8452 status include but are not limited to:  
  
    |Event ID|Event Source|Event String|  
    |--------------|------------------|------------------|  
    |1586|NTDS General|The checkpoint with the PDC was unsuccessful. The checkpointing process will be retried again in four hours. A full synchronization of the security database to downlevel domain controllers may take place if this machine is promoted to be the PDC before the next successful checkpoint. The error returned was: The naming context is in the process of being removed or is not replicated from the specified server.|  
  
##  <a name="BKMK_Causes"></a> Causes  
 This error most commonly occurs when replication topology on a domain controller that initiates replication differs from the replication topology defined on the copy of Active Directory on the destination domain controller.  
  
 The error naturally occurs when the replication topology in an Active Directory forest is modified by:  
  
-   Adding or removing partitions to or from the forest \(that is, the promotion or demotion of the first or last domain controller in a domain, or the addition or removal of an application partition, including default DNS application partitions\).  
  
-   The addition or removal of directory partitions on existing domain controllers \(that is, the promotion or demotion of a global catalog server or addition or removal of an application partition\).  
  
-   Changes in replication topology or settings \(that is, the promotion of new DCs, the demotion of existing DCs , changes to preferred or nominated bridgeheads, the building of alternate replication paths in response to replication failures or offline DCs, as well as site and site link changes\).  
  
 The error can be transient in a forest undergoing the changes above until the set of source DCs and partitions that each destination DC replicates from has inbound replicated by triggering replication operations.  
  
 The error can be persistent when replication failures prevent the end\-to\-end replication of topology changes in the forest.  
  
 The error is most commonly seen in replication scenarios triggered by REPADMIN.EXE remotely \(especially \/SYNCALL\) or the "replicate now command" in DSSITE.MSC where the copy of Active Directory on the DC triggering replication has a different list of source DCs that a destination DC replicates partitions from than what the destination DC has defined in its copy of Active Directory.  
  
 Windows 2000 domain controllers are particularly prone to this error during demotion of global catalog servers as they are slow to remove objects from read\-only partitions. Object removal during GC demotion improved dramatically on Windows Server 2003 and later.  
  
 The NTDS Replication event 1586 is caused when the PDC FSMO role for the domain has been seized or transferred to a domain controller that was not a direct replication partner of the previous role holder.  
  
 In rare conditions, the error can be caused by corruption in attributes like **hasMasterNCs** or **msds\-hasMasterNCs**.  
  
 The "More Information" section of this article contains explanations as to why the diagnostic and administrative tools listed in the Symptoms section of this article generate the 8452 error.  
  
 In summary, Error 8452 happens if anyone of the following is true:  
  
1.  When DC1 \<\- DC2 replication is initiated for a NC, on DC1 there is no replica link for the NC from DC2.  
  
2.  When DC1 \<\- DC2 replication in initiated for a NC, the NC is in the process of being removed on DC2.  
  
3.  In mixed domain environment, PDC FSMO role is transferred from DC2 to DC1, but on DC1 there is no replica link from DC2.  
  
##  <a name="BKMK_Resolutions"></a> Resolutions  
  
1.  Wait. As mentioned, this condition is usually transient and does not normally warrant troubleshooting.  
  
     If replication topology changes of the type listed in the Cause section of this article are taking place in your Active Directory forest, wait for the error condition to correct itself with time.  
  
2.  Avoid the use of the "repadmin \/syncall" command and equivalents until domain controllers initiating replication and the destination DCs being replicated to agree about the source DCs and directory partitions being replicated.  
  
3.  Make originating changes in the right places.  
  
4.  Push and Pull changes to connection objects and partition changes around as required  
  
5.  Go Direct  
  
     If you want to run the **Replicate now** command from \\\\DC3 to \\\\DC2 from Active Directory Sites and Services on \\\\DC1, focus the operation on \\\\DC3 to \\\\DC2.  
  
     If the error is caused by root cause \#3, then after the user gives the correct input, the error will not happen. For example, in case \#1 of scenario \#3, if the user input a correct \<src DC\> such that on \<dest DC\> there is a replica link from \<src DC\> for \<the NC\>, the repadmin \/replicate command will be executed successfully.  
  
6.  Resolve replication failures that block end\-to\-end replication.  
  
7.  REPADMIN \/REPLICATE  
  
8.  NTDS Replication event 1586  
  
     For NTDS Replication event 1586, transfer the PDC emulator role to an Active Directory domain controller that is *currently* a direct replication partner of the previous PDC emulator.  
  
9. If the error is caused by the demotion of a Windows 2000 global catalog server, execute the batch file in the "Directory Service is too busy to complete the operation" section of [KB 249256](http://support.microsoft.com/default.aspx?scid=kb;EN-US;249256) \(http:\/\/support.microsoft.com\/default.aspx?scid\=kb;EN\-US;249256\).  
  
## More Information  
  
### REPADMIN \/SYNCALL  
 The REPADMIN \/syncall operation will cause a DC to initiate replication from all of its source replication partners and make the source replication partners initiate replication from all of their source replication partners, and so on.  
  
 For example, suppose we have a replication topology DC1 \<\- DC2 \<\- DC3. If you run “repadmin \/syncall” on DC1, it will initiate the following replication: DC2 \<\- DC3, and DC1 \<\- DC2.  
  
 There are two cases where error 8452 might be observed in this scenario:  
  
-   Case 1: Change the replication topology to make DC2 inbound replicate from DC4 so that the current topology becomes DC1 \<\- DC2 \<\- DC4.  
  
     If you run “repadmin \/syncall” on DC1 before knowledge of the DC2 \<\- DC4 topology change inbound replicates to DC1, the syncall operation will initiate DC2 \<\- DC3 replications because DC1 still has the old replication topology stored locally. Because on DC2 at this moment KCC has created a replica link from DC4 and has deleted the replica link from DC3, the replication from DC2 \<\- DC3 cannot be executed and the operation logs error 8452.  
  
-   Case 2: Suppose a NC on DC3 is being removing when you run “repadmin \/syncall \<the NC\>” on DC1. DC2 \<\- DC3 replication will be initiated as before. Because the NC on DC3 is in the process of being removed, it is not a valid replication source, and the error 8452 appears.  
  
### Active Directory Sites and Services \(DSSITE.MSC\) \-\> Replicate Now  
 The Active Directory Sites and Services snap\-in \(DSSITE.MSC\) uses the topology information stored in the local copy of Active Directory.  
  
 Given the replication topology DC1 \<\- DC2 \<\- DC3, a connection object exists under the NTDS Settings object of DC2. This connection object represents the route for DC2 to inbound replicate a NC \(or multiple NCs\) from DC3. If you right\-click on this connection object and select **Replicate now**, DC3 initiates replication from DC2.  
  
 As in the REPADMIN \/SYNCALL example, there are also two cases where we might observe error 8452:  
  
-   Case 1: Suppose we change the replication topology on DC2 to make it inbound replicate from DC4. The new replication topology is DC1 \<\- DC2 \<\- DC4. Until knowledge of this this topology change outbound replicates to DC1, the topology on DC1 is still the old topology of DC1 \<\- DC2 \<\- DC3.  
  
     Starting the Active Directory Sites and Services UI focused on DC1s copy of Active Directory still shows that DC2 has an inbound connection object from source DC3. Right\-clicking on DC3’s inbound connection object from DC2 and choosing **Replicate now** will initiate a DC2 \<\- DC3 replication on DC2. However, the KCC on DC2 already removed the replica link inbound replicating to DC2 from DC3 and created a replica link to DC2. Because the replication attempt DC2 \<\-\> DC2 cannot be executed, the request fails error 8452.  
  
-   Case2: Suppose we are removing a NC on DC3 when we right\-click the connection object and select **Replicate now** on DC1 to initiate DC2 \<\- DC3 replication for this NC. Because the NC on DC3 is in the process of being removed, DC3 is not a valid replication source, and error 8452 appears.  
  
### REPADMIN \/REPLICATE or REPADMIN \/SYNC  
 The replicate \(or sync\) command of repadmin triggers immediate replication of a naming context \(directory partition\) to a destination DC from a source DC. Its \(simplified\) syntax is:  
  
```  
repadmin /replicate <dest DC> <src DC> <replicated NC>  
```  
  
 There are two cases that will trigger error 8452 when the repadmin \/replicate \(or sync\) command is used to initiate a replication:  
  
-   Case 1: the \<src DC\> parameter is not a replication partner of \<dest DC\> for \<replicated NC\>. For example, we have a replication topology DC1 \<\- DC2 \<\- DC3 in which DC2 syncs a NC from DC3. If we call:  
  
    ```  
    repadmin /replicate DC2 DC1 <the NC>  
    ```  
  
     DC2 will initiate replication from DC1. Because DC2 does not have a replica link from DC1 for the NC, this replication cannot be executed, and error 8452 appears.  
  
-   Case 2: the NC is being removed on src DC when the following command is run:  
  
    ```  
    repadmin /replicate <dest DC> <src DC> <the NC>  
    ```  
  
     In this case, \<src DC\> is not a valid replication source and error 8452 appears.  
  
### DCDIAG  
 The showrepl \(or showreps\) command of repadmin reports the replication status for each source DC from which the destination DC has an inbound connection object. The Replications test of dcdiag checks for timely replication between DCs. If error 8452 appears in a repadmin \/showrepl report or dcdiag \/test:replications report, the reason is that the replicated NC is being removed on the source DC when the last replication happened.  
  
### NTDS Replication Event 1586  
 NTDS replication event 1586 is generated in a mixed domain environment which contains both Windows NT 4.0 and Active Directory domain controllers. In this mixed domain environment, Active Directory domain controllers replicate amongst themselves using the DS replication protocol, while the Active Directory PDC emulator replicates to Windows NT 4 BDCs using the legacy netlogon replication protocol. In this case the Active Directory PDC FSMO role holder is the single point for replication to NT4 BDCs in a common domain. The PDC maintains a checkpoint for each BDC representing the most recent replicated change. If the PDC emulator role is transferred to another Active Directory domain controller in the domain, the information about each individual BDC’s checkpoint must be replicated to the new PDC emulator. Hence the new PDC emulator must have a direct replication relationship with the old PDC emulator. If the new PDC emulator does not replicate directly with the old PDC emulator \(that is on the new PDC emulator there is no replica link from old PDC emulator\), then error 8452 appears in event 1586.  
  
### Demotion  
 There is another scenario that returns DRAERR\_NoReplica error. During DC demotion, DC locator will find a DC to replicate local changes to. If the found DC does not replicate directly with the DC being demoted, DRAERR\_NoReplica will be returned and DC locator will be called to find a destination DC. In this scenario, the error is not logged so it is not observed.  
  
## See Also  
 [Troubleshooting Active Directory operations that fail with error 8452: "The naming context is in the process of being removed or is not replicated from the specified server."](http://support.microsoft.com/kb/2023704)   
 [How the Active Directory Replication Model Works](http://technet.microsoft.com/library/cc772726\(WS.10\).aspx)   
 [repsFrom, RepsFrom](http://msdn.microsoft.com/library/cc228409\(PROT.13\).aspx)