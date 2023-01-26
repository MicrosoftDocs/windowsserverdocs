---
title: Get started with the macOS client
description: Learn how to set up the Remote Desktop client for Mac
ms.topic: article
ms.assetid: 7afc65f8-3158-49c9-9d48-4dab1c69afba
author: Heidilohr
manager: femila
ms.author: helohr
ms.date: 11/03/2022
---
# Get started with the macOS client

>Applies to: Windows Server 2022, Windows Server 2019, Windows 10, Windows 8.1, Windows Server 2012 R2, Windows Server 2016

You can use the Remote Desktop client for Mac to work with Windows apps, resources, and desktops from your Mac computer. Use the following information to get started - and check out the [FAQ](remote-desktop-client-faq.yml) if you have questions.

> [!TIP]
> If you want to connect to Azure Virtual Desktop instead of Remote Desktop Services or a remote PC, see [Connect to Azure Virtual Desktop with the Remote Desktop client for macOS](/azure/virtual-desktop/users/connect-macos).

>[!NOTE]
> - Curious about the new releases for the macOS client? Check out [What's new for Remote Desktop on Mac?](mac-whatsnew.md)
> - The Mac client runs on computers running macOS 10.10 and newer.
> - The information in this article applies primarily to the full version of the Mac client - the version available in the Mac AppStore. Test-drive new features by downloading our preview app here:  [beta client release notes](https://go.microsoft.com/fwlink/?LinkID=619698&clcid=0x409).

## Get the Remote Desktop client

Follow these steps to get started with Remote Desktop on your Mac:

1. Download the Microsoft Remote Desktop client from the [Mac App Store](https://itunes.apple.com/app/microsoft-remote-desktop/id1295203466?mt=12).
2. [Set up your PC to accept remote connections](remote-desktop-client-faq.yml#how-do-i-set-up-a-pc-for-remote-desktop-). (If you skip this step, you can't connect to your PC.)
3. Add a Remote Desktop connection or a remote resource. You use a connection to connect directly to a Windows PC and a remote resource to use a RemoteApp program, session-based desktop, or a virtual desktop published on-premises using RemoteApp and Desktop Connections. This feature is typically available in corporate environments.

## What about the Mac beta client?

We're testing new features on our preview channel on AppCenter. Want to check it out? Go to [Microsoft Remote Desktop for Mac](https://aka.ms/rdmacbeta) and select **Download**. You don't need to create an account or sign into AppCenter to download the beta client.

If you already have the client, you can check for updates to ensure you have the latest version. In the beta client, select **Microsoft Remote Desktop Beta** at the top, and then select **Check for updates**.

## Add a workspace

Subscribe to the feed your admin gave you to get the list of managed resources available to you on your macOS device.

To subscribe to a feed:

1. Select **Add feed** on the main page to connect to the service and retrieve your resources.
2. In the Feed URL field, enter the URL for the feed you want to add. This URL can be either a URL or an email address.
   - If you use a URL, use the one your admin gave you.
   - If you use an email address, enter your email address. Entering your email address tells the client to search for a URL associated with your email address if your admin configured the server that way.
3. Select **Subscribe**.
4. Sign in with your user account when prompted.

After you've signed in, you should see a list of available resources.

Once you've subscribed to a feed, the feed's content will update automatically regularly. Resources may be added, changed, or removed based on changes made by your administrator.

### Export and import connections

You can export a remote desktop connection definition and use it on a different device. Remote desktops are saved in separate RDP files.

To export an RDP file:

1. In the Connection Center, right-click the remote desktop.
2. Select **Export**.
3. Browse to the location where you want to save the remote desktop RDP file.
4. Select **OK**.

To import an RDP file:

1. In the menu bar, select **File** > **Import**.
2. Browse to the RDP file.
3. Select **Open**.

## Add a remote resource

Remote resources are RemoteApp programs, session-based desktops, and virtual desktops published using RemoteApp and Desktop Connections.

- The URL displays the link to the RD Web Access server that gives you access to RemoteApp and Desktop Connections.
- The configured RemoteApp and Desktop Connections are listed.

To add a remote resource:

1. In the Connection Center select **+**, and then select **Add Remote Resources**.
2. Enter information for the remote resource:
   - **Feed URL** - The URL of the RD Web Access server. You can also enter your corporate email account in this field – this tells the client to search for the RD Web Access Server associated with your email address.
   - **User name** - The user name to use for the RD Web Access server you are connecting to.
   - **Password** - The password to use for the RD Web Access server you are connecting to.
3. Select **Save**.

The remote resources will be displayed in the Connection Center.

## Connect to an RD Gateway to access internal assets

A Remote Desktop Gateway (RD Gateway) lets you connect to a remote computer on a corporate network from anywhere on the Internet. You can create and manage your gateways in the preferences of the app or while setting up a new desktop connection.

To set up a new gateway in preferences:

1. In the Connection Center, select **Preferences > Gateways**.
2. Select the **+** button at the bottom of the table Enter the following information:
   - **Server name** – The name of the computer you want to use as a gateway. This can be a Windows computer name, an Internet domain name, or an IP address. You can also add port information to the server name (for example: **RDGateway:443** or **10.0.0.1:443**).
   - **User name** - The user name and password to be used for the Remote Desktop gateway you are connecting to. You can also select **Use connection credentials** to use the same user name and password as those used for the remote desktop connection.

## Manage your user accounts

When you connect to a desktop or remote resources, you can save the user accounts to select from again. You can manage your user accounts by using the Remote Desktop client.

To create a new user account:

1. In the Connection Center, select **Settings** > **Accounts**.
2. Select **Add User Account**.
3. Enter the following information:
   - **User Name** - The name of the user to save for use with a remote connection. You can enter the user name in any of the following formats: user_name, domain\user_name, or user_name@domain.com.
   - **Password** - The password for the user you specified. Every user account that you want to save to use for remote connections needs to have a password associated with it.
   - **Friendly Name** - If you are using the same user account with different passwords, set a friendly name to distinguish those user accounts.
4. Select **Save**, then select **Settings**.

## Customize your display resolution

You can specify the display resolution for the remote desktop session.

1. In the Connection Center, select **Preferences**.
2. Select **Resolution**.
3. Select **+**.
4. Enter a resolution height and width, and then select **OK.**

To delete the resolution, select it, and then select **-**.

## Displays have separate spaces

If you're running macOS X 10.9 and have disabled **Displays have separate spaces** in Mavericks (**System Preferences > Mission Control**), you need to configure this setting in the Remote Desktop client using the same option.

### Drive redirection for remote resources

Drive redirection is supported for remote resources, so that you can save files created with a remote application locally to your Mac. The redirected folder is always your home directory displayed as a network drive in the remote session.

> [!NOTE]
> In order to use this feature, the administrator needs to set the appropriate settings on the server.

## Use a keyboard in a remote session

Mac keyboard layouts differ from the Windows keyboard layouts.

- The Command key on the Mac keyboard equals the Windows key.
- To perform actions that use the Command button on the Mac, you will need to use the control button in Windows (for example Copy = Ctrl+C).
- The function keys can be activated in the session by pressing additionally the FN key (for example, FN+F1).
- The Alt key to the right of the space bar on the Mac keyboard equals the Alt Gr/right Alt key in Windows.

By default, the remote session will use the same keyboard locale as the OS you're running the client on. (If your Mac is running an en-us OS, it will be used for the remote sessions as well.) If the OS keyboard locale is not used, check the keyboard setting on the remote PC and change it manually. See the [Remote Desktop Client FAQ](remote-desktop-client-faq.yml) for more information about keyboards and locales.

## Support for Remote Desktop gateway pluggable authentication and authorization

Windows Server 2012 R2 introduced support for a new authentication method, Remote Desktop Gateway pluggable authentication and authorization, which provides more flexibility for custom authentication routines. You can now try this authentication model with the Mac client.

> [!IMPORTANT]
> Custom authentication and authorization models before Windows 8.1 aren't supported, although the article above discusses them.

To learn more about this feature, check out [Remote Desktop Gateway Pluggable Authentication and Authorization Sample](https://github.com/microsoftarchive/msdn-code-gallery-community-m-r/blob/master/Remote%20Desktop%20Gateway%20Pluggable%20Authentication%20and%20Authorization%20Sample/README.md).
