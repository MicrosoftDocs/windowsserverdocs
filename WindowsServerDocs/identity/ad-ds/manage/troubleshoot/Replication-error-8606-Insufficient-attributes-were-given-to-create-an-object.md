---
ms.assetid: 9e7b0141-9b48-49a1-a9de-a3e8e90ce22b
title: Replication error 8606 Insufficient attributes were given to create an object
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Replication error 8606 Insufficient attributes were given to create an object

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This article covers symptoms, root causes, and how to resolve Active Directory replication error 8606: Insufficient attributes were given to create an object. </para>
    <list class="bullet">
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
      <listItem>
        <para>
          <link xlink:href="8d8439ba-9a88-48ed-80da-fae13fda82d6#BKMK_MoreInfo">More information</link>
        </para>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_Symptoms">
    <title>Symptoms</title>
    <content>
      <list class="ordered">
        <listItem>
          <para>The DCDIAG reports that the Active Directory Replications test failed with error 8606: "Insufficient attributes were given to create an object."</para>
          <code>Starting test: Replications
[Replications Check, &lt;Destination DC&gt;] A recent replication attempt failed:
From &lt;source DC&gt; to &lt;destination DC&gt;
Naming Context: &lt;directory partition DN path&gt;
<codeFeaturedElement>The replication generated an error (8606): 
Insufficient attributes were given to create an object. This object may not exist because it may have been deleted and already garbage collected</codeFeaturedElement>
The failure occurred at &lt;date&gt; &lt;time&gt;
The last success occurred at &lt;date&gt; &lt;time&gt;</code>
        </listItem>
        <listItem>
          <para>Incoming replication that is triggered by the <ui>Replicate now</ui> command in the Active Directory Sites and Services snap-in DSSITE.MSC is unsuccessful, and it generates the following error: "Insufficient attributes were given to create an object." And, right-clicking on a connection object from a source DC and then selecting <ui>Replicate now</ui> is unsuccessful, and it generates the following error: "Access is denied." The on-screen error message text reads as follows:</para>
          <para>Dialog title text:</para>
          <para>Replicate Now</para>
          <para>Dialog message text: </para>
          <para>The following error occurred during the attempt to synchronize naming context &lt;DNS name of directory partition&gt; from domain controller &lt;source DC&gt; 
to domain controller &lt;destination DC&gt;:</para>
          <para>
Insufficient attributes were given to create an object. This object may not exist because it may have been deleted and already garbage collected.</para>
          <para>This operation will not continue.</para>
        </listItem>
        <listItem>
          <para>REPADMIN commands that commonly cite the 8606 status include but are not limited to:</para>
          <list class="bullet">
            <listItem>
              <para>REPADMIN /ADD</para>
            </listItem>
            <listItem>
              <para>REPADMIN /REPLSUM</para>
            </listItem>
            <listItem>
              <para>REPADMIN /SHOWREPL</para>
            </listItem>
            <listItem>
              <para>REPADMIN /SYNCALL</para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>Event 1988 is logged shortly after one of the following events occurs:</para>
          <list class="ordered">
            <listItem>
              <para>The first Windows Server 2008 R2 domain controller in the forest is deployed.</para>
            </listItem>
            <listItem>
              <para>Any update to the partial attribute set is made.</para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>NTDS Replication Event 1988 may be logged in the Directory Service event log of domain controllers that are trying to inbound-replicate Active Directory:</para>
          <para>Event Type: Error</para>
          <para>Event Source: NTDS Replication</para>
          <para>Event Category: Replication</para>
          <para>Event ID: 1988</para>
          <para>User: NT AUTHORITYANONYMOUS LOGON</para>
          <para>Computer: &lt;name of DC that logged event, that is the "destination" DC in the replication attempt&gt;</para>
          <para>Description:</para>
          <para>The local domain controller has attempted to replicate the following object from the following source domain controller. This object is not present on the local domain controller because it may have been deleted and already garbage collected. </para>
          <para>
