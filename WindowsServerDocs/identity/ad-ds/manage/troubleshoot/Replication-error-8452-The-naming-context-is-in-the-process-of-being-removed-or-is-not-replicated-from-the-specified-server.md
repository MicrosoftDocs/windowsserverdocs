---
ms.assetid: 92a9eeb6-2ed8-424e-9e81-2c00cf300ded
title: Replication error 8452 The naming context is in the process of being removed or is not replicated from the specified server
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Replication error 8452 The naming context is in the process of being removed or is not replicated from the specified server

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This topic explains symptoms, causes and how to resolve Active Directory replication error 8452: The naming context is in the process of being removed or is not replicated from the specified server.</para>
    <list class="bullet">
      <listItem>
        <para>
          <link xlink:href="0b8174c6-62bd-47ba-ac46-01f8cf3c5e8c#BKMK_Symptoms">Symptoms</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="0b8174c6-62bd-47ba-ac46-01f8cf3c5e8c#BKMK_Causes">Causes</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="0b8174c6-62bd-47ba-ac46-01f8cf3c5e8c#BKMK_Resolutions">Resolutions</link>
        </para>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_Symptoms">
    <title>Symptoms</title>
    <content>
      <list class="ordered">
        <listItem>
          <para>DCDIAG reports that Active Directory Replications test has failed with error status code (8452): "The naming context is in the process of being removed or is not replicated from the specified server."</para>
          <code>Testing server: &lt;site name&gt;&lt;destination dc name&gt;
Starting test: Replications
* Replications Check
[Replications Check,&lt;destination DC name] A recent replication attempt failed:
From &lt;source DC&gt; to &lt;destination DC&gt;
Naming Context: &lt;directory partition DN path&gt;
<codeFeaturedElement>The replication generated an error (8452):
The naming context is in the process of being removed or is not replicated from the specified
server.</codeFeaturedElement> The failure occurred at &lt;date&gt; &lt;time&gt;.
The last success occurred at &lt;date&gt; &lt;time&gt;.
3 failures have occurred since the last success.</code>
        </listItem>
<listItem><para>REPADMIN.EXE reports that the last replication attempt has failed with status 8452.</para><para>REPADMIN commands that commonly cite the 8452 status include but are not limited to:</para><table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11"><tbody><tr><TD><list class="bullet"><listItem><para>REPADMIN /SHOWREPS</para></listItem><listItem><para>REPADMIN /REPLSUM</para></listItem></list></TD><TD><list class="bullet"><listItem><para>REPADMIN /SYNCALL</para></listItem></list></TD></tr></tbody></table><para>The following sample output from "REPADMIN /SHOWREPS" shows inbound replication from CONTOSO-DC2 to CONTOSO-DC1 failing with the "The naming context is in the process of being removed or is not replicated from the specified server" error:</para><code>Default-First-Site-NameCONTOSO-DC1
DSA Options: IS_GC 
Site Options: (none)
DSA object GUID: b6dc8589-7e00-4a5d-b688-045aef63ec01
DSA invocationID: b6dc8589-7e00-4a5d-b688-045aef63ec01
==== INBOUND NEIGHBORS ======================================
DC=contoso,DC=com
Default-First-Site-NameCONTOSO-DC2 via RPC
DSA object GUID: 74fbe06c-932c-46b5-831b-af9e31f496b2
Last attempt @ &lt;date&gt; &lt;time&gt; failed, <codeFeaturedElement>result 8452 (0x2104):
The naming context is in the process of being removed or is not replicated from the specified server.</codeFeaturedElement>
&lt;#&gt; consecutive failure(s).
Last success @ &lt;date&gt; &lt;time&gt;.
</code>

