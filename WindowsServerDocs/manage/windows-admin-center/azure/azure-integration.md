---
title: Configuring Azure Integration
description: Configuring Azure Integration Windows Admin Center (Project Honolulu). Connecting your Windows Admin Center gateway to Azure.
ms.topic: article
author: IngridAtMicrosoft
ms.author: wscontent
ms.date: 10/18/2021
---

# Configuring Azure integration

>Applies to: Windows Admin Center, Windows Admin Center Preview

Windows Admin Center supports several optional features that integrate with Azure services. [Learn about the Azure integration options available with Windows Admin Center.](./index.md)

To allow the Windows Admin Center gateway to communicate with Azure to leverage Microsoft Entra authentication for gateway access, or to create Azure resources on your behalf (for example, to protect VMs managed in Windows Admin Center using Azure Site Recovery), you will need to first register your Windows Admin Center gateway with Azure. You only need to do this once for your Windows Admin Center gateway - the setting is preserved when you update your gateway to a newer version.

## Register your gateway with Azure

The first time you try to use an Azure integration feature in Windows Admin Center, you're prompted to register the gateway to Azure. You can also register the gateway by going to the **Azure** tab in Windows Admin Center Settings. Only Windows Admin Center gateway administrators can register the Windows Admin Center gateway with Azure. [Learn more about Windows Admin Center user and administrator permissions](../configure/user-access-control.md#gateway-access-role-definitions).


The guided in-product steps will create a Microsoft Entra app in your directory, which allows Windows Admin Center to communicate with Azure. To view the Microsoft Entra app that is automatically created, go to the **Azure** tab of Windows Admin Center settings. The **View in Azure** hyperlink lets you view the Microsoft Entra app in the Azure portal.

The Microsoft Entra app created is used for all points of Azure integration in Windows Admin Center, including [Microsoft Entra authentication to the gateway](../configure/user-access-control.md#azure-active-directory). Windows Admin Center automatically configures the permissions needed to create and manage Azure resources on your behalf:

- Microsoft Graph
    - Application.Read.All
    - Application.ReadWrite.All
    - Directory.AccessAsUser.All
    - Directory.Read.All
    - Directory.ReadWrite.All
    - User.Read
- Azure Service Management
    - user_impersonation

<a name='manual-azure-ad-app-configuration'></a>

### Manual Microsoft Entra app configuration

If you wish to configure a Microsoft Entra app manually, rather than using the Microsoft Entra app created automatically by Windows Admin Center during the gateway registration process, you must do the following.

1. Grant the Microsoft Entra app the required API permissions listed above. You can do so by navigating to your Microsoft Entra app in the Azure portal. Go to the Azure portal > **Microsoft Entra ID** > **App registrations** > select your Microsoft Entra app you wish to use. Then to to the **API permissions** tab and add the API permissions listed above.
2. Add the Windows Admin Center gateway URL to the reply URLs (also known as the redirect URIs). Navigate to your Microsoft Entra app, then go to **Manifest**. Find the "replyUrlsWithType" key in the manifest. Within the key, add an object containing two keys: "url" and "type". The key "url" should have a value of the Windows Admin Center gateway URL, appending a wildcard at the end. The key "type" key should have a value of "Web". For example:

    ```json
    "replyUrlsWithType": [
            {
                    "url": "http://localhost:6516/*",
                    "type": "Single-Page Application"
            }
    ],
    ```

> [!NOTE]
> If you have Microsoft Defender Application Guard enabled for your browser, you won't be able to register Windows Admin Center with Azure or sign into Azure.

## Troubleshooting Single-Page Application error on Azure sign-in

If you've recently updated your Windows Admin Center instance to a newer version, and your gateway was previously registered with Azure, you might encounter an error stating "cross-origin token redemption is permitted only for the 'Single-Page Application' client type" upon signing into Azure. This is because Windows Admin Center has changed the way we perform authentication based on [general Microsoft guidance](/entra/identity-platform/v2-oauth2-implicit-grant-flow#prefer-the-auth-code-flow). Where we previously used the implicit grant flow, we're now using the authorization code flow. 

If you'd like to continue using your existing app registration for your Windows Admin Center application, use [Microsoft Entra admin center](https://entra.microsoft.com/) to update the registration's redirect URIs to the Single-Page Application (SPA) platform. Doing so enables the authorization code flow with Proof Key for Code Exchange (PKCE) and cross-origin resource sharing (CORS) support for applications that use that registration.

Follow these steps for application registrations that are currently configured with **Web** platform redirect URIs:
1.	Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).
2.	Navigate to **Identity > Applications > App registrations**, select your application, and then **Authentication**.
3.	In the **Web** platform tile under **Redirect URIs**, select the warning banner indicating that you should migrate your URIs.
![Screenshot of warning banner under web platform tile suggesting URI migration.](../media/entra-uri-warning-banner.png)
4. Select the redirect URI for your application and then select **Configure**. These redirect URIs should now appear in the **Single-page application** platform tile, showing that CORS support with the authorization code flow and PKCE is enabled for these URIs.
![Screenshot of migrate URIs selection page.](../media/entra-migrate-uris.png)

Instead of updating existing URIs, you can instead create a new application registration for your gateway. App registrations that are newly created for Windows Admin Center through the gateway registration flow create Single-Page Application platform redirect URIs. 

If you can't migrate your application registration's redirect URIs to use auth code flow, you can continue to use the existing application registration as is. To do so, you must unregister your Windows Admin Center gateway and re-register with the same application registration ID.

## Stay updated

[Follow us on Twitter](https://twitter.com/servermgmt)

[Read our Blogs](https://techcommunity.microsoft.com/t5/windows-admin-center-blog/bg-p/Windows-Admin-Center-Blog)