Source domain controller</para>
          <para>&lt;fully qualified GUIDED CNAME of source DC&gt;</para>
          <para>Object:</para>
          <para>&lt;DN path of live object on source DC&gt;</para>
          <para>Object GUID:</para>
          <para>&lt;object GUID of object on source DCs copy of Active Directory&gt;</para>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_Causes">
    <title>Causes</title>
    <content>
      <para>The 8606 error is logged when a source domain controller sends an update to an object (instead of an originating object create) that was already created, deleted, and reclaimed by garbage collection from the copy of Active Directory on a destination domain controller <placeholder>and</placeholder> the destination domain controller was configured to run in <externalLink><linkText>strict replication consistency</linkText><linkUri>http://technet.microsoft.com/library/cc816938(WS.10).aspx</linkUri></externalLink>. 
</para>
      <para>If the destination domain controller was configured to use loose replication consistency, the object would instead be "reanimated" on the copy of Active Directory on the destination domain controller. Specific variations that can cause the 8606 error are documented in the "More Information" section. However, the error is caused by one of the following:</para>
      <list class="bullet">
        <listItem>
          <para>A permanently lingering object whose removal will require administrative intervention.</para>
        </listItem>
        <listItem>
          <para>A transient lingering object that will correct itself when the source domain controller performs its next garbage-collection cleanup. The introduction of the first Windows Server 2008 R2 domain controller in an existing forest and updates to the partial attribute set are known causes of this condition.</para>
        </listItem>
        <listItem>
          <para>An object that was undeleted or restored at the cusp of tombstone lifetime expiration.</para>
        </listItem>
      </list>
      <para>
