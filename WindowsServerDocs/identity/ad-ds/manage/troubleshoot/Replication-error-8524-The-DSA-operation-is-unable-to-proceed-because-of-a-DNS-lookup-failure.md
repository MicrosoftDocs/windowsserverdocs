---
ms.assetid: e008cc4e-c1dc-4822-bc8c-a904567fb21f
title: Replication error 8524 The DSA operation is unable to proceed because of a DNS lookup failure
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 02/09/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Replication error 8524 The DSA operation is unable to proceed because of a DNS lookup failure

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012``


<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This topic explains symptoms, causes and how to resolve Active Directory replication error 8524 The DSA operation is unable to proceed because of a DNS lookup failure.</para>
    <list class="ordered">
      <listItem>
        <para>
          <link xlink:href="83f03f7a-2818-4805-8af2-e397f0be4aa1#BKMK_Symptoms">Symptoms</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="83f03f7a-2818-4805-8af2-e397f0be4aa1#BKMK_Causes">Causes</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="83f03f7a-2818-4805-8af2-e397f0be4aa1#BKMK_Resolutions">Resolutions</link>
        </para>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_Symptoms">
    <title>Symptoms</title>
    <content>
      <list class="ordered">
        <listItem>
          <para>DCDIAG reports that Active Directory Replications test has failed with status 8524:</para>
          <code>Testing server: &lt;sitename&gt;&lt;destination DC&gt;
Starting test: Replications
[Replications Check,&lt;destination DC&gt;] A recent replication attempt failed:
From &lt;source DC&gt; to &lt;destination dc&gt;
Naming Context: 
CN=&lt;DN path for failing directory partition&gt;,DC=Contoso,DC=Com
<codeFeaturedElement>The replication generated an error (8524):</codeFeaturedElement>
<codeFeaturedElement>The DSA operation is unable to proceed because of a DNS lookup failure.</codeFeaturedElement>
</code>
        </listItem>
        <listItem>
          <para>REPADMIN reports that a replication attempt has failed with status 8524.</para>
          <para>REPADMIN commands that commonly cite the 8524 status include but are not limited to:</para>
          <list class="bullet">
            <listItem>
              <para>REPADMIN /REPLSUM</para>
            </listItem>
            <listItem>
              <para>REPADMIN /SHOWREPS</para>
            </listItem>
            <listItem>
              <para>REPADMIN /SHOWREPL</para>
            </listItem>
          </list>
          <para>Sample 8524 failures from REPADMIN /SHOWREPS is shown below:</para>
          <code>Default-First-Site-NameCONTOSO-DC1
DSA Options: IS_GC 
Site Options: (none)
DSA object GUID: e15fc9a1-82f8-4a99-97f2-8e715f06e747
DSA invocationID: e15fc9a1-82f8-4a99-97f2-8e715f06e747

==== INBOUND NEIGHBORS ======================================

DC=contoso,DC=com
Default-First-Site-Name\CONTOSO-DC2 via RPC
DSA object GUID: 8a7baee5-cd81-4c8c-9c0f-b10030574016
Last attempt @ YYYY-MM-DD HH:MM:SS failed, result 8524 (0x214c):
<codeFeaturedElement>The DSA operation is unable to proceed because of a DNS lookup failure.</codeFeaturedElement>
1 consecutive failure(s).
Last success @ YYYY-MM-DD HH:MM:SS. 
&lt;Remainder of /showrepl output truncated&gt; 
</code>
        </listItem>
        <listItem>
          <para>NTDS KCC, NTDS General or Microsoft-Windows-ActiveDirectory_DomainService events with the 8524 status are logged in the directory service event log.</para>
          <para>Active Directory events that commonly cite the 8524 status include but are not limited to:</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Event</para>
                </TD>
                <TD>
                  <para>Source</para>
                </TD>
                <TD>
                  <para>Event String</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>2023</para>
                </TD>
                <TD>
                  <para>Microsoft-Windows-ActiveDirectory_DomainService</para>
                </TD>
                <TD>
                  <para>This directory server was unable to replicate changes to the following remote directory server for the following directory partition.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1655</para>
                </TD>
                <TD>
                  <para>NTDS General</para>
                </TD>
                <TD>
                  <para>Active Directory attempted to communicate with the following global catalog and the attempts were unsuccessful.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1308</para>
                </TD>
                <TD>
                  <para>NTDS KCC</para>
                </TD>
                <TD>
                  <para>The Knowledge Consistency Checker (KCC) has detected that successive attempts to replicate with the following directory service has consistently failed.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1865</para>
                </TD>
                <TD>
                  <para>NTDS KCC</para>
                </TD>
                <TD>
                  <para>The Knowledge Consistency Checker (KCC) was unable to form a complete spanning tree network topology. As a result, the following list of sites cannot be reached from the local site.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1925</para>
                </TD>
                <TD>
                  <para>NTDS KCC</para>
                </TD>
                <TD>
                  <para>The attempt to establish a replication link for the following writable directory partition failed.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>1926</para>
                </TD>
                <TD>
                  <para>NTDS KCC</para>
                </TD>
                <TD>
                  <para>The attempt to establish a replication link to a read-only directory partition with the following parameters failed.</para>
                </TD>
              </tr>
            </tbody>
          </table>
        </listItem>
        <listItem>
          <para>Domain controllers log NTDS Replication event 2087 and/or NTDS Replication event 2088 in their Directory Service event log.</para>
          <para>Log Name: Directory Service</para>
          <para>Source: Microsoft-Windows-ActiveDirectory_DomainService</para>
          <para>Date: &lt;date&gt; &lt;time&gt;</para>
          <para>Event ID: 2087</para>
          <para>Task Category: DS RPC Client</para>
          <para>Level: Error</para>
          <para>Keywords: Classic</para>
          <para>User: ANONYMOUS LOGON</para>
          <para>Computer: &lt;dc name&gt;.&lt;domain name&gt;</para>
          <para>Description:</para>
          <para>Active Directory Domain Services could not resolve the following DNS host name of the source domain controller to an IP address. This error prevents additions, deletions and changes in Active Directory Domain Services from replicating between one or more domain controllers in the forest. Security groups, group policy, users and computers and their passwords will be inconsistent between domain controllers until this error is resolved, potentially affecting logon authentication and access to network resources.</para>
          <para>&lt;Remainder of event truncated, see MSKB <externalLink><linkText>824449</linkText><linkUri>http://support.microsoft.com/?kbid=824449</linkUri></externalLink> for full text&gt;</para>
