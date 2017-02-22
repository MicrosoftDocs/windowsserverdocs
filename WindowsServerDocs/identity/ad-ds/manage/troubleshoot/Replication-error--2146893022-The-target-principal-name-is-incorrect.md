---
ms.assetid: 3b13244f-88d3-48c0-99b7-45ccdc85e86c
title: Replication error -2146893022 The target principal name is incorrect
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 02/09/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Replication error -2146893022 The target principal name is incorrect

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This topic explains symptoms, causes and how to resolve Active Directory replication error -2146893022: The target principal name is incorrect.</para>
    <list class="bullet">
      <listItem>
        <para>
          <link xlink:href="efb721cf-6541-44b2-95f4-37d5641aeee4#BKMK_Symptoms">Symptoms</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="efb721cf-6541-44b2-95f4-37d5641aeee4#BKMK_Causes">Causes</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="efb721cf-6541-44b2-95f4-37d5641aeee4#BKMK_Resolutions">Resolutions</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="efb721cf-6541-44b2-95f4-37d5641aeee4#BKMK_MoreInfo">More Information</link>
        </para>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_Symptoms">
    <title>Symptoms</title>
    <content>
      <para>This article describes the symptoms, cause, and resolution steps when Active Directory replication fails with error -2146893022: "The target principal name is incorrect."</para>
      <list class="ordered">
        <listItem>
          <para>DCDIAG reports that the Active Directory Replications test has failed with error -2146893022: "The target principal name is incorrect."</para>
          <code>[Replications Check,&lt;DC Name&gt;] A recent replication attempt failed:
From &lt;source DC&gt; to &lt;destination DC&gt;
Naming Context: &lt;DN path of directory partition&gt;
<codeFeaturedElement>The replication generated an error (-2146893022):
The target principal name is incorrect.</codeFeaturedElement>
The failure occurred at &lt;date&gt; &lt;time&gt;.
The last success occurred at &lt;date&gt; &lt;time&gt;.
&lt;X&gt; failures have occurred since the last success.</code>
        </listItem>
<listItem><para>REPADMIN.EXE reports that replication attempt has failed with status -2146893022 (0x80090322).</para><para>REPADMIN commands that commonly cite the -2146893022 (0x80090322 status) include but are not limited to:</para><table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11"><tbody><tr><TD><list class="bullet"><listItem><para>REPADMIN /REPLSUM</para></listItem><listItem><para>REPADMIN /SHOWREPL</para></listItem></list></TD><TD><list class="bullet"><listItem><para>REPADMIN /SHOWREPS</para></listItem><listItem><para>REPADMIN /SYNCALL</para></listItem></list></TD></tr></tbody></table><para>Sample output from "REPADMIN /SHOWREPS" and REPADMIN /SYNCALL depicting the "target principal name is incorrect" error are shown below:</para><code>c:&gt;repadmin /showreps
&lt;site name&gt;&lt;destination DC&gt;
DC Options: IS_GC 
Site Options: (none)
DC object GUID: &lt;NTDS settings object object GUID&gt;
DChttp://bemis/13/Pages/2090913_en-US.aspx invocationID: &lt;invocation ID string&gt;
==== INBOUND NEIGHBORS ======================================
DC=&lt;DN path for directory partition&gt;
&lt;site name&gt;&lt;source DC via RPC
DC object GUID: &lt;source DCs ntds settings object object guid&gt;
Last attempt @ &lt;date&gt; &lt;time&gt; failed, <codeFeaturedElement>result -2146893022 (0x80090322):
The target principal name is incorrect.</codeFeaturedElement>
&lt;X #&gt; consecutive failure(s).
Last success @ &lt;date&gt; &lt;time&gt;.


