---
ms.assetid: 198da604-9d18-4801-b805-39a9c624ee1a
title: Replication error 1256 The remote system is not available
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Replication error 1256 The remote system is not available

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="https://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="https://www.w3.org/1999/xlink" xmlns:xsi="https://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This article describes the symptoms, cause, and resolution steps for cases when Active Directory replication fails with error 1256: The remote system is not available.</para>
    <list class="bullet">
      <listItem>
        <para>
          <link xlink:href="eb8f6b88-a7fe-4e58-bf5f-b9b2ece15d1e#BKMK_Symptoms">Symptoms</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="eb8f6b88-a7fe-4e58-bf5f-b9b2ece15d1e#BKMK_Cause">Cause</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="eb8f6b88-a7fe-4e58-bf5f-b9b2ece15d1e#BKMK_Resolution">Resolution</link>
        </para>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_Symptoms">
    <title>Symptoms</title>
    <content>
      <list class="ordered">
<listItem><para>The DCDIAG reports that the Active Directory Replications test has failed with error 1256: "The remote system is not available."</para><code>Starting test: Replications
[Replications Check, &lt;Destination DC&gt;] A recent replication attempt failed:
From &lt;source DC&gt; to &lt;destination DC&gt;
Naming Context: &lt;directory partition DN path&gt;
<codeFeaturedElement>The replication generated an error (1256):</codeFeaturedElement> 
<codeFeaturedElement>The remote system is not available.</codeFeaturedElement> For information about network troubleshooting, see Windows Help.
The failure occurred at &lt;date&gt; &lt;time&gt;
The last success occurred at &lt;date&gt; &lt;time&gt;
</code></listItem><listItem><para>REPADMIN.EXE reports that a replication attempt has failed with status 1256.</para><para>REPADMIN commands that commonly cite the 1256 status include but are not limited to:</para><table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11"><tbody><tr><TD><list class="bullet"><listItem><para>REPADMIN /REPLSUM</para></listItem><listItem><para>REPADMIN /SHOWREPL</para></listItem></list></TD><TD><list class="bullet"><listItem><para>REPADMIN /SHOWREPS</para></listItem><listItem><para>REPADMIN /FAILCACHE</para></listItem></list></TD></tr></tbody></table><para>Sample output from "REPADMIN /SHOWREPS" depicting inbound replication from LonEMEADC to LonContosoDC failing with "The remote system is not available" error is shown below: </para><code>Repadmin: running command /showrepl against full DC localhost
LondonLONCONTOSODC
DSA Options: IS_GC 
Site Options: (none)
DSA object GUID: a29bbfda-8425-4cb9-9c66-8e07d505a5c6
DSA invocationID: d58a6322-6a28-4708-82d3-53b7dcc13c1a
==== INBOUND NEIGHBORS ======================================
&lt;snip&gt;
DC=ForestDnsZones,DC=Contoso,DC=com
LondonLONEMEADC via RPC
DSA object GUID: cd691606-63d1-4cc8-b77a-055674ba569d
Last attempt @ 2010-06-10 17:35:46 failed, <codeFeaturedElement>result 1256 (0x4e8):</codeFeaturedElement>
<codeFeaturedElement>The remote system is not available.</codeFeaturedElement> For information about network troubleshooting, see Windows Help.
&lt;#&gt; consecutive failure(s).
Last success @ &lt;date&gt; &lt;time&gt;. 
</code></listItem><listItem><para>NTDS KCC, NTDS Replication, or ActiveDirectory_DomainService events with the 1256 status are logged in the directory service event log.</para><table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11"><thead><tr><TD><para>Event ID</para></TD><TD><para>Event Source</para></TD><TD><para>Event String</para></TD></tr></thead><tbody><tr><TD><para>1085</para><alert class="note"><para>Event 1085 is logged only if the NTDS Diagnostics value <embeddedLabel>"5 Replication Events"</embeddedLabel> has been set to a value of 1 or higher.</para></alert></TD><TD><para>NTDS Replication</para><para>ActiveDirectory_DomainService</para></TD><TD><para>Internal event: Active Directory Domain Services could not synchronize the following directory partition with the directory service at the following network address.</para></TD></tr><tr><TD><para>1308</para></TD><TD><para>NTDS KCC</para><para>ActiveDirectory_DomainService</para></TD><TD><para>The Knowledge Consistency Checker (KCC) has detected that successive attempts to replicate with the following domain controller has consistently failed. </para><para>The Knowledge Consistency Checker (KCC) has detected that successive attempts to replicate with the following directory service has consistently failed.</para></TD></tr></tbody></table></listItem></list>
    </content>
  </section>
  <section address="BKMK_Cause">
    <title>Cause</title>
    <content>
      <para>When the destination DC fails to bind to the source DC using RPC, a win32 error code appears in the <embeddedLabel>Repsfrom</embeddedLabel> status for that partition - usually Schema or Configuration partitions because they are replicated at a higher priority. After an RPC bind failure has occurred, a cleanup routine will run to clear the destination DCs queue from that same source DC. This is done to avoid wasting time attempting to replicate with a DC that it cannot connect to. Because it has not attempted a sync for the partitions that have been cleared from the queue, a status 1256 is logged. In a scenario where destination DC replicates Schema, Configuration, and several GC non-writable partitions from the source DC, the win32 error status for the Schema and Configuration partitions that caused the RPC bind failure is logged. The destination DC will then cancel the pending replication tasks for the remaining partitions and log win32 error 1256 for the status. </para>
      <para>In summary: 1256 is logged as the replication status per partition as a result of the destination DC cancelling the sync request from the source DC due to a connectivity failure previously encountered.</para>
    </content>
  </section>
  <section address="BKMK_Resolution">
    <title>Resolution</title>
    <content>
      <para>The win32 error 1256 should not be the focus of troubleshooting efforts, instead find the replication status that led to the RPC bind failure and then follow the corresponding article on TechNet. 
