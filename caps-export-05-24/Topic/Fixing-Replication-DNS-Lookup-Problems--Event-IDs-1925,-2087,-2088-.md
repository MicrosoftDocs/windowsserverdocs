---
title: Fixing Replication DNS Lookup Problems (Event IDs 1925, 2087, 2088)
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: b506eb78-51ad-4be2-b205-85756cabe766
author: Femila
---
# Fixing Replication DNS Lookup Problems (Event IDs 1925, 2087, 2088)
<?xml version="1.0" encoding="utf-8"?>
<developerConceptualDocument xmlns="http://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
  <introduction>
    <para>This section provides a description of Domain Name System (DNS) lookup problems that you might experience when Active Directory replication is enabled.</para>
    <para>Domain controllers running Windows 2000 Server, Windows Server 2003, or <token>nextref_longhorn</token> cannot replicate Active Directory updates if DNS lookup failures prevent a destination domain controller from contacting its source replication partner to request changes. Lookup failures occur when a destination domain controller cannot resolve its source replication partner's globally unique identifier (GUID)–based alias (CNAME) resource record to an IP address by using DNS. GUID-based alias (CNAME) resource records are always registered in the DNS zone _msdcs.<placeholder>ForestRootDomain</placeholder>.</para>
    <para>The most common DNS failures occur when DNS client settings are misconfigured on the destination or source domain controller, or the direct and intermediate DNS servers that are used to resolve the query are misconfigured. Network problems or domain controller disconnection problems might also be present. If the problem is due to DNS configuration errors or replication latency, the effect on Active Directory replication is minimized by improvements to domain controller name resolution that were introduced in Windows Server 2003 Service Pack 1 (SP1).</para>
    <para>
      <embeddedLabel>In this topic</embeddedLabel>
    </para>
    <list class="bullet">
      <listItem>
        <para>
          <link xlink:href="#BKMK_Improvements">Improvements to domain controller name resolution</link>
        </para>
        <list class="bullet">
          <listItem>
            <para>
              <link xlink:href="#BKMK_DNS_Failure">DNS failure scenarios</link>
            </para>
          </listItem>
          <listItem>
            <para>
              <link xlink:href="#BKMK_DNS_Events">DNS events for lookup failure</link>
            </para>
          </listItem>
        </list>
      </listItem>
      <listItem>
        <para>
          <link xlink:href="#BKMK_DNS_Requirements">DNS requirements for CNAME lookup success</link>
        </para>
        <list class="bullet">
          <listItem>
            <para>
              <link xlink:href="#BKMK_Potential_Failures">Potential preliminary failures due to replication latency</link>
            </para>
          </listItem>
        </list>
      </listItem>
    </list>
  </introduction>
  <section address="BKMK_Improvements">
    <title>Improvements to domain controller name resolution</title>
    <content>
      <para>Domain controllers running Windows Server 2003 with SP1, Windows Server 2003 R2, or <token>nextref_longhorn</token> have a more robust response to DNS name resolution failures than earlier versions of Windows Server. Rather than failing on the first attempt to resolve the IP address of a source domain controller by using its alias (CNAME) resource record, destination domain controllers running these operating systems use alternate names to attempt resolution. They also log events that report problems and prescribe solutions.</para>
    </content>
    <sections>
      <section address="BKMK_DNS_Failure">
        <title>DNS failure scenarios</title>
        <content>
          <para>All domain controllers register multiple service location (SRV) resource records in DNS as well as a hosting address (A) resource records for each IP address of the domain controller, plus an additional host (A) resource record for each IP address if the domain controller is a global catalog server. In addition, each domain controller registers a single alias (CNAME) resource record. </para>
          <para>The following table shows the DNS resource records that are required for proper Active Directory functionality.</para>
          <table xmlns:caps="http://schemas.microsoft.com/build/caps/2013/11">
            <thead>
              <tr>
                <TD colspan="1">
                  <para>Mnemonic</para>
                </TD>
                <TD colspan="1">
                  <para>Type</para>
                </TD>
                <TD colspan="1">
                  <para>DNS resource record</para>
                </TD>
              </tr>
            </thead>
            <tbody>
              <tr>
                <TD colspan="1">
                  <para>pdc</para>
                </TD>
                <TD colspan="1">
                  <para>SRV</para>
                </TD>
                <TD colspan="1">
                  <para>_ldap._tcp.pdc._msdcs.<placeholder>DnsDomainName</placeholder></para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>gc</para>
                </TD>
                <TD colspan="1">
                  <para>SRV</para>
                </TD>
                <TD colspan="1">
                  <para>_ldap_tcp.gc._msdcs.<placeholder>DnsForestRootDomainName</placeholder></para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>GcIpAddress</para>
                </TD>
                <TD colspan="1">
                  <para>A</para>
                </TD>
                <TD colspan="1">
                  <para>_gc._msdcs.<placeholder>DnsForestRootDomainName</placeholder></para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>DsaCname</para>
                </TD>
                <TD colspan="1">
                  <para>CNAME</para>
                </TD>
                <TD colspan="1">
                  <para>
                    <placeholder>DsaGuid</placeholder>._msdcs.<placeholder>DnsForestRootDomainName</placeholder></para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>kdc</para>
                </TD>
                <TD colspan="1">
                  <para>SRV</para>
                </TD>
                <TD colspan="1">
                  <para>_kerberos._tcp.dc._msdcs.<placeholder>DnsDomainName</placeholder></para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>dc</para>
                </TD>
                <TD colspan="1">
                  <para>SRV</para>
                </TD>
                <TD colspan="1">
                  <para>_ldap._tcp.dc._msdcs.<placeholder>DnsDomainName</placeholder></para>
                </TD>
              </tr>
              <tr>
                <TD colspan="1">
                  <para>None</para>
                </TD>
                <TD colspan="1">
                  <para>A</para>
                </TD>
                <TD colspan="1">
                  <para>
                    <placeholder>DomainControllerFQDN</placeholder>
                  </para>
                </TD>
              </tr>
            </tbody>
          </table>
          <para>In the alias (CNAME) resource record (<placeholder>DSA_GUID</placeholder>._msdcs.<placeholder>ForestRootDNSDomainName</placeholder>), <placeholder>DSA_GUID</placeholder> is the GUID of the NTDS Settings object (also called the Directory System Agent (DSA) object) for the domain controller. <placeholder>ForestRootDNSDomainName</placeholder> is the DNS name of the forest where the domain controller is located. Destination domain controllers use the alias (CNAME) resource record to identify and locate their replication partners.</para>
          <para>The Netlogon service on the domain controller registers all service (SRV) resource records when the operating system starts up and at regular intervals thereafter. The DNS client service on the domain controller registers the DNS host (A) resource record.</para>
          <para>A domain controller uses the following steps to locate its replication partner: </para>
          <list class="ordered">
            <listItem>
              <para>The destination domain controller queries its DNS server to look for the alias (CNAME) resource record of its replication partner. On domain controllers running Windows 2000 Server or Windows Server 2003 with no service pack applied, if this lookup fails to resolve the alias (CNAME) resource record to an IP address, DNS lookup (and replication) fails.</para>
            </listItem>
            <listItem>
              <para>On domain controllers running Windows Server 2003 with SP1, Windows Server 2003 R2, or <token>nextref_longhorn</token>, if the CNAME lookup is unsuccessful, the domain controller looks for the DNS host (A) resource record of its replication partner. For example, the domain controller looks for DC03.corp.contoso.com.</para>
            </listItem>
            <listItem>
              <para>If the DNS host (A) resource record lookup is unsuccessful, the domain controller performs a NetBIOS broadcast by using the host name of its replication partner. For example, the domain controller uses DC03.</para>
            </listItem>
          </list>
          <para>When lookups fail, events that describe the condition are logged in the Directory Service event log.</para>
        </content>
      </section>
      <section address="BKMK_DNS_Events">
        <title>DNS events for lookup failure</title>
        <content>
          <para>Two events, Event ID 2087 and Event ID 2088, are logged on destination domain controllers running Windows Server 2003 with SP1, Windows Server 2003 R2, or <token>nextref_longhorn</token>: </para>
          <list class="bullet">
            <listItem>
              <para>If all lookups fail, Event ID 2087 is logged. </para>
            </listItem>
            <listItem>
              <para>If lookup succeeds but either the first or second attempt fails, Event ID 2088 is logged.</para>
            </listItem>
          </list>
          <para>On domain controllers running all versions of Windows Server, the destination domain controller that cannot successfully locate its replication partner in DNS logs Event ID 1925.</para>
          <para>Regardless of whether replication succeeds or fails, if you receive Event ID 1925, Event ID 2087, or Event ID 2088, you should investigate and correct the cause of the failure, because incorrect DNS configuration can affect other essential operations—including logon authentication and access to network resources—on member computers, domain controllers, and application servers. In addition, although fallback name resolution might allow replication to occur, it introduces unnecessary latency and overhead into the replication process.</para>
        </content>
      </section>
    </sections>
  </section>
  <section address="BKMK_DNS_Requirements">
    <title>DNS requirements for CNAME lookup success</title>
    <content>
      <para>Failure of CNAME lookup indicates that either the DNS clients or DNS servers are not configured properly. It is important to understand the requirements for successful CNAME lookup and to ensure that DNS is functioning accordingly.</para>
      <para>Resolving the fully qualified, GUID-based, alias (CNAME) resource record of the source domain controller to the current IP address of the source domain controller requires the following DNS configurations:</para>
      <list class="ordered">
        <listItem>
          <para>In their respective TCP/IP client settings, the source domain controller and destination domain controller must be configured to resolve DNS names by using only valid DNS servers that directly host, forward, or delegate to the following DNS zones: </para>
          <list class="ordered">
            <listItem>
              <para>_msdcs.<placeholder>ForestRootDNSDomainName</placeholder>, to resolve queries for computers in the forest.</para>
            </listItem>
            <listItem>
              <para>The DNS zone that corresponds to the primary DNS suffix of the respective target domain controller, to resolve queries for computers in the domain. (The source domain controller can resolve the domain name of the target domain controller, and the reverse is also true.) The primary DNS suffix is usually the same as the DNS name of the domain to which a computer is joined. You can view the primary DNS suffix in the properties of My Computer.</para>
            </listItem>
          </list>
          <para>If the DNS servers that the source domain controller is configured to use for name resolution do not host these zones directly, the DNS servers that are used must forward or delegate to DNS servers that do host these zones. </para>
        </listItem>
        <listItem>
          <para>The source domain controller must have successfully registered the following resource records: </para>
          <list class="bullet">
            <listItem>
              <para>GUID-based alias (CNAME) resource record in the DNS zone _msdcs.<placeholder>ForestRootDNSDomainName</placeholder> </para>
            </listItem>
            <listItem>
              <para>Host (A) resource record in the DNS zone that corresponds to its primary DNS suffix </para>
            </listItem>
          </list>
        </listItem>
      </list>
    </content>
    <sections>
      <section address="BKMK_Potential_Failures">
        <title>Potential preliminary failures due to replication latency</title>
        <content>
          <para>At the time that the destination domain controller queries its DNS servers for the location of its source replication partner, DNS configurations might be correct on both the source and destination domain controllers, but DNS resource record registrations might be in flux as a result of configuration changes on the source domain controller. In this case, DNS lookup can fail as a result of replication latency, as follows: </para>
          <list class="bullet">
            <listItem>
              <para>If the source domain controller changes the DNS server on which it registers its alias (CNAME) and host (A) resource records, it is possible that the initial DNS server that the destination domain controller queries to resolve the name of the source domain controller is different than any of the DNS servers on which the alias (CNAME) and host (A) resource records for the source domain controller are currently registered. In this case, DNS replication latency or failures might prevent DNS records that are successfully registered on the DNS servers that the source controller uses from being located by the DNS server that the destination domain controller queries.</para>
            </listItem>
            <listItem>
              <para>If the Active Directory domain of the DNS server that the destination domain controller uses initially has a parent-child relationship with the Active Directory domain of the servers on which the source domain controller registers its resource records, the forwarder and delegation configuration on both the DNS servers that the source domain controller uses and the DNS servers that the destination domain controller uses—as well as any intermediate DNS servers that are used to resolve the DNS query—must be valid. Any required records on those DNS servers might be subject to replication latency and failure.</para>
            </listItem>
          </list>
          <para>Understanding these basic requirements for name resolution that locates the source replication partner provides a more meaningful context for working through solutions when you have replication DNS lookup problems. </para>
          <para>From the following list, choose a problem that best describes your situation, and then complete the procedures for the suggested fix:</para>
          <para>
            <link xlink:href="6460101a-f188-47c7-aa53-172422d48606">Event ID 1925: Attempt to establish a replication link failed due to DNS lookup problem</link>
          </para>
          <para>
            <link xlink:href="85b1d179-f53e-4f95-b0b8-5b1c096a8076">Event ID 2087: DNS lookup failure caused replication to fail</link>
          </para>
          <para>
            <link xlink:href="15df3aec-0e5c-41da-a7c6-7710d57f9ffd">Event ID 2088: DNS lookup failure occurred with replication success</link>
          </para>
        </content>
      </section>
    </sections>
  </section>
  <relatedTopics />
</developerConceptualDocument>