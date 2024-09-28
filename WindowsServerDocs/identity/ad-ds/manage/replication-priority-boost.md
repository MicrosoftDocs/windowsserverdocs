---
title: Active Directory Directory Services Replication Priority Boost feature
description: Learn about and how to manage Active Directory Directory Services Replication Priority Boost
ms.author: clfish
author: gswashington
ms.service: ad-ds
ms.topic: how-to
ms.date: 10/02/2024
---

# Active Directory Directory Services Replication Priority Boost feature

Applies to: Windows Server 2025, Windows Server 2022

Active Directory is a distributed system; this means that changes applied to one domain controller are replicated to other DCs in the system automatically. Because changes can happen concurrently on multiple DCs, a priority system is necessary to manage these changes. A destination DC retrieves its changes from its replication partners. When a destination DC retrieves its replication tasks from multiple DCs, these tasks are served based on priority. 

Replication priority in Active Directory is hard coded and uses fixed heuristic rules. For example, the configuration naming context (NC) has higher priority than that of the domain NC because a topology change often is of higher importance. Similarly, the an intra-site partner will have higher priority than an inter-site partner because a DC's geographic proximity often is more relevant for DCs in the same site. DCs in the same group all share the same priority.

This built-in priority works fine in most cases. However, there are scenarios in which the built-in priority heuristics aren't the most efficient approach. For example, in some environments, sites are not designed according to proximity but according to functionality, say primary versus backup sites. Inter-site changes might be more relevant than intra-site changes. Alternately, there are times that the changes in the configuration DC aren't important. Or there are times in which you want to stick with a particular partner DC over the rest in the same group.

Another scenario in which Replication Priority Boost might be useful would involve an administrator performing an over-the-wire DC promo that requires replication of a large DIT file. If the replication was interrupted due to reboots or network issues, the replication might restart using a different replication partner. Specifying a prioritization boost on the `repsFrom` attribute would let the administrator prioritize a specific replication partner (or multiple replication partners) to work around this situation. This article includes an example of how to specify a prioritization boost in the Replication Priority Boost feature using the `repsFrom` attribute.

## System requirements

There are no specific system requirements for enabling the Replication Priority Boost feature in Windows Server 2025. The feature is also compatible with systems running a Windows Server 2022 DC as the replication source DC if the destination DC is running Windows Server 2025 and understands the new rootDSE modify.

## How it works

The Replication Priority Boost feature introduces an interface that lets you boost the priority of a replication partner. the Replication Priority Boost feature lets you manage the priority to get the most efficient replication order to match their needs. The Replication Priority Boost feaure uses a root DSE modify to add a booster factor on the system to designate the priority and a root DSE attribute to read this boost factor.

`RootDSE modify: setPriorityBoost:<naming context>:<partner DC>:<boost factor>`
`RootDSE attribute: msDS-PriorityBoost:<naming context>:<partner DC>`

The boost factor is added on top of the system-calculated (built-in) priority by the system admin. The following screen shot shows the Replication Priority Boost feature user interface performing this operation on for destination DC <>.  

<!-- screen shot here and procedure here-->
<!-- Note: ADO links to scenario and spec are 404 ... See https://dev.azure.com/msft-skilling/Content/_workitems/edit/186868-->

The Replication Priority Boost feature doesn't change the size of any supported attribute values. JET database supports up to 2147483647 bytes in a single value of binary type. There are limitations on some particular attribute sizes imposed by other modules, but not in the case of JET in Active Directory. See [Active Directory Maximum Limits - Scalability](https://review.learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2003/cc756101(v=ws.10)?branch=main#maximum-size-of-active-directory-objects) for more information on JIT management.

## See also

- [Active Directory Maximum Limits - Scalability](https://review.learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2003/cc756101(v=ws.10)?branch=main#maximum-size-of-active-directory-objects)
- [Onboard Active Directory Security Group for JIT to manage](./identity/access-management/just-in-time/security-group-elevation-support?branch=main)