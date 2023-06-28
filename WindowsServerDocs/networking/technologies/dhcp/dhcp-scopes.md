---
title: DHCP scopes in Windows Server
description: Learn about how scopes work in DHCP server and how to design IP address ranges.
ms.topic: article
author: robinharwood
ms.author: wscontent
ms.custom: template-concept, team=cloud_advocates
ms.contributors: orthomas
ms.date: 07/10/2023
---

# DHCP scopes

A DHCP scope is an administrative grouping of IP addresses for computers on a subnet that that the DHCP server can lease to clients. When you define one or more scopes on your DHCP server, the server can manage the distribution and assignment of IP addresses to DHCP clients.

Scopes enable you to configure network settings for all clients, such as DNS servers and network gateways. Scopes filter hosts by name, MAC address, and even operating system before assigning an IP address. You can configure policy for each scope.

You will first create a scope for each physical subnet and then use that scope to define the parameters and policies that clients must follow.

Before creating your new scope, you also must devote time to planning the IP address ranges it will use.

## Types of scopes

DHCP server includes the following types of scopes:

- Single scope
- Multicast scope
- DHCP Superscopes

### Single scope

A single scope is the simplest configuration possible in DHCP. A single scope is a range of IP addresses and associated configuration options allocated to DHCP clients in a specific subnet.

Additionally, a typical DHCP scope has the following properties:

- A range of IP addresses from which to include or exclude addresses used for DHCP service lease offerings.

- A subnet mask, which determines the subnet prefix for a given IP address.

- A scope name assigned when it is created.

- Lease duration values, which are assigned to DHCP clients that receive dynamically allocated IP addresses.

- Any DHCP scope options configured for assignment to DHCP clients, such as DNS server IP address and router/default gateway IP address.

- Reservations are optionally used to ensure that a DHCP client always receives the same IP address.

Before deploying your DHCP server, list your subnets and the IP address range you want to use for each subnet. 

Other types of scopes available in an authorized IPv4 DHCP server can provide expanded functionality, depending on your user requirements and deployment considerations:

### Multicast scope

Multicasting in Windows is the process of sending a message to a group of recipients, in contrast to a message that's sent to a specific recipient. In a single scope setup, DHCP assigns each client a single unique IP address from a range of IP addresses that you planned and configured prior to activating the scope. A multicast scope is a group of IP multicast network addresses that can be distributed by the DHCP server to other computers in your network using the Multicast Address Dynamic Client Allocation Protocol (MADCAP). MADCAP controls how the DHCP server dynamically assigns IP addresses. See [RFC2730](https://www.rfc-editor.org/rfc/rfc2730) for more information on MADCAP. 

### DHCP Superscopes

DHCP Superscopes is an administrative feature of DHCP server that you can use to group multiple scopes as a single administrative entity. Superscopes simplify the identification of which scopes reside within which networks. In an environment with multiple subnets defined on a single physical network, superscopes enable your DHCP server to assign leases to clients across those multiple subnets. See [DHCP Superscopes](../openspecs/windows_protocols/ms-dhcpm/4b3dafe4-70e5-4085-969e-4bb402d9c68b) to learn more about how to enable DHCP superscope.

## Scope options

Scope options configured at the server level will be applied to all DHCP clients regardless of which subnet they are on. Functionality that you want to be present across all DHCP clients should be configured at the server level. These standard options include:

- Default gateway
- Domain Name and DNS servers
- WINS servers

In addition to standard options, you can configure user-defined or vendor-specific classes.

## Defining a DHCP scope

Each subnet can have only a single DHCP scope with a single continuous range of IP addresses. To use several address ranges within a single scope or subnet for DHCP service, you must first define the scope and then set any required exclusion ranges. The following section of this article provides guidance on planning for exclusion ranges.

## Planning address ranges

Planning IP address ranges across multiple scopes on an authorized IPv4 DHCP server is central to understanding how scopes work and successfully creating new scopes. 

IP address ranges must be planned prior to setting up scopes. See [Install DHCP Server](quickstart-install-configure-DHCP-server.md) for guidance on creating a new scope on an authorized DHCP IPv4 server.

## Creating IP address ranges

Each subnet must have its own unique IP address range. The IP address range specifices which IP addresses to include or exclude for assignment to DHCP clients. In other words, you can select a range of IP addresses that can be used by devices connected to your DHCP service. These IP address ranges are represented on a DHCP server with scopes or groupings of IP addresses on the subnet that uses the DHCP service. 

You also can exclude specific IP addresses that you do not want clients to use. 

### Defining IP address range

When you define your IP address range for each scope use the full range of consecutive IP addresses that make up the local subnet of your DHCP service. As a best practice, you want to establish the entire range of addresses before identifying the static IPs within your range. You then can identify which of the remaining IPs are available for DHCP clients to lease.

### Reservations

Your network includes servers, routers, switches, printers, and other devices that can require reserved (static) IP addresses. It's a good idea to make a list of these devices and even adding additional placeholder addresses for use as your needs expand. A DHCP reservation is a pre-set IP address that’s provided by your DHCP server and given to a NIC when a NIC calls out to a DHCP server for an IP address. Keep in mind that a device must support DHCP to use reservations.

You can use reservations to assign an IP address to a specific client device (NIC) based on its MAC address. The device always receives the same IP address; it'll never change. A main disadvantage is that the device is competely dependent on your DHCP Server after the reservation is configured; if the DHCP server experiences issues and goes down, the DHCP reservation device will not be available.

Reservations give you the ability to change IP addresses readily without having to log in to a device. You also can manage IP addresses for third-party devices if they are also set to DHCP.

### Exclusion ranges

It might become necessary to manually configure some servers and other devices with static IP addresses from the same IP address range that the DHCP server is using. When you manually configure some servers and other devices with static IP addresses from the same IP address range that the DHCP server is using, it is possible to unintentionally create an IP address conflict in which you and the DHCP server both assign the same IP address to different devices.

To solve this problem, you can create an exclusion range for the DHCP scope. An exclusion range is a contiguous range of IP addresses within the scope's IP address range that the DHCP server is not allowed to use. If you create an exclusion range, the DHCP server won't assign the addresses in that range, allowing you to manually assign these addresses without creating an IP address conflict.

You should use exclusions for all devices that are configured with a static IP address. The excluded addresses should include all IP addresses that you assigned manually to other servers, non-DHCP clients, diskless workstations, or Routing and Remote Access and PPP clients. A simple spreadsheet can assist you in keeping track of your addresses and the purpose of each. 

It is recommended that you configure your exclusion range with extra addresses to accommodate future network growth. The following table provides an example exclusion range for a scope with an IP address range of 10.0.0.1 - 10.0.0.254 and a subnet mask of 255.255.255.0.

|Configuration items|Example values|
|-----------------------|------------------|
|Exclusion range Start IP Address|10.0.0.1|
|Exclusion range End IP Address|10.0.0.25|

## Related links

- [DHCP Basics](../troubleshoot/dynamic-host-configuration-protocol-basics)
- [DHCP Subnet selection options](/dhcp-subnet-options)
- [Install DHCP server]()