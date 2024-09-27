---
title: Active Directory Directory Services Replication Priority Boost feature
description: Learn about and how to manage Active Directory Directory Services Replication Priority Boost
author: gswashington
ms.service: active-directory
ms.topic: how-to
ms.date: 10/02/2024
ms.author: brdpm

---

# Active Directory Directory Services Replication Priority Boost feature

Applies to: Windows Server 2025, Windows Server 2022

Active Directory is a distributed system; this means that changes applied to one domain controller are replicated to other DCs in the system automatically. Because changes can happen concurrently on multiple DCs, there has to be priority system to manage these changes. A destination DC get its changes from its replication partners. When a destination DC retrieves its changes from multiple DCs, these tasks are served based on priority. (Replication jobs from various partners are applied in order of priority.) Replication priority is hard coded and uses fixed heuristic rules. For example, the configuration naming context (NC) has higher priority than that of the domain NC because a topology change often is of higher importance. Similarly, the an intra-site partner will have higher priority than an inter-site partner because a DC's geographic proximity often is more relevant for DCs in the same site. DCs in the same group all share the same priority. 

Built-in priority works fine in most cases. However, there are scenarios in which the built-in priority heuristics aren't the most efficient approach. For example, in some environments, sites are not designed according to proximity but according to functionality, say primary versus backup sites. Inter-site changes might be more relevant that intra-site changes. Alternately, there are times that the changes in the configuration DC are not important. Or there are times in which you want to stick with a particular partner DC over the rest in the same group.

There are no specific system requirements for enabling this feature in Windows Server 2025. The feature is compatible with systems running a Windows Server 2022 DC as the replication source DC as long as the destination DC is running Windows Server 2025 and understands the new rootDSE modify.

## How it works

The Replication Priority Boost feature introduces an interface that lets you boost the priority of a replication partner. the Replication Priority Boost feature lets you manage the priority to get the most efficient replication order to match their needs. The Replication Priority Boost feaure uses a root DSE mode to add a booster factor on the system to designate the priority and a root DSE attribute to read this boost factor

`RootDSE modify: setPriorityBoost:<naming context>:<partner DC>:<boost factor>`
`RootDSE attribute: msDS-PriorityBoost:<naming context>:<partner DC>`

The boost factor is added on top of the system calculated priority by the system admin. The following screen shot shows the Replication Priority Boost feature user interface.

<!-- screen shot here -->
<!-- Note: ADO links to scenario and spec are 404 ... See https://dev.azure.com/msft-skilling/Content/_workitems/edit/186868-->

The Replication Priority Boost feature doesn't change the size of any supported attribute values. JET database supports up to 2147483647 bytes in a single value of binary type. There are limitations on some particular attribute sizes imposed by other modules, but not in the case of JET in Active Directory.

For example, in a scenario where an admin performs over-the-wire DC promo that requires replication of a large DIT file, if the replication is interrupted due to reboots or network issues, the replication might restart using a different replication partner. Specifying a prioritization boost on the repsFrom attribute lets an administrator prioritize a specific replication partner(s) to get around this situation.

<!-- [MS-ADTS]: setPriorityBoost | Microsoft Learn   >>>>> Protocol Documentation for the new feature for more information.  Note: this is not a link; what does this reference? See https://dev.azure.com/msft-skilling/Content/_workitems/edit/186868-->

## See also

- [Active Directory Maximum Limits - Scalability](https://review.learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2003/cc756101(v=ws.10)?branch=main#maximum-size-of-active-directory-objects)
- [Onboard Active Directory Security Group for JIT to manage](https://review.learn.microsoft.com/identity/access-management/just-in-time/security-group-elevation-support?branch=main)