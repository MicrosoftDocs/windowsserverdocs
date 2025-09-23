---
title: Group Policy processing for Windows
description: Learn about how Group Policy processing works in Active Directory Domain Services on Windows Server and Windows client computers.
author: Orin-Thomas
ms.topic: concept-article
ms.author: orthomas
contributor: alalve
ms.date: 06/16/2025
---

# Group Policy processing

By default, Group Policy is inherited and cumulative, and it affects all computers and users in an Active Directory (AD) container and its children. Computer-related policy settings override user-related policy settings.

Group Policy Objects (GPO) are processed in the following order:

1. The local GPO is applied.
1. GPOs linked to sites are applied.
1. GPOs linked to domains are applied.
1. GPOs linked to organizational units (OUs) are applied. In a nested OU structure, GPOs linked to parent OUs are applied first, followed by GPOs linked to the child OUs.

> [!TIP]
> The sequence of GPO processing is crucial because each subsequent policy application can override settings applied by earlier policies.

The default inheritance method is to evaluate Group Policy starting with the highest parent AD container. The AD container closest to the computer or user overrides Group Policy set in a higher-level AD container. Inheritance is ignored when you set the enforced option for that GPO link or when the block inheritance setting is applied. Local Group Policy is processed before domain-based policies. Policy settings from GPOs linked to AD containers override local policy settings.

You can link more than one GPO to an AD container. The GPO link with the lowest link order in the Group Policy Object Links list has precedence by default.

## How Group Policy processing works

Group Policy for computer settings is applied when the computer starts. Group Policy is applied at log on for users. This initial processing of policy can also be referred to as a foreground policy application.

The foreground processing of Group Policy can be synchronous or asynchronous. In synchronous mode, the computer doesn't complete the system start until computer policy is applied successfully. User logon process doesn't complete until user policy is applied successfully. In asynchronous mode, if there are no policy changes that require synchronous processing, the computer can complete the start sequence before the application of computer policy is complete. The desktop can also be available to the user before the application of user policy is complete when in asynchronous mode. The system then periodically applies (refreshes) Group Policy in the background. During a refresh, policy settings are applied asynchronously.

All policy processing must be completed within 60 minutes. There's no method to modify this time-out period.

After initial processing of Group Policy (also referred to as foreground policy application), the system periodically applies (refreshes) Group Policy in the background. During a refresh, policy settings are applied asynchronously.

By default, a refresh occurs every 90 minutes. The system might add a random time of up to 30 minutes to the refresh interval. You can change these default values by using a Group Policy setting in the Administrative Templates extension to Group Policy. Setting the value to zero minutes causes the refresh rate to be set to seven seconds. Not all Group Policy extensions are processed during a background refresh. For example, folder redirection processing occurs only when a user logs on. Also the processing of software installation policy occurs only when a computer starts and when a user logs on.

Even though the system processes the script extensions for Group Policy during a background refresh, individual scripts run only when the computer starts and shuts down, and when a user logs on and logs off.

During a policy refresh, by default, a client-side extension reapplies policy settings only if it detects a change to one of its GPOs or to its list of GPOs. This behavior is for performance reasons.

## Enforced GPOs

Determine if there are any policy settings that must always be enforced for particular groups of users or computers. Create GPOs that contain these policy settings, link them to the appropriate site, domain, or OU, and designate these links as enforced. By setting this option, you enforce a higher-level GPO’s policy settings by preventing GPOs in lower-level AD containers from overriding them. For example, if you define a specific GPO at the domain level and set the enforced option, the policies that the GPO contains apply to all OUs under that domain. GPOs linked to the lower-level OUs can't override that enforced domain Group Policy. If multiple GPOs are linked at the same site, domain, or OU and have the enforced option set, the highest GPO link set to enforced takes precedence.

## Block Inheritance

In the Group Policy Management Console (GPMC), Block Policy Inheritance, or Block Inheritance, refers to a feature that influences the Group Policy processing order. Each domain and OU in AD has a **GPOptions** attribute, which can be configured to block inheritance. This stops policy settings applied at the local, site, domain, and higher OU levels from affecting computers or users within the OU. However, while blocked inheritance prevents most settings from applying to an OU, it doesn't affect settings applied through GPOs with the enforced option. Enforced is a link property and takes precedence over block policy inheritance, a container property.

Policy settings linked to a domain typically apply to all computers and users within the domain, regardless of their parent OU. Using GPMC, you can block inheritance on a domain or OU to stop normal Group Policy settings from applying. Blocking inheritance at the domain level stops settings from GPOs linked to an AD site from applying to the domain, while blocking at the OU level prevents settings from GPOs linked to sites and domains from affecting those OUs.

In addition to blocking inheritance:

- A GPO itself can be entirely disabled
- A GPO can have its computer settings disabled
- A GPO can have its user settings disabled
- A GPO can have all of its settings disabled

## Group Policy Preference client-side extensions

Group Policy Preference client-side extensions have their own unique processing methods. Within a single GPO, you can configure one or more preference items for a specific Group Policy Preference extension to process. For instance, a single GPO can contain multiple [Drive Map Preference](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn581924(v=ws.11)) items.

During Group Policy processing, the infrastructure cycles through a series of extensions. For each extension, it provides essential information, including a list of GPOs with changes and GPOs no longer applicable to the user or computer. The infrastructure also shares context-specific details, such as whether the network connection is considered slow. The Group Policy Preference extension uses information about the changed and out-of-scope GPOs to process its settings.

