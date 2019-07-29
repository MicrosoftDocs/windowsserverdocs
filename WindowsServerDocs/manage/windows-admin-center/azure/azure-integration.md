---
title: Configuring Azure Integration
description: Configuring Azure Integration Windows Admin Center (Project Honolulu). Connecting your Windows Admin Center gateway to Azure.
ms.technology: manage
ms.topic: article
author: haley-rowland
ms.author: harowl
ms.date: 09/19/2018
ms.localizationpriority: medium
ms.prod: windows-server-threshold
---

# Configuring Azure integration

>Applies To: Windows Admin Center, Windows Admin Center Preview

Windows Admin Center supports several optional features that integrate with Azure services. [Learn about the Azure integration options available with Windows Admin Center.](../plan/azure-integration-options.md)

To allow the Windows Admin Center gateway to communicate with Azure to leverage Azure Active Directory authentication for gateway access, or to create Azure resources on your behalf (for example, to protect VMs managed in Windows Admin Center using Azure Site Recovery), you will need to first register your Windows Admin Center gateway with Azure. You only need to do this once for your Windows Admin Center gateway - the setting is preserved when you update your gateway to a newer version.

## Register your gateway with Azure

The first time you try to use an Azure integration feature in Windows Admin Center, you will be prompted to register the gateway to Azure. You can also register the gateway by going to the **Azure** tab in Windows Admin Center Settings.

The guided in-product steps will create an Azure AD app in your directory, which allows Windows Admin Center to communicate with Azure. To view the Azure AD app that is automatically created, go to the **Azure** tab of Windows Admin Center settings. The **View in Azure** hyperlink lets you view the Azure AD app in the Azure portal. 

The Azure AD app created is used for all points of Azure integration in Windows Admin Center, including [Azure AD authentication to the gateway](../configure/user-access-control.md#azure-active-directory).