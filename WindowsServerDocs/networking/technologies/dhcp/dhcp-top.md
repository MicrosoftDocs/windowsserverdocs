---
title: Dynamic Host Configuration Protocol (DHCP)
description: This topic provides a brief overview of Dynamic Host Configuration Protocol (DHCP) in Windows Server 2016. 
manager: brianlic
ms.prod: windows-server
ms.technology: networking-dhcp
ms.topic: article
ms.assetid: 0ff29ef3-c458-4432-9065-e50a7de5b4b9
ms.author: lizross
author: eross-msft
---
# Dynamic Host Configuration Protocol (DHCP)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic for a brief overview of DHCP in Windows Server 2016.

> [!NOTE]
> In addition to this topic, the following DHCP documentation is available.
>
> - [What's New in DHCP](What-s-New-in-DHCP.md)
> - [Deploy DHCP Using Windows PowerShell](dhcp-deploy-wps.md)

Dynamic Host Configuration Protocol (DHCP) is a client/server protocol that automatically provides an Internet Protocol (IP) host with its IP address and other related configuration information such as the subnet mask and default gateway. RFCs 2131 and 2132 define DHCP as an Internet Engineering Task Force (IETF) standard based on Bootstrap Protocol (BOOTP), a protocol with which DHCP shares many implementation details. DHCP allows hosts to obtain required TCP/IP configuration information from a DHCP server.

Windows Server 2016 includes DHCP Server, which is an optional networking server role that you can deploy on your network to lease IP addresses and other information to DHCP clients. All Windows-based client operating systems include the DHCP client as part of TCP/IP, and DHCP client is enabled by default.

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

## Benefits of DHCP

DHCP provides the following benefits.

- **Reliable IP address configuration**. DHCP minimizes configuration errors caused by manual IP address configuration, such as typographical errors, or address conflicts caused by the assignment of an IP address to more than one computer at the same time.

- **Reduced network administration**. DHCP includes the following features to reduce network administration:

    - Centralized and automated TCP/IP configuration.

    - The ability to define TCP/IP configurations from a central location.

    - The ability to assign a full range of additional TCP/IP configuration values by means of DHCP options.

    - The efficient handling of IP address changes for clients that must be updated frequently, such as those for portable devices that move to different locations on a wireless network.

    - The forwarding of initial DHCP messages by using a DHCP relay agent, which eliminates the need for a DHCP server on every subnet.