Client-side extensions process preference items sequentially, from the top to the bottom of the list. The outcome of processing each preference item depends on its configured action, and item-level targeting might prevent an item from applying. The extension processes each item until it either completes the list or stops due to configuration settings like **Stop processing items in this extension if an error occurs on this item** or **Apply once and do not reapply**. Once all preference items are processed, control returns to the Group Policy service.

## Group Policy Filtering

You can filter whether a GPO applies using security filtering or Windows Management Instrumentation (WMI) filters.

Security filtering enables you to refine which users and computers receive and apply the policy settings in a GPO. Security group filtering determines whether the GPO applies to groups, users, or computers. Security group filtering can't be used selectively on different policy settings within a GPO.

WMI allows you to use a WMI query to filter the application of group policy. When you use WMI filtering, the GPO applies to security principals that meet the conditions of the WMI query. Each GPO can be linked to one WMI filter; however, the same WMI filter can be linked to multiple GPOs. Before you can link a WMI filter to a GPO, you must create the filter. The WMI filter is evaluated on the destination computer during the processing of Group Policy. The GPO applies only if the WMI filter evaluates to true.

## Loopback processing mode

Loopback processing mode applies the user configuration settings of Group Policy Objects assigned to the computer regardless of who logs on. Loopback processing will either merge or replace the user settings from the GPOs assigned to the user. This policy setting is appropriate in certain closely managed environments with special-use computers, such as classrooms, public kiosks, and reception areas.

For instance, you might enable this policy setting on a specific server to adjust user settings based on the computer being utilized. When you enable the loopback processing mode policy setting, the system applies user policy settings based on the computer's configuration, regardless of who signs in. This ensures consistent user policy settings for all users on the computer, as defined by the computer's GPOs.

By enabling the loopback processing policy setting in a GPO, you can configure user policy settings based on the computer that they sign in. Without loopback processing, GPOs applying a computer object will only process the computer configuration settings. GPOs applied to users will only process user configuration settings.  When you enable the loopback processing mode policy setting, you must ensure that both the Computer Configuration and User Configuration settings in the GPO are enabled. Those policy settings are applied regardless of which user logs on.

You can configure the loopback policy setting by using the GPMC to edit the GPO and enabling the **Configure user Group Policy loopback processing mode** policy setting under **Computer Configuration\Policies\Administrative Templates\System\Group Policy**. Two options are available:

- Merge mode: In this mode, the list of GPOs for the user is gathered during the logon process. Then, the list of GPOs for the computer is gathered. Next, the list of GPOs for the computer is added to the end of the GPOs for the user. As a result, the computer’s GPOs have higher precedence than the user’s GPOs. If the policy settings conflict, the user policy settings in the computer's GPOs are applied rather than the user's normal policy settings.

- Replace mode: In this mode, the list of GPOs for the user isn't gathered. Instead, only the list of GPOs based on the computer object is used. The User Configuration settings from this list are applied to the user.

## Group Policy refresh

The primary mechanisms for refreshing Group Policy are at startup and logon. Group Policy is also refreshed at other intervals regularly. The policy refresh interval affects how quickly changes to GPOs are applied. By default, clients and servers check for changes to GPOs every 90 minutes using a randomized offset of up to 30 minutes. Changes to Group Policy settings might not be immediately available on users’ desktops because changes to the GPO must first replicate to the appropriate domain controller.

Domain controllers check for computer policy changes every five minutes. This polling frequency can be changed by using one of these policy settings, Group Policy Refresh Interval for Computers, Group Policy Refresh Interval for Domain Controllers, or Group Policy refresh Interval for Users. Shortening the frequency between refreshes isn't recommended because of the potential increase in network traffic and more load placed on the domain controllers.

Components of a GPO are stored in both AD and on the SYSVOL folder of domain controllers. Replication of a GPO to other domain controllers occurs by two independent mechanisms:

- The built-in replication system controls the replication of AD. By default, replication typically takes less than a minute between domain controllers within the same site. This process can be slower if your network is slower than a LAN.

- Distributed File System Replication (DFSR) controls the replication of the SYSVOL folder. Within sites, replication occurs every 15 minutes. If the domain controllers are in different sites, the replication process occurs at set intervals based on site topology and schedule, the lowest interval is 15 minutes.

## Trigger Group Policy update

If necessary, you can trigger a Group Policy refresh manually in the following ways:

- From a local computer, enter `gpupdate.exe` from the command line. Running `gpupdate.exe` triggers a policy refresh for the computer on which the command is run.

- Use the `Invoke-GPUpdate` PowerShell cmdlet. You can use this cmdlet to trigger a refresh of the local computer or to trigger a refresh of a remote computer.

- Use the GPMC to trigger a group policy refresh at the OU level by right clicking on the OU and selecting **Group Policy Update**.

## Optimize GPO processing

To reduce the amount of time required to process a GPO, consider using the following.

- When a GPO contains only computer configuration or user configuration settings, disable the portion of the policy setting that doesn't apply. With this optimization, the destination computer doesn't scan the portions of a GPO that you disable, which reduces processing time.

- Combine smaller GPOs to form a consolidated GPO. This optimization reduces the number of GPOs that are applied to a user or computer. Applying fewer GPOs to a user or computer can reduce startup or logon times and make it easier to troubleshoot the policy structure.
