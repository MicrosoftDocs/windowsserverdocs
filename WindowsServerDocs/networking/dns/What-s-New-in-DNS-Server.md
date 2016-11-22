---
title: What's New in DNS Server in Windows Server 2016
description: This topic provides an overview of new features in DNS Server in Windows Server 2016
manager: dongill
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - networking-dns
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c9cecb94-3cd5-4da7-9a3e-084148b8226b
ms.author: jamesmci
author: jamesmci
---
# What's New in DNS Server in Windows Server 2016

>Applies To: Windows Server 2016

This topic describes the Domain Name System (DNS) server functionality that is new or changed in Windows Server 2016.  
  
In Windows Server 2016, DNS Server offers enhanced support in the following areas.  
  
|Functionality|New or Improved|Description|  
|-----------------|-------------------|---------------|  
|DNS Policies|New|You can configure DNS policies to specify how a DNS server responds to DNS queries. DNS responses can be based on client IP address (location), time of the day, and several other parameters. DNS policies enable location-aware DNS, traffic management, load balancing, split-brain DNS, and other scenarios.|  
|Response Rate Limiting (RRL)|New|You can enable response rate limiting on your DNS servers. By doing this, you avoid the possibility of malicious systems using your DNS servers to initiate a denial of service attack on a DNS client.|  
|DNS-based Authentication of Named Entities (DANE)|New|You can use TLSA (Transport Layer Security Authentication) records to provide information to DNS clients that state what CA they should expect a certificate from for your domain name. This prevents man-in-the-middle attacks where someone might corrupt the DNS cache to point to their won website, and provide a certificate they issued from a different CA.|  
|Unknown record support|New|You can add records which are not explicitly supported by the Windows DNS server  using the unknown record functionality.|  
|IPv6 root hints|New|You can use the native IPV6 root hints support to perform internet name resolution using the IPV6 root servers.|  
|Windows PowerShell Support|Improved|New Windows PowerShell cmdlets are available for DNS Server.|  
  
## DNS Policies  
You can create DNS policies to control how a DNS Server handles DNS queries based on different parameters. For instance, you may create a DNS policy to respond to a query asking for the IP address of a web server to respond with a different IP address based on the closest datacenter to the client.  
  
DNS Policies can be used in different scenarios, including:  
  
-   **Application high availability**. DNS clients are redirected to the healthiest endpoint for a given application.  
  
-   **Traffic Management**. DNS clients are redirected to the closest datacenter.  
  
-   **Split Brain DNS**. DNS records are split into different Zone Scopes, and DNS clients receive a response based on whether they are internal or external clients.  
  
-   **Filtering**. DNS queries from a list of malicious IP addresses or FQDNs are blocked.  
  
-   **Forensics**. Malicious DNS clients are redirected to a sink hole instead of the computer they are trying to reach.  
  
-   **Time of day based redirection**. DNS clients can be redirected to datacenters based on the time of the day.  
  
You can also use DNS policies for Active Directory integrated DNS zones.  
## Response Rate Limiting  
You can configure RRL settings to control how to respond to requests to a DNS client when your server receives several requests targeting the same client. By doing this, you can prevent someone from sending a Denial of Service (Dos) attack using your DNS servers. For instance, a bot net can send requests to your DNS server using the IP address of a third computer as the requestor. Without RRL, your DNS servers might respond to all the requests, flooding the third computer. When you use RRL, you can configure the following settings:  
  
-   **Responses per second**. This is the maximum number of times the same response will be given to a client within one second.  
  
-   **Errors per second**. This is the maximum number of times an error response will be sent to the same client within one second.  
  
-   **Window**. This is the number of seconds for which responses to a client will be suspended if too many requests are made.  
  
-   **Leak rate**. This is how frequently the DNS server will respond to a query during the time responses are suspended. For instance, if the server suspends responses to a client for 10 seconds, and the leak rate is 5, the server will still respond to one query for every 5 queries sent. This allows the legitimate clients to get responses even when the DNS server is applying response rate limiting on their subnet or FQDN.  
  
-   **TC rate**. This is used to tell the client to try connecting with TCP when responses to the client are suspended. For instance, if the TC rate is 3, and the server suspends responses to a given client, the server will issue a request for TCP connection for every 3 queries received. Make sure the value for TC rate is lower than the leak rate, to give the client the option to connect via TCP before leaking responses.  
  
-   **Maximum responses**. This is the maximum number of responses the server will issue to a client while responses are suspended.  
  
-   **White list domains**. This is a list of domains to be excluded from RRL settings.  
  
-   **White list subnets**. This is a list of subnets to be excluded from RRL settings.  
  
-   **White list server interfaces**. This is a list of DNS server interfaces to be excluded from RRL settings.  
  
## DANE support  
You can use DANE support (RFC 6394 and 6698) to specify to your DNS clients what CA they should expect certificates to be issued from for domains names hosted in your DNS server. This prevents a form of man-in-the-middle attack where someone is able to corrupt a DNS cache and point a DNS name to their own IP address.  
  
