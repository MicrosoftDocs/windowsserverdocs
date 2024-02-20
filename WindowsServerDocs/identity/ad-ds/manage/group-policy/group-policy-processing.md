---
title: Group Policy processing
description: You can use this article to understand Group Policy processing in Active Directory Domain Services.
author: Orin-Thomas
ms.topic: conceptual
ms.author: orthomas
contributor: orthomas
ms.date: 02/18/2024
---

# Group Policy Processing

By default Group Policy Objects (GPOs) are inherited, cumulative, and affect all computers and users in an Active Directory container and its children. GPOs are processed in the following order: Local Group Policy, site, domain, and then OU, with the last GPO processed overriding the earlier GPOs. The default inheritance method is to evaluate Group Policy starting with the Active Directory container farthest from the computer or user object. The Active Directory container closest to the computer or user overrides Group Policy set in a higher-level Active Directory container unless you set the Enforced (No Override) option for that GPO link or if the Block Policy Inheritance policy setting has been applied to the domain or OU. The LGPO is processed first, so policy settings from GPOs linked to Active Directory containers override the local policy settings.

You can link more than one GPO to an Active Directory container. The GPO link with the lowest link order in the Group Policy Object Links list (displayed in the Linked Group Policy Objects tab in the Group Policy Management Console) has precedence by default.

## Enforced GPOs

Determine if there are any policy settings that must always be enforced for particular groups of users or computers. Create GPOs that contain these policy settings, link them to the appropriate site, domain, or OU, and designate these links as Enforced. By setting this option, you enforce a higher-level GPO’s policy settings by preventing GPOs in lower-level Active Directory containers from overriding them. For example, if you define a specific GPO at the domain level and specify that it's enforced, the policies that the GPO contains apply to all OUs under that domain; GPOs linked to the lower-level OUs can't override that domain Group Policy. If multiple GPOs are linked at the same Site, Domain, or OU and have the Enforced option set, the highest GPO link set to Enforced takes precedence.

## Block Inheritance

You can use the Block Inheritance option at the OU level to stop settings applied at the Local, Site, Domain, and higher Organizational Unit level from influencing the configuration of computers or users within the OU. Whilst Block Inheritance stops settings that would normally apply to computers and users within an OU, this setting won't block settings applied through GPOs linked with the Enforced option. Enforced is a link property, and Block Policy Inheritance is a container property. Enforced takes precedence over Block Policy Inheritance. In addition, you can disable policy settings on the GPO itself in four other ways: A GPO can be disabled; a GPO can have its computer settings disabled, its user settings disabled, or all of its settings disabled.

## Group Policy Filtering

You can filter whether a GPO applies using security filtering or WMI filters.

Security filtering enables you to refine which users and computers will receive and apply the policy settings in a GPO. Security group filtering determines whether the GPO as a whole applies to groups, users, or computers; it cannot be used selectively on different policy settings within a GPO. F

Windows Management Instrumentation (WMI) filters allow you to use a WMI query to filter the application of group policy. When you use WMI filtering, the GPO will only apply to security principals that meet the conditions of the WMI query. Each GPO can be linked to one WMI filter; however, the same WMI filter can be linked to multiple GPOs. Before you can link a WMI filter to a GPO, you must create the filter. The WMI filter is evaluated on the destination computer during the processing of Group Policy. The GPO will apply only if the WMI filter evaluates to true.

## Group Policy refresh
The primary mechanisms for refreshing Group Policy are startup and logon. Group Policy is also refreshed at other intervals on a regular basis. The policy refresh interval affects how quickly changes to GPOs are applied. By default, clients and servers running Windows Server and Windows Client operating systems check for changes to GPOs every 90 minutes by using a randomized offset of up to 30 minutes.

Domain controllers check for computer policy changes every five minutes. This polling frequency can be changed by using one of these policy settings: Group Policy Refresh Interval for Computers, Group Policy Refresh Interval for Domain Controllers, or Group Policy refresh Interval for Users. However, shortening the frequency between refreshes is not recommended because of the potential increase in network traffic and the additional load placed on the domain controllers.

Changes to Group Policy settings might not be immediately available on users’ desktops because changes to the GPO must first replicate to the appropriate domain controller. In addition, clients use a 90-minute refresh period (randomized by up to approximately 30 minutes) for the retrieval of Group Policy. Therefore, it's rare for a changed Group Policy setting to be applied immediately.

Components of a GPO are stored in both Active Directory and on the Sysvol folder of domain controllers. Replication of a GPO to other domain controllers occurs by two independent mechanisms:
- Replication in Active Directory is controlled by Active Directory’s built-in replication system. By default, this typically takes less than a minute between domain controllers within the same site. This process can be slower if your network is slower than a LAN.
- Replication of the Sysvol folder is controlled by Distributed File System Replication (DFSR). Within sites, replication occurs every 15 minutes. If the domain controllers are in different sites, the replication process occurs at set intervals based on site topology and schedule; the lowest interval is 15 minutes.


## Trigger Group Policy update

If necessary, you can trigger a Group Policy refresh manually in one of the following ways:
- From a local computer type gpupdate at the command line. This will trigger a policy refresh for the computer on which the command is run.
- Use the Invoke-UpUpdate PowerShell cmdlet. You can use this cmdlet to trigger a refresh of the local computer or to trigger a refresh of a remote computer.
- Use the Group Policy Management Console to trigger a group policy refresh at the OU level by right clicking on the OU and selecting Group Policy Update.

## Optimize GPO processing
To reduce the amount of time required to process a GPO, consider using one of the following strategies:
- If a GPO contains only computer configuration or user configuration settings, disable the portion of the policy setting that does not apply. When you do this, the destination computer does not scan the portions of a GPO that you disable, which reduces processing time. For information about disabling portions of a GPO, see Disabling the User Configuration or Computer Configuration settings in a GPO later in this guide.
- When possible, combine smaller GPOs to form a consolidated GPO. This reduces the number of GPOs that are applied to a user or computer. Applying fewer GPOs to a user or computer can reduce startup or logon times and make it easier to troubleshoot the policy structure.