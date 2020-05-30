---
title: Set up the Remote Desktop web client for your users
description: Describes how an admin can set up the Remote Desktop web client.
ms.prod: windows-server
ms.technology: remote-desktop-services
ms.author: helohr
ms.date: 09/19/2019
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
* Install the [Windows 10 KB4025334 update](https://support.microsoft.com/help/4025334/windows-10-update-kb4025334) on the RD Gateway. Later cumulative updates may already contains this KB.
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
    >When running the **Publish-RDWebClientPackage** cmdlet, you may see a warning that says per-device CALs are not supported, even if your deployment is configured for per-user CALs. If your deployment uses per-user CALs, you can ignore this warning. We display it to make sure you're aware of the configuration limitation.
8. When you're ready for users to access the web client, just send them the web client URL you created.

>[!NOTE]
>To see a list of all supported cmdlets for the RDWebClientManagement module, run the following cmdlet in PowerShell:
>```PowerShell
>Get-Command -Module RDWebClientManagement
>```

## How to update the Remote Desktop web client

When a new version of the Remote Desktop web client is available, follow these steps to update the deployment with the new client:

1. Open an elevated PowerShell prompt on the RD Web Access server and run the following cmdlet to download the latest available version of the web client:
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

## How to install the Remote Desktop web client without an internet connection

Follow these steps to deploy the web client to an RD Web Access server that doesn't have an internet connection.

> [!NOTE]
> Installing without an internet connection is available in version 1.0.1 and above of the RDWebClientManagement PowerShell module.

> [!NOTE]
> You still need an admin PC with internet access to download the necessary files before transferring them to the offline server.

> [!NOTE]
> The end-user PC needs an internet connection for now. This will be addressed in a future release of the client to provide a complete offline scenario.

### From a device with internet access

1. Open a PowerShell prompt.

2. Import the Remote Desktop web client management PowerShell module from the PowerShell gallery:
    ```PowerShell
    Import-Module -Name RDWebClientManagement
    ```

3. Download the latest version of the Remote Desktop web client for installation on a different device:
    ```PowerShell
    Save-RDWebClientPackage "C:\WebClient\"
    ```

4. Download the latest version of the RDWebClientManagement PowerShell module:
    ```PowerShell
    Find-Module -Name "RDWebClientManagement" -Repository "PSGallery" | Save-Module -Path "C:\WebClient\"
    ```

5. Copy the content of "C:\WebClient\" to the RD Web Access server.

### From the RD Web Access server

Follow the instructions under [How to publish the Remote Desktop web client](remote-desktop-web-client-admin.md#how-to-publish-the-remote-desktop-web-client), replacing steps 4 and 5 with the following.

4. You have two options to retrieve the latest web client management PowerShell module:
    - Import the Remote Desktop web client management PowerShell module:
      ```PowerShell
      Import-Module -Name RDWebClientManagement
      ```
    - Copy the downloaded RDWebClientManagement folder to one of the local PowerShell module folders listed under **$env:psmodulePath**, or add the path to the folder with the downloaded files to the **$env:psmodulePath**.

5. Deploy the latest version of the Remote Desktop web client from the local folder (replace with the appropriate zip file):
    ```PowerShell
    Install-RDWebClientPackage -Source "C:\WebClient\rdwebclient-1.0.1.zip"
    ```

## Connecting to RD Broker without RD Gateway in Windows Server 2019
This section describes how to enable a web client connection to an RD Broker without an RD Gateway in Windows Server 2019.

### Setting up the RD Broker server

#### Follow these steps if there is no certificate bound to the RD Broker server

1. Open **Server Manager** > **Remote Desktop Services**.

2. In **Deployment Overview** section, select the **Tasks** dropdown menu.

3. Select **Edit Deployment Properties**, a new window titled **Deployment Properties** will open.

4. In the **Deployment Properties** window, select **Certificates** in the left menu.

5. In the list of Certificate Levels, select **RD Connection Broker - Enable Single Sign On**. You have two options: (1) create a new certificate or (2) an existing certificate.

#### Follow these steps if there is a certificate previously bound to the RD Broker server

1. Open the certificate bound to the Broker and copy the **Thumbprint** value.

2. To bind this certificate to the secure port 3392, open an elevated PowerShell window and run the following command, replacing **"< thumbprint >"** with the value copied from the previous step:

    ```PowerShell
    netsh http add sslcert ipport=0.0.0.0:3392 certhash="<thumbprint>" certstorename="Remote Desktop" appid="{00000000-0000-0000-0000-000000000000}"
    ```

    > [!NOTE]
    > To check if the certificate has been bound correctly, run the following command:
    >
    > ```PowerShell
    > netsh http show sslcert
    > ```
    >
    > In the list of SSL Certificate bindings, ensure that the correct certificate is bound to port 3392.

3. Open the Windows Registry (regedit) and nagivate to ```HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp``` and locate the key **WebSocketURI**. The value must be set to <strong>https://+:3392/rdp/</strong>.

### Setting up the RD Session Host
Follow these steps if the RD Session Host server is different from the RD Broker server:

1. Create a certificate for the RD Session Host machine, open it and copy the **Thumbprint** value.

2. To bind this certificate to the secure port 3392, open an elevated PowerShell window and run the following command, replacing **"< thumbprint >"** with the value copied from the previous step:

    ```PowerShell
    netsh http add sslcert ipport=0.0.0.0:3392 certhash="<thumbprint>" appid="{00000000-0000-0000-0000-000000000000}"
    ```

    > [!NOTE]
    > To check if the certificate has been bound correctly, run the following command:
    >
    > ```PowerShell
    > netsh http show sslcert
    > ```
    >
    > In the list of SSL Certificate bindings, ensure that the correct certificate is bound to port 3392.

3. Open the Windows Registry (regedit) and nagivate to ```HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp``` and locate the key **WebSocketURI**. The value must be set to <https://+:3392/rdp/>.

### General Observations

* Ensure that both the RD Session Host and RD Broker server are running Windows Server 2019.

* Ensure that public trusted certificates are configured for both the RD Session Host and RD Broker server.
    > [!NOTE]
    > If both the RD Session Host and the RD Broker server share the same machine, set the RD Broker server certificate only. If the RD Session Host and RD Broker server use different machines, both must be configured with unique certificates.

* The **Subject Alternative Name (SAN)** for each certificate must be set to the machine's **Fully Qualified Domain Name (FQDN)**. The **Common Name (CN)** must match the SAN for each certificate.

## How to pre-configure settings for Remote Desktop web client users
This section will tell you how to use PowerShell to configure settings for your Remote Desktop web client deployment. These PowerShell cmdlets control a user's ability to change settings based on your organization's security concerns or intended workflow. The following settings are all located in the **Settings** side panel of the web client.

### Suppress telemetry
By default, users may choose to enable or disable collection of telemetry data that is sent to Microsoft. For information about the telemetry data Microsoft collects, please refer to our Privacy Statement via the link in the **About** side panel.

As an administrator, you can choose to suppress telemetry collection for your deployment using the following PowerShell cmdlet:

   ```PowerShell
    Set-RDWebClientDeploymentSetting -Name "SuppressTelemetry" $true
   ```

By default, the user may select to enable or disable telemetry. A boolean value **$false** will match the default client behavior. A boolean value **$true** disables telemetry and restricts the user from enabling telemetry.

### Remote resource launch method

>[!NOTE]
>This setting currently only works with the RDS web client, not the Windows Virtual Desktop web client.

By default, users may choose to launch remote resources (1) in the browser or (2) by downloading an .rdp file to handle with another client installed on their machine. As an administrator, you can choose to restrict the remote resource launch method for your deployment with the following Powershell command:

   ```PowerShell
    Set-RDWebClientDeploymentSetting -Name "LaunchResourceInBrowser" ($true|$false)
   ```
 By default, the user may select either launch method. A boolean value **$true** will force the user to launch resources in the browser. A boolean value **$false** will force the user to launch resources by downloading an .rdp file to handle with a locally installed RDP client.

### Reset RDWebClientDeploymentSetting configurations to default

To reset a deployment-level web client setting to the default configuration, run the following PowerShell cmdlet and use the -name parameter to specify the setting you want to reset:

   ```PowerShell
    Reset-RDWebClientDeploymentSetting -Name "LaunchResourceInBrowser"
    Reset-RDWebClientDeploymentSetting -Name "SuppressTelemetry"
   ```

## Troubleshooting

If a user reports any of the following issues when opening the web client for the first time, the following sections will tell you what to do to fix them.

### What to do if the user's browser shows a security warning when they try to access the web client

The RD Web Access role might not be using a trusted certificate. Make sure the RD Web Access role is configured with a publicly trusted certificate.

If that doesn't work, your server name in the web client URL might not match the name provided by the RD Web certificate. Make sure your URL uses the FQDN of the server hosting the RD Web role.

### What to do if the user can't connect to a resource with the web client even though they can see the items under All Resources

If the user reports that they can't connect with the web client even though they can see the resources listed, check the following things:

* Is the RD Gateway role properly configured to use a trusted public certificate?
* Does the RD Gateway server have the required updates installed? Make sure that your server has [the KB4025334 update](https://support.microsoft.com/help/4025334/windows-10-update-kb4025334) installed.

If the user gets an "unexpected server authentication certificate was received" error message when they try to connect, then the message will show the certificate's thumbprint. Search the RD Broker server's certificate manager using that thumbprint to find the right certificate. Verify that the certificate is configured to be used for the RD Broker role in the Remote Desktop deployment properties page. After making sure the certificate hasn't expired, copy the certificate in .cer file format to the RD Web Access server and run the following command on the RD Web Access server with the bracketed value replaced by the certificate's file path:

```PowerShell
Import-RDWebClientBrokerCert <certificate file path>
```

### Diagnose issues with the console log

If you can't solve the issue based on the troubleshooting instructions in this article, you can try to diagnose the source of the problem yourself by watching the console log in the browser. The web client provides a method for recording the browser console log activity while using the web client to help diagnose issues.

* Select the ellipsis in the upper-right corner and navigate to the **About** page in the dropdown menu.
* Under **Capture support information** select the **Start recording** button.
* Perform the operation(s) in the web client that produced the issue you are trying to diagnose.
* Navigate to the **About** page and select **Stop recording**.
* Your browser will automatically download a .txt file titled **RD Console Logs.txt**. This file will contain the full console log activity generated while reproducing the target issue.

The console may also be accessed directly through your browser. The console is generally located under the developer tools. For example, you can access the log in Microsoft Edge by pressing the **F12** key, or by selecting the ellipsis, then navigating to **More tools** > **Developer Tools**.

## Get help with the web client

If you've encountered an issue that can't be solved by the information in this article, you can report it on [Tech Community](https://aka.ms/wvdtc). You can also request or vote for new features at our [suggestion box](https://remotedesktop.uservoice.com/forums/911494-remote-desktop-web-client).