For instance, imagine you host a secure website that uses SSL at www.contoso.com by using a certificate from a well-known authority named CA1. Someone might still be able to get a certificate for www.contoso.com from a different, not-so-well-known, certificate authority named CA2. Then, the entity hosting the fake www.contoso.com website might be able to corrupt the DNS cache   of a client or server to point www.contoto.com to their fake site. The end user will be presented a certificate from CA2, and may simply acknowledge it and connect to the fake site. With DANE, the client would make a request to the DNS server for contoso.com asking for the TLSA record and learn that the certificate for www.contoso.com was issues by CA1. If presented with a certificate from another CA, the connection is aborted.  
  
## Unknown record support  
An "Unknown Record" is an RR whose RDATA format is not known to the DNS server. The newly added support for unknown record (RFC 3597) types means that you can add the unsupported record types into the Windows DNS server zones in the binary on-wire format. The windows caching resolver already has the ability to process unknown record types. Windows DNS server will not do any record specific processing for the unknown records, but will send it back in responses if queries are received for it.  
  
## IPv6 root hints  
The IPV6 root hints, as published by IANA, have been added to the windows DNS server. The internet name queries can now use IPv6 root servers for performing name resolutions.  
  
## Windows PowerShell support  
The following new Windows PowerShell cmdlets and parameters are introduced in Windows Server Technical Preview.  
  
-   **Add-DnsServerRecursionScope**. This cmdlet creates a new recursion scope on the DNS server. Recursion scopes are used by DNS policies to specify a list of forwarders to be used in a DNS query.  
  
-   **Remove-DnsServerRecursionScope**. This cmdlet removes existing recursion scopes.  
  
-   **Set-DnsServerRecursionScope**. This cmdlet changes the settings of an existing recursion scope.  
  
-   **Get-DnsServerRecursionScope**. This cmdlet retrieves information about existing recursion scopes.  
  
-   **Add-DnsServerClientSubnet**. This cmdlet creates a new DNS client subnet. Subnets are used by DNS policies to identify where a DNS client is located.  
  
-   **Remove-DnsServerClientSubnet**. This cmdlet removes existing DNS client subnets.  
  
-   **Set-DnsServerClientSubnet**. This cmdlet changes the settings of an existing DNS client subnet.  
  
-   **Get-DnsServerClientSubnet**. This cmdlet retrieves information about existing DNS client subnets.  
  
-   **Add-DnsServerQueryResolutionPolicy**. This cmdlet creates a new DNS query resolution policy. DNS query resolution policies are used to specify how, or if, a query is responded to, based on different criteria.  
  
-   **Remove-DnsServerQueryResolutionPolicy**. This cmdlet removes existing DNS policies.  
  
-   **Set-DnsServerQueryResolutionPolicy**. This cmdlet changes the settings of an existing DNS policy.  
  
-   **Get-DnsServerQueryResolutionPolicy**. This cmdlet retrieves information about existing DNS policies.  
  
-   **Enable-DnsServerPolicy**. This cmdlet enables existing DNS policies.  
  
-   **Disable-DnsServerPolicy**. This cmdlet disables existing DNS policies.  
  
-   **Add-DnsServerZoneTransferPolicy**. This cmdlet creates a new DNS server zone transfer policy. DNS zone transfer policies specify whether to deny or ignore a zone transfer based on different criteria.  
  
-   **Remove-DnsServerZoneTransferPolicy**. This cmdlet removes existing DNS server zone transfer policies.  
  
-   **Set-DnsServerZoneTransferPolicy**. This cmdlet changes settings of an existing DNS server zone transfer policy.  
  
-   **Get-DnsServerResponseRateLimiting**. This cmdlet retrieves RRL settings.  
  
-   **Set-DnsServerResponseRateLimiting**. This cmdlet changes RRL settigns.  
  
-   **Add-DnsServerResponseRateLimitingExceptionlist**. This cmdlet creates an RRL exception list on the DNS server.  
  
-   **Get-DnsServerResponseRateLimitingExceptionlist**. This cmdlet retrieves RRL excception lists.  
  
-   **Remove-DnsServerResponseRateLimitingExceptionlist**. This cmdlet removes an existing RRL exception list.  
  
-   **Set-DnsServerResponseRateLimitingExceptionlist**. This cmdlet changes RRL exception lists.  
  
-   **Add-DnsServerResourceRecord**. This cmdlet was updated to support unknown record type.  
  
-   **Get-DnsServerResourceRecord**. This cmdlet was updated to support unknown record type.  
  
-   **Remove-DnsServerResourceRecord**. This cmdlet was updated to support unknown record type.  
  
-   **Set-DnsServerResourceRecord**. This cmdlet was updated to support unknown record type  
  
## See also  
  
-   [What's New in DNS Client](What-s-New-in-DNS-Client.md)  
  

  

