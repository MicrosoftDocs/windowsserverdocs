---
title: User access options with Windows Admin Center
description: User access options and identity providers with Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: haley-rowland
ms.author: harowl
ms.date: 03/07/2019
ms.localizationpriority: medium
ms.prod: windows-server
---

# User access options with Windows Admin Center

>Applies To: Windows Admin Center, Windows Admin Center Preview

When deployed on Windows Server, Windows Admin Center provides a centralized point of management for your server environment. By controlling access to Windows Admin Center, you can improve the security of your management landscape.

## Gateway access roles

Windows Admin Center defines two roles for access to the gateway service: gateway users and gateway administrators.

> [!NOTE]
> Access to the gateway does not imply access to the target servers visible by the gateway. To manage a target server, a user must connect with credentials that have administrative privileges on the target server.

**Gateway users** can connect to the Windows Admin Center gateway service in order to manage servers through that gateway, but they cannot change access permissions nor the authentication mechanism used to authenticate to the gateway.

**Gateway administrators** can configure who gets access as well as how users will authenticate to the gateway.

>[!NOTE]
> If there are no access groups defined in Windows Admin Center, the roles will reflect the Windows account access to the gateway server. 

[Configure gateway user and administrator access in Windows Admin Center.](../configure/user-access-control.md)

## Identity provider options

Gateway administrators can choose either of the following:

 - [Active Directory/local machine groups](../configure/user-access-control.md#active-directory-or-local-machine-groups)
 - [Azure Active Directory as the identity provider for Windows Admin Center](../configure/user-access-control.md#azure-active-directory)


### Smartcard authentication

When using Active Directory or local machine groups as the identity provider, you can enforce smartcard authentication by requiring users who access Windows Admin Center to be a member of additional smartcard-based security groups. [Configure smartcard authentication in Windows Admin Center.](../configure/user-access-control.md#active-directory-or-local-machine-groups)

### Conditional access and multi-factor authentication

By requiring Azure AD authentication for the gateway, you can leverage additional security features like conditional access and multi-factor authentication provided by Azure AD. [Learn more about configuring conditional access with Azure Active Directory.](https://docs.microsoft.com/azure/active-directory/active-directory-conditional-access-azure-portal-get-started)

## Role-based access control

By default, users require full local administrator privileges on the machines they wish to manage using Windows Admin Center.
This allows them to connect to the machine remotely and ensures they have sufficient permissions to view and modify system settings.
However, some users may not need unrestricted access to the machine to perform their jobs.
You can use **role-based access control** in Windows Admin Center to provide such users with limited access to the machine instead of making them full local administrators.

Role-based access control in Windows Admin Center works by configuring each managed server with a PowerShell [Just Enough Administration](https://aka.ms/jeadocs) endpoint.
This endpoint defines the roles, including what aspects of the system each role is allowed to manage and which users are assigned to the role.
When a user connects to the restricted endpoint, a temporary local administrator account is created to manage the system on their behalf.
This ensures that even tools which do not have their own delegation model can still be managed with Windows Admin Center.
The temporary account is automatically removed when the user stops managing the machine through Windows Admin Center.

When a user connects to a machine configured with role-based access control, Windows Admin Center will first check if they are a local administrator.
If they are, they will receive the full Windows Admin Center experience with no restrictions.
Otherwise, Windows Admin Center will check if the user belongs to any of the pre-defined roles.
A user is said to have *limited access* if they belong to a Windows Admin Center role but are not a full administrator.
Finally, if the user is neither an administrator nor a member of a role, they will be denied access to manage the machine.

Role-based access control is available for the Server Manager and Failover Cluster solutions.

### Available roles

Windows Admin Center supports the following end-user roles:

Role name | Intended use
----------|-------------
Administrators | Allows users to use most of the features in Windows Admin Center without granting them access to Remote Desktop or PowerShell. This role is good for "jump server" scenarios where you want to limit the management entry points on a machine.
Readers | Allows users to view information and settings on the server, but not make changes.
Hyper-V Administrators | Allows users to make changes to Hyper-V virtual machines and switches, but limits other features to read-only access.

The following built-in extensions have reduced functionality when a user connects with limited access:

- Files (no file upload or download)
- PowerShell (unavailable)
- Remote Desktop (unavailable)
- Storage Replica (unavailable)

At this time, you cannot create custom roles for your organization, but you can choose which users are granted access to each role.

### Preparing for role-based access control

To leverage the temporary local accounts, each target machine needs to be configured to support role-based access control in Windows Admin Center.
The configuration process involves installing PowerShell scripts and a Just Enough Administration endpoint on the machine using Desired State Configuration.

If you only have a few computers, you can easily apply the configuration individually to each computer using the role-based access control page in Windows Admin Center.
When you set up role-based access control on an individual computer, local security groups are created to control access to each role.
You can grant access to users or other security groups by adding them as members of the role security groups.

For an enterprise-wide deployment on multiple machines, you can download the configuration script from the gateway and distribute it to your computers using a Desired State Configuration pull server, Azure Automation, or your preferred management tooling.
