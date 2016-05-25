---
title: Replication error 8614 The Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: 0172a547-0a20-45b7-92c6-4167e477bb42
author: Femila
---
# Replication error 8614 The Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime
<?xml version="1.0" encoding="utf-8"?>
<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This article covers symptoms, root causes, and how to resolve Active Directory replication error 8614 The Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime. </para>
    <list class="ordered">
      <listItem>
        <para>
          <link xlink:href="0172a547-0a20-45b7-92c6-4167e477bb42#BKMK_Symptoms">Symptoms</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="0172a547-0a20-45b7-92c6-4167e477bb42#BKMK_Causes">Causes</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="0172a547-0a20-45b7-92c6-4167e477bb42#BKMK_Resolution">Resolution</link>
        </para>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_Symptoms">
    <title>Symptoms</title>
    <content>
      <list class="ordered">
        <listItem>
          <para>DCDIAG reports that Active Directory Replications test failed with error status code (8614): "Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime."</para>
          <code>Testing server: &lt;site name&gt;\&lt;destination dc name&gt;
            Starting test: Replications
               * Replications Check
               [Replications Check,&lt;destination DC name] A recent replication attempt failed:
                  From &lt;source DC&gt; to &lt;destination DC&gt;
                  Naming Context: &lt;directory partition DN path&gt;
                  The replication generated an error (8614):
                  Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime.
                  The failure occurred at &lt;date&gt; &lt;time&gt;.
                  The last success occurred at &lt;date&gt; &lt;time&gt;.
                  3 failures have occurred since the last success.</code>
        </listItem>
        <listItem>
          <para>REPADMIN.EXE reports that the last replication attempt failed with status 8614.</para>
          <para>REPADMIN commands that commonly cite the 8614 status include but are not limited to:</para>
          <list class="bullet">
            <listItem>
              <para>REPADMIN /REPLSUM</para>
            </listItem>
            <listItem>
              <para>REPADMIN /SHOWREPL</para>
            </listItem>
            <listItem>
              <para>REPADMIN /SHOWREPS</para>
            </listItem>
            <listItem>
              <para>REPADMIN /SYNCALL</para>
            </listItem>
          </list>
          <para>Sample output from "REPADMIN /SHOWREPS" depicting inbound replication from CONTOSO-DC2 to CONTOSO-DC1 failing with the "replication access was denied" error is shown below:</para>
          <code>Default-First-Site-Name\CONTOSO-DC1
DSA Options: IS_GC 
Site Options: (none)
DSA object GUID: b6dc8589-7e00-4a5d-b688-045aef63ec01
DSA invocationID: b6dc8589-7e00-4a5d-b688-045aef63ec01
==== INBOUND NEIGHBORS ======================================
      DC=contoso,DC=com
        Default-First-Site-Name\CONTOSO-DC2 via RPC
          DSA object GUID: 74fbe06c-932c-46b5-831b-af9e31f496b2
                    Last attempt @ &lt;date&gt; &lt;time&gt; failed, result 8614(0x21a6):
                       The Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime.
          &lt;#&gt; consecutive failure(s).
          Last success @ &lt;date&gt; &lt;time&gt;.
</code>
        </listItem>
        <listItem>
          <para>NTDS KCC, NTDS General, or Microsoft-Windows-ActiveDirectory_DomainService events with the 5 status are logged in the Directory Service event log.</para>
          <para>Active Directory events that commonly cite the 8524 status include but are not limited to the following:</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Event source</para>
                </TD>
                <TD>
                  <para>ID</para>
                </TD>
                <TD>
                  <para>Event string</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>NTDS KCC</para>
                </TD>
                <TD>
                  <para>1925</para>
                </TD>
                <TD>
                  <para>The attempt to establish a replication link for the following writable directory partition failed.</para>
                </TD>
              </tr>
            </tbody>
          </table>
        </listItem>
        <listItem>
          <para>NTDS Replication Event 2042 may be logged in the Directory Service event log:</para>
          <para>Event Type: Error</para>
          <para>Event Source: NTDS Replication</para>
          <para>Event Category: Replication</para>
          <para>Event ID: 2042</para>
          <para>User: NT AUTHORITY\ANONYMOUS LOGON</para>
          <para>Computer: &lt;name of DC that logged event&gt;</para>
          <para>Description:</para>
          <para>It has been too long since this machine last replicated with the named source 
machine. The time between replications with this source has exceeded the tombstone 
lifetime. Replication has been stopped with this source.</para>
          <para>The reason that replication is not allowed to continue is that the two machine's 
