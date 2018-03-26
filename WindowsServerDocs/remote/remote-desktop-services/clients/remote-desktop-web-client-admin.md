---
title: Set up the Remote Desktop web client for your users
description: Describes how an admin can set up the Remote Desktop web client.
ms.prod: windows-server-threshold
ms.technology: remote-desktop-services
ms.author: helohr
ms.date: 3/26/2018
ms.topic: article
author: Heidilohr
---
# Set up the Remote Desktop web client for your users

[This information relates to pre-released product which may be substantially modified before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information provided here.]

The Remote Desktop web client lets users access your organization's Remote Desktop infrastructure through a compatible web browser. They'll be able to interact with remote apps or desktops like they would with a local PC no matter where they are. Once you set up your Remote Desktop web client, all that your users will need to get started is the URL where they can access the client, their credentials, and a supported web browser.

>[!NOTE]
>You may have heard people call this client the HTML5 client. Both names refer to the same client.

## What you'll need to set up the web client

Before getting started, keep the following things in mind:

* Make sure your [Remote Desktop deployment](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/rds-deploy-infrastructure) has an RD Gateway, an RD Connection Broker, and RD Web Access running on Windows Server 2016.
* Make sure your deployment is configured for [per-user client access licenses](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/rds-client-access-license) (CALs) instead of per-device, otherwise all licenses will be consumed.
* Install the [Windows 10 KB4025334 update](https://support.microsoft.com/en-us/help/4025334/windows-10-update-kb4025334) on the RD Gateway.
* Make sure public trusted certificates are configured for the RD Gateway and RD Web Access roles.
* Make sure that any computers your users will connect to are running one of the following OS versions:
    * Windows 7 SP1 or later
    * Windows Server 2008R2 or later

Your users will see better performance connecting to Windows Server 2016 (or later) and Windows 10 (version 1611 or later).

## How to publish the Remote Desktop web client

To install the web client for the first time, follow these steps:

1. On the RD Connection Broker server, obtain the certificate used for Remote Desktop connections and export it as a .cer file. Copy the .cer file from the RD Connection Broker to the server running the RD Web role.
1. On the RD Web Access server, open an elevated PowerShell prompt.
1. Update the PowerShellGet module. The version of PowerShellGet that comes with Windows Server 2016 will not be able to install the web client management module. To update PowerShellGet, run the following command:
    ```PowerShell
    Install-Module -Name PowerShellGet -Force
    ```

1. Install the Remote Desktop web client management PowerShell module from the PowerShell gallery with this cmdlet:
    ```PowerShell
    Install-Module -Name RDWebClientManagement
    ```
    
1. After that, run the following cmdlet to download the latest version of the Remote Desktop web client:
    ```PowerShell
    Install-RDWebClientPackage
    ```
    
1. After that, run this cmdlet with the bracketed value replaced with path of the .cer file that you copied from the RD Broker:
    ```PowerShell
    Import-RDWebClientBrokerCert <.cer file path>
    ```
    
1. Finally, run this cmdlet to publish the Remote Desktop web client:
    ```PowerShell
    Publish-RDWebClientPackage -Production -Latest
    ```
    Make sure you can access the web client at the web client URL with your server name, formatted as <https://server_FQDN/RDWeb/Pages/webclient>. It's important to use the server name that matches the RD Web Access public certificate in the URL (typically the server FQDN).
1. When you're ready for users to acces the web client, just send them the web client URL you created.

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

    The client should appear on the test URL that corresponds to your web client URL (for example, <https://server_FQDN/RDWeb/Pages/webclient-test>).
3. Publish the client for users by running the following cmdlet:
    ```PowerShell
    Publish-RDWebClientPackage -Type Production -Latest
    ```

    This will replace the client for all users when they relaunch the web page.

To see a list of all supported cmdlets for the RDWebClientManagement module, run the following cmdlet in PowerShell:

```PowerShell
Get-Command -Module RDWebClientManagement
```

## Troubleshooting

If a user reports any of the following issues when opening the web client for the first time, the following sections will tell you what to do to fix them.

### What to do if the user's browser shows a security warning when they try to access the web client

The RD Web Access role might not be using a trusted certificate. Make sure the RD Web Access role is configured with a publicly trusted certificate.

If that doesn't work, your server name in the web client URL might not match the name provided by the RD Web certificate. Make sure your URL uses the FQDN of the server hosting the RD Web role.

### What to do if the user can't connect to a resource with the web client even though they can see the items under All Resources

If the user reports that they can't connect with the web client even though they can see the resources listed, check the following things:

* Is the RD Gateway role properly configured to use a trusted public certificate?
* Does teh RD Gateway server have the required updates installed? Make sure that your server has [the KB4025334 update](https://support.microsoft.com/en-us/help/4025334/windows-10-update-kb4025334) installed.

If the user gets an "unexpected server authentication certificate was received" error message when they try to connect, then the message will show the certificate's thumbprint. Search the RD Broker server's certificate manager using that thumbprint to find the right certificate. Verify that the certificate is configured to be used for the RD Broker role in the Remote Desktop deployment properties page. After making sure the certificate hasn't expired, copy the certificate in .cer file format to the RD Web Access server and run the following command on the RD Web Access server with the bracketed value replaced by the certificate's file path:

```PowerShell
Import-RDWebClientBrokerCert <certificate file path>
```