</listItem><listItem><para>In Active Directory Sites and Services, if you right-click the connection object and click <ui>Replicate now</ui>, the error "The naming context is in the process of being removed or is not replicated from the specified server." </para><para>Right-clicking on the connection object from a source DC and choosing "replicate now" fails with "The naming context is in the process of being removed or is not replicated from the specified server.". The on-screen error message text and screenshot is shown below:</para><para>Dialog title text: Replicate Now</para><para>Dialog message text: </para><para>The following error occurred during the attempt to synchronize naming context &lt;%directory partition name%&gt; from Domain Controller &lt;Source DC&gt; to Domain Controller &lt;Destination DC&gt;: </para><para>The naming context is in the process of being removed or is not replicated from the specified server.</para><para>The operation will not continue.</para></listItem><listItem><para>NTDS KCC, NTDS General or Microsoft-Windows-ActiveDirectory_DomainService events with the 8452 status are logged in the directory service event log.</para><para>Active Directory events that commonly cite the 8452 status include but are not limited to:</para><table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11"><thead><tr><TD><para>Event ID</para></TD><TD><para>Event Source</para></TD><TD><para>Event String</para></TD></tr></thead><tbody><tr><TD><para>1586</para></TD><TD><para>NTDS General</para></TD><TD><para>The checkpoint with the PDC was unsuccessful. The checkpointing process will be retried again in four hours. A full synchronization of the security database to downlevel domain controllers may take place if this machine is promoted to be the PDC before the next successful checkpoint. The error returned was: The naming context is in the process of being removed or is not replicated from the specified server.</para></TD></tr></tbody></table></listItem>
</list>
    </content>
  </section>
  <section address="BKMK_Causes">
    <title>Causes</title>
    <content>
      <para>This error most commonly occurs when replication topology on a domain controller that initiates replication differs from the replication topology defined on the copy of Active Directory on the destination domain controller.</para>
      <para>The error naturally occurs when the replication topology in an Active Directory forest is modified by:</para>
      <list class="bullet">
        <listItem>
          <para>Adding or removing partitions to or from the forest (that is, the promotion or demotion of the first or last domain controller in a domain, or the addition or removal of an application partition, including default DNS application partitions).</para>
        </listItem>
        <listItem>
          <para>The addition or removal of directory partitions on existing domain controllers (that is, the promotion or demotion of a global catalog server or addition or removal of an application partition).</para>
        </listItem>
        <listItem>
          <para>Changes in replication topology or settings (that is, the promotion of new DCs, the demotion of existing DCs , changes to preferred or nominated bridgeheads, the building of alternate replication paths in response to replication failures or offline DCs, as well as site and site link changes).</para>
        </listItem>
      </list>
      <para>The error can be transient in a forest undergoing the changes above until the set of source DCs and partitions that each destination DC replicates from has inbound replicated by triggering replication operations.</para>
      <para>The error can be persistent when replication failures prevent the end-to-end replication of topology changes in the forest. </para>
      <para>The error is most commonly seen in replication scenarios triggered by REPADMIN.EXE remotely (especially /SYNCALL) or the "replicate now command" in DSSITE.MSC where the copy of Active Directory on the DC triggering replication has a different list of source DCs that a destination DC replicates partitions from than what the destination DC has defined in its copy of Active Directory. </para>
      <para>Windows 2000 domain controllers are particularly prone to this error during demotion of global catalog servers as they are slow to remove objects from read-only partitions. Object removal during GC demotion improved dramatically on Windows Server 2003 and later. </para>
      <para>The NTDS Replication event 1586 is caused when the PDC FSMO role for the domain has been seized or transferred to a domain controller that was not a direct replication partner of the previous role holder.</para>
      <para>In rare conditions, the error can be caused by corruption in attributes like <embeddedLabel>hasMasterNCs</embeddedLabel> or <embeddedLabel>msds-hasMasterNCs</embeddedLabel>.</para>
      <para>The "More Information" section of this article contains explanations as to why the diagnostic and administrative tools listed in the Symptoms section of this article generate the 8452 error.</para>
      <para>In summary, Error 8452 happens if anyone of the following is true:</para>
      <list class="ordered">
        <listItem>
          <para>When DC1 &lt;- DC2 replication is initiated for a NC, on DC1 there is no replica link for the NC from DC2.</para>
        </listItem>
        <listItem>
          <para>When DC1 &lt;- DC2 replication in initiated for a NC, the NC is in the process of being removed on DC2.</para>
        </listItem>
        <listItem>
          <para>In mixed domain environment, PDC FSMO role is transferred from DC2 to DC1, but on DC1 there is no replica link from DC2.</para>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_Resolutions">
    <title>Resolutions</title>
    <content>
      <list class="ordered">
        <listItem>
          <para>Wait. As mentioned, this condition is usually transient and does not normally warrant troubleshooting.</para>
          <para>If replication topology changes of the type listed in the Cause section of this article are taking place in your Active Directory forest, wait for the error condition to correct itself with time.</para>
        </listItem>
        <listItem>
          <para>Avoid the use of the "repadmin /syncall" command and equivalents until domain controllers initiating replication and the destination DCs being replicated to agree about the source DCs and directory partitions being replicated.</para>
        </listItem>
        <listItem>
          <para>Make originating changes in the right places.</para>
        </listItem>
        <listItem>
          <para>Push and Pull changes to connection objects and partition changes around as required</para>
        </listItem>
        <listItem>
          <para>Go Direct</para>
          <para>If you want to run the <ui>Replicate now</ui> command from DC3 to DC2 from Active Directory Sites and Services on DC1, focus the operation on DC3 to DC2.</para>
          <para>If the error is caused by root cause #3, then after the user gives the correct input, the error will not happen. For example, in case #1 of scenario #3, if the user input a correct &lt;src DC&gt; such that on &lt;dest DC&gt; there is a replica link from &lt;src DC&gt; for &lt;the NC&gt;, the repadmin /replicate command will be executed successfully.</para>
        </listItem>
        <listItem>
          <para>Resolve replication failures that block end-to-end replication.</para>
        </listItem>
        <listItem>
          <para>REPADMIN /REPLICATE</para>
        </listItem>
        <listItem>
          <para>NTDS Replication event 1586</para>
          <para>For NTDS Replication event 1586, transfer the PDC emulator role to an Active Directory domain controller that is <placeholder>currently</placeholder> a direct replication partner of the previous PDC emulator.</para>
        </listItem>
        <listItem>
          <para>If the error is caused by the demotion of a Windows 2000 global catalog server, execute the batch file in the "Directory Service is too busy to complete the operation" section of <externalLink><linkText>KB 249256</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;249256</linkUri></externalLink> (http://support.microsoft.com/default.aspx?scid=kb;EN-US;249256).</para>
        </listItem>
      </list>
    </content>
  </section>
  <section>
    <title>More Information</title>
    <content />
    <sections>
      <section>
        <title>REPADMIN /SYNCALL </title>
        <content>
          <para>The REPADMIN /syncall operation will cause a DC to initiate replication from all of its source replication partners and make the source replication partners initiate replication from all of their source replication partners, and so on. </para>
          <para>For example, suppose we have a replication topology DC1 &lt;- DC2 &lt;- DC3. If you run "repadmin /syncall" on DC1, it will initiate the following replication: DC2 &lt;- DC3, and DC1 &lt;- DC2.</para>
          <para>There are two cases where error 8452 might be observed in this scenario:</para>
          <list class="bullet">
            <listItem>
              <para>Case 1: Change the replication topology to make DC2 inbound replicate from DC4 so that the current topology becomes DC1 &lt;- DC2 &lt;- DC4.</para>
              <para>If you run "repadmin /syncall" on DC1 before knowledge of the DC2 &lt;- DC4 topology change inbound replicates to DC1, the syncall operation will initiate DC2 &lt;- DC3 replications because DC1 still has the old replication topology stored locally. Because on DC2 at this moment KCC has created a replica link from DC4 and has deleted the replica link from DC3, the replication from DC2 &lt;- DC3 cannot be executed and the operation logs error 8452.</para>
            </listItem>
            <listItem>
              <para>Case 2: Suppose a NC on DC3 is being removing when you run "repadmin /syncall &lt;the NC&gt;" on DC1. DC2 &lt;- DC3 replication will be initiated as before. Because the NC on DC3 is in the process of being removed, it is not a valid replication source, and the error 8452 appears.</para>
            </listItem>
          </list>
        </content>
      </section>
      <section>
        <title>Active Directory Sites and Services (DSSITE.MSC) -&gt; Replicate Now</title>
        <content>
          <para>The Active Directory Sites and Services snap-in (DSSITE.MSC) uses the topology information stored in the local copy of Active Directory. </para>
          <para>Given the replication topology DC1 &lt;- DC2 &lt;- DC3, a connection object exists under the NTDS Settings object of DC2. This connection object represents the route for DC2 to inbound replicate a NC (or multiple NCs) from DC3. If you right-click on this connection object and select <ui>Replicate now</ui>, DC3 initiates replication from DC2.</para>
          <para>As in the REPADMIN /SYNCALL example, there are also two cases where we might observe error 8452:</para>
          <list class="bullet">
            <listItem>
              <para>Case 1: Suppose we change the replication topology on DC2 to make it inbound replicate from DC4. The new replication topology is DC1 &lt;- DC2 &lt;- DC4. Until knowledge of this this topology change outbound replicates to DC1, the topology on DC1 is still the old topology of DC1 &lt;- DC2 &lt;- DC3. </para>
              <para>Starting the Active Directory Sites and Services UI focused on DC1s copy of Active Directory still shows that DC2 has an inbound connection object from source DC3. Right-clicking on DC3's inbound connection object from DC2 and choosing <ui>Replicate now</ui> will initiate a DC2 &lt;- DC3 replication on DC2. However, the KCC on DC2 already removed the replica link inbound replicating to DC2 from DC3 and created a replica link to DC2. Because the replication attempt DC2 &lt;-&gt; DC2 cannot be executed, the request fails error 8452.</para>
            </listItem>
            <listItem>
              <para>Case2: Suppose we are removing a NC on DC3 when we right-click the connection object and select <ui>Replicate now</ui> on DC1 to initiate DC2 &lt;- DC3 replication for this NC. Because the NC on DC3 is in the process of being removed, DC3 is not a valid replication source, and error 8452 appears.</para>
            </listItem>
          </list>
          <para />
        </content>
      </section>
      <section>
        <title>REPADMIN /REPLICATE or REPADMIN /SYNC</title>
        <content>
          <para>The replicate (or sync) command of repadmin triggers immediate replication of a naming context (directory partition) to a destination DC from a source DC. Its (simplified) syntax is:</para>
          <code>repadmin /replicate &lt;dest DC&gt; &lt;src DC&gt; &lt;replicated NC&gt;</code>
          <para>There are two cases that will trigger error 8452 when the repadmin /replicate (or sync) command is used to initiate a replication:</para>
          <list class="bullet">
            <listItem>
              <para>Case 1: the &lt;src DC&gt; parameter is not a replication partner of &lt;dest DC&gt; for &lt;replicated NC&gt;. For example, we have a replication topology DC1 &lt;- DC2 &lt;- DC3 in which DC2 syncs a NC from DC3. If we call: </para>
              <code>repadmin /replicate DC2 DC1 &lt;the NC&gt;</code>
              <para>DC2 will initiate replication from DC1. Because DC2 does not have a replica link from DC1 for the NC, this replication cannot be executed, and error 8452 appears.</para>
            </listItem>
            <listItem>
              <para>Case 2: the NC is being removed on src DC when the following command is run: </para>
              <code>repadmin /replicate &lt;dest DC&gt; &lt;src DC&gt; &lt;the NC&gt;</code>
              <para>In this case, &lt;src DC&gt; is not a valid replication source and error 8452 appears.</para>
            </listItem>
          </list>
        </content>
      </section>
      <section>
        <title>DCDIAG</title>
        <content>
          <para>The showrepl (or showreps) command of repadmin reports the replication status for each source DC from which the destination DC has an inbound connection object. The Replications test of dcdiag checks for timely replication between DCs. If error 8452 appears in a repadmin /showrepl report or dcdiag /test:replications report, the reason is that the replicated NC is being removed on the source DC when the last replication happened.</para>
        </content>
      </section>
      <section>
        <title>NTDS Replication Event 1586</title>
        <content>
          <para>NTDS replication event 1586 is generated in a mixed domain environment which contains both Windows NT 4.0 and Active Directory domain controllers. In this mixed domain environment, Active Directory domain controllers replicate amongst themselves using the DS replication protocol, while the Active Directory PDC emulator replicates to Windows NT 4 BDCs using the legacy netlogon replication protocol. In this case the Active Directory PDC FSMO role holder is the single point for replication to NT4 BDCs in a common domain. The PDC maintains a checkpoint for each BDC representing the most recent replicated change. If the PDC emulator role is transferred to another Active Directory domain controller in the domain, the information about each individual BDC's checkpoint must be replicated to the new PDC emulator. Hence the new PDC emulator must have a direct replication relationship with the old PDC emulator. If the new PDC emulator does not replicate directly with the old PDC emulator (that is on the new PDC emulator there is no replica link from old PDC emulator), then error 8452 appears in event 1586.</para>
        </content>
      </section>
      <section>
        <title>Demotion</title>
        <content>
          <para>There is another scenario that returns DRAERR_NoReplica error. During DC demotion, DC locator will find a DC to replicate local changes to. If the found DC does not replicate directly with the DC being demoted, DRAERR_NoReplica will be returned and DC locator will be called to find a destination DC. In this scenario, the error is not logged so it is not observed.</para>
        </content>
      </section>
    </sections>
  </section>
  <relatedTopics>
    <externalLink>
      <linkText>Troubleshooting Active Directory operations that fail with error 8452: "The naming context is in the process of being removed or is not replicated from the specified server."</linkText>
      <linkUri>http://support.microsoft.com/kb/2023704</linkUri>
    </externalLink>
    <externalLink>
      <linkText>How the Active Directory Replication Model Works</linkText>
      <linkUri>http://technet.microsoft.com/library/cc772726(WS.10).aspx</linkUri>
    </externalLink>
<externalLink><linkText>repsFrom, RepsFrom</linkText><linkUri>http://msdn.microsoft.com/library/cc228409(PROT.13).aspx</linkUri></externalLink></relatedTopics>
</developerConceptualDocument>


