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

The first time you try to use an Azure integration feature in Windows Admin Center, you will be prompted to register the gateway to Azure. You can also register the gateway by going to the **Azure** tab in Windows Admin Center Settings. Note that only Windows Admin Center gateway administrators can register the Windows Admin Center gateway with Azure. [Learn more about Windows Admin Center user and administrator permissions](../configure/user-access-control.md#gateway-access-role-definitions).

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
                    "type": "Web"
            }
    ],
    ```

> [!NOTE]
> If you have Microsoft Defender Application Guard enabled for your browser, you won't be able to register Windows Admin Center with Azure or sign into Azure.


## Stay updated

[Follow us on Twitter](https://twitter.com/servermgmt)

[Read our Blogs](https://techcommunity.microsoft.com/t5/windows-admin-center-blog/bg-p/Windows-Admin-Center-Blog)
