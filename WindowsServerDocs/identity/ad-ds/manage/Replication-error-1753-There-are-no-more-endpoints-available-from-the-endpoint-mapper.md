---
ms.assetid: 0f21951c-b1bf-43bb-a329-bbb40c58c876
title: Replication error 1753 There are no more endpoints available from the endpoint mapper
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Replication error 1753 There are no more endpoints available from the endpoint mapper

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="https://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="https://www.w3.org/1999/xlink" xmlns:xsi="https://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This topic explains symptoms, causes and how to resolve Active Directory replication error 8524 The DSA operation is unable to proceed because of a DNS lookup failure.</para>
    <list class="bullet">
      <listItem>
        <para>
          <link xlink:href="f7022f0d-0099-410c-8178-c654e624bc42#BKMK_Symptoms">Symptoms</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="f7022f0d-0099-410c-8178-c654e624bc42#BKMK_Cause">Cause</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="f7022f0d-0099-410c-8178-c654e624bc42#BKMK_Resolutions">Resolutions</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="f7022f0d-0099-410c-8178-c654e624bc42#BKMK_MoreInfo">More information</link>
        </para>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_Symptoms">
    <title>Symptoms</title>
    <content>
      <para>This article describes symptoms, cause and resolution steps for Active Directory operations that fail with Win32 error 1753: &quot;There are no more endpoints available from the endpoint mapper.&quot;</para>
      <list class="ordered">
        <listItem>
          <para>DCDIAG reports that the Connectivity test, Active Directory Replications test or KnowsOfRoleHolders test has failed with error 1753: &quot;There are no more endpoints available from the endpoint mapper.&quot;</para>
          <code>Testing server: &lt;site&gt;&lt;DC Name&gt;
Starting test: Connectivity
* Active Directory LDAP Services Check
* Active Directory RPC Services Check
[&lt;DC Name&gt;] <codeFeaturedElement>DsBindWithSpnEx() failed with error 1753,
There are no more endpoints available from the endpoint mapper..</codeFeaturedElement>
Printing RPC Extended Error Info:
Error Record 1, ProcessID is &lt;process ID&gt; (DcDiag) 
System Time is: &lt;date&gt; &lt;time&gt;
Generating component is 2 (RPC runtime)
Status is 1753: There are no more endpoints available from the endpoint mapper. Detection location is 500
NumberOfParameters is 4
Unicode string: ncacn_ip_tcp
Unicode string: &lt;source DC object GUID&gt;._msdcs.contoso.com
Long val: -481213899
Long val: 65537
Error Record 2, ProcessID is 700 (DcDiag) 
System Time is: &lt;date&gt; &lt;time&gt;
Generating component is 2 (RPC runtime)
<codeFeaturedElement>Status is 1753: There are no more endpoints available from the endpoint mapper.</codeFeaturedElement>
NumberOfParameters is 1
Unicode string: 1025
[Replications Check,&lt;DC Name&gt;] A recent replication attempt failed:
From &lt;source DC&gt; to &lt;destination DC&gt;
Naming Context: &lt;DN path of directory partition&gt;
The replication generated an error <codeFeaturedElement>(1753):
There are no more endpoints available from the endpoint mapper.</codeFeaturedElement> 
The failure occurred at &lt;date&gt; &lt;time&gt;.
The last success occurred at &lt;date&gt; &lt;time&gt;.
3 failures have occurred since the last success.
The directory on &lt;DC name&gt; is in the process.
of starting up or shutting down, and is not available.
Verify machine is not hung during boot.
</code>
        </listItem>
