---
ms.assetid: b3012a39-0ba9-49f2-a9a3-3af4f5574617
title: Event ID 2087 - DNS lookup failure caused replication to fail
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 02/09/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Event ID 2087: DNS lookup failure caused replication to fail

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012


<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This problem typically occurs when a Domain Name System (DNS) lookup failure causes replication to fail. When a destination domain controller receives Event ID 2087 in the Directory Service event log, attempts to resolve the globally unique identifier (GUID) in the alias (CNAME) resource record, the fully qualified domain name (FQDN), and the NetBIOS name to the IP address of the source domain controller have all failed. Failure to locate the source replication partner prevents replication with that source until the problem is fixed.</para>
    <para>The following is an example of the event text: </para>
    <code>Log Name: Directory Service
Source: Microsoft-Windows-ActiveDirectory_DomainService
Date: 3/9/2008  11:00:21 AM
Event ID: 2087
Task Category: DS RPC Client 
Level: Error
Keywords: Classic
User: ANONYMOUS LOGON
Computer: DC3.contoso.com
Description:
Active Directory could not resolve the following DNS host name of 
the source domain controller to an IP address. This error prevents 
additions, deletions and changes in Active Directory Domain Services from replicating 
between one or more domain controllers in the forest. Security 
groups, group policy, users and computers and their passwords will 
be inconsistent between domain controllers until this error is 
resolved, potentially affecting logon authentication and access 
to network resources. 

Source domain controller: 
  DC2 
Failing DNS host name: 
  b0069e56-b19c-438a-8a1f-64866374dd6e._msdcs.contoso.com 

NOTE: By default, only up to 10 DNS failures are shown for any 
given 12 hour period, even if more than 10 failures occur.  To 
log all individual failure events, set the following diagnostics 
registry value to 1: 

Registry Path: 
HKLM\System\CurrentControlSet\Services\NTDS\Diagnostics\22 DS RPC Client 

User Action: 

1) If the source domain controller is no longer functioning or 
its operating system has been reinstalled with a different 
computer name or NTDSDSA object GUID, remove the source domain 
controller's metadata with ntdsutil.exe, using the steps outlined 
in MSKB article 216498. 

2) Confirm that the source domain controller is running Active 
Directory Domain Services and is accessible on the network by typing 
"net view \\&lt;source DC name&gt;" or "ping &lt;source DC name&gt;". 

3) Verify that the source domain controller is using a valid 
DNS server for DNS services, and that the source domain 
controller's host record and CNAME record are correctly 
registered, using the DNS Enhanced version of DCDIAG.EXE 
available on http://www.microsoft.com/dns 

dcdiag /test:dns 

4) Verify that this destination domain controller is using 
a valid DNS server for DNS services, by running the DNS Enhanced 
version of DCDIAG.EXE command on the console of the destination 
domain controller, as follows: 

dcdiag /test:dns 

5) For further analysis of DNS error failures see KB 824449: 
http://support.microsoft.com/?kbid=824449 