c:\&gt;repadmin /syncall /Ade
Syncing all NC's held on localhost.
Syncing partition: DC=&lt;Directory DN path&gt;
<codeFeaturedElement>CALLBACK MESSAGE: Error contacting server CN=NTDS Settings,CN=&lt;server name&gt;,CN=Servers,CN=&lt;site name&gt;,CN=Sites,CN=Configuration,DC=&lt;forest root domain&gt; (network error): -2146893022 (0x80090322):</codeFeaturedElement>
</code></listItem><listItem><para>The <ui>Replicate now</ui> command in Active Directory Sites and Services returns "The target principal name is incorrect."</para><para>Right-clicking on the connection object from a source DC and choosing <ui>Replicate now</ui> fails with ""The target principal name is incorrect." The on-screen error message text and screenshot is shown below:</para><para>Dialog title text: Replicate Now</para><para>Dialog message text: </para><para>The following error occurred during the attempt to contact the domain controller &lt;source DC name&gt;:</para><para>The target principal name is incorrect</para></listItem><listItem><para>NTDS KCC, NTDS General or Microsoft-Windows-ActiveDirectory_DomainService events with the -2146893022 status are logged in the Directory Services log in Event Viewer.</para><para>Active Directory events that commonly cite the -2146893022 status include but are not limited to:</para><table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11"><thead><tr><TD><para>Event ID</para></TD><TD><para>Event Source</para></TD><TD><para>Event String</para></TD></tr></thead><tbody><tr><TD><para>1586</para></TD><TD><para>NTDS Replication</para></TD><TD><para>The Windows NT 4.0 or earlier replication checkpoint with the PDC emulator master was unsuccessful. </para><para>