views of deleted objects may now be different. The source machine may still have 
copies of objects that have been deleted (and garbage collected) on this machine. 
If they were allowed to replicate, the source machine might return objects which 
have already been deleted.</para>
          <para>Time of last successful replication: YYYY-MM-DD HH:MM:SS</para>
          <para>Invocation ID of source: &lt;32 character GUID for source DC&gt;</para>
          <para>Name of source: &lt;fully qualified cname record of source DC&gt;</para>
          <para>Tombstone lifetime (days): &lt;current TSL value. Default = 60 or 180 days&gt;</para>
          <para>The replication operation has failed.</para>
          <para>User Action:</para>
          <para>Determine which of the two machines was disconnected from the forest and is now out 
of date. You have three options:</para>
          <list class="ordered">
            <listItem>
              <para>Demote or reinstall the machine(s) that were disconnected.</para>
            </listItem>
            <listItem>
              <para>Use the "repadmin /removelingeringobjects" tool to remove inconsistent deleted 
objects and then resume replication.</para>
            </listItem>
            <listItem>
              <para>Resume replication. Inconsistent deleted objects may be introduced. You can 
continue replication by using the following registry key. Once the systems 
replicate once, it is recommended that you remove the key to reinstate the 
protection.</para>
            </listItem>
          </list>
</listItem>
        <listItem>
          <para>The replicate now command in Active Directory Sites and Services returns the message "Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime."</para>
          <para>Right-clicking on the connection object from a source DC and choosing "replicate now" in Active Directory Sites and Services (DSSITE.MSC) is unsuccessful, and you receive the message "Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime."</para>
          <para>The on-screen error message text and screen shot are as follows:</para>
          <code>Dialog title text: Replicate Now
Dialog message text: The following error occurred during the attempt to synchronize naming context &lt;%directory partition name%&gt; from Domain Controller &lt;Source DC&gt; to Domain Controller &lt;Destination DC&gt;:
The Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime.

The operation will not continue</code>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_Causes">
    <title>Causes</title>
    <content>
      <para>Active Directory domain controllers support multi-master replication where any domain controller that is holding a writable partition can originate a create, modify, or delete of an object or attribute (value). Knowledge of object / attribute deletes persists for tombstone lifetime number of days. (See Microsoft Knowledge Base articles <externalLink><linkText>216996</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;216993</linkUri></externalLink> and <externalLink><linkText>910205</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;910205</linkUri></externalLink>.)
</para>
      <para>
Active Directory requires end-to-end replication from all partition holders to transitively replicate all originating deletes for all directory partitions to all partition holders. Failure to inbound-replicate a directory partition in a rolling TSL number of days results in lingering objects. (A lingering object is an object that has been intentionally deleted by at least one DC but that incorrectly exists on destination DCs that failed to inbound-replicate the transient knowledge of all unique deletions.) </para>
      <para>