<para>Log Name: Directory Service</para><para>Source: Microsoft-Windows-ActiveDirectory_DomainService</para><para>Date: &lt;date&gt; &lt;time&gt;</para><para>Event ID: 2088</para><para>Task Category: DS RPC Client</para><para>Level: Warning</para><para>Keywords: Classic</para><para>User: ANONYMOUS LOGON</para><para>Computer: &lt;dc name&gt;.&lt;domain name&gt;</para><para>Description:</para><para>Active Directory Domain Services could not use DNS to resolve the IP address of the source domain controller listed below. To maintain the consistency of Security groups, group policy, users and computers and their passwords, Active Directory Domain Services successfully replicated using the NetBIOS or fully qualified computer name of the source domain controller.</para><para>Invalid DNS configuration may be affecting other essential operations on member computers, domain controllers or application servers in this Active Directory Domain Services forest, including logon authentication or access to network resources.</para><para>You should immediately resolve this DNS configuration error so that this domain controller can resolve the IP address of the source domain controller using DNS.</para><para>&lt;Remainder of event truncated, see MSKB <externalLink><linkText>824449</linkText><linkUri>http://support.microsoft.com/?kbid=824449</linkUri></externalLink> for full text&gt;</para></listItem>
      </list>

</content>
  </section>
  <section address="BKMK_Causes">
    <title>Causes</title>
    <content>
      <para>Error Status 8524 maps to error string "The DSA operation is unable to proceed because of a DNS lookup failure." - a catch-all error for all possible DNS failures affecting Active Directory on post Windows Server 2003 SP1 domain controllers.</para>
      <para>Microsoft-Windows-ActiveDirectory_DomainService event 2087 is a partner event to other Active Directory events that cite the 8524 status if an Active Directory domain controller is unable to resolve a remote DC by its fully qualified CNAME record (&lt;object guid for source DCs NTDS Settings object&gt;._msdcs.&lt;forest root domain&gt;) using DNS.</para>
      <para>Microsoft-Windows-ActiveDirectory_DomainService event 2088 is logged when a source domain controller is successfully resolved by its NetBIOS name but such name resolution fallback only occurs when DNS name resolution fails.</para>
      <para>The presence of the 8524 status and the Microsoft-Windows-ActiveDirectory_DomainService event 2088 or 2087 events all indicate that DNS name resolution is failing Active Directory.</para>
      <para>In summary, the 8524 replication status is logged when a destination DC is unable to resolve the source DC by its CNAME and Host "A" or Host "AAAA" records using DNS. Specific root causes include:</para>
      <list class="ordered">
        <listItem>
          <para>The source DC is offline, or no longer exists but its NTDS Settings object still exist in the destination DCs copy of Active Directory.</para>
        </listItem>
        <listItem>
          <para>The source DC failed to register the CNAME or host records on one or more DNS Servers either because the registration attempts failed or DNS client settings on the source do not point to DNS Servers that either host, forwarded or delegate its _msdcs.&lt;forest root domain zone and / or primary DNS suffix domain zones. </para>
        </listItem>
        <listItem>
          <para>DNS client settings on the destination DC do not point to DNS Servers that either host, forward or delegate the DNS zones containing the CNAME or host records for the source DC.</para>
        </listItem>
        <listItem>
          <para>CNAME and host records registered by the source DC do not exist on DNS servers queried by the destination DC due to simple replication latency, a replication failure or a zone transfer failure.</para>
        </listItem>
        <listItem>
          <para>Invalid forwarders or delegations are preventing the destination DC from resolving CNAME or Host records for DCs in other domains in the forest.</para>
        </listItem>
        <listItem>
          <para>DNS Servers used by destination DC, source DC or intermediate DNS Servers are not functioning properly.</para>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_Resolutions">
    <title>Resolutions</title>
    <content>
      <list class="ordered">
        <listItem>
          <para>Verify whether the 8524 is caused by an offline DC or stale DC metadata.</para>
          <para>If the 8524 error / event refers to a DC that is currently offline but still a valid DC in the forest, make it operational.</para>
          <para>If the 8524 error / event refers to an inactive DC - a DC install that no longer exists on the network but whose NTDS Settings object still exists in the destination DCs copy of Active Directory - remove the stale metadata for that DC from the destination DCs copy of Active Directory.</para>
          <para>Microsoft CSS regularly finds stale metadata for nonexistent DCs, or stale metadata from previous promotions of a DC with the same computer name that has not been removed from Active Directory.</para>
        </listItem>
        <listItem>
          <para>Remove stale DC metadata if present.</para>
          <procedure>
            <title>GUI Metadata Cleanup using Active Directory Sites and Services (DSSITE.MSC)</title>
            <steps class="ordered">
              <step>
                <content>
                  <para>Start the Windows 2008 or Windows Server 2008 R2 or W2K8 R2 Active Directory Sites and Services snap-in (DSSITE.MSC).</para>
                  <para>This can also be done by starting the Active Directory Sites and Services on a Windows Vista or Windows 7 computer that has been installed as part of the Remote Server Administration Tools (RSAT) package.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>Focus the DSSITE.MSC snap-in on the <placeholder>destination</placeholder> DCs copy of Active Directory.</para>
                  <para>After starting DSSITE.MSC, right click on the <ui>Active Directory Sites and Services &lt;DC Name&gt;</ui>.</para>
                  <para>Select the destination DC that is logging the 8524 error / event from the list of DCs visible in the <ui>Change Domain Controller...</ui> list.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>Delete the source DCs NTDS Settings object referenced in the 8524 errors and events. Active Directory Users and Computers (DSA.MSC) snap-in and delete either the source DCs NTDS Settings object.</para>
                  <para>A DCs NTDS Settings object appears below the Sites, Site Name, Servers container and %server name% container and above the inbound connection object displayed in in the right-hand pane of Active Directory Sites and Services.</para>
                  <para>Right click on the stale NTDS Settings object you want to remove then click <ui>Delete</ui>.</para>
                </content>
              </step>
            </steps>
          </procedure>
