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
---
# Get started with Remote Desktop on Mac

>Applies To: Windows 10, Windows 8.1, Windows Server 2012 R2, Windows Server 2016

Devices running OS 10.7 and newer are supported.

Microsoft Remote Desktop Client gives you the ability to get work done from almost anywhere by providing an easy way to use your mobile device to: 

- Connect to a remote PC to access all of your apps, files, and network resources
- Access published Windows apps hosted on Microsoft Azure

> [!NOTE]
> The information in this article applies primarily to the full version of the Mac client - the version available in the Mac AppStore. The latest Mac client beta does not yet have support for all of the features described below. For more information about the beta and what is available in that client, check out the [beta client release notes](http://go.microsoft.com/fwlink/?LinkID=619698&clcid=0x409).


## Start using the Remote Desktop client on your iOS device
Follow these steps to get started with Remote Desktop on your iOS device:

1. Download the Microsoft Remote Desktop client from the [Mac App Store](https://itunes.apple.com/us/app/microsoft-remote-desktop/id715768417?mt=12&ls=1).
2. Set up your PC to accept remote connections.
3. Create a new Remote Desktop connection or add a remote resource.

A remote desktop connection summarizes all the settings for the remote desktop you want to connect to.

Remote Resources enables access to RemoteApp programs, session-based desktops, and virtual desktops published on-premises using RemoteApp and Desktop Connections. This feature is typically available in corporate environments.

RemoteApp is also available as a cloud-based service that provides access to published applications on Microsoft Azure. For more information, visit the Azure RemoteApp landing page.

## What about the Mac beta client?
We're currently testing a new beta client for Mac. Want to check it out? Go to [http://go.microsoft.com/fwlink/?LinkID=619698&clcid=0x409](http://go.microsoft.com/fwlink/?LinkID=619698&clcid=0x409) and click **Download**. You don't need to create an account or sign into HockeyApp to download the beta client.

If you already have the client, you can check for updates to ensure you have the latest version. In the beta client, click **Microsoft Remote Desktop Beta** at the top, and then click **Check for updates**. 


## Getting to know the Connection Center

After the Remote Desktop Client is installed, start the app, and the connection center will open. You can use the connection center to:

- Connect to a Windows PC or server
- Access on-premises work resources published using RemoteApp and Desktop Connections
- Access apps in the cloud through Azure RemoteApp
- Manage remote desktops
- Modify settings

### Create and edit Remote Desktops

A remote desktop summarizes all the settings for the remote desktop connection.

To create a remote desktop: 
1. In the Connection Center click **New**.
2. Enter the following information for the general settings:
  - Connection name (Optional): The name of the remote desktop in the connection center. This can be any string. If this is field is empty, the PC name will be displayed. 
  - PC name: The name of the PC you want to connect to. This can be a Windows computer name, an Internet domain name, or an IP address. You can also add port information to the PC name, for example: MyDesktop:3389 or 10.0.0.1:3389.
  - Gateway: The Remote Desktop Gateway enables authorized users to connect to virtual desktops, RemoteApp programs, and session-based desktops on an internal corporate network from any Internet-connected device. You can either select a gateway that is already configured, or add a new one. No gateway configured is displayed if no Gateway is selected. How to configure a gateway is explained in the section on the Remote Desktop Gateway. Ask your network administrator for the name of your Remote Desktop Gateway.
  - Credentials: The user name and password to be used for the remote PC you are connecting to. If no credentials are displayed, the log on screen will be displayed after clicking the remote desktop. The user name can be entered in the following formats: user_name, domain\user_name, and user_name@domain.com.
  - Resolution: Select the display resolution for the remote session.
  - Colors: Select the color depth for the remote session.
  - Full screen mode: Choose between the OS X native full screen feature (Mac OS X 10.7+) or the custom full screen mode which enables the multi-monitor feature to provide a better experience for users of Mac OS X versions 10.7 and 10.8..
  - Start session in full screen: The remote session will start using the full screen. Disable this option if you prefer to start a remote desktop connection in windowed mode.
  - Scale content: Enable the aspect ratio to be fixed for the session content.
  - Use all monitors: Enable use of all monitors for the remote session.
3. Set the following session settings:

  - Sound: Select the device to play audio during the remote session. You can configure sound to be played on the local device, the remote PC, or not at all.
  - Connect to admin session: Connect to an administration session on a server running Windows Server 2003 and newer.
  - Forward printing devices: Locally installed printers are available during the remote session.
  - Swap mouse buttons: Whenever a mouse gesture would send a command with the left mouse button, it sends the same command with the right mouse button instead. This is necessary if the remote PC is configured for left-handed mouse mode.
4. Optionally set up redirection, which lets you access local folders during your remote session. Click **+** at the bottom to browse to a folder you want to have redirected.
5. Click **Close** to save the remote desktop.

Need to edit these settings? Right-click the desktop you want to edit, and then click **Edit**. 

To delete a remote desktop, right-click the desktop you want to delete, and then click **Delete**. Click **Yes**.

To copy a remote desktop, right-click the remote desktop you want to make a copy of, and then click **Duplicate**.

## Export remote desktops
You can export a remote desktop for use on a different device. Remote desktops are saved in separate .RDP files.

1. In the Connection Center, right-click the remote desktop.
2. Click **Export**.
3. Browse to the location where you want to save the remote desktop .RDP file.
4. Click **OK**.

## Import remote desktops
Use the following steps to import a remote desktop .RDP file.

1. In the menu bar, click **File > Import**.
2. Browse to the .RDP file.
3. Click **Open**.

## Search remote desktops
If you have a lot of remote desktop connections, you might want to take advantage of the search feature.

To search for a remote desktop connection, type some of the text in the PC name or the connection name to filter the remote desktops list.

## Rearrange remote desktops
Depending on your environment, the list of remote desktops can get quite long. The remote desktops in this list can be rearranged to bring frequently used remote desktops to the top of the list and remote desktops that are used less frequently can be moved towards the bottom of the list.

To move a remote desktop connection, click and hold the connection. Then drag and drop it to a new position in the list.

## Manage preferences
You can update the gateway and resolution settings for all connections.

To update preferences, click **Preferences** in the connection center.

You can select, configure, or add a gateway. You can also select the display resolution for remote desktop sessions.

## Remote Desktop gateway

A Remote Desktop Gateway (RD Gateway) lets authorized users connect to a remote computer on a corporate network from anywhere on the Internet. You can create and manage your gateways using the Remote Desktop client.

To set up a new gateway:

1. In the Connection Center, click **Preferences**.
2. Click **Gateway**. 
3. Enter the following information:
  - **Gateway name** - The name to display for the gateway. This can be any string. If you don't specify a name, the server name will be used.
  - **Server name** – The name of the computer you want to use as a gateway. This can be a Windows computer name, an Internet domain name, or an IP address. You can also add port information to the server name (for example: **RDGateway:443** or **10.0.0.1:443**).
  - **User name** - The user name and password to be used for the Remote Desktop gateway you are connecting to. If you don't provide a user name and password, the credentials for the remote desktop connection are used.
  - **Password** - the password for the RD Gateway you are connecting to.
4. Click **+** to add the gateway, and then click **close**.

To delete a gateway:

1. In the Connection Center, click **Preferences**.
2. Click **Gateway**. 
3. Select the gateway, click **-**, and then click **close**.

## Resolution
You can specify the display resolution for the remote desktop session.

1. In the Connection Center, click **Preferences**.
2. Click **Resolution**. 
3. Click **+**.
4. Enter a resolution height and width, and then click **OK.**

To delete the resolution, select it, and then click **-**.

**Displays have separate spaces**
Mac OS X 10.9 users who have disabled **Displays have separate spaces** in Mavericks (**System Preferences > Mission Control**) need to configure this setting in the remote desktop client using the same option.

## Remote resources
Remote resources are RemoteApp programs, session-based desktops, and virtual desktops published using RemoteApp and Desktop Connections.

- The URL displays the link to the RD Web Access server enabling access to RemoteApp and Desktop Connections.
- The configured RemoteApp and Desktop Connections are listed.

To add remote resources:

1. In the Connection Center, click **Remote Resources**. 
2. Enter information for the remote resource:
   - **URL** - The URL of the RD Web Access server.
   - **User name** - The user name to use for the RD Web Access server you are connecting to.
   - **Password** - The password to use for the RD Web Access server you are connecting to.
3. Click **Refresh**, and then click **close**.

The remote resources will be displayed in the Connection Center.


To delete remote resources:

1. In the Connection Center, press and hold any of the applications or desktops in the remote resources or the name of the application feed.
2. Tap **Settings** on the URL name.
2. Tap **Delete**.
3. Confirm the deletion.

### Drive redirection for remote resources
Drive redirection is supported for remote resources, so that you can save files created with a remote application locally to your Mac. The redirected folder is always your home directory displayed as a network drive in the remote session.

> [!NOTE]
> In order to use this feature, the administrator needs to set the appropriate settings on the server.


## Navigating the Remote Desktop Session
When you start a remote desktop connection, there are tools available that you can use to navigate the session.

### Start a Remote Desktop Connection or remote resource

To start a connection, double-click the connection or remote application.

If you are in full screen mode, the menu bar at the top of the screen is hidden. This remote connection menu bar includes tools you can use to navigate the session.

### Remote Desktop Menu bar

- Microsoft Remote Desktop: This menu enables you to manage the remote desktop session.
- Window: Enables you to manage the windows.
- Help: View web-based help.

### Remote Resource Menu bar

- Microsoft Remote Desktop: This menu enables you to manage the remote desktop session.
- Remote Desktop Client: Right-click the remote desktop client icon in the menu bar to switch between active applications. You can also right-click the Remote Desktop Client icon in the dock to switch between applications.

### Mac and Windows keyboard layouts

Mac keyboard layouts differ from the Windows keyboard layouts. The OS keyboard locale is suggested to the remote PC. If the OS keyboard locale is not used, we recommend checking the keyboard setting on the remote PC and changing the setting manually.

- The Command key on the Mac keyboard equals the Windows key.
- To perform actions that use the Command button on the Mac, you will need to use the control button in Windows (e.g.: Copy = Ctrl + C).
- The function keys can be activated in the session by pressing additionally the FN key (e.g.: FN + F1).
- The Alt key to the right of the space bar on the Mac keyboard equals the Alt Gr/right Alt key in Windows.

## Support for Remote Desktop gateway pluggable authentication and authorization

Windows Server 2012 R2 introduced support for a new authentication method, Remote Desktop Gateway pluggable authentication and authorization, which provides more flexibility for custom authentication routines. You can now this authentication model with the Mac client. 

> [!IMPORTANT]
> Custom authentication and authorization models before Windows 8.1 are not supported, although the article above discusses them.

To learn more about this feature, check out [http://aka.ms/paa-sample](http://aka.ms/paa-sample).


> [!TIP]
> Questions and comments are always welcome. However, please do NOT post a request for troubleshooting help by using the comment feature at the end of this article. Instead, go to the [Remote Desktop client forum](http://social.technet.microsoft.com/forums/windowsserver/en-us/home?forum=winrdc) and start a new thread. Have a feature suggestion? Tell us in the [client user voice forum](https://remotedesktop.uservoice.com/forums/272085-remote-desktop-for-android).
