---
title: Get started with Remote Desktop on Mac
description: Learn how to set up the Remote Desktop client for Mac
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7afc65f8-3158-49c9-9d48-4dab1c69afba
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 07/17/2017
---
# Get started with Remote Desktop on Mac

>Applies To: Windows 10, Windows 8.1, Windows Server 2012 R2, Windows Server 2016

You can use the Remote Desktop client for Mac to work with Windows apps, resources, and desktops from your Mac computer. Use the following information to get started - and check out the [FAQ](remote-desktop-client-faq.md) if you have questions.

>[!Note]
> - The Mac client runs on computers running macOS/OS 10.7 and newer.
> - The information in this article applies primarily to the full version of the Mac client - the version available in the Mac AppStore. The latest Mac client beta does not yet have support for all of the features described below. For more information about the beta and what is available in that client, check out the [beta client release notes](http://go.microsoft.com/fwlink/?LinkID=619698&clcid=0x409).

## Get the Remote Desktop client
Follow these steps to get started with Remote Desktop on your Mac:

1. Download the Microsoft Remote Desktop client from the [Mac App Store](https://itunes.apple.com/us/app/microsoft-remote-desktop/id715768417?mt=12&ls=1).
2. [Set up your PC to accept remote connections](remote-desktop-client-faq.md#how-do-i-set-up-a-pc-for-remote-desktop). (If you skip this step, you can't connect to your PC.)
3. Add a Remote Desktop connection or a remote resource. You use a connection to connect to a directly to a Windows PC and a remote resource to use a RemoteApp program, session-based desktop, or a virtual desktop published on-premises using RemoteApp and Desktop Connections. This feature is typically available in corporate environments.

## What about the Mac beta client?
We're currently testing a new beta client for Mac. Want to check it out? Go to [Microsoft Remote Desktop for Mac](http://go.microsoft.com/fwlink/?LinkID=619698) and click **Download**. You don't need to create an account or sign into HockeyApp to download the beta client.

If you already have the client, you can check for updates to ensure you have the latest version. In the beta client, click **Microsoft Remote Desktop Beta** at the top, and then click **Check for updates**. 

## Add a Remote Desktop connection
To create a remote desktop connection:

1. In the Connection Center, click **+** and then click **Add PC or Server**.
2. Enter the following information:
   - **PC name** - the name of the computer. This can be a Windows computer name (found in the **System** settings), a domain name, or an IP address. You can also add port information to the end of this name, like **MyDesktop:3389**.
   - **User name** - The user name to use to access the remote PC. Use one of these formats: *user_name*, *domain\user_name*, or *user_name@domain.com*. You can also choose whether to require a password. 

3. You can also set these optional settings:
   - Friendly name
   - Gateway
   - Sounds
   - Swap mouse buttons
   - Admin Mode
4. Click **Save**.

To start the connection, just double-click it. The same is true for remote resources.

### Export and import connections
You can export a remote desktop connection definition and use it on a  different device. Remote desktops are saved in separate .RDP files.

1. In the Connection Center, right-click the remote desktop.
2. Click **Export**.
3. Browse to the location where you want to save the remote desktop .RDP file.
4. Click **OK**.

Use the following steps to import a remote desktop .RDP file.

1. In the menu bar, click **File > Import**.
2. Browse to the .RDP file.
3. Click **Open**.

## Add a remote resource
Remote resources are RemoteApp programs, session-based desktops, and virtual desktops published using RemoteApp and Desktop Connections.

- The URL displays the link to the RD Web Access server that gives you access to RemoteApp and Desktop Connections.
- The configured RemoteApp and Desktop Connections are listed.

To add a remote resource:

1. In the Connection Center click **+**, and then click **Add Remote Resources**. 
2. Enter information for the remote resource:
   - **Feed URL** - The URL of the RD Web Access server. You can also enter your corporate email account in this field – this tells the client to search for the RD Web Access Server associated with your email address.
   - **User name** - The user name to use for the RD Web Access server you are connecting to.
   - **Password** - The password to use for the RD Web Access server you are connecting to.
3. Click **Save**.


The remote resources will be displayed in the Connection Center.


## Connect to an RD Gateway to access internal assets

A Remote Desktop Gateway (RD Gateway) lets you connect to a remote computer on a corporate network from anywhere on the Internet. You can create and manage your gateways using the Remote Desktop client.

To set up a new gateway:

1. In the Connection Center, click **Settings > Gateways**. 
2. Click **Add Remote Desktop gateway**.
3. Enter the following information:
  - **Server name** – The name of the computer you want to use as a gateway. This can be a Windows computer name, an Internet domain name, or an IP address. You can also add port information to the server name (for example: **RDGateway:443** or **10.0.0.1:443**).
  - **User name** - The user name and password to be used for the Remote Desktop gateway you are connecting to. You can also select **Use connection credentials** to use the same user name and password as those used for the remote desktop connection.


## Manage your user accounts 

When you connect to a desktop or remote resources, you can save the user accounts to select from again. You can manage your user accounts by using the Remote Desktop client.

To create a new user account:

1. In the Connection Center, click **Settings** > **User Names**.
2. Tap **Add User Account**.
3. Enter the following information:
   - **User Name** - The name of the user to save for use with a remote connection. You can enter the user name in any of the following formats: user_name, domain\user_name, or user_name@domain.com.
   - **Password** - The password for the user you specified. Every user account that you want to save to use for remote connections needs to have a password associated with it.
4. Tap **Save**, and then tap **Settings**.
5. Tap **Done** to save the  new configuration.


## Customize your display resolution
You can specify the display resolution for the remote desktop session.

1. In the Connection Center, click **Preferences**.
2. Click **Resolution**. 
3. Click **+**.
4. Enter a resolution height and width, and then click **OK.**

To delete the resolution, select it, and then click **-**.

**Displays have separate spaces**
If you are running Mac OS X 10.9 and disabled **Displays have separate spaces** in Mavericks (**System Preferences > Mission Control**), you need to configure this setting in the remote desktop client using the same option.

### Drive redirection for remote resources
Drive redirection is supported for remote resources, so that you can save files created with a remote application locally to your Mac. The redirected folder is always your home directory displayed as a network drive in the remote session.

> [!NOTE]
> In order to use this feature, the administrator needs to set the appropriate settings on the server.


## Use a keyboard in a remote session

Mac keyboard layouts differ from the Windows keyboard layouts. 

- The Command key on the Mac keyboard equals the Windows key.
- To perform actions that use the Command button on the Mac, you will need to use the control button in Windows (e.g.: Copy = Ctrl + C).
- The function keys can be activated in the session by pressing additionally the FN key (e.g.: FN + F1).
- The Alt key to the right of the space bar on the Mac keyboard equals the Alt Gr/right Alt key in Windows.

By default, the remote session will use the same keyboard locale as the OS you're running the client on. (If your Mac is running an en-us OS, that will be used for the remote sessions as well. If the OS keyboard locale is not used, check the keyboard setting on the remote PC and changing the setting manually. See the [Remote Desktop Client FAQ](remote-desktop-client-faq.md) for more information about keyboards and locales.


## Support for Remote Desktop gateway pluggable authentication and authorization

Windows Server 2012 R2 introduced support for a new authentication method, Remote Desktop Gateway pluggable authentication and authorization, which provides more flexibility for custom authentication routines. You can now this authentication model with the Mac client. 

> [!IMPORTANT]
> Custom authentication and authorization models before Windows 8.1 are not supported, although the article above discusses them.

To learn more about this feature, check out [http://aka.ms/paa-sample](http://aka.ms/paa-sample).


> [!TIP]
> Questions and comments are always welcome. However, please do NOT post a request for troubleshooting help by using the comment feature at the end of this article. Instead, go to the [Remote Desktop client forum](http://social.technet.microsoft.com/forums/windowsserver/en-us/home?forum=winrdc) and start a new thread. Have a feature suggestion? Tell us in the [client user voice forum](https://remotedesktop.uservoice.com/forums/272085-remote-desktop-for-android).

Not finding content you need? Windows 10 users, tell us what you want on [Feedback Hub](feedback-hub:?tabid=2&contextid=898). 
