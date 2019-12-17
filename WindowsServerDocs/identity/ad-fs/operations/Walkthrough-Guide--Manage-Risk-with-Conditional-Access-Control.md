---
ms.assetid: 3a840b63-78b7-4e62-af7b-497026bfdb93
title: Walkthrough Guide - Manage Risk with Conditional Access Control
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Walkthrough Guide: Manage Risk with Conditional Access Control




## About This Guide
This walkthrough provides instructions for managing risk with one of the factors (user data) available through the conditional access control mechanism in Active Directory Federation Services (AD FS) in Windows Server 2012 R2. For more information about conditional access control and authorization mechanisms in AD FS in Windows Server 2012 R2, see [Manage Risk with Conditional Access Control](../../ad-fs/operations/Manage-Risk-with-Conditional-Access-Control.md).

This walkthrough consists of the following sections:

-   [Step 1: Setting up the lab environment](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Conditional-Access-Control.md#BKMK_1)

-   [Step 2: Verify the default AD FS access control mechanism](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Conditional-Access-Control.md#BKMK_2)

-   [Step 3: Configure conditional access control policy based on user data](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Conditional-Access-Control.md#BKMK_3)

-   [Step 4: Verify conditional access control mechanism](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Conditional-Access-Control.md#BKMK_4)

## <a name="BKMK_1"></a>Step 1: Setting up the lab environment
In order to complete this walkthrough, you need an environment that consists of the following components:

-   An Active Directory domain with a test user and group accounts, running on Windows Server 2008, Windows Server 2008 R2, or Windows Server 2012 with its schema upgraded to Windows Server 2012 R2 or an Active Directory domain running on Windows Server 2012 R2

-   A federation server running on Windows Server 2012 R2

-   A web server that hosts your sample application

-   A client computer from which you can access the sample application

> [!WARNING]
> It is highly recommended (both in production or test environments) that you do not use the same computer to be your federation server and your web server.

In this environment, the federation server issues the claims that are required so that users can access the sample application. The Web server hosts a sample application that will trust the users who present the claims that the federation server issues.

For instructions on how to set up this environment, see [Set up the lab environment for AD FS in Windows Server 2012 R2](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md).

## <a name="BKMK_2"></a>Step 2: Verify the default AD FS access control mechanism
In this step you will verify the default AD FS access control mechanism, where the user is redirected to the AD FS sign-in page, provides valid credentials, and is granted access to the application. You can use the **Robert Hatley** AD account and the **claimapp** sample application that you configured in [Set up the lab environment for AD FS in Windows Server 2012 R2](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md).

#### To verify the default AD FS access control mechanism

1.  On your client computer, open a browser window, and navigate to your sample application: **https://webserv1.contoso.com/claimapp**.

    This action automatically redirects the request to the federation server and you are prompted to sign in with a username and password.

2.  Type in the credentials of the **Robert Hatley** AD account that you created in [Set up the lab environment for AD FS in Windows Server 2012 R2](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md).

    You will be granted access to the application.

## <a name="BKMK_3"></a>Step 3: Configure conditional access control policy based on user data
In this step you will set up an access control policy based on the user group membership data. In other words, you will configure an **Issuance Authorization Rule** on your federation server for a relying party trust that represents your sample application - **claimapp**. By this rule's logic, **Robert Hatley** AD user will be issued claims that are required to access this application because he belongs to a **Finance** group. You have added the **Robert Hatley** account to the **Finance** group in [Set up the lab environment for AD FS in Windows Server 2012 R2](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md).

You can complete this task using either AD FS Management Console or via Windows PowerShell.

#### To configure conditional access control policy based on user data via the AD FS Management Console

1.  In the AD FS Management Console, navigate to **Trust Relationships**, and then **Relying Party Trusts**.

2.  Select the relying party trust that represents your sample application (**claimapp**), and then either in the **Actions** pane or by right-clicking this relying party trust, select **Edit Claim Rules**.

3.  In the **Edit Claim Rules for claimapp** window, select **Issuance Authorization Rules** tab and click **Add Rule**.

4.  In the **Add Issuance Authorization Claim Rule Wizard**, on the **Select Rule Template page**, select **Permit or Deny Users Based on an Incoming Claim** claim rule template and then click **Next**.

5.  On the **Configure Rule** page, do all of the following and then click **Finish**:

    1.  Enter a name for the claim rule, for example **TestRule**.

    2.  Select **Group SID** as **Incoming claim type**.

    3.  Click **Browse**, type in **Finance** for the name of your AD test group, and resolve it for the **Incoming claim value** field.

    4.  Select the **Deny access to users with this incoming claim** option.

6.  In the **Edit Claim Rules for claimapp** window, make sure to delete the **Permit Access to All Users** rule that was created by default when you created this relying party trust.

#### To configure conditional access control policy based on user data via Windows PowerShell

1.  On your federation server, open the Windows PowerShell command window and run the following command:


~~~
`$rp = Get-AdfsRelyingPartyTrust -Name claimapp`
~~~


2. In the same Windows PowerShell command window, run the following command:


~~~
`$GroupAuthzRule = '@RuleTemplate = "Authorization" @RuleName = "Foo" c:[Type == "https://schemas.microsoft.com/ws/2008/06/identity/claims/groupsid", Value =~ "^(?i)<group_SID>$"] =>issue(Type = "https://schemas.microsoft.com/authorization/claims/deny", Value = "DenyUsersWithClaim");'
Set-AdfsRelyingPartyTrust -TargetRelyingParty $rp -IssuanceAuthorizationRules $GroupAuthzRule`
~~~

> [!NOTE]
> Make sure to replace <group_SID> with the value of the SID of your AD **Finance** group.

## <a name="BKMK_4"></a>Step 4: Verify conditional access control mechanism
In this step you will verify the conditional access control policy that you set up in the previous step. You can use the following procedure to verify that **Robert Hatley** AD user can access your sample application because he belongs to the **Finance** group and AD users who do not belong to the **Finance** group cannot access the sample application.

1.  On your client computer, open a browser window, and navigate to your sample application: **https://webserv1.contoso.com/claimapp**

    This action automatically redirects the request to the federation server and you are prompted to sign in with a username and password.

2.  Type in the credentials of the **Robert Hatley** AD account that you created in [Set up the lab environment for AD FS in Windows Server 2012 R2](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md).

    You will be granted access to the application.

3.  Type in the credentials of another AD user that does NOT belong to the **Finance** group. (For more information on how to create user accounts in AD, see [https://technet.microsoft.com/library/cc7833232.aspx](https://technet.microsoft.com/library/cc783323%28v=ws.10%29.aspx).

    At this point, because of the access control policy that you set up in the previous step, an 'access denied' message is displayed for this AD user that does NOT belong to the **Finance** group. The default message text is **You are not authorized to access this site. Click here to sign out and sign in again or contact your administrator for permissions.** However, this text is fully customizable. For more information about how to customize the sign-in experience, see [Customizing the AD FS Sign-in Pages](https://technet.microsoft.com/library/dn280950.aspx).

## See Also
[Manage Risk with Conditional Access Control](../../ad-fs/operations/Manage-Risk-with-Conditional-Access-Control.md)
[Set up the lab environment for AD FS in Windows Server 2012 R2](../deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md)