A full synchronization of the security accounts manager (SAM) database to domain controllers running Windows NT 4.0 and earlier might take place if the PDC emulator master role is transferred to the local domain controller before the next successful checkpoint.</para></TD></tr><tr><TD><para>1925</para></TD><TD><para>NTDS KCC</para></TD><TD><para>The attempt to establish a replication link for the following writable directory partition failed.</para></TD></tr><tr><TD><para>1308</para></TD><TD><para>NTDS KCC</para></TD><TD><para>The Knowledge Consistency Checker (KCC) has detected that successive attempts to replicate with the following domain controller has consistently failed.</para></TD></tr><tr><TD><para>1926</para></TD><TD><para>Microsoft-Windows-ActiveDirectory_DomainService</para></TD><TD><para>The attempt to establish a replication link to a read-only directory partition with the following parameters failed.</para></TD></tr><tr><TD><para>1373</para></TD><TD><para>NTDS Inter-site Messaging</para></TD><TD><para>The Intersite Messaging service could not receive any messages for the following service through the following transport. The query for messages failed.</para></TD></tr></tbody></table></listItem>
</list>
    </content>
  </section>
  <section address="BKMK_Causes">
    <title>Causes</title>
    <content>
      <para>The -2146893022  0x80090322  SEC_E_WRONG_PRINCIPAL error code is not an error returned by Active Directory but may be returned by lower layer components, including RPC, Kerberos, SSL, LSA and NTLM, for different root causes. </para>
      <para>Kerberos errors that are mapped by Windows code to -2146893022  0x80090322  SEC_E_WRONG_PRINCIPAL include:</para>
      <list class="bullet">
        <listItem>
          <para>KRB_AP_ERR_MODIFIED (0x29 / 41 decimal / KRB_APP_ERR_MODIFIED) </para>
        </listItem>
        <listItem>
          <para>KRB_AP_ERR_BADMATCH (0x24h / 36 decimal / Ticket and authenticator do not match)</para>
        </listItem>
        <listItem>
          <para>KRB_AP_ERR_NOT_US (0x23h / 35 decimal / The ticket is not for us)</para>
        </listItem>
      </list>
      <para>Some specific root causes for Active Directory logging -2146893022  0x80090322  SEC_E_WRONG_PRINCIPAL include: </para>
      <list class="bullet">
        <listItem>
          <para>A bad name-to-IP mapping in DNS, WINS, HOST or LMHOST file caused the destination DC to connect to the wrong source DC in the same Kerberos realm.</para>
        </listItem>
        <listItem>
          <para>A bad name-to-IP mapping in DNS, WINS, HOST or LMHOST file caused the destination DC to connect to the wrong source DC in a different Kerberos realm.</para>
        </listItem>
        <listItem>
          <para>The Kerberos target computer (source DC) was unable to decrypt Kerberos authentication data sent by the Kerberos client (destination DC) because the KDC and source DC have different versions of the source DCs computer account password.</para>
        </listItem>
        <listItem>
          <para>The KDC could not find a domain to look for the SPN of the source DC.</para>
        </listItem>
        <listItem>
          <para>Authentication data in Kerberos encrypted frames were modified by hardware (including network devices), software, or an attacker.</para>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_Resolutions">
    <title>Resolutions</title>
    <content>
      <list class="ordered">
        <listItem>
          <para>
            <embeddedLabel>Run dcdiag /test:checksecurityerror on the source DC</embeddedLabel>
          </para>
          <para>SPNs may be missing, invalid or duplicated due to simple replication latency, especially following promotion, or replication failures.</para>
          <para>Duplicate SPNs may cause bad SPN to name mappings.</para>
          <para>DCDIAG /TEST:CheckSecurityErrorr can check for missing or duplicate SPNs and other errors.</para>
          <para>Run this command on the console of all source DCs that fail "outbound" replication with the SEC_E_WRONG_PRINCIPAL error.</para>
          <para>You can check SPN registration against a specific location using the syntax:</para>
          <code>dcdiag /test:checksecurityerror replsource:&lt;remote dc&gt;</code>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>Verify that Kerberos encrypted network traffic reached the intended Kerberos target (name-to-IP mapping).</embeddedLabel>
          </para>
          <para>When inbound replicating Active Directory, destination DCs search their local copy of Active Directory for the objectGUID of the source DCs NTDS Settings objects, then query the active DNS Server for a matching DC GUIDed CNAME record which is then mapped to a host "A" / "AAAA" record containing the source DCs IP address. Active Directory performs name resolution fallback that includes queries for fully qualified computer names in DNS or single-label hostnames in WINS (note: DNS servers can also perform WINS lookups in fallback scenarios).</para>
          <para>Stale NTDS Settings objects, bad name-to-IP mappings in DNS and WINS host records, stale entries in HOST files can all cause a destination DC to submit Kerberos-encrypted traffic to the wrong Kerberos target.</para>
          <para>There are two methods to check for this condition: </para>
          <list class="bullet">
            <listItem>
              <para>Take a network trace.</para>
            </listItem>
          </list>
          <para>Or</para>
          <list class="ordered">
            <listItem>
              <para>Manually verify that name DNS / NetBIOS name queries resolve to the intended target computer.</para>
            </listItem>
          </list>
          <para>
            <embeddedLabel>Network trace method</embeddedLabel> (as parsed by Network Monitor 3.3.1641 with full default parsers enabled)</para>
          <para>The table below shows a synopsis of network traffic exhibited when destination DC1 inbound replicates Active Directory from source DC2.</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>F#</para>
                </TD>
                <TD>
                  <para>SRC</para>
                </TD>
                <TD>
                  <para>DEST</para>
                </TD>
                <TD>
                  <para>Protocol</para>
                </TD>
                <TD>
                  <para>Frame</para>
                </TD>
                <TD>
                  <para>Comment</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>1</para>
                </TD>
                <TD>
                  <para>DC1</para>
                </TD>
                <TD>
                  <para>DC2</para>
                </TD>
                <TD>
                  <para>MSRPC</para>
                </TD>
                <TD>
                  <para>MSRPC:c/o Request: unknown Call=0x5 Opnum=0x3 Context=0x1 Hint=0x90</para>
                </TD>
                <TD>
                  <para>Dest DC RPC call to EPM on source DC over 135</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>2</para>
                </TD>
                <TD>
                  <para>DC2</para>
                </TD>
                <TD>
                  <para>DC1</para>
                </TD>
                <TD>
                  <para>MSRPC</para>
                </TD>
                <TD>
                  <para>MSRPC:c/o Response: unknown Call=0x5 Context=0x1 Hint=0xF4 Cancels=0x0</para>
                </TD>
                <TD>
                  <para>EPM response to RPC caller</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>3</para>
                </TD>
                <TD>
                  <para>DC1</para>
                </TD>
                <TD>
                  <para>DC2</para>
                </TD>
                <TD>
                  <para>MSRPC</para>
                </TD>
                <TD>
                  <para>MSRPC:c/o Bind: UUID{E3514235-4B06-11D1-AB04-00C04FC2DCD2} DRSR(DRSR) Call=0x2 Assoc Grp=0x0 Xmit=0x16D0 Recv=0x16D0</para>
                </TD>
                <TD>
                  <para>RPC bind request to E351 service UUID</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>4</para>
                </TD>
                <TD>
                  <para>DC2</para>
                </TD>
                <TD>
                  <para>DC1</para>
                </TD>
                <TD>
                  <para>MSRPC</para>
                </TD>
                <TD>
                  <para>MSRPC:c/o Bind Ack: Call=0x2 Assoc Grp=0x9E62 Xmit=0x16D0 Recv=0x16D0</para>
                </TD>
                <TD>
                  <para>RPC Bind response</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>5</para>
                </TD>
                <TD>
                  <para>DC1</para>
                </TD>
                <TD>
                  <para>KDC</para>
                </TD>
                <TD>
                  <para>Kerberos v5</para>
                </TD>
                <TD>
                  <para>KerberosV5:TGS Request Realm: CONTOSO.COM Sname: E3514235-4B06-11D1-AB04-00C04FC2DCD2/6f3f96d3-dfbf-4daf-9236-4d6da6909dd2/contoso.com</para>
                </TD>
                <TD>
                  <para>TGS request for replication SPN of source DC. This operation will not appear on the wire of destination DC uses self as KDC.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>6</para>
                </TD>
                <TD>
                  <para>KDC</para>
                </TD>
                <TD>
                  <para>DC1</para>
                </TD>
                <TD>
                  <para>Kerberos v5</para>
                </TD>
                <TD>
                  <para>KerberosV5:TGS Response Cname: CONTOSO-DC1$</para>
                </TD>
                <TD>
                  <para>TGS response to destination DC contoso-dc1. This operation will not appear on the wire of destination DC uses self as KDC.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>7</para>
                </TD>
                <TD>
                  <para>DC1</para>
                </TD>
                <TD>
                  <para>DC2</para>
                </TD>
                <TD>
                  <para>MSRPC</para>
                </TD>
                <TD>
                  <para>MSRPC:c/o Alter Cont: UUID{E3514235-4B06-11D1-AB04-00C04FC2DCD2} DRSR(DRSR) Call=0x2</para>
                </TD>
                <TD>
                  <para>AP request</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>8</para>
                </TD>
                <TD>
                  <para>DC2</para>
                </TD>
                <TD>
                  <para>DC1</para>
                </TD>
                <TD>
                  <para>MSRPC</para>
                </TD>
                <TD>
                  <para>MSRPC:c/o Alter Cont Resp: Call=0x2 Assoc Grp=0x9E62 Xmit=0x16D0 Recv=0x16D0</para>
                </TD>
                <TD>
                  <para>AP response</para>
                </TD>
              </tr>
            </tbody>
          </table>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Drilldown on Frame 7</para>
                </TD>
                <TD>
                  <para>Drilldown on Frame 8</para>
                </TD>
                <TD>
                  <para>Comments</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>MSRPC MSRPC:c/o Alter Cont: UUID{E3514235-4B06-11D1-AB04-00C04FC2DCD2} DRSR(DRSR) Call=0x2</para>
                </TD>
                <TD>
                  <para>MSRPC:c/o Alter Cont Resp: Call=0x2 Assoc Grp=0xC3EA43 Xmit=0x16D0 Recv=0x16D0</para>
                </TD>
                <TD>
                  <para>DC1 connects to AD Replication Service on DC2 over the port returned by the EPM on DC2. </para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Ipv4: Src = x.x.x.245, Dest = x.x.x.35, Next Protocol = TCP, Packet ID =, Total IP Length = 0</para>
                </TD>
                <TD>
                  <para>Ipv4: Src = x.x.x.35, Dest = x.x.x.245, Next Protocol = TCP, Packet ID = 31546, Total IP Length = 278</para>
                </TD>
                <TD>
                  <para>Verify that AD replication source DC (referred to here as the "Dest" computer in 1st column and "Src" computer in column 2 "owns' the IP address cited in the trace (x.x.x.35 in this example).</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Ticket: Realm: CONTOSO.COM, Sname: E3514235-4B06-11D1-AB04-00C04FC2DCD2/6f3f96d3-dfbf-4daf-9236-4d6da6909dd2/contoso.com</para>
                </TD>
                <TD>
                  <para>ErrorCode: KRB_AP_ERR_MODIFIED (41) </para>
                  <para>

Realm: &lt;verify that realm returned by the source DC matches the Kerberos realm intended by the destination DC&gt;. </para>
                  <para>


Sname: &lt;verify that the sName in the AP response matches contains the hostname of the intended source DC and NOT another DC that the destination incorrectly resolved to due to a bad name-to-ip mapping problem.</para>
                </TD>
                <TD>
                  <para>In column 1, note the realm of the target Kerberos realm as "contoso.com" followed by the source DCs Replication SPN ("Sname") which consists of the Active Directory replication service UUID (E351) concatenated with object GUID of the source DCs NTDS Settings object.</para>
                  <para>The GUIDED value "6f3f96d3-dfbf-4daf-9236-4d6da6909dd2" to the right of the E351... replication service UUID is the Object GUID for the source DCs NTDS settings object currently defined in the destination DCs copy of Active Directory. Verify that this object GUID matches the value in the "DSA Object GUID" field when "repadmin /showreps" is run from the console of the source DC).</para>
                  <para>A ping or nslookup of the source DCs fully qualified CNAME concatenated with "_msdcs.&lt;forest root DNS name&gt;" from the console of the destination DC must return the source DCs current IP address:</para>
                  <code>ping 6f3f96d3-dfbf-4daf-9236-4d6da6909dd2._msdcs.contoso.com</code>
                  <code>nslookup -type=cname 6f3f96d3-dfbf-4daf-9236-4d6da6909dd2._msdcs.&lt;forest root domain&gt; &lt;DNS Server IP&gt;</code>
                  <para>In the reply shown in column 2, focus on the "Sname" field and verify that it contains the hostname of the AD replication source DC.</para>
                  <para>Bad name-to-IP mappings <placeholder>could</placeholder> cause the destination DC to connect to a DC in a completely invalid target realm causing the Realm value to be invalid as shown in this case. Bad host-to-IP mappings could cause DC1 to connect to DC3 in the same domain which would still generate KRB_AP_ERR_MODIFIED but the realm name in frame 8 would match the realm in frame 7.</para>
                </TD>
              </tr>
            </tbody>
          </table>
          <para>
            <embeddedLabel>Name to IP mapping verification (without using a network trace)</embeddedLabel>
          </para>
          <para>From the console of the source DC:</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Command</para>
                </TD>
                <TD>
                  <para>Comment</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>IPCONFIG /ALL |MORE</para>
                </TD>
                <TD>
                  <para>Note IP address of NIC used by destination DCs.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>REPADMIN /SHOWREPS |MORE</para>
                </TD>
                <TD>
                  <para>Note value of "DSA Object GUID" which denotes the object GUID for the source DC's NTDS Settings Object in the source DC's copy of Active Directory.</para>
                </TD>
              </tr>
            </tbody>
          </table>
          <para>From the console of the destination DC:</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Command</para>
                </TD>
                <TD>
                  <para>Comment</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>IPCONFIG /ALL |MORE</para>
                </TD>
                <TD>
                  <para>Note the primary, secondary and any tertiary DNS Servers configured that the destination DC could query during DNS lookups.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>REPADMIN /SHOWREPS |MORE</para>
                </TD>
                <TD>
                  <para>In the "Inbound Neighbors" section of the repadmin output, locate the replication status where the destination DC replicates a common partition from the source DC in question. </para>
                  <para>

