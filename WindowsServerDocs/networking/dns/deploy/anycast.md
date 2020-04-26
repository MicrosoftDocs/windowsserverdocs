---
title: Anycast DNS overview
description: This topic provides a brief overview of Anycast DNS
manager: laurawi
ms.prod: windows-server
ms.technology: networking-dns
ms.topic: article
ms.assetid: f9c313ac-bb86-4e48-b9b9-de5004393e06
ms.author: greglin
author: greg-lindsay
---
# Anycast DNS overview

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2019

This topic provides information about how Anycast DNS works.

## What is Anycast DNS?

Anycast DNS is a method that enables a specified DNS server, or one of a group of servers, to respond to a DNS query based on the geographical location of a DNS client. 

With Anycast DNS, you can enhance DNS response time and simplify DNS client settings. Anycast DNS also provides an extra layer of redundancy and can help protect against DNS denial of service attacks. 

## How Anycast DNS works

Anycast DNS works by using routing protocols such as Border Gateway Protocol (BGP) to send DNS client queries to the closest DNS server or group of DNS servers. 

DNS servers that exist in multiple geographical locations each advertise a single, identical IP address called a <i>virtual IP address (VIP)</i> from their local gateway (router). When a DNS client query is initiated, the client's gateway evaluates which of the available routes to the destination is the shortest, and sends the DNS query to that location.

Note that routing preferences can also be adjusted to prefer one location over another irrespective of geographical location.

### Example of Anycast DNS

Following is an example of how Anycast DNS works.

1. A DNS client located in Seattle initiates a DNS query to the Anycast IP address 10.10.10.10.
2. The local router consults its route table and has two available paths. Utilizing the shortest path, it sends the packets to the SEA router.
3. The SEA router sends the query to the 10.10.10.10 destination corresponding to the SEA load balancer VIP.
4. The SEA load balancer randomly selects a DNS server from the pool of healthy, available DNS servers. In this case, the server chosen is SEA-DC16.
5. The SEA-DC16 server responds to the DNS client query. 
   - Optional: Servers have a non-AD integrated primary zone **loc.tst** that includes TXT records unique to the location and server identity for use in troubleshooting. For example, the client might issue the query **nslookup -type=TXT server.loc.tst** to determine the specific server that answered the query. All DNS servers have this zone, but only one is shown in the diagram. The zone name should be unique but can anything you choose.
6. The load balancer returns the DNS response to the SEA router.
7. The SEA router returns the DNS response to the local router.
8. The DNS client receives the DNS response from the local router.

See the following diagram:

![graphic](../../media/Anycast/anycast.png)

Background processes: 
- The SEA and LON load balancers monitor health of the DNS servers individually, and withdraw servers from the pool that are not healthy.
- The SEA and LON load balancers monitor health of their own local DNS services based on criteria specified in the load balancer configuration. If the service health drops below threshold, the 10.10.10.10 VIP is no longer announced as available, and the route is withdrawn, resulting in failover to the next closest VIP.

## Frequently asked questions

Q: Is Anycast DNS a good solution to use in an on-premises DNS environment?
A: Anycast DNS works seamlessly with an on-premises DNS service. However, Anycast is not *required* for the DNS service to scale.
 
Q: What is the impact of implementing Anycast DNS in an environment with a large number (ex: >50) of domain controllers? 
A: There is no direct impact on functionality. If a load balancer is used then no additional configuration on domain controllers is required.
 
Q: Is an Anycast DNS configuration supported by Microsoft customer service?
A: If you use a non-Microsoft load balancer to forward DNS queries, Microsoft will support issues related to the DNS Server service. Consult the load balancer vendor for issues related to DNS forwarding. 
 
Q: What is the best practice for Anycast DNS with a large number (ex: >50) of domain controllers?
A: The best practice is to use a load balancer at each geographical location, similar to the diagram shown in this article. Load balancers are typically provided by an external vendor. 

Q: Do Anycast DNS and Azure DNS have similar functionality?
A: Azure DNS uses Anycast. To use Anycast with Azure DNS, configure your load balncer to forward requests to the Azure DNS server. 