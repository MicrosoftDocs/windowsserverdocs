---
title: Manage User Accounts with Active Directory Users and Computers in Windows Server
description: Create, delete, and manage user accounts in Active Directory Users and Computers. Learn how to manage user account properties, group memberships, and passwords.
ms.date: 06/30/2025
ms.topic: how-to
author: orin-thomas
ms.author: orthomas
---

# Manage user accounts in Active Directory Users and Computers

You can create, delete, and manage security principals, including user accounts, in the Active Directory Users and Computers console. This console is available when the Active Directory Domain Services (AD DS) and Active Directory Lightweight Directory Services (AD LDS) components of the Remote Server Administration Tools are installed on a Windows Server or client computer. To create, delete, and manage security permissions, you need to have the appropriate permissions. By default, members of the Domain Admins and Enterprise Admins group can manage user, group, and computer accounts. Members of the Account Operators group can create, modify, and delete user accounts but are unable to manage groups or permissions.

## Prerequisites

- A computer running Windows Server or a Windows client operating system with the AD DS and AD LDS components of the Remote Server Administration Tools installed.

- The computer must be joined to a domain and the user account you're using must have the appropriate permissions to manage user accounts in that domain.

## Managing user accounts

The following sections of this article provide information about managing the user accounts on the server:

- [Create a user account](#create-a-user-account)
- [Manage group memberships](#manage-group-memberships)
- [Reset a user password](#reset-a-user-password)
- [Disable a user account](#disable-a-user-account)
- [Enable a user account](#enable-a-user-account)
- [Remove a user account](#remove-a-user-account)
- [User account properties](#user-account-properties)

### Create a user account

When you add a user account, the assigned user can sign in to a domain joined computer. You can give the user permission to access network resources such as shared folders, printers, and applications. To create a user account by using Active Directory Users and Computers, perform the following steps:

1. In the Active Directory Users and Computers console, expand the domain tree and select the container or organizational unit that you want to host the user account.
1. On the **Action** menu, select **New** and then select **User**.
1. In the **New Object - User** dialog, provide the following information and then select **Next**:
    - **First name**: User's first name (optional)
    - **Initials**: User's initials (optional)
    - **Last name**: User's last name (optional)
    - **Full name**: User's full name (required)
    - **User logon name**: User account name (required)
1. On the second page of the **New Object - User** dialog, provide the following information and then select **Next**:
    - **Password**: Can be the assigned password or a temporary password that the user changes on their next logon.
    - **Confirm**: A duplicate of the assigned password or temporary password.
    - **User must change password at next logon**. Select this checkbox if you want to force the user to change the password at their next logon. 
    - **User cannot change password**. Select this checkbox if you want to restrict the user from changing the password. 
    - **Password never expires**. Select this checkbox if you want to exempt the account from password policies. 
    - **Account is disabled**. Select this checkbox if you want to create the account in a disabled state. 
1. Review the summary page of the **New Object - User** dialog. Select **Finish** to create the account.

### Manage group memberships

Security permissions, such as those to shared folders, are most often assigned to security groups rather than to individual user accounts. By managing which groups a user is a member of, you often manage the resources to which the user account has access. To manage the group membership of an account, perform the following steps.

1. In the Active Directory Users and Computers console, locate and select the user account you want to manage the membership of.
1. On the **Action** menu, select **Properties**.
1. In the user's account properties dialog, select the **Member Of** tab.
1. If you want to remove the user account from a group, select the listed group, select **Remove**, and then select **OK** to close the user account properties dialog.
1. If you want to add the user account to a group, select **Add**. 
1. In the **Select Groups** dialog, enter the name of the group you want to add the account to and then select **OK**. If you're unsure of the group name, use the **Advanced** button to search the domain for groups and the **Check Names** button to verify the name.
1. Select **OK** to close the user account properties dialog and apply the changes.

### Reset a user password

To reset a user account password by using the Active Directory Users and Computers console, perform the following steps:

1. In the Active Directory Users and computers console, locate the user account you want to reset the password for.
1. On the **Action** menu, select **Reset Password**.
1. In the **Reset Password** dialog, provide the following information and then select **OK**.
    - **New password**: New password for the user.
    - **Confirm password**: Reenter the same password.
    - **User must change password at next logon**. Select this checkbox if you want to force the user to change password the next time they sign in.
    - **Unlock the user account**. If the account is locked out because the user entered too many incorrect passwords, select this checkbox to unlock the account.

### Disable a user account

To disable a user account by using the Active Directory Users and Computers console, perform the following steps:

1. In the Active Directory Users and computers console, locate the user account that you want to disable.
1. On the **Action** menu, select **Disable Account**.
1. In the **Active Directory Domain Services** dialog, select **OK**. The account is disabled.

When an account is disabled, a signed in user remains signed in but is unable to perform new sign-ins.

### Enable a user account

To enable a user account by using the Active Directory Users and Computers console, perform the following steps:

1. In the Active Directory Users and computers console, locate the user account you want to enable.
1. On the **Action** menu, select **Enable Account**.
1. In the **Active Directory Domain Services** dialog, select **OK**. The account is enabled.

### Remove a user account

Removing an account from Active Directory deletes the account. The best practice is to disable accounts before deleting them in case the account has permissions to resources that can't be accessed via other methods. To delete an account by using the Active Directory Users and Computers console, perform the following steps:

1. In the Active Directory Users and computers console, locate the user account you want to enable.
1. On the **Action** menu, select **Delete**.
1. In the **Active Directory Domain Services** dialog, select **OK**. The account is removed.

You can recover deleted accounts by using Active Directory recycle bin if you enable the recycle bin before you delete the account. If the recycle bin isn't enabled, you need to perform an authoritative restore of AD DS by using a backup of AD DS that includes the account.

## User account properties

The following list includes all tabs on the **User account properties** page, including tabs that are visible only if the **Advanced Features** option is enabled. You can enable this option on the **View** menu of the Active Directory Users and Computers console. This information is stored with the account as attributes of the AD DS account object.

- [General](#general)
- [Address](#address)
- [Account](#account)
- [Profile](#profile)
- [Telephones](#telephones)
- [Organization](#organization)
- [Remote Desktop Services Profile](#remote-desktop-services-profile)
- [COM+](#com)
- [Attribute Editor](#attribute-editor)
- [Security](#security)
- [Environment](#environment)
- [Sessions](#sessions)
- [Remote control](#remote-control)
- [Published Certificates](#published-certificates)
- [Member Of](#member-of)
- [Password Replication](#password-replication)
- [Dial-in](#dial-in)
- [Object](#object)

### General

The **General** tab of the user account properties page includes the following fields related to the user's name and description:

- First Name
- Initials
- Last name
- Display name
- Description
- Office
- Telephone number
- Web page

### Address

The **Address** tab of the user account properties page allows you to store location information with the account and includes the following fields:

- Street
- P.O. Box
- City
- State/province
- Zip/Postal Code
- Country/region

### Account

The **Account** tab of the user account properties page allows you to configure various account settings. These include logon hours, the specific computers that the account can log on to, and the types of encryption the account supports. You can also set whether the account can be delegated and specify if or when the account should expire. This tab includes the following settings:

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

The **Profile** tab of the user account properties page allows you to configure roaming profile information, logon script, and home folder settings. This tab includes the following fields:

- Profile path
- Logon script
- Home folder

### Telephones

The **Telephones** tab of the user account properties page allows you to store telephone number information with a user account. It includes the following fields:

- Home
- Pager
- Mobile
- Fax
- IP phone
- Notes

### Organization

The **Organization** tab of the user account properties page allows you to store information about a user, including job title and department. You can also use this tab to specify a manager and see which user accounts are listed as direct reports. This tab includes the following fields:

- Job Title
- Department
- Company
- Manager
- Direct reports

### Remote Desktop Services Profile

The **Remote Desktop Service Profile** tab of the user account properties page allows you to configure a Remote Desktop Service user profile. This tab includes the following settings:

- Remote Desktop Services User Profile Profile Path
- Remote Desktop Services Home Folder
- Deny this user permissions to log on to Remote Desktop Session Host server

### COM+

The **COM+** tab of the user account properties page allows you to specify which COM+ partition set a user account is associated with.

### Attribute Editor

The **Attribute Editor** tab of the user account properties page allows you to edit each account attribute directly. The Attribute Editor also shows attributes that aren't exposed through the user properties page interface.

### Security

The **Security** tab of the user account properties page allows you to see the security permissions that apply to the account. By selecting the **Advanced** button, you can also configure auditing of the use of these permissions. 

### Environment

The **Environment** tab of the user account properties page allows you to configure specific programs to start at logon to the Remote Desktop Services environment and whether to connect client drives, printers, and the main client printer at logon. 

### Sessions

The **Sessions** tab of the user account properties page allows you to configure Remote Desktop Services time-out and reconnection settings. You can configure the following settings on this tab:

- End a disconnected session
- Active session limit
- Idle session limit
- What action to take when a session limit is reached or connection is broken
- Whether to allow reconnection from any client or only the originating client

### Remote control

The **Remote Control** tab of the user account properties page allows you to configure Remote Desktop Services remote control settings. This tab includes the following fields:

- Enable remote control
- Require user's permission
- Level of control (view/interact)

### Published Certificates

The **Published Certificates** tab of the user account properties page lists all X509 certificates published for the user account and stored in Active Directory.

### Member Of

The **Member Of** tab of the user account properties page allows you to add or remove security group membership.

### Password Replication

The **Password Replication** tab of the user account properties page allows you to specify which read-only domain controllers store cached copies of the user account's password.

### Dial-in

The **Dial-in** tab of the user account properties page allows you to configure the following Network Policy Server network access permissions:

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

The **Object** tab of the user account properties page allows you to view information about the security principal object and to configure the **Protect object from accidental deletion** setting.
