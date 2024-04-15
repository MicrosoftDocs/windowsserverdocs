---
title: Group Policy Management Console in Windows
description: Understand how to create, edit, link, and manage Group Policy Objects using the Group Policy Management Console.
author: Orin-Thomas
ms.topic: how-to
ms.author: orthomas
contributor: orthomas
ms.date: 02/18/2024
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
- Have Edit settings, delete, and modify security permissions on the GPO.
- To link GPOs, you need the modify permission on that site, domain, or OU. By default, only Domain Administrators and Enterprise Administrators have this permission.
  - Users and groups with permission to link GPOs to a specific site, domain, or OU can link GPOs, change link order, and set block inheritance on that site, domain, or OU.

## Create an unlinked GPO

To create an unlinked GPO, perform the following steps:

1. To open the GPMC, select **Start**, select **Administrative Tools**, and then select **Group Policy Management**.
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

## Use loopback processing mode

Loopback processing mode keeps the configuration of the computer the same regardless of who logs on. This policy setting is appropriate in certain closely managed environments with special-use computers, such as classrooms, public kiosks, and reception areas. For example, you might want to enable this policy setting for a specific server, such as a terminal server. Enabling the loopback processing mode policy setting directs the system to apply the same user policy settings for any user who signs in the computer, based on the computer.

When you apply GPOs to users, normally the same set of user policy settings applies to those users when they sign in any computer. By enabling the loopback processing policy setting in a GPO, you can configure user policy settings based on the computer that they sign in. Those policy settings are applied regardless of which user logs on. When you enable the loopback processing mode policy setting, you must ensure that both the Computer Configuration and User Configuration settings in the GPO are enabled.

You can configure the loopback policy setting by using the GPMC to edit the GPO and enabling the User Group Policy loopback processing mode policy setting under **Computer Configuration\Policies\Administrative Templates\System\Group Policy**. Two options are available:

- Merge mode: In this mode, the list of GPOs for the user is gathered during the logon process. Then, the list of GPOs for the computer is gathered. Next, the list of GPOs for the computer is added to the end of the GPOs for the user. As a result, the computer’s GPOs have higher precedence than the user’s GPOs. If the policy settings conflict, the user policy settings in the computer's GPOs are applied rather than the user's normal policy settings.
- Replace mode: In this mode, the list of GPOs for the user isn't gathered. Instead, only the list of GPOs based on the computer object is used. The User Configuration settings from this list are applied to the user.

## Restoring Default Domain Policy GPO and Default Domain Controller GPO

`Dcgpofix.exe` is a command-line tool that in a disaster completely restores the Default Domain Policy GPO and Default Domain Controller GPO to their original states. `Dcgpofix.exe` is included with Windows Server and is located in the `C:\Windows\system32\` folder.

`Dcgpofix.exe` restores only the policy settings that are contained in the default GPOs at the time they're generated. `Dcgpofix.exe` doesn't restore other GPOs that administrators create, it's only intended for disaster recovery of the default GPOs.
