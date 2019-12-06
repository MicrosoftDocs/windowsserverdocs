---
ms.assetid: 5fd4063d-34dc-4b15-9a88-cc6c1fff455a
title: Walkthrough Guide - Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Walkthrough Guide: Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications




## About This Guide
This walkthrough provides instructions for configuring multifactor authentication (MFA) in Active Directory Federation Services (AD FS) in Windows Server 2012 R2 based on the user's group membership data.

For more information about MFA and authentication mechanisms in AD FS, see [Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](../../ad-fs/operations/Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md).

This walkthrough consists of the following sections:

-   [Step 1: Setting up the lab environment](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Conditional-Access-Control.md#BKMK_1)

-   [Step 2: Verify the default AD FS authentication mechanism](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md#BKMK_2)

-   [Step 3: Configure MFA on your federation server](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md#BKMK_3)

-   [Step 4: Verify MFA mechanism](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md#BKMK_4)

## <a name="BKMK_1"></a>Step 1: Setting up the lab environment
In order to complete this walkthrough, you need an environment that consists of the following components:

-   An Active Directory domain with a test user and group accounts, running on Windows Server 2012 R2 or an Active Directory domain running on Windows Server 2008, Windows Server 2008 R2, or Windows Server 2012 with its schema upgraded to Windows Server 2012 R2

-   A federation server running on Windows Server 2012 R2

-   A web server that hosts your sample application

-   A client computer from which you can access the sample application

> [!WARNING]
> It is highly recommended (both in a production and test environments) that you do not use the same computer to be your federation server and your web server.

In this environment, the federation server issues the claims that are required so that users can access the sample application. The Web server hosts a sample application that will trust the users who present the claims that the federation server issues.

For instructions on how to set up this environment, see [Set up the lab environment for AD FS in Windows Server 2012 R2](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md).

## <a name="BKMK_2"></a>Step 2: Verify the default AD FS authentication mechanism
In this step you will verify the default AD FS access control mechanism (**Forms Authentication** for extranet and **Windows Authentication** for intranet), where the user is redirected to the AD FS sign-in page, provides valid credentials, and is granted access to the application. You can use the **Robert Hatley** AD account and the **claimapp** sample application that you configured in [Set up the lab environment for AD FS in Windows Server 2012 R2](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md).

1.  On your client computer, open a browser window, and navigate to your sample application: **https://webserv1.contoso.com/claimapp**.

    This action automatically redirects the request to the federation server and you are prompted to sign in with a username and password.

2.  Type in the credentials of the **Robert Hatley** AD account that you created in [Set up the lab environment for AD FS in Windows Server 2012 R2](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md).

    You will be granted access to the application.

## <a name="BKMK_3"></a>Step 3: Configure MFA on your federation server
There are two parts to configuring MFA in AD FS in Windows Server 2012 R2:

-   [Select an additional authentication method](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md#BKMK_5)

-   [Set up MFA policy](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md#BKMK_6)

### <a name="BKMK_5"></a>Select an additional authentication method
In order to set up MFA, you must select an additional authentication method. In this walkthrough, for additional authentication method, you can choose between the following options:

-   Select [Certificate authentication](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md#BKMK_7) method that is available in AD FS in Windows Server 2012 R2 by default

-   Configure and select [Windows Azure Multi-Factor Authentication](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md#BKMK_8)

#### <a name="BKMK_7"></a>Certificate authentication
Complete either of the following procedures to select Certificate authentication as the additional authentication method:

###### To configure Certificate authentication as an additional authentication method via the AD FS Management Console

1.  On your federation server, in the AD FS Management Console, navigate to the **Authentication Policies** node, and under **Multi-factor Authentication** section, click the **Edit** link next to the **Global Settings** sub-section.

2.  In the **Edit Global Authentication Policy** window, select **Certificate Authentication** as an additional authentication method, and then click **OK**.

###### To configure Certificate authentication as an additional authentication method via Windows PowerShell

1.  On your federation server, open the Windows PowerShell command window and run the following command:

    ```
    Set-AdfsGlobalAuthenticationPolicy -AdditionalAuthenticationProvider CertificateAuthentication

    ```

    > [!WARNING]
    > To verify that this command ran successfully, you can run the `Get-AdfsGlobalAuthenticationPolicy` command.

#### <a name="BKMK_8"></a>Windows Azure Multi-Factor Authentication
Complete the following procedures in order to download and configure and select **Windows Azure Multi-Factor Authentication** as additional authentication on your federation server:

1.  [Create a Multi-Factor Authentication Provider via the Windows Azure Portal](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md#BKMK_a)

2.  [Download the Windows Azure Multi-Factor Authentication Server](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md#BKMK_b)

3.  [Install the Windows Azure Multi-Factor Authentication Server on your Federation Server](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md#BKMK_c)

4.  [Configure Windows Azure Multi-Factor Authentication as an additional authentication method](../../ad-fs/operations/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md#BKMK_d)

##### <a name="BKMK_a"></a>Create a Multi-Factor Authentication Provider via the Windows Azure Portal

1.  Log on to the Windows Azure Portal as an Administrator.

2.  On the left, select Active Directory.

3.  On the Active Directory page, at the top, select **Multi-Factor Auth Providers**.  Then at the bottom, click **New**.

4.  Under **App Services->Active Directory**, select **Multi-Factor Auth Provider**, and select **Quick Create**.

5.  Under **App Services**, select **Active Auth Providers**, and select **Quick Create**.

6.  Fill in the following fields and select **Create**.

    1.  **Name** - The name of the Multi-Factor Auth Provider.

    2.  **Usage Model** - The usage model of the Multi-Factor Authentication Provider.

        -   **Per Authentication** - purchasing model that charges per authentication. Typically used for scenarios that use Windows Azure Multi-Factor Authentication in a consumer-facing application.

        -   **Per Enabled User** - purchasing model that charges per enabled user.  Typically used for employee-facing scenarios such as Office 365.

        For additional information on usage models, see [Windows Azure pricing details](http://www.windowsazure.com/pricing/details/active-directory/).

    3.  **Directory** - The Windows Azure Active Directory tenant that the Multi-Factor Authentication Provider is associated with. This is optional as the provider does not have to be linked to Windows Azure Active Directory when securing on-premises applications.

7.  Once you click create, the Multi-Factor Authentication Provider will be created and you should see a message stating:  Successfully created Multi-Factor Authentication Provider.  Click **Ok**.

Next, you must download the Windows Azure Multi-Factor Authentication Server. You can do this by launching the Windows Azure Multi-Factor Authentication Portal through the Windows Azure portal.

##### <a name="BKMK_b"></a>Download the Windows Azure Multi-Factor Authentication Server

1.  Log on to the Windows Azure Portal as an Administrator, and click on the Multi-Factor Authentication Provider you created in the procedure above. Then click the **Manage** button.

    This launches the **Windows Azure Multi-Factor Authentication** portal.

2.  In the **Windows Azure Multi-Factor Authentication** portal, click **Downloads**, and then click **Download** to download a copy of the Windows Azure Multi-Factor Authentication Server.

Once you have downloaded the executable for the Windows Azure Multi-Factor Authentication Server, you must install it on your federation server.

##### <a name="BKMK_c"></a>Install the Windows Azure Multi-Factor Authentication Server on your Federation Server

1.  Download and double-click on the executable for the Windows Azure Multi-Factor Authentication Server.  This will begin the installation.

2.  On the License Agreement screen, read the agreement, select **I Agree** and click **Next**.

3.  Ensure that the destination folder is correct and click **Next**.

4.  Once the installation complete, click **Finish**.

You are now ready to launch the Windows Azure Multi-Factor Authentication server that you installed on your federation server and configure it as an additional authentication method.

##### <a name="BKMK_d"></a>Configure Windows Azure Multi-Factor Authentication as an additional authentication method

1.  Launch **Windows Azure Multi-Factor Authentication** from where you installed it on your federation server, and on the Welcome page, check the **Skip using the Authentication Configuration Wizard** checkbox and click **Next**.

2.  To activate the Multi-Factor Authentication Server, go back to the page in the Multi-Factor Authentication management portal where you downloaded the Multi-Factor Authentication Server and click the **Generate Activation Credentials** button. In the Multi-Factor Authentication Server user interface, enter the credentials that were generated and click **Activate**.

3.  Next, the **Multi-Factor Authentication Server** user interface prompts you to run the **Multi-Server Configuration Wizard**.  Select **No**.

    > [!IMPORTANT]
    > You can skip completing the **Multi-Server Configuration Wizard** given the lab environment with only one federation server that is used to complete this walkthrough. However, if your environment contains several federation servers, you must install the Multi-Factor Authentication Server and complete the **Multi-Server Configuration Wizard** on each federation server in order to enable replication between the Multi-Factor servers running on your federation servers.

4.  In the **Multi-Factor Authentication Server** user interface, select the **Users** icon, click **Import from Active Directory**, select the **Robert Hatley** account to provision it in Windows Azure Multi-Factor Authentication, and then click **Import**.

5.  In the **Users** list, select the **Robert Hatley** account, click **Edit**, and in the **Edit User** window, provide a cell phone number of this account, make sure the **Enabled** checkbox is checked, and then click **Apply**.

6.  In the **Users** list, select the **Robert Hatley** account, and click **Test**. In the **Test User** window, provide the credentials for the **Robert Hatley** account. When the cell phone rings, press '#' to complete the account verification.

7.  In the **Multi-Factor Authentication Server** user interface, select the **AD FS** icon, make sure that **Allow user enrollment**, **Allow users to select method** (including **Phone call** and **Text message**), **Use security questions for fallback** and **Enable logging** checkboxes are checked, click **Install AD FS Adapter**, and complete the **Multi-Factor Authentication AD FS Adapter** installation wizard.

    > [!NOTE]
    > The **Multi-Factor Authentication AD FS Adapter** installation wizard creates a security group called **PhoneFactor Admins** in your Active Directory and then adds the AD FS service account of your federation service to this group.
    > 
    > It is recommended that you verify on your domain controller that the **PhoneFactor Admins** group is indeed created and that the AD FS service account is a member of this group.
    > 
    > If necessary, add the AD FS service account to the **PhoneFactor Admins** group on your domain controller manually.

    For additional details on installing the AD FS Adapter, click the Help link in the top right corner of the Multi-Factor Authentication Server.

8.  To register the adapter in your federation service, on your federation server, launch the Windows PowerShell command window, and run the following command: `\Program Files\Multi-Factor Authentication Server\Register-MultiFactorAuthenticationAdfsAdapter.ps1`. The adapter is now registered as **WindowsAzureMultiFactorAuthentication**.  You must restart your AD FS service for the registration to take effect.

9. To configure Windows Azure Multi-Factor Authentication as the additional authentication method, in the AD FS Management Console, navigate to the **Authentication Policies** node, and under **Multi-factor Authentication** section, click the **Edit** link next to the **Global Settings** sub-section. In the **Edit Global Authentication Policy** window, select **Multi-Factor Authentication** as an additional authentication method, and then click **OK**.

    > [!NOTE]
    > You can customize the name and description of the Windows Azure Multi-Factor Authentication method, as well as any configured third-party authentication method, as it appears in your AD FS UI, by running the **Set-AdfsAuthenticationProviderWebContent** cmdlet. For more information, see [https://technet.microsoft.com/library/dn479401.aspx](https://technet.microsoft.com/library/dn479401.aspx)

### <a name="BKMK_6"></a>Set up MFA policy
In order to enable MFA, you must set up the MFA policy on your federation server. For this walkthrough, per our MFA policy, **Robert Hatley** account is required to undergo MFA because he belongs to the **Finance** group that you set up in [Set up the lab environment for AD FS in Windows Server 2012 R2](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md).

You can set up the MFA policy either via the AD FS Management Console or using the Windows PowerShell.

##### To configure the MFA policy based on user's group membership data for 'claimapp'  via the AD FS Management Console

1.  On your federation server, in the AD FS Management Console, navigate to **Authentication Policies**\\**Per Relying Party Trust** node, and select the relying party trust that represents your sample application (**claimapp**).

2.  Either in the **Actions** page or by right-clicking **claimapp**, select **Edit Custom Multi-factor Authentication**.

3.  In the **Edit Relying Party Trust for claimapp** window, click the **Add** button next to the **Users/Groups** list. Type in **Finance** for the name of your AD group that you created in [Set up the lab environment for AD FS in Windows Server 2012 R2](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md), and click **Check Names**, and when the name is resolved, click **OK**.

4.  Click **OK** in the **Edit Relying Party Trust for claimapp** window.

##### To configure the MFA policy based on user's group membership data for 'claimapp'  via Windows PowerShell

1.  On your federation server, open the Windows PowerShell command window and run the following command:

    ```
    $rp = Get-AdfsRelyingPartyTrust -Name claimapp
    ```

2.  In the same Windows PowerShell command window, run the following command:

    ```
    $GroupMfaClaimTriggerRule = 'c:[Type == "https://schemas.microsoft.com/ws/2008/06/identity/claims/groupsid", Value =~ "^(?i) <group_SID>$"] => issue(Type = "https://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod", Value = "https://schemas.microsoft.com/claims/multipleauthn");'
    Set-AdfsRelyingPartyTrust -TargetRelyingParty $rp -AdditionalAuthenticationRules $GroupMfaClaimTriggerRule

    ```

    > [!NOTE]
    > Make sure to replace <group_SID> with the value of the SID of your AD group **Finance**.

## <a name="BKMK_4"></a>Step 4: Verify MFA mechanism
In this step you will verify the MFA functionality that you set up in the previous step. You can use the following procedure to verify that **Robert Hatley** AD user can access your sample application and this time is required to undergo MFA because he belongs to the **Finance** group.

1.  On your client computer, open a browser window, and navigate to your sample application: **https://webserv1.contoso.com/claimapp**.

    This action automatically redirects the request to the federation server and you are prompted to sign in with a username and password.

2.  Type in the credentials of the **Robert Hatley** AD account.

    At this point, because of the MFA policy that you configured, the user will be prompted to undergo additional authentication. The default message text is **For security reasons, we require additional information to verify your account.** However, this text is fully customizable. For more information about how to customize the sign-in experience, see [Customizing the AD FS Sign-in Pages](https://technet.microsoft.com/library/dn280950.aspx).

    If you configured Certificate authentication as the additional authentication method, the default message text is **Select a certificate that you want to use for authentication. If you cancel the operation, please close your browser and try again.**

    If you configured Windows Azure Multi-Factor Authentication as the additional authentication method, the default message text is **A call will be placed to your phone to complete your authentication.** For more information about signing in with Windows Azure Multi-Factor Authentication and using various options for the preferred method of verification, see [Windows Azure Multi-Factor Authentication Overview](https://technet.microsoft.com/library/dn249479.aspx).

## See Also
[Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](../../ad-fs/operations/Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md)
[Set up the lab environment for AD FS in Windows Server 2012 R2](../../ad-fs/deployment/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md)



