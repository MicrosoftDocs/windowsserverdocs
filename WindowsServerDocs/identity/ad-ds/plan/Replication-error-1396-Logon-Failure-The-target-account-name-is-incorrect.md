---
ms.assetid: 399a8bbe-3375-4bb0-b55b-5f46e7050028
title: Replication error 1396 Logon Failure The target account name is incorrect
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Replication error 1396 Logon Failure The target account name is incorrect

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="https://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="https://www.w3.org/1999/xlink" xmlns:xsi="https://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This article describes the symptoms, cause and how to resolve Active Directory replication failing with Win32 error 1396: &quot;Logon failure: The target account name is incorrect.&quot; </para>
    <list class="bullet">
      <listItem>
        <para>
          <link xlink:href="d3a01966-74c9-4c49-ba11-354b9acf7519#BKMK_Symptoms">Symptoms</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="d3a01966-74c9-4c49-ba11-354b9acf7519#BKMK_Causes">Causes</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="d3a01966-74c9-4c49-ba11-354b9acf7519#BKMK_Resolutions">Resolutions</link>
        </para>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_Symptoms">
    <title>Symptoms</title>
    <content>
      <para />
      <list class="ordered">
<listItem><para>DCDIAG reports that the Active Directory Replications test has failed with error 1396: Logon failure: The target account name is incorrect.&quot;</para><code>Testing server: &lt;Site name&gt;&lt;DC Name&gt;
Starting test: Replications
[Replications Check,&lt;DC Name&gt;] A recent replication attempt failed:
From &lt;source DC&gt; to &lt;destination DC&gt;
Naming Context: CN=&lt;DN path of naming context&gt;
<codeFeaturedElement>The replication generated an error (1396):
Logon Failure: The target account name is incorrect.</codeFeaturedElement>
The failure occurred at &lt;date&gt; &lt;time&gt;.
The last success occurred at &lt;date&gt; &lt;time&gt;.
XX failures have occurred since the last success</code></listItem><listItem><para>REPADMIN.EXE reports that the last replication attempt has failed with status 1396.</para><para>REPADMIN commands that commonly cite the 1396 status include but are not limited to:</para><table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11"><tbody><tr><TD><list class="bullet"><listItem><para>REPADMIN /ADD</para></listItem><listItem><para>REPADMIN /REPLSUM</para></listItem><listItem><para>REPADMIN /REHOST</para></listItem><listItem><para>REPADMIN /SHOWVECTOR /LATENCY</para></listItem></list></TD><TD><list class="bullet"><listItem><para>REPADMIN /SHOWREPS</para></listItem><listItem><para>REPADMIN /SHOWREPL</para></listItem><listItem><para>REPADMIN /SYNCALL</para></listItem></list></TD></tr></tbody></table><para>Sample output from &quot;REPADMIN /SHOWREPS&quot; depicting inbound replication from CONTOSO-DC2 to CONTOSO-DC1 failing with the &quot;Logon Failure: The target account name is incorrect.&quot; error is shown below::</para><code>Default-First-Site-NameCONTOSO-DC1
DSA Options: IS_GC 
Site Options: (none)
DSA object GUID: b6dc8589-7e00-4a5d-b688-045aef63ec01
DSA invocationID: b6dc8589-7e00-4a5d-b688-045aef63ec01
==== INBOUND NEIGHBORS ======================================
DC=contoso,DC=com
Default-First-Site-NameCONTOSO-DC2 via RPC
DSA object GUID: 74fbe06c-932c-46b5-831b-af9e31f496b2
Last attempt @ &lt;date&gt; &lt;time&gt; failed, <codeFeaturedElement>result 1396 (0x574):
Logon Failure: The target account name is incorrect.</codeFeaturedElement>
&lt;#&gt; consecutive failure(s).
Last success @ &lt;date&gt; &lt;time&gt;.
</code></listItem><listItem><para>The <ui>Replicate now</ui> command in Active Directory Sites and Services returns &quot;Logon Failure: The target account name is incorrect.&quot;</para><para>Right-clicking on the connection object from a source DC and choosing <ui>Replicate now</ui> fails with &quot;Logon Failure: The target account name is incorrect.&quot; The on-screen error message is shown below:</para><para>Dialog title text:</para><para>Replicate Now</para><para>Dialog message text: </para><para>The following error occurred during the attempt to synchronize naming context &lt;partition DNS path&gt; from domain controller &lt;source DC&gt; to domain controller &lt;destination DC&gt;: Logon Failure: The target account name is incorrect. This operation will not continue. </para></listItem><listItem><para>NTDS KCC, NTDS General or Microsoft-Windows-ActiveDirectory_DomainService events with the 1396 status are logged in the Directory Services log in Event Viewer.</para><para>Active Directory events that commonly cite the 1396 status include but are not limited to:</para><table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11"><thead><tr><TD><para>Event ID</para></TD><TD><para>Event Source</para></TD><TD><para>Event String</para></TD></tr></thead><tbody><tr><TD><para>1125</para></TD><TD><para>Microsoft-Windows-ActiveDirectory_DomainService</para></TD><TD><para>The Active Directory Domain Services Installation Wizard (Dcpromo) was unable to establish connection with the following domain controller.</para></TD></tr><tr><TD><para>1645</para><para>This event lists the three-part SPN.</para></TD><TD><para>NTDS Replication</para></TD><TD><para>Active Directory did not perform an authenticated remote procedure call (RPC) to another domain controller because the desired service principal name (SPN) for the destination domain controller is not registered on the Key Distribution Center (KDC) domain controller that resolves the SPN.</para></TD></tr><tr><TD><para>1655</para></TD><TD><para>Microsoft-Windows-ActiveDirectory_DomainService</para></TD><TD><para>Active Directory Domain Services attempted to communicate with the following global catalog and the attempts were unsuccessful.</para></TD></tr><tr><TD><para>2847</para></TD><TD><para>Microsoft-Windows-ActiveDirectory_DomainService</para></TD><TD><para>The Knowledge Consistency Checker located a replication connection for the local read-only directory service and attempted to update it remotely on the following directory service instance. The operation failed. It will be retried.</para></TD></tr><tr><TD><para>1925</para></TD><TD><para>NTDS KCC</para></TD><TD><para>The attempt to establish a replication link for the following writable directory partition failed.</para></TD></tr><tr><TD><para>1926</para></TD><TD><para>NTDS KCC</para></TD><TD><para>The attempt to establish a replication link to a read-only directory partition with the following parameters failed.</para></TD></tr><tr><TD><para>5781</para></TD><TD><para>NETLOGON</para></TD><TD><para> The server cannot register its name in DNS.</para></TD></tr></tbody></table></listItem><listItem><para>DCPROMO fails with an onscreen error</para><para>Dialog Title Text:</para><para>Active Directory Installation Failed</para><para>Dialog Message text:</para><para>The operation failed because: The Directory Service failed to create the server object for CN=NTDS Settings,CN=ServerBeingPromoted,CN=Servers,CN=Site,CN=Sites,CN=Configuration,DC=contoso,DC=com on server ReplicationSourceDC.contoso.com. </para><para>Please ensure
the network credentials provided have sufficient access to add a replica. </para><para>
&quot;Logon Failure: The target account name is incorrect. &quot;</para><para>In this case, Event ID 1645, 1168, and 1125 are logged on the server that is being promoted.</para></listItem><listItem><para>Map a drive using <embeddedLabel>net use</embeddedLabel>:</para><code>C:&gt;net use z: &lt;server_name&gt;c$
System error 1396 has occurred.
Logon Failure: The target account name is incorrect.</code><para>In this case, the server can also logging Event ID 333 in the system event log and use a high amount of virtual memory for an application such as SQL Server.</para></listItem><listItem><para>The DC time is incorrect.</para></listItem><listItem><para>The KDC will not start on an RODC after a restore of the krbtgt account for the RODC, which had been deleted. For example, after a restore, error 1396 appears. </para><para>
Event ID 1645 is logged on the RODC. </para><para>
Dcdiag also reports an error that it cannot update the RODC krbtgt account. </para></listItem>
</list>
    </content>
  </section>
  <section address="BKMK_Causes">
    <title>Causes</title>
    <content>
      <para />
      <list class="ordered">
        <listItem>
          <para>The SPN does not exist on the global catalog searched by the KDC on behalf of the client attempting to authenticate using Kerberos.</para>
          <para>In the context of Active Directory replication, the Kerberos client is the destination DC, the KDC performing the SPN lookup is likely the destination DC itself but could be a remote DC.</para>
        </listItem>
        <listItem>
          <para>The user or service account that should contain the service principal name being looked up does not exist on the global catalog searched by the KDC on behalf of destination DC attempting to replicate.</para>
          <para>In the context of Active Directory replication, the source DC computer account does not exist on the global catalog searched by the DC on behalf of the destination DC performing inbound replication.</para>
        </listItem>
        <listItem>
          <para>The destination DC lacks an LSA secret for the source DCs domain.</para>
        </listItem>
        <listItem>
          <para>The SPN being looked up exists on a different computer account than the source DC.</para>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_Resolutions">
    <title>Resolutions</title>
    <content>
      <list class="ordered">
        <listItem>
          <para>Check the Directory Service event log on the destination DC for NTDS Replication event 1645 and note the following:</para>
          <para>The name of the destination DC</para>
          <para>The SPN being looked up (E3514235-4B06-11D1-AB04-00C04FC2DCD2/&lt;object guid for source DCs NTDS Settings object&gt;/&lt;target domain&amp;amp;gt;.&amp;amp;lt;tld&amp;amp;gt;@&lt;target domain&gt;.&lt;tld&gt;</para>
          <para>The KDC being used by the destination DC</para>
        </listItem>
        <listItem>
          <para>From the console of the KDC identified in step 1, type: </para>
          <code>nltest /dsgetdc &lt;forest root DNS domain name &gt; /gc</code>
          <para>Run the NLTEST locator test immediately following a replication attempt that fails with the 1396 error on the destination DC. </para>
          <para>This should identify that GC that the KDC is performing SPN lookups against. </para>
          <para>The GC being searched by the KDC may also be captured in Microsoft-Windows-ActiveDirectory_DomainService event 1655.</para>
        </listItem>
        <listItem>
          <para>Search for the SPN discovered in step 1 on the global catalog discovered in step 2.</para>
          <code>C:&gt;repadmin /showattr Server_Name DC=corp,DC=contoso,dc=com &lt;GC used by KDC&gt; &lt;DN path of forest root domain&gt; /filter:&quot;(serviceprincipalname=&lt;SPN cited in the NTDS Replication event 1645&gt;)&quot; /gc /subtree /atts:cn,serviceprincipalname</code>
          <para>OR</para>
          <code>C:&gt;dsquery * forestroot -scope subtree -filter &quot;(serviceprincipalname=E3514235-4B06-11D1-AB04-00C04FC2DCD2/65cead9f-4949-46a3-a49a-f1fbfe13d2b3*)&quot; -attr * -s Server_Name.europe.corp.contoso.com</code>
          <para>Verify that the host object for the SPN exists.</para>
          <para>Verify the DN path for the host object including whether the object is CNF / conflict mangled or resides in the lost and found container.</para>
          <para>Verify that the source DCs Active Directory Replication SPN is registered only on the source DCs computer account.</para>
          <para>If the replication SPN is missing, determine if the source DC has registered its SPN with itself, and whether the SPN is missing on the GC used by the KDC due to simple replication latency or a replication failure.</para>
        </listItem>
        <listItem>
          <para>Check the secure channel health and trust health.</para>
        </listItem>
      </list>
    </content>
  </section>
  <relatedTopics>
    <externalLink>
      <linkText>Troubleshooting Active Directory operations that fail with error 1396: Logon Failure: The target account name is incorrect.</linkText>
      <linkUri><a href="https://support.microsoft.com/kb/2183411/en-gb" data-raw-source="https://support.microsoft.com/kb/2183411/en-gb">https://support.microsoft.com/kb/2183411/en-gb</a></linkUri>
    </externalLink>
  </relatedTopics>
</developerConceptualDocument>