Remember the following when you troubleshoot 8606 errors: </para>
      <list class="bullet">
        <listItem>
          <para>Even though the 8606 error is logged on the destination domain controller, the problem object that is blocking replication resides on the source domain controller. Additionally, the source domain controller or a transitive replication partner of the source domain controller potentially <?Comment JTH: Ask Arren. 2012-02-22T15:14:00Z  Id='0?>did not inbound-replicate knowledge of a deleted tombstone life number of days in the past.<?CommentEnd Id='0'
    ?></para>
        </listItem>
        <listItem>
          <para>Lingering objects may exist under the following circumstances:</para>
          <list class="ordered">
            <listItem>
              <para>As "live" objects, as CNF or conflict-mangled objects "live" objects, or as CNF or conflict-mangled objects in the deleted objects container of the source domain controller.</para>
            </listItem>
            <listItem>
              <para>In any directory partition including application partitions <placeholder>except</placeholder> the schema partition. The schema partition does not support deletes.</para>
            </listItem>
            <listItem>
              <para>In any object class (users, computers, groups, and DNS records are most common). Lingering objects are most frequently found in read-only domain partitions on GCs and in writable domains and may also be found in the configuration partition.</para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>Remember to search for potentially lingering objects by object GUID vs. DN path so that objects can be found regardless of their host partition and parent container. Searching by objectguid will also locate objects that are in the deleted objects container without using the deleted objects LDAP control.</para>
        </listItem>
        <listItem>
          <para>The NTDS Replication 1988 event identifies only the current object on the source domain controller that is blocking incoming replication by a strict mode destination domain controller. Additional lingering object updates are likely in the replication queue "behind" the object that is referenced in the 1988 event.</para>
        </listItem>
        <listItem>
          <para>The presence of lingering objects on a source domain controller prevents or blocks strict mode destination domain controllers from inbound-replicating "good" changes that exist behind the lingering object in the replication queue.</para>
        </listItem>
        <listItem>
          <para>Because of the way that domain controllers individually delete objects from their deleted object containers (the garbage-collection daemon runs every 12 hours from the last time each domain controller last started), the objects that are causing 8606 errors on destination domain controllers <placeholder>could</placeholder> be subject to removal in the next garbage-collection cleanup execution. Lingering objects in this class are transient and should remove themselves in no more than 12 hours from problem start.</para>
        </listItem>
        <listItem>
          <para>The lingering object in question is likely one that was intentionally deleted by an administrator or application. Factor this into your resolution plan, and beware of reanimating objects, especially security principals that were intentionally deleted.</para>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_Resolution">
    <title>Resolution</title>
    <content>
      <list class="ordered">
        <listItem>
          <para>Identify the current value for the forest-wide <embeddedLabel>TombStoneLifeTime</embeddedLabel> attribute setting:</para>
          <code>c:&gt;repadmin /showattr . "CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=forest root domain,DC=TLD&gt; /atts:tombstonelifetime</code>
          <para>See the "Tombstone lifetime and replication of deletions" section in Knowledge Base article <externalLink><linkText>910205</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;910205</linkUri></externalLink>.</para>
        </listItem>
        <listItem>
          <para>For each destination domain controller that is logging the 8606 error, filter the Directory Service event log on NTDS Replication event 1988.</para>
        </listItem>
        <listItem>
          <para>Collect metadata for each <placeholder>unique</placeholder> object that is cited in the NTDS Replication event 1988.</para>
          <para>From each 1988 event that is logged on the destination domain controller that cites a new object, populate the following table:</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Object DN path</para>
                </TD>
                <TD>
                  <para>Object GUID</para>
                </TD>
                <TD>
                  <para>Source DC</para>
                </TD>
                <TD>
                  <para>Host partition</para>
                </TD>
                <TD>
                  <para>Live or deleted?</para>
                </TD>
                <TD>
                  <para>LastKnownParent</para>
                </TD>
                <TD>
                  <para>IsDeleted value</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para />
                </TD>
                <TD>
                  <para />
                </TD>
                <TD>
                  <para />
                </TD>
                <TD>
                  <para />
                </TD>
                <TD>
                  <para />
                </TD>
                <TD>
                  <para />
                </TD>
                <TD>
                  <para />
                </TD>
              </tr>
            </tbody>
          </table>
          <para>Columns 1 through 5 of this table can be populated by reading values directly from fields in the NTDS Replication 1988 events that are logged in the Directory Service event logs of the destination domain controllers that are logging either the 1988 event or the 8606 replication status. </para>
          <para>The date stamps for <embeddedLabel>LastKnownParent</embeddedLabel> and <embeddedLabel>IsDeleted</embeddedLabel> columns can be determined by running "repadmin /showobjmeta" and referencing the objectguid of the object that is cited in the NTDS replication 1988 event. To do this, use the following syntax: </para>
          <code>c:&gt;repadmin /showobjmeta &lt;fqdn of source DC from 1988 event&gt; "&lt;GUID=GUID of object cited in the 1988 event&gt;" </code>
          <para>The date stamp for <embeddedLabel>LastKnownParent</embeddedLabel> identifies the date on which the object was deleted. The date stamp for <embeddedLabel>IsDeleted</embeddedLabel> tells you when the object was last deleted or reanimated. The version number tells you whether the last modification deleted or reanimated the object. An <embeddedLabel>IsDeleted</embeddedLabel> value of 1 represents an initial delete. Odd-numbered values greater than 1 indicate a reanimation following at least one deletion. For example, an <embeddedLabel>IsDeleted</embeddedLabel> value of 2 represents an object that was deleted (version 1) and then later undeleted or reanimated (version 2). Later even-numbered values for <embeddedLabel>IsDeleted</embeddedLabel> represent later reanimations or undeletes of the object.</para>
        </listItem>
        <listItem>
          <para>Select the appropriate action based on the object metadata cited in the 1988 event.</para>
          <para>Error 8606 / NTDS Replication event 1988 event is most frequently caused by long-term replication failures that are preventing domain controllers from inbound-replicating knowledge of all originating deletes in the forest. This results in lingering objects on one or more source domain controllers. </para>
          <para>Review the metadata for object that is listed in the table that was created in the previous step.</para>
          <para>If the object in the 1988 event is either ((live on the source domain controller) but (deleted on the destination domain controller for longer than tombstone lifetime expiration)), see <link xlink:href="8d8439ba-9a88-48ed-80da-fae13fda82d6#BKMK_RemovingLingeringObjects">Removing lingering objects</link>and <?Comment JTH: Arren 2012-02-23T06:31:00Z  Id='1?>"."<?CommentEnd Id='1'
    ?> Objects in this condition must be manually removed by an administrator. </para>
          <para>Deleted objects may have been prematurely purged from the deleted objects container if system time jumped forward in time on the destination domain controller. Review the <link xlink:href="8d8439ba-9a88-48ed-80da-fae13fda82d6#BKMK_CheckForTimeJumps">Check for time jumps</link> section. </para>
          <para>If the object that is cited in the 1988 event exists in the deleted objects container of the source domain controller and its delete date is right at the cusp of tombstone lifetime expiration in such a way that the object was reclaimed by garbage collection by one or more destination domain controllers and <placeholder>will</placeholder> be reclaimed by garbage collection at the next garbage-collection interval on source domain controllers (that is, the lingering objects are <placeholder>transient</placeholder>), you have a choice. Either wait for the next garbage collection execution to delete the object, or manually trigger garbage collection on the source domain controller. See <link xlink:href="8d8439ba-9a88-48ed-80da-fae13fda82d6#BKMK_ManuallyStartGarbageCollection">Manually starting garbage collection</link>. The introduction of the first Windows Server 2008 R2 domain controller, or any change in the partial attribute set, can cause this condition. </para>
          <para>If repadmin /showobjmeta output for the object that is cited in the 1988 event has a <embeddedLabel>LastKnownParent</embeddedLabel> value of 1, this indicates that the object was deleted, <placeholder>and</placeholder> an <embeddedLabel>IsDeleted</embeddedLabel> value that of 2 or some other even-numbered value, <placeholder>and</placeholder> that date stamp for <embeddedLabel>IsDeleted</embeddedLabel> is at the cusp of the tombstone lifetime number of days different from the date stamp for <embeddedLabel>LastKnownParent</embeddedLabel>, then the object was deleted and then undeleted/auth-restored while it was still live on the source domain controller but already reclaimed by garbage collection by destination domain controllers logging error 8606/Event 1988. See <link xlink:href="8d8439ba-9a88-48ed-80da-fae13fda82d6#BKMK_ReanimationsOnCuspOfTSL">Reanimations at the cusp of TSL expiration</link>.</para>
        </listItem>
      </list>
    </content>
    <sections>
      <section address="BKMK_RemovingLingeringObjects">
        <title>Removing lingering objects</title>
        <content>
          <para>Two commands in REPADMIN.EXE can remove lingering objects from the following directory partitions:</para>
          <list class="bullet">
            <listItem>
              <para>REPADMIN /REMOVELINGERINGOBJECTS</para>
            </listItem>
            <listItem>
              <para>REPADMIN /REHOST</para>
            </listItem>
          </list>
          <para>REPADMIN /REMOVELINGERINGOBJCTS can be used to remove lingering objects from writable and read-only directory partitions on Windows Server 2003 source domain controllers. The syntax is as follows:</para>
          <code>c:&gt;repadmin /removelingeringobjects &lt;Dest_DSA_LIST&gt; &lt;Source DSA GUID&gt; &lt;NC&gt; [/ADVISORY_MODE]</code>
          <para>Where: </para>
          <para>&lt;Dest_DSA_LIST&gt; is the name of a domain controller that is running Windows Server 2003 or a later version and that contains lingering objects (such as the source domain controller that is cited in the NTDS Replication 1988 event). </para>
          <para>&lt;Source DSA GUID&gt; is the name of a domain controller that is running Windows Server 2003 or a later version and that hosts a writable copy of the directory partition that contains lingering objects to which the domain controller in &lt;Dest_DSA_LIST&gt; has network connectivity. </para>
          <para>&lt;NC&gt; is the DN path of the directory partition that is suspected of containing lingering objects, such as the partition that is specified in a 1988 event. </para>
          <para>REPADMIN /REHOST can be used to remove lingering-objects domain controllers that host a <placeholder>read-only</placeholder> copy of a domain directory partition from domain controllers that are running Windows 2000 SP4 or a later version. The syntax is as follows:</para>
          <code>c:&gt;repadmin /rehost DSA &lt;Naming Context&gt; &lt;Good Source DSA Address&gt;</code>
          <para>Where:</para>
          <para>DSA is the name of a domain controller that is running Windows 2000 SP4 or a later version and that hosts a read-only domain directory partition for a nonlocal domain. For example, a GC in root.contoso.com can rehost its read-only copy of child.contoso.com but cannot rehost root.contoso.com.</para>
          <para>&lt;Naming Context&gt; is the DN path of a read-only domain directory partition that is residing in a global catalog.</para>
          <para>&lt;Good Source DSA Address&gt; is the name of a domain controller that is running Windows 2000 SP4 or a later version and that hosts a writable copy of &lt;Naming Context&gt;. The domain controller must be network-available to the DSA computer.</para>
          <para>If the lingering object that is reported in the 1988 event is not removed by repadmin, evaluate whether the object on the source domain controller was created in USN gap, or whether the objects originating domain controller does not exist in the source domain controller's up-to dateness vector as documented in Microsoft Knowledge Base article <externalLink><linkText>948071</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;948071</linkUri></externalLink>. </para>
          <alert class="note">
            <para>Lingering objects can also be removed by using <externalLink><linkText>repldiag.exe</linkText><linkUri>http://activedirectoryutils.codeplex.com/releases/view/13664</linkUri></externalLink>. This tool automates the repadmin /removelingeringobjects process.</para>
          </alert>
        </content>
      </section>
      <section>
        <title>Monitoring Active Directory replication health daily</title>
        <content>
          <para>If error 8606 / Event 1988 was caused by the domain controller's failing to replicate Active Directory changes in the last tombstone lifetime number of days, make sure that Active Directory replication health is being monitored on a day-to-day basis going forward. Replication health may be monitored by using a dedicated monitoring application or by viewing the output from the one inexpensive but effective option to run "repadmin /showrepl * /csv" command in a spreadsheet application such as Microsoft Excel. (See "Method 2: Monitor replication by using a command-line" in Microsoft Knowledge Base article <externalLink><linkText>910205</linkText><linkUri>http://support.microsoft.com/kb/910205</linkUri></externalLink>).
