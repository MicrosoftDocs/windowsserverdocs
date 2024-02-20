---
title: Group Policy Management Console
description: You can use this article to understand how to perform tasks with the Group Policy Management Console.
author: Orin-Thomas
ms.topic: how-to
ms.author: orthomas
contributor: orthomas
ms.date: 02/18/2024
---

# Group Policy Management Console (GPMC)

The GPMC provides unified management of all aspects of Group Policy across multiple forests in an organization. The GPMC lets you manage all GPOs, Windows Management Instrumentation (WMI) filters, and Group Policy–related permissions in your network. Think of the GPMC as your primary access point to Group Policy, with all the Group Policy management tools available from the GPMC interface.

The GPMC consists of a set of scriptable interfaces for managing Group Policy and an MMC-based user interface (UI). The GPMC is included with Windows Server and the Remote Server Administration Tools.

The GPMC provides the following capabilities:

- Importing and exporting GPOs.
- Copying and pasting GPOs.
- Backing up and restoring GPOs.
- Searching for existing GPOs.
- Reporting capabilities.
- Group Policy Modeling. Allows you to simulate Resultant Set of Policy (RsoP) data for planning Group Policy deployments before implementing them in the production environment.
- Group Policy Results. Allows you to obtain RSoP data for viewing GPO interaction and for troubleshooting Group Policy deployments.
- Support for migration tables to facilitate the importing and copying of GPOs across domains and across forests. A migration table is a file that maps references to users, groups, computers, and Universal Naming Convention (UNC) paths in the source GPO to new values in the destination GPO.
- Reporting GPO settings and RSoP data in HTML reports that you can save and print.
- Scriptable interfaces that allow all operations that are available within the GPMC. You can't, however, use scripts to edit individual policy settings in a GPO.

## Create an unlinked GPO

To create an unlinked GPO that you then may link at the site, domain, or OU level, perform the following steps:

1. In the GPMC console tree, right-click Group Policy Objects in the forest and domain in which you want to create a new unlinked GPO.
2. Click New.
3. In the New GPO dialog box, specify a name for the new GPO, and then click OK.

## Edit an existing GPO

To change policy settings within an existing GPO, perform the following steps:

1. In the GPMC console tree, expand Group Policy Objects in the forest and domain containing the GPO that you want to edit.
2. Right-click the GPO that you want to edit, and then click Edit. This opens the Group Policy Management Editor.
3. In the console tree of the Group Policy Management Editor, expand items as needed to locate the policy item that contains the policy settings that you want to modify. Click an item to view the associated policy settings in the details pane.
4. In the details pane, double-click the names of the policy setting that you want to edit.
5. In the Properties dialog box, modify policy settings as needed, and then click OK.
6. After completing the necessary modifications, close the Group Policy Management Editor.

## To Link a GPO

The primary way to apply the policy settings in a GPO to users and computers is by linking the GPO to a container in Active Directory. GPOs can be linked to three types of containers in Active Directory: sites, domains, and OUs. A GPO can be linked to multiple Active Directory containers.

GPOs are stored on a per-domain basis. For example, if you link a GPO to an OU, the GPO isn't stored in that OU. A GPO is a per-domain object that can be linked anywhere in the forest. The UI in the GPMC helps clarify the distinction between links and actual GPOs.

In the GPMC, you can link an existing GPO to Active Directory containers by using either of the following methods:

- Right-click a site, domain, or OU item, and then click Link an Existing GPO. This procedure requires that the GPO already exist in the domain.
- Drag a GPO from under the Group Policy Objects item to the OU to which you want to link the GPO. This drag-and-drop functionality works only within the same domain.

## Change GPO link order

Within each site, domain, and OU, the link order controls the order in which GPOs are applied. To change the precedence of a link, you can change the link order, moving each link up or down in the list to the appropriate location. Links with the lowest number have higher precedence for a given site, domain, or OU.

