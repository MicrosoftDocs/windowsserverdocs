---
ms.assetid: 6a06a2e6-f056-458a-9fff-e7b6c2feec37
title: Replication error 1722 The RPC server is unavailable
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Replication error 1722 The RPC server is unavailable

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This topic explains symptoms, causes and how to resolve Active Directory replication error 1722: The RPC server is unavailable.</para>
    <list class="bullet">
      <listItem>
        <para>
          <link xlink:href="33500c62-ab27-4796-8b51-b7a812d56e04#BKMK_Symptoms">Symptoms</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="33500c62-ab27-4796-8b51-b7a812d56e04#BKMK_Causes">Causes</link>
        </para>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="33500c62-ab27-4796-8b51-b7a812d56e04#BKMK_Resolutions">Resolutions</link>
        </para>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_Symptoms">
    <title>Symptoms</title>
    <content>
      <para>This article describes the symptoms, cause and resolution for resolving Active Directory replication failing with Win32 error 1722: The RPC server is unavailable.</para>
      <list class="ordered">
        <listItem>
          <para>DCPROMO promotion of a replica DC fails to create an NTDS Settings object on the helper DC with error 1722.</para>
          <para>Dialog Title Text:</para>
          <para>Active Directory Domain Services Installation Wizard</para>
          <para>Dialog Message text:</para>
          <para>The operation failed because: Active Directory Domain Services could not create the NTDS Settings object for this Active Directory Domain Controller CN=NTDS Settings,CN=&lt;Name of DC being promoted),CN=Servers,CN=&lt;site name&gt;,CN=Sites,CN=Configuration,DC=&lt;forest root domain&gt; on the remote AD DC &lt;helper DC&gt;.&lt;domain name&gt;.&lt;top level domain&gt;. Ensure the provided network credentials have sufficient permissions. <embeddedLabel>"The RPC server is unavailable."</embeddedLabel> </para>
        </listItem>
