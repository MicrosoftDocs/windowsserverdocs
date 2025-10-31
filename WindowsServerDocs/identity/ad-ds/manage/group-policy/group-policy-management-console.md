---
title: Group Policy Management Console in Windows
description: Learn how to create, edit, link, and manage Group Policy Objects using the Group Policy Management Console.
author: orin-thomas
ms.topic: how-to
ms.author: daknappe
contributor: orthomas
ms.date: 05/14/2025
---

# Group Policy Management Console

The Group Policy Management Console (GPMC) provides unified management of all aspects of Group Policy across multiple forests in an organization. The GPMC lets you manage all Group Policy Objects (GPOs), Windows Management Instrumentation (WMI) filters, and Group Policy–related permissions in your network. Think of the GPMC as your primary access point to Group Policy, with all the Group Policy management tools available from the GPMC interface.

The GPMC consists of a set of scriptable interfaces for managing Group Policy and an MMC-based user interface (UI). The GPMC is included with Windows Server and the Remote Server Administration Tools.

The GPMC provides the following capabilities:

- Import and exporting GPOs.
- Copy and pasting GPOs.
- Back up and restoring GPOs.
- Search for existing GPOs.
- Report capabilities.
- Group Policy Modeling. Allows you to simulate Resultant Set of Policy (RsoP) data for planning Group Policy deployments before implementing them in the production environment.
- Group Policy Results. Allows you to view GPO interaction and to troubleshoot Group Policy deployments.
- Support for migration tables to facilitate the importing and copying of GPOs across domains and across forests. A migration table is a file that maps references to users, groups, computers, and Universal Naming Convention (UNC) paths in the source GPO to new values in the destination GPO.
- Reporting GPO settings and RSoP data in HTML reports that you can save and print.
- Scriptable interfaces that allow all operations that are available within the GPMC. You can't use scripts to edit individual policy settings in a GPO.

## Prerequisites

To use the GPMC, you must complete the following prerequisites.

- Have the Group Policy Management feature installed on a computer running Windows Server or a Windows client operating system.
- Have _Edit settings_, _delete_, and _modify_ security permissions on the GPO.
- To link GPOs, you need the _modify_ permission on that site, domain, or OU. By default, only Domain Administrators and Enterprise Administrators have this permission.
  - Users and groups with permission to link GPOs to a specific site, domain, or OU can link GPOs, change link order, and set block inheritance on that site, domain, or OU.

## Create an unlinked GPO

To create an unlinked GPO, perform the following steps:

1. To open the GPMC, select **Start**, enter **Group Policy Management** in the search box, and then select **Group Policy Management**.
1. In the GPMC console tree, right-click **Group Policy Objects** in the forest and domain in which you want to create a new unlinked GPO.
1. Select **New**.
1. In the New GPO dialog box, specify a name for the new GPO, and then select **OK**.

## Edit an existing GPO

To change policy settings within an existing GPO, perform the following steps:

1. In the GPMC console tree, expand Group Policy Objects in the forest and domain containing the GPO that you want to edit.
1. Right-click the GPO that you want to edit, and then select **Edit**.
1. In the console tree of the Group Policy Management Editor, expand items as needed to locate the policy item that contains the policy settings that you want to modify. Select an item to view the associated policy settings in the details pane.
1. In the details pane, double-click the names of the policy setting that you want to edit.
1. In the Properties dialog box, modify policy settings as needed, and then select **OK**.
1. After completing the necessary modifications, close the Group Policy Management Editor.

## Link a GPO

The primary way to apply the policy settings in a GPO to users and computers is by linking the GPO to a container in Active Directory. GPOs can be linked to three types of containers in Active Directory: sites, domains, and organizational units (OUs). A GPO can be linked to multiple Active Directory containers.

GPOs are stored on a per-domain basis. For example, if you link a GPO to an OU, the GPO isn't stored in that OU. A GPO is a per-domain object that can be linked anywhere in the forest. The UI in the GPMC helps clarify the distinction between links and actual GPOs.

In the GPMC, you can link an existing GPO to Active Directory containers by using either of the following methods:

- Right-click a site, domain, or OU item, and then select **Link an Existing GPO**. This procedure requires that the GPO already exist in the domain.
- Drag a GPO from under the Group Policy Objects item to the OU to which you want to link the GPO. This drag-and-drop functionality works only within the same domain.

## Change GPO link order

Within each site, domain, and OU, the link order controls the order in which GPOs are applied. To change the precedence of a link, you can change the link order, moving each link up or down in the list to the appropriate location. Links with the lowest number have higher precedence for a given site, domain, or OU.

For example, you want the last GPO that you added to have the highest precedence. You can adjust the link order of the GPO to a link order of 1 to make it the highest. To change the link order for GPO links for a site, domain, or OU, use the GPMC.

## Unlink a GPO from a site, domain, or OU

Unlinking a GPO means that the linked GPO no longer applies to the location where it was originally linked. To unlink a GPO:

1. In the GPMC console tree, expand Group Policy Objects in the forest and domain containing the GPO that you want to unlink.
1. Select the GPO that you want to unlink.
1. In the details pane, select the **Scope** tab.
1. In the Links section, right-click the Active Directory object with the link you want to delete, and then select **Delete Link(s)**.

Deleting a link to a GPO is different than deleting a GPO. If a GPO link the GPO remains available. Other links from other domains to that GPO also remain present. When you delete a GPO, you're prompted to delete the GPO and all links to it in the selected domain. Doing the GPO and all links doesn't delete links to the GPO from other domains. Be sure to remove links to the GPO in other domains before deleting this GPO from this domain.

## Disable User Configuration or Computer Configuration settings in a GPO

To create a GPO to set only user-related policy settings, disable the Computer Configuration settings in the GPO. Disabling the computer configure slightly reduces computer startup time because the Computer Configuration settings in the GPO don't have to be evaluated. If you're configuring only computer-related policy settings, disable the User Configuration settings in the GPO. To disable User Configuration or Computer configuration:

1. In the GPMC console tree, expand Group Policy Objects in the forest and domain containing the GPO that contains the policy settings you want to disable.
1. Right-click the GPO that contains the policy settings that you want to disable.
1. In the GPO Status list, select one of the following options:
   - All policy settings disabled
   - Computer configuration settings disabled
   - Enabled (default)
   - User configuration settings disabled

## Related content

- [Group Policy Processing](group-policy-processing.md)
- [Backing up, restoring, migrating, and copying Group Policy Objects (GPOs)](group-policy-backup-restore.md)
- [Group Policy Modeling and Group Policy Results](group-policy-modeling-results.md)