The "DSA" object GUID" listed for the source DC in the replication status section of the report should match the object GUID listed in the /showreps header when run on the console of the source DC.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>IPCONFIG /FLUSHDNS</para>
                </TD>
                <TD>
                  <para>Clear the DNS Client cache.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Start -&gt;Run -&gt; Notepad %systemroot%\system32\drivers\etc\hosts</para>
                </TD>
                <TD>
                  <para>Check for host to IP mappings referencing the source DCs single label or fully qualified DNS name. Remove if present. Save changes to HOST file. </para>
                  <para>

Run "Nbtstat -R" (upper case "R") to refresh the NetBIOS name cache.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>NSLOOKUP -type=CNAME &lt;object guid of source DCs NTDS Settings object&gt;._msdcs.&lt;forest root DNS name&gt; &lt;primary DNS Server IP </para>
                  <para>

Repeat for each additional DNS Server IP configured on the destination DC. </para>
                  <para>

example: </para>
                  <code>c:\&gt;nslookup -type=cname 8a7baee5-cd81-4c8c-9c0f-b10030574016._msdcs.contoso.com 152.45.42.103</code>
                </TD>
                <TD>
                  <para>Verify that IP returned matches the IP address of target DC listed above recorded from the console of the source DC. 
</para>
                  <para>