<para>Metadata cleanup can also be performed from the Windows Server 2008 or Windows Server 2008 R2 version of Active Directory Users and Computers snap-in as documented in <externalLink><linkText>Clean Up Server Metadata</linkText><linkUri>http://technet.microsoft.com/library/cc816907%28WS.10%29.aspx</linkUri></externalLink>.</para><para>OR</para><procedure><title>Command line Metadata Cleanup using NTDSUTIL</title><steps class="ordered"><step><content><para>The legacy or command line method of deleting stale NTDS Settings objects using the NTDSUTIL metadata cleanup command is documented in MSKB <externalLink><linkText>216498</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;216498</linkUri></externalLink>.</para></content></step></steps></procedure>

</listItem>
        <listItem>
          <para>Run DCDIAG /TEST:DNS on the source DC + destination DC</para>
          <para>DCDIAG /TEST:DNS performs 7 different tests to quickly vet the DNS health of a domain controller. This test is NOT run as part of the default execution of DCDIAG. </para>
          <list class="ordered">
            <listItem>
              <para>Log onto the console of the destination domain controllers logging the 8524 events with Enterprise Admin credentials.</para>
            </listItem>
            <listItem>
              <para>Open an administrative privileged CMD prompt and run "DCDIAG /TEST:DNS /F on the DC logging the 8424 status AND the source DC that the destination DC is replicating from.</para>
              <para>To run DCDIAG against all DCs in a forest, type "DCDIAG /TEST:DNS /V /E /F:&lt;File name.txt&gt;</para>
              <para>To run DCDIAG TEST:DNS against a specific DC type "DCDIAG /TEST:DNS /V /S:&lt;DC NAME&gt; /F:&lt;File name.txt&gt;</para>
            </listItem>
            <listItem>
              <para>Locate the summary table at the end of the DCDIAG /TEST:DNS output. Identify and reconcile warning or failure conditions on the relevant DCs of the report.</para>
            </listItem>
            <listItem>
              <para>If DCDIAG does not identify the root cause, take "the long way around" using the steps below.</para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>Check Active Directory Name Resolution using PING</para>
          <para>Destination DCs resolve source DCs in DNS by their fully qualified CNAME records which are derived from the object GUID of the remote DCs NTDS Settings object (the parent object to connection objects visible in the Active Directory Sites and Services snap-in). You can test a given DCs ability to resolve a source DC fully qualified CNAME record using the PING command.</para>
          <list class="ordered">
            <listItem>
              <para>Locate the objectGUID of the source DCs NTDS Settings object in the source DCs copy of Active Directory.</para>
              <para>From the console of the source DC logging the 8524 error / event, type:</para>
              <code>c:\&gt;repadmin /showreps &lt;fully qualified hostname of <placeholder>source</placeholder> DC cited in the 8524 error / event &gt;</code>
              <para>For example, if the DC referenced in the 8524 error/event is contoso-DC2 in the contoso.com domain type:</para>
              <code>c:\&gt;repadmin /showreps contoso-dc2.contoso.com</code>
              <para>The "DSA Object GUID" field in the header of the /SHOWREPS command contains the objectGUID of the source DCs <placeholder>current</placeholder> NTDS settings object. Use the source DCs view of its NTDS Settings Object in case replication is slow or failing. The header of the repadmin output will look something like:</para>
              <code>Default-First-Site-Name\CONTOSO-DC1
