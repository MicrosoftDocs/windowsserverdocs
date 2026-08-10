---
title: Active Directory Domain Services Replication Priority Boost
description: Learn about what the Active Directory Domain Services Replication Priority Boost feature is and how to manage it.
ms.author: roharwoo
author: robinharwood
ms.topic: how-to
ms.date: 10/21/2024
---

# Active Directory Domain Services Replication Priority Boost

>Applies to: Windows Server 2025, Windows Server 2022

Active Directory is a distributed system, which means changes you apply to one domain controller (DC) replicate to other DCs in the system automatically. Because changes can happen concurrently on multiple DCs, your deployment needs a priority system to manage these changes. In a priority system, when the destination DC retrieves its replication tasks from the other DCs that are its replication partners, the system serves these tasks based on priority.

Replication priority in Active Directory is hardcoded to use fixed heuristic rules. For example, the configuration naming context (NC) has a higher priority than the domain NC because topology changes are of higher importance. Similarly, the intra-site partner has higher priority than an inter-site partner because a DC's geographic proximity is more relevant for DCs in the same site. DCs in the same group all share the same priority.

The built-in priority heuristics work fine in most cases. However, there are scenarios where they aren't the most efficient approach. For example, in some environments, sites aren't designed according to proximity but functionality, such as with primary versus backup sites. In these cases, inter-site changes are more relevant than intra-site changes. There may also be scenarios when either the changes in the configuration DC aren't important or you choose to use only a specific partner DC instead of other DCs in the same group.

Replication Priority Boost is useful in scenarios that involve an administrator performing an over-the-wire DC promo that requires replication of a large DIT file. If the replication is interrupted because of a reboot or network issues, the replication can restart using a different replication partner. Administrators can work around these issues by specifying a prioritization boost on the `repsFrom` attribute to prioritize one or more specific replication partners.

In this article, you learn how to use Replication Priority Boost.

## System requirements and compatibility

There are no specific system requirements for enabling Replication Priority Boost in Windows Server 2025. The feature is also compatible with systems running a Windows Server 2022 DC as the replication source DC if the destination DC is running Windows Server 2025.

## Configure the boost factor

Use Replication Priority Boost to manage priority levels to get the most efficient replication order to match your deployment's needs. Replication Priority Boost uses a root directory system agent-specific entry (rootDSE) modifier, called [**setPriorityBoost**](/openspecs/windows_protocols/ms-adts/ee15e25a-a5b1-4229-904b-6f48cee9b793), to add a boost factor to the system to designate priority. To read the boost factor after it's set, there's a rootDSE attribute called [**msDS-PriorityBoost**](/openspecs/windows_protocols/ms-adts/b04b3102-2fd6-426c-9549-4f941b2d6233).

### Recommended boost values

When using `setPriorityBoost` to add a boost factor, you need to specify a boost factor value. The following list recommends a boost factor value to set depending on your configuration:

|Scenario|Boost factor value|
|--------|-----------|
| Boost an intra-site replication partner higher priority than its peer intra-site replication partners. | 2 |
| Boost a domain NC higher priority than the configuration NC. | 10 |
| Boost an inter-site DC higher priority than an intra-site DC, if the inter-site source DC **doesn't** have [DRS_NEVER_NOTIFY](/openspecs/windows_protocols/ms-drsr/ac9c8a11-cd46-4080-acbf-9faa86344030) bit set with the destination DC. | 2 |
| Boost an inter-site DC higher priority than an intra-site DC, if the inter-site source DC has [DRS_NEVER_NOTIFY](/openspecs/windows_protocols/ms-drsr/ac9c8a11-cd46-4080-acbf-9faa86344030) bit set with the destination DC. | 18 |

## Set and read the priority boost

The Active Directory administrator adds, or sets the boost factor on top of the built-in priority level. To add the priority boost, the administrator must change the value specified in the Lightweight Directory Access Protocol (LDAP) modify operation.

### Set the priority boost

The following steps show how to set the replication priority boost.

1. Run **Ldp.exe** to start the **Ldp** program.

1. Select the **Connection** menu and select **Connect**. Enter in the Server name and Port number for your DC. Select **OK**.

    :::image type="content" source="./media/replication-priority-boost/connect-to-server.png" border="true" alt-text="Screenshot showing the connection dialog including the server name and port number.":::

1. Select the **Browse** menu, then select **Modify**.

1. In the **Edit Entry Attribute** field, enter:

    ```Cmd
    setPriorityBoost
    ```

1. In **Values**, type the values for your destination DC in the format: **`<naming context>:<partner DC>:<boost factor>`**. For example:

    ```Cmd
    CN=app1:ae732425-2e31-4246-98a5-60ce2e1c8101:5
    ```

1. Confirm that the Operation is **Add**.

1. Select **Enter** to update the **Entry List**.

1. Select **Run** to set the priority boost.

    :::image type="content" source="./media/replication-priority-boost/set-priority-boost.png" border="true" alt-text="Screenshot showing how to modify the rootDSE using setPriorityBoost.":::

1. The Ldp output window shows that the modify call was successful.

    ```cmd
    ----------
    ***Call Modify...
    ldap_modify_s(Id, '(null)',[1] attrs);
    Modified "".
    ----------
    ```

### Read the priority boost

To read the priority boost, and confirm the priority boost is set, you need to search using the _msDS-PriorityBoost_ attribute.

1. Select the **Browse** menu, then **Search**.

1. Leave **Base DN** as-is, and the **Filter** set to: **(objectClass=*)**. The **Scope** is **Base**.

1. In the Attributes field, enter **`"msDS-PriorityBoost;parameter=CN=<naming context>:<partner DC>"`**, replacing the values for your naming context and partner DC. Ensure that the whole value is within quotes. For example:

    ```Cmd
    "msDS-PriorityBoost;parameter=CN=app1:ae732425-2e31-4246-98a5-60ce2e1c8101"
    ```

1. Select **Run** to run the search and read the priority boost.

    :::image type="content" source="./media/replication-priority-boost/search-priority-boost.png" border="true" alt-text="Screenshot of how to read the priority using the rootDSE msDS-PriorityBoost.":::

1. If successful, the Ldp output window returns the priority boost, including the partner DC and priority boost factor.

    ```cmd
    ----------
    ***Searching...
    ldap_search_s(Id, "(null)", 0, "(objectclass=*)", attrList, 0, &msg)
    Getting 1 entries:
    Dn: (RootDSE)
        msDS-PriorityBoost;parameter=CN=app1:ae732425-2e31-4246-98a5-60ce2e1c8101: 5;
    ```
