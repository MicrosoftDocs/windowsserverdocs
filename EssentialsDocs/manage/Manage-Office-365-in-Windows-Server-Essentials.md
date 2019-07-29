---
title: "Manage Office 365 in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3f8485e4-e10f-4f38-8a5e-d5227abd0d84
0author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Manage Office 365 in Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

When you integrate your  Windows Server Essentials server with Microsoft  Office 365, you can manage your  Office 365 services and online accounts along with your on-premises resources from the  Windows Server Essentials Dashboard. In this topic, you'll find out what you can gain by integrating your server with  Office 365, how to do it, and how to manage and troubleshoot your  Office 365 integration.  
  
  
  
> [!IMPORTANT]
>   Office 365 integration is only supported in a single domain controller environment. In addition, the  Office 365 integration wizard must run on a domain controller.  
  
## In this topic  
  
-   [Why should I integrate Office 365 with my server?](#BKMK_IntegrationOverview)  
  
-   [Set up Office 365 integration](Manage-Office-365-in-Windows-Server-Essentials.md#BKMK_Configure)  
  
-   [Manage Office 365 integration](#BKMK_ManageIntegration)  
  
-   [Troubleshoot Office 365 integration](Manage-Office-365-in-Windows-Server-Essentials.md#BKMK_Troubleshoot)  
  
##  <a name="BKMK_IntegrationOverview"></a> Why should I integrate Office 365 with my server?  
 There are a lot of good reasons to integrate  Office 365 with your  Windows Server Essentials server. If you manage some of your resources in-house but use  Office 365 for other services, you'll be able to manage your  Office 365 services and resources from the Dashboard, along with your on-premises resources, instead of working in two places.  
  
- Manage the online accounts that give your users access to  Office 365 along with your user accounts:  
  
  -   Create Microsoft Online Services accounts for your users in a single step, or create user accounts on the server for your existing online accounts. You can also add an online account to a new or existing user account.  
  
       When you create the online accounts from the Dashboard, users sign in to  Office 365 with the same password they use on the server. If they change the password for their user account, the online password changes also. And you know that their online account passwords always meet the security requirements you set for your user accounts.  
  
  -   Manage an online account along with the user account throughout the lifecycle of the user account. If you deactivate a user account, the online account is deactivated also. If you remove a user account, the online account also is removed.  
  
  -   On a  Windows Server Essentials server, manage Exchange Online distribution groups for email also.  
  
- Send and receive email from your organization's Internet domain (for example, contoso.com) by linking a custom Internet domain to your  Office 365 subscription.  
  
- Manage your subscription and  Office 365 integration from the Dashboard.  
  
- If your subscription includes  SharePoint Online libraries,  Office 365 integration with a  Windows Server Essentials server lets you:  
  
  - Create and manage your  SharePoint Online libraries from the Dashboard.  
  
    > [!NOTE]
    >  You'll also be able to use the My Server 2012 R2 app to work with documents in your  SharePoint Online libraries from your laptop, mobile device, or Windows phone. This feature is only available for  Windows Server Essentials. For more information, see [Use the My Server App](../use/Use-the-My-Server-App-to-Connect-to-Windows-Server-Essentials.md).  
  
  - Change permissions for a  SharePoint Online team site from the Dashboard, or open the team site from the Dashboard to make other changes.  
  
    For more information, see [Manage SharePoint Online](Manage-SharePoint-Online-in-Windows-Server-Essentials.md).  
  
- If you subscribe to Exchange Online,  Office 365 integration with a  Windows Server Essentials server lets you manage the mobile devices that your users use to connect to your company email server:  
  
  -   Require password protection when mobile devices connect to the company email server. Set a minimum password length, the number of failed sign-in attempts to allow, and the minimum time required between sign-in attempts.  
  
  -   Block a mobile device from connecting to Exchange Online if you know of security issues with the device model.  
  
  -   If a mobile device is lost or stolen, wipe the device to delete any sensitive company data the next time the device is turned on.  
  
- Office 365 integration gives you new ways to connect to  Office 365 services and resources:  
  
  -   Open  Office 365 services from the  Windows Server Essentials Launchpad. For information, see [Quick Start Guide to Using Microsoft Office 365](../use/Quick-Start-Guide-to-Using-Microsoft-Office-365-with-Windows-Server-Essentials.md).  
  
  -   Use the My Server 2012 R2 app to work with documents in your  SharePoint Online libraries from your laptop, mobile device, or Windows phone. For information, see [Use the My Server App](../use/Use-the-My-Server-App-to-Connect-to-Windows-Server-Essentials.md). This feature is only available in  Windows Server Essentials.  
  
##  <a name="BKMK_Configure"></a> Set up Office 365 integration  
 You can integrate your server with  Office 365 at any time after you complete the server installation. If you don't already have an  Office 365 subscription, you can purchase one or sign up for a free trial subscription.  
  
 You will do the following tasks:  
  
-   [Step 1: Verify Office 365 integration requirements](#BKMK_StepOne_VERIFY)  
  
-   [Step 2: Integrate the server with Microsoft Office 365](#BKMK_StepTwo)  
  
-   [Step 3: Link your organization's Internet domain name to Office 365 (optional)](#BKMK_StepThree)  
  
###  <a name="BKMK_StepOne_VERIFY"></a> Step 1: Verify Office 365 integration requirements  
 Before you start, make sure the server meets these requirements:  
  
-   The server can have any of these operating systems:  Windows Server Essentials,  Windows Server Essentials, or the  Windows Server 2012 R2 Standard or  Windows Server 2012 R2 Datacenter operating system with the Windows Server Essentials Experience role installed.  
  
-   The environment can only have one domain controller, and you must perform  Office 365 integration on the domain controller.  
  
-   You must be able to connect to the Internet from the server.  
  
-   You should install all critical and important updates on the server before you start  Office 365 integration.  
  
-   If you want to use your organization's Internet domain in email addresses and with your  SharePoint Online resources, you'll need to register the domain name so you can link the domain to  Office 365 during integration. For more information, see [How to buy a domain name](https://office.microsoft.com/office365-suite-help/how-to-buy-a-domain-name-HA102819883.aspx?CTT=5&origin=HA102818660).  
  
> [!NOTE]
>  You don't need to subscribe to  Office 365 in advance. You'll be able to buy a subscription or sign up for a free trial during  Office 365 integration. If you'd like to take a look at plans and pricing for  Office 365, [compare Office 365 plans for businesses](https://office.microsoft.com/compare-office-365-for-business-plans-FX102918419.aspx?CR_CC=200061904&WT.srch=1&WT.mc_ID=PS_bing_O365Comm_subscribe-to-office-365_Text).  
  
###  <a name="BKMK_StepTwo"></a> Step 2: Integrate the server with Microsoft Office 365  
 Perform the following procedure on the domain controller to integrate your  Windows Server Essentials server with  Office 365.  
  
> [!NOTE]
>  The procedure's the same whether you have  Windows Server Essentials or  Windows Server Essentials, but you'll start from a different place on the Home page. In  Windows Server Essentials, you integrate the server with  Office 365 and other Microsoft Online Services on the **Services** tab. In  Windows Server Essentials,  Office 365 integration is performed on the **Email** tab.  
  
##### To integrate the server with Office 365  
  
1. Sign in on the server as an administrator, and open the  Windows Server Essentials Dashboard.  
  
2. On the **Home** page, click **Services** (in  Windows Server Essentials, click **Email**), click **Integrate with Microsoft Office 365**, and then click **Set up Microsoft Office 365 Integration**.  
  
    The Integrate with Microsoft Office 365 Wizard appears.  
  
3. On the **Get Started** page, take one of following actions:  
  
   -   If you don't have a subscription to  Office 365, click **Next**, and follow the instructions to subscribe to  Office 365 or sign up for a trial subscription.  
  
        You'll need to sign in to  Office 365 before you return to the wizard. But you don't need to perform any of the tasks in the **Start here** section of the  Office 365 portal.  
  
   -   If you already have a subscription to  Office 365 that you want to integrate with the server, select **I already have a subscription for Office 365**, and then click **Next**.  
  
4. Follow the instructions to complete the wizard.  
  
   After the wizard completes successfully, you'll notice the following changes to the Dashboard:  
  
-   There's a new **Office 365** page, which is used to manage the integration and your  Office 365 subscription.  
  
-   On the **Users** page, you'll see an **Online accounts** tab where you can create and manage the Microsoft Online Services accounts that give your users access to  Office 365. If you're using Exchange Online and have a  Windows Server Essentials server, you'll also see a **Distribution Groups** tab.  
  
-   The **Storage** page on a  Windows Server Essentials server has a **SharePoint Libraries** tab for managing  SharePoint Online libraries and changing permissions for your team sites. Every business plan for  Office 365 includes these basic  SharePoint Online features.  
  
###  <a name="BKMK_StepThree"></a> Step 3: Link your organization's Internet domain name to Office 365 (optional)  
 If you want to use your own Internet domain in email addressed to your organization and the URLs for your  SharePoint Online resources, you can link a custom domain to your  Office 365 subscription. If you integrate your  Windows Server Essentials server with  Office 365, you can do this from the Dashboard.  
  
 It's easiest to do this before you create online accounts for your users so you can use the domain when you bulk-create the online accounts.  
  
 You get a domain name when you sign up for  Office 365 ?for example, *contoso*.onmicrosoft.com. If you'd rather use a different domain name ?say, simply contoso.com ?you can. You'll need to buy a domain name if you don't already own one, and change some of the DNS records.  
  
 Setting up a custom domain to use with  Office 365 involves four tasks:  
  
1. **Buy a domain name.** That is, register it with a domain registrar or DNS hosting provider.  
  
   -   Pick a domain name that works with  Office 365. You can use a 2nd-level domain name ?for example, buycontoso.com ?but not a 3rd-level domain name ?for example, marketing.contoso.com. For more information about choosing a domain to use in  Office 365, see [Domains](https://technet.microsoft.com/library/office-365-domains.aspx).  
  
   -   Buy it from a domain registrar that allows the domain name server (DNS) records required by  Office 365. To find out which domain registrars allow the required DNS records, see [How to buy a domain name](https://office.microsoft.com/office365-suite-help/how-to-buy-a-domain-name-HA102819883.aspx?CTT=5&origin=HA102818660). If you already registered your domain with a different registrar, don't worry; you can transfer the domain to a different registrar when you link the domain to  Office 365.  
  
2. **Configure DNS records that allow Office 365 services to use the domain name.** The easiest way is to let the wizard configure the DNS records for you when you link the domain to your  Office 365 subscription in step 3. If you'd rather do it yourself, see [How to manually configure DNS records for Office 365 integration](#BKMK_ManuallyConfigureDNS).  
  
3. **Link your custom Internet domain to your Office 365 subscription.** You'll use the **Link a domain to Office 365** action.  
  
4. **Verify that your Office 365 services are using the new domain name.**  
  
   If you complete steps 1 and 2 before you use the **Link a domain to Office 365** task, the wizard can link the domain name to  Office 365. Alternatively, you can have a wizard help you with some or all of steps 1 and 2.  
  
##### To link your organization's Internet domain to Office 365  
  
1.  On the Dashboard, open the **Office 365** page, and click **Link a domain to Office 365**.  
  
2.  Follow the instructions to complete the wizard.  
  
     The wizard can help you with some or all of the steps for registering, configuring, and linking a new or existing Internet domain name to use in  Office 365.  
  
     Click the help link on the wizard page to get the information you need to complete a task. Or see the Set up a domain name section of [Manage Remote Web Access in Windows Server Essentials](https://technet.microsoft.com/library/jj628152\(d=printer\).aspx) for a process overview and requirements.  
  
    > [!NOTE]
    >  To use the wizard to register a new domain name, you must use one of the domain name service providers that partnered with Microsoft to provide seamless integration with the wizard. To find a domain name registrar, see [How to buy a domain name](https://office.microsoft.com/office365-suite-help/how-to-buy-a-domain-name-HA102819883.aspx?CTT=5&origin=HA102818660).  
  
3.  If the wizard detects that your domain name isn't managed by the server, you'll need to manually configure the required DNS records to complete the configuration. For instructions, see [How to manually configure DNS records for Office 365 integration](#BKMK_ManuallyConfigureDNS), later in this topic.  
  
4.  Verify that the domain is being used in  Office 365.  
  
     There's a little wait after the wizard completes, while the domain name registrar verifies the DNS records. This happens automatically; you don't have to do anything. But it generally takes about an hour ?and sometimes a little longer. When domain verification is complete, the **Office 365** page will list your organization's domain.  
  
####  <a name="BKMK_ManuallyConfigureDNS"></a> How to manually configure DNS records for Office 365 integration  
 If the Link Your Domain to Office 365 Wizard detects that your domain name is not managed by the server, to complete the configuration, you must manually configure the required domain name server (DNS) records. In that case, you'll find a list of DNS records that you must configure at **%username%\NewDNSRecords_(n).txt**, where *(n)* is a random number.  
  
 The following table describes the DNS records that you must add. Entry methods can vary with different domain name registrars. If you have any questions, ask your domain name registrar for help.  
  
### Required DNS records for linking a custom Internet domain name to Office 365  
  
|Service|Required DNS Records|Purpose|  
|-------------|--------------------------|-------------|  
|(Multiple services)|MX| Office 365 uses this record to verify that you own a specific domain name. This MX record does not interfere with email message routing.|  
|Exchange Online|MX|Provides email message routing. **Important:**  If you are migrating email, do not assign a preference of zero (**0**) to the new MX record. Make sure the value for the record is greater than the value that is assigned to the current MX record. When the email migration is complete and you are ready to change the email server to  Office 365, have your domain name registrar reset the preference value of the new MX record.|  
|Exchange Online|Alias (CNAME)|Autodiscover record that is used to help users easily set up a connection between Exchange Online and their Outlook desktop client or a mobile email client. **Note:**  If you prefer to access Outlook Web Access by using your organization's own domain name (for example, http://mail.contoso.com) instead of the standard URL (https://outlook.com/owa/office365.com), you can configure the Alias (CName) record as follows: **Type=CNAME, TTL=01:00:00, HostName=mail, Address=mail.office365.com**|  
|Exchange Online|TXT|Specifies that outlook.com, the domain used by the  Office 365 email servers, is authorized to send email on behalf of your domain. Create this record to help prevent your outbound email from being flagged as spam.|  
|Lync Online|SRV|Helps enable federation with other instant messaging services such as Windows Live or Yahoo!.|  
|Lync Online|SRV|Autodiscover record that is used to help users easily set up a connection between the Lync desktop client and Microsoft Lync Online.|  
  
> [!IMPORTANT]
>  After domain verification is complete, do not attempt to add or make any further changes to the DNS records from the  Office 365 portal.  
  
###  <a name="BKMK_StepFour_ACCOUNTS"></a> Next step  
  
-   Create Microsoft Online Services accounts for your users.  
  
     To use  Office 365 services, your users must have a Microsoft Online Services account associated with their network user account. The Dashboard makes this easy. If you're using a new  Office 365 subscription, you can bulk-create online accounts for your existing user accounts. If you're integrating a new server with an  Office 365 subscription that you're already using, you can import user accounts from your existing online accounts. For procedures, see [Manage Online Accounts for Users](Manage-Online-Accounts-for-Users.md).  
  
> [!NOTE]
>  On the Dashboard in  Windows Server Essentials, Microsoft Online Services accounts are referred to as Office 365 accounts. The accounts are the same; only the terminology changed.  
  
##  <a name="BKMK_ManageIntegration"></a> Manage Office 365 integration  
 After you integrate your server with  Office 365, the **Office 365** page on the Dashboard displays information about your  Office 365 subscription and makes these tasks available:  
  
-   [Manage your Office 365 subscription](#BKMK_ManageO365) ?Change the administrator account that you use to manage the subscription. Open the  Office 365 Admin Dashboard to manage your subscription.  
  
-   [Link your organization's Internet domain to Office 365](#BKMK_StepThree) ?If you want to be able to send and receive email addressed to your own domain, you can link the domain to  Office 365. (Discussed earlier, in [Step 3: Link your organization's domain to Office 365](#BKMK_StepThree).)  
  
-   [Disable Office 365 integration](#BKMK_Disable) ?If you don't want to manage your  Office 365 services, subscription, and online accounts from the Dashboard, you can disable  Office 365 integration. The services are still available on the  Office 365 portal.  
  
###  <a name="BKMK_ManageO365"></a> Manage your Office 365 subscription  
 If you need to make changes to your  Office 365 subscription while you're working on the server, you can open the subscription in  Office 365 from the **Office 365** page of the Dashboard. You can also change the administrator account that the server uses to make changes to  Office 365 services.  
  
##### To open your subscription on the Office 365 Admin Dashboard  
  
1.  On the  Windows Server Essentials Dashboard, open the **Office 365** page.  
  
2.  In **Configuration tasks**, click **Manage Office 365**.  
  
3.  Sign in to  Office 365 with the Microsoft online account that you use to manage your subscription.  
  
     The  Office 365 Admin Dashboard opens.  
  
##### To change the Office 365 administrator account  
  
1.  On the Dashboard, click **Office 365**.  
  
2.  In **Configuration Tasks**, click **Change the Office 365 administrator account**. The Change Administrator Account Wizard appears. (In  Windows Server Essentials, the wizard is named Set Up the Office 365 Administrator Account.)  
  
3.  Type the credentials for the account that you want to use to connect to your  Office 365 subscription, and then click **Next**.  
  
4.  Click **Close**. The Dashboard restarts.  
  
###  <a name="BKMK_Disable"></a> Disable Office 365 integration  
 If you decide that you don't want to manage your  Office 365 services and online accounts from the Dashboard, you can disable  Office 365 integration. Your  Office 365 subscription remains active, and any configuration changes you made from the Dashboard stay in effect. For example, you'll receive email addressed to a domain name that you linked to your  Office 365 subscription. You won't lose any email, and controls that you set for mobile devices are still used Exchange Online.  
  
 Going forward, you will manage your  Office 365 subscription, services, and resources in  Office 365, and your users will need to manage the passwords for their online accounts in  Office 365. Password synchronization no longer happens, and disabling or removing a user account will have no effect on the user's online account.  
  
 Because the Office 365 Integration software is installed on the local server, you can disable the feature even if the Integration service cannot connect to  Office 365.  
  
##### To disable Office 365 integration with the server  
  
1.  On the Dashboard, click **Office 365**.  
  
2.  Click **Disable Office 365 Integration**. The Disable Office 365 Wizard appears.  
  
3.  Follow the instructions to complete the wizard.  
  
> [!NOTE]
>  To enable  Office 365 integration again, use the **Integrate with Office 365** task on the **Service** tab of the Dashboard's **Home** page. For instructions, see [Step 2: Integrate your Windows Server Essentials server with Microsoft Office 365](#BKMK_StepTwo), earlier in this topic.  
  
##  <a name="BKMK_Troubleshoot"></a> Troubleshoot Office 365 integration  
 This section provides information to help you troubleshoot common problems that you might encounter when using the  Office 365 integration features in  Windows Server Essentials.  
  
###  <a name="BKMK_AcctsNotCreated"></a> Some Microsoft Online Services accounts were not created  
 **Description**  
  
 An attempt to create one or more Microsoft Online Services accounts from the Dashboard wasn't successful.  
  
 **Solution**  
  
1.  Click the link on the wizard completion page to open a results file that contains detailed information about each account creation request that did not complete successfully. For example, a result might inform you that a Microsoft Online Services account already exists with the name of a requested account.  
  
2.  Take the recommended actions to resolve each error.  
  
3.  If this problem persists, restart the server and then try to create the online accounts again.  
  
###  <a name="BKMK_ProblemUninstalling"></a> There was a problem uninstalling Office 365 Integration  
 **Description**  
  
 An unknown error occurred when you tried to disable  Office 365 integration.  
  
 **Solution**  
  
1.  Make sure the computer is connected to the Internet, and then try again.  
  
2.  If the error happens again, restart the server and then try again.  
  
## See also  
  
-   [Services Integration Overview for Windows Server Essentials - Part 1](http://blogs.technet.com/b/sbs/archive/2013/11/04/services-integration-overview-for-windows-server-2012-r2-essentials-part-1.aspx)  
  
-   [Services Integration Overview for Windows Server Essentials - Part 2](http://blogs.technet.com/b/sbs/archive/2013/11/06/services-integration-overview-for-windows-server-2012-r2-essentials-part-2.aspx)  
  
-   [Quick Start Guide to Using Microsoft Office 365](../use/Quick-Start-Guide-to-Using-Microsoft-Office-365-with-Windows-Server-Essentials.md)  
  
-   [Manage Microsoft Online Services](../manage/Manage-Microsoft-Online-Services-in-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](../manage/Manage-Windows-Server-Essentials.md)
