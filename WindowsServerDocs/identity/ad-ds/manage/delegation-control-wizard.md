---
description: Learn how to delegate administrative control in Active Directory Domain Services on Windows Server.
title: Delegation of Control in Active Directory Domain Services on Windows Server
ms.author: orthomas
author: orin-thomas
ms.date: 07/15/2024
ms.topic: how-to
#customer intent: As an Active Directory administrator, I want to delegate administrative control to users or groups so that I can assign a range of administrative tasks to the appropriate users and groups.
---

# Delegation of Control in Active Directory Domain Services

> 

Delegation of Control means you can assign a range of administrative tasks to different users and groups. You can assign basic administrative tasks to regular users or groups, and leave domain-wide and forest-wide administration to members of the Domain Admins and Enterprise Admins groups. By delegating administration, you can allow groups within your organization to take more control of their local resources. You also help secure your Active Directory environment accidental or malicious damage by limiting the membership of administrator groups.

You can delegate administrative control to any level of a domain tree by creating organizational units within a domain and delegating administrative control for specific organizational units to particular users or groups. To decide what organizational units you want to create, and which organizational units should contain accounts or shared resources, consider the structure of your organization.

Active Directory defines specific permissions and user rights that can be used for delegating or restricting administrative control. Using a combination of organizational units, groups, and permissions, you can define the most appropriate administrative scope for a particular person, which could be an entire domain, all organizational units within a domain, or a single organizational unit.

Administrative control can be assigned to a user or group using the _Delegation of Control Wizard_. You can use the Delegation of Control Wizard to delegate the following tasks:

- Create, delete, and manage user accounts
- Reset user passwords and force password change at next logon
- Read all user information
- Modify the membership of a group
- Join a computer to a domain
- Manage Group Policy links
- Generate Resultant Set of Policy (Planning)
- Generate Resultant Set of Policy (Logging)
- Create, delete, and manage inetOrgPerson accounts
- Reset inetOrgPerson passwords and force password change at next logon
- Read all inetOrgPerson information

## Prerequisites

Before you can delegate control, you'll need the following prerequisites.

- You must be a member of the Domain Admins group or have been delegated the necessary permissions to perform the tasks you want to delegate.

- On the computer where you'll delegate control, you must have the AD DS Remote Server Administration Tools (RSAT) installed.

## Delegate control

When you use the Delegation of Control Wizard, you delegate not only at the domain or organizational unit level, but to all objects under that container.

To use the Delegation of Control Wizard, perform the following steps:

1. In Active Directory Users and Computers, select the parent container. For example select the domain or organizational unit over which you wish to delegate control.

1. From the Action menu, select **Delegate control**. This will start the Delegation of Control Wizard.

1. On the Users or Groups page, select the users or groups to which you're delegating privileges.

1. On the Tasks to Delegate page, select the task that you want to delegate from a list of common tasks as explained earlier in this article.

1. Choose Finish to complete the delegation process.

 You can also choose the create a custom task to delegate option if you wish to create a custom task. Creating a custom task involves specifying the type of object that the task relates to and the permissions you want to delegate. The common tasks apply to all objects within the scope of the container on which you're performing delegation.

## Related content

- [Delegating Administration by Using OU Objects](../plan/Delegating-Administration-by-Using-OU-Objects.md)
- [Setting up delegated Managed Service Accounts](../../../security/delegated-managed-service-accounts/delegated-managed-service-accounts-set-up-dmsa.md)