<listItem><para>REPADMIN.EXE reports that replication attempt has failed with status 1753.</para><para>REPADMIN commands that commonly cite the 1753 status include but are not limited to:</para><table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11"><tbody><tr><TD><list class="bullet"><listItem><para>REPADMIN /REPLSUM</para></listItem><listItem><para>REPADMIN /SHOWREPL</para></listItem></list></TD><TD><list class="bullet"><listItem><para>REPADMIN /SHOWREPS</para></listItem><listItem><para>REPADMIN /SYNCALL</para></listItem></list></TD></tr></tbody></table><para>Sample output from &quot;REPADMIN /SHOWREPS&quot; depicting inbound replication from CONTOSO-DC2 to CONTOSO-DC1 failing with the &quot;replication access was denied&quot; error is shown below:</para><code>Default-First-Site-NameCONTOSO-DC1
DSA Options: IS_GC 
Site Options: (none)
DSA object GUID: b6dc8589-7e00-4a5d-b688-045aef63ec01
DSA invocationID: b6dc8589-7e00-4a5d-b688-045aef63ec01
==== INBOUND NEIGHBORS ======================================
DC=contoso,DC=com
Default-First-Site-NameCONTOSO-DC2 via RPC
DSA object GUID: 74fbe06c-932c-46b5-831b-af9e31f496b2
Last attempt @ &lt;date&gt; &lt;time&gt; failed, <codeFeaturedElement>result 1753 (0x6d9):
There are no more endpoints available from the endpoint mapper.</codeFeaturedElement>
&lt;#&gt; consecutive failure(s).
Last success @ &lt;date&gt; &lt;time&gt;.

</code></listItem><listItem><para>The <ui>Check Replication Topology</ui> command in Active Directory Sites and Services returns &quot;There are no more endpoints available from the endpoint mapper.&quot;</para><para>Right-clicking on the connection object from a source DC and choosing <ui>Check Replication Topology</ui> fails with &quot;There are no more endpoints available from the endpoint mapper.&quot; The on-screen error message is shown below:</para><para>Dialog title text: Check Replication Topology</para><para>Dialog message text: </para><para>The following error occurred during the attempt to contact the domain controller: There are no more endpoints available from the endpoint mapper.</para></listItem><listItem><para>The <ui>Replicate now</ui> command in Active Directory Sites and Services returns &quot;there are no more endpoints available from the endpoint mapper.&quot;</para><para>Right-clicking on the connection object from a source DC and choosing <ui>Replicate now</ui> fails with &quot;There are no more endpoints available from the endpoint mapper.&quot; The on-screen error message is shown below:</para><para>Dialog title text: Replicate Now</para><para>Dialog message text: The following error occurred during the attempt to synchronize naming context &lt;%directory partition name%&gt; from Domain Controller &lt;Source DC&gt; to Domain Controller &lt;Destination DC&gt;:</para><para>

