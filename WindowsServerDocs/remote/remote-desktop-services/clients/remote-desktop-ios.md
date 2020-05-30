---
title: Get started with the iOS client
description: Learn how to set up the Remote Desktop client for iOS
ms.prod: windows-server
ms.technology: remote-desktop-services
ms.topic: article
ms.assetid: 03ec5a3d-d3f2-4afd-9405-ae58b6ecc91c
author: Heidilohr
manager: lizross
ms.author: helohr
date: 05/06/2020
ms.localizationpriority: medium
---
# Get started with the iOS client

>Applies to: Windows 10, Windows 8.1, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

You can use the Remote Desktop client for iOS to work with Windows apps, resources, and desktops from your iOS device (iPhones and iPads).

Use the following information to get started. Be sure to check out the [FAQ](remote-desktop-client-faq.md) if you have any questions.

> [!NOTE]
> - Curious about the new releases for the iOS client? Check out [What's new for Remote Desktop on iOS?](ios-whatsnew.md)
> - The iOS client supports devices running iOS 6.x and newer.

## Get the Remote Desktop client and start using it

### Download the Remote Desktop client from the iOS store

Follow these steps to get started with Remote Desktop on your iOS device:

1. Download the Microsoft Remote Desktop client from the [iOS App Store](https://aka.ms/rdios) or [iTunes](https://itunes.apple.com/app/microsoft-remote-desktop/id714464092?mt=8).
2. [Set up your PC to accept remote connections](remote-desktop-client-faq.md#how-do-i-set-up-a-pc-for-remote-desktop).
3. Add a [PC](#add-a-pc) or a [workspace](#add-a-workspace). You use a connection to connect to a directly to a Windows PC and a remote resource to use a RemoteApp program, session-based desktop, or a virtual desktop published on-premises using RemoteApp and Desktop Connections. This feature is typically available in corporate environments.

### Add a PC

To add a PC:

1. In the Connection Center tap **+**, and then tap **Add PC**.
2. Enter the following information:
   - **PC name** – the name of the computer. This can be a Windows computer name, an Internet domain name, or an IP address. You can also append port information to the PC name (for example, **MyDesktop:3389** or **10.0.0.1:3389**).
   - **User name** – The user name to use to access the remote PC. You can use the following formats: *user_name*, *domain\user_name*, or `user_name@domain.com`. You can also select **Ask when required** to be prompted for a user name and password when necessary.
3. You can also set the following additional options:
   - **Friendly name (optional)** – An easy-to-remember name for the PC you're connecting to. You can use any string, but if you don't specify a friendly name, the PC name is displayed instead.
   - **Gateway (optional)** – The Remote Desktop gateway that you want to use to connect to virtual desktops, RemoteApp programs, and session-based desktops on an internal corporate network. Get the information about the gateway from your system administrator.
   - **Sound** – Select the device to use for audio during your remote session. You can choose to play sound on the local devices, the remote device, or not at all.
   - **Swap mouse buttons** – Whenever a mouse gesture would send a command with the left mouse button, it sends the same command with the right mouse button instead. This is necessary if the remote PC is configured for left-handed mouse mode.
   - **Admin Mode** - Connect to an administration session on a server running Windows Server 2003 or later.
   - **Clipboard** - Choose whether to redirect text and images in your clipboard to your PC.
   - **Storage** - Choose whether to redirect storage to your PC.
4. Tap **Save**.

Need to edit these settings? Press and hold the desktop you want to edit, and then tap the settings icon.

### Add a workspace

To get a list of managed resources you can access on your iOS, add a workspace by subscribing to the feed provided by your admin.

To add a workspace:

1. On the Connection Center screen, tap **+**, and then tap **Add workspace**.
2. In the Feed URL field, enter the URL for the feed you want to add. This can be either a URL or an email address.
   - If you use a URL, use the one your admin gave you. This URL is usually <https://rdweb.wvd.microsoft.com>.
   - If you use an email address, enter your email address. This tells the client ot search for a URL associated with your email address if your admin configured the server that way.
3. Tap **Next**.
4. Provide your credentials when prompted.
   - For **User name**, give the user name of an account with permission to access resources.
   - For **Password**, give the password for the account.
   - You may also be prompted to give additional information depending on the settings your admin configured authentication with.
5. Tap **Save**.

After this, the Connection Center should display the remote resources.

Once subscribed to a feed, the feed's content will update automatically on a regular basis. Resources may be added, changed, or removed based on changes made by your administrator.

## Manage your user accounts

When you connect to a PC or workspace, you can save the user accounts to select from again.

To create a new user account:

1. In the Connection Center, tap **Settings**, and then tap **User Accounts**.
2. Tap **Add User Account**.
3. Enter the following information:
   - **User Name** - The name of the user to save for use with a remote connection. You can enter the user name in any of the following formats: user_name, domain\user_name, or user_name@domain.com.
   - **Password** - The password for the user you specified.
4. Tap **Save**.

To delete a user account:

1. In the Connection Center, tap **Settings**, and then tap **User Accounts**.
2. Select the account you would like to delete.
3. Tap **Delete**.

## Connect to an RD Gateway to access internal assets

A Remote Desktop Gateway (RD Gateway) lets you connect to a remote computer on a corporate network from anywhere on the Internet. You can create and manage your gateways using the Remote Desktop client.

To set up a new gateway:

1. In the Connection Center, tap **Settings** > **Gateways**.
2. Tap **Add gateway**.
3. Enter the following information:
   - **Gateway name** – The name of the computer you want to use as a gateway. This can be a Windows computer name, an Internet domain name, or an IP address. You can also add port information to the server name (for example, **RDGateway:443** or **10.0.0.1:443**).
   - **User name** - The user name and password to be used for the Remote Desktop gateway you're connecting to. You can also select **Use connection credentials** to use the same user name and password as those used for the remote desktop connection.

## Navigate the Remote Desktop session

When you start a remote desktop session, there are tools available that you can use to navigate the session.

### Start a Remote Desktop Connection

1. Tap the remote desktop connection to start the remote desktop session.
2. If you are asked to verify the certificate for the remote desktop, tap **Accept**. You can choose to always accept by sliding the  **Don't ask me again for connections to this computer** toggle to **ON**.

### Connection Bar

The connection bar gives you access to additional navigation controls.

- **Pan Control**: The pan control enables the screen to be enlarged and moved around. Note that pan control is only available using direct touch.
   - Enable / Disable the pan control: Tap the pan icon in the connection bar to display the pan control and zoom the screen. Tap the pan icon in the connection bar again to hide the control and return the screen to its original resolution.
   - Use the pan control: Tap and hold the pan control and then drag in the direction you want to move the screen.
   - Move the pan control: Double tap and hold the pan control to move the control on the screen.
- **Connection name**: The current connection name is displayed. Tap the connection name to display the session selection bar.
- **Keyboard**: Tap the keyboard icon to display or hide the keyboard. The pan control is displayed automatically when the keyboard is displayed.
- **Move the connection bar**: Tap and hold the connection bar, and then drag and drop to a new location at the top of the screen.

### Session selection

You can have multiple connections open to different PCs at the same time. Tap the connection bar to display the session selection bar on the left-hand side of the screen. The session selection bar enables you to view your open connections and switch between them.

- Switch between apps in an open remote resource session.

    When you are connected to remote resources, you can switch between open applications within that session by tapping the expander menu and choosing from the list of available items.
- Start a new session

  You can start new applications or desktop sessions from within your current connection: tap **Start New**, and then choose from the list of available items.

- Disconnection a session

  To disconnect a session tap X in the left-hand side of the session tile.

### Command bar

The command bar replaced the Utility bar starting in version 8.0.1. You can switch between the mouse modes and return to the connection center from the command bar.

## Use touch gestures and mouse modes in a remote session

The client uses standard touch gestures. You can also use touch gestures to replicate mouse actions on the remote desktop. The mouse modes available are defined in the table below.

> [!NOTE]
> Interacting with Windows 8 or newer the native touch gestures are supported in Direct Touch mode. For more information on Windows 8 gestures see [Touch: Swipe, tap, and beyond](https://windows.microsoft.com/windows-8/touch-swipe-tap-beyond).

| Mouse mode    | Mouse operation      | Gesture                                                    |
|---------------|----------------------|------------------------------------------------------------|
| Direct touch  | Left click           | 1 finger tap                                               |
| Direct touch  | Right click          | 1 finger tap and hold                                      |
| Mouse pointer | Left click           | 1 finger tap                                               |
| Mouse pointer | Left click and drag  | 1 finger double tap and hold, then drag                    |
| Mouse pointer | Right click          | 2 finger tap                                               |
| Mouse pointer | Right click and drag | 2 finger double tap and hold, then drag                    |
| Mouse pointer | Mouse wheel          | 2 finger tap and hold, then drag up or down                |
| Mouse pointer | Zoom                 | Pinch 2 fingers to zoom in or spread 2 fingers to zoom out |

## Supported input devices

Basic [Bluetooth mouse support](https://support.apple.com/HT210546) is available in iOS 13 and iPadOS as an accessibility feature. Deeper mouse integration in the RD Client is available by using the Swiftpoint GT and ProPoint mice. In addition, external keyboards that are compatible with iOS and iPadOS are also supported.

For more information about device support, see [What's new in the iOS client](ios-whatsnew.md) and the [iOS App Store](https://aka.ms/rdios).

> [!TIP]
> Swiftpoint is offering an [exclusive discount on the ProPoint mouse](https://www.swiftpoint.com/microsoft) for iOS client users.

## Use a keyboard in a remote session

You can use either an on-screen keyboard or physical keyboard in your remote session.

For on-screen keyboards, use the button on the right edge of the bar above the keyboard to switch between the standard and additional keyboard.

If Bluetooth is enabled for your iOS device, the client automatically detects the Bluetooth keyboard.

While certain key combinations might not work as expected in a remote session, many of the common Windows key combinations, such as CTRL+C, CTRL+V, and ALT+TAB will work.

> [!IMPORTANT]
> Questions and comments are always welcome. However, please do NOT post a request for troubleshooting help by using the comment feature at the end of this article. Instead, go to the [Remote Desktop client forum](https://social.technet.microsoft.com/forums/windowsserver/en-us/home?forum=winrdc) and start a new thread. Have a feature suggestion? Tell us in the [client user voice forum](https://remotedesktop.uservoice.com/forums/272085-remote-desktop-for-android).