</para>
          <para>
Domain controllers that have not inbound-replicated in 50 percent of tombstone lifetime number of days should be put in a watch list that receive priority admin attention to make replication operational. Domain controllers that cannot be made to successfully replicate should be force-demoted if they have not replicated within 90 percent of tombstone lifetime (TSL).
</para>
          <para>
Replication failures that appear on a destination domain controller may be caused by the destination domain controller, by the source domain controller, or by the underlying network and DNS infrastructure.</para>
        </content>
      </section>
      <section address="BKMK_CheckForTimeJumps">
        <title>Check for time jumps</title>
        <content>
          <para>To determine whether a time jump occurred, check date stamps in Event and diagnostic logs (Event Viewer, repadmin /showreps, netlogon logs, dcdiag reports) on destination domain controllers that are logging error 8606/NTDS Replication 1988 events for the following:</para>
          <list class="bullet">
            <listItem>
              <para>Date stamps that predate the release of an operating system (for example, date stamps from CY 2003 for an OS released in CY 2008)</para>
            </listItem>
            <listItem>
              <para>Date stamps that predate the installation of the operating system in your forest</para>
            </listItem>
            <listItem>
              <para>Date stamps in the future</para>
            </listItem>
            <listItem>
              <para>Having no events that are logged in a given date range</para>
            </listItem>
          </list>
          <para>Microsoft Support teams have seen system time on production domain controllers incorrectly jump hours, days, weeks, years, and even tens of years in the past and future. If system time was found to be inaccurate, you should correct it and then try to determine why time jumped and what can be done to prevent inaccurate time going forward vs. just correcting the bad time. Possible questions to ask include the following:</para>
          <list class="bullet">
            <listItem>
              <para>Was the forest root PDC configured by using an external time source?</para>
            </listItem>
            <listItem>
              <para>Are reference online time sources available on the network and resolvable in DNS?</para>
            </listItem>
            <listItem>
              <para>Was the Microsoft or third-party time service running and in an error-free state?</para>
            </listItem>
            <listItem>
              <para>Are domain controller role computers configured to use NT5DS hierarchy to source time?</para>
            </listItem>
            <listItem>
              <para>Was time rollback protection that is described in Microsoft Knowledge Base article <externalLink><linkText>884776</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;884776</linkUri></externalLink> in place?</para>
            </listItem>
            <listItem>
              <para>Do system clocks have good batteries and accurate time in the BIOS on domain controllers on virtual host computers?</para>
            </listItem>
            <listItem>
              <para>Are virtual host and guest computers configured to source time according to the hosting manufacturer's recommendations?</para>
            </listItem>
          </list>
          <para>Microsoft Knowledge Base article <externalLink><linkText>884776</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;884776</linkUri></externalLink> documents steps to help protect domain controllers from "listening" to invalid time samples. More information about MaxPosPhaseCorrection and MaxNegPhaseCorrection is available in the <externalLink><linkText>W32Time Blog</linkText><linkUri>http://blogs.msdn.com/b/w32time/</linkUri></externalLink> post <externalLink><linkText>Configuring the Time Service: Max[Pos/Neg]PhaseCorrection</linkText><linkUri>http://blogs.msdn.com/b/w32time/archive/2008/02/28/configuring-the-time-service-max-pos-neg-phasecorrection.aspx</linkUri></externalLink>. Microsoft Knowledge Base article <externalLink><linkText>961027</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;961027</linkUri></externalLink> describes some helpful precision updates when you are configuring time-based settings in policy.</para>
          <para>Check for lingering objects by using "repadmin /removelingeringobjects /advisorymode," and then remove them as required. 
