---
title: Virtual network peering
description:  
manager: dougkim
ms.prod: windows-server-threshold
ms.technology: networking-hv-switch
ms.topic: get-started-article
ms.assetid: 
ms.author: pashort
author: shortpatti
ms.date: 08/08/2018
---


# Virtual network peering

>Applies to: Windows Server

Virtual network peering lets you connect two virtual networks seamlessly. Once peered, for connectivity purposes, the virtual networks appear as one. 

The benefits of using virtual network peering include:

-   Traffic between virtual machines in the peered virtual networks gets routed through the backbone infrastructure through *private* IP addresses only. The communication between the virtual networks does not require public Internet    or gateways.

-   A low-latency, high-bandwidth connection between resources in different virtual networks.

-   The ability for resources in one virtual network to communicate with resources in a different virtual network.

-   No downtime to resources in either virtual network when creating the peering.

## Requirements and constraints

Virtual network peering has a few requirements and constraints:

- Peered virtual networks must:

  -   Have non-overlapping IP address spaces

  -   Be managed by the same Network Controller

- Once you peer a virtual network with another virtual network, you cannot add or delete address ranges in the address space.

  >[!TIP]
  >If you need to add address ranges:<ol><li>Remove the peering.</li><li>Add the address space.</li><li>Add the peering again.</li></ol>

- Since virtual network peering is between two virtual networks, there is no derived transitive relationship across peerings. For example, if you peer virtualNetworkA with virtualNetworkB and virtualNetworkB with virtualNetworkC, then virtualNetworkA does not get peered with virtualNetworkC.

  [image here]

## Connectivity

After you peer virtual networks, resources in either virtual network can directly connect with resources in the peered virtual network.

-   Network latency between virtual machines in peered virtual networks is the same as the latency within a single virtual network.

-   Network throughput is based on the bandwidth allowed for the virtual machine. There isn't any additional restriction on bandwidth within the peering.

-   Traffic between virtual machines in peered virtual networks is routed directly through the backbone infrastructure, not through a gateway or over the public Internet.

-   Virtual machines in a virtual network can access the internal load-balancer in the peered virtual network.

You can apply access control lists (ACLs) in either virtual network to block access to other virtual networks or subnets if desired. If you open full connectivity between peered virtual networks (which is the default option), you
can apply ACLs to specific subnets or virtual machines to block or deny specific access. To learn more about ACLs, see [Use Access Control Lists (ACLs) to Manage Datacenter Network Traffic Flow](https://docs.microsoft.com/windows-server/networking/sdn/manage/use-acls-for-traffic-flow).

## Service chaining

You can configure user-defined routes that point to virtual machines in peered virtual networks as the next hop IP address, to enable service chaining. Service chaining enables you to direct traffic from one virtual network to a virtual appliance, in a peered virtual network, through user-defined routes.

You can deploy hub-and-spoke networks, where the hub virtual network can host infrastructure components such as a network virtual appliance. All the spoke virtual networks peer with the hub virtual network. Traffic can flow through
network virtual appliances in the hub virtual network.

Virtual network peering enables the next hop in a user-defined route to be the IP address of a virtual machine in the peered virtual network. To learn more about user-defined routes, see [Use Network Virtual Appliances on a Virtual Network](https://docs.microsoft.com/windows-server/networking/sdn/manage/use-network-virtual-appliances-on-a-vn).

## Gateways and on-premises connectivity

Each virtual network, regardless of whether peered with another virtual network, can still have its own gateway to connect to an on-premises network. When you peer virtual networks, you can also configure the gateway in the peered virtual network as a transit point to an on-premises network. In this case, the virtual network that uses a remote gateway cannot have its own gateway. A virtual network can have only one gateway that can be either a local or remote gateway (in the peered virtual network).

## Monitor

When you peer two virtual networks, you must configure a peering for each virtual network in the peering.

You can monitor the status of your peering connection, which can be in one of the following states:

-   **Initiated:** Shown when you create the peering from the first virtual network to the second virtual network.

-   **Connected:** Shown after you've created the peering from the second virtual network to the first virtual network. The peering state for the first virtual network changes from Initiated to Connected. Both virtual network peers must have the state of Connected before establishing a virtual network peering successfully.

-   **Disconnected:** Shown if one virtual network disconnects from another virtual network.

[infographic of the states]

## Next steps
[Configure the virtual network peering](sdn-configure-vnet-peering.md): In this procedure, you use Windows PowerShell to find the HNV provider logical network to create two virtual networks, each with one subnet. You also configure the peering between the two virtual networks.