Error 8614 is an example of logic added in domain controllers that are running Windows Server 2003 or a later version to quarantine the spread of lingering objects and to identify long-term replication failures that cause inconsistent directory partitions. </para>
      <para>Root causes for error 8614 and for NTDS Replication Event 2042 include the following: </para>
      <list class="ordered">
        <listItem>
          <para>The destination DC that is logging the 8614 error failed to inbound-replicate a directory partition from one or more source DCs for tombstone lifetime number of days.</para>
        </listItem>
        <listItem>
          <para>System time on the destination DC moved, or "jumped," tombstone lifetime one or more number of days in the future since the last successful replication. This gives the <placeholder>appearance</placeholder> to the replication engine that the destination DC failed to inbound-replicate a directory partition for tombstone lifetime elapsed number of days.</para>
          <para>Time jumps can occur when a destination DC successfully inbound-replicates, adopts "bad" system time TSL or more number of days in the future, and then tries to inbound-replicate from a source that was last replicated from TSL or more number of days in the past.</para>
          <para>OR</para>
          <para>Time jumps from current time to a date/time tombstone lifetime or more days in the past, successfully inbound-replicates, and then tries to inbound-replicate after it adopts time TSL or more number of days in the future.</para>
        </listItem>
      </list>
      <para>Basically, the cause and resolution steps for replication error status 8614 apply equally to the cause and to the resolution of NTDS replication event 2042.</para>
    </content>
  </section>
  <section address="BKMK_Resolution">
    <title>Resolution</title>
    <content>
      <alert class="note">
        <para>There are two action plans to recover Active Directory domain controllers that are logging error status 8614 or NTDS Replication event 2042. You can either force-demote the domain controller <placeholder>or</placeholder> use the action plan below that says, "Check for required fixes, look for time jumps, check for lingering objects and remove them if present, remove any replication quarantines, resolve replication failures, then put the DC back into service." Force-demoting such DCs may be "easier" and faster but can also result in the loss of originating updates (that is, "data loss") on the domain controller that is being force-demoted. Active Directory recovers gracefully from this condition by following the steps below. Select the best solution for your scenario, but do not assume that a force demotion is the only workable solution, especially where that replication failure is easy to resolve or is external to Active Directory.</para>
      </alert>
      <list class="ordered">
        <listItem>
          <para>Check for nondefault values of tombstone lifetime.</para>
          <para>By default, tombstone lifetime uses either 60 or 180 days, depending on the version of Windows that is deployed in your forest. Microsoft Support regularly sees DCs that have failed inbound replication for those periods of time. It is also possible that the tombstone lifetime has been configured to a very short period such as 2 days. If this is the case, DCs that did not inbound-replicate for, say, 5 days will fail the "all DCs must replicate with a rolling TSL number of days" test.</para>
          <para>Use repadmin /showattr to see whether a nondefault value for the <embeddedLabel>TombstoneLifetime</embeddedLabel> attribute has been configured.</para>
          <para>repadmin /showattr . "CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=&lt;forest root domain&gt;,DC=&lt;top level domain&gt;"</para>
          <para>If the attribute is not present in the showattr output, an internal default value is being used.</para>
        </listItem>
        <listItem>
          <para>Check for DCs that failed inbound replication for TSL number of days.</para>
          <para>Run "repadmin /showrepl * /csv" parsed by using Microsoft Office Excel as specified in <externalLink><linkText>Verify successful replication to a domain controller</linkText><linkUri>http://technet.microsoft.com/library/cc794749(WS.10).aspx</linkUri></externalLink>. Sort the replsum output in Excel on the last replication success column from least current to the most current date and time order.</para>
        </listItem>
        <listItem>
          <para>Check for Windows Server 2003 domain controllers without services packs.</para>
          <para>If the 8614 error occurred on a Windows Server 2003 domain controller without service packs, install the latest Windows Server 2003 service pack.</para>
        </listItem>
        <listItem>
          <para>Check for time jumps.</para>
          <para>To determine whether a time jump occurred, check event and diagnostic logs (repadmin /showreps, dcdiag logs) on destination DCs that are logging 8614 errors for the following:</para>
          <list class="bullet">
            <listItem>
              <para>Date stamps that predate the release of an operating system (date stamps from 2003 for an OS released in 2008).</para>
            </listItem>
            <listItem>
              <para>Date stamps that predate the installation of the operating system in your forest.</para>
            </listItem>
            <listItem>
              <para>Date stamps in the future.</para>
            </listItem>
            <listItem>
              <para>No events being logged in a given date range.</para>
            </listItem>
          </list>
          <para>Microsoft Support teams have seen system time on production domain controllers incorrectly jump hours, days, weeks, years, and even tens of years in the past and future.</para>
          <para>If system time was found to be inaccurate, you should correct it and then try to determine why time jumped and what can be done to prevent inaccurate time going forward vs. just correcting the bad time. Possible areas to investigate include the following:</para>
          <list class="bullet">
            <listItem>
              <para>Was the forest root PDC configured by using an external time source?</para>
            </listItem>
            <listItem>
              <para>Are reference time sources online, available on the network, and resolvable in DNS?</para>
            </listItem>
            <listItem>
              <para>Was the Microsoft or third-party time service running and in an error-free state?</para>
            </listItem>
            <listItem>
              <para>Are DC-role computers configured to use NT5DS hierarchy to source time?</para>
            </listItem>
            <listItem>
              <para>Was the time rollback protection that is described in Microsoft Knowledge Base article <externalLink><linkText>884776</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;884776</linkUri></externalLink> in place?</para>
            </listItem>
            <listItem>
              <para>Do system clocks have good batteries and accurate time in the BIOS?</para>
            </listItem>
            <listItem>
              <para>Are virtual host and guest computers configured to source time according to the hosting manufacturers recommendations?</para>
            </listItem>
          </list>
          <para>Microsoft Knowledge Base article <externalLink><linkText>884776</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;884776</linkUri></externalLink> documents steps to help protect domain controllers from "listening" to invalid time samples. More information on MaxPosPhaseCorrection and MaxNegPhaseCorrection is available in the <externalLink><linkText>W32Time Blog</linkText><linkUri>http://blogs.msdn.com/b/w32time/</linkUri></externalLink> post <externalLink><linkText>Configuring the Time Service: Max[Pos/Neg]PhaseCorrection</linkText><linkUri>http://blogs.msdn.com/b/w32time/archive/2008/02/28/configuring-the-time-service-max-pos-neg-phasecorrection.aspx</linkUri></externalLink>. Microsoft Knowledge Base article <externalLink><linkText>961027</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;961027</linkUri></externalLink> describes some helpful precision updates when you configure time-based settings in policy.</para>
