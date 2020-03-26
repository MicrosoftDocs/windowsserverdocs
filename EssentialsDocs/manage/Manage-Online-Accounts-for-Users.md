---
title: Manage Online Accounts for Windows Server Essentials Users
description: Describes how to use Windows Server Essentials
ms.date: 10/03/2016
ms.prod: windows-server
ms.topic: article
ms.assetid: c09f4cf6-4d12-49fe-9ae4-e6cb14027b9d
author: nnamuhcs
ms.author: daveba
---

# Manage Online Accounts for Windows Server Essentials Users

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

When you integrate your  Windows Server Essentials server with Microsoft  Office 365, you can manage your online accounts along with user accounts from the Dashboard. In this topic, you ll find out what you can gain by managing your users  Microsoft Online Services accounts from the Dashboard, how to create and manage online accounts from the Dashboard, and how to manage email addresses and distribution groups for Exchange Online from the Dashboard.  

  
> [!NOTE]
>  To manage your Microsoft Online Services accounts in  Windows Server Essentials, you must integrate your server with  Office 365. For instructions, see [Manage Office 365](Manage-Office-365-in-Windows-Server-Essentials.md).  
  
> [!IMPORTANT]
>  If you  managing online accounts in  Windows Server Essentials, you  accustomed to seeing the Microsoft Online Services accounts referred to as *Office 365 accounts*. On the Dashboard in  Windows Server Essentials, the labels were changed to *Microsoft Online Services accounts*, or *Microsoft online accounts* for short. The accounts and the procedures are the same; only the labels changed. Most procedures in this topic use the term *online account*.  
  
## In this topic  
  
