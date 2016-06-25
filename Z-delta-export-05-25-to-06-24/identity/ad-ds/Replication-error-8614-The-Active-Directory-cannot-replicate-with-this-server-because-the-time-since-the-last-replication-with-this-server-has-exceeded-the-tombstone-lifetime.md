---
title: Replication error 8614 The Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime
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
ms.assetid: 0172a547-0a20-45b7-92c6-4167e477bb42
---
# Replication error 8614 The Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime
This article covers symptoms, root causes, and how to resolve Active Directory replication error 8614 The Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime.  
  
1.  [Symptoms](../../identity/ad-ds/Replication-error-8614-The-Active-Directory-cannot-replicate-with-this-server-because-the-time-since-the-last-replication-with-this-server-has-exceeded-the-tombstone-lifetime.md#BKMK_Symptoms)  
  
2.  [Causes](../../identity/ad-ds/Replication-error-8614-The-Active-Directory-cannot-replicate-with-this-server-because-the-time-since-the-last-replication-with-this-server-has-exceeded-the-tombstone-lifetime.md#BKMK_Causes)  
  
3.  [Resolution](../../identity/ad-ds/Replication-error-8614-The-Active-Directory-cannot-replicate-with-this-server-because-the-time-since-the-last-replication-with-this-server-has-exceeded-the-tombstone-lifetime.md#BKMK_Resolution)  
  
##  <a name="BKMK_Symptoms"></a> Symptoms  
  
1.  DCDIAG reports that Active Directory Replications test failed with error status code \(8614\): "Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime."  
  
    ```  
    Testing server: <site name>\<destination dc name>  
                Starting test: Replications  
                   * Replications Check  
                   [Replications Check,<destination DC name] A recent replication attempt failed:  
                      From <source DC> to <destination DC>  
                      Naming Context: <directory partition DN path>  
                      The replication generated an error (8614):  
                      Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime.  
                      The failure occurred at <date> <time>.  
                      The last success occurred at <date> <time>.  
                      3 failures have occurred since the last success.  
    ```  
  
2.  REPADMIN.EXE reports that the last replication attempt failed with status 8614.  
  
     REPADMIN commands that commonly cite the 8614 status include but are not limited to:  
  
    -   REPADMIN \/REPLSUM  
  
    -   REPADMIN \/SHOWREPL  
  
    -   REPADMIN \/SHOWREPS  
  
    -   REPADMIN \/SYNCALL  
  
     Sample output from "REPADMIN \/SHOWREPS" depicting inbound replication from CONTOSO\-DC2 to CONTOSO\-DC1 failing with the "replication access was denied" error is shown below:  
  
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
                        Last attempt @ <date> <time> failed, result 8614(0x21a6):  
                           The Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime.  
              <#> consecutive failure(s).  
              Last success @ <date> <time>.  
  
    ```  
  
3.  NTDS KCC, NTDS General, or Microsoft\-Windows\-ActiveDirectory\_DomainService events with the 5 status are logged in the Directory Service event log.  
  
     Active Directory events that commonly cite the 8524 status include but are not limited to the following:  
  
    |Event source|ID|Event string|  
    |------------------|--------|------------------|  
    |NTDS KCC|1925|The attempt to establish a replication link for the following writable directory partition failed.|  
  
4.  NTDS Replication Event 2042 may be logged in the Directory Service event log:  
  
     Event Type: Error  
  
     Event Source: NTDS Replication  
  
     Event Category: Replication  
  
     Event ID: 2042  
  
     User: NT AUTHORITY\\ANONYMOUS LOGON  
  
     Computer: \<name of DC that logged event\>  
  
     Description:  
  
     It has been too long since this machine last replicated with the named source   
    machine. The time between replications with this source has exceeded the tombstone   
    lifetime. Replication has been stopped with this source.  
  
     The reason that replication is not allowed to continue is that the two machine's   
    views of deleted objects may now be different. The source machine may still have   
    copies of objects that have been deleted \(and garbage collected\) on this machine.   
    If they were allowed to replicate, the source machine might return objects which   
    have already been deleted.  
  
     Time of last successful replication: YYYY\-MM\-DD HH:MM:SS  
  
     Invocation ID of source: \<32 character GUID for source DC\>  
  
     Name of source: \<fully qualified cname record of source DC\>  
  
     Tombstone lifetime \(days\): \<current TSL value. Default \= 60 or 180 days\>  
  
     The replication operation has failed.  
  
     User Action:  
  
     Determine which of the two machines was disconnected from the forest and is now out   
    of date. You have three options:  
  
    1.  Demote or reinstall the machine\(s\) that were disconnected.  
  
    2.  Use the "repadmin \/removelingeringobjects" tool to remove inconsistent deleted   
        objects and then resume replication.  
  
    3.  Resume replication. Inconsistent deleted objects may be introduced. You can   
        continue replication by using the following registry key. Once the systems   
        replicate once, it is recommended that you remove the key to reinstate the   
        protection.  
  
5.  The replicate now command in Active Directory Sites and Services returns the message "Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime."  
  
     Right\-clicking on the connection object from a source DC and choosing "replicate now" in Active Directory Sites and Services \(DSSITE.MSC\) is unsuccessful, and you receive the message "Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime."  
  
     The on\-screen error message text and screen shot are as follows:  
  
    ```  
    Dialog title text: Replicate Now  
    Dialog message text: The following error occurred during the attempt to synchronize naming context <%directory partition name%> from Domain Controller <Source DC> to Domain Controller <Destination DC>:  
    The Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime.  
  
    The operation will not continue  
    ```  
  
##  <a name="BKMK_Causes"></a> Causes  
 Active Directory domain controllers support multi\-master replication where any domain controller that is holding a writable partition can originate a create, modify, or delete of an object or attribute \(value\). Knowledge of object \/ attribute deletes persists for tombstone lifetime number of days. \(See Microsoft Knowledge Base articles [216996](http://support.microsoft.com/default.aspx?scid=kb;EN-US;216993) and [910205](http://support.microsoft.com/default.aspx?scid=kb;EN-US;910205).\)  
  
 Active Directory requires end\-to\-end replication from all partition holders to transitively replicate all originating deletes for all directory partitions to all partition holders. Failure to inbound\-replicate a directory partition in a rolling TSL number of days results in lingering objects. \(A lingering object is an object that has been intentionally deleted by at least one DC but that incorrectly exists on destination DCs that failed to inbound\-replicate the transient knowledge of all unique deletions.\)  
  
 Error 8614 is an example of logic added in domain controllers that are running Windows Server 2003 or a later version to quarantine the spread of lingering objects and to identify long\-term replication failures that cause inconsistent directory partitions.  
  
 Root causes for error 8614 and for NTDS Replication Event 2042 include the following:  
  
1.  The destination DC that is logging the 8614 error failed to inbound\-replicate a directory partition from one or more source DCs for tombstone lifetime number of days.  
  
2.  System time on the destination DC moved, or "jumped," tombstone lifetime one or more number of days in the future since the last successful replication. This gives the *appearance* to the replication engine that the destination DC failed to inbound\-replicate a directory partition for tombstone lifetime elapsed number of days.  
  
     Time jumps can occur when a destination DC successfully inbound\-replicates, adopts "bad" system time TSL or more number of days in the future, and then tries to inbound\-replicate from a source that was last replicated from TSL or more number of days in the past.  
  
     OR  
  
     Time jumps from current time to a date\/time tombstone lifetime or more days in the past, successfully inbound\-replicates, and then tries to inbound\-replicate after it adopts time TSL or more number of days in the future.  
  
 Basically, the cause and resolution steps for replication error status 8614 apply equally to the cause and to the resolution of NTDS replication event 2042.  
  
##  <a name="BKMK_Resolution"></a> Resolution  
  
> [!NOTE]  
>  There are two action plans to recover Active Directory domain controllers that are logging error status 8614 or NTDS Replication event 2042. You can either force\-demote the domain controller *or* use the action plan below that says, "Check for required fixes, look for time jumps, check for lingering objects and remove them if present, remove any replication quarantines, resolve replication failures, then put the DC back into service." Force\-demoting such DCs may be "easier" and faster but can also result in the loss of originating updates \(that is, "data loss"\) on the domain controller that is being force\-demoted. Active Directory recovers gracefully from this condition by following the steps below. Select the best solution for your scenario, but do not assume that a force demotion is the only workable solution, especially where that replication failure is easy to resolve or is external to Active Directory.  
  
1.  Check for nondefault values of tombstone lifetime.  
  
     By default, tombstone lifetime uses either 60 or 180 days, depending on the version of Windows that is deployed in your forest. Microsoft Support regularly sees DCs that have failed inbound replication for those periods of time. It is also possible that the tombstone lifetime has been configured to a very short period such as 2 days. If this is the case, DCs that did not inbound\-replicate for, say, 5 days will fail the "all DCs must replicate with a rolling TSL number of days" test.  
  
     Use repadmin \/showattr to see whether a nondefault value for the **TombstoneLifetime** attribute has been configured.  
  
     repadmin \/showattr . "CN\=Directory Service,CN\=Windows NT,CN\=Services,CN\=Configuration,DC\=\<forest root domain\>,DC\=\<top level domain\>"  
  
     If the attribute is not present in the showattr output, an internal default value is being used.  
  
2.  Check for DCs that failed inbound replication for TSL number of days.  
  
     Run "repadmin \/showrepl \* \/csv" parsed by using Microsoft Office Excel as specified in [Verify successful replication to a domain controller](http://technet.microsoft.com/library/cc794749\(WS.10\).aspx). Sort the replsum output in Excel on the last replication success column from least current to the most current date and time order.  
  
3.  Check for Windows Server 2003 domain controllers without services packs.  
  
     If the 8614 error occurred on a Windows Server 2003 domain controller without service packs, install the latest Windows Server 2003 service pack.  
  
4.  Check for time jumps.  
  
     To determine whether a time jump occurred, check event and diagnostic logs \(repadmin \/showreps, dcdiag logs\) on destination DCs that are logging 8614 errors for the following:  
  
    -   Date stamps that predate the release of an operating system \(date stamps from 2003 for an OS released in 2008\).  
  
    -   Date stamps that predate the installation of the operating system in your forest.  
  
    -   Date stamps in the future.  
  
    -   No events being logged in a given date range.  
  
     Microsoft Support teams have seen system time on production domain controllers incorrectly jump hours, days, weeks, years, and even tens of years in the past and future.  
  
     If system time was found to be inaccurate, you should correct it and then try to determine why time jumped and what can be done to prevent inaccurate time going forward vs. just correcting the bad time. Possible areas to investigate include the following:  
  
    -   Was the forest root PDC configured by using an external time source?  
  
    -   Are reference time sources online, available on the network, and resolvable in DNS?  
  
    -   Was the Microsoft or third\-party time service running and in an error\-free state?  
  
    -   Are DC\-role computers configured to use NT5DS hierarchy to source time?  
  
    -   Was the time rollback protection that is described in Microsoft Knowledge Base article [884776](http://support.microsoft.com/default.aspx?scid=kb;EN-US;884776) in place?  
  
    -   Do system clocks have good batteries and accurate time in the BIOS?  
  
    -   Are virtual host and guest computers configured to source time according to the hosting manufacturers recommendations?  
  
     Microsoft Knowledge Base article [884776](http://support.microsoft.com/default.aspx?scid=kb;EN-US;884776) documents steps to help protect domain controllers from "listening" to invalid time samples. More information on MaxPosPhaseCorrection and MaxNegPhaseCorrection is available in the [W32Time Blog](http://blogs.msdn.com/b/w32time/) post [Configuring the Time Service: Max\[Pos\/Neg\]PhaseCorrection](http://blogs.msdn.com/b/w32time/archive/2008/02/28/configuring-the-time-service-max-pos-neg-phasecorrection.aspx). Microsoft Knowledge Base article [961027](http://support.microsoft.com/default.aspx?scid=kb;EN-US;961027) describes some helpful precision updates when you configure time\-based settings in policy.  
  
5.  Check for and remove lingering objects if they are present.  
  
     The point of the 8614 error replication quarantine is to check for lingering objects and remove them, if present, in each locally held partition *before* setting "Allow Replication with divergent and corrupt partner" \= 1 in the registry of the destination DC, even if you think that all destination DCs in the forest are running in strict replication consistency.  
  
     The removal of lingering objects is beyond the scope of this article. More information can be found in the following sources:  
  
    -   Microsoft Knowledge Base article [910205](http://support.microsoft.com/kb/910205): Information about lingering objects in a Windows Server Active Directory forest  
  
    -   Technet: [Event ID 1388 or 1988: A lingering object is detected](http://technet.microsoft.com/library/cc780362\(WS.10\).aspx)  
  
    -   Microsoft Knowledge Base article [870695](http://support.microsoft.com/default.aspx?scid=kb;EN-US;870695): Outdated Active Directory objects generate event ID 1988 in Windows Server 2003  
  
     Repadmin syntax is shown here:  
  
    |||  
    |-|-|  
    |Syntax|c:\\\>repadmin \/removelingeringobjects \<Dest\_DSA\_LIST\> \<Source DSA GUID\> \<NC\> \[\/advisory\_mode\]|  
    |Online help \(Windows Server 2008 and later\)|c:\\\>repadmin \/help:removelingeringobject|  
  
6.  Evaluate setting strict replication on destination DCs.  
  
     Strict mode replication prevents lingering objects from being reanimated on destination DCs that have used garbage collection to create, delete, and reclaim intentionally deleted objects.  
  
     The registry key for strict replication is the following:  
  
    |||  
    |-|-|  
    |Path|hklm\\system\\ccs\\services\\ntds\\parameters|  
    |Setting|Strict Replication Consistency<br /><br /> \(not case sensitive\)|  
    |Type|reg\_dword|  
    |Value|0 &#124; 1|  
  
     Repadmin syntax for enabling and disabling strict replication on a single or multiple DCs is as follows:  
  
    |||  
    |-|-|  
    |Syntax|Repadmin \/regkey \<DSA\_LIST\> \<{\+&#124;\-}key\> \[value \[\/reg\_sz\]\]|  
    |Online help \(Windows Server 2008 and later\)|Repadmin \/help:regkey|  
    |Enable on a single DC|repadmin \/regkey \<fully qualified computer name\> \+strict|  
    |Enable on all DCs in forest|repadmin \/regkey \* \+strict|  
    |Enable on all GCs in forest|repadmin \/regkey gc: \+strict|  
  
7.  Set "Allow replication with divergent and corrupt partner \= 1" on the 8614 DC.  
  
     After any lingering objects are removed, disable the time\-based replication quarantine:  
  
     Registry method  
  
    |||  
    |-|-|  
    |Path|hklm\\system\\ccs\\services\\ntds\\parameters|  
    |Setting|Allow replication with divergent and corrupt partner<br /><br /> \(not case sensitive\)|  
    |Type|reg\_dword|  
    |Value|0\=disallow, 1\=allow|  
  
     Repadmin method  
  
    |||  
    |-|-|  
    |Syntax|repadmin \/regkey \<DSA\_LIST\> \<{\+&#124;\-}key\> \[value \[\/reg\_sz\]\]|  
    |Online help \(Windows Server 2008 and later\)|Repadmin \/help:regkey|  
    |Enable on a single DC|repadmin \/regkey dc01.contoso.com \+allowDivergent|  
    |Enable on all DCs in forest|repadmin \/regkey \* \+allowDivergent|  
    |Enable on all GCs in forest|repadmin \/regkey GC: \+allowDivergent|  
  
8.  Resolve AD replication failures if they are present.  
  
     When the 8614 error status is logged on a destination DC, prior replication errors that were logged in the previous TSL number of days are masked.  
  
     The fact that the 8614 error was reported by the destination DC does not mean that the replication fault resides on the destination DC. Instead, the source of the replication failure could lie with the network or DNS name resolution, or there could be a problem with authentication, with jet database, with topology, or with the replication engine on either the source DC or the destination DC.  
  
     Review past Directory Service events and diagnostic output \(dcdiag, repadmin logs\) that was generated by the source DC, by the destination DC, and by alternative replication partners in the past to identify the scope and failure status that is preventing replication between the destination DC and the source DC.  
  
9. Delete "Allow replication with divergent and corrupt partner" or set "Allow replication with divergent and corrupt partner \= 0" in the registry.  
  
10. Monitor Active Directory replication daily going forward.  
  
     Monitor end\-to\-end replication in your Active Directory forest daily by using an Active Directory monitoring application. One inexpensive but effective option is to run "repadmin \/showrepl \* \/csv" and then parse the results in Excel. \(See "Method 2: Monitor replication by using a command line" in Microsoft Knowledge Base article [910205](http://support.microsoft.com/kb/910205).\)  
  
     Identify DCs that are approaching replication failures for 50 percent and for 90 percent of tombstone lifetime, and put them on a watch list. At 50 percent of TSL, make a strong push to resolve replication errors. At 90 percent, consider demoting \(forcibly, if it is necessary, by using the **dcpromo \/forceremoval** command\) DCs that are causing replication errors.  
  
     Again, replication errors that are logged on a destination DC may be caused by a problem on the source DC, on the destination DC, or on the underlying network. Therefore, make an effort to determine the cause and where the fault is before you take preventive action.  
  
## See Also  
 [Troubleshooting Active Directory operations that fail with error 8614: "The Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime"](http://support.microsoft.com/kb/2020053)   
 [Fixing Replication Lingering Object Problems \(Event IDs 1388, 1988, 2042\)](http://technet.microsoft.com/library/cc738018\(WS.10\).aspx)   
 [317097: Lingering objects prevent Active Directory replication from occurring](http://support.microsoft.com/default.aspx?scid=kb;EN-US;317097)   
 [Configuring the Time Service: Max\[Pos\/Neg\]PhaseCorrection](http://blogs.msdn.com/b/w32time/archive/2008/02/28/configuring-the-time-service-max-pos-neg-phasecorrection.aspx)