</listItem>
        <listItem>
          <para>Check for and remove lingering objects if they are present.</para>
          <para>The point of the 8614 error replication quarantine is to check for lingering objects and remove them, if present, in each locally held partition <placeholder>before</placeholder> setting "Allow Replication with divergent and corrupt partner" = 1 in the registry of the destination DC, even if you think that all destination DCs in the forest are running in strict replication consistency.</para>
          <para>The removal of lingering objects is beyond the scope of this article. More information can be found in the following sources:</para>
          <list class="bullet">
            <listItem>
              <para>Microsoft Knowledge Base article <externalLink><linkText>910205</linkText><linkUri>http://support.microsoft.com/kb/910205</linkUri></externalLink>: Information about lingering objects in a Windows Server Active Directory forest</para>
            </listItem>
            <listItem>
              <para>Technet: <externalLink><linkText>Event ID 1388 or 1988: A lingering object is detected</linkText><linkUri>http://technet.microsoft.com/library/cc780362(WS.10).aspx</linkUri></externalLink></para>
            </listItem>
            <listItem>
              <para>Microsoft Knowledge Base article <externalLink><linkText>870695</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;870695</linkUri></externalLink>: Outdated Active Directory objects generate event ID 1988 in Windows Server 2003</para>
            </listItem>
          </list>
          <para>Repadmin syntax is shown here:</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <tbody>
              <tr>
                <TD>
                  <para>Syntax</para>
                </TD>
                <TD>
                  <para>c:\&gt;repadmin /removelingeringobjects &lt;Dest_DSA_LIST&gt; &lt;Source DSA GUID&gt; &lt;NC&gt; [/advisory_mode]</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Online help (Windows Server 2008 and later) </para>
                </TD>
                <TD>
                  <para>c:\&gt;repadmin /help:removelingeringobject</para>
                </TD>
              </tr>
            </tbody>
          </table>
