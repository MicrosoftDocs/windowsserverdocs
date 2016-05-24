---
title: Grant a Member the Right to Logon Locally
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: a45ce641-b31d-41a6-92f8-e4d605e0659c
author: Femila
---
# Grant a Member the Right to Logon Locally
  Domain controllers, by default, restrict the types of user accounts that have the ability to log on locally. By default, only members of the Account Operators, Administrators, Backup Operators, Print Operators, and Server Operators groups have the **Allowed logon locally** system right. If you want to grant a user account the ability to log on locally to a domain controller, you must either make that user a member of a group that already has the **Allowed logon locally** system right or grant the right to that user account.  
  
> [!NOTE]  
>  The phrases “log on interactively” and “log on to the console” are alternate expressions that refer to the ability to log on locally and to the **Allow Log on locally** right.  
  
 Regarding the following procedure, it is assumed that you already know how to create Active Directory user accounts and group accounts, as well as knowing how to add members to groups. For procedures to perform any of these tasks, see:  
  
-   [Create a New User Account](http://go.microsoft.com/fwlink/?LinkID=138269) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=138269\)  
  
-   [Create a New Group](http://go.microsoft.com/fwlink/?LinkID=133523) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=133523\)  
  
-   [Add a Member to a Group](http://go.microsoft.com/fwlink/?LinkID=133522) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=133522\)  
  
 Membership in the local **Administrators** on a domain controller in your domain, or equivalent, is the minimum required to grant user rights. [!INCLUDE[gen_win7_review_details](../Token/gen_win7_review_details_md.md)]  
  
 Perform the following procedure using a domain controller or another domain member computer that has Remote Server Administration Tools \(RSAT\) installed. For more information about RSAT, see [Remote Server Administration Tools for AD DS](http://go.microsoft.com/fwlink/?LinkID=144909) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=144909\).  
  
### Grant a user or group the right to log on locally to the domain controllers in the domain  
  
1.  Click **Start**, type **gpmc.msc**, and then press ENTER.  
  
2.  Double\-click the name of the forest, double\-click **Domains**, double\-click the name of the domain in which you want to join a computer, right\-click **Default Domain Controllers Policy**, and then click **Edit**.  
  
3.  In the console tree, expand **Computer Configuration**, **Policies**, **Windows Settings**, **Security Settings**, and **Local Policies**, and then click **User Rights Assignment**.  
  
4.  In the details pane, double\-click **Allow Logon Locally**.  
  
5.  Ensure that the **Define these policy settings** check box is selected, and then click **Add User or Group**.  
  
6.  Type the name of the account that you want to allow to log on locally. As an alternative, click **Browse** to locate the account with the **Select Users, Computers, or Groups** dialog box, and then click **OK**.  
  
7.  After you have the account name entered, click **OK** in the **Add User or Group** dialog box, and then click **OK** in the **Allow log on locally Properties** dialog box.  
  
> [!IMPORTANT]  
>  The domain controllers in the domain share the Default Domain Controllers Group Policy object \(GPO\). When you grant an account the **Allow logon locally** right, you are allowing that account to log on locally to all domain controllers in the domain.  
  
  