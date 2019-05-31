---
title: Use DNS Policy for Application Load Balancing With Geo-Location Awareness
description: This topic is part of the DNS Policy Scenario Guide for Windows Server 2016
manager: brianlic
ms.prod: windows-server-threshold
ms.technology: networking-dns
ms.topic: article
ms.assetid: b6e679c6-4398-496c-88bc-115099f3a819
ms.author: pashort
author: shortpatti
---

# Use DNS Policy for Application Load Balancing With Geo-Location Awareness

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn how to configure DNS policy to load balance an application with geo-location awareness.

The previous topic in this guide, [Use DNS Policy for Application Load Balancing](https://technet.microsoft.com/windows-server-docs/networking/dns/deploy/app-lb), uses an example of a fictional company - Contoso Gift Services - which provides online gifting services, and which has a Web site named contosogiftservices.com. Contoso Gift Services load balances their online Web application between servers in North American datacenters located in Seattle, WA, Chicago, IL, and Dallas, TX.

>[!NOTE]
>It is recommended that you familiarize yourself with the topic [Use DNS Policy for Application Load Balancing](https://technet.microsoft.com/windows-server-docs/networking/dns/deploy/app-lb) before performing the instructions in this scenario.

This topic uses the same fictional company and network infrastructure as a basis for a new example deployment that includes geo-location awareness.

In this example, Contoso Gift Services is successfully expanding their presence across the globe.

Similar to North America, the company now has web servers hosted in European datacenters.

Contoso Gift Services DNS Administrators want to configure application load balancing for European datacenters in a similar manner to the DNS policy implementation in the United States, with application traffic distributed among Web servers that are located in Dublin, Ireland, Amsterdam, Holland, and elsewhere.

DNS Administrators also want all queries from other locations in the world distributed equally between all of their datacenters.

In the next sections you can learn how to achieve similar goals to those of the Contoso DNS Administrators on your own network.

## How to Configure Application Load Balancing with Geo-Location Awareness

The following sections show you how to configure DNS policy for application load balancing with geo-location awareness.

>[!IMPORTANT]
>The following sections include example Windows PowerShell commands that contain example values for many parameters. Ensure that you replace example values in these commands with values that are appropriate for your deployment before you run these commands.

### <a name="bkmk_clientsubnets"></a>Create the DNS Client Subnets

You must first identify the subnets or IP address space of the North America and Europe regions.

You can obtain this information from Geo-IP maps. Based on these Geo-IP distributions, you must create the DNS Client Subnets.

A DNS Client Subnet is a logical grouping of IPv4 or IPv6 subnets from which queries are sent to a DNS server.

You can use the following Windows PowerShell commands to create DNS Client Subnets. 

    
    Add-DnsServerClientSubnet -Name "AmericaSubnet" -IPv4Subnet 192.0.0.0/24,182.0.0.0/24
    Add-DnsServerClientSubnet -Name "EuropeSubnet" -IPv4Subnet 141.1.0.0/24,151.1.0.0/24
    
For more information, see [Add-DnsServerClientSubnet](https://docs.microsoft.com/powershell/module/dnsserver/add-dnsserverclientsubnet?view=win10-ps).

### <a name="bkmk_zscopes2"></a>Create the Zone Scopes

After the client subnets are in place, you must partition the zone contosogiftservices.com into different zone scopes, each for a datacenter.

A zone scope is a unique instance of the zone. A DNS zone can have multiple zone scopes, with each zone scope containing its own set of DNS records. The same record can be present in multiple scopes, with different IP addresses or the same IP addresses.

>[!NOTE]
>By default, a zone scope exists on the DNS zones. This zone scope has the same name as the zone, and legacy DNS operations work on this scope.

The previous scenario on application load balancing demonstrates how to configure three zone scopes for datacenters in North America.

With the commands below, you can create two more zone scopes, one each for the Dublin and Amsterdam datacenters. 

You can add these zone scopes without any changes to the three existing North America zone scopes in the same zone. In addition, after you create these zone scopes, you do not need to restart your DNS server.

You can use the following Windows PowerShell commands to create zone scopes.

    
    Add-DnsServerZoneScope -ZoneName "contosogiftservices.com" -Name "DublinZoneScope"
    Add-DnsServerZoneScope -ZoneName "contosogiftservices.com" -Name "AmsterdamZoneScope"
    

For more information, see [Add-DnsServerZoneScope](https://docs.microsoft.com/powershell/module/dnsserver/add-dnsserverzonescope?view=win10-ps)

### <a name="bkmk_records2"></a>Add Records to the Zone Scopes

Now you must add the records representing the web server host into the zone scopes.

The records for the America datacenters were added in the previous scenario. You can use the following Windows PowerShell commands to add records to the zone scopes for European datacenters.
 
    
    Add-DnsServerResourceRecord -ZoneName "contosogiftservices.com" -A -Name "www" -IPv4Address "151.1.0.1" -ZoneScope "DublinZoneScope”
    Add-DnsServerResourceRecord -ZoneName "contosogiftservices.com" -A -Name "www" -IPv4Address "141.1.0.1" -ZoneScope "AmsterdamZoneScope"
    

For more information, see [Add-DnsServerResourceRecord](https://docs.microsoft.com/powershell/module/dnsserver/add-dnsserverresourcerecord?view=win10-ps).

### <a name="bkmk_policies2"></a>Create the DNS Policies

After you have created the partitions (zone scopes) and you have added records, you must create DNS policies that distribute the incoming queries across these scopes.

For this example, query distribution across application servers in different datacenters meets the following criteria.

1. When the DNS query is received from a source in a North American client subnet, 50% of the DNS responses point to the Seattle data center, 25% of responses point to the Chicago datacenter, and the remaining 25% of responses point to the Dallas datacenter.
2. When the DNS query is received from a source in a European client subnet, 50% of the DNS responses point to the Dublin datacenter, and 50% of the DNS responses point to the Amsterdam datacenter.
3. When the query comes from anywhere else in the world, the DNS responses are distributed across all five datacenters.

You can use the following Windows PowerShell commands to implement these DNS policies.

    
    Add-DnsServerQueryResolutionPolicy -Name "AmericaLBPolicy" -Action ALLOW -ClientSubnet "eq,AmericaSubnet" -ZoneScope "SeattleZoneScope,2;ChicagoZoneScope,1; TexasZoneScope,1" -ZoneName "contosogiftservices.com" –ProcessingOrder 1
    
    Add-DnsServerQueryResolutionPolicy -Name "EuropeLBPolicy" -Action ALLOW -ClientSubnet "eq,EuropeSubnet" -ZoneScope "DublinZoneScope,1;AmsterdamZoneScope,1" -ZoneName "contosogiftservices.com" -ProcessingOrder 2
    
    Add-DnsServerQueryResolutionPolicy -Name "WorldWidePolicy" -Action ALLOW -FQDN "eq,*.contoso.com" -ZoneScope "SeattleZoneScope,1;ChicagoZoneScope,1; TexasZoneScope,1;DublinZoneScope,1;AmsterdamZoneScope,1" -ZoneName "contosogiftservices.com" -ProcessingOrder 3
    
    

For more information, see [Add-DnsServerQueryResolutionPolicy](https://docs.microsoft.com/powershell/module/dnsserver/add-dnsserverqueryresolutionpolicy?view=win10-ps).

You have now successfully created a DNS policy that provides application load balancing across Web servers that are located in five different datacenters on multiple continents.

You can create thousands of DNS policies according to your traffic management requirements, and all new policies are applied dynamically - without restarting the DNS server - on incoming queries.