</para>
          <para>
Relax "Allow replication with Divergent and corrupt partner" as required.</para>
        </content>
      </section>
      <section address="BKMK_ManuallyStartGarbageCollection">
        <title>Manually starting garbage collection</title>
        <content>
          <para>Several options exist to manually trigger garbage collection on a specific domain controller:</para>
          <para>Run "repadmin /setattr "" "" doGarbageCollection add 1"</para>
          <para>Run LDIFDE /s &lt;server&gt; /i /f dogarbage.ldif where dogarbage.ldif contains the text:</para>
          <code>dn:
changetype: modify
replace: DoGarbageCollection
dogarbagecollection: 1
- 
</code>
          <alert class="note">
            <para>The final "-" character is a <placeholder>required</placeholder> element of the .ldif file.</para>
          </alert>
        </content>
      </section>
      <section address="BKMK_ReanimationsOnCuspOfTSL">
        <title>Reanimations at the cusp of TSL expiration</title>
        <content>
          <para>For this condition to exist, repadmin /showobject "&lt;GUID=object guid for object in 1988 event&gt;" should report that the object is "not found" on the destination domain controller but is live on the source domain controller and is either a deleted or a nondeleted object.</para>
          <para>A review of key fields from repadmin /showobjmeta on the source domain controller should report that the following are true:</para>
          <list class="bullet">
            <listItem>
              <para>
                <embeddedLabel>LastKnownParent</embeddedLabel> has a value of 1, and its date stamp is at the cusp of TSL days in the past. Its date stamp indicates the delete date of the object.</para>
            </listItem>
            <listItem>
              <para>
                <embeddedLabel>IsDeleted</embeddedLabel> has a version number of 2 (or another even-numbered value), where version 1 defined the original deletion and version 2 is the restore/reanimation. The date stamp for "isDeleted=2" should be after the last change date for <embeddedLabel>LastKnownParent</embeddedLabel> by a number of days approximately equal to TSL. </para>
            </listItem>
          </list>
          <para>Evaluate whether the object in question should remain a live object or a deleted object. If <embeddedLabel>LastKnownParent</embeddedLabel> has a value of 1, something or someone deleted the object. If this was not an <placeholder>accidental</placeholder> deletion, chances are good that the object should be deleted from any source domain controllers that have a live copy of the object. 