<listItem><para>DCDIAG reports that the Active Directory Replications test has failed with error 1722: "The RPC Server is unavailable"</para><code>[Replications Check,&lt;DC Name&gt;] A recent replication attempt failed:
From &lt;source DC&gt; to &lt;destination DC&gt;
Naming Context: &lt;DN path of directory partition&gt;
The replication generated an error (1722):
<codeFeaturedElement>The RPC server is unavailable.</codeFeaturedElement>
The failure occurred at &lt;date&gt; &lt;time&gt;.
The last success occurred at &lt;date&gt; &lt;time&gt;.
&lt;X&gt; failures have occurred since the last success.
[&lt;dc name&gt;] DsBindWithSpnEx()<codeFeaturedElement>failed with error 1722,
The RPC server is unavailable.</codeFeaturedElement>.
Printing RPC Extended Error Info: 
&lt;snip&gt;</code></listItem><listItem><para>REPADMIN.EXE reports that the last replication attempt has failed with status 1722 (0x6ba).</para><para>REPADMIN commands that commonly cite the 1722 (0x6ba) status include but are not limited to:</para><table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11"><tbody><tr><TD><list class="bullet"><listItem><para>REPADMIN /REPLSUM</para></listItem><listItem><para>REPADMIN /SHOWREPL</para></listItem></list></TD><TD><list class="bullet"><listItem><para>REPADMIN /SHOWREPS</para></listItem><listItem><para>REPADMIN /SYNCALL</para></listItem></list></TD></tr></tbody></table><para>Sample output from "REPADMIN /SHOWREPS" and REPADMIN /SYNCALL depicting "The RPC server is unavailable" error is shown below:</para><code>c:&gt; <codeFeaturedElement>repadmin /showreps</codeFeaturedElement>
&lt;site name&gt;&lt;destination DC&gt;
DC Options: &lt;list of flags&gt;
Site Options: (none)
DC object GUID: &lt;NTDS settings object object GUID&gt;
DC invocationID: &lt;invocation ID string&gt;
==== INBOUND NEIGHBORS ======================================
DC=&lt;DN path for directory partition&gt;
&lt;site name&gt;&lt;source DC via RPC
DC object GUID: &lt;source DCs ntds settings object object guid&gt;
Last attempt @ &lt;date&gt; &lt;time&gt; failed, result <codeFeaturedElement>1722 (0x6ba):</codeFeaturedElement>
<codeFeaturedElement>The RPC server is unavailable.</codeFeaturedElement>
&lt;X #&gt; consecutive failure(s).
Last success @ &lt;date&gt; &lt;time&gt;
</code><para>Sample output of "REPADMIN /SYNCALL" depicting "The RPC server is unavailable" error is shown below:</para><code>C:&gt;repadmin /syncall
CALLBACK MESSAGE: Error contacting server &lt;object guid of NTDS
Settings object&gt;._msdcs.&lt;forest root domain&gt;.&lt;top level domain&gt;
(network error): 1722 (0x6ba):
The RPC server is unavailable. 
</code></listItem><listItem><para>The "replicate now" command in Active Directory Sites and Services returns "The RPC server is unavailable."</para><para>Right-clicking on the connection object from a source DC and choosing <ui>Replicate now</ui> fails with "The RPC server is unavailable." The on-screen error message is shown below:</para><para>Dialog title text:</para><para>Replicate Now</para><para>Dialog message text: </para><para>The following error occurred during the attempt to synchronize naming context &lt;DNS name of directory partition&gt; from domain controller &lt;source Dc host name&gt; to domain controller &lt;destination DC hostname&gt;:The RPC server is unavailable. This operation will not continue. This condition may be caused by a DNS lookup problem. For information about troubleshooting common DNS lookup problems, please see the following Microsoft Web site: http://go.microsoft.com/fwlink/?LinkId=5171. </para></listItem><listItem><para>NTDS KCC, NTDS General or Microsoft-Windows-ActiveDirectory_DomainService events with the 1722 status are logged in the Directory Services log in Event Viewer.</para><para>Active Directory events that commonly cite the 1722 status include but are not limited to:</para><table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11"><thead><tr><TD><para>Event ID</para></TD><TD><para>Event Source</para></TD><TD><para>Event String</para></TD></tr></thead><tbody><tr><TD><para>1125</para></TD><TD><para>Microsoft-Windows-ActiveDirectory_DomainService</para></TD><TD><para>The Active Directory Domain Services Installation Wizard (Dcpromo) was unable to establish connection with the following domain controller.</para></TD></tr><tr><TD><para>1311</para></TD><TD><para>NTDS KCC</para></TD><TD><para>The Knowledge Consistency Checker (KCC) has detected problems with the following directory partition.</para></TD></tr><tr><TD><para>1865</para></TD><TD><para>NTDS KCC</para></TD><TD><para>The Knowledge Consistency Checker (KCC) was unable to form a complete spanning tree network topology. As a result, the following list of sites cannot be reached from the local site.</para></TD></tr><tr><TD><para>1925</para></TD><TD><para>NTDS KCC</para></TD><TD><para>The attempt to establish a replication link for the following writable directory partition failed.</para></TD></tr><tr><TD><para>1960</para></TD><TD><para>NTDS Replication</para></TD><TD><para>Internal event: The following domain controller received an exception from a remote procedure call (RPC) connection. The operation may have failed.</para></TD></tr></tbody></table></listItem>
</list>
    </content>
  </section>
  <section address="BKMK_Causes">
    <title>Causes</title>
    <content>
      <para>RPC is an intermediate layer between the network transport and the application protocol. RPC itself has no special insight into failures but attempts to map lower layer protocol failures into an error at the RPC layer.</para>
      <para>RPC error 1722 / 0x6ba / RPC_S_SERVER_UNAVAILABLE is logged when a lower layer protocol reports a connectivity failure. The common case is that the abstract TCP CONNECT operation failed. In the context of Active Directory replication, the RPC client on the destination DC was not able to successfully connect to the RPC server on the source DC. Common causes for this are:</para>
      <list class="ordered">
        <listItem>
          <para>Link local failure</para>
        </listItem>
        <listItem>
          <para>DHCP failure</para>
        </listItem>
        <listItem>
          <para>DNS failure</para>
        </listItem>
        <listItem>
          <para>WINS failure</para>
        </listItem>
        <listItem>
          <para>Routing failure (including blocked ports on firewalls) </para>
        </listItem>
        <listItem>
          <para>IPSec / Network authentication failures</para>
        </listItem>
        <listItem>
          <para>UDP formatted Kerberos packets are being fragmented by network infrastructure devices like routers and switches.</para>
        </listItem>
        <listItem>
          <para>Resource limitations</para>
        </listItem>
        <listItem>
          <para>Higher layer protocol not running</para>
        </listItem>
        <listItem>
          <para>Higher layer protocol is returning this error</para>
        </listItem>
      </list>
    </content>
  </section>
  <section address="BKMK_Resolutions">
    <title>Resolutions</title>
    <content>
      <para>Basic Troubleshooting Steps to identify the problem:</para>
      <list class="ordered">
        <listItem>
          <para>Verify the startup value and service status is correct for the Remote Procedure Call (RPC), Remote Procedure Call (RPC) Locator and Kerberos Key Distribution Center. The operating system version will determine the correct values for the source and destination system that is logging the replication error. Use the following table to help validate the settings.</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Service Name</para>
                </TD>
                <TD>
                  <para>Windows 2000</para>
                </TD>
                <TD>
                  <para>Windows Server 2003/R2</para>
                </TD>
                <TD>
                  <para>Windows Server 2008</para>
                </TD>
                <TD>
                  <para>Windows Server 2008 R2</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>Remote Procedure Call (RPC)</para>
                </TD>
                <TD>
                  <para>Started / Automatic</para>
                </TD>
                <TD>
                  <para>Started / Automatic</para>
                </TD>
                <TD>
                  <para>Started / Automatic</para>
                </TD>
                <TD>
                  <para>Started / Automatic</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Remote Procedure Call (RPC) Locator</para>
                </TD>
                <TD>
                  <para>Started / Automatic (Domain Controllers)</para>
                  <para>Not started / Manual (Member Servers)</para>
                </TD>
                <TD>
                  <para>Not started / Manual</para>
                </TD>
                <TD>
                  <para>Not started / Manual</para>
                </TD>
                <TD>
                  <para>Not started / Manual</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Kerberos Key Distribution Center (KDC)</para>
                </TD>
                <TD>
                  <para>Started / Automatic (Domain Controllers)</para>
                  <para>Not started / Disabled(Member Servers)</para>
                </TD>
                <TD>
                  <para>Started / Automatic (Domain Controllers)</para>
                  <para>Not started / Disabled(Member Servers)</para>
                </TD>
                <TD>
                  <para>Started / Automatic (Domain Controllers)</para>
                  <para>Not started / Disabled(Member Servers)</para>
                </TD>
                <TD>
                  <para>Started / Automatic (Domain Controllers)</para>
                  <para>Not started / Disabled(Member Servers)</para>
                </TD>
              </tr>
            </tbody>
          </table>
          <para>If you make any changes to match the settings above, reboot the machine and verify both the startup value and service status match the values documented in the previous table.</para>
        </listItem>
        <listItem>
          <para>Verify the <embeddedLabel>ClientProtocols</embeddedLabel> key exists under <embeddedLabel>HKLMSoftwareMicrosoftRpc</embeddedLabel>, and that it contains the correct default protocols.</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Protocol Name</para>
                </TD>
                <TD>
                  <para>Type</para>
                </TD>
                <TD>
                  <para>Data Value</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>ncacn_http</para>
                </TD>
                <TD>
                  <para>REG_SZ</para>
                </TD>
                <TD>
                  <para>rpcrt4.dll</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>ncacn_ip_tcp</para>
                </TD>
                <TD>
                  <para>REG_SZ</para>
                </TD>
                <TD>
                  <para>rpcrt4.dll</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>ncacn_np</para>
                </TD>
                <TD>
                  <para>REG_SZ</para>
                </TD>
                <TD>
                  <para>rpcrt4.dll</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>ncacn_ip_udp</para>
                </TD>
                <TD>
                  <para>REG_SZ</para>
                </TD>
                <TD>
                  <para>rpcrt4.dll</para>
                </TD>
              </tr>
            </tbody>
          </table>
          <para>If the ClientProtocols key or any of the four default values are missing, import the key from a known good server.</para>
        </listItem>
        <listItem>
          <para>Verify DNS is working. DNS lookup failures are the cause of a large amount of 1722 RPC errors when it comes to replication. There are a few tools to use to help identify DNS errors:</para>
          <list class="bullet">
            <listItem>
              <para>
                <embeddedLabel>DCDIAG /TEST:DNS /V /E /F:&lt;filename.log&gt;</embeddedLabel>
              </para>
              <para>The <codeInline>DCDIAG /TEST:DNS</codeInline> command can validate DNS health of domain controllers that run Windows 2000 Server (SP3 or later), Windows Server 2003, Windows Server 2008, and Windows Server 2008 R2. This test was first introduced with Windows Server 2003 Service Pack 1.</para>
              <para>There are seven test groups for this command:</para>
              <list class="bullet">
                <listItem>
                  <para>Authentication (Auth)</para>
                </listItem>
                <listItem>
                  <para>Basic (Basc) </para>
                </listItem>
                <listItem>
                  <para>Records registration (RReg)</para>
                </listItem>
                <listItem>
                  <para>Dynamic update (Dyn) </para>
                </listItem>
                <listItem>
                  <para>Delegations (Del) </para>
                </listItem>
                <listItem>
                  <para>Forwarders/Root hints (Forw)</para>
                </listItem>
              </list>
              <para>Sample Output</para>
              <code>TEST: Authentication (Auth)
