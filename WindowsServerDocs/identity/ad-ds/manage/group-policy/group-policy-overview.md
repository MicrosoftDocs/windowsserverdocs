---
title: Group Policy overview
description: You can use this article to understand Group Policy in Active Directory Domain Services.
author: Orin-Thomas
ms.topic: conceptual
ms.author: orthomas
contributor: orthomas
ms.date: 02/18/2024
---

# Group Policy overview

Group Policy enables Active Directory–based change and configuration management of user and computer settings on computers running Windows Server and Windows Client operating systems. In addition to using Group Policy to define configurations for groups of users and computers, you can also use Group Policy to help manage server computers, by configuring many server-specific operational and security settings.

## What is a Group Policy Object (GPO)?

The Group Policy settings you create are contained in a GPO. To create and edit a GPO, use the Group Policy Management Console (GPMC). By using the GPMC to link a GPO to selected Active Directory sites, domains, and organizational units (OUs), you apply the policy settings in the GPO to the users and computers in those Active Directory objects. GPOs are stored in both Active Directory and in the Sysvol folder on each domain controller. 

## What is an Organizational Unit (OU)

An OU is the lowest-level Active Directory container to which you can assign Group Policy settings. Typically, you assign most GPOs at the OU level, so make sure that your OU structure supports your Group Policy-based client-management strategy. You might also apply some Group Policy settings at the domain level, particularly those such as password policies. Very few policy settings are applied at the site level. A well-designed OU structure that reflects the administrative structure of your organization and takes advantage of GPO inheritance simplifies the application of Group Policy. For example, a well-designed OU structure can prevent duplicating certain GPOs so that you can apply these GPOs to different parts of the organization. If possible, create OUs to delegate administrative authority and to help implement Group Policy.

OU design requires balancing requirements for delegating administrative rights independent of Group Policy needs, and the need to scope the application of Group Policy. You can create OUs within a domain and delegate administrative control for specific OUs to particular users or groups. By using a structure in which OUs contain homogeneous objects, such as either user or computer objects but not both, you can easily disable those sections of a GPO that do not apply to a particular type of object. This approach to OU design reduces complexity and improves the speed at which Group Policy is applied. Keep in mind that GPOs linked to the higher layers of the OU structure are inherited by default by OUs at the lower layer, which reduces the need to duplicate GPOs or to link a GPO to multiple containers.