</para>
          <para>
If the object should exist on all replicas, the options are as follows:</para>
          <list class="bullet">
            <listItem>
              <para>Enable loose replication on strict mode destination domain controllers that do not have the object.</para>
            </listItem>
            <listItem>
              <para>Force-demote the domain controllers that have already garbage collected the object.</para>
            </listItem>
            <listItem>
              <para> Delete the object and then re-create it. </para>
            </listItem>
          </list>
        </content>
      </section>
    </sections>
  </section>
  <section address="BKMK_MoreInfo">
    <title>More information</title>
    <content>
      <para>Causes of Lingering Objects</para>
    </content>
    <sections>
      <section>
        <title>Cause 1: The source domain controller sends updates to objects that have already been reclaimed by garbage collection on the destination domain controller because the source domain controller either was offline or has failed replication for TSL elapsed number of days.</title>
        <content>
          <para>The CONTOSO.COM domain contains two domain controllers in the same domain. Tombstone lifetime equals 60 days. Strict replication is enabled on both domain controllers. DC2 experiences a motherboard failure. Meanwhile, DC1 makes originating deletes for stale security groups daily over the next 90 days. After it is offline for 90 days, DC2 receives a replacement motherboard, powers up, and then originates an ACL change on all user accounts <placeholder>before</placeholder> it inbound-replicates knowledge of originating deletes from DC1. DC1 logs 8606 errors for updates security groups that are purged on DC1 for the first 30 days that DC2 was offline.</para>
        </content>
      </section>
      <section>
        <title>Cause 2: The Source DC sends updates to objects at the cusp of TSL expiration that have already been reclaimed by garbage collection by a strict mode destination DC.</title>
        <content>
          <para>The CONTOSO.COM domain contains two domain controllers in the same domain. Tombstone lifetime equals 60 days. Strict replication is enabled on both domain controllers. DC1 and DC2 replicate every 24 hours. DC1 originates deletes daily. DC1 is in-place upgraded to <token>nextref_server_includes>. This stamps new attributes on all objects in the configuration and writable domain partitions. This includes objects that are currently in the deleted objects container, some of which were deleted 60 days ago and are now at the cusp of tombstone expiration. DC2 reclaims some objects by garbage collection that were deleted TSL days ago before the replication schedule opens with DC2. Error 8606 is logged until DC1 reclaims the blocking objects by garbage collection.
