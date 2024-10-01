---
title: Active Directory Domain Services Replication Priority Boost feature
description: Learn about what the Active Directory Domain Services Replication Priority Boost feature is and how to manage it.
ms.author: clfish
author: gswashington
ms.service: ad-ds
ms.topic: how-to
ms.date: 10/02/2024
---

# Active Directory Domain Services Replication Priority Boost feature

Applies to: Windows Server 2025, Windows Server 2022

Active Directory is a distributed system, which means changes you apply to one domain controller replicate to other DCs in the system automatically. Because changes can happen concurrently on multiple DCs, your deployment needs a priority system to manage these changes. In a priority system, when the destination DC retrieves its replication tasks from the other DCs that are its replication partners, the system serves these tasks based on priority. 

Replication priority in Active Directory is hardcoded to use fixed heuristic rules. For example, the configuration naming context (NC) has higher priority than that of the domain NC because topology changes are of higher importance. Similarly, the intra-site partner has higher priority than an inter-site partner because a DC's geographic proximity is more relevant for DCs in the same site. DCs in the same group all share the same priority.

The built-in priority heuristics work fine in most cases. However, there are scenarios where they aren't the most efficient approach. For example, in some environments, sites aren't designed according to proximity but functionality, such as with primary versus backup sites. In these cases, inter-site changes are more relevant than intra-site changes. There may also be scenarios when either the changes in the configuration DC aren't important or you choose to use only a specific partner DC instead of other DCs in the same group.

Replication Priority Boost is useful in scenarios that involve an administrator performing an over-the-wire DC promo that requires replication of a large DIT file. If the replication is interrupted by a reboot or network issues, the replication can restart using a different replication partner. Administrators can work around these issues by specifying a prioritization boost on the `repsFrom` attribute to prioritize a one or more specific replication partners. You can see an example of how to specify prioritization boosts in [How to configure Replication Priority Boost](#how-to-configure-replication-priority-boost).

## Compatibility

There are no specific system requirements for enabling the Replication Priority Boost feature in Windows Server 2025. The feature is also compatible with systems running a Windows Server 2022 DC as the replication source DC if the destination DC is running Windows Server 2025 and understands the new rootDSE modify.

## How to configure Replication Priority Boost

The Replication Priority Boost feature introduces an interface that lets you boost the priority of a replication partner. You can use this feature to manage priority levels to get the most efficient replication order to match your deployment's needs. The Replication Priority Boost feature uses both a root DSE modifier to add a boost factor to the system to designate priority and a root DSE attribute to read the boost factor.

```Cmd

`RootDSE modify: setPriorityBoost:<naming context>:<partner DC>:<boost factor>`

`RootDSE attribute: msDS-PriorityBoost:<naming context>:<partner DC>`

```

The system admin adds the boost factor on top of the built-in priority level. The following screenshot shows the Replication Priority Boost feature user interface performing this operation on for destination DC <>.

<!-- screen shot here and procedure here-->
<!-- Note: ADO links to scenario and spec are 404 ... See https://dev.azure.com/msft-skilling/Content/_workitems/edit/186868-->

The Replication Priority Boost feature doesn't change the size of any supported attribute values. The Joint Engine Technology (JET) database supports up to 2,147,483,647 bytes in a single value of binary type. There are limitations on some particular attribute sizes imposed by other modules, but not in the case of JET in Active Directory. For more information about JET management, see [Active Directory Maximum Limits - Scalability](https://review.learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2003/cc756101(v=ws.10)?branch=main#maximum-size-of-active-directory-objects).

## See also

- [Active Directory Maximum Limits - Scalability](https://review.learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2003/cc756101(v=ws.10)?branch=main#maximum-size-of-active-directory-objects)
- [Onboard Active Directory Security Group for JIT to manage](./identity/access-management/just-in-time/security-group-elevation-support?branch=main)