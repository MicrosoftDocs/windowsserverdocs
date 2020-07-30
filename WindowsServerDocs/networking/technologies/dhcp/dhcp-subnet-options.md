---
title: DHCP Subnet Selection Options
description: This topic provides information about DHCP subnet selection options for Dynamic Host Configuration Protocol (DHCP) in Windows Server 2016. 
manager: dougkim
ms.prod: windows-server
ms.technology: networking-dhcp
ms.topic: get-started-article
ms.assetid: ca19e7d1-e445-48fc-8cf5-e4c45f561607
ms.author: lizross
author: eross-msft
ms.date: 08/17/2018
---

# DHCP Subnet Selection Options

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic for information about new DHCP subnet selection options.

DHCP now supports option 82 \(sub-option 5\). You can use these options to allow DHCP proxy clients and relay agents to request an IP address for a specific subnet, and from a specific IP address range and scope.  For more details, see **Option 82 Sub Option 5**: [RFC 3527 Link Selection sub-option for the Relay Agent Information Option for DHCPv4](https://tools.ietf.org/html/rfc3527).

If you are using a DHCP relay agent that is configured with DHCP option 82, sub-option 5, the relay agent can request an IP address lease for DHCP clients from a specific IP address range.


## Option 82 Sub Option 5: Link Selection Sub Option

The Relay Agent Link Selection sub-option allows a DHCP Relay Agent to specify an IP subnet from which the DHCP server should assign IP addresses and options.

Typically, DHCP relay agents rely on the Gateway IP Address \(GIADDR\) field to communicate with DHCP servers. However, GIADDR is limited by its two operational functions:

1. To inform the DHCP server about the subnet upon which the DHCP client that is requesting the IP address lease resides.
2. To inform the DHCP server of the IP address to use to communicate with the relay agent.

In some cases, the IP address that the relay agent uses to communicate with the DHCP server might be different than the IP address range from which the DHCP client IP address needs to be allocated. 

The Link Selection Sub option of option 82 is useful in this situation, allowing the relay agent to explicitly state the subnet from which it wants the IP address allocated in the form of DHCP v4 option 82 sub option 5.

> [!NOTE]
>
> All relay agent IP addresses (GIADDR) must be part of an active DHCP scope IP address range. Any GIADDR outside of the DHCP scope IP address ranges is considered a rogue relay and Windows DHCP Server will not acknowledge DHCP client requests from those relay agents.
>
> A special scope can be created to "authorize" relay agents. Create a scope with the GIADDR (or multiple if the GIADDR's are sequential IP addresses), exclude the GIADDR address(es) from distribution, and then activate the scope. This will authorize the relay agents while preventing the GIADDR addresses from being assigned.


### Use case scenario

In this scenario, an organization network includes both a DHCP server and a Wireless Access Point \(AP\) for the guest users. Guests client IP addresses are assigned from the organization DHCP server - however, due to firewall policy restrictions, the DHCP server cannot access the guest wireless network or wireless clients with broadcase messages.

To resolve this restriction, the AP is configured with the Link Selection Sub Option 5 to specify the subnet from which it wants the IP address allocated for guest clients, while in the GIADDR also specifying the IP address of the internal interface that leads to the corporate network.
