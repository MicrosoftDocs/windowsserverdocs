---
title: Active Directory Domain Services Replication Priority Boost
description: Learn about what the Active Directory Domain Services Replication Priority Boost feature is and how to manage it.
ms.author: clfish
author: gswashington
ms.topic: how-to
ms.date: 10/21/2024
---

# Active Directory Domain Services Replication Priority Boost

>Applies to: Windows Server 2025, Windows Server 2022

Active Directory is a distributed system, which means changes you apply to one domain controller (DC) replicate to other DCs in the system automatically. Because changes can happen concurrently on multiple DCs, your deployment needs a priority system to manage these changes. In a priority system, when the destination DC retrieves its replication tasks from the other DCs that are its replication partners, the system serves these tasks based on priority. 

Replication priority in Active Directory is hardcoded to use fixed heuristic rules. For example, the configuration naming context (NC) has higher priority than that of the domain NC because topology changes are of higher importance. Similarly, the intra-site partner has higher priority than an inter-site partner because a DC's geographic proximity is more relevant for DCs in the same site. DCs in the same group all share the same priority.

The built-in priority heuristics work fine in most cases. However, there are scenarios where they aren't the most efficient approach. For example, in some environments, sites aren't designed according to proximity but functionality, such as with primary versus backup sites. In these cases, inter-site changes are more relevant than intra-site changes. There may also be scenarios when either the changes in the configuration DC aren't important or you choose to use only a specific partner DC instead of other DCs in the same group.

Replication Priority Boost is useful in scenarios that involve an administrator performing an over-the-wire DC promo that requires replication of a large DIT file. If the replication is interrupted by a reboot or network issues, the replication can restart using a different replication partner. Administrators can work around these issues by specifying a prioritization boost on the `repsFrom` attribute to prioritize one or more specific replication partners. You can see an example of how to specify prioritization boosts in [Configure Replication Priority Boost](#configure-replication-priority-boost).

## Prerequisites

- Active Directory Domain Services are set up and running

## System requirements and compatibility

There are no specific system requirements for enabling the Replication Priority Boost feature in Windows Server 2025. The feature is also compatible with systems running a Windows Server 2022 DC as the replication source DC if the destination DC is running Windows Server 2025 and understands the new rootDSE modify.

## Configure Replication Priority Boost

The Replication Priority Boost feature introduces an interface for you to boost the priority of a replication partner. Use this feature to manage priority levels to get the most efficient replication order to match your deployment's needs. The Replication Priority Boost feature uses both a root directory system agent-specific entry (rootDSE) modifier to add a boost factor to the system to designate priority and rootDSE attribute to read the boost factor.

```Cmd

RootDSE modify: setPriorityBoost:<naming context>:<partner DC>:<boost factor>

RootDSE attribute: msDS-PriorityBoost:<naming context>:<partner DC>

```

For more information, see the [setPriorityBoost spec](/openspecs/windows_protocols/ms-adts/ee15e25a-a5b1-4229-904b-6f48cee9b793).

## Set and read the priority boost

The Active Directory administrator adds the boost factor on top of the built-in priority level.

The following steps show how to set and read the replication priority boost using the Ldp tool.

1. Start the **Ldp** tool to manage your Active Directory namespace and perform LDAP operations.

1. Enter in the Server name and Port number to connect. Select **OK**.

    :::image type="content" source="./media/replication-priority-boost/ldp-connection.png" border="true" alt-text="Screenshot of the Connect dialog in the Ldp tool.":::

1. Select **Browse**, then **Modify**. The Modify window opens.

1. In the Attribute field, enter **setPriorityBoost**.

1. Enter the Values for your destination DC in the format: **`<naming context>:<partner DC>:<boost factor>`**.

1. Select **Run** to set the priority boost.

    :::image type="content" source="./media/replication-priority-boost/set-priority-boost.png" border="true" alt-text="Screenshot of the Modify dialog using the rootDSE setPriorityBoost.":::

1. Select **Browse**, then **Search**. The Search window opens.

1. In the Attributes field, enter **`msDS-PriorityBoost:<naming context>:<partner DC>`**, replacing the values for your naming context and partner DC.

1. Select **Run** to read the replication boost.

    :::image type="content" source="./media/replication-priority-boost/msds-priority-boost.png" border="true" alt-text="Screenshot of the Search dialog using the rootDSE msDS-PriorityBoost.":::

> [!NOTE]
> The Replication Priority Boost feature doesn't change the size of any supported attribute values. The Joint Engine Technology (JET) database supports up to 2,147,483,647 bytes in a single value of binary type. There are limitations on some particular attribute sizes imposed by other modules, but not in the case of JET in Active Directory. For more information about JET management, see [Active Directory Maximum Limits - Scalability](/windows-server/identity/ad-ds/plan/active-directory-domain-services-maximum-limits).

## Related content

- [Active Directory Maximum Limits - Scalability](/windows-server/identity/ad-ds/plan/active-directory-domain-services-maximum-limits#maximum-number-of-objects)
- [Active Directory security groups](/windows-server/identity/ad-ds/manage/understand-security-groups)
