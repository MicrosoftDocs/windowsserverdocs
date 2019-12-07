---
title: Configuring Azure Integration
description: Configuring Azure Integration Windows Admin Center (Project Honolulu). Connecting your Windows Admin Center gateway to Azure.
ms.technology: manage
ms.topic: article
author: haley-rowland
ms.author: harowl
ms.date: 09/19/2018
ms.localizationpriority: medium
ms.prod: windows-server
---

# Configuring Azure integration

>Applies To: Windows Admin Center, Windows Admin Center Preview

Windows Admin Center supports several optional features that integrate with Azure services. [Learn about the Azure integration options available with Windows Admin Center.](../plan/azure-integration-options.md)

To allow the Windows Admin Center gateway to communicate with Azure to leverage Azure Active Directory authentication for gateway access, or to create Azure resources on your behalf (for example, to protect VMs managed in Windows Admin Center using Azure Site Recovery), you will need to first register your Windows Admin Center gateway with Azure. You only need to do this once for your Windows Admin Center gateway - the setting is preserved when you update your gateway to a newer version.

## Register your gateway with Azure

The first time you try to use an Azure integration feature in Windows Admin Center, you will be prompted to register the gateway to Azure. You can also register the gateway by going to the **Azure** tab in Windows Admin Center Settings. Note that only Windows Admin Center gateway administrators can register the Windows Admin Center gateway with Azure. [Learn more about Windows Admin Center user and administrator permissions](../configure/user-access-control.md#gateway-access-role-definitions).

The guided in-product steps will create an Azure AD app in your directory, which allows Windows Admin Center to communicate with Azure. To view the Azure AD app that is automatically created, go to the **Azure** tab of Windows Admin Center settings. The **View in Azure** hyperlink lets you view the Azure AD app in the Azure portal. 

The Azure AD app created is used for all points of Azure integration in Windows Admin Center, including [Azure AD authentication to the gateway](../configure/user-access-control.md#azure-active-directory). Windows Admin Center automatically configures the permissions needed to create and manage Azure resources on your behalf:

- Azure Active Directory Graph
    - Directory.AccessAsUser.All
    - User.Read
- Azure Service Management
    - user_impersonation

### Manual Azure AD app configuration

If you wish to configure an Azure AD app manually, rather than using the Azure AD app created automatically by Windows Admin Center during the gateway registration process, you must do the following.

1. Grant the Azure AD app the required API permissions listed above. You can do so by navigating to your Azure AD app in the Azure portal. Go to the Azure portal > **Azure Active Directory** > **App registrations** > select your Azure AD app you wish to use. Then to to the **API permissions** tab and add the API permissions listed above.
2. Add the Windows Admin Center gateway URL to the reply URLs (also known as the redirect URIs). Navigate to your Azure AD app, then go to **Manifest**. Find the "replyUrlsWithType" key in the manifest. Within the key, add an object containing two keys: "url" and "type". The key "url" should have a value of the Windows Admin Center gateway URL, appending a wildcard at the end. The key "type" key should have a value of "Web". For example:

    ```json
    "replyUrlsWithType": [
            {
                    "url": "http://localhost:6516/*",
                    "type": "Web"
            }
    ],
    ```
