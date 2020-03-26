---
title: Use DNS Policy for Application Load Balancing
description: This topic is part of the DNS Policy Scenario Guide for Windows Server 2016
manager: brianlic
ms.prod: windows-server
ms.technology: networking-dns
ms.topic: article
ms.assetid: f9c313ac-bb86-4e48-b9b9-de5004393e06
ms.author: lizross
author: eross-msft
---
# Use DNS Policy for Application Load Balancing

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn how to configure DNS policy to perform application load balancing.

Previous versions of Windows Server DNS only provided load balancing by using round robin responses; but with DNS in Windows Server 2016, you can configure DNS policy for application load balancing.

When you have deployed multiple instances of an application, you can use DNS policy to balance the traffic load between the different application instances, thereby dynamically allocating the traffic load for the application.

## Example of Application Load Balancing

Following is an example of how you can use DNS policy for application load balancing.

This example uses one fictional company - Contoso Gift Services - which provides online gifing services, and which has a Web site named **contosogiftservices.com**.

The contosogiftservices.com website is hosted in multiple datacenters that each have different IP addresses.

In North America, which is the primary market for Contoso Gift Services, the Web site is hosted in three datacenters: Chicago, IL, Dallas, TX and Seattle, WA.

The Seattle Web server has the best hardware configuration and can handle twice as much load as the other two sites. Contoso Gift Services wants application traffic directed in the following manner.

- Because the Seattle Web server includes more resources, half of the application's clients are directed to this server
- One quarter of the application's clients are directed to the Dallas, TX datacenter
- One quarter of the application's clients are directed to the Chicago, IL, datacenter

The following illustration depicts this scenario.

![DNS Application Load Balancing with DNS Policy](../../media/Dns-App-Lb/dns-app-lb.jpg)


### How Application Load Balancing Works

After you have configured the DNS server with DNS policy for application load balancing using this example scenario, the DNS server responds 50% of the time with the Seattle Web server address, 25% of the time with the Dallas Web server address, and 25% of the time with the Chicago Web server address.

Thus for every four queries the DNS server receives, it responds with two responses for Seattle and one each for Dallas and Chicago.

One possible issue with load balancing with DNS policy is the caching of DNS records by the DNS client and the resolver/LDNS, which can interfere with load balancing because the client or resolver do not send a query to the DNS server.

You can mitigate the effect of this behavior by using a low Time\-to\-Live \(TTL\) value for the DNS records that should be load balanced.

### How to Configure Application Load Balancing

The following sections show you how to configure DNS policy for application load balancing.

#### Create the Zone Scopes

You must first create the scopes of the zone contosogiftservices.com for the datacenters where they are hosted.

A zone scope is a unique instance of the zone. A DNS zone can have multiple zone scopes, with each zone scope containing its own set of DNS records. The same record can be present in multiple scopes, with different IP addresses or the same IP addresses.

>[!NOTE]
>By default, a zone scope exists on the DNS zones. This zone scope has the same name as the zone, and legacy DNS operations work on this scope.

You can use the following Windows PowerShell commands to create zone scopes.
    
    Add-DnsServerZoneScope -ZoneName "contosogiftservices.com" -Name "SeattleZoneScope"
    
    Add-DnsServerZoneScope -ZoneName "contosogiftservices.com" -Name "DallasZoneScope"
    
    Add-DnsServerZoneScope -ZoneName "contosogiftservices.com" -Name "ChicagoZoneScope"

For more information, see [Add-DnsServerZoneScope](https://docs.microsoft.com/powershell/module/dnsserver/add-dnsserverzonescope?view=win10-ps)

#### <a name="bkmk_records"></a>Add Records to the Zone Scopes

Now you must add the records representing the web server host into the zone scopes.

In **SeattleZoneScope**, you can add the record www.contosogiftservices.com with IP address 192.0.0.1, which is located in the Seattle datacenter.

In **ChicagoZoneScope**, you can add the same record \(www.contosogiftservices.com\) with IP address 182.0.0.1 in the Chicago datacenter.

Similarly in **DallasZoneScope**, you can add a record \(www.contosogiftservices.com\) with IP address 162.0.0.1 in the Chicago datacenter.

You can use the following Windows PowerShell commands to add records to the zone scopes.
    
    Add-DnsServerResourceRecord -ZoneName "contosogiftservices.com" -A -Name "www" -IPv4Address "192.0.0.1" -ZoneScope "SeattleZoneScope
    
    Add-DnsServerResourceRecord -ZoneName "contosogiftservices.com" -A -Name "www" -IPv4Address "182.0.0.1" -ZoneScope "ChicagoZoneScope"
    
    Add-DnsServerResourceRecord -ZoneName "contosogiftservices.com" -A -Name "www" -IPv4Address "162.0.0.1" -ZoneScope "DallasZoneScope"
    

For more information, see [Add-DnsServerResourceRecord](https://docs.microsoft.com/powershell/module/dnsserver/add-dnsserverresourcerecord?view=win10-ps).

#### <a name="bkmk_policies"></a>Create the DNS Policies

After you have created the partitions (zone scopes) and you have added records, you must create DNS policies that distribute the incoming queries across these scopes so that 50% of queries for contosogiftservices.com are responded to with the IP address for the Web server in the Seattle datacenter and the rest are equally distributed between the Chicago and Dallas datacenters.

You can use the following Windows PowerShell commands to create a DNS policy that balances application traffic across these three datacenters.

>[!NOTE]
>In the example command below, the expression –ZoneScope "SeattleZoneScope,2; ChicagoZoneScope,1; DallasZoneScope,1" configures the DNS server with an array that includes the parameter combination \<ZoneScope\>,\<weight\>.
    
    Add-DnsServerQueryResolutionPolicy -Name "AmericaPolicy" -Action ALLOW -ZoneScope "SeattleZoneScope,2;ChicagoZoneScope,1;DallasZoneScope,1" -ZoneName "contosogiftservices.com"
    

For more information, see [Add-DnsServerQueryResolutionPolicy](https://docs.microsoft.com/powershell/module/dnsserver/add-dnsserverqueryresolutionpolicy?view=win10-ps).  

You have now successfully created a DNS policy that provides application load balancing across Web servers in three different datacenters.

You can create thousands of DNS policies according to your traffic management requirements, and all new policies are applied dynamically - without restarting the DNS server - on incoming queries.
