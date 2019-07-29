---
title: Get started with Remote Desktop on Android
description: Basic set up steps for the Remote Desktop client for Android.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 64f038e1-40ec-4c67-938b-72edea49e5d8
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 07/24/2018
ms.localizationpriority: medium
---
# Get started with Remote Desktop on Android

>Applies to: Windows 10, Windows 8.1, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

You can use the Remote Desktop client for Android to work with Windows apps and desktops directly from your Android device.

Use the following information to get started. Be sure to check out the [FAQ](remote-desktop-client-faq.md) if you have any questions.

> [!NOTE]
> - Curious about the new releases for the Android client? Check out [What's new for Remote Desktop on Android?](android-whatsnew.md)
> You can run the client on Android 4.1 and newer devices as well as on Chromebooks with ChromeOS 53 installed. Learn more about Android applications on Chrome [here](https://sites.google.com/a/chromium.org/dev/chromium-os/chrome-os-systems-supporting-android-apps).

## Get the RD client and start using it

Follow these steps to get started with Remote Desktop on your Android device:

1. Download the Remote Desktop client from [Google Play](https://play.google.com/store/apps/details?id=com.microsoft.rdc.android). 
2. [Set up your PC to accept remote connections](remote-desktop-allow-access.md).
3. Add a Remote Desktop connection or a remote resource. You use a connection to connect directly to a Windows PC and a remote resource to use a RemoteApp program, session-based desktop, or virtual desktop published on-premises. 
4. Create a widget so you can get to Remote Desktop quickly.

> [!NOTE]
> If you would like to flight new features earlier we recommend downloading our [Microsoft Remote Desktop Beta](https://play.google.com/store/apps/details?id=com.microsoft.rdc.android.beta) application from the Google Play store. 

### Add a Remote Desktop connection

To create a Remote Desktop connection:

1. In the Connection Center tap **+**, and then tap **Desktop**.
2. Enter the following information for the computer you want to connect to:
   - **PC name** – the name of the computer. This can be a Windows computer name, an Internet domain name, or an IP address. You can also append port information to the PC name (for example, **MyDesktop:3389** or **10.0.0.1:3389**).
   - **User name** – The user name to use to access the remote PC. You can use the following formats: *user_name*, *domain\user_name*, or <em>user_name@domain.com</em>. You can also specify whether to prompt for a user name and password.
3. You can also set the following additional options:
   - **Friendly name** – An easy-to-remember name for the PC you are connecting to. You can use any string, but if you do not specify a friendly name, the PC name is displayed.
   - **Gateway** – The Remote Desktop gateway that you want to use to connect to virtual desktops, RemoteApp programs, and session-based desktops on an internal corporate network. Get the information about the gateway from your system administrator.
    Need to configure a Remote Desktop Gateway?
   - **Sound** – Select the device to use for audio during your remote session. You can choose to play sound on the local devices, the remote device, or not at all.
   - **Customize display resolution** - Set a custom resolution for a connection by enabling this setting. When off the resolution is applied which you have defined in the global settings of the app.
   - **Swap mouse buttons** – Use this option to swap the left mouse button functions for the right mouse button. (This is especially useful if the remote PC is configured for a left-handed user but you use a right-handed mouse.)
   - **Connect to admin session** - Use this option to connect to a console session to administrate a Windows server.
   - **Redirect to local storage** – Mounts your local storage as a remote file system on the remote PC.
4. Tap **Save**.

Need to edit these settings? Tap the overflow menu (**...**) next to the name of the desktop, and then tap **edit**.

Want to delete the connection? Again, tap the overflow menu (**...**), and then tap **remove**.

>[!TIP]
> If you get error 0xf07 about a bad password ("We couldn't connect to the remote PC because the password associated with the user account has expired"), change your password and try again.

### Add a remote resource
Remote resources are RemoteApp programs, session-based desktops, and virtual desktops published using RemoteApp and Desktop Connections.

To add a remote resource:

1. On the Connection Center screen, tap **+**, and then tap **Remote Resources Feed**. 
2. Enter information for the Remote Resource:
   - **Email or URL** - The URL of the RD Web Access server. You can also enter your corporate email account in this field – this tells the client to search for the RD Web Access Server associated with your email address.
   - **User name** - The user name to use for the RD Web Access server you are connecting to.
   - **Password** - The password to use for the RD Web Access server you are connecting to.
3. Tap **Save**.

The remote resources will be displayed in the Connection Center.


To delete remote resources:

1. In the Connection Center, tap the overflow menu (**...**) next to the remote resource.
2. Tap **Remove**.
3. Confirm the deletion.

### Widgets – Pin a saved desktop to your home screen

The Remote Desktop applications support pinning connections to your home screen by using the Android widget feature. The way that you add a widget depends on the type of Android device you are using and its operating system. Here is the most common way to add a widget: 

1. Tap **apps** to launch the apps menu.
2. Tap **widgets**.
3. Swipe through the widgets and look for the Remote Desktop icon with the description, “Pin Remote Desktop.”
4. Tap and hold that Remote Desktop widget and move it to the home screen.
5. When you release the icon, you’ll see the saved remote desktops. Choose the connection that you want to save to your home screen.

Now you can start the remote desktop connection directly from your home screen by tapping it.

> [!NOTE]
> If you rename the desktop connection in the Remote Desktop application, the label of this pinned remote desktop will not update.

## Connect to an RD Gateway to access internal assets

A Remote Desktop Gateway (RD Gateway) lets you connect to a remote computer on a corporate network from anywhere on the Internet. You can create and manage your gateways using the Remote Desktop client.

To set up a new gateway:

1. In the Connection Center, tap **Settings > Gateways**. Tap **+** to add a new gateway.
2. Enter the following information:
   - **Server name** – The name of the computer you want to use as a gateway. This can be a Windows computer name, an Internet domain name, or an IP address. You can also add port information to the server name (for example: **RDGateway:443** or **10.0.0.1:443**).
   - **User name** - The user name and password to be used for the Remote Desktop Gateway you are connecting to. You can also select **Use desktop user account** to use the same credentials as those used for the remote desktop connection.

## Manage your user accounts

When you connect to a desktop or remote resources, you can save the user accounts to select from again. You can also define user accounts in the client itself, as opposed to saving the user data when you connect to a desktop.

To create a new user account:

1. In the Connection Center, tap **Settings**, and then tap **User accounts**.
2. Tap **+** to add a new user account.
3. Enter the following information:
   - **User Name** - The name of the user to save for use with a remote connection. You can enter the user name in any of the following formats: user_name, domain\user_name, or user_name@domain.com.
   - **Password** - The password for the user you specified. Every user account that you want to save to use for remote connections needs to have a password associated with it.
4. Tap **Save**.

To delete a user account:

1. In the Connection Center, tap **Settings > User accounts**.
2. Tap and hold a user account in the list to select it. You can select multiple users.
3. Tap the trash can to delete the selected user.

## Navigate the Remote Desktop session
When you start a remote desktop connection, there are tools available that you can use to navigate the session.

### Start a Remote Desktop connection

1. Tap the Remote Desktop connection to start the session. 
2. If you are asked to verify the certificate for the remote desktop, tap **Connect**. You can also select **Don’t ask me again for connections to this computer** to always accept the certificate.

### Manage global app settings

You can set the following global settings in your Android client:

- **Show Desktop Previews** - Lets you see a preview of a desktop in the Connection Center before you connect to it. By default, this is set to **on**.
- **Pinch to Zoom** - Lets you use pinch-to-zoom gestures. If the app you're using through Remote Desktop supports multi-touch (introduced in Windows 8), turn this setting **off**.
- **Help to improve Remote Desktop** - Sends anonymous data to Microsoft. We use this data to improve the client. You can learn more about how we treat this anonymous, private data, see the [Remote Desktop Client Privacy Statement](https://www.microsoft.com/privacystatement/RemoteApp/Default.aspx). By default, this setting is **on**.
- **Display** - There are two global settings for your display:
  - **Orientation** - Sets the preferred orientation (landscape or portrait) for your session. 
    >[!NOTE]
    > If you connect to a PC running Windows 8 or an older version of Windows, the session won't scale correctly. Your best bet is to disconnect from the PC, and then reconnect in the orientation you want to use. An even better option is to upgrade the PC to at least Windows 8.1.

  - **Resolution** - Sets the resolution you want to use for desktop connections globally. If you have already set a custom resolution for an individual app or connection, this setting won't change that.
    >[!NOTE]
    >When you change one of the display settings, they only apply to new connections from that point on. To see the change in a session you're already connected to disconnect and then connect again.

### Connection Bar

The connection bar gives you access to additional navigation controls. By default, the connection bar is placed in the middle at the top of the screen. Double-tap and drag the bar to the left or right to move it.

- **Pan Control**: The pan control enables the screen to be enlarged and moved around. Note that pan control is only available using direct touch.
   - Enable / Disable the pan control: Tap the pan icon in the connection bar to display the pan control and zoom the screen. Tap the pan icon in the connection bar again to hide the control and return the screen to its original resolution.
   - Use the pan control: Tap and hold the pan control and then drag in the direction you want to move the screen.
   - Move the pan control: Double tap and hold the pan control to move the control on the screen.
- **Additional options**: Tap the additional options icon to display the session selection bar and command bar (see below).
- **Keyboard**: Tap the keyboard icon to display or hide the keyboard. The pan control is displayed automatically when the keyboard is displayed.
- **Move the connection bar**: Tap and hold the connection bar, and then drag and drop to a new location at the top of the screen.


### Command bar

Tap the connection bar to display the command bar on the right-hand side of the screen. You can switch between the mouse modes (Direct Touch and Mouse Pointer). Use the home button to return to the connection center from the command bar. Alternatively you can use the back button for the same action. Your active session will not be disconnected. 


### Use direct touch gestures and mouse modes in a remote session

The client uses standard touch gestures. You can also use touch gestures to replicate mouse actions on the remote desktop. The mouse modes available are defined in the table below.

> [!NOTE]
> Interacting with Windows 8 or newer the native touch gestures are supported in Direct Touch mode. 

| Mouse mode    | Mouse operation      | Gesture                                                               |
|---------------|----------------------|-----------------------------------------------------------------------|
| Direct touch  | Left click           | 1 finger tap                                                          |
| Direct touch  | Right click          | 1 finger tap and hold                                                 |
| Mouse pointer | Zoom                 | Use 2 fingers and pinch to zoom in or move fingers apart to zoom out. |
| Mouse pointer | Left click           | 1 finger tap                                                          |
| Mouse pointer | Left click and drag  | 1 finger double tap and hold, then drag                               |
| Mouse pointer | Right click          | 2 finger tap                                                          |
| Mouse pointer | Right click and drag | 2 finger double tap and hold, then drag                               |
| Mouse pointer | Mouse wheel          | 2 finger tap and hold, then drag up or down                           |

> [!TIP]
> Questions and comments are always welcome. However, please do NOT post a request for troubleshooting help by using the comment feature at the end of this article. Instead, go to the [Remote Desktop client forum](https://social.technet.microsoft.com/forums/windowsserver/en-us/home?forum=winrdc) and start a new thread. Have a feature suggestion? Tell us in the [client user voice forum](https://remotedesktop.uservoice.com/forums/272085-remote-desktop-for-android).
