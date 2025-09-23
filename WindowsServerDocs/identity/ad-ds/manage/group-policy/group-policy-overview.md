---
title: Group Policy overview for Windows Server
description: Learn about what Group Policy does and how it works with Active Directory Domain Services in Windows.
author: orin-thomas
ms.topic: overview
ms.author: daknappe
contributor: orthomas
ms.date: 06/10/2025
#customer intent: As an IT administrator, I want to understand Group Policy so that I can manage user and computer settings effectively.
---

# Group Policy overview for Windows Server

Group Policy enables configuration and settings management of user and computer settings on computers running Windows Server and Windows Client operating systems. In addition to using Group Policy to define configurations for groups of users and client computers, you can also use Group Policy to help manage server computers, by configuring many server-specific operational and security settings.

## What is a Group Policy

Group policy can represent policy settings in the locally in the file system or in Active Directory Domain Services (AD DS). When used with Active Directory (AD), Group Policy settings are contained in a Group Policy Object (GPO). A GPO is a virtual collection of policy settings, security permissions, and scope of management (SOM) that you can apply to users and computers in AD. A GPO consists of two main components: the Group Policy container and the Group Policy template. The Group Policy container is stored in the domain partition of Active Directory, while the Group Policy template is located in the SYSVOL folder on each domain controller (DC).


These components are replicated across DCs via AD replication and either the File Replication Service (FRS) or Distributed File System Replication (DFSR).

GPOs include configurations for both computer and user settings. Computer configurations apply system-wide and manage settings like power management and firewall rules. User configurations affect only the current user, with options such as Internet Explorer settings and Folder Redirection. GPOs can be linked to various levels within the AD hierarchy, such as sites, domains, and organizational units (OUs), which define their scope of application.

Policy settings are applied at computer startup and user sign in. The Group Policy service determines applicable GPOs by querying the AD based on site, domain, and OU membership. A [Client-side extension](#client-side-extensions) (CSE) applies the specific settings dictated by the GPOs, managing tasks like registry updates and security configurations. Policy settings are applied to computers when they start up and to users when they sign in. When a computer starts up, the Group Policy service checks AD to determine which GPOs are linked and applicable to the computer object, including:

- The site in which the computer resides.

- The domain in which the computer is a member.

- The parent organizational unit to which the computer is a direct member and any other organizational units above the parent OU.

Group Policy preferences offer similar management capabilities as standard Group Policies and are managed in the same way. Administrators can create and manage GPOs using the Local Group Policy Editor (`gpedit.msc`) for local settings, or the Group Policy Object Editor within an AD-related MMC snap-in for domain-wide settings. Each GPO has a globally unique identifier (GUID) and follows the hierarchical structure of AD for policy evaluation. A thorough understanding of how to create, modify, and link GPOs within AD is essential for effective policy management. GPOs are stored in both AD and the SYSVOL folder on each DC, facilitating centralized administration and policy enforcement.

## Client-side extensions

A Group Policy CSE is an isolated component responsible for processing specific policy settings delivered by the Group Policy infrastructure. Each CSE manages and stores its policy data in its own specific format, independent of the Group Policy infrastructure, which doesn't interpret or manage the details of this data. The primary function of Group Policy is to deliver settings to a computer, where each CSE applies its portion of the policy settings from multiple Group Policy Objects.

Imagine the Group Policy infrastructure as a library system. The library system manages and delivers books (or data) to various branches (the computers). The library doesn't need to understand the content of each book; it simply ensures that the correct book gets to the right branch. In this analogy, the Group Policy service is like the library system, delivering books without knowing their content. The various policy settings are like different genres or collections of books. The Group Policy CSE represents a librarian at each branch, who knows how to handle their specific collection. Just as each librarian is equipped to manage their collection, each CSE reads its specific policy setting information and performs actions based on what it finds within those settings.

## How Group Policy works

For computers, Group Policy is applied when the computer starts. For users, Group Policy is applied at sign in. This initial processing of policy can also be referred to as a foreground policy application.

The foreground application of Group Policy can be synchronous or asynchronous. In synchronous mode, the computer doesn't complete the system start until computer policy is applied successfully. The user sign in process doesn't complete until user policy is applied successfully. In asynchronous mode, if there are no policy changes that require synchronous processing, the computer can complete the start sequence before the application of computer policy is complete. The shell can be available to the user before the application of user policy is complete. The system then periodically applies (refreshes) Group Policy in the background. During a refresh, policy settings are applied asynchronously.

To learn more about how Group Policies work, see [Group Policy Processing](group-policy-processing.md).

## What is an OU

An OU is the lowest-level AD container to which you can assign Group Policy settings. Typically, you assign most GPOs at the OU level, so make sure that your OU structure supports your Group Policy-based client-management strategy. You might also apply some Group Policy settings at the domain level, particularly password policies. Few policy settings are applied at the site level. A well-designed OU structure that reflects the administrative structure of your organization and takes advantage of GPO inheritance simplifies the application of Group Policy. For example, a well-designed OU structure can prevent duplicating certain GPOs so that you can apply these GPOs to different parts of the organization. If possible, create OUs to delegate administrative authority and to help implement Group Policy.

OU design requires balancing requirements for delegating administrative rights independent of Group Policy needs, and the need to scope the application of Group Policy. You can create OUs within a domain and delegate administrative control for specific OUs to particular users or groups. By using a structure in which OUs contain homogeneous objects, such as either user or computer objects but not both, you can easily disable those sections of a GPO that don't apply to a particular type of object. This approach to OU design reduces complexity and improves the speed at which Group Policy is applied. GPOs linked to the higher layers of the OU structure are inherited by default for OUs at the lower layer, reducing the need to duplicate GPOs or to link a GPO to multiple containers.

## Related content

- [Group Policy Processing](group-policy-processing.md)
- [Backing up, restoring, migrating, and copying Group Policy Objects (GPOs)](group-policy-backup-restore.md)
- [Group Policy Modeling and Group Policy Results](group-policy-modeling-results.md)
- [Group Policy Management Console (GPMC)](group-policy-management-console.md)
- [Group Policy Settings Used in Windows Authentication](../../../../security/windows-authentication/group-policy-settings-used-in-windows-authentication.md)