Additional Data 
Error value: 
11004 The requested name is valid, but no data of the requested 
type was found. 
</code>
  </introduction>
  <section>
    <title>Diagnosis</title>
    <content>
      <para>Failure to resolve the current alias (CNAME) resource record of the source domain controller to an IP address can have the following causes:</para>
      <list class="bullet">
        <listItem>
          <para>The source domain controller is powered off, is offline, or resides on an isolated network, and Active Directory and DNS data for the offline domain controller has not been deleted to indicate that the domain controller is inaccessible.</para>
        </listItem>
        <listItem>
          <para>One of the following conditions exists:</para>
          <list class="bullet">
            <listItem>
              <para>The source domain controller has not registered its resource records in DNS.</para>
            </listItem>
            <listItem>
              <para>The destination domain controller is configured to use an invalid DNS server.</para>
            </listItem>
            <listItem>
              <para>The source domain controller is configured to use an invalid DNS server.</para>
            </listItem>
            <listItem>
              <para>The DNS server that the source domain controller uses does not host the correct zones, or the zones are not configured to accept dynamic updates.</para>
            </listItem>
            <listItem>
              <para>The direct DNS servers that the destination domain controller queries cannot resolve the IP address of the source domain controller as a result of nonexistent or invalid forwarders or delegations.</para>
            </listItem>
          </list>
        </listItem>
        <listItem>
          <para>Active Directory Domain Services (AD DS) has been removed on the source domain controller and then reinstalled with the same IP address, but knowledge of the new NTDS Settings GUID has not reached the destination domain controller.</para>
        </listItem>
        <listItem>
          <para>AD DS has been removed on the source domain controller and then reinstalled with a different IP address, but the current host address (A) resource record for the IP address of the source domain controller is either not registered or does not exist on the DNS servers that the destination domain controller queries as a result of replication latency or replication error.</para>
        </listItem>
        <listItem>
          <para>The operating system of the source domain controller has been reinstalled with a different computer name, but its metadata either has not been removed or has been removed and not yet inbound-replicated by the destination domain controller.</para>
        </listItem>
      </list>
    </content>
  </section>
  <section>
    <title>Resolution</title>
    <content>
      <para>First, determine whether the source domain controller is functioning. If the source domain controller is not functioning, remove its remaining metadata from AD DS.</para>
      <para>If the source domain controller is functioning, continue with procedures to diagnose and solve the DNS problem, as necessary: </para>
      <list class="bullet">
        <listItem>
          <para>Use Dcdiag to diagnose DNS problems.</para>
        </listItem>
        <listItem>
          <para>Register DNS service (SRV) resource records plus host records.</para>
        </listItem>
        <listItem>
          <para>Synchronize replication between the source and destination domain controllers.</para>
        </listItem>
        <listItem>
          <para>Verify consistency of the NTDS Settings GUID.</para>
        </listItem>
      </list>
    </content>
    <sections>
      <section>
        <title>Determine whether a domain controller is functioning</title>
        <content>
          <para>To determine whether the source domain controller is functioning, use the following test.</para>
          <para>
            <embeddedLabel>Requirements</embeddedLabel>
          </para>
          <list class="bullet">
            <listItem>
              <para>Membership in the <embeddedLabel>Domain Users</embeddedLabel> group in the domain of the domain controller, or equivalent, is the minimum required to complete this procedure. <token>review_detailincludes></para>
            </listItem>
            <listItem>
              <para>Tools: Net view</para>
            </listItem>
          </list>
          <procedure>
            <title>To determine whether a domain controller is functioning</title>
            <steps class="bullet">
              <step>
                <content>
                  <para>To confirm that the domain controller is running AD DS and is accessible on the network, at a command prompt type the following command, and then press ENTER:</para>
                  <para>
                    <codeInline>net view &lt;SourceDomainControllerName&gt;</codeInline>
                  </para>
                  <para>where <codeInline>&lt;SourceDomainControllerName&gt;</codeInline> is the NetBIOS name of the domain controller.</para>
                </content>
              </step>
            </steps>
          </procedure>
          <para>This command displays the Netlogon and SYSVOL shares, indicating that the server is functioning as a domain controller. If this test shows that the domain controller is not functioning on the network, determine the nature of the disconnection and whether the domain controller can be recovered or whether its metadata must be removed from AD DS manually. If the domain controller is not functioning and cannot be restored, use the procedure in the following section, "Clean up domain controller metadata," to delete the data that is associated with that server from AD DS.</para>
        </content>
      </section>
      <section>
        <title>Clean up domain controller metadata</title>
        <content>
          <para>If tests show that the domain controller is no longer functioning but you still see objects representing the domain controller in the Active Directory Sites and Services snap-in, replication will continue to be attempted, and you must remove these objects from AD DS manually. You must use the Ntdsutil tool to clean up (delete) the metadata for the defunct domain controller.</para>
          <para>If the defunct domain controller is the last domain controller in the domain, you should also remove the metadata for the domain. Allow sufficient time for all global catalog servers in the forest to inbound-replicate the domain deletion before you promote a new domain with the same name.</para>
          <para>The process for cleaning up metadata is improved in the version of Ntdsutil that is included with Windows Server 2003 Service Pack 1 (SP1). Instructions for cleaning up metadata with the Windows Server 2003 version of Ntdsutil and the Windows Server 2003 SP1 version of Ntdsutil are provided in the following procedure.</para>
          <para>
            <embeddedLabel>Requirements</embeddedLabel>
          </para>
          <list class="bullet">
            <listItem>
              <para>Membership in Enterprise Admins, or equivalent, is the minimum required to complete this procedure. <token>review_detailincludes></para>
            </listItem>
            <listItem>
              <para>Tools: Ntdsutil (System32 command-line tool)</para>
            </listItem>
          </list>
          <procedure>
            <title>To clean up server metadata</title>
            <steps class="ordered">
              <step>
                <content>
                  <para>Open a Command Prompt.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>At the command prompt, type the following command, and then press ENTER:</para>
                  <para>
                    <codeInline>ntdsutil</codeInline>
                  </para>
                </content>
              </step>
              <step>
                <content>
                  <para>At the <codeInline>ntdsutil:</codeInline> command prompt, type the following command, and then press ENTER:</para>
                  <para>
                    <codeInline>metadata cleanup</codeInline>
                  </para>
                </content>
              </step>
              <step>
                <content>
                  <para>Perform metadata cleanup as follows:</para>
                  <alert class="note">
                    <para>If you are removing domain metadata as well as server metadata, skip the following procedure and use the procedure that begins at step a.</para>
                  </alert>
                  <list class="bullet">
                    <listItem>
                      <para>If you are performing server metadata cleanup only and you are using the version of Ntdsutil.exe that is included with Windows Server 2003 SP1, at the <codeInline>metadata cleanup:</codeInline> command prompt, type the following command, and then press ENTER:</para>
                      <para>
                        <codeInline>remove selected server &lt;ServerName&gt;</codeInline>
                      </para>
                      <para>Or</para>
                      <para>
                        <codeInline>remove selected server &lt;ServerName1&gt; on &lt;ServerName2&gt;</codeInline>
                      </para>
                      <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
                        <thead>
                          <tr>
                            <TD colspan="1">
                              <para>Parameter</para>
                            </TD>
                            <TD colspan="1">
                              <para>Description</para>
                            </TD>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <TD colspan="1">
                              <para>&lt;ServerName&gt;, &lt;ServerName1&gt;</para>
                            </TD>
                            <TD colspan="1">
                              <para>The distinguished name of the domain controller whose metadata you want to remove, in the form cn=&lt;ServerName&gt;,cn=Servers,cn=&lt;SiteName&gt;, cn=Sites,cn=Configuration,dc=&lt;ForestRootDomain&gt;</para>
                            </TD>
                          </tr>
                          <tr>
                            <TD colspan="1">
                              <para>&lt;ServerName2&gt;</para>
                            </TD>
                            <TD colspan="1">
                              <para>The DNS name of the domain controller to which you want to connect and from which you want to remove server metadata</para>
                            </TD>
                          </tr>
                        </tbody>
                      </table>
                    </listItem>
                    <listItem>
                      <para>If you are performing metadata cleanup by using the version of Ntdsutil.exe that is included with Windows Server 2003 with no service pack, or if you are performing both domain metadata cleanup and server metadata cleanup, perform metadata cleanup as follows: </para>
                    </listItem>
                  </list>
                  <list class="ordered">
                    <listItem>
                      <para>At the <codeInline>metadata cleanup:</codeInline> prompt, type the following command, and then press ENTER:</para>
                      <para>
                        <codeInline>connection</codeInline>
                      </para>
                    </listItem>
                    <listItem>
                      <para>At the <codeInline>server connections:</codeInline> prompt, type the following command, and then press ENTER:</para>
                      <para>
                        <codeInline>connect to server &lt;Server&gt;</codeInline>
                      </para>
                    </listItem>
                    <listItem>
                      <para>At the <codeInline>connection:</codeInline> prompt, type the following command, and then press ENTER:</para>
                      <para>
                        <codeInline>quit</codeInline>
                      </para>
                    </listItem>
                    <listItem>
                      <para>At the <codeInline>metadata cleanup:</codeInline> prompt, type the following command, and then press ENTER:</para>
                      <para>
                        <codeInline>select operation target</codeInline>
                      </para>
                    </listItem>
                    <listItem>
                      <para>At the <codeInline>select operation target:</codeInline> prompt, type the following command, and then press ENTER:</para>
                      <para>
                        <codeInline>list sites</codeInline>
                      </para>
                    </listItem>
                    <listItem>
                      <para>A numbered list of sites appears. Type the following command, and then press ENTER:</para>
                      <para>
                        <codeInline>select site &lt;SiteNumber&gt;</codeInline>
                      </para>
                    </listItem>
                    <listItem>
                      <para>At the <codeInline>select operation target:</codeInline> prompt, type the following command, and then press ENTER:</para>
                      <para>
                        <codeInline>list domains in site</codeInline>
                      </para>
                    </listItem>
                    <listItem>
                      <para>A numbered list of domains in the selected site appears. Type the following command, and then press ENTER:</para>
                      <para>
                        <codeInline>select domain &lt;DomainNumber&gt;</codeInline>
                      </para>
                    </listItem>
                    <listItem>
                      <para>At the <codeInline>select operation target:</codeInline> prompt, type the following command, and then press ENTER:</para>
                      <para>
                        <codeInline>list servers in site</codeInline>
                      </para>
                    </listItem>
                    <listItem>
                      <para>A numbered list of servers in a domain and site is displayed. Type the following command, and then press ENTER:</para>
                      <para>
                        <codeInline>select server &lt;ServerNumber&gt;</codeInline>
                      </para>
                    </listItem>
                    <listItem>
                      <para>At the <codeInline>select operation target:</codeInline> prompt, type the following command, and then press ENTER:</para>
                      <para>
                        <codeInline>quit</codeInline>
                      </para>
                    </listItem>
                    <listItem>
                      <para>At the <codeInline>metadata cleanup:</codeInline> prompt, type the following command, and then press ENTER:</para>
                      <para>
                        <codeInline>remove selected server</codeInline>
                      </para>
                    </listItem>
                    <listItem>
                      <para>If the server whose metadata you have removed is the last domain controller in the domain and you want to remove the domain metadata, at the <codeInline>metadata cleanup:</codeInline> prompt, type the following command, and then press ENTER:</para>
                      <para>
                        <codeInline>remove selected domain</codeInline>
                      </para>
                      <para>Metadata for the domain that you selected in step h is removed.</para>
                    </listItem>
                    <listItem>
                      <para>At the <codeInline>metadata cleanup:</codeInline> and <codeInline>ntdsutil:</codeInline> prompts, type <codeInline>quit</codeInline>, and then press ENTER.</para>
                      <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
                        <thead>
                          <tr>
                            <TD colspan="1">
                              <para>Parameter</para>
                            </TD>
                            <TD colspan="1">
                              <para>Description</para>
                            </TD>
                          </tr>
                        </thead>
                        <tbody>
                          <tr>
                            <TD colspan="1">
                              <para>&lt;Server&gt;</para>
                            </TD>
                            <TD colspan="1">
                              <para>The DNS name of a domain controller that you want to connect to</para>
                            </TD>
                          </tr>
                          <tr>
                            <TD colspan="1">
                              <para>&lt;SiteNumber&gt;</para>
                            </TD>
                            <TD colspan="1">
                              <para>The number that is associated with the site of the server that you want to clean up, which appears in the list</para>
                            </TD>
                          </tr>
                          <tr>
                            <TD colspan="1">
                              <para>&lt;DomainNumber&gt;</para>
                            </TD>
                            <TD colspan="1">
                              <para>The number that is associated with the domain of the server that you want to clean up, which appears in the list</para>
                            </TD>
                          </tr>
                          <tr>
                            <TD colspan="1">
                              <para>&lt;ServerNumber&gt;</para>
                            </TD>
                            <TD colspan="1">
                              <para>The number that is associated with the server that you want to clean up, which appears in the list</para>
                            </TD>
                          </tr>
                        </tbody>
                      </table>
                      <para />
                    </listItem>
                  </list>
                </content>
              </step>
            </steps>
          </procedure>
        </content>
      </section>
      <section>
        <title>Use Dcdiag to diagnose DNS problems</title>
        <content>
          <para>If the domain controller is functioning online, continue by using the Dcdiag tool to diagnose and fix DNS problems that might be interfering with Active Directory replication.</para>
          <para>Use the following procedures to complete this process:</para>
          <list class="bullet">
            <listItem>
              <para>Verify connectivity and basic DNS functionality.</para>
            </listItem>
            <listItem>
              <para>Verify registration of the alias (CNAME) resource record in DNS.</para>
            </listItem>
            <listItem>
              <para>Verify and enable secure dynamic updates.</para>
            </listItem>
          </list>
          <para>Before you begin these procedures, gather the following information, which is contained in the Event ID 2087 message text:</para>
          <list class="bullet">
            <listItem>
              <para>The FQDN of the source domain controller and destination domain controller</para>
            </listItem>
            <listItem>
              <para>The IP address of the source domain controller</para>
            </listItem>
          </list>
          <para>The updated version of Dcdiag that is included in Windows Support Tools in Windows Server 2003 SP1 contains tests that provide consolidated and improved testing of basic and advanced DNS features. You can use this tool to diagnose basic DNS functionality and dynamic updates.</para>
          <para>When you use the enhanced SP1 version of Dcdiag for DNS testing, there are specific requirements that do not apply to all Dcdiag tests.</para>
          <para>
            <embeddedLabel>Requirements</embeddedLabel>
          </para>
          <list class="bullet">
            <listItem>
              <para>Membership in <embeddedLabel>Enterprise Admins</embeddedLabel>, or equivalent, is the minimum required to complete the new DNS tests that are available in the SP1 version of Dcdiag. <token>review_detailincludes></para>
            </listItem>
            <listItem>
              <para>Tools: Dcdiag.exe</para>
            </listItem>
            <listItem>
              <para>Operating system:</para>
              <list class="bullet">
                <listItem>
                  <para>You can run the enhanced version of Dcdiag on computers running the following operating systems:</para>
                  <para>Windows XP Professional</para>
                  <para>Windows Server 2003</para>
                  <para>Windows Server 2003 with SP1</para>
                </listItem>
                <listItem>
                  <para>You can run the new Dcdiag DNS tests against Microsoft DNS servers that are installed on domain controllers running the following operating systems:</para>
                  <para>Windows 2000 Server with Service Pack 3 (SP3)</para>
                  <para>Windows 2000 Server with Service Pack 4 (SP4)</para>
                  <para>Windows Server 2003</para>
                  <para>Windows Server 2003 with SP1</para>
                </listItem>
              </list>
            </listItem>
          </list>
          <alert class="note">
            <para>You can use the <system>/f:</system> switch in Dcdiag commands to save the output to a text file. Use <system>/f:</system><placeholder>FileName</placeholder> to generate the file in the location that is indicated in <placeholder>FileName</placeholder>, for example, <system>/f:c:TestDnsTest.txt</system>.</para>
          </alert>
        </content>
        <sections>
          <section>
            <title>Verify basic DNS functionality</title>
            <content>
              <para>To verify the settings that might interfere with Active Directory replication, you can begin by running the basic DNS test that ensures that DNS is operating properly on the domain controller.</para>
              <para>The basic DNS test checks the following:</para>
              <list class="bullet">
                <listItem>
                  <para>Connectivity: The test determines whether domain controllers are registered in DNS, can be contacted by PING, and have Lightweight Directory Access Protocol / remote procedure call (LDAP/RPC) connectivity. If the connectivity test fails on a domain controller, no other tests are run against that domain controller. The connectivity test is performed automatically before any other DNS test is run.</para>
                </listItem>
                <listItem>
                  <para>Essential services: The test confirms that the following services are running and available on the tested domain controller:</para>
                  <list class="bullet">
                    <listItem>
                      <para>DNS Client service</para>
                    </listItem>
                    <listItem>
                      <para>Net Logon service</para>
                    </listItem>
                    <listItem>
                      <para>Key Distribution Center (KDC) service</para>
                    </listItem>
                    <listItem>
                      <para>DNS Server service (if DNS is installed on the domain controller)</para>
                    </listItem>
                  </list>
                </listItem>
                <listItem>
                  <para>DNS client configuration: The test confirms that DNS servers on all adapters are reachable.</para>
                </listItem>
                <listItem>
                  <para>Resource record registrations: The test confirms that the host (A) resource record of each domain controller is registered on at least one of the DNS servers that is configured on the client.</para>
                </listItem>
                <listItem>
                  <para>Zone and start of authority (SOA): If the domain controller is running the DNS Server service, the test confirms that the Active Directory domain zone and start of authority (SOA) resource record for the Active Directory domain zone are present.</para>
                </listItem>
                <listItem>
                  <para>Root zone: Checks whether the root (.) zone is present.</para>
                </listItem>
              </list>
              <procedure>
                <title>To verify basic DNS functionality</title>
                <steps class="ordered">
                  <step>
                    <content>
                      <para>At a command prompt, type the following command, and then press ENTER:</para>
                      <para>
                        <codeInline>dcdiag /test:dns /s:&lt;SourceDomainControllerName&gt; /DnsBasic</codeInline>
                      </para>
                      <para>where <codeInline>&lt;SourceDomainControllerName&gt;</codeInline> is the distinguished name, NetBIOS name, or DNS name of the domain controller.</para>
                      <para>As an alternative, you can test all domain controllers in the forest by typing <codeInline>/e:</codeInline> instead of <codeInline>/s:</codeInline>.</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>Copy the report into Notepad or an equivalent text editor. </para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>Scroll to the Summary table near the bottom of the Dcdiag log file. </para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>Note the names of all domain controllers that report "Warn" or "Fail" status in the Summary table. </para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>Find the detailed breakout section for the problem domain controller by searching for the string "DC: &lt;DomainControllerName&gt;". </para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>Make the required configuration changes on DNS clients and DNS servers.</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>To validate the configuration changes, rerun <codeInline>Dcdiag /test:DNS</codeInline> with the <codeInline>/e:</codeInline> or <codeInline>/s:</codeInline> switch.</para>
                    </content>
                  </step>
                </steps>
              </procedure>
              <para>If the basic DNS test shows no errors, continue by verifying that resource records that are used to locate domain controllers are registered in DNS. </para>
            </content>
          </section>
          <section>
            <title>Verify resource record registration</title>
            <content>
              <para>The destination domain controller uses the DNS alias (CNAME) resource record to locate its source domain controller replication partner. Although domain controllers running Windows Server 2003 with SP1 can locate source replication partners by using FQDNs?or, if that fails, NetBIOS names?the presence of the alias (CNAME) resource record is expected and should be verified for proper DNS functioning.</para>
              <para>You can use Dcdiag to verify registration of all resource records that are essential for domain controller location by using the <system>dcdiag /test:dns /DnsRecordRegistration</system> test. This test verifies registration of the following resource records in DNS:</para>
              <list class="bullet">
                <listItem>
                  <para>alias (CNAME) (the GUID-based resource record that locates a replication partner)</para>
                </listItem>
                <listItem>
                  <para>host (A) (the host resource record that contains the IP address of the domain controller)</para>
                </listItem>
                <listItem>
                  <para>LDAP SRV (the service (SRV) resource records that locate LDAP servers)</para>
                </listItem>
                <listItem>
                  <para>GC SRV (the service (SRV) resource records that locate global catalog servers)</para>
                </listItem>
                <listItem>
                  <para>PDC SRV (the service (SRV) resource records that locate primary domain controller (PDC) emulator operations masters)</para>
                </listItem>
              </list>
              <para>As an alternative, you can use the following procedure to check for only the alias (CNAME) resource record.</para>
              <procedure>
                <title>To verify alias (CNAME) resource record registration</title>
                <steps class="ordered">
                  <step>
                    <content>
                      <para>In the DNS snap-in, locate any domain controller that is running the DNS Server service, where the server hosts the DNS zone with the same name as the Active Directory domain of the domain controller.</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>In the console tree, click the zone that is named _msdcs.<placeholder>Dns_Domain_Name</placeholder>.</para>
                      <alert class="note">
                        <para>In Windows 2000 Server DNS, _msdcs.<placeholder>Dns_Domain_Name</placeholder> is a subdomain of the DNS zone for the Active Directory domain name. In Windows Server 2003 DNS, _msdcs.<placeholder>Dns_Domain_Name</placeholder> is a separate zone.</para>
                      </alert>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>In the details pane, verify that the following resource records are present:</para>
                      <list class="bullet">
                        <listItem>
                          <para>An alias (CNAME) resource record that is named <placeholder>Dsa_Guid</placeholder>._msdcs.<placeholder>Dns_Domain_Name</placeholder></para>
                        </listItem>
                        <listItem>
                          <para>A corresponding host (A) resource record for the name of the DNS server</para>
                        </listItem>
                      </list>
                    </content>
                  </step>
                </steps>
              </procedure>
              <para>If the alias (CNAME) resource record is not registered, verify that dynamic updates are functioning properly. Use the test in the following section.</para>
            </content>
          </section>
          <section>
            <title>Verify dynamic updates</title>
            <content>
              <para>If the basic DNS test shows that resource records do not exist in DNS, use the dynamic update test to diagnose why the Net Logon service did not register the resource records automatically. To verify that the Active Directory domain zone is configured to accept secure dynamic updates and to perform registration of a test record (_dcdiag_test_record), use the following procedure. The test record is deleted automatically after the test.</para>
              <procedure>
                <title>To verify dynamic updates</title>
                <steps class="bullet">
                  <step>
                    <content>
                      <para>At a command prompt, type the following command, and then press ENTER:</para>
                      <para>
                        <codeInline>dcdiag /test:dns /s:&lt;SourceDomainControllerName&gt; /DnsDynamicUpdate</codeInline>
                      </para>
                      <para>where &lt;SourceDomainControllerName&gt; is the distinguished name, NetBIOS name, or DNS name of the domain controller.</para>
                      <para>As an alternative, you can test all domain controllers by using the <codeInline>/e:</codeInline> switch instead of the <codeInline>/s:</codeInline> switch.</para>
                    </content>
                  </step>
                </steps>
              </procedure>
              <para>If secure dynamic update is not configured, use the following procedure to configure it.</para>
              <procedure>
                <title>To enable secure dynamic updates</title>
                <steps class="ordered">
                  <step>
                    <content>
                      <para>Open the DNS snap-in.</para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>In the console tree, right-click the applicable zone, and then click <ui>Properties</ui>. </para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>On the <ui>General</ui> tab, verify that the zone type is Active Directory-integrated. </para>
                    </content>
                  </step>
                  <step>
                    <content>
                      <para>In <ui>Dynamic Updates</ui>, click <ui>Secure only</ui>. </para>
                    </content>
                  </step>
                </steps>
              </procedure>
            </content>
          </section>
        </sections>
      </section>
      <section>
        <title>Register DNS resource records</title>
        <content>
          <para>If DNS resource records do not appear in DNS for the source domain controller, you have verified dynamic updates, and you want to register DNS resource records immediately, you can force the registration manually by using the following procedure. The Net Logon service on a domain controller registers the DNS resource records that are required for the domain controller to be located on the network. The DNS Client service registers the host (A) resource record that the alias (CNAME) record points to.</para>
          <para>
            <embeddedLabel>Requirements</embeddedLabel>
          </para>
          <list class="bullet">
            <listItem>
              <para> Membership in the <embeddedLabel>Domain Admins</embeddedLabel> group in the forest root domain or the <embeddedLabel>Enterprise Admins</embeddedLabel> group, or equivalent, is the minimum required to complete this procedure.</para>
            </listItem>
            <listItem>
              <para>Tools: <system>net stop/start</system>, <system>ipconfig</system></para>
            </listItem>
          </list>
          <procedure>
            <title>To register DNS resource records manually</title>
            <steps class="ordered">
              <step>
                <content>
                  <para>To initiate registration of domain controller Locator resource records manually on the source domain controller, at a command prompt type the following commands, and then press ENTER after each command:</para>
                  <para>
                    <codeInline>net stop net logon &amp; net start net logon</codeInline>
                  </para>
                </content>
              </step>
              <step>
                <content>
                  <para>To initiate registration of the host A resource record manually, at a command prompt type the following command, and then press ENTER:</para>
                  <para>
                    <codeInline>ipconfig /flushdns &amp; ipconfig /registerdns</codeInline>
                  </para>
                </content>
              </step>
              <step>
                <content>
                  <para>Wait 15 minutes, and then review events in Event Viewer to ensure proper registration of the resource records.</para>
                </content>
              </step>
            </steps>
          </procedure>
          <para>Repeat the procedure in the "Verify Resource Record Registration" section earlier in this section to verify that the resource records appear in DNS.</para>
        </content>
      </section>
      <section>
        <title>Synchronize replication between the source and destination domain controllers</title>
        <content>
          <para>After you complete DNS testing, use the following procedure to synchronize replication on the inbound connection from the source domain controller to the destination domain controller. </para>
          <para>
            <embeddedLabel>Requirements</embeddedLabel>
          </para>
          <list class="bullet">
            <listItem>
              <para> Membership in the <embeddedLabel>Domain Admins</embeddedLabel> group in the domain of the destination domain controller, or equivalent, is the minimum required to complete this procedure. <token>review_detailincludes></para>
            </listItem>
            <listItem>
              <para>Tool: Active Directory Sites and Services</para>
            </listItem>
          </list>
          <procedure>
            <title>To synchronize replication from a source domain controller</title>
            <steps class="ordered">
              <step>
                <content>
                  <para>Open Active Directory Sites and Services. </para>
                </content>
              </step>
              <step>
                <content>
                  <para>In the console tree, double-click the <ui>Sites</ui> container, double-click the site of the domain controller to which you want to synchronize replication, double-click the <ui>Servers</ui> container, double-click the server object of the domain controller, and then click <ui>NTDS Settings</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>In the details pane, in the <ui>From Server</ui> column, locate the connection object that shows the name of the source domain controller.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>Right-click the appropriate connection object, and then click <ui>Replicate Now</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>Click <ui>OK</ui>.</para>
                </content>
              </step>
            </steps>
          </procedure>
          <para>If replication does not succeed, use the procedure in the following section to verify consistency of the NTDS Settings GUID.</para>
        </content>
      </section>
      <section>
        <title>Verify consistency of the NTDS Settings GUID</title>
        <content>
          <para>If you have performed all DNS tests and other tests and replication does not succeed, use the following procedure to verify that the GUID of the NTDS Settings object that the destination domain controller is using to locate its replication partner matches the GUID that is currently in effect on the source domain controller itself. To perform this test, you view the object GUID as it appears in the local directories of each domain controller.</para>
          <para>
            <embeddedLabel>Requirements</embeddedLabel>
          </para>
          <list class="bullet">
            <listItem>
              <para> Membership in the <embeddedLabel>Domain Admins</embeddedLabel> group in the domain of the destination domain controller, or equivalent, is the minimum required to complete this procedure.</para>
            </listItem>
            <listItem>
              <para>Tool: Ldp.exe (Windows Support Tools)</para>
            </listItem>
          </list>
          <procedure>
            <title>To verify consistency of the NTDS Settings GUID</title>
            <steps class="ordered">
              <step>
                <content>
                  <para>Click <ui>Start</ui>, click <ui>Run</ui>, type <ui>Ldp</ui>, and then click <ui>OK</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>On the <ui>Connection</ui> menu, click <ui>Connect</ui>. </para>
                </content>
              </step>
              <step>
                <content>
                  <para>In the <ui>Connect</ui> dialog box, leave the <ui>Server</ui> box empty. </para>
                </content>
              </step>
              <step>
                <content>
                  <para>In <ui>Port</ui>, type <ui>389</ui>, and then click <ui>OK</ui>. </para>
                </content>
              </step>
              <step>
                <content>
                  <para>On the <ui>Connection</ui> menu, click <ui>Bind</ui>. </para>
                </content>
              </step>
              <step>
                <content>
                  <para>In the <ui>Bind</ui> dialog box, provide Enterprise Admins credentials. If it is not already selected, click <ui>Domain</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>In <ui>Domain</ui>, type the name of the forest root domain, and then click <ui>OK</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>On the <ui>View</ui> menu, click <ui>Tree</ui>. </para>
                </content>
              </step>
              <step>
                <content>
                  <para>In the <ui>Tree View</ui> dialog box, type:</para>
                  <para>
                    <ui>CN=Configuration,DC=Forest_Root_Domain</ui>
                  </para>
                  <para>and then click <ui>OK</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>Navigate to the object CN=NTDS Settings,CN=<placeholder>SourceServerName</placeholder>,CN=Servers,CN=<placeholder>SiteName</placeholder>, CN=Sites,CN=configuration,DC=<placeholder>ForestRootDomain</placeholder>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>Double-click the <ui>NTDS Settings</ui> object and, in the details pane, view the value for the attribute <embeddedLabel>objectGUID</embeddedLabel>. Right-click that value, and then copy it to Notepad.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>On the <ui>Connection</ui> menu, click <ui>Disconnect</ui>.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>Repeat steps 2 through 11, but in step 3, type the name of the source domain controller, for example, DC03.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>In Notepad, compare the values of the two GUIDs.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>If the values do not match, the destination domain controller must receive replication of the valid GUID. Check the GUID value on other domain controllers and attempt replication on the destination domain controller with a different domain controller that has the correct GUID.</para>
                </content>
              </step>
              <step>
                <content>
                  <para>If the values match, verify that the GUID matches the GUID in the <placeholder>Dsa_Guid</placeholder>._msdcs.<placeholder>Dns_Domain_Name</placeholder> resource record for the source domain controller, as follows:</para>
                  <list class="ordered">
                    <listItem>
                      <para>Note the primary DNS servers that each domain controller identifies in the TCP/IP properties in their Network Settings. All the DNS servers that are listed in the respective TCP/IP properties should be able to indirectly or directly resolve this alias (CNAME) resource record.</para>
                    </listItem>
                    <listItem>
                      <para>From the servers that are listed, identify the authoritative name server or servers for this domain zone by looking at the server names that are listed for the name server (NS) resource records at the root of the zone. (In the DNS snap-in, select the forward lookup zone for the root domain, and then view the name server (NS) records in the details pane.) </para>
                    </listItem>
                    <listItem>
                      <para>On the name server or servers obtained in step b, open the DNS snap-in, and double-click the forward lookup zone for the forest root domain name. Double-click the _msdcs folder, and note the alias (CNAME) resource records that exist for your server name.</para>
                    </listItem>
                    <listItem>
                      <para>If there are no records present or the records are incorrect, see article 241505 in the Microsoft Knowledge Base (<externalLink><linkText>http://go.microsoft.com/fwlink/?LinkId=69994</linkText><linkUri>http://go.microsoft.com/fwlink/?LinkId=69994</linkUri></externalLink>).</para>
                    </listItem>
                  </list>
                </content>
              </step>
            </steps>
          </procedure>
        </content>
      </section>
    </sections>
  </section>
  <relatedTopics />
</developerConceptualDocument>


