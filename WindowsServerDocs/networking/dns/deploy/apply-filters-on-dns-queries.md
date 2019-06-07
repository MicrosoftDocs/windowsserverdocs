---
title: Use DNS Policy for Applying Filters on DNS Queries
description: This topic is part of the DNS Policy Scenario Guide for Windows Server 2016
manager: brianlic
ms.prod: windows-server-threshold
ms.technology: networking-dns
ms.topic: article
ms.assetid: b86beeac-b0bb-4373-b462-ad6fa6cbedfa
ms.author: pashort
author: shortpatti
---
# Use DNS Policy for Applying Filters on DNS Queries

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn how to configure DNS policy in Windows Server&reg; 2016 to create query filters that are based on criteria that you supply. 

Query filters in DNS policy allow you to configure the DNS server to respond in a custom manner based on the DNS query and DNS client that sends the DNS query.

For example, you can configure DNS policy with query filter Block List that blocks DNS queries from known malicious domains, which prevents DNS from responding to queries from these domains. Because no response is sent from the DNS server, the malicious domain member's DNS query times out.

Another example is to create a query filter Allow List that allows only a specific set of clients to resolve certain names.

## <a name="bkmk_criteria"></a> Query filter criteria
You can create query filters with any logical combination (AND/OR/NOT) of the following criteria.

|Name|Description|
|-----------------|---------------------|
|Client Subnet|Name of a predefined client subnet. Used to verify the subnet from which the query was sent.|
|Transport Protocol|Transport protocol used in the query. Possible values are UDP and TCP.|
|Internet Protocol|Network protocol used in the query. Possible values are IPv4 and IPv6.|
|Server Interface IP address|IP address of the network interface of the DNS server that received the DNS request.|
|FQDN|Fully Qualified Domain Name of record in the query, with the possibility of using a wild card.|
|Query Type|Type of record being queried \(A, SRV, TXT, etc.\).|
|Time of Day|Time of day the query is received.|

The following examples show you how to create filters for DNS policy that either block or allow DNS name resolution queries.

>[!NOTE]
>The example commands in this topic use the Windows PowerShell command **Add-DnsServerQueryResolutionPolicy**. For more information, see [Add-DnsServerQueryResolutionPolicy](https://docs.microsoft.com/powershell/module/dnsserver/add-dnsserverqueryresolutionpolicy?view=win10-ps). 

## <a name="bkmk_block1"></a>Block queries from a domain

In some circumstances you might want to block DNS name resolution for domains that you have identified as malicious, or for domains that do not comply with the usage guidelines of your organization. You can accomplish blocking queries for domains by using DNS policy.

The policy that you configure in this example is not created on any particular zone – instead you create a Server Level Policy that is applied to all zones configured on the DNS server. Server Level Policies are the first to be evaluated and thus first to be matched when a query is received by the DNS server.

The following example command configures a Server Level Policy to block any queries with the domain **suffix contosomalicious.com**.

`
Add-DnsServerQueryResolutionPolicy -Name "BlockListPolicy" -Action IGNORE -FQDN "EQ,*.contosomalicious.com" -PassThru 
`

>[!NOTE]
>When you configure the **Action** parameter with the value **IGNORE**, the DNS server is configured to drop queries with no response at all. This causes the DNS client in the malicious domain to time out.

## <a name="bkmk_block2"></a>Block queries from a subnet
With this example, you can block queries from a subnet if it is found to be infected by some malware and is trying to contact malicious sites using your DNS server. 

`
Add-DnsServerClientSubnet -Name "MaliciousSubnet06" -IPv4Subnet 172.0.33.0/24 -PassThru

Add-DnsServerQueryResolutionPolicy -Name "BlockListPolicyMalicious06" -Action IGNORE -ClientSubnet  "EQ,MaliciousSubnet06" -PassThru
`

The following example demonstrates how you can use the subnet criteria in combination with the FQDN criteria to block queries for certain malicious domains from infected subnets.

`
Add-DnsServerQueryResolutionPolicy -Name "BlockListPolicyMalicious06" -Action IGNORE -ClientSubnet  "EQ,MaliciousSubnet06" –FQDN “EQ,*.contosomalicious.com” -PassThru
`

## <a name="bkmk_block3"></a>Block a type of query
You might need to block name resolution for certain types of queries on your servers. For example, you can block the ‘ANY’ query, which can be used maliciously to create amplification attacks.

`
Add-DnsServerQueryResolutionPolicy -Name "BlockListPolicyQType" -Action IGNORE -QType "EQ,ANY" -PassThru
`

## <a name="bkmk_allow1"></a>Allow queries only from a domain
You can not only use DNS policy to block queries, you can use them to automatically approve queries from specific domains or subnets. When you configure Allow Lists, the DNS server only processes queries from allowed domains, while blocking all other queries from other domains.

The following example command allows only computers and devices in the contoso.com and child domains to query the DNS server.

`
Add-DnsServerQueryResolutionPolicy -Name "AllowListPolicyDomain" -Action IGNORE -FQDN "NE,*.contoso.com" -PassThru 
`

## <a name="bkmk_allow2"></a>Allow queries only from a subnet
You can also create Allow Lists for IP subnets, so that all queries not originating from these subnets are ignored.

`
Add-DnsServerClientSubnet -Name "AllowedSubnet06" -IPv4Subnet 172.0.33.0/24 -PassThru
`
`
Add-DnsServerQueryResolutionPolicy -Name "AllowListPolicySubnet” -Action IGNORE -ClientSubnet  "NE, AllowedSubnet06" -PassThru
`

## <a name="bkmk_allow3"></a>Allow only certain QTypes
You can apply Allow Lists to QTYPEs. 

For example, if you have external customers querying DNS server interface 164.8.1.1, only certain QTYPEs are allowed to be queried, while there are other QTYPEs like SRV or TXT records which are used by internal servers for name resolution or for monitoring purposes.

`
Add-DnsServerQueryResolutionPolicy -Name "AllowListQType" -Action IGNORE -QType "NE,A,AAAA,MX,NS,SOA" –ServerInterface “EQ,164.8.1.1” -PassThru
`

You can create thousands of DNS policies according to your traffic management requirements, and all new policies are applied dynamically - without restarting the DNS server - on incoming queries. 