</listItem>
        <listItem>
          <para>Evaluate setting strict replication on destination DCs.</para>
          <para>Strict mode replication prevents lingering objects from being reanimated on destination DCs that have used garbage collection to create, delete, and reclaim intentionally deleted objects.</para>
          <para>The registry key for strict replication is the following:</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <tbody>
              <tr>
                <TD>
                  <para>Path</para>
                </TD>
                <TD>
                  <para>hklm\system\ccs\services\ntds\parameters</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Setting</para>
                </TD>
                <TD>
                  <para>Strict Replication Consistency </para>
                  <para>(not case sensitive)</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Type</para>
                </TD>
                <TD>
                  <para>reg_dword</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Value</para>
                </TD>
                <TD>
                  <para>0 | 1</para>
                </TD>
              </tr>
            </tbody>
          </table>
          <para>Repadmin syntax for enabling and disabling strict replication on a single or multiple DCs is as follows:</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <tbody>
              <tr>
                <TD>
                  <para>Syntax</para>
                </TD>
                <TD>
                  <para>Repadmin /regkey &lt;DSA_LIST&gt; &lt;{+|-}key&gt; [value [/reg_sz]]</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Online help (Windows Server 2008 and later)</para>
                </TD>
                <TD>
                  <para>Repadmin /help:regkey</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Enable on a single DC</para>
                </TD>
                <TD>
                  <para>repadmin /regkey &lt;fully qualified computer name&gt; +strict</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Enable on all DCs in forest</para>
                </TD>
                <TD>
                  <para>repadmin /regkey * +strict</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Enable on all GCs in forest</para>
                </TD>
                <TD>
                  <para>repadmin /regkey gc: +strict</para>
                </TD>
              </tr>
            </tbody>
          </table>
        </listItem>
        <listItem>
          <para>Set "Allow replication with divergent and corrupt partner = 1" on the 8614 DC.</para>
          <para>After any lingering objects are removed, disable the time-based replication quarantine:</para>
          <para>Registry method</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <tbody>
              <tr>
                <TD>
                  <para>Path</para>
                </TD>
                <TD>
                  <para>hklm\system\ccs\services\ntds\parameters</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Setting</para>
                </TD>
                <TD>
                  <para>Allow replication with divergent and corrupt partner</para>
                  <para>(not case sensitive)</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Type</para>
                </TD>
                <TD>
                  <para>reg_dword</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Value</para>
                </TD>
                <TD>
                  <para>0=disallow, 1=allow</para>
                </TD>
              </tr>
            </tbody>
          </table>
          <para>Repadmin method</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <tbody>
              <tr>
                <TD>
                  <para>Syntax</para>
                </TD>
                <TD>
                  <para>repadmin /regkey &lt;DSA_LIST&gt; &lt;{+|-}key&gt; [value [/reg_sz]] </para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Online help (Windows Server 2008 and later)</para>
                </TD>
                <TD>
                  <para>Repadmin /help:regkey</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Enable on a single DC</para>
                </TD>
                <TD>
                  <para>repadmin /regkey dc01.contoso.com +allowDivergent</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Enable on all DCs in forest</para>
                </TD>
                <TD>
                  <para>repadmin /regkey * +allowDivergent </para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Enable on all GCs in forest</para>
                </TD>
                <TD>
                  <para>repadmin /regkey GC: +allowDivergent </para>
                </TD>
              </tr>
            </tbody>
          </table>
        </listItem>
        <listItem>
          <para>Resolve AD replication failures if they are present.</para>
          <para>When the 8614 error status is logged on a destination DC, prior replication errors that were logged in the previous TSL number of days are masked.</para>
          <para>The fact that the 8614 error was reported by the destination DC does not mean that the replication fault resides on the destination DC. Instead, the source of the replication failure could lie with the network or DNS name resolution, or there could be a problem with authentication, with jet database, with topology, or with the replication engine on either the source DC or the destination DC.</para>
          <para>Review past Directory Service events and diagnostic output (dcdiag, repadmin logs) that was generated by the source DC, by the destination DC, and by alternative replication partners in the past to identify the scope and failure status that is preventing replication between the destination DC and the source DC.</para>
        </listItem>
        <listItem>
          <para>Delete "Allow replication with divergent and corrupt partner" or set "Allow replication with divergent and corrupt partner = 0" in the registry.</para>
        </listItem>
        <listItem>
          <para>Monitor Active Directory replication daily going forward.</para>
          <para>Monitor end-to-end replication in your Active Directory forest daily by using an Active Directory monitoring application. One inexpensive but effective option is to run "repadmin /showrepl * /csv" and then parse the results in Excel. (See "Method 2: Monitor replication by using a command line" in Microsoft Knowledge Base article <externalLink><linkText>910205</linkText><linkUri>http://support.microsoft.com/kb/910205</linkUri></externalLink>.)</para>
          <para>Identify DCs that are approaching replication failures for 50 percent and for 90 percent of tombstone lifetime, and put them on a watch list. At 50 percent of TSL, make a strong push to resolve replication errors. At 90 percent, consider demoting (forcibly, if it is necessary, by using the <embeddedLabel>dcpromo /forceremoval</embeddedLabel> command) DCs that are causing replication errors.</para>
          <para>Again, replication errors that are logged on a destination DC may be caused by a problem on the source DC, on the destination DC, or on the underlying network. Therefore, make an effort to determine the cause and where the fault is before you take preventive action.</para>
        </listItem>
      </list>
    </content>
  </section>
  <relatedTopics>
    <externalLink>
      <linkText>Troubleshooting Active Directory operations that fail with error 8614: "The Active Directory cannot replicate with this server because the time since the last replication with this server has exceeded the tombstone lifetime"</linkText>
      <linkUri>http://support.microsoft.com/kb/2020053</linkUri>
    </externalLink>
    <externalLink>
      <linkText>Fixing Replication Lingering Object Problems (Event IDs 1388, 1988, 2042)</linkText>
      <linkUri>http://technet.microsoft.com/library/cc738018(WS.10).aspx</linkUri>
    </externalLink>
    <externalLink>
      <linkText>317097: Lingering objects prevent Active Directory replication from occurring</linkText>
      <linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;317097</linkUri>
    </externalLink>
    <externalLink>
      <linkText>Configuring the Time Service: Max[Pos/Neg]PhaseCorrection</linkText>
      <linkUri>http://blogs.msdn.com/b/w32time/archive/2008/02/28/configuring-the-time-service-max-pos-neg-phasecorrection.aspx</linkUri>
    </externalLink>
  </relatedTopics>
</developerConceptualDocument>