Microsoft Knowledge Base article <externalLink><linkText>2498185</linkText><linkUri>https://support.microsoft.com/kb/2498185</linkUri></externalLink> contains a list of Active Directory Replication troubleshooting articles.</para>
      <para>In order to determine the actual win32 error to troubleshoot use <placeholder>one</placeholder> of the following methods:</para>
      <list class="ordered">
        <listItem>
          <para>View <embeddedLabel>repadmin /showreps</embeddedLabel> or <embeddedLabel>/showrepl</embeddedLabel> output on the destination DC.</para>
          <list class="ordered">
            <listItem>
              <para>Identify Source DC in the output and list all win32 status messages per partition.</para>
            </listItem>
            <listItem>
              <para>The win32 status that is listed that is not a 1256 should be the focus of troubleshooting efforts.</para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>Using <embeddedLabel>repadmin /showrepl * /csv</embeddedLabel> output:</para>
          <list class="ordered">
            <listItem>
              <para>Filter column K, <embeddedLabel>Last Failure Status:</embeddedLabel>, clear <embeddedLabel>0</embeddedLabel> and <embeddedLabel>(Blanks)</embeddedLabel>.</para>
            </listItem>
            <listItem>
              <para>Filter column C, Destination DSA: Clear <embeddedLabel>(Select All)</embeddedLabel> and select just the DC where the 1256 status is logged.</para>
            </listItem>
            <listItem>
              <para>If 1256 is logged on more than one Source DC, Filter column F, <embeddedLabel>Source DSA:</embeddedLabel>, clear <embeddedLabel> (Select All)</embeddedLabel> and Select just one DC to narrow the focus.</para>
            </listItem>
            <listItem>
              <para>Column K, <embeddedLabel>Last Failure Status</embeddedLabel> will list the 1256s along with the real win32 error that led to the RPC bind failure.</para>
              <para>In the following example, win32 error 1722 is logged for the Configuration and Schema partitions and should be the focus of troubleshooting.</para>
              <table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11">
                <tbody>
                  <tr>
                    <TD>
                      <para>B</para>
                    </TD>
                    <TD>
                      <para>C</para>
                    </TD>
                    <TD>
                      <para>D</para>
                    </TD>
                    <TD>
                      <para>E</para>
                    </TD>
                    <TD>
                      <para>F</para>
                    </TD>
                    <TD>
                      <para>H</para>
                    </TD>
                    <TD>
                      <para>I</para>
                    </TD>
                    <TD>
                      <para>J</para>
                    </TD>
                    <TD>
                      <para>K</para>
                    </TD>
                  </tr>
                  <tr>
                    <TD>
                      <para>Destination DSA Site</para>
                    </TD>
                    <TD>
                      <para>Destination DSA</para>
                    </TD>
                    <TD>
                      <para>Naming Context</para>
                    </TD>
                    <TD>
                      <para>Source DSA Site</para>
                    </TD>
                    <TD>
                      <para>Source DSA</para>
                    </TD>
                    <TD>
                      <para>Number of Failures</para>
                    </TD>
                    <TD>
                      <para>Last Failure Time</para>
                    </TD>
                    <TD>
                      <para>Last Success Time</para>
                    </TD>
                    <TD>
                      <para>Last Success Status</para>
                    </TD>
                  </tr>
                  <tr>
                    <TD>
                      <para>London</para>
                    </TD>
                    <TD>
                      <para>LONCONTOSODC</para>
                    </TD>
                    <TD>
                      <para>CN=Configuration,DC=Contoso,DC=com</para>
                    </TD>
                    <TD>
                      <para>London</para>
                    </TD>
                    <TD>
                      <para>LONEMEADC</para>
                    </TD>
                    <TD>
                      <para>11</para>
                    </TD>
                    <TD>
                      <para>6/10/2010 17:35</para>
                    </TD>
                    <TD>
                      <para>6/10/2010 14:50</para>
                    </TD>
                    <TD>
                      <para>1722</para>
                    </TD>
                  </tr>
                  <tr>
                    <TD>
                      <para>London</para>
                    </TD>
                    <TD>
                      <para>LONCONTOSODC</para>
                    </TD>
                    <TD>
                      <para>CN=Schema,CN=Configuration,DC=Contoso,DC=com</para>
                    </TD>
                    <TD>
                      <para>London</para>
                    </TD>
                    <TD>
                      <para>LONEMEADC</para>
                    </TD>
                    <TD>
                      <para>11</para>
                    </TD>
                    <TD>
                      <para>6/10/2010 17:35</para>
                    </TD>
                    <TD>
                      <para>6/10/2010 14:50</para>
                    </TD>
                    <TD>
                      <para>1722</para>
                    </TD>
                  </tr>
                  <tr>
                    <TD>
                      <para>London</para>
                    </TD>
                    <TD>
                      <para>LONCONTOSODC</para>
                    </TD>
                    <TD>
                      <para>DC=ForestDnsZones,DC=Contoso,DC=com</para>
                    </TD>
                    <TD>
                      <para>London</para>
                    </TD>
                    <TD>
                      <para>LONEMEADC</para>
                    </TD>
                    <TD>
                      <para>11</para>
                    </TD>
                    <TD>
                      <para>6/10/2010 17:35</para>
                    </TD>
                    <TD>
                      <para>6/10/2010 14:50</para>
                    </TD>
                    <TD>
                      <para>
                        <embeddedLabel>1256</embeddedLabel>
                      </para>
                    </TD>
                  </tr>
                  <tr>
                    <TD>
                      <para>London</para>
                    </TD>
                    <TD>
                      <para>LONCONTOSODC</para>
                    </TD>
                    <TD>
                      <para>DC=corp,DC=Contoso,DC=com</para>
                    </TD>
                    <TD>
                      <para>London</para>
                    </TD>
                    <TD>
                      <para>LONEMEADC</para>
                    </TD>
                    <TD>
                      <para>11</para>
                    </TD>
                    <TD>
                      <para>6/10/2010 17:35</para>
                    </TD>
                    <TD>
                      <para>6/10/2010 14:50</para>
                    </TD>
                    <TD>
                      <para>1256</para>
                    </TD>
                  </tr>
                  <tr>
                    <TD>
                      <para>London</para>
                    </TD>
                    <TD>
                      <para>LONCONTOSODC</para>
                    </TD>
                    <TD>
                      <para>DC=EMEA,DC=Contoso,DC=com</para>
                    </TD>
                    <TD>
                      <para>London</para>
                    </TD>
                    <TD>
                      <para>LONEMEADC</para>
                    </TD>
                    <TD>
                      <para>11</para>
                    </TD>
                    <TD>
                      <para>6/10/2010 17:35</para>
                    </TD>
                    <TD>
                      <para>6/10/2010 14:50</para>
                    </TD>
                    <TD>
                      <para>1256</para>
                    </TD>
                  </tr>
                  <tr>
                    <TD>
                      <para>London</para>
                    </TD>
                    <TD>
                      <para>LONCONTOSODC</para>
                    </TD>
                    <TD>
                      <para>DC=apac,DC=Contoso,DC=com</para>
                    </TD>
                    <TD>
                      <para>London</para>
                    </TD>
                    <TD>
                      <para>LONEMEADC</para>
                    </TD>
                    <TD>
                      <para>11</para>
                    </TD>
                    <TD>
                      <para>6/10/2010 17:35</para>
                    </TD>
                    <TD>
                      <para>6/10/2010 14:50</para>
                    </TD>
                    <TD>
                      <para>1256</para>
                    </TD>
                  </tr>
                </tbody>
              </table>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>Initiate a manual replication sync between source and destination DCs using repadmin. </para>
          <code>Repadmin /replicate DestinationDC SourceDC <placeholder>DN of partition reporting status 1256</placeholder> </code>
          <para>(use <embeddedLabel>/readonly</embeddedLabel> switch for GC partition or <embeddedLabel>/selsecrets</embeddedLabel> switch if destination is an RODC)</para>
          <code>repadmin /replicate loncontosodc lonemeadc.emea.contoso.com dc=forestdnszones,dc=contoso,dc=com 