DSA Options: IS_GC 
Site Options: (none)
DSA object GUID: 8a7baee5-cd81-4c8c-9c0f-b10030574016</code>
              <para>Right-click and copy the GUID and paste it into the PING command in step d of this list.</para>

</listItem>
            <listItem>
              <para>Locate the ObjectGUID of the source DC in the <placeholder>destination</placeholder> DCs copy of Active Directory.</para>
              <para>From the console of the destination DC logging the 8524 error / event, type:</para>
              <code>c:\&gt;repadmin /showreps &lt;fully qualified hostname of <placeholder>destination</placeholder> DC&gt;&gt;
</code>
              <para>For example, if the DC logging 8524 error / event is contoso-DC1 in the contoso.com domain type:</para>
              <code>c:\&gt;repadmin /showreps contoso-dc1.contoso.com</code>
              <para>REPADMIN /SHOWREPS output is shown below. The "DSA Object GUID" field is listed for each source DC the destination DC inbound replicates from.</para>
              <code>c:\&gt;repadmin /showreps contoso-dc1.contoso.com
Default-First-Site-Name\CONTOSO-DC1
DSA Options: IS_GC 
Site Options: (none)
DSA object GUID: e15fc9a1-82f8-4a99-97f2-8e715f06e747
DSA invocationID: e15fc9a1-82f8-4a99-97f2-8e715f06e747 
==== INBOUND NEIGHBORS ======================================
DC=contoso,DC=com
Default-First-Site-Name\CONTOSO-DC2 via RPC
DSA object GUID: 8a7baee5-cd81-4c8c-9c0f-b10030574016 &lt;- Object GUID for source DC derived from
Last attempt @ 2010-03-24 15:45:15 failed, result 8524 (0x214c): \ destination DCs copy of Active Directory
The DSA operation is unable to proceed because of a DNS lookup failure.
23 consecutive failure(s).
Last success @ YYYY-MM-DD HH:MM:SS.
</code>
            </listItem>
            <listItem>
              <para>Compare the object GUID from step a and step b.</para>
              <para>If the object GUIDS are the same, then the source DC and destination DC know about the same instantiation (the same promotion) of the source DC. If they are different then figure who which one was created later. The NTDS setting object with the earlier create date is likely stale and should be removed.</para>
            </listItem>
            <listItem>
              <para>PING the source DC by its fully qualified CNAME.</para>
              <para>From the console of the destination DC, test Active Directory's name resolution with a PING of the source DCs fully qualified CNAME record:</para>
              <code>c:\&gt;ping &lt;ObjectGUID from source DCs NTDS Settings object._msdcs.&lt;DNS name for Active Directory forest root domain&gt;
