---
title: Configuring Azure Integration
description: Configuring Azure Integration Windows Admin Center (Project Honolulu). Connecting your Windows Admin Center gateway to Azure.
ms.technology: manage
ms.topic: article
author: haley-rowland
ms.author: harowl
ms.date: 06/18/2018
ms.localizationpriority: medium
ms.prod: windows-server-threshold
---

# Configuring Azure integration

>Applies To: Windows Admin Center, Windows Admin Center Preview

Windows Admin Center supports several optional features that integrate with Azure services. [Learn about the Azure integration options available with Windows Admin Center.](../plan/azure-integration-options.md)

To allow the Windows Admin Center gateway to communicate with Azure to leverage Azure Active Directory authentication for gateway access, or to create Azure resources on your behalf (for example, to protect VMs managed in Windows Admin Center using Azure Site Recovery), you will need to first register your Windows Admin Center gateway with Azure. You only need to do this once for your Windows Admin Center gateway - the setting is preserved when you update your gateway to a newer version.

## Register your gateway with Azure using Windows Admin Center Preview

The first time you try to use an Azure integration feature in Windows Admin Center, you will be prompted to register the gateway to Azure. You can also register the gateway by going to the **Azure** tab in Windows Admin Center Settings.

The guided in-product steps will create an Azure AD app in your directory, which allows Windows Admin Center to communicate with Azure. To view the Azure AD app that is automatically created, go to the **Azure** tab of Windows Admin Center settings. The **View in Azure** hyperlink lets you view the Azure AD app in the Azure portal. 

The Azure AD app created is used for all points of Azure integration in Windows Admin Center, including [Azure AD authentication to the gateway](user-access-control.md#azure-active-directory).

## Register your gateway with Azure using Windows Admin Center

To connect your gateway, you must run the [New-AadApp.ps1 PowerShell script](https://aka.ms/WACAzureConnectScript) (there is also a hyperlink in the Windows Admin Center UI for this download, which is visible wherever you try to use an Azure integration feature for the first time), which creates a web application in Azure AD with the name "WindowsAdminCenter-*gateway*" (previous versions of the script create an app with the name "SME-*gateway*") and registers the application with the Windows Admin Center gateway. This allows Windows Admin Center to connect to Azure resources like Azure AD on your behalf. You can run the script from any computer that has access to the Windows Admin Center gateway and to Azure, with the Windows Admin Center gateway URL as the `-GatewayEndpoint` parameter. 

This script requires two Azure PowerShell modules: AzureRm.Resources and AzureAD. If you don't have them installed, run the following commands in an elevated PowerShell console:

```powershell
    PS C:>Install-Module AzureRM.Resources
    PS C:>Install-Module AzureAD
```

Once you have the prerequisite modules installed, you can run the script. For example,

```powershell
    PS> .\New-AadApp.ps1 -GatewayEndpoint "https://gateway.contoso.com"
```

If you are NOT using port 443, the `-GatewayEndpoint` parameter should contain the port (for example, `"https://myComputer:6516"`).

Unless the computer where you run the script has administrative privilege on the computer where Windows Admin Center is installed, you will need to include the `-Credential` parameter to specify a username and password with access to the computer where Windows Admin Center is installed. The `-Credential` parameter takes a PSCredential, which you can create by using the cmdlet Get-Credential. Alternatively, you can pass in a username for `-Credential` and you will be prompted to provide a password. For example,

```powershell
    PS> $cred = Get-Credential
    PS> .\New-AadApp.ps1 -GatewayEndpoint "https://gateway.contoso.com" -Credential $cred
```

If you have multiple directories, or tenants, associated with your Azure account, you can use the `-TenantId` parameter to specify the tenant in which you want to create the Azure AD application and associate with your Windows Admin Center gateway. For example,

```powershell
    PS> .\New-AadApp.ps1 -GatewayEndpoint "https://gateway.contoso.com" -TenantId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

After running the script, complete the following steps to grant permissions to the application:
1. From the script output, copy the AadClientId.
2. Go to the [Azure portal](https://portal.azure.com) > **Azure Active Directory**
3. Go to **App registrations**, and search for the application just created, using the AadClientId copied in step 1. You can also search using the gateway name (the same name used as the -GatewayEndpoint parameter in the New-AadApp.ps1 script). Select this application.
4. Select **Settings** > **Required permissions**, and then click **Grant Permissions** > **Yes**.

Finally, refresh the browser page from which you are accessing the Windows Admin Center gateway. 

## Other considerations

If you've already configured your gateway for Azure connectivity when you set up Azure Site Recovery and you used the New-AsrAadApp.ps1 available in our documentation prior to the version 1804.25 release, you need to delete your existing Azure AD application. In the Azure portal go to **Azure Active Directory** > **Application registration** > **All applications** and search for "ASR" (the old Azure AD app is named "ASR-Honolulu-*gateway*"). Then run the [New-AadApp.ps1 script](https://aka.ms/WACAzureConnectScript) to create the replacement application with the correct permissions.