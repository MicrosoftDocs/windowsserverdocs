---
title: Configuring user access control and permissions
description: Configuring user access control and permissions using Active Directory or Azure Active Directory (Project Honolulu)
ms.technology: manage
ms.topic: article
author: haley-rowland
ms.author: harowl
ms.date: 04/12/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Configure User Access Control and Permissions

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

> [!NOTE] 
> Access management only applies when you are running Windows Admin Center as a service on Windows Server.

[If you haven't already, familiarize yourself with the user access control options in Windows Admin Center by reading the high-level overview.](../understand/user-access-options.md) 

## Gateway access role definitions

There are two roles for access to the Windows Admin Center gateway service:

**Gateway users** can connect to the Windows Admin Center gateway service in order to manage servers through that gateway, but they cannot change access permissions nor the authentication mechanism used to authenticate to the gateway.

**Gateway administrators** can configure who gets access as well as how users will authenticate to the gateway. Only gateway administrators can view and configure the Access settings in Windows Admin Center. Local administrators on the gateway machine are always administrators of the Windows Admin Center gateway service.

> [!NOTE] 
> Access to the gateway does not imply access to managed servers visible by the gateway. To manage a target server, the connecting user must use credentials (either via their passed through Windows credential, or via credentials provided in the Windows Admin Center session using the "Manage as" action) that have administrative access to that target server.

## Choose the identity provider

By default, any user that navigates to the gateway URL has access to the Windows Admin Center service. Only local administrators on the gateway machine have administrator access to the Windows Admin Center service.

Gateway administrators can choose the idenity provider used for gateway access by going to Window Admin Center general settings (gear icon at the right-hand of the top navigation bar) to the "Access" tab. Windows Admin Center supports using either Active Directory/local groups or Azure Active Directory (Azure AD). By choosing Azure AD authentication for the gateway, you can leverage additional security features like conditional access and multi-factor authentication provided by Azure AD. 

## Active Directory or local machine groups

When you choose Active Directory or local machine groups as your identity provider for gateway access, you can manage gateway user and administrator access from within the Windows Admin Center interface.

Under the "Users" tab, you can control who can access Windows Admin Center as a gateway user. By default, and if no security groups are listed, any user that access the gateway URL has access. Once you add one or more security groups to the users list, access is restricted to the members of those groups.


### Smartcard authentication
You can enforce **smartcard authentication** by specifying an additional _required_ group for smartcard-based security groups. Once you have added a smartcard-based security group, a user will only have access to the Windows Admin Center service if they are a member of any security group AND a smartcard group included in the users list.

Under the "Administrators" tab, you can control who can access Windows Admin Center as a gateway administrator. The local administrators group on the machine will always have full administrator access and cannot be removed from the list. By adding security groups, you give members of those groups privileges to change Windows Admin Center gateway settings. The administrators list supports smartcard authentication in the same way as the users list: with the AND condition for a security group and a smartcard group.

## Azure Active Directory

If you choose Azure Active Directory (Azure AD) as your identity provider, you will manage user and administrator access from the Azure Portal, rather from within the Windows Admin Center UI.

[To set up Azure AD, you must first connect your gateway to Azure](azure-integration.md#connect-your-gateway-to-azure) (you only need to do this once for your Windows Admin Center gateway). This step creates an Azure AD application, from which you can manage gateway user and gateway administrator access.

By default, all members of the Azure AD tenant will have user access to the Windows Admin Center gateway service. Only local administrators on the gateway machine will have administrator access to the Windows Admin Center gateway.

If you want to give specific Azure AD users or groups gateway user or gateway administrator access to the Windows Admin Center service, you must do the following:

1.	Go to your SME Azure AD application in the Azure portal. 
    -	When you click **Change access control** and then select **Azure Active Directory** from the Windows Admin Center Access settings, you can use the hyperlink provided in the UI to access your Azure AD application in the Azure portal. This hyperlink is also available in the Access settings after you click save and have selected Azure AD as your access control identity provider.
    -	You can also find your application in the Azure portal by going to **Azure Active Directory** > **Enterprise applications** > **All applications** and searching **SME** (the Azure AD app will be named SME-<gateway>). If you don't get any search results, ensure **Show** is set to **all applications**, **application status** is set to **any** and click Apply, then try your search. Once you've found the application, go to **Users and groups**
2.	In the Properties tab, set **User assignment required** to Yes.
    Once you've done this, only members listed in the Users and groups tab will be able to access the Windows Admin Center gateway.
3.	In the Users and groups tab, select **Add user**. You must assign a gateway user or gateway administrator role for each user/group added.

Once you save the Azure AD access control in the "Change access control" pane, the gateway service will restart and you must refresh your browser. You can update user access for the SME Azure AD application in the Azure portal at any time. 

Users will now be prompted to login using their Azure Active Directory identity when they attempt to access the Windows Admin Center gateway URL. From the Azure tab of Windows Admin Center general settings, users and administrators can view their currently logged in account and as well as sign-out of this Azure AD account.

### Conditional access and multi-factor authentication

One of the benefits of using Azure Active Directory as your identity provider for controlling access to the Windows Admin Center gateway is that you can leverage Azure AD's powerful security features like conditional access and multi-factor authentication. 

[Learn more about configuring conditional access with Azure Active Directory.](https://docs.microsoft.com/azure/active-directory/active-directory-conditional-access-azure-portal-get-started)


## Configure for single sign-on

**Single sign-on when deployed as a Service on Windows Server**

If you have installed Windows Admin Center on Windows 10, single sign-on needs no additional configuration. 

However, if you have installed Windows Admin Center on Windows Server, you must have some form of Kerberos delegation enabled in your environment.  This delegation configures the gateway machine as trusted to delegate to the target node. 

To configure [Resource-based constrained delegation](http://windowsitpro.com/security/how-windows-server-2012-eases-pain-kerberos-constrained-delegation-part-1) in your environment, use the following PowerShell code (requires a Windows Server 2012 or higher Domain Controller):

     $gateway = "WindowsAdminCenterGW"
     $node = "ManagedNode"
     $gatewayObject = Get-ADComputer -Identity $gateway
     $nodeObject = Get-ADComputer -Identity $node
     Set-ADComputer -Identity $nodeObject -PrincipalsAllowedToDelegateToAccount $gatewayObject

In this example, the Windows Admin Center gateway is installed on server **WindowsAdminCenterGW**, and the target
node name is **ManagedNode**.

To remove this relationship, use the following command:

    Set-ADComputer -Identity $nodeObject -PrincipalsAllowedToDelegateToAccount $null