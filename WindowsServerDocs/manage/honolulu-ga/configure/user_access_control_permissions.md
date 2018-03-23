---
author: nwashburn-ms
---

<a href="../overview.md">Honolulu</a> > <a href="../overview.md">Configure</a> > Honolulu User Access Control and Permissions

# Configure Honolulu User Access Control and Permissions

[Content goes here]

[TODO:legacy-content-begin]

## Gateway Access Management

> [!NOTE] 
> Access management only applies when you are running Honolulu as a service on Windows Server.

**Gateway users** can connect to the Honolulu gateway service in order to manage servers through that gateway, but they cannot change access permissions nor the authentication mechanism used to authenticate to the gateway.

**Gateway administrators** can configure who gets access as well as how users will authenticate to the gateway. Only gateway administrators can view and configure the Access settings in Honolulu. Local administrators on the gateway machine are always administrators of the Honolulu gateway service.

> [!NOTE] 
> Access to the gateway does not imply access to managed servers visible by the gateway. To manage a target server, the connecting user must use credentials (either via their passed through Windows credential, or via credentials provided in the Honolulu session using the "Manage as" action) that are local administrators or part of the administrators group of that target server.

By default, any user that navigates to the gateway URL has access to the Honolulu service. Only local administrators on the gateway machine have administrator access to the Honolulu service.

Under the "Access" tab in Project Honolulu general settings, administrators can configure gateway access using Active Directory/local groups OR Azure Active Directory (AAD). By choosing AAD authentication for the gateway, you can leverage additional security features like conditional access and multi-factor authentication provided by AAD. 

### Active Directory or local machine groups

When you choose Active Directory or local machine groups as your identity provider for gateway access, you can manage gateway user and administrator access from within the Honolulu interface.

Under the "Users" tab, you can control who can access Honolulu as a gateway user. By default, and if no security groups are listed, any user that access the gateway URL has access. Once you add one or more security groups to the users list, access is restricted to the members of those groups.

You can enforce **smartcard authentication** by specifying an additional _required_ group for smartcard-based security groups. Once you have added a smartcard-based security group, a user will only have access to the Honolulu service if they are a member of any security group AND a smartcard group included in the users list.

Under the "Administrators" tab, you can control who can access Honolulu as a gateway administrator. The local administrators group on the machine will always have full administrator access and cannot be removed from the list. By adding security groups, you give members of those groups privileges to change Honolulu gateway settings. The administrators list supports smartcard authentication in the same way as the users list: with the AND condition for a security group and a smartcard group.

### Azure Active Directory

> [!NOTE]
> AAD authentication is supported in Project Honolulu version 1803, which is only available to Windows Insiders. To get access to this feature, [join the Windows Insider Program](https://insider.windows.com/for-business-getting-started-server/) and download Honolulu from [Windows Server Insider Preview](https://www.microsoft.com/software-download/windowsinsiderpreviewserver).

If you choose Azure Active Directory (AAD) as your identity provider, you will manage user and administrator access from the Azure Portal, rather from within the Honolulu UI.

To set up AAD, you must first [connect your gateway to Azure](#connect-your-gateway-to-azure) (you only need to do this once for your Honolulu gateway). This step creates an AAD application, from which you can manage gateway user and gateway administrator access.

By default, all members of the AAD tenant will have user access to the Honolulu gateway service. Only local administrators on the gateway machine will have administrator access to the Honolulu gateway.

If you want to give specific AAD users or groups gateway user or gateway administrator access to the Honolulu service, you must do the following:

1.	Go to your SME AAD application in the Azure portal. 
    -	When you click **Change access control** and then select **Azure Active Directory** from the Honolulu Access settings, you can use the hyperlink provided in the UI to access your AAD application in the Azure portal. This hyperlink is also available in the Access settings after you click save and have selected AAD as your access control identity provider.
    -	You can also find your application in the Azure portal by going to **Azure Active Directory** > **Enterprise applications** > **All applications** and searching **SME** (the AAD app will be named SME-<gateway>). If you don't get any search results, ensure **Show** is set to **all applications**, **application status** is set to **any** and click Apply, then try your search. Once you've found the application, go to **Users and groups**
2.	In the Properties tab, set **User assignment required** to Yes.
    Once you've done this, only members listed in the Users and groups tab will be able to access the Honolulu gateway.
3.	In the Users and groups tab, select **Add user**. You must assign a gateway user or gateway administrator role for each user/group added.

Once you save the AAD access control in the "Change access control" pane, the gateway service will restart and you must refresh your browser. You can update user access for the SME AAD application in the Azure portal at any time. 

Users will now be prompted to login using their Azure Active Directory identity when they attempt to access the Honolulu gateway URL. From the Azure tab of Honolulu general settings, users and administrators can view their currently logged in account and as well as sign-out of this AAD account.

#### Conditional access and multi-factor authentication

One of the benefits of using Azure Active Directory as your identity provider for controlling access to the Honolulu gateway is that you can leverage AAD's powerful security features like conditional access and multi-factor authentication. To set up conditional access, you can follow the [guidance here](https://docs.microsoft.com/azure/active-directory/active-directory-conditional-access-azure-portal-get-started).

[TODO:legacy-content-end]