</para>
          <para>
Any updates to the partial attribute set can cause temporary lingering objects that will clear themselves up after source domain controllers garbage-collect deleted objects at the cusp of TSL expiration (for example, the addition of the first <token>nextref_server_includes> domain controller to an existing forest).</para>
        </content>
      </section>
      <section>
        <title>Cause 3: A time jump on a destination domain controller prematurely speeds up the garbage collection of deleted objects on a destination domain controller.</title>
        <content>
          <para>The CONTOSO.COM domain contains two domain controllers in the same domain. Tombstone lifetime equals 60 days. Strict replication is enabled on both domain controllers. DC1 and DC2 replicate every 24 hours. DC1 originates deletes daily. The reference time source that is used by DC1 (but not DC2) rolls forward to calendar year 2039. This causes DC2 to also adopt a system time in calendar year 2039. This causes DC1 to prematurely delete objects that are deleted today from its deleted objects container. Meanwhile, DC2 originates changes to attributes on users, computers, and groups that are live on DC2 but deleted and now prematurely garbage collected on DC1. DC1 will log error 8606 when it next inbound-replicates changes for the premature deleted objects.</para>
        </content>
      </section>
      <section>
        <title>Cause 4: An object is reanimated at the cusp of TSL expiration</title>
        <content>
          <para>The CONTOSO.COM domain contains two domain controllers in the same domain. Tombstone lifetime equals 60 days. Strict replication is enabled on both domain controllers. DC1 and DC2 replicate every 24 hours. DC1 originates deletes daily. An OU that contains users, computers, and groups is accidentally deleted. A system state backup that is made at the cusp of TSL in the past is auth-restored on DC2. The backup contains objects that are live on DC2 but already deleted and reclaimed by garbage collection on DC1.</para>
        </content>
      </section>
      <section>
        <title>Cause 5: A USN bubble is triggered the logging of the 8606</title>
        <content>
          <para>Suppose you create an object in a USN bubble in such a way that it does not outbound-replicate because the destination domain controller "thinks" it has the object because of the bubble. Now, after the bubble closes, and after changes start to replicate again, a change is created for that object on the source domain controller and is displayed as a lingering object to the destination domain controller. The destination controller logs the 8606 event.</para>
        </content>
      </section>
      <section>
        <title>Requirements for end-to-end replicate knowledge of originating deletes</title>
        <content>
          <para>Active Directory domain controllers support multi-master replication where any domain controller (holding a writable partition) can originate a create, change, or delete of an object or attribute (value). Knowledge of object/attribute deletes are persisted by the originating domain controller and any domain controller that has incoming replicated knowledge of an originating delete for TSL number of days. (See Microsoft Knowledge Base articles <externalLink><linkText>216996</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;216993</linkUri></externalLink> and <externalLink><linkText>910205</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;910205</linkUri></externalLink>)
</para>
          <para>
Active Directory requires end-to-end replication from all partition holders to transitively replicate all originating deletes for all directory partitions to all partition holders. Failure to inbound-replicate a directory partition in a rolling TSL numbers of days results in lingering objects. A lingering object is an object that was intentionally deleted by at least one domain controller but that incorrectly exists on destination domain controllers that did not inbound-replicate the transient knowledge of all unique deletions.</para>
        </content>
      </section>
    </sections>
  </section>
  <relatedTopics>
    <externalLink>
      <linkText>Troubleshooting Active Directory operations that fail with error 8606: "Insufficient attributes were given to create an object"</linkText>
      <linkUri>http://support.microsoft.com/kb/2028495</linkUri>
    </externalLink>
  </relatedTopics>
</developerConceptualDocument>


