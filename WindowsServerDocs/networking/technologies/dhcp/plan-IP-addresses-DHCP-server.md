---
title: Plan IP address ranges on a DHCP server
description: This article provides guidance on planning IP address ranges on an authorized IPv4 DHCP server. 
ms.topic: article
author: robinharwood
ms.author: wscontent
ms.custom: template-concept, team=cloud_advocates
ms.contributors: orthomas
ms.date: 07/01/2023
---

Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

# Plan IP address ranges across multiple scopes on a DHCP server

This article provides guidance on planning IP address ranges using multiple scopes on an authorized IPv4 DHCP server. 

IP address ranges must be planned prior to setting up scopes. See [Install DHCP Server](quickstart-install-configure-DHCP-server.md) for guidance on creating a new scope on an authorized DHCP IPv4 server.

## Create IP address ranges

Each subnet must have its own unique IP address range. The IP address range specifices which IP addresses to include or exclude for assignment to DHCP clients. In other words, you can select a range of IP addresses that can be used by devices connected to your DHCP service. These IP address ranges are represented on a DHCP server with scopes or groupings of IP addresses on the subnet that uses the DHCP service. 

You also can exclude specific IP addresses that you do not want clients to use. 

### Define IP address range

When you define your IP address range for each scope use the full range of consecutive IP addresses that make up the local subnet of your DHCP service. As a best practice, you want to establish the entire range of addresses before identifying the static IPs within your range. You then can identify which of the remaining IPs are available for DHCP clients to lease.

### Static IP addresses

Your network includes servers, routers, switches, printers, and other devices that may require static IP addresses. Make a list of these devices while adding additional placeholder addresses for use as your needs expand.

Before you begin recording static IP addresses, be sure to record the router’s IP address. This is the default gateway value. A best practice is to choose either the first or the last address in the static IP address range.

If there are any IP addresses you wish to prevent clients from using, make a list of these also so that you optionally can enter them manually later in the DHCP server Management Console as part of creating a new DHCP scope. See []() for more information on configuring DHCP server new scope settings. Otherwise, you can establish the range of static IPs, including unused addresses to retain as your network inevitably grows.

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
- []()

## Related links

- [DHCP Basics](../troubleshoot/dynamic-host-configuration-protocol-basics)
- [DHCP Subnet selection options](/dhcp-subnet-options)