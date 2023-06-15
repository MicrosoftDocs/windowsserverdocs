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

### Define your dynamic IP address range

When you define your IP address range for each scope use the full range of consecutive IP addresses that make up the local subnet of your DHCP service. As a best practice, you want to establish the entire range of addresses and then identify the static IPs within your range. You then can identify which of the remaining IPs are available for DHCP clients to lease. 

### Static IP addresses

Before you begin, be sure to record the router’s IP address. This is the default gateway value. A best practice is to choose either the first or the last address in the static IP address range.

Your network includes servers, routers, switches, printers, and other devices that may require static IP addresses. Make a list of these devices while adding additional placeholder addresses for use as your needs expand.

If there are any IP addresses you wish to prevent clients from using, make a list of these so that you optionally can enter them manually later in the DHCP server Management Console as part of creating a new DHCP scope. See []() for more information on configuring DHCP server new scope settings.. Otherwise, you can establish the range of static IPs, including unused addresses to retain as your network inevitably grows. 

## Related links

- [DHCP Basics](../troubleshoot/dynamic-host-configuration-protocol-basics)
- [DHCP Subnet selection options](/dhcp-subnet-options)