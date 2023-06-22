---
title: Scopes in DHCP server
description: This article helps you to understand how scopes work in IPv4 DHCP server. 
ms.topic: article
author: robinharwood
ms.author: wscontent
ms.custom: template-concept, team=cloud_advocates
ms.contributors: orthomas
ms.date: 07/01/2023
---

# Scopes in DHCP server

A DHCP scope is an administrative grouping of IP addresses for computers on a subnet that that the DHCP server can lease to clients. When you define one or more scopes on your DHCP server, the server can manage the distribution and assignment of IP addresses to DHCP clients. 

Scopes enable you to configure network settings for all clients, such as DNS servers and network gateways. Scopes filter hosts by name, MAC address, and even operating system before assigning an IP address. You can configure policy for each scope.

The DHCP server administrator first creates a scope for each physical subnet and then uses the scope to define the parameters and policies that clients must follow.

<!-- TYPES OF SCOPE 1. single scope - distribution of IP addreses; 2. multi-cast scope (dist. multicast network addresses; 3. scope options ... (need couple to be set ... pre-configured items (standard available options) + specific vendor-class options, e.g. extra Msft options ... custom confogurations ... define 'user classes'  4. super ) ...  -->

planning IP addresses < pull in the planning UP addresses article into this article>
address pools (see planning IP addreses) 
address leases (similar to superscopes -- these are the active leases currently in use)
reservations (the exclusions ... two methods 1. plan it with range so it doesn't include statis IP or; use this method -- exclusions)

## Scope properties

A DHCP scope has the following properties:

- A range of IP addresses from which to include or exclude addresses used for DHCP service lease offerings.

- A subnet mask, which determines the subnet prefix for a given IP address.

- A scope name assigned when it is created.

- Lease duration values, which are assigned to DHCP clients that receive dynamically allocated IP addresses.

- Any DHCP scope options configured for assignment to DHCP clients, such as DNS server IP address and router/default gateway IP address.

- Reservations are optionally used to ensure that a DHCP client always receives the same IP address.

Before deploying your servers, list your subnets and the IP address range you want to use for each subnet.

## Defining a DHCP scope

Each subnet can have only a single DHCP scope with a single continuous range of IP addresses. To use several address ranges within a single scope or subnet for DHCP service, you must first define the scope and then set any required exclusion ranges. See []() for more information on planning and setting exclusion ranges. 

## DHCP Superscope

DHCP Superscope is an administrative feature of DHCP server that you can use to group multiple scopes as a single administrative entity. See [DHCP Superscopes](../openspecs/windows_protocols/ms-dhcpm/4b3dafe4-70e5-4085-969e-4bb402d9c68b) to learn more about how to enable DHCP superscope. 

## Next steps

- [DHCP Basics](../troubleshoot/dynamic-host-configuration-protocol-basics)
- [DHCP Subnet selection options](/dhcp-subnet-options)
 