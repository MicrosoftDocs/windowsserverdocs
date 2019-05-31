---
ms.assetid: 0fd7b6aa-3e50-45a3-a3a6-56982844363e
title: Event ID 2088 - DNS lookup failure occurred with replication success
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Event ID 2088: DNS lookup failure occurred with replication success

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

    
    <developerConceptualDocument xmlns="https://ddue.schemas.microsoft.com/authoring/2003/5" xmlns:xlink="https://www.w3.org/1999/xlink" xmlns:xsi="https://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://ddue.schemas.microsoft.com/authoring/2003/5 http://clixdevr3.blob.core.windows.net/ddueschema/developer.xsd">
      <introduction>
    <para>When a destination domain controller running Windows Server 2003 with Service Pack 1 (SP1) receives Event ID 2088 in the Directory Service event log, attempts to resolve the globally unique identifier (GUID) in the alias (CNAME) resource record to an IP address for the source domain controller failed. However, the destination domain controller tried other means to resolve the name and succeeded by using either the fully qualified domain name (FQDN) or the NetBIOS name of the source domain controller. Although replication was successful, the Domain Name System (DNS) problem should be diagnosed and resolved. </para>
    <para>The following is an example of the event text: </para>
    <code>Log Name: Directory Service

	Source: Microsoft-Windows-ActiveDirectory_DomainService
	Date: 3/15/2008  9:20:11 AM
	Event ID: 2088
	Task Category: DS RPC Client 
	Level: Warning
	Keywords: Classic
	User: ANONYMOUS LOGON
	Computer: DC3.contoso.com
	Description:
	Active Directory could not use DNS to resolve the IP address of the 
	source domain controller listed below. To maintain the consistency 
	of Security groups, group policy, users and computers and their passwords, 
	Active Directory Domain Services successfully replicated using the NetBIOS 
	or fully qualified computer name of the source domain controller. 

Invalid DNS configuration may be affecting other essential operations on 
member computers, domain controllers or application servers in this 
Active Directory Domain Services forest, including logon authentication 
or access to network resources. 

You should immediately resolve this DNS configuration error so that 
this domain controller can resolve the IP address of the source 
domain controller using DNS. 

Alternate server name: 
  DC1 
Failing DNS host name: 
  4a8717eb-8e58-456c-995a-c92e4add7e8e._msdcs.contoso.com 

NOTE: By default, only up to 10 DNS failures are shown for any given 
12 hour period, even if more than 10 failures occur.  To log all 
individual failure events, set the following diagnostics registry 
value to 1: 

Registry Path: 
HKLM\System\CurrentControlSet\Services\NTDS\Diagnostics\22 DS RPC Client 

User Action: 

1) If the source domain controller is no longer functioning or its 
operating system has been reinstalled with a different computer 
name or NTDSDSA object GUID, remove the source domain controller's 
metadata with ntdsutil.exe, using the steps outlined in MSKB article 216498. 

2) Confirm that the source domain controller is running Active Directory 
and is accessible on the network by typing "net view \\&lt;source DC name&gt;" 
or "ping &lt;source DC name&gt;". 

3) Verify that the source domain controller is using a valid DNS server 
for DNS services, and that the source domain controller's host record 
and CNAME record are correctly registered, using the DNS Enhanced 
version of DCDIAG.EXE available on <https://www.microsoft.com/dns> 

dcdiag /test:dns 

4) Verify that this destination domain controller is using a 
valid DNS server for DNS services, by running the DNS Enhanced 
version of DCDIAG.EXE command on the console of the destination 
domain controller, as follows: 

dcdiag /test:dns 

5) For further analysis of DNS error failures see KB 824449: 
<https://support.microsoft.com/?kbid=824449> 

Additional Data 
Error value: 
11004 The requested name is valid, but no data of the requested 
type was found</code>
  </introduction>
  <section>
    <title>Diagnosis</title>
    <content>
      <para>Failure to resolve the source domain controller name by using the alias (CNAME) resource record in DNS can be due to DNS misconfigurations or delays in DNS data propagation.</para>
    </content>
  </section>
  <section>
    <title>Resolution</title>
    <content>
      <para>Proceed with DNS testing as described in &quot;<link xlink:href="85b1d179-f53e-4f95-b0b8-5b1c096a8076">Event ID 2087: DNS lookup failure caused replication to fail</link>.&quot;</para>
    </content>
  </section>
  <relatedTopics />
</developerConceptualDocument>