There are no more endpoints available from the endpoint mapper.</para><para>The operation will not continue</para></listItem><listItem><para>NTDS KCC, NTDS General or Microsoft-Windows-ActiveDirectory_DomainService events with the -2146893022 status are logged in the Directory Services log in Event Viewer.</para><para>Active Directory events that commonly cite the -2146893022 status include but are not limited to:</para><table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11"><thead><tr><TD><para>Event ID</para></TD><TD><para>Event Source</para></TD><TD><para>Event String</para></TD></tr></thead><tbody><tr><TD><para>1655</para></TD><TD><para>NTDS General</para></TD><TD><para>Active Directory attempted to communicate with the following global catalog and the attempts were unsuccessful.</para></TD></tr><tr><TD><para>1925</para></TD><TD><para>NTDS KCC</para></TD><TD><para>The attempt to establish a replication link for the following writable directory partition failed.</para></TD></tr><tr><TD><para>1265</para></TD><TD><para>NTDS KCC</para></TD><TD><para>An attempt by the Knowledge Consistency Checker (KCC) to add a replication agreement for the following directory partition and source domain controller failed.</para></TD></tr></tbody></table></listItem>
</list>
    </content>
  </section>
  <section address="BKMK_Cause">
    <title>Cause</title>
    <content>
      <para>The diagram below shows the RPC workflow starting with the registration of the server application with the RPC Endpoint Mapper (EPM) in step 1 to the passing of data from the RPC client to the client application in step 7. </para>
      <para>&lt;ADDS_RPCWorkflow&gt;</para>
      <para>Steps 1 through 7 map to the following operations:</para>
      <list class="ordered">
        <listItem>
          <para>Server app registers its endpoints with the RPC Endpoint Mapper (EPM) </para>
        </listItem>
        <listItem>
          <para>Client makes an RPC call (on behalf of a user, OS or application initiated operation) </para>
        </listItem>
        <listItem>
          <para>Client side RPC contacts the target computers EPM and ask for the endpoint to complete the client call </para>
        </listItem>
        <listItem>
          <para>Server Machine&#39;s EPM responds with an endpoint </para>
        </listItem>
        <listItem>
          <para>Client side RPC contacts the server app </para>
        </listItem>
        <listItem>
          <para>Server app executes the call, returns the result to the client RPC </para>
        </listItem>
        <listItem>
          <para>Client side RPC passes the result back to the client app</para>
        </listItem>
      </list>
      <para>Failure 1753 is generated by a failure between steps #3 and #4. Specifically, error 1753 means that the RPC client (destination DC) was able to contact the RPC Server (source DC) over port 135 but the EPM on the RPC Server (source DC) was unable to locate the RPC application of interest and returned server side error 1753. The presence of the 1753 error indicates that the RPC client (destination DC) received the server side error response from the RPC Server (AD replication source DC) over the network. </para>
      <para>Specific root causes for the 1753 error include: </para>
      <list class="ordered">
        <listItem>
          <para>The server app never started (i.e. Step #1 in the &quot;more information&quot; diagram located above was never attempted).</para>
        </listItem>
        <listItem>
          <para>The server app started but there was some failure during initialization that prevented it from registering with the RPC Endpoint Mapper (i.e. Step #1 in the &quot;more information&quot; diagram above was attempted but failed).</para>
        </listItem>
        <listItem>
          <para>The server app started but subsequently died. (i.e. Step #1 in the &quot;more information&quot; diagram above was completed successfully, but was undone later because the server died).</para>
        </listItem>
        <listItem>
          <para>The server app manually unregistered its endpoints (similar to 3 but intentional. Not likely but included for completeness.)</para>
        </listItem>
        <listItem>
          <para>The RPC client (destination DC) contacted a different RPC server than the intended one due to a Name to IP mapping error in DNS, WINS or host/Lmhosts file.</para>
        </listItem>
      </list>
      <para>Error 1753 is NOT caused by: </para>
      <list class="bullet">
        <listItem>
          <para>A lack of network connectivity between the RPC client (destination DC) and RPC Server (source DC) over port 135</para>
        </listItem>
        <listItem>
          <para>A lack of network connectivity between the RPC server (source DC) using port 135 and the RPC client (destination DC) over the ephemeral port. </para>
        </listItem>
        <listItem>
          <para>A password mismatch or the inability by the source DC to decrypt a Kerberos encrypted packet </para>
        </listItem>
      </list>
      <para> </para>
    </content>
  </section>
  <section address="BKMK_Resolutions">
    <title>Resolutions</title>
    <content>
      <list class="ordered">
        <listItem>
          <para>
            <embeddedLabel>Verify that the service registering its service with the endpoint mapper has started</embeddedLabel>
          </para>
          <para>For Windows 2000 and Windows Server 2003 DCs: ensure that the source DC is booted into normal mode. </para>
          <para>
For Windows Server 2008 or Windows Server 2008 R2: from the console of the source DC, start Services Manager (services.msc) and verify that the <embeddedLabel>Active Directory Domain Services</embeddedLabel> service is running. </para>
        </listItem>
        <listItem>
          <para>
            <embeddedLabel>Verify that RPC client (destination DC) connected to the intended RPC Server (source DC)</embeddedLabel>
          </para>
          <para>All DCs in a common Active Directory forest register a domain controller CNAME record in the _msdcs.&lt;forest root domain&gt; DNS zone regardless of what domain they reside in within the forest. The DC CNAME record is derived from the <embeddedLabel>objectGUID</embeddedLabel> attribute of the NTDS Settings object for each domain controller. </para>
          <para>When performing replication-based operations, a destination DC queries DNS for the source DCs CNAME record. The CNAME record contains the source DC fully qualified computer name which is used to derive the source DCs IP address via DNS client cache lookup, Host / LMHost file lookup, host A / AAAA record in DNS, or WINS. </para>
          <para>Stale NTDS Settings objects and bad name-to-IP mappings in DNS, WINS, Host and LMHOST files may cause the RPC client (destination DC) to connect to the wrong RPC Server (Source DC). Furthermore, the bad name-to-IP mapping may cause the RPC client (destination DC) to connect to a computer that does not even have the RPC Server Application of interest (the Active Directory role in this case) installed. (Example: a stale host record for DC2 contains the IP address of DC3 or a member computer). </para>
          <para>Verify that the objectGUID for the source DC that exists in the destination DCs copy of Active Directory matches the source DC objectGUID stored in the source DCs copy of Active Directory. If there is a discrepancy, use repadmin /showobjmeta on the ntds settings object to see which one corresponds to last promotion of the source DC (hint: compare date stamps for the NTDS Settings object create date from /showobjmeta against the last promotion date in the source DCs dcpromo.log file. You may have to use the last modify / create date of the DCPROMO.LOG file itself). If the object GUIDs are not identical, the destination DC likely has a stale NTDS Settings object for the source DC whose CNAME record refers to a host record with a bad name to IP mapping. </para>
          <para>On the destination DC, run IPCONFIG /ALL to determine which DNS Servers the destination DC is using for name resolution:</para>
          <code>c:&gt;ipconfig /all</code>
          <para>On the destination DC, run NSLOOKUP against the source DCs fully qualified DC CNAME record:</para>
          <code>c:&gt;nslookup -type=cname &lt;fully qualified cname of source DC&gt; &lt;destination DCs primary DNS Server IP &gt;
c:&gt;nslookup -type=cname &lt;fully qualified cname of source DC&gt; &lt;destination DCs secondary DNS Server IP&gt;</code>
          <para>Verify that the IP address returned by NSLOOKUP &quot;owns&quot; the host name / security identity of the source DC:</para>
          <code>C:&gt;NBTSTAT -A &lt;IP address returned by NSLOOKUP in the step above&gt;</code>
          <para>or</para>
          <para>Log onto the console of the source DC, run &quot;IPCONFIG&quot; from the CMD prompt and verify that the source DC owns the IP address returned by the NSLOOKUP command above</para>
          <para>Check for stale / duplicate host to IP mappings in DNS</para>
          <code>NSLOOKUP -type=hostname &lt;single label hostname of source DC&gt; &lt;primary DNS Server IP on destination DC&gt;
NSLOOKUP -type=hostname &lt;single label hostname of source DC&gt; &lt;secondary DNS Server IP on destination DC&gt;

NSLOOKUP -type=hostname &lt;fully qualified computer name of source DC&gt; &lt;primary DNS Server IP on destination DC&gt;
NSLOOKUP -type=hostname &lt;fully qualified computer name of source DC&gt; &lt;secondary DNS Server IP on dest. DC&gt;</code>
<para>If invalid IP addresses exist in host records, investigate whether DNS scavenging is enabled and properly configured. </para><para>If the tests above or a network trace doesn&#39;t show a name query returning an invalid IP address, consider stale entries in HOST files, LMHOSTS files and WINS Servers. Note that DNS Servers can also be configured to perform WINS fallback name resolution.</para>
</listItem>
        <listItem>
          <para>
            <embeddedLabel>Verify that the server application (Active Directory et al) has registered with the endpoint mapper on the RPC server (source DC)</embeddedLabel>
          </para>
          <para>Active Directory uses a mix of well-known and dynamically registered ports. This table lists well known ports and protocols used by Active Directory domain controllers.</para>
          <table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>RPC Server Application</para>
                </TD>
                <TD>
                  <para>Port</para>
                </TD>
                <TD>
                  <para>TCP</para>
                </TD>
                <TD>
                  <para>UDP</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>DNS server</para>
                </TD>
                <TD>
                  <para>53</para>
                </TD>
                <TD>
                  <para>X</para>
                </TD>
                <TD>
                  <para>X</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Kerberos</para>
                </TD>
                <TD>
                  <para>88</para>
                </TD>
                <TD>
                  <para>X</para>
                </TD>
                <TD>
                  <para>X</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>LDAP server</para>
                </TD>
                <TD>
                  <para>389</para>
                </TD>
                <TD>
                  <para>X</para>
                </TD>
                <TD>
                  <para>X</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Microsoft-DS</para>
                </TD>
                <TD>
                  <para>445</para>
                </TD>
                <TD>
                  <para>X</para>
                </TD>
                <TD>
                  <para>X</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>LDAP SSL</para>
                </TD>
                <TD>
                  <para>636</para>
                </TD>
                <TD>
                  <para>X</para>
                </TD>
                <TD>
                  <para>X</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Global Catalog Server</para>
                </TD>
                <TD>
                  <para>3268</para>
                </TD>
                <TD>
                  <para>X</para>
                </TD>
                <TD>
                  <para />
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Global Catalog Server</para>
                </TD>
                <TD>
                  <para>3269</para>
                </TD>
                <TD>
                  <para>X</para>
                </TD>
                <TD>
                  <para />
                </TD>
              </tr>
            </tbody>
          </table>
          <para>Well-known ports are NOT registered with the endpoint mapper. </para>
          <para>Active Directory and other applications also register services that receive dynamically assigned ports in the RPC ephemeral port range. Such RPC server applications are dynamically assigned TCP ports between 1024 and 5000 on Windows 2000 and Windows Server 2003 computers and ports between 49152 and 65535 range on Windows Server 2008 and Windows Server 2008 R2 computers. The RPC port used by replication can be hard-coded in the registry using the steps documented in <externalLink><linkText>KB article 224196</linkText><linkUri><a href="https://support.microsoft.com/kb/224196" data-raw-source="https://support.microsoft.com/kb/224196">https://support.microsoft.com/kb/224196</a></linkUri></externalLink>. Active Directory continues to register with the EPM when configured to use a hard coded port. </para>
          <para>Verify that the RPC Server application of interest has registered itself with the RPC endpoint mapper on the RPC Server (the source DC in the case of AD replication). </para>
          <para>There are a number of ways to accomplish this task but one is to install and run PORTQRY from an admin privileged CMD prompt on the console of the source DC using the syntax: </para>
          <code>c:&amp;gt;portquery -n &lt;source DC&gt; -e 135 &gt;file.txt</code>
          <para>In the portqry output, note the port numbers dynamically registered by the &quot;MS NT Directory DRS Interface&quot; (UUID = 351...) for the <embeddedLabel>ncacn_ip_tcp protocol</embeddedLabel>. The snippet below shows sample portquery output from a Windows Server 2008 R2 DC and the UUID / protocol pair specifically used by Active Directory highlighted in <embeddedLabel>bold</embeddedLabel>: </para>
          <code>UUID: e3514235-4b06-11d1-ab04-00c04fc2dcd2 MS NT Directory DRS Interface
ncacn_np:CONTOSO-DC01[\pipe\lsass] 
UUID: e3514235-4b06-11d1-ab04-00c04fc2dcd2 MS NT Directory DRS Interface
ncacn_np:CONTOSO-DC01[\PIPE\protected_storage] 
<codeFeaturedElement>UUID: e3514235-4b06-11d1-ab04-00c04fc2dcd2 MS NT Directory DRS Interface
ncacn_ip_tcp:CONTOSO-DC01[49156]</codeFeaturedElement> 
UUID: e3514235-4b06-11d1-ab04-00c04fc2dcd2 MS NT Directory DRS Interface
ncacn_http:CONTOSO-DC01[49157] 
UUID: e3514235-4b06-11d1-ab04-00c04fc2dcd2 MS NT Directory DRS Interface
ncacn_http:CONTOSO-DC01[6004]</code>
          <para />
        </listItem>
        <listItem>
          <para>Other possible ways to resolve this error:</para>
          <list class="ordered">
            <listItem>
              <para>Verify that the source DC is booted in normal mode and that the OS and DC role on the source DC have fully started.</para>
            </listItem>
            <listItem>
              <para>Verify that the Active Directory Domain Service is running. If the service is currently stopped or was not configured with default startup values, reset the default startup values, reboot the modified DC then retry the operation.</para>
            </listItem>
            <listItem>
              <para>Verify that the startup value and service status for RPC service and RPC Locator is correct for OS version of the RPC Client (destination DC) and RPC Server (source DC). If the service is currently stopped or was not configured with default startup values, reset the default startup values, reboot the modified DC then retry the operation.</para>
              <para>In addition, ensure that the service context matches default settings listed in the following table.</para>
              <table xmlns:caps="https://schemas.microsoft.com/build/caps/2013/11">
                <thead>
                  <tr>
                    <TD>
                      <para>Service</para>
                    </TD>
                    <TD>
                      <para>Default status (Startup type) in Windows Server 2003 and later </para>
                    </TD>
                    <TD>
                      <para>Default status (Startup type) in Windows Server 2000</para>
                    </TD>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <TD>
                      <para>Remote Procedure Call</para>
                    </TD>
                    <TD>
                      <para>Started (Automatic)</para>
                    </TD>
                    <TD>
                      <para>Started (Automatic)</para>
                    </TD>
                  </tr>
                  <tr>
                    <TD>
                      <para>Remote Procedure Call Locator</para>
                    </TD>
                    <TD>
                      <para>Null or Stopped (Manual)</para>
                    </TD>
                    <TD>
                      <para>Started (Automatic)</para>
                    </TD>
                  </tr>
                </tbody>
              </table>
            </listItem>
            <listItem>
              <para>Verify that the size of the dynamic port range has not been constrained. The Windows Server 2008 and Windows Server 2008 R2 NETSH syntax to enumerate the RPC port range is shown below:</para>
              <code>&gt;netsh int ipv4 show dynamicport tcp
&gt;netsh int ipv4 show dynamicport udp
&gt;netsh int ipv6 show dynamicport tcp
&gt;netsh int ipv6 show dynamicport udp</code>
            </listItem>
            <listItem>
              <para>Verify that hard coded port definitions defined in KB 224196 fall within the dynamic port range for source DCs OS version.</para>
              <para>Review <externalLink><linkText>KB article 224196</linkText><linkUri><a href="https://support.microsoft.com/kb/224196" data-raw-source="https://support.microsoft.com/kb/224196">https://support.microsoft.com/kb/224196</a></linkUri></externalLink> and ensure that the hard coded port falls within the ephemeral port range for the source DC&#39;s operating system version.</para>
            </listItem>
            <listItem>
              <para>Verify that the ClientProtocols key exists under HKLM\Software\Microsoft\Rpc and contains the following 5 default values:</para>
              <code>ncacn_http REG_SZ rpcrt4.dll
ncacn_ip_tcp REG_SZ rpcrt4.dll
<codeFeaturedElement>ncacn_nb_tcp REG_SZ rpcrt4.dll</codeFeaturedElement>
ncacn_np REG_SZ rpcrt4.dll
ncacn_ip_udp REG_SZ rpcrt4.dll</code>
            </listItem>
          </list>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_MoreInfo">
    <title>More information</title>
    <content>
      <para>
        <embeddedLabel>Example of a bad name to IP mapping causing RPC error 1753 vs. -2146893022: the target principal name is incorrect</embeddedLabel>
      </para>
      <para>The contoso.com domain consists of DC1 and DC2 with IP addresses x.x.1.1 and x.x.1.2. The host &quot;A&quot; / &quot;AAAA&quot; records for DC2 are correctly registered on all of the DNS Servers configured for DC1. In addition, the HOSTS file on DC1 contains an entry mapping DC2s fully qualified hostname to IP address x.x.1.2. Later, DC2&#39;s IP address changes from X.X.1.2 to X.X.1.3 and a new member computer is joined to the domain with IP address x.x.1.2. AD Replication attempts triggered by the <ui>Replicate now</ui> command in Active Directory Sites and Services snap-in fails with error 1753 as shown in the trace below:</para>
      <code>F# SRC    DEST    Operation 
1 x.x.1.1 x.x.1.2 ARP:Request, x.x.1.1 asks for x.x.1.2
2 x.x.1.2 x.x.1.1 ARP:Response, x.x.1.2 at 00-13-72-28-C8-5E
3 x.x.1.1 x.x.1.2 TCP:Flags=......S., SrcPort=50206, DstPort=DCE endpoint resolution(135)
4 x.x.1.2 x.x.1.1 ARP:Request, x.x.1.2 asks for x.x.1.1
5 x.x.1.1 x.x.1.2 ARP:Response, x.x.1.1 at 00-15-5D-42-2E-00
6 x.x.1.2 x.x.1.1 TCP:Flags=...A..S., SrcPort=DCE endpoint resolution(135)
7 x.x.1.1 x.x.1.2 TCP:Flags=...A...., SrcPort=50206, DstPort=DCE endpoint resolution(135)
8 x.x.1.1 x.x.1.2 MSRPC:c/o Bind: UUID{E1AF8308-5D1F-11C9-91A4-08002B14A0FA} EPT(EPMP) 
9 x.x.1.2 x.x.1.1 MSRPC:c/o Bind Ack: Call=0x2 Assoc Grp=0x5E68 Xmit=0x16D0 Recv=0x16D0 
<codeFeaturedElement>10</codeFeaturedElement> x.x.1.1 x.x.1.2 EPM:Request: ept_map: NDR, DRSR(DRSR) {E3514235-4B06-11D1-AB04-00C04FC2DCD2} [DCE endpoint resolution(135)]
<codeFeaturedElement>11</codeFeaturedElement> x.x.1.2 x.x.1.1 EPM:Response: ept_map: 0x16C9A0D6 - EP_S_NOT_REGISTERED
</code>
      <para>At frame <embeddedLabel>10</embeddedLabel>, the destination DC queries the source DCs end point mapper over port 135 for the Active Directory replication service class UUID E351... </para>
      <para>In frame <embeddedLabel>11</embeddedLabel>, the source DC, in this case a member computer that does not yet host the DC role and therefore has not registered the E351... UUID for the Replication service with its local EPM responds with symbolic error EP_S_NOT_REGISTERED which maps to decimal error 1753, hex error 0x6d9 and friendly error &quot;there are no more endpoints available from the endpoint mapper&quot;.</para>
      <para>Later, the member computer with IP address x.x.1.2 gets promoted as a replica &quot;MayberryDC&quot; in the contoso.com domain. Again, the <ui>Replicate now</ui> command is used to trigger replication but this time fails with the on-screen error &quot;The target principal name is incorrect.&quot; The computer whose network adapter is assigned the IP address x.x.1.2 <placeholder>is</placeholder> a domain controller, is currently booted into normal mode and has registered the E351... replication service UUID with its local EPM but it does not own the name or security identity of DC2 and cannot decrypt the Kerberos request from DC1 so the request now fails with error &quot;The target principal name is incorrect.&quot; The error maps to decimal error -2146893022 / hex error 0x80090322. </para>
      <para>Such invalid host-to-IP mappings could be caused by stale entries in host / lmhost files, host A / AAAA registrations in DNS, or WINS. </para>
      <para>Summary: This example failed because an invalid host-to-IP mapping (in the HOST file in this case) caused the destination DC to resolve to a &quot;source&quot; DC that did not have the Active Directory Domain Services service running (or even installed for that matter) so the replication SPN was not yet registered and the source DC returned error 1753. In the second case, an invalid host-to-IP mapping (again in the HOST file) caused the destination DC to connect to a DC that had registered the E351... replication SPN but that source had a different hostname and security identity than the intended source DC so the attempts failed with error -2146893022: The target principal name is incorrect.</para>
    </content>
  </section>
  <relatedTopics>
    <externalLink>
      <linkText>Troubleshooting Active Directory operations that fail with error 1753: There are no more endpoints available from the endpoint mapper.</linkText>
      <linkUri><a href="https://support.microsoft.com/kb/2089874" data-raw-source="https://support.microsoft.com/kb/2089874">https://support.microsoft.com/kb/2089874</a></linkUri>
    </externalLink>
<externalLink><linkText>KB article 839880 Troubleshooting RPC Endpoint Mapper errors using the Windows Server 2003 Support Tools from the product CD</linkText><linkUri><a href="https://support.microsoft.com/kb/839880" data-raw-source="https://support.microsoft.com/kb/839880">https://support.microsoft.com/kb/839880</a></linkUri></externalLink>
<externalLink><linkText>KB article 832017 Service overview and network port requirements for the Windows Server system</linkText><linkUri><a href="https://support.microsoft.com/kb/832017/" data-raw-source="https://support.microsoft.com/kb/832017/">https://support.microsoft.com/kb/832017/</a></linkUri></externalLink>
<externalLink><linkText>KB article 224196 Restricting Active Directory replication traffic and client RPC traffic to a specific port</linkText><linkUri><a href="https://support.microsoft.com/kb/224196/" data-raw-source="https://support.microsoft.com/kb/224196/">https://support.microsoft.com/kb/224196/</a></linkUri></externalLink>
<externalLink><linkText>KB article 154596 How to configure RPC dynamic port allocation to work with firewalls</linkText><linkUri><a href="https://support.microsoft.com/kb/154596" data-raw-source="https://support.microsoft.com/kb/154596">https://support.microsoft.com/kb/154596</a></linkUri></externalLink><externalLink><linkText>How RPC Works</linkText><linkUri><a href="https://msdn.microsoft.com/library/aa373935(VS.85).aspx" data-raw-source="https://msdn.microsoft.com/library/aa373935(VS.85).aspx">https://msdn.microsoft.com/library/aa373935(VS.85).aspx</a></linkUri></externalLink><externalLink><linkText>How the Server Prepares for a Connection</linkText><linkUri><a href="https://msdn.microsoft.com/library/aa373938(VS.85).aspx" data-raw-source="https://msdn.microsoft.com/library/aa373938(VS.85).aspx">https://msdn.microsoft.com/library/aa373938(VS.85).aspx</a></linkUri></externalLink>
<externalLink><linkText>How the Client Establishes a Connection</linkText><linkUri><a href="https://msdn.microsoft.com/library/aa373937(VS.85).aspx" data-raw-source="https://msdn.microsoft.com/library/aa373937(VS.85).aspx">https://msdn.microsoft.com/library/aa373937(VS.85).aspx</a></linkUri></externalLink><externalLink><linkText>Registering the Interface</linkText><linkUri><a href="https://msdn.microsoft.com/library/aa375357(VS.85).aspx" data-raw-source="https://msdn.microsoft.com/library/aa375357(VS.85).aspx">https://msdn.microsoft.com/library/aa375357(VS.85).aspx</a></linkUri></externalLink><externalLink><linkText>Making the Server Available on the Network</linkText><linkUri><a href="https://msdn.microsoft.com/library/aa373974(VS.85).aspx" data-raw-source="https://msdn.microsoft.com/library/aa373974(VS.85).aspx">https://msdn.microsoft.com/library/aa373974(VS.85).aspx</a></linkUri></externalLink><externalLink><linkText>Registering Endpoints</linkText><linkUri><a href="https://msdn.microsoft.com/library/aa375255(VS.85).aspx" data-raw-source="https://msdn.microsoft.com/library/aa375255(VS.85).aspx">https://msdn.microsoft.com/library/aa375255(VS.85).aspx</a></linkUri></externalLink><externalLink><linkText>Listening for Client Calls</linkText><linkUri><a href="https://msdn.microsoft.com/library/aa373966(VS.85).aspx" data-raw-source="https://msdn.microsoft.com/library/aa373966(VS.85).aspx">https://msdn.microsoft.com/library/aa373966(VS.85).aspx</a></linkUri></externalLink><externalLink><linkText>How the Client Establishes a Connection</linkText><linkUri><a href="https://msdn.microsoft.com/library/aa373937(VS.85).aspx" data-raw-source="https://msdn.microsoft.com/library/aa373937(VS.85).aspx">https://msdn.microsoft.com/library/aa373937(VS.85).aspx</a></linkUri></externalLink><externalLink><linkText>Restricting Active Directory replication traffic and client RPC traffic to a specific port</linkText><linkUri><a href="https://support.microsoft.com/kb/224196" data-raw-source="https://support.microsoft.com/kb/224196">https://support.microsoft.com/kb/224196</a></linkUri></externalLink><externalLink><linkText>SPN for a Target DC in AD DS</linkText><linkUri><a href="https://msdn.microsoft.com/library/dd207688(PROT.13).aspx" data-raw-source="https://msdn.microsoft.com/library/dd207688(PROT.13).aspx">https://msdn.microsoft.com/library/dd207688(PROT.13).aspx</a></linkUri></externalLink></relatedTopics>
</developerConceptualDocument>


