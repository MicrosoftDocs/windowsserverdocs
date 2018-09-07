---
title: Set up the Remote Desktop web client for your users
description: Describes how an admin can set up the Remote Desktop web client.
ms.prod: windows-server-threshold
ms.technology: remote-desktop-services
ms.author: helohr
ms.date: 08/02/2018
ms.topic: article
author: Heidilohr
ms.localizationpriority: medium
---
# Set up the Remote Desktop web client for your users

The Remote Desktop web client lets users access your organization's Remote Desktop infrastructure through a compatible web browser. They'll be able to interact with remote apps or desktops like they would with a local PC no matter where they are. Once you set up your Remote Desktop web client, all your users need to get started is the URL where they can access the client, their credentials, and a supported web browser.

>[!IMPORTANT]
>The web client does not currently support using Azure Application Proxy and does not support Web Application Proxy at all. See [Using RDS with application proxy services](../rds-supported-config.md#using-remote-desktop-services-with-application-proxy-services) for details.

## What you'll need to set up the web client

Before getting started, keep the following things in mind:

* Make sure your [Remote Desktop deployment](../rds-deploy-infrastructure.md) has an RD Gateway, an RD Connection Broker, and RD Web Access running on Windows Server 2016 or 2019.
* Make sure your deployment is configured for [per-user client access licenses](../rds-client-access-license.md) (CALs) instead of per-device, otherwise all licenses will be consumed.
* Install the [Windows 10 KB4025334 update](https://support.microsoft.com/en-us/help/4025334/windows-10-update-kb4025334) on the RD Gateway. Later cumulative updates may already contains this KB.
* Make sure public trusted certificates are configured for the RD Gateway and RD Web Access roles.
* Make sure that any computers your users will connect to are running one of the following OS versions:
    * Windows 10
    * Windows Server 2008R2 or later

Your users will see better performance connecting to Windows Server 2016 (or later) and Windows 10 (version 1611 or later).

>[!IMPORTANT]
>If you used the web client during the preview period and installed a version prior to 1.0.0, you must first uninstall the old client before moving to the new version. If you receive an error that says "The web client was installed using an older version of RDWebClientManagement and must first be removed before deploying the new version," follow these steps:
>
>1. Open an elevated PowerShell prompt.
>2. Run **Uninstall-Module RDWebClientManagement** to uninstall the new module.
>3. Close and reopen the elevated PowerShell prompt.
>4. Run **Install-Module RDWebClientManagement -RequiredVersion \<old version> to install the old module.**
>5. Run **Uninstall-RDWebClient** to uninstall the old web client.
>6. Run **Uninstall-Module RDWebClientManagement** to uninstall the old module.
>7. Close and reopen the elevated PowerShell prompt.
>8. Proceed with the normal installation steps as follows.

## How to publish the Remote Desktop web client

To install the web client for the first time, follow these steps:

1. On the RD Connection Broker server, obtain the certificate used for Remote Desktop connections and export it as a .cer file. Copy the .cer file from the RD Connection Broker to the server running the RD Web role.
2. On the RD Web Access server, open an elevated PowerShell prompt.
3. On Windows Server 2016, update the PowerShellGet module since the inbox version doesn't support installing the web client management module. To update PowerShellGet, run the following cmdlet:
    ```PowerShell
    Install-Module -Name PowerShellGet -Force
    ```
    
    >[!IMPORTANT]
    >You'll need to restart PowerShell before the update can take effect, otherwise the module may not work.

4. Install the Remote Desktop web client management PowerShell module from the PowerShell gallery with this cmdlet:
    ```PowerShell
    Install-Module -Name RDWebClientManagement
    ```
    
5. After that, run the following cmdlet to download the latest version of the Remote Desktop web client:
    ```PowerShell
    Install-RDWebClientPackage
    ```
    
6. Next, run this cmdlet with the bracketed value replaced with the path of the .cer file that you copied from the RD Broker:
    ```PowerShell
    Import-RDWebClientBrokerCert <.cer file path>
    ```
    
7. Finally, run this cmdlet to publish the Remote Desktop web client:
    ```PowerShell
    Publish-RDWebClientPackage -Type Production -Latest
    ```
    Make sure you can access the web client at the web client URL with your server name, formatted as <https://server_FQDN/RDWeb/webclient/index.html>. It's important to use the server name that matches the RD Web Access public certificate in the URL (typically the server FQDN).

    >[!NOTE]
    >When running the **Publish-RDWebClientPackage** cmdlet, you may see a warning that says per-device CALs are not supported, even if your deployment is configured for per-user CALs. If your deployment uses per-user CALs, you can ignore this warning. We display it to make sure you’re aware of the configuration limitation.
8. When you're ready for users to acces the web client, just send them the web client URL you created.

>[!NOTE]
>To see a list of all supported cmdlets for the RDWebClientManagement module, run the following cmdlet in PowerShell:
>```PowerShell
>Get-Command -Module RDWebClientManagement
>```

## How to update the Remote Desktop web client

When a new version of the Remote Desktop web client is available, follow these steps to update the deployment with the new client:

1. Open an elevated PowerShell prompt on the RD Web Access server and run the following cmdlet to download the latest available version of the web cient:
    ```PowerShell
    Install-RDWebClientPackage
    ```

2. Optionally, you can publish the client for testing before official release by running this cmdlet:
    ```PowerShell
    Publish-RDWebClientPackage -Type Test -Latest
    ```

    The client should appear on the test URL that corresponds to your web client URL (for example, <https://server_FQDN/RDWeb/webclient-test/index.html>).
3. Publish the client for users by running the following cmdlet:
    ```PowerShell
    Publish-RDWebClientPackage -Type Production -Latest
    ```

    This will replace the client for all users when they relaunch the web page.

## How to uninstall the Remote Desktop web client

To remove all traces of the web client, follow these steps:

1. On the RD Web Access server, open an elevated PowerShell prompt.
2. Unpublish the Test and Production clients, uninstall all local packages and remove the web client settings:
   
   ```PowerShell
   Uninstall-RDWebClient
   ```

3. Uninstall the Remote Desktop web client management PowerShell module:

   ```PowerShell
   Uninstall-Module -Name RDWebClientManagement
   ```

## Troubleshooting

If a user reports any of the following issues when opening the web client for the first time, the following sections will tell you what to do to fix them.

### What to do if the user's browser shows a security warning when they try to access the web client

The RD Web Access role might not be using a trusted certificate. Make sure the RD Web Access role is configured with a publicly trusted certificate.

If that doesn't work, your server name in the web client URL might not match the name provided by the RD Web certificate. Make sure your URL uses the FQDN of the server hosting the RD Web role.

### What to do if the user can't connect to a resource with the web client even though they can see the items under All Resources

If the user reports that they can't connect with the web client even though they can see the resources listed, check the following things:

* Is the RD Gateway role properly configured to use a trusted public certificate?
* Does the RD Gateway server have the required updates installed? Make sure that your server has [the KB4025334 update](https://support.microsoft.com/en-us/help/4025334/windows-10-update-kb4025334) installed.

If the user gets an "unexpected server authentication certificate was received" error message when they try to connect, then the message will show the certificate's thumbprint. Search the RD Broker server's certificate manager using that thumbprint to find the right certificate. Verify that the certificate is configured to be used for the RD Broker role in the Remote Desktop deployment properties page. After making sure the certificate hasn't expired, copy the certificate in .cer file format to the RD Web Access server and run the following command on the RD Web Access server with the bracketed value replaced by the certificate's file path:

```PowerShell
Import-RDWebClientBrokerCert <certificate file path>
```

### Diagnose issues with the console log

If you can't solve the issue based on the troubleshooting instructions in this article, you can try to diagnose the source of the problem yourself by watching the console log in the browser. The console is generally located under the developer tools. For example, you can access the log in Edge by pressing the **F12** key, or by selecting the ellipsis, then navigating to **More tools** > **Developer Tools**.

## Get help with the web client

If you've encountered an issue that can’t be solved by the information in this article, you can [email us](mailto:rdwbclnt@microsoft.com) to report it. You can also request or vote for new features at our [suggestion box](https://aka.ms/rdwebfbk).