Authentication test: Successfully completed

TEST: Basic (Basc)
Microsoft(R) Windows(R) Server 2003, Enterprise Edition (Service Pack level: 2.0) is supported
NETLOGON service is running
kdc service is running
DNSCACHE service is running
DNS service is running
DC is a DNS server
Network adapters information:
Adapter [00000009] Microsoft Virtual Machine Bus Network Adapter:
MAC address is 00:15:5D:40:CF:92
IP address is static
IP address: &lt;IP Address
DNS servers:
&lt;DNS IP Address&gt; (DC.domain.com.) [Valid]
The A record for this DC was found
The SOA record for the Active Directory zone was found
The Active Directory zone on this DC/DNS server was found (primary)
Root zone on this DC/DNS server was not found
&lt;omitted other tests for readability&gt;
Summary of DNS test results:

Auth Basc Forw Del Dyn RReg Ext 
________________________________________________________________
Domain: Ca.fragale
DC1 PASS PASS FAIL PASS PASS PASS n/a 
Domain: child.Ca.fragale
DC2 PASS PASS n/a n/a n/a PASS n/a 

Enterprise DNS infrastructure test results:
For parent domain domain.com and subordinate domain child:
Forwarders or root hints are not misconfigured from parent domain to subordinate domain
Error: Forwarders are configured from subordinate to parent domain but some of them failed DNS server tests

(See DNS servers section for error details)
Delegation is configured properly from parent to subordinate domain
......................... domain.com failed test DNS
The summary provides remediation steps for the more common 
</code>
              <para>The summary provides remediation steps for the more common failures from this test.
Explanation and additional options for this test can be found at <externalLink><linkText>Domain Controller Diagnostics Tool (dcdiag.exe)</linkText><linkUri>http://technet.microsoft.com/library/cc776854(WS.10).aspx</linkUri></externalLink>.</para>
            </listItem>
            <listItem>
              <para>
                <embeddedLabel>NLTEST /DSGETDC:&lt;netbios or DNS domain name&gt;</embeddedLabel>
              </para>
              <para>Nltest /dsgetdc: is used to exercise the dc locator process. Thus /dsgetdc:&lt; domain name &gt; tries to find the domain controller for the domain. Using the force flag forces domain controller location rather than using the cache. You can also specify options such as <embeddedLabel>/gc</embeddedLabel> or <embeddedLabel>/pdc</embeddedLabel> to locate a Global Catalog or a Primary Domain Controller emulator. For finding the Global Catalog, you must specify a "tree name," which is the DNS domain name of the root domain.</para>
              <para>Sample Output:</para>
              <code>DC: \DC.Domain.com
Address: \\&lt;IP Address&gt;
Dom Guid: 5499c0e6-2d33-429d-aab3-f45f6a06922b
Dom Name: Domain.com
Forest Name: Domain.com
Dc Site Name: Default-First-Site-Name
Our Site Name: Default-First-Site-Name
Flags: PDC GC DS LDAP KDC TIMESERV WRITABLE DNS_DC DNS_DOMAIN DNS_FOREST CLOSE_SITE
The command completed successfully</code>
            </listItem>
            <listItem>
              <para>
                <embeddedLabel>Netdiag -v</embeddedLabel>
              </para>
              <para>This command can be used with Windows Server 2003 and earlier versions to gather specific information for networking configuration and error. This tool takes some time to run when executing the -v switch.</para>
              <para>Sample Output for the DNS test:</para>
              <code>DNS test . . . . . . . . . . . . . : Passed
