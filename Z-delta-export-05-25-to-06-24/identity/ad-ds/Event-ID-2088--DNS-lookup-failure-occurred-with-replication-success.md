---
title: Event ID 2088: DNS lookup failure occurred with replication success
H1: na
ms.custom: 
  - x
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: 15df3aec-0e5c-41da-a7c6-7710d57f9ffd
---
# Event ID 2088: DNS lookup failure occurred with replication success
When a destination domain controller running Windows Server 2003 with Service Pack 1 \(SP1\) receives Event ID 2088 in the Directory Service event log, attempts to resolve the globally unique identifier \(GUID\) in the alias \(CNAME\) resource record to an IP address for the source domain controller failed. However, the destination domain controller tried other means to resolve the name and succeeded by using either the fully qualified domain name \(FQDN\) or the NetBIOS name of the source domain controller. Although replication was successful, the Domain Name System \(DNS\) problem should be diagnosed and resolved.  
  
 The following is an example of the event text:  
  
```  
Log Name: Directory Service  
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
and is accessible on the network by typing "net view \\<source DC name>"   
or "ping <source DC name>".   
  
3) Verify that the source domain controller is using a valid DNS server   
for DNS services, and that the source domain controller's host record   
and CNAME record are correctly registered, using the DNS Enhanced   
version of DCDIAG.EXE available on http://www.microsoft.com/dns   
  
dcdiag /test:dns   
  
4) Verify that this destination domain controller is using a   
valid DNS server for DNS services, by running the DNS Enhanced   
version of DCDIAG.EXE command on the console of the destination   
domain controller, as follows:   
  
dcdiag /test:dns   
  
5) For further analysis of DNS error failures see KB 824449:   
http://support.microsoft.com/?kbid=824449   
  
Additional Data   
Error value:   
11004 The requested name is valid, but no data of the requested   
type was found  
```  
  
## Diagnosis  
 Failure to resolve the source domain controller name by using the alias \(CNAME\) resource record in DNS can be due to DNS misconfigurations or delays in DNS data propagation.  
  
## Resolution  
 Proceed with DNS testing as described in "[Event ID 2087: DNS lookup failure caused replication to fail](../Topic/Event%20ID%202087:%20DNS%20lookup%20failure%20caused%20replication%20to%20fail.md)."