</code>
              <para>Using our example of the 8a7baee5-cd81-4c8c-9c0f-b10030574016 objectGUID from the repadmin /showreps output above from the contoso-dc1 DC in the contoso.com domain, the PING syntax would be:</para>
              <code>c:\&gt;ping 8a7baee5-cd81-4c8c-9c0f-b10030574016._msdcs.contoso.com</code>
              <para>If PING works, retry the failing operation in Active Directory. If PING fails, proceed to the "Resolve the 8524 DNS lookup failure" but retrying the PING test after each step until it resolves.</para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>Resolve the 8524 DNS lookup failure: "The long way around"</para>
          <para>If the 8524 error / events are not caused by stale DC metadata and the CNAME PING test fails, vet the DNS health of the source DC, the destination DC and the DNS Servers used by the source and destination DCs. In summary, verify that:</para>
          <list class="bullet">
            <listItem>
              <para>The source DC has registered the CNAME and host records with a valid DNS.</para>
            </listItem>
            <listItem>
              <para>The destination DC points to valid DNS Servers.</para>
            </listItem>
            <listItem>
              <para>That the records of interest registered by source DCs are resolvable by destination DCs.</para>
            </listItem>
          </list>
          <para>The error message text in DS RPC Client event 2087 documents a user action for resolving the 8524 error. A more detailed action plan follows:</para>
          <list class="ordered">
            <listItem>
              <para>Verify that the source DC points to valid DNS Servers</para>
              <para>On the source DC, verify that DNS Client settings point <placeholder>exclusively</placeholder>  to operational DNS Severs that either host, forward or delegate the:</para>
              <para>_msdcs.&lt;forest root domain&gt; zone (i.e. All DCs in the contoso.com forest register CNAME records in the _msdcs.contoso.com zone)</para>
              <para>AND</para>
              <para>The DNS zone for the Active Directory domain (i.e. a computer in the contoso.com domain would register host records in in contoso.com zone)</para>
              <para>AND</para>
              <para>The computers primary DNS suffix domain if different from the Active Directory domain name (see <externalLink><linkText>Disjoint Namespace</linkText><linkUri>http://technet.microsoft.com/library/cc731125(WS.10).aspx</linkUri></externalLink>).</para>
              <para>Options to validate that a DNS Server hosts, forwards or delegates (i.e. "can resolve") such zones include:</para>
              <list class="ordered">
                <listItem>
                  <para>Start the DNS management tool for your DNS and verify that the DNS Servers that the source DC points to for name resolution host the zones in question.</para>
                </listItem>
              </list>
              <para>OR</para>
              <list class="ordered">
                <listItem>
                  <para>Use NSLOOKUP to verify that all of the DNS Servers that the source DC points to can resolve queries for the DNS zones in question.</para>
                  <para>Run IPCONFIG /ALL on the console of the source DC</para>
                  <code>c:\&gt;ipconfig /all

DNS Servers . . . . . . . . . . . : 192.0.2.99 &lt;- Primary DNS Server IP&gt;
                                    192.0.2.101&lt;- Secondary DNS Server IP&gt; 
</code>
                  <para>Run the following NSLOOKUP queries:</para>
                  <code>c:\&gt;nslookup -type=soa &lt;Source DC DNS domain name&gt; &lt;source DCs primary DNS Server IP &gt;
c:\&gt;nslookup -type=soa &lt; Source DC DNS domain name &gt; &lt;source DCs secondary DNS Server IP &gt;
c:\&gt;nslookup -type=soa &lt;_msdcs.&lt;forest root DNS domain&gt; &lt;source DCs primary DNS Server IP &gt;
c:\&gt;nslookup -type=soa &lt;_msdcs.&lt;forest root DNS domain&gt; &lt;source DCs secondary DNS Server IP &gt;</code>
                  <para>For example, if a DC in the CHILD.CONTOSO.COM domain of the contoso.com forest is configured with the primary and secondary DNS Server IPs "192.0.2.99" and "192.0.2.101", the NSLOOKUP syntax would be</para>
                  <code>c:\&gt;nslookup -type=soa child.contoso.com 192.0.2.99
c:\&gt;nslookup -type=soa child.contoso.com 192.0.2.101
c:\&gt;nslookup -type=soa _msdcs.contoso.com 192.0.2.99
c:\&gt;nslookup -type=soa _msdcs.contoso.com 192.0.2.101</code>
                </listItem>
              </list>
<alert class="note"><list class="bullet"><listItem><para>The SOA query for the _mscs.contoso.com zone will resolve correctly if the targeted DNS has a good forwarder or delegation for the _msdcs.&lt;forest root zone&gt;. This query will not resolve correctly if the _msdcs.&lt;forest root zone&gt; on the DNS Server being queried is a non-delegated sub-domain of &lt;forest root zone&gt; which is the zone relationship created by Windows 2000 domains.</para></listItem><listItem><para>CNAME records are always registered in the _msdcs.&lt;forest root zone&gt;, even for DCs in non-root domains.</para></listItem><listItem><para>Configuring the DNS client of a DC or member computer to point to an ISP DNS Server for name resolution is invalid unless that ISP has been contracted (paid) and is currently hosting, forwarding or delegating DNS queries for your Active Directory forest.</para></listItem><listItem><para>ISP DNS Servers typically do not accept dynamic DNS updates so CNAME, Host and SRV records may have to be manually registered.</para></listItem></list></alert></listItem>
            <listItem>
              <para>Verify that the source DC has registered its CNAME record</para>
              <para>Use step 1 from "Check Active Directory Name Resolution using PING" to locate the current CNAME of the source DC.</para>
              <para>Run <embeddedLabel>ipconfig /all</embeddedLabel> on the console of the source DC to determine which DNS Servers the source DC points to name resolution.</para>
              <code>c:\&gt;ipconfig /all

DNS Servers . . . . . . . . . . . : 192.0.2.99 &lt;- Primary DNS Server IP&gt;
                                    192.0.2.101&lt;- Secondary DNS Server IP&gt; 
</code>
              <para>Use NSLOOKUP to query the current DNS Servers for the source DCs CNAME record (found by using the procedure in "Check Active Directory Name Resolution using PING").</para>
              <code>c:\&gt;nslookup -type=cname &lt;fully qualified cname of source DC&gt; &lt;source DCs primary DNS Server IP &gt;
c:\&gt;nslookup -type=cname &lt;fully qualified cname of source DC&gt; &lt;source DCs secondary DNS Server IP&gt; 
</code>
              <para>Continuing the example where the NTDS Settings objectGUID for contoso-dc2 in the contoso.com domain is 8a7baee5-cd81-4c8c-9c0f-b10030574016 and points to "192.0.2.99" as primary for DNS name resolution, the NSLOOKUP syntax would be:</para>
              <code>c:\&gt;nslookup -type=cname 8a7baee5-cd81-4c8c-9c0f-b10030574016._msdcs.contoso.com 192.0.2.99
c:\&gt;nslookup -type=cname 8a7baee5-cd81-4c8c-9c0f-b10030574016._msdcs.contoso.com 192.0.2.101</code>
              <para>If the source DC has not registered its CNAME record on the DNS Servers it points to for name resolution, run the following command from the command prompt of the source DC then recheck the registration of the CNAME record:</para>
              <code>c:\&gt;net stop netlogon &amp; net start netlogon</code>
              <alert class="note">
                <list class="bullet">
                  <listItem>
                    <para>CNAME records are always registered in the _msdcs.&lt;forest root zone&gt;, even for DC in non-root domains.</para>
                  </listItem>
                  <listItem>
                    <para>CNAME records are registered by the Net Logon service during operating system startup, Net Logon service startup and recurring intervals thereafter.</para>
                  </listItem>
                  <listItem>
                    <para>Each promotion of a DC with the same name may create a new NTDS Settings object with a different objectGUID which therefore registers a different CNAME record. Verify registration of the CNAME record based the last promotion of the source DC versus the objectGUID for the NTDS Settings object on the destination DC if the source has been promoted more than once.</para>
                  </listItem>
                  <listItem>
                    <para>Timing issues during OS startup can delay successful Dynamic DNS registration.</para>
                  </listItem>
                  <listItem>
                    <para>If a DCs CNAME record was successfully registered but later disappears, check for the <externalLink><linkText>zone transfer delete bug</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;953317</linkUri></externalLink>, duplicate DNS zones in different replication scopes or overly aggressive scavenging by the DNS Server.</para>
                  </listItem>
                  <listItem>
                    <para>If the CNAME record registration is failing on the DNS servers that the source DC points to for name resolution, review NETLOGN events in the SYSTEM event log for DNS registration failures.</para>
                  </listItem>
                </list>
              </alert>
</listItem>
            <listItem>
              <para>Verify that the source DC has registered its host records</para>
              <para>From the console of the source DC, run <embeddedLabel>ipconfig /all</embeddedLabel> to determine which DNS Servers the source DC points to name resolution:</para>
              <code>c:\&gt;ipconfig /all

DNS Servers . . . . . . . . . . . : 192.0.2.99 &lt;- Primary DNS Server IP&gt;
                                    192.0.2.101&lt;- Secondary DNS Server IP&gt; 
</code>
              <para>Use NSLOOKUP to query the current DNS Servers for the host record:</para>
              <code>c:\&gt;nslookup -type=A+AAAA &lt;fully qualified hostname of source DC&gt; &lt;source DCs primary DNS Server IP &gt;
c:\&gt;nslookup -type=A+AAAA &lt;fully qualified hostname of source DC&gt; &lt;source DCs secondary DNS Server IP&gt;
</code>
              <para>Continuing the example for the hostname for contoso-dc2 in the contoso.com domain is 8a7baee5-cd81-4c8c-9c0f-b10030574016 and points to self (127.0.0.1) as primary for DNS name resolution, the NSLOOKUP syntax would be:</para>
              <code>c:\&gt;nslookup -type=A+AAAA contoso-dc1.contoso.com 192.0.2.99
c:\&gt;nslookup -type=A+AAAA contoso-dc1.contoso.com 192.0.2.101
</code>
              <para>Repeat the NSLOOKUP command against the source DCs secondary DNS Server IP address.</para>
              <para>To dynamically register host "A" records, type the following from the console of the computer:</para>
              <code>c:\&gt;ipconfig /registerdns</code>
              <alert class="note">
                <list class="bullet">
                  <listItem>
                    <para>Windows 2000 through Windows Server 2008 R2 computers all register IPv4 host "A" records.</para>
                  </listItem>
                  <listItem>
                    <para>Windows Server 2008 and Windows Server 2008 R2 computers all register IPv6 host "AAAA" records.</para>
                  </listItem>
                  <listItem>
                    <para>Host "A" and "AAAA" records are registered in the computers primary DNS suffix zone.</para>
                  </listItem>
                  <listItem>
                    <para>Disable network adapters that do not have network cables attached.</para>
                  </listItem>
                  <listItem>
                    <para>Disable host record registration on network adapters that are not accessible DCs and member computers on the network.</para>
                  </listItem>
                  <listItem>
                    <para>It is not supported to disable the IPv6 protocol by clearing the IPv6 checkbox in Networks in Control Panel.</para>
                  </listItem>
                </list>
              </alert>
            </listItem>
            <listItem>
              <para>Verify that the destination DC points to valid DNS Servers</para>
              <para>On the destination DC, verify that DNS Client settings point <placeholder>exclusively</placeholder>  to operational DNS Severs that either host, forward or delegate the:</para>
              <para>_msdcs.&lt;forest root domain&gt; zone (i.e. All DCs in the contoso.com forest register CNAME records in the _msdcs.contoso.com zone)</para>
              <para>AND</para>
              <para>The DNS zone for the Active Directory domain (i.e. a computer in the contoso.com domain would register host records in in contoso.com zone)</para>
              <para>AND</para>
              <para>The computers primary DNS suffix domain if different from the Active Directory domain name (see <externalLink><linkText>Disjoint Namespace</linkText><linkUri>http://technet.microsoft.com/library/cc731125(WS.10).aspx</linkUri></externalLink>).</para>
              <para>Options to validate that a DNS Server hosts, forwards or delegates (i.e. "can resolve") such zones include:</para>
              <list class="ordered">
                <listItem>
                  <para>Start the DNS management tool for your DNS and verify that the DNS Servers that the source DC points to for name resolution host the zones in question.</para>
                </listItem>
              </list>
              <para>OR</para>
              <list class="ordered">
                <listItem>
                  <para>Use NSLOOKUP to verify that all of the DNS Servers that the source DC points to can resolve queries for the DNS zones in question.</para>
                  <para>Run IPCONFIG /ALL on the console of the source DC</para>
                  <code>c:\&gt;ipconfig /all

DNS Servers . . . . . . . . . . . : 192.0.2.99 &lt;- Primary DNS Server IP&gt;
                                    192.0.2.101&lt;- Secondary DNS Server IP&gt; 
</code>
                  <para>Run the following NSLOOKUP queries:</para>
                  <code>c:\&gt;nslookup -type=soa &lt;Source DC DNS domain name&gt; &lt;source DCs primary DNS Server IP &gt;
c:\&gt;nslookup -type=soa &lt; Source DC DNS domain name &gt; &lt;source DCs secondary DNS Server IP &gt;
c:\&gt;nslookup -type=soa &lt;_msdcs.&lt;forest root DNS domain&gt; &lt;source DCs primary DNS Server IP &gt;
c:\&gt;nslookup -type=soa &lt;_msdcs.&lt;forest root DNS domain&gt; &lt;source DCs secondary DNS Server IP &gt;</code>
                  <para>For example, if a DC in the CHILD.CONTOSO.COM domain of the contoso.com forest is configured with the primary and secondary DNS Server IPs "192.0.2.99" and "192.0.2.101", the NSLOOKUP syntax would be</para>
                  <code>c:\&gt;nslookup -type=soa child.contoso.com 192.0.2.99
c:\&gt;nslookup -type=soa child.contoso.com 192.0.2.101
c:\&gt;nslookup -type=soa _msdcs.contoso.com 192.0.2.99
c:\&gt;nslookup -type=soa _msdcs.contoso.com 192.0.2.101</code>
                </listItem>
              </list>
<alert class="note"><list class="bullet"><listItem><para>The SOA query for the _mscs.contoso.com zone will resolve correctly if the targeted DNS has a good forwarder or delegation or for the _msdcs.&lt;forest root zone&gt;. This query will not resolve correctly if the _msdcs.&lt;forest root zone&gt; on the DNS Server being queried is a non-delegated sub-domain of &lt;forest root zone&gt; which is the zone relationship created by Windows 2000 domains.</para></listItem><listItem><para>CNAME records are always registered in the _msdcs.&lt;forest root zone&gt;, even for DCs in non-root domains.</para></listItem><listItem><para>Configuring the DNS client of a DC or member computer to point to an ISP DNS Server for name resolution is invalid unless that ISP has been contracted (paid) and is currently hosting, forwarding or delegating DNS queries for your Active Directory forest.</para></listItem><listItem><para>ISP DNS Servers typically do not accept dynamic DNS updates so CNAME, Host and SRV records may have to be manually registered.</para></listItem><listItem><para>The DNS resolver on the Windows computers is by-design "sticky" about using DNS servers that are responsive to queries, regardless of whether such DNS Servers host, forward or delegate the required zones. Restated, the DNS resolver will not fail over and query another DNS server as long as the active DNS server is responsive, even if the response from the DNS Server indicates that it does not host the record being queried or even host a copy of the zone for that record.</para></listItem><listItem><para>Configuring the DNS client of a DC or member computer to point to an ISP DNS Server for name resolution is invalid unless that ISP has been contracted (paid) to host, forward or delegate DNS queries for your Active Directory forest.</para></listItem></list></alert>
</listItem>
            <listItem>
              <para>Verify that the DNS Server used by the destination DC can resolve the source DCs CNAME and HOST records</para>
              <para>From the console of the destination DC, run "ipconfig /all" to determine which DNS Servers that destination DC points to for name resolution:</para>
              <code>c:\&gt;ipconfig /all

DNS Servers . . . . . . . . . . . : 192.0.2.102 &lt;- Primary DNS Server IP&gt;
                                    192.0.2.103&lt;- Secondary DNS Server IP&gt; 
</code>
              <para>From the console of the destination DC, use NSLOOKUP to query the DNS Servers configured on the destination DC for the source DCs cname and host records:</para>
              <code>c:\&gt;nslookup -type=cname &lt;fully qualified CNAME of source DC&gt; &lt;destination DCs primary DNS Server IP &gt;
c:\&gt;nslookup -type=cname &lt;fully qualified CNAME of source DC&gt; &lt;destination DCs secondary DNS Server IP&gt;
c:\&gt;nslookup -type=host &lt;fully qualified hostname of source DC&gt; &lt;destination DCs primary DNS Server IP &gt;
c:\&gt;nslookup -type=host &lt;fully qualified hostname of source DC&gt; &lt;destination DCs secondary DNS Server IP&gt;
</code>
              <para>Continuing the example where contoso-dc2 in the contoso.com domain with GUID 8a7baee5-cd81-4c8c-9c0f-b10030574016 in the Contoso.com forest root domain points to DNS Servers "192.0.2.102" and "192.0.2.103", the NSLOOKUP syntax would be:</para>
              <code>c:\&gt;nslookup -type=cname 8a7baee5-cd81-4c8c-9c0f-b10030574016._msdcs.contoso.com 192.0.2.102
c:\&gt;nslookup -type=cname 8a7baee5-cd81-4c8c-9c0f-b10030574016._msdcs.contoso.com 192.0.2.103
c:\&gt;nslookup -type=A+AAAA contoso-dc1.contoso.com 192.0.2.102
c:\&gt;nslookup -type=A+AAAA contoso-dc1.contoso.com 192.0.2.102
</code>

</listItem>
            <listItem>
              <para>Review the relationship between the DNS Servers used by the source and destination DCs</para>
              <para>If the DNS Servers used by the source and destination host AD-integrated copies of the _msdcs.&lt;forest root&gt; and &lt;primary DNS suffix&gt; zones, check for:</para>
              <list class="bullet">
                <listItem>
                  <para>Replication latency between the DNS where the record was registered and the DNS where the record is being queried.</para>
                </listItem>
                <listItem>
                  <para>A replication failure between the DNS where the record is registered and the DNS being queried.</para>
                </listItem>
                <listItem>
                  <para>The DNS zone hosting the record of interest resides in different replication scopes and therefore different contents, or is CNF / conflict-mangled on one or more DCs.</para>
                </listItem>
              </list>
              <para>If the DNS zones used by the source and destination DC are stored in primary and secondary copies of DNS zones, check for:</para>
              <list class="bullet">
                <listItem>
                  <para>The <ui>Allow zone transfers</ui> checkbox is not enabled on the DNS that hosts the primary copy of the zone.</para>
                </listItem>
                <listItem>
                  <para>The <ui>Only the following servers</ui> checkbox is enabled but the IP address of the secondary DNS has not been added to the allow list on the primary DNS.</para>
                </listItem>
                <listItem>
                  <para>The DNS zone on the Windows Server 2008 DNS hosting the secondary copy of the zone is empty due to MSKB <externalLink><linkText>953317</linkText><linkUri>http://support.microsoft.com/default.aspx?scid=kb;EN-US;953317</linkUri></externalLink>.</para>
                </listItem>
              </list>
              <para>If the DNS servers used by the source and destination DC have parent / child relationships, check for:</para>
              <list class="bullet">
                <listItem>
                  <para>Invalid delegations on the DNS that owns the parent zone that is delegating to the subordinate zone.</para>
                </listItem>
                <listItem>
                  <para>Invalid forwarder IP addresses on the DNS server trying to resolve the superior DNS zone (example: a DC in child.contoso.com trying to resolve host records in conto.com zone residing on DNS Servers in the root domain).</para>
                </listItem>
              </list>
            </listItem>
          </list>
</listItem>
      </list>
    </content>
  </section>
  <relatedTopics>
    <externalLink>
      <linkText>Troubleshooting Active Directory operations that fail with error 8524: The DSA operation is unable to proceed because of a DNS lookup failure</linkText>
      <linkUri>http://support.microsoft.com/kb/2021446</linkUri>
    </externalLink>
  </relatedTopics>
</developerConceptualDocument>