Interface {34FDC272-55DC-4103-B4B7-89234BC30C4A}
DNS Domain: 
DNS Servers: &lt;DNS Server Ip address &gt;
IP Address: Expected registration with PDN (primary DNS domain name):
Hostname: DC.domain.com.
Authoritative zone: domain.com.
Primary DNS server: DC.domain.com &lt;Ip Adress&gt;
Authoritative NS:&lt;Ip Adress&gt; 
Check the DNS registration for DCs entries on DNS server &lt;DNS Server Ip address &gt;
The Record is correct on DNS server '&lt;DNS Server Ip address &gt;'.
(You will see this line repeated several times for every entry for this DC. Including srv records.)
The Record is correct on DNS server '&lt;DNS Server Ip address &gt;'.
PASS - All the DNS entries for DC are registered on DNS server '&lt;DNS Server Ip address &gt;'.</code>
            </listItem>
            <listItem>
              <para>
                <embeddedLabel />ping -a &lt;IP_of_problem_server&gt;</para>
              <para>This a simple quick test to validate the host record for a domain controller is resolving to the correct machine.</para>
            </listItem>
            <listItem>
              <para>
                <embeddedLabel>dnslint /s IP /ad IP</embeddedLabel>
              </para>
              <para>DNSLint is a Microsoft Windows utility that helps you to diagnose common DNS name resolution issues. The output for this is an .htm file with a lot of information including:</para>
              <code>
                <codeFeaturedElement>DNS server: localhost</codeFeaturedElement>
IP Address: 127.0.0.1
UDP port 53 responding to queries: YES
TCP port 53 responding to queries: Not tested
Answering authoritatively for domain: <codeFeaturedElement>NO</codeFeaturedElement>

<codeFeaturedElement>SOA record data from server:</codeFeaturedElement>
Authoritative name server: DC.domain.com
Hostmaster: hostmaster
Zone serial number: 14
Zone expires in: 1.00 day(s)
Refresh period: 900 seconds
Retry delay: 600 seconds
Default (minimum) TTL: 3600 seconds
</code>
            </listItem>
            <listItem>
              <para>Additional authoritative (NS) records from server:
DC2.domain.com &lt;IP Address&gt;</para>
              <code>Alias (CNAME) and glue (A) records for forest GUIDs from server:
CNAME: 98d4aa0c-d8e2-499a-8f90-9730b0440d9b._msdcs.domain.com
Alias: DC.domain.com
Glue: &lt;IP Adress&gt;

