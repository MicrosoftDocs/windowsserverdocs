---
title: DHCP scopes in Windows Server
description: Learn about how scopes work in DHCP server and how to design IP address ranges.
ms.topic: conceptual
author: robinharwood
ms.author: wscontent
ms.custom: template-concept, team=cloud_advocates
ms.contributors: orthomas
ms.date: 08/11/2023
---

# DHCP scopes

A Dynamic Host Configuration Protocol (DHCP) scope is an administrative grouping of IP addresses for computers on a subnet that the DHCP server can lease to clients. When you define one or more scopes on your DHCP server, the server can manage the distribution and assignment of IP addresses to DHCP clients.

Scopes enable you to configure network settings for all clients, such as Domain Name System (DNS) servers and network gateways. Scopes filter hosts by name, MAC address, and even operating system before assigning an IP address. You can configure policy for each scope.

This article explains the different types of scopes, their option, and how to plan for creating your scope. If you're looking for information about how to create and configure a DHCP scope, see [Quickstart: Install and configure DHCP Server](quickstart-install-configure-dhcp-server.md) instead. Before creating your new scope, you should also plan the range of IP addresses it should use.

## Types of scopes

DHCP server includes the following types of scopes:

- Single scope.
- Multicast scope.
- DHCP Superscopes.

### Single scope

A single scope is the simplest configuration possible in DHCP. A single scope is a range of IP addresses and associated configuration options allocated to DHCP clients in a specific subnet.

Additionally, a typical DHCP scope has the following properties:

- A range of IP addresses from which to include or exclude addresses used for DHCP service lease offerings.

- A subnet mask, which determines the subnet prefix for a given IP address.

- A scope name that's automatically assigned when you create the scope.

- Lease duration values, which are assigned to DHCP clients that receive dynamically allocated IP addresses.

- Any DHCP scope options configured for assignment to DHCP clients, such as DNS server, router, and default gateway IP addresses.

- Reservations are optionally used to ensure that a DHCP client always receives the same IP address.

Before you deploy your DHCP server, list your subnets, and the IP address range you want to use for each subnet.

Other types of scopes available in an authorized IPv4 DHCP server can provide expanded functionality, depending on your user requirements and deployment considerations.

### Multicast scope

Multicasting in Windows is the process of sending a message to a group of recipients, in contrast to a message that's sent to a specific recipient. In a single-scope setup, DHCP assigns each client a single unique IP address from a range of IP addresses that you planned and configured prior to activating the scope. In contrast, a multicast scope is a group of IP multicast network addresses that the DHCP server can distribute to other computers in your network using the Multicast Address Dynamic Client Allocation Protocol (MADCAP). MADCAP controls how the DHCP server dynamically assigns IP addresses. For more information about how MADCAP works, see [RFC2730](https://www.rfc-editor.org/rfc/rfc2730).

### DHCP Superscopes

DHCP Superscopes are an administrative feature of DHCP server you can use to group multiple scopes as a single administrative entity. Superscopes make it easier to identify which scopes reside within which networks. In an environment with multiple subnets defined on a single physical network, superscopes enable your DHCP server to assign leases to clients across those multiple subnets. See [DHCP Superscopes](/openspecs/windows_protocols/ms-dhcpm/4b3dafe4-70e5-4085-969e-4bb402d9c68b) to learn more about how to enable DHCP Superscopes.

## Scope options

Scope options you configure at the server level are applied to all DHCP clients regardless of which subnet they're on. If you want a certain functionality to be available across all DHCP clients, you should configure it at the server level. These standard options include:

- Default gateway.
- Domain Name and DNS servers.
- Windows Internet Name Service (WINS) servers.

In addition to standard options, you can configure user-defined or vendor-specific classes.

## Define a DHCP scope

Each subnet can have only a single DHCP scope with a single continuous range of IP addresses. To use several address ranges within a single scope or subnet for DHCP service, you must first define the scope, then set any required exclusion ranges. The following sections describe how to plan for exclusion ranges.

### Plan address ranges

Planning IP address ranges across multiple scopes on an authorized IPv4 DHCP server is central to understanding how scopes work and successfully creating new scopes.

Each subnet must have its own unique IP address range. The IP address range specifies which IP addresses to include or exclude for assignment to DHCP clients. In other words, An IP address range lets you select which addresses devices connected to your DHCP can use. IP address ranges are represented on a DHCP server as scopes or groupings of IP addresses on the subnet that uses the DHCP service. You also can exclude specific IP addresses that you don't want clients to use.

When you define your IP address range for each scope, you must use the full range of consecutive IP addresses that make up the local subnet of your DHCP service. We highly recommend you establish the entire range of addresses before identifying the static IPs within your range. After you establish the range, it's easier for you to identify which of the remaining IPs are available for DHCP clients to lease.

You must plan IP address ranges before setting up scopes. To learn more about how to create new scopes on an authorized DHCP IPv4 server, see [Install DHCP Server](quickstart-install-configure-DHCP-server.md).

### Reservations

Your network includes servers, routers, switches, printers, and other devices that can require reserved (static) IP addresses. It's a good idea to make a list of these devices, including extra placeholder addresses for you to use as your needs expand. A DHCP reservation is a preset IP address that’s provided by your DHCP server and given to a Network Interface Card (NIC) when a NIC calls out to a DHCP server for an IP address. Keep in mind that a device must support DHCP to use reservations.

You can use reservations to assign an IP address to a specific client device (NIC) based on its MAC address. The device always receives the same IP address, and the address never changes. The device is dependent on your DHCP Server after you configure the reservation. If the DHCP server experiences issues and shuts down, the DHCP reservation device also becomes unavailable.

Reservations give you the ability to change IP addresses readily without having to sign in to a device. You also can manage IP addresses for third-party devices if they're set to DHCP.

### Exclusion ranges

There are certain scenarios where you may need to manually configure servers or other devices with static IP addresses from the same IP address range as the DHCP server. In these situations, it's possible to unintentionally create an IP address conflict in which you and the DHCP server both assign the same IP address to different devices.

To prevent address conflicts, you can create an exclusion range for the DHCP scope. An exclusion range is a contiguous range of IP addresses within the scope's IP address range that the DHCP server isn't allowed to use. If you create an exclusion range, the DHCP server doesn't assign addresses to that range, allowing you to manually assign these addresses without creating an IP address conflict.

You should use exclusions for all devices configured with a static IP address. The excluded addresses should include all IP addresses you assigned manually to other servers, non-DHCP clients, diskless workstations, or Routing and Remote Access and Point-to-Point Protocol (PPP) clients.

We recommend you configure your exclusion range with extra placeholder addresses to accommodate future network growth. The following table provides an example exclusion range for a scope with an IP address range of 10.0.0.1 to 10.0.0.254 and a subnet mask of 255.255.255.0.

|Configuration items|Example values|
|-----------------------|------------------|
|Exclusion range Start IP Address|10.0.0.1|
|Exclusion range End IP Address|10.0.0.25|

## Next steps

Learn more about DHCP scopes at the following resources:

- [DHCP (Dynamic Host Configuration Protocol) Basics](../../../troubleshoot/dynamic-host-configuration-protocol-basics.md)
- [DHCP Subnet Selection Options](dhcp-subnet-options.md)
- [Quickstart: Install and configure DHCP Server](quickstart-install-configure-dhcp-server.md)