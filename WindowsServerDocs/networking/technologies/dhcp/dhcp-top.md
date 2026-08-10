---
title: What is DHCP Server in Windows Server?
description: Discover how Windows Server DHCP simplifies automated IP management, reduces configuration errors, and enhances network efficiency with this powerful protocol.
ms.topic: overview
ms.author: roharwoo
author: robinharwood
ai-usage: ai-assisted
ms.date: 05/13/2025
#customer intent: As a network administrator, I want to understand the benefits of using DHCP in Windows Server so that I can automate IP address management and reduce configuration errors.
---

# What is Dynamic Host Configuration Protocol (DHCP) Server in Windows Server?

Dynamic Host Configuration Protocol (DHCP) Server in Windows Server automates the assignment and management of IP addresses and related network configurations. By centralizing these tasks, DHCP Server reduces manual effort, minimizes errors, and ensures efficient use of IP address resources across your network.

Windows Server includes DHCP Server as an optional networking server role that you can deploy to manage and offer IP addresses leases and other information to DHCP clients. All Windows-based client operating systems include the DHCP client as part of TCP/IP, and DHCP client is enabled by default.

Dynamic Host Configuration Protocol (DHCP) is a client/server protocol that automatically provides an Internet Protocol (IP) host with its IP address and other related configuration information such as the subnet mask and default gateway. RFCs 2131 and 2132 define DHCP as an Internet Engineering Task Force (IETF) standard based on Bootstrap Protocol (BOOTP), a protocol with which DHCP shares many implementation details. DHCP allows hosts to obtain required TCP/IP configuration information from a DHCP server.

## Why use DHCP?

Every device on a TCP/IP-based network must have a unique unicast IP address to access the network and its resources. Without DHCP, IP addresses for new computers or computers that are moved from one subnet to another must be configured manually; IP addresses for computers that are removed from the network must be manually reclaimed.

With DHCP, this entire process is automated and managed centrally. The DHCP server maintains a pool of IP addresses and leases an address to any DHCP-enabled client when it starts up on the network. Because the IP addresses are dynamic (leased) rather than static (permanently assigned), addresses no longer in use are automatically returned to the pool for reallocation.

The network administrator establishes DHCP servers that maintain TCP/IP configuration information and provide address configuration to DHCP-enabled clients in the form of a lease offer. The DHCP server stores the configuration information in a database that includes:

- Valid TCP/IP configuration parameters for all clients on the network.

- Valid IP addresses, maintained in a pool for assignment to clients, as well as excluded addresses.

- Reserved IP addresses associated with particular DHCP clients. This allows consistent assignment of a single IP address to a single DHCP client.

- The lease duration, or the length of time for which the IP address can be used before a lease renewal is required.

A DHCP-enabled client, upon accepting a lease offer, receives:

- A valid IP address for the subnet to which it is connecting.

- Requested DHCP options, which are additional parameters that a DHCP server is configured to assign to clients. Some examples of DHCP options are Router (default gateway), DNS Servers, and DNS Domain Name.

## Benefits of DHCP Server

DHCP provides the following benefits.

- **Reliable IP address configuration**. DHCP minimizes configuration errors caused by manual IP address configuration, such as typographical errors, or address conflicts caused by the assignment of an IP address to more than one computer at the same time.

- **Reduced network administration**. DHCP includes the following features to reduce network administration:

  - Centralized and automated TCP/IP configuration.

  - The ability to define TCP/IP configurations from a central location.

  - The ability to assign a full range of additional TCP/IP configuration values by means of DHCP options.

  - The efficient handling of IP address changes for clients that must be updated frequently, such as those for portable devices that move to different locations on a wireless network.

  - The forwarding of initial DHCP messages by using a DHCP relay agent, which eliminates the need for a DHCP server on every subnet.

## DHCP Server features

DHCP Server in Windows Server includes the following features:

- **DHCP policies**. This feature allows you to create policies that apply DHCP options and setting based on client characteristics, such as MAC address or vendor class.

- **DHCP audit logging**. This feature allows you to track DHCP server activity, including lease assignments and renewals.

- **DHCP server management**. This feature allows you to manage DHCP servers using Windows PowerShell, the DHCP console, or the Windows Admin Center.

- **DHCP server authorization**. This feature allows you to authorize DHCP servers in Active Directory, preventing unauthorized servers from providing IP addresses to clients.

- **DHCP server integration with DNS**. Dynamic DNS automatically update DNS records when DHCP leases are assigned or renewed, ensuring that clients can resolve hostnames to IP addresses.

- **DHCP server integration with IPv4 and IPv6**. This feature allows you to assign both IPv4 and IPv6 addresses to clients using DHCP, providing support for both IP addressing standards.

- **DHCP failover**. This feature allows two DHCP servers to share a single scope, providing redundancy and load balancing.

- **DHCP server integration with IPAM**. This feature allows you to manage DHCP servers using IP Address Management (IPAM), providing a centralized location for managing IP address assignments and leases.

## Get started with DHCP

To learn how to install and configure DHCP in Windows Server, see [Quickstart: Install and configure DHCP Server](quickstart-install-configure-dhcp-server.md).