For example, if you add six GPO links and later decide that you want the last one that you added to have the highest precedence, you can adjust the link order of the GPO link, so it has a link order of 1. To change the link order for GPO links for a site, domain, or OU, use the GPMC.

## To unlink a GPO from a site, domain, or OU

Unlinking a GPO means that the linked GPO no longer applies to the location where it was originally linked. To unlink a GPO:

1. In the GPMC console tree, expand Group Policy Objects in the forest and domain containing the GPO that you want to unlink.
2. Click the GPO that you want to unlink.
3. In the details pane, click the Scope tab.
4. In the Links section, right-click the Active Directory object with the link you want to delete, and then click Delete Link(s).

Deleting a link to a GPO is different than deleting a GPO. If a GPO link the GPO remains available. Other links from other domains to that GPO also remain present. When you delete a GPO, you'll be prompted to delete the GPO and all links to it in the selected domain. Doing this doesn't delete links to the GPO from other domains. Be sure to remove links to the GPO in other domains before deleting this GPO from this domain.

## Disable User Configuration or Computer Configuration settings in a GPO

If you're creating a GPO to set only user-related policy settings, you can disable the Computer Configuration settings in the GPO. Doing this slightly reduces computer startup time because the Computer Configuration settings in the GPO don't have to be evaluated to determine if any policy settings exist. If you are configuring only computer-related policy settings, disable the User Configuration settings in the GPO. To disable User Configuration or Comptuer configuraiton: 

1. In the GPMC console tree, expand Group Policy Objects in the forest and domain containing the GPO that contains the policy settings you want to disable.
2. Right-click the GPO that contains the policy settings that you want to disable.
3. In the GPO Status list, select one of these choices:
- All policy settings disabled
- Computer configuration settings disabled
- Enabled (default)
- User configuration settings disabled

## Using loopback processing to configure user policy settings

The User Group Policy loopback processing mode policy setting is an advanced option that is intended to keep the configuration of the computer the same regardless of who logs on. This policy setting is appropriate in certain closely managed environments with special-use computers, such as classrooms, public kiosks, and reception areas. For example, you might want to enable this policy setting for a specific server, such as a terminal server. Enabling the loopback processing mode policy setting directs the system to apply the same user policy settings for any user who logs onto the computer, based on the computer.

When you apply GPOs to users, normally the same set of user policy settings applies to those users when they log on to any computer. By enabling the loopback processing policy setting in a GPO, you can configure user policy settings based on the computer that they log on to. Those policy settings are applied regardless of which user logs on. When you enable the loopback processing mode policy setting, you must ensure that both the Computer Configuration and User Configuration settings in the GPO are enabled.

You can configure the loopback policy setting by using the GPMC to edit the GPO and enabling the User Group Policy loopback processing mode policy setting under Computer Configuration\Policies\Administrative Templates\System\Group Policy. Two options are available:

- Merge mode: In this mode, the list of GPOs for the user is gathered during the logon process. Then, the list of GPOs for the computer is gathered. Next, the list of GPOs for the computer is added to the end of the GPOs for the user. As a result, the computer’s GPOs have higher precedence than the user’s GPOs. If the policy settings conflict, the user policy settings in the computer's GPOs will be applied rather than the user's normal policy settings.
- Replace mode: In this mode, the list of GPOs for the user is not gathered. Instead, only the list of GPOs based on the computer object is used. The User Configuration settings from this list are applied to the user.

## Restoring Default Domain Policy GPO and Default Domain Controller GPO

Dcgpofix.exe is a command-line tool that completely restores the Default Domain Policy GPO and Default Domain Controller GPO to their original states, in the event of a disaster when you can't use the GPMC. Dcgpofix.exe is included with Windows Server and is located in the C:\Windows\system32\ folder.

Dcgpofix.exe restores only the policy settings that are contained in the default GPOs at the time they are generated. Dcgpofix.exe does not restore other GPOs that administrators create; it is only intended for disaster recovery of the default GPOs.