Repeat for all DNS Servers IPs configured on destination DC. </para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>nslookup -type=A+AAAA &lt;FQDN of source DC&gt; &lt;DNS Server IP&gt;</para>
                </TD>
                <TD>
                  <para>Check for duplicate host "A" records on all DNS Server IPs configured on the destination DC.</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>nbtstat -A &lt;IP address of DNS Server IP returned by nslookup&gt;</para>
                </TD>
                <TD>
                  <para>Should return name of the source DC.</para>
                </TD>
              </tr>
            </tbody>
          </table>
          <para>Note: A replication request directed to a non-DC (due to a bad name-to-IP mapping) or a DC that does not currently have the E351... service UUID registered with the endpoint mapper will return error 1753: there are no more endpoints available with the endpoint mapper.</para>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>The Kerberos target cannot decrypt Kerberos authenticated data due to a password mismatch</embeddedLabel>
          </para>
          <para>This condition can occur if the password for the source DC differs between the KDC and source DC's copy of Active Directory. The destination DC's copy of the source DC computer account password may be stale if it is not using itself as the KDC. </para>
          <para>Replication failures can prevent DCs from having a current password values for DCs in a given domain. </para>
          <para>Every domain controller runs the KDC service for their domain realm. For same realm transactions, a destination DC <placeholder>favors</placeholder> getting Kerberos tickets from itself but may obtain a ticket from a remote DC. Referrals are used to obtain Kerberos tickets from other realms. </para>
          <para>To quickly identify which KDC a Kerberos client is targeting, open an elevated command prompt and run the following command near to when the SEC_E_WRONG_PRINCIPAL error appears.</para>
          <code>NLTEST /DSGETDC:&lt;DNS domain of target domain&gt; /kdc</code>
          <para>The definitive way to determine which DC a Kerberos client obtained a ticket from is to take a network trace. The lack of Kerberos traffic in a network trace may indicate that the Kerberos client has already acquired tickets, is getting tickets off-the-wire from itself or your network trace application is not properly parsing Kerberos traffic.</para>
          <para>Kerberos tickets for the logged on user account can be purged from an admin privileged CMD prompt using "KLIST purge".</para>
          <para>Kerberos tickets for the system account used by Active Directory replication can be purged <placeholder>without</placeholder> a reboot using "KLIST -li 0x3e7 purge".</para>
          <para>DCs can be made to use other DCs by stopping the KDC service on a local or remote DC.</para>
          <para>Use REPADIN /SHOWOBJMETA to check for obvious version number differences in password-related attributes (dBCSPwd, UnicodePWD, NtPwdHistory, PwdLastSet, lmPwdHistory) for the source DC and destination DC's copy of Active Directory </para>
          <code>C:\&gt;repadmin /showobjmeta &lt;source DC&gt; &lt;DN path of source DC computer account&gt;</code>
          <code>C:\&gt;repadmin /showobjmeta &lt;KDC selected by destination DC&gt; &lt;DN path of source DC computer account&gt;</code>
          <para>To reset DC machine account passwords, run the following command at an elevated command prompt: </para>
          <code>netdom resetpwd /server:&lt;DC to direct password change to&gt; /userd:&lt;user name&gt; /passwordd:&lt;password&gt;</code>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_MoreInfo">
    <title>More Information</title>
    <content />
    <sections>
      <section>
        <title>Repro steps for bad host to IP mapping causing destination DC to pull from wrong source</title>
        <content>
          <list class="ordered">
            <listItem>
              <para>Promote dc1 + DC2 + DC3 in contoso.com domain. End-to-end replication occurs without error.</para>
            </listItem>
            <listItem>
              <para>Stop the KDC on DC1 and DC2 to force off-box Kerberos traffic that can be observed in network trace. End-to-end replication occurs without error.</para>
            </listItem>
            <listItem>
              <para>Create Host file entry for DC2 pointing to IP address of a DC in a remote forest simulating a bad host to IP mapping in a host "A" / "AAAA" record or perhaps a stale NTDS Settings object in the destination DC's copy of Active Directory.</para>
            </listItem>
            <listItem>
              <para>Start Active Directory Sites and Services on the console of DC1. Right-click DC1's inbound connection object from DC2 and note replication error "the target account name is incorrect."</para>
            </listItem>
          </list>
        </content>
      </section>
      <section>
        <title>Repro steps for source DC password mismatch between KDC and source DC</title>
        <content>
          <list class="ordered">
            <listItem>
              <para>Promote dc1 + DC2 + DC3 in contoso.com domain. End-to-end replication occurs without error.</para>
            </listItem>
            <listItem>
              <para>Stop the KDC on DC1 and DC2 to force off-box Kerberos traffic that can be observed in network trace. End-to-end replication occurs without error.</para>
            </listItem>
            <listItem>
              <para>Disabling inbound replication on KDC DC3 simulating a replication failure on the KDC.</para>
            </listItem>
            <listItem>
              <para>Reset the computer account password on DC2 three or more times such that DC1 and DC2 have DC2 current password.</para>
            </listItem>
            <listItem>
              <para>Start Active Directory Sites and Services on the console of DC1. Right click DC1's inbound connection object from DC2 and note replication error "the target account name is incorrect."</para>
            </listItem>
          </list>
        </content>
      </section>
      <section>
        <title>DS RPC client logging</title>
        <content>
          <para>Set NTDSDiagnostics LoggingsDS RPC Client = 3. Trigger replication. Look for Task Category Event 1962 + 1963. Note the fully qualified cname cited in the "directory service" field. Destination DC should be able to ping this record and have the returned address map to the current IP address of the source DC. </para>
        </content>
      </section>
      <section>
        <title>Kerberos Workflow</title>
        <content>
          <para>Workflow</para>
          <list class="ordered">
            <listItem>
              <para>Client Computer calls <externalLink><linkText>IntializeSecurityContext</linkText><linkUri>http://msdn.microsoft.com/en-us/library/aa375506(VS.85).aspx</linkUri></externalLink> and specifies the Negotiate security support provider (SSP).</para>
            </listItem>
            <listItem>
              <para>The client contacts the KDC with its TGT and requests a TGS Ticket for the target DC.</para>
            </listItem>
            <listItem>
              <para>The KDC searches the Global Catalog for a source (either e351 or hostname) in destination DCs realm.</para>
            </listItem>
            <listItem>
              <para>If the target DC is in the destination DCs realm, the KDC hands the client a service ticket.</para>
            </listItem>
            <listItem>
              <para>If the target DC is in a different realm, the KDC hands the client a referral ticket.</para>
            </listItem>
            <listItem>
              <para>The client contacts a KDC in the target DCs domain requesting a service ticket.</para>
            </listItem>
            <listItem>
              <para>If the source DC's SPN does not exist in the realm, you get an error.</para>
            </listItem>
            <listItem>
              <para>The destination DC contacts the target and presents its ticket.</para>
            </listItem>
            <listItem>
              <para>If the target DC owns the name in the ticket and can decrypt it, the authentication works.</para>
            </listItem>
            <listItem>
              <para>If the target DC hosts the RPC server service UUID, then the on-wire Kerberos error "KRB_AP_ERR_NOT_US or KRB_AP_ERR_MODIFIED gets remapped to -2146893022 decimal / 0x80090322 / SEC_E_WRONG_PRINCIPAL / "The target principal name is incorrect."</para>
            </listItem>
          </list>
          <para>See the <externalLink><linkText>Troubleshooting Kerberos Errors</linkText><linkUri>http://www.microsoft.com/download/en/details.aspx?displaylang=en&amp;id=21820</linkUri></externalLink> white paper for additional information</para>
        </content>
      </section>
    </sections>
  </section>
  <relatedTopics>
    <externalLink>
      <linkText>Troubleshooting Active Directory operations that fail with error -2146893022: The target principal name is incorrect.</linkText>
      <linkUri>http://support.microsoft.com/kb/2090913</linkUri>
    </externalLink>
    <externalLink>
      <linkText>How the Active Directory Replication Model Works</linkText>
      <linkUri>http://technet.microsoft.com/library/cc772726(WS.10).aspx</linkUri>
    </externalLink>
<externalLink><linkText>repsFrom, RepsFrom</linkText><linkUri>http://msdn.microsoft.com/library/cc228409(PROT.13).aspx</linkUri></externalLink></relatedTopics>
</developerConceptualDocument>