DsReplicaSync() <codeFeaturedElement>failed with status 1722 (0x6ba)</codeFeaturedElement>:
The RPC server is unavailable.
</code>
          <para>Take note that after manually initiating replication for the partition that the status has changed from 1256 to 1722:</para>
          <table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11">
            <tbody>
              <tr>
                <TD>
                  <para>B</para>
                </TD>
                <TD>
                  <para>C</para>
                </TD>
                <TD>
                  <para>D</para>
                </TD>
                <TD>
                  <para>E</para>
                </TD>
                <TD>
                  <para>F</para>
                </TD>
                <TD>
                  <para>H</para>
                </TD>
                <TD>
                  <para>I</para>
                </TD>
                <TD>
                  <para>J</para>
                </TD>
                <TD>
                  <para>K</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Destination DSA Site</para>
                </TD>
                <TD>
                  <para>Destination DSA</para>
                </TD>
                <TD>
                  <para>Naming Context</para>
                </TD>
                <TD>
                  <para>Source DSA Site</para>
                </TD>
                <TD>
                  <para>Source DSA</para>
                </TD>
                <TD>
                  <para>Number of Failures</para>
                </TD>
                <TD>
                  <para>Last Failure Time</para>
                </TD>
                <TD>
                  <para>Last Success Time</para>
                </TD>
                <TD>
                  <para>Last Success Status</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>London</para>
                </TD>
                <TD>
                  <para>LONCONTOSODC</para>
                </TD>
                <TD>
                  <para>CN=Configuration,DC=Contoso,DC=com</para>
                </TD>
                <TD>
                  <para>London</para>
                </TD>
                <TD>
                  <para>LONEMEADC</para>
                </TD>
                <TD>
                  <para>11</para>
                </TD>
                <TD>
                  <para>6/10/2010 17:35</para>
                </TD>
                <TD>
                  <para>6/10/2010 14:50</para>
                </TD>
                <TD>
                  <para>1722</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>London</para>
                </TD>
                <TD>
                  <para>LONCONTOSODC</para>
                </TD>
                <TD>
                  <para>CN=Schema,CN=Configuration,DC=Contoso,DC=com</para>
                </TD>
                <TD>
                  <para>London</para>
                </TD>
                <TD>
                  <para>LONEMEADC</para>
                </TD>
                <TD>
                  <para>11</para>
                </TD>
                <TD>
                  <para>6/10/2010 17:35</para>
                </TD>
                <TD>
                  <para>6/10/2010 14:50</para>
                </TD>
                <TD>
                  <para>1722</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>London</para>
                </TD>
                <TD>
                  <para>LONCONTOSODC</para>
                </TD>
                <TD>
                  <para>DC=ForestDnsZones,DC=Contoso,DC=com</para>
                </TD>
                <TD>
                  <para>London</para>
                </TD>
                <TD>
                  <para>LONEMEADC</para>
                </TD>
                <TD>
                  <para>12</para>
                </TD>
                <TD>
                  <para>6/10/2010 17:35</para>
                </TD>
                <TD>
                  <para>6/10/2010 14:50</para>
                </TD>
                <TD>
                  <para>
                    <embeddedLabel>1722</embeddedLabel>
                  </para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>London</para>
                </TD>
                <TD>
                  <para>LONCONTOSODC</para>
                </TD>
                <TD>
                  <para>DC=corp,DC=Contoso,DC=com</para>
                </TD>
                <TD>
                  <para>London</para>
                </TD>
                <TD>
                  <para>LONEMEADC</para>
                </TD>
                <TD>
                  <para>11</para>
                </TD>
                <TD>
                  <para>6/10/2010 17:35</para>
                </TD>
                <TD>
                  <para>6/10/2010 14:50</para>
                </TD>
                <TD>
                  <para>1256</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>London</para>
                </TD>
                <TD>
                  <para>LONCONTOSODC</para>
                </TD>
                <TD>
                  <para>DC=EMEA,DC=Contoso,DC=com</para>
                </TD>
                <TD>
                  <para>London</para>
                </TD>
                <TD>
                  <para>LONEMEADC</para>
                </TD>
                <TD>
                  <para>11</para>
                </TD>
                <TD>
                  <para>6/10/2010 17:35</para>
                </TD>
                <TD>
                  <para>6/10/2010 14:50</para>
                </TD>
                <TD>
                  <para>1256</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>London</para>
                </TD>
                <TD>
                  <para>LONCONTOSODC</para>
                </TD>
                <TD>
                  <para>DC=apac,DC=Contoso,DC=com</para>
                </TD>
                <TD>
                  <para>London</para>
                </TD>
                <TD>
                  <para>LONEMEADC</para>
                </TD>
                <TD>
                  <para>11</para>
                </TD>
                <TD>
                  <para>6/10/2010 17:35</para>
                </TD>
                <TD>
                  <para>6/10/2010 14:50</para>
                </TD>
                <TD>
                  <para>1256</para>
                </TD>
              </tr>
            </tbody>
          </table>
</listItem>
      </list>
    </content>
  </section>
  <relatedTopics>
    <externalLink>
      <linkText>Troubleshooting Active Directory operations that fail with error 1256: The remote system is not available.</linkText>
      <linkUri>https://support.microsoft.com/kb/2200187</linkUri>
    </externalLink>
  </relatedTopics>
</developerConceptualDocument>