-   [Why should I manage my online accounts from the Dashboard?](#BKMK_WhyManageOnlineAccounts)  
  
-   [Create online accounts](#BKMK_SECTION_CreateOnlineAccounts)  
  
-   [Manage online accounts](#BKMK_SECTION_ManageOnlineAccounts)  
  
-   [Manage email addresses for Exchange Online](#BKMK_SECTION_ManageEmailAddresses)  
  
-   [Manage distribution groups for Exchange Online](#BKMK_SECTION_ManageDistributionGroups)  
  
##  <a name="BKMK_WhyManageOnlineAccounts"></a> Why should I manage my online accounts from the Dashboard?  
 When you use the Dashboard to assign a Microsoft Online Services account to a user account, the account passwords are automatically synchronized, and you can maintain the two accounts together throughout the user account s lifecycle.  
  
 It s convenient for the user, who can use the same password to access resources on the server and in  Office 365. And you can apply the same password requirements for access to resources in  Office 365 that you require for your in-house resources.  
  
### How does password synchronization work?  
 When you use the Dashboard to assign a Microsoft Online Services account to a user account, the user account password is automatically synchronized with the user s online account. This means that a user only needs a single password to access both the resources on the server and in  Office 365. Furthermore, you can use the same name for the user account and the user s online ID.  
  
 Password synchronization occurs immediately and automatically when a user changes the password for their user account from a domain-joined computer or by using Remote Web Access.  
  
> [!IMPORTANT]
>  If  Office 365 is integrated with  Windows Server Essentials, users should not change the password for their Microsoft online account from the  Office 365 portal. Doing so will break the password synchronization.  
  
### Simplified account creation  
 There s another advantage when you create your initial online accounts from the Dashboard. You can create online accounts for all of your users with a single action. On the other hand, if your employees are using  Office 365 already, and you  setting up a new  Windows Server Essentials server, you can create all of your user accounts from the online accounts with a single action. For more information, see [Create online accounts](#BKMK_SECTION_CreateOnlineAccounts).  
  
### Manage email addresses and distribution groups from the Dashboard  
 You will be able to manage your email addresses and distribution groups for Exchange Online from the Dashboard. And you can use your organization s Internet domain in the email addresses. You can do all of this from the Dashboard, without signing in to  Office 365. (You ll need to be using  Windows Server Essentials to manage distribution groups from the Dashboard. This feature is not supported in  Windows Server Essentials.) For more information, see [Manage email addresses for Exchange Online](#BKMK_SECTION_ManageEmailAddresses) and [Manage distribution groups for Exchange Online](#BKMK_SECTION_ManageDistributionGroups).  
  
### Manage the user account and online account together  
 And you can manage an online account along with the user account throughout the account s lifecycle. If you deactivate the user account, the online account also is deactivated in Microsoft Online Services. If you remove a user account, the online account also is removed. For more information, see [Manage online accounts](#BKMK_SECTION_ManageOnlineAccounts).  
  
##  <a name="BKMK_SECTION_CreateOnlineAccounts"></a> Create online accounts  
 After you integrate your server with  Office 365, it s to your advantage to create Microsoft Online Services accounts for your users from the Dashboard. You ll have a lot of flexibility in creating the online accounts. If you have a new  Office 365 subscription, you can bulk-create online accounts for all of your users. If you have already created your online accounts in  Office 365, don t worry. If you  setting up a new server, you can create your user accounts on the server by importing the online accounts. And you can assign either a new or an existing online account when you create an individual user account or when you add an online account to an existing user account.  
  
 **License requirements** You will need a user license for each online account that you create. Check the **Office 365** page on the Dashboard to see how many user licenses are available through your  Office 365 subscription. If you need to add more user licenses, you ll be able to open your  Office 365 subscription in  Office 365 to do that.  
  
 **Follow-up for users** After you add an online account for a user account, the user is required to change the password for their user account the next time they sign in. The new password is synchronized immediately with their online account. After that, they can use the password to sign in to  Office 365 with their online ID.  
  
> [!IMPORTANT]
>  Emphasize to your users that they should never change their online account password in  Office 365. The password will be changed automatically whenever they change the password for their user account. If they change the online password in  Office 365, password synchronization will be broken.  
  
 Use the procedures in this section to:  
  
-   [Bulk-create online accounts for your existing user accounts](#BKMK_ToBulkCreateOnlineAccounts)  
  
-   [Import user accounts from your Microsoft Online Services accounts](#BKMK_ToImportUserAccounts)  
  
-   [Create a new user account with an online account assigned to it](#BKMK_ToCreateaNewUserAccount)  
  
-   [Assign an online account to a user account](#BKMK_ToAssignAnOnlineAccount)  
  
> [!NOTE]
>  If you  using  Windows Server Essentials, you will see *Office 365 account* instead of *Microsoft Online Services account* throughout these procedures. The process is the same, but the terminology changed in  Windows Server Essentials.  
  
###  <a name="BKMK_ToBulkCreateOnlineAccounts"></a> To bulk-create online accounts for your existing user accounts  
  
1.  Sign in on the server as an administrator, and open the  Windows Server Essentials Dashboard.  
  
2.  On the Dashboard, open the **Users** page.  
  
3.  In **Users Tasks**, click **Add Microsoft online accounts**.  
  
     The **Add Microsoft Online Services accounts** page of the wizard displays all user accounts that do not have a Microsoft online account. All of the accounts are selected by default, and the user name is suggested for the Microsoft online ID. If you have linked a custom Internet domain to your  Office 365 subscription, that domain will be used by default.  
  
4.  On the **Add Microsoft Online Services accounts** page, review the accounts that will be created. For example, check for users who already have an online account with a different online ID, and make sure the domain that you want to use in email addresses is selected. When you finish making any needed changes, click **Next**.  
  
5.  On the **Assign Microsoft Online Services licenses** page, select  Office 365 services your users will use. When you click **Next**, account creation will begin.  
  
    > [!NOTE]
    >  You must have a service license in  Office 365 for each online account. You can check your available licenses and, if needed, open your subscription to add licenses from the **Office 365** page on the Dashboard.  
  
6.  Notify users that they now have a Microsoft online account. They must change their network user account password before they can sign in to  Office 365. For instructions, see [To begin using a new Microsoft online account](#BKMK_ToBeginUsingAnOnlineAccount).  
  
###  <a name="BKMK_ToBeginUsingAnOnlineAccount"></a> To begin using a new Microsoft online account  
  
1.  Sign in on your computer with your network user account.  
  
2.  Change the password for your user account. To get started, press Ctrl+Alt+Delete, and click **Change a password**.  
  
     When you change your password, the password is synchronized with your new online account. You can now use the same password to sign in to  Office 365.  
  
3.  [Sign in to Office 365](https://login.microsoftonline.com/login.srf?wa=wsignin1.0&rpsnv=3&ct=1398981834&rver=6.1.6206.0&wp=MBI_SSL&wreply=https:%2F%2Foutlook.office365.com%2Fowa%2F&id=260563&CBCXT=out) using your new online ID and your user account password.  
  
    > [!IMPORTANT]
    >  Do not change your online account password in  Office 365. That will break password synchronization. Your online password will be updated each time you change the password for your network user account.  
  
###  <a name="BKMK_ToImportUserAccounts"></a> To import user accounts from your existing online accounts  
  
1.  On the Dashboard, open the **Users** page.  
  
2.  In **Users Tasks**, click **Import accounts from Office 365**.  
  
     The next page displays all online accounts for your  Office 365 subscription that do not have a user account on the server. All of the accounts are selected by default, and the online ID is suggested for the user name.  
  
3.  To create the user accounts:  
  
    1.  Make any changes that are needed to the proposed user accounts.  
  
    2.  Optionally click the link to view the temporary passwords that will be assigned to the user accounts. You will need to give your users their temporary password along with their new account name.  
  
         (After you create the accounts, you ll find these passwords listed in this file: *SystemDrive*\Users\\*Office365admin*\\*NewServerUser*.txt where *Office365admin* is the network account that is used to administer  Office 365 on the server and *NewServerUser* is the new user account name.)  
  
    3.  Click **Next** to create the user accounts.  
  
4.  Let your users know their new user accounts and the temporary passwords they will use to sign in on the server for the first time  œ and that they will have to change the password after they sign in. For instructions for your users, see [To begin using a new Microsoft online account](#BKMK_ToBeginUsingAnOnlineAccount).  
  
     Be sure they know that the passwords for their online account will be synchronized with their user account going forward, and they should not change their online password in  Office 365.  
  
###  <a name="BKMK_ToCreateaNewUserAccount"></a> To create a new user account with an online account assigned to it  
  
1.  On the Dashboard, click **Users**.  
  
2.  In **Users Tasks**, click **Add a user account**. The Add a User Account Wizard appears.  
  
3.  Follow the instructions to create the user account.  
  
4.  On the **Assign a Microsoft Online Services account** page, either create a new online account for the user or assign an existing online account:  
  
    -   To create a new online account, click **Create a new Microsoft Online Services account and assign it to this user account**, and type a name for the Microsoft Online Services account (by default, the user name is used for the online ID). Then click **Next**.  
  
    -   To assign an existing Microsoft online account, click **Assign an existing Microsoft Online Services account to this user account**, and select an existing account from the drop-down list. Then click **Next**.  
  
    > [!NOTE]
    >  In  Windows Server Essentials, Microsoft Online Services accounts are referred to as Office 365 accounts in wizards and Dashboard labels.  
  
5.  Follow the instructions to complete the wizard.  
  
6.  Notify the user that they will need to change their user account password before they can sign in to Office 365 with their new online account. For instructions, see [To begin using a new Microsoft online account](#BKMK_ToBeginUsingAnOnlineAccount).  
  
#### <a name="BKMK_ToAssignAnOnlineAccount"></a>To assign an online account to a user account  
  
1.  On the Dashboard, click **Users**.  
  
2.  Right-click the user account in the list, and then click **Assign a Microsoft online account**. The Assign a Microsoft Online Services Account Wizard appears.  
  
3.  Assign an existing online account or create a new one for the user. The default online ID for a new account is the user name. Then click **Next** to add the online account to the user account.  
  
4.  Review the information on the last page of the wizard, and then click **Close**.  
  
5.  Notify the user that they will need to change their user account password before they can sign in to Office 365 with their new online account. For instructions, see [To begin using a new Microsoft online account](#BKMK_ToBeginUsingAnOnlineAccount).  
  
##  <a name="BKMK_SECTION_ManageOnlineAccounts"></a> Manage online accounts  
 When you add an online account to a user account in Windows Server Essentials, you can manage both accounts together throughout the account s lifecycle.  
  
###  <a name="BKMK_UnderstandingAccountStatus"></a> Understanding the online account status  
 When you assign a Microsoft Online Services account to a user account, the email address for the account appears in the **Microsoft online account** column on the **Users** page of the Dashboard. (In  Windows Server Essentials, the column label is **Office 365 account**.)  
  
-   A blue icon next to an email address indicates the online account is active. That is, the account has a current  Office 365 license, and the user can use the online ID to sign in to  Office 365.  
  
-   A shaded icon next to the email address indicates the online account is inactive  œ either because the license is no longer active or the online account has been unassigned. When you unassign a user s online account, the license is removed, and the user is blocked from signing in to  Office 365 using the account. However, the server maintains the mapping between the user account name and the  Office 365 email address.  
  
###  <a name="BKMK_UnassignOnlineAccount"></a> Restrict access to an online account  
 What do you do if a user leaves your organization, or you want to restrict the user s access to your  Office 365 services? If you  managing your users  online accounts along with their user accounts in  Windows Server Essentials, you have three options:  
  
-   **Unassign the online account** ?If you want to keep a user from using  Office 365 without preventing access to resources on the server, you should unassign the online account. The  Office 365 license will be released, and the user is blocked from signing in to  Office 365. However, the server maintains the mapping between the user account name and the  Office 365 email address. For instructions, see [To unassign an online account from a user account](#BKMK_ToUnassignAnOnlineAccount).  
  
-   **Deactivate the user account** ?If you deactivate a user account because an employee leaves, either temporarily or permanently, the user s online account also is deactivated. The online account cannot be used, but the user data, including email, is retained in Microsoft Online Services. For instructions, see [Deactivate a user account](Manage-User-Accounts-in-Windows-Server-Essentials.md#BKMK_Manage6) in [Manage User Accounts](Manage-User-Accounts-in-Windows-Server-Essentials.md).  
  
-   **Remove the user account** ?If you remove a user account, the online account is removed from Microsoft Online Services also. For instructions, see [Remove a user account](Manage-User-Accounts-in-Windows-Server-Essentials.md#BKMK_Remove) in [Manage User Accounts](Manage-User-Accounts-in-Windows-Server-Essentials.md).  
  
    > [!WARNING]
    >  Be aware that when an online account is removed, the user data is subject to the data retention policies of Microsoft Online Services. If you need to retain the person s user data after an employee leaves, deactivate the user account instead of removing it.  
  
####  <a name="BKMK_ToUnassignAnOnlineAccount"></a> To unassign an online account from a user account  
  
1.  On the Dashboard, click **Users**.  
  
2.  Right-click the user account in the list, and then click **Unassign a Microsoft online account** (in  Windows Server Essentials, click **Unassign an Office 365 account**).  
  
3.  At the confirmation prompt, click **Yes**.  
  
##  <a name="BKMK_SECTION_ManageEmailAddresses"></a> Manage email addresses for Exchange Online  
 By adding email addresses to the user s online account in  Windows Server Essentials, you can allow the user to receive email at multiple email addresses in Exchange Online.  
  
###  <a name="BKMK_PROC_AddEmailAliases"></a> To add additional email addresses to a user s Microsoft online account  
  
1.  On the  Windows Server Essentials Dashboard, click **Users**.  
  
2.  Right-click the user account in the list, and then click **View the account properties**.  
  
3.  On the **Microsoft online** tab of the account properties (or the **Office 365** tab in  Windows Server Essentials), click **Add**.  
  
4.  Type the new email alias, and then select the email domain.  
  
5.  Click **OK** twice.  
  
##  <a name="BKMK_SECTION_ManageDistributionGroups"></a> Manage distribution groups for Exchange Online (Windows Server Essentials only)  
 After you integrate your  Windows Server Essentials server with  Office 365, you can create and manage distribution groups for Exchange Online from the  Windows Server Essentials Dashboard. You ll do this on the **Distribution Groups** tab that is added to the **Users** page. You will only see this tab if you have an Exchange Online subscription. This feature is not available in  Windows Server Essentials.  
  
 Use the following procedures to:  
  
-   [Add a distribution group](#BKMK_PROCEDURE_AddDistGroup)  
  
-   [Change the members of a distribution group](#BKMK_ChangeGroupMembers)  
  
-   [Change a user s distribution group memberships](#BKMK_EditUserMemberships)  
  
-   [Remove a distribution group](#BKMK_RemoveDistributionGroup)  
  
###  <a name="BKMK_PROCEDURE_AddDistGroup"></a> To add a distribution group  
  
1.  On the Dashboard in  Windows Server Essentials, click **Users**, and then click the **Distribution Groups** tab.  
  
2.  In **Distribution Group Tasks**, click **Add a distribution group**.  
  
     The Add a New Distribution Group Wizard appears.  
  
3.  On the **Add a new distribution group** page, enter the following information and then click **Next**:  
  
    -   Enter a group name, optional description, and email alias for the new distribution group.  
  
    -   By default, the distribution group can receive email from people outside your organization. If you do not want to allow this, clear that option.  
  
4.  On the **Add group members** page, use the **Add** button to add active user accounts that have an online account assigned to them, and other distribution groups, to the new distribution group. Then click **Next**.  
  
     The new distribution group is created in Exchange Online.  
  
###  <a name="BKMK_ChangeGroupMembers"></a> To change the members of a distribution group  
  
1.  On the Dashboard, click **Users**, and then click the **Distribution Groups** tab.  
  
2.  Right-click the distribution group in the list, and then click **Change group membership**.  
  
3.  Use the **Add** and **Remove** buttons to add or remove active online accounts from the distribution group. Then click **Next** to update the distribution group membership in Exchange Online.  
  
###  <a name="BKMK_EditUserMemberships"></a> To change a user s distribution group memberships  
  
1.  On the Dashboard, click **Users**.  
  
2.  Right-click the user account in the list, and then click **View the account properties**.  
  
3.  In the user account properties, click the **Distribution Groups** tab, and then click **Edit**.  
  
4.  In the **Edit Group Membership** box, use the **Add** and **Remove** buttons to add or remove distribution groups from the user account, and then click **Close**.  
  
5.  Click **OK** to save the updated user account properties.  
  
###  <a name="BKMK_RemoveDistributionGroup"></a> To remove a distribution group  
  
1.  On the Dashboard, click **Users**, and then click the **Distribution Groups** tab.  
  
2.  Right-click the distribution group in the list, and then click **Remove the group**.  
  
3.  At the confirmation prompt, click **Delete group**.  
  
     The distribution group is removed from Exchange Online.  
  
## See also  
  
-   [Manage User Accounts](Manage-User-Accounts-in-Windows-Server-Essentials.md)  
  
-   [Manage Office 365](Manage-Office-365-in-Windows-Server-Essentials.md)  
  
-   [Manage Microsoft Online Services](Manage-Microsoft-Online-Services-in-Windows-Server-Essentials.md)
