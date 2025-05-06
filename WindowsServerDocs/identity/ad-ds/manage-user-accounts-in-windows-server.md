---
title: "Manage user accounts with Active Directory Users and Computers in Windows Server"
description: Create, delete, and manage user accounts in Active Directory Users and Computers. Learn how to manage user account properties, group memberships, and passwords.
ms.date: 03/05/2025
ms.topic: article
author: orin-thomas
ms.author: orthomas
---

# Manage User Accounts in Active Directory Users and Computers

You can create, delete, and manage security principals, including user accounts, in the Active Directory Users and Computers console. This console is available when the Active Directory Domain Services (AD DS) and Active Directory Lightweight Directory Services (AD LDS) Tools component of the Remote Server Administration tools are installed on a Windows Server or client computer. To create, delete, and manage security permissions you need to have the appropriate permissions. By default members of the Domain Admins and Enterprise Admins group can manage user, group, and computer accounts. Members of the Account Operators group are able to create, modify, and delete user accounts but are unable to manage groups or permissions.

## Prerequisites

To manage user accounts in Active Directory Users and Computers, you need to have the following prerequisites:

- A computer running Windows Server or Windows client operating system with the Active Directory Domain Services (AD DS) and Active Directory Lightweight Directory Services (AD LDS) Tools component of the Remote Server Administration tools installed.

- The computer must be joined to a domain and the user account you are using must have the appropriate permissions to manage user accounts in that domain.

## Managing user accounts

The following sections of this page provide information manage the user accounts on the server:

- [Create a user account](#create-a-user-account)
- [Manage group memberships](#manage-group-memberships)
- [Reset a user password](#reset-a-user-password)
- [Disable a user account](#disable-a-user-account)
- [Enable a user account](#enable-a-user-account)
- [Remove a user account](#remove-a-user-account)
- [User account properties](#user-account-properties)

### Create a user account

When you add a user account, the assigned user can sign in a domain joined computer. You can give the user permission to access network resources such as shared folders, printers, and applications. To create a user account using Active Directory Users and Computers, perform the following steps:

1. In the Active Directory Users and Computers console, expand the domain tree and select the container or organizational unit that you wish to host the user account.
1. On the Action menu, select New and then select User.
1. On the New Object - User dialog provide the following information and choose Next:
    - First name: User's first name (optional field)
    - Initials: User's initials (optional field)
    - Last name: User's last name (optional field)
    - Full name: User's full name (mandatory field)
    - User logon name: User account name (mandatory field)
1. On the second page of the New Object - User dialog, provide the following information and choose Next:
    - Password: Can be the assigned password or a temporary password that the user changes on next logon
    - Confirm: A duplicate of the assigned password or temporary password
    - User must change password at next logon. A checkbox that can be enabled to force the user to change password at next logon. Can be enabled or left blank.
    - User cannot change password. A checkbox that can be enabled to restrict the user from changing their password. Can be enabled or left blank.
    - Password never expires. A checkbox that can be enabled to exempt the account from password policies. Can be enabled or left blank.
    - Account is disabled. A checkbox that allows to you create the account in a disabled state. Can be enabled or left black.
1. Review the summary page of the New Object - User dialog and choose Finish to create the account.

### Manage group memberships

Security permissions, such as those to shared folders, are most often assigned to security groups rather than to individual user accounts. By managing which groups a user is a member of, you often manage the resources to which the user account has access. To manage the group membership of an account, perform the following steps.

1. In the Active Directory Users and Computers console, locate and select the user account you wish to manage the membership of.
1. From the Action menu, select Properties.
1. On the users account properties dialog box, select the Member Of tab.
1. If you want to remove the user account from a group, select the listed group and select Remove and then choose OK to close the user account properties dialog box.
1. If you want to add the user account to a group, select Add. 
1. On the Select Groups dialog box, enter the name of the group you wish to add the account to and then select OK. If you're unsure of the group name, use the Advanced button to search the domain for groups and the Check Names button to verify the correct name.
1. Choose OK to close the user account properties dialog box and apply the changes.

### Reset a user password

To reset a user account password using the Active Directory Users and Computers console, perform the following steps:

1. In the Active Directory Users and computers console, locate and the user account you wish to reset the password for.
1. From the Action menu, select Reset Password.
1. On the Reset Password dialog box, provide the following information and choose OK.
    - New password: New password for the user
    - Confirm password: Reenter the same password to confirm
    - User must change password at next logon. A checkbox that you can enable to force the user to change password the next time they sign on.
    - Unlock the user account. If the account is locked out due entering incorrect passwords, enable this checkbox to unlock the account.

### Disable a user account

To disable a user account using the Active Directory Users and Computers console, perform the following steps:

1. In the Active Directory Users and computers console, locate and the user account you wish to disable.
1. From the Action menu, select Disable Account.
1. On the Active Directory Domain Services dialog, select OK. The account is disabled.

When an account is disabled, a signed on remains signed in but is unable to perform new sign ins.

### Enable a user account

To enable a user account using the Active Directory Users and Computers console, perform the following steps:

1. In the Active Directory Users and computers console, locate and the user account you wish to enable.
1. From the Action menu, select Enable Account.
1. On the Active Directory Domain Services dialog, select OK. The account is enabled.

### Remove a user account

Removing an account from Active Directory deletes the account. Best practice is to disable accounts before deleting them in case the account has permissions to resources that can't be accessed using other methods. To delete an account using the Active Directory Users and Computers console, perform the following steps:

1. In the Active Directory Users and computers console, locate and the user account you wish to enable.
1. From the Action menu, select Enable Account.
1. On the Active Directory Domain Services dialog, select OK. The account is enabled.

Deleted accounts can be recovered using Active Directory Recycle Bin if you enable the Active Directory Recycle Bin before account deletion. If Active Directory Recycle Bin isn't enabled, you need to perform an authoritative restore of AD DS using a backup of AD DS that includes the account.

## User account properties

The following list includes all tabs on the User account properties page, including tabs are only visible if the Advanced Features option is enabled. You can enable this option on the View menu of the Active Directory Users and Computers console. This information is stored with the account as attributes of the AD DS account object.

[General](#general)
[Address](#address)
[Account](#account)
[Profile](#profile)
[Telephones](#telephones)
[Organization](#organization)
[Remote Desktop Services Profile](#remote-desktop-services-profile)
[COM+](#com)
[Attribute Editor](#attribute-editor)
[Security](#security)
[Environment](#environment)
[Sessions](#sessions)
[Remote control](#remote-control)
[Published Certificates](#published-certificates)
[Member Of](#member-of)
[Password Replication](#password-replication)
[Dial-in](#dial-in)
[Object](#object)

### General

The General tab of the user account properties page includes the following fields related to the user's name and description:

- First Name
- Initials
- Last name
- Display name
- Description
- Office
- Telephone number
- Web page

### Address

The Address tab of the user account properties page allows you to store location information with the account and includes the following fields:

- Street
- P.O. Box
- City
- State/province
- Zip/Postal Code
- Country/region

### Account

The Account tab of the user account properties page allows you to configure various account settings. These include logon hours, the specific computers that the account can log on to, and the types of encryption the account supports. You can also set whether the account can be delegated and specify if or when the account should expire. This tab includes the following settings:

- User logon name, including user logon domain
- User logon name (Pre-Windows 2000)
- Logon Hours
- Log On To
- Unlock account
- User must change password at next logon
- User cannot change password
- Password never expires
- Store password using reversible encryption
- Account is disabled
- Smart card is required for interactive logon
- Account is sensitive and cannot be delegated
- Use only Kerberos DES encryption types for this account
- This account supports Kerberos AES 128 bit encryption
- This account supports Kerberos AES 256 bit encryption
- Do not require Kerberos preauthentication
- Account expires

### Profile

The Profile tab of the user account properties page allows you to configure roaming profile information, logon script, and home folder settings. This tab includes the following fields:

- Profile path
- Logon script
- Home folder

### Telephones

The Telephones tab of the user account properties page allows you to store telephone number information with a user account and includes the following fields:

- Home
- Pager
- Mobile
- Fax
- IP phone
- Notes

### Organization

The Organization tab of the user account properties page allows you to store information about a user including job title and department. You can also use this tab to specify a manager and see which user accounts are listed as direct reports. This tab includes the following fields:

- Job Title
- Department
- Company
- Manager
- Direct reports

### Remote Desktop Services Profile

The Remote Desktop Service Profile tab of the user account properties page allows you to configure a Remote Desktop Service user profile. This tab includes the following fields:

- Remote Desktop Services User Profile Profile Path
- Remote Desktop Services Home Folder
- Deny this user permissions to log on to Remote Desktop Session Host server

### COM+

The COM+ tab of the user account properties page allows you to specify which COM+ partition set a user account is associated with.

### Attribute Editor

The Attribute Editor tab of the user account properties page allows you to edit each account attribute directly. The Attribute Editor also shows attributes that are not exposed through the user properties page interface.

### Security

The Security tab of the user account properties page allows you to see the security permissions that apply to the account. By selecting the Advanced button, you can also configure auditing of the use of these permissions. 

### Environment

The Environment tab of the user account properties page allows you to configure specific programs to start at logon to the Remote Desktop Services environment and whether to connect client drives, printers, and the main client printer at logon. 

### Sessions

The Sessions tab of the user account properties page allows you to configure Remote Desktop Services time-out and reconnection settings. You can configure the following settings on this tab:

- End a disconnected session
- Active session limit
- Idle session limit
- What action to take when a session limit is reached or connection is broken
- Whether to allow reconnection from any client or only the originating client

### Remote control

The Remote Control tab of the user account properties page allows you to configure Remote Desktop Services remote control settings. This tab includes the following fields:

- Enable remote control
- Require user's permission
- Level of control (view/interact)

### Published Certificates

The Published Certificates tab of the user account properties page lists all X509 certificates published for the user account and stored within Active Directory.

### Member Of

The Member Of tab of the user account properties page allows you to manage security group group membership. You can add or remove group membership using this tab of the user account properties page.

### Password Replication

The Password Replication tab of the user account properties page allows you to manage whether the user account's password are cached on Read Only Domain Controllers. You can use this tab to specify which Read Only Domain Controllers store cached copies of the user account's password.

### Dial-in

The Dial-in tab of the user account properties page allows you to configure the following Network Policy Server Network Access Permissions:

- Allow access
- Deny access
- Control access through NPS Network Policy
- Verify Caller-ID
- No Callback
- Set by caller
- Always callback to
- Assign Static IP addresses
- Apply Static Routes

### Object

The Object tab of the user account properties page allows you to view information about the security principal object and to configure the "Protect object from accidental deletion" setting.