CNAME: a2c5007f-7082-4adb-ba7d-a9c47db1efc3._msdcs.domain.com
Alias: dc2.child.domain.com
Glue: &lt;IP Address&gt;</code>
              <para>For more information, see <externalLink><linkText>Description of the DNSLint utility</linkText><linkUri>http://support.microsoft.com/kb/321045</linkUri></externalLink>.</para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>Verify network ports are not blocked by a firewall or 3rd party application listening on the required ports.</para>
          <para>The endpoint mapper (listening on port 135) tells the client which randomly assigned port a service (FRS, AD replication, MAPI, and so on) is listening on.</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD>
                  <para>Application protocol</para>
                </TD>
                <TD>
                  <para>Protocol</para>
                </TD>
                <TD>
                  <para>Ports</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD>
                  <para>Global Catalog Server</para>
                </TD>
                <TD>
                  <para>TCP</para>
                </TD>
                <TD>
                  <para>3269</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>Global Catalog Server</para>
                </TD>
                <TD>
                  <para>TCP</para>
                </TD>
                <TD>
                  <para>3268</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>LDAP Server</para>
                </TD>
                <TD>
                  <para>TCP</para>
                </TD>
                <TD>
                  <para>389</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>LDAP Server</para>
                </TD>
                <TD>
                  <para>UDP</para>
                </TD>
                <TD>
                  <para>389</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>LDAP SSL</para>
                </TD>
                <TD>
                  <para>TCP</para>
                </TD>
                <TD>
                  <para>636</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>LDAP SSL</para>
                </TD>
                <TD>
                  <para>UDP</para>
                </TD>
                <TD>
                  <para>636</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>IPsec ISAKMP</para>
                </TD>
                <TD>
                  <para>UDP</para>
                </TD>
                <TD>
                  <para>500</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>NAT-T</para>
                </TD>
                <TD>
                  <para>UDP</para>
                </TD>
                <TD>
                  <para>4500</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>RPC</para>
                </TD>
                <TD>
                  <para>TCP</para>
                </TD>
                <TD>
                  <para>135</para>
                </TD>
              </tr>
              <tr>
                <TD>
                  <para>RPC randomly allocated high TCP ports</para>
                </TD>
                <TD>
                  <para>TCP</para>
                </TD>
                <TD>
                  <para>1024-5000</para>
                  <para>49152-65535</para>
                  <alert class="note">
                    <para>This is the range in Windows Server 2008, Windows Vista, Windows 7, and Windows 2008 R2. </para>
                  </alert>
                </TD>
              </tr>
            </tbody>
          </table>
          <para>Portqry can be used to identify if a port is blocked from a Dc when targeting another DC. It can be downloaded at <externalLink><linkText>PortQry Command Line Port Scanner Version 2.0</linkText><linkUri>http://www.microsoft.com/download/en/details.aspx?displaylang=en&amp;id=17148</linkUri></externalLink>.</para>
          <para>Example syntax:</para>
          <code>portqry -n &lt;problem_server&gt; -e 135 </code>
          <code>portqry -n &lt;problem_server&gt; -r 1024-5000</code>
          <para>A graphical version of portqry, called Portqryui can be found at PortQryUI - User Interface for the PortQry Command Line Port Scanner<externalLink><linkText>PortQryUI - User Interface for the PortQry Command Line Port Scanner</linkText><linkUri>http://www.microsoft.com/download/en/details.aspx?displaylang=en&amp;id=24009</linkUri></externalLink>.</para>
          <para> If the Dynamic Port range has ports being blocked, please use the below links to configure a port range that manageable:</para>
          <list class="bullet">
            <listItem>
              <para>
                <externalLink>
                  <linkText>How to configure RPC dynamic port allocation to work with firewalls</linkText>
                  <linkUri>http://support.microsoft.com/?id=154596</linkUri>
                </externalLink>
              </para>
            </listItem>
            <listItem>
              <para>
                <externalLink>
                  <linkText>Restricting Active Directory replication traffic and client RPC traffic to a specific port</linkText>
                  <linkUri>http://support.microsoft.com/?id=224196</linkUri>
                </externalLink>
              </para>
            </listItem>
            <listItem>
              <para>
                <externalLink>
                  <linkText>How to restrict FRS replication traffic to a specific static port</linkText>
                  <linkUri>http://support.microsoft.com/?id=319553</linkUri>
                </externalLink>
              </para>
            </listItem>
            <listItem>
              <para>
                <externalLink>
                  <linkText>How to configure a firewall for domains and trusts</linkText>
                  <linkUri>http://support.microsoft.com/?id=179442</linkUri>
                </externalLink>
              </para>
            </listItem>
            <listItem>
              <para>
                <externalLink>
                  <linkText>Service overview and network port requirements for the Windows Server system</linkText>
                  <linkUri>http://support.microsoft.com/?id=832017</linkUri>
                </externalLink>
              </para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>Bad NIC drivers - See network card vendors or OEMs for the latest drivers.</para>
        </listItem>
        <listItem>
          <para>UDP fragmentation can cause replication errors that appear to have a source of RPC server is unavailable. Event ID 40960 &amp; 40961 errors with a source of LSASRV are very common for this particular cause.</para>
        </listItem>
        <listItem>
          <para>SMB signing mismatches between DCs. Using Default Domain Controllers Policy to configure consistent settings for SMB Signing under the following section will help address this cause:</para>
          <para>Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options</para>
          <para>Microsoft network client: Digitally sign communications (always) Disabled. </para>
          <para>Microsoft network client: Digitally sign communications (if server agrees) Enabled.</para>
          <para>Microsoft network server: Digitally sign communications (always) Disabled.</para>
          <para>Microsoft network server: Digitally sign communications (if client agrees) Enabled.</para>
          <para>The settings can be found under the following registry keys:</para>
          <para>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManWorkstation\Parameters</para>
          <para>
HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters</para>
          <para>RequireSecuritySignature=always (0 disable, 1 enable). </para>
          <para>
EnableSecuritySignature=is server agrees (0 disable, 1 enable).</para>
        </listItem>
      </list>
      <para>
        <embeddedLabel>Additional Troubleshooting:</embeddedLabel>
      </para>
      <para>If the above do not provide a solution to the 1722, then you can use the following Diagnostic logging to gather more information: </para>
      <para>Windows Server 2003 SP2 computers logs extended RPC Server info in NTDS Replication events 1960, 1961, 1962 and 1963. </para>
      <para>Crank up NTDS Diagnostic logging. </para>
      <para>1 = basic, 2 and 3 add verbosity, and 5 logs extended info. </para>
    </content>
  </section>
  <relatedTopics>
    <externalLink>
      <linkText>Troubleshooting Active Directory operations that fail with error 1722: The RPC server is unavailable</linkText>
      <linkUri>http://support.microsoft.com/kb/2102154</linkUri>
    </externalLink>
    <externalLink>
      <linkText>RPC Return Values</linkText>
      <linkUri>http://msdn.microsoft.com/library/aa378645(VS.85).aspx</linkUri>
    </externalLink>
    <externalLink>
      <linkText>Understanding Extended Error Information</linkText>
      <linkUri>http://msdn.microsoft.com/library/aa379109(VS.85).aspx</linkUri>
    </externalLink>
    <externalLink>
      <linkText>Extended Error Information Detection Locations</linkText>
      <linkUri>http://msdn.microsoft.com/library/aa373838(VS.85).aspx</linkUri>
    </externalLink>
    <externalLink>
      <linkText>Enabling Extended Error Information</linkText>
      <linkUri>http://msdn.microsoft.com/library/aa373803(VS.85).aspx</linkUri>
    </externalLink>
    <externalLink>
      <linkText>Network Connectivity</linkText>
      <linkUri>http://technet.microsoft.com/library/cc961803.aspx</linkUri>
    </externalLink>
  </relatedTopics>
</developerConceptualDocument>


