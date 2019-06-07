---
title: Get started with Remote Desktop on Windows
description: Basic set up steps for the Remote Desktop client for Windows.
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
ms.date: 05/07/2018
ms.localizationpriority: medium
---
# Get started with Remote Desktop on Windows

>Applies to: Windows 10, Windows 8.1, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

You can use the Remote Desktop client for Windows to work with Windows apps and desktops remotely from a different Windows device.

Use the following information to get started. Be sure to check out the [FAQ](remote-desktop-client-faq.md) if you have any questions.

> [!NOTE]
> - Curious about the new releases for the Windows client? Check out [What's new for Remote Desktop on Windows?](windows-whatsnew.md)
> - You can run the client on any version of Windows 10.

## Get the RD client and start using it

Follow these steps to get started with Remote Desktop on your Windows 10 device:

1. Download the Remote Desktop client from [Microsoft Store](https://www.microsoft.com/store/p/microsoft-remote-desktop/9wzdncrfj3ps). 
2. [Set up your PC to accept remote connections](remote-desktop-allow-access.md).
3. Add a Remote Desktop connection or a remote resource. You use a connection to connect directly to a Windows PC and a remote resource to use a RemoteApp program, session-based desktop, or virtual desktop published by your admin. 
4. Pin items so you can get to Remote Desktop quickly.

### Add a Remote Desktop connection

To create a Remote Desktop connection:

1. In the Connection Center tap **+ Add**, and then tap **Desktop**.
2. Enter the following information for the computer you want to connect to:
   - **PC name** – the name of the computer. This can be a Windows computer name, an Internet domain name, or an IP address. You can also append port information to the PC name (for example, **MyDesktop:3389** or **10.0.0.1:3389**).
   - **User account** – The user account to use to access the remote PC. Tap **+** to add a new account or select an existing account. You can use the following formats for the username: *user_name*, *domain\user_name*, or <em>user_name@domain.com</em>. You can also specify whether to prompt for a user name and password during the connection by selecting **Ask me every time**.
3. You can also set additional options by tapping on **Show more**:
   - **Display name** – An easy-to-remember name for the PC you are connecting to. You can use any string, but if you do not specify a friendly name, the PC name is displayed.
   - **Group** – Specify a group to make it easier to find your connections later. You can add a new group by tapping **+** or select one from the list.
   - **Gateway** – The Remote Desktop gateway that you want to use to connect to virtual desktops, RemoteApp programs, and session-based desktops on an internal corporate network. Get the information about the gateway from your system administrator.
   - **Connect to admin session** - Use this option to connect to a console session to administrate a Windows server.
   - **Swap mouse buttons** – Use this option to swap the left mouse button functions for the right mouse button. (This is especially useful if the remote PC is configured for a left-handed user but you use a right-handed mouse.)
   - **Set my remote session resolution to:** – Select the resolution you want to use in the session. **Choose for me** will set the resolution based on the size of the client.
   - **Change the size of the display:** – When selecting a high static resolution for the session, you have the option to make items on the screen appear larger to improve readability. Note: This only applies when connecting to Windows 8.1 or above.
   - **Update the remote session resolution on resize** – When enabled, the client will dynamically update the session resolution based on the size of the client. Note: This only applies when connecting to Windows 8.1 or above.
   - **Clipboard** – When enabled, allows you to copy text and images to/from the remote PC.
   - **Audio Playback** – Select the device to use for audio during your remote session. You can choose to play sound on the local devices, the remote PC, or not at all.
   - **Audio Recording** – When enabled, allows you to use a local microphone with applications on the remote PC.
4. Tap **Save**.

Need to edit these settings? Tap the overflow menu (**...**) next to the name of the desktop, and then tap **Edit**.

Want to delete the connection? Again, tap the overflow menu (**...**), and then tap **Remove**.

### Add a remote resource
Remote resources are RemoteApp programs, session-based desktops, and virtual desktops published by your admin using Remote Desktop Services.

To add a remote resource:

1. On the Connection Center screen, tap **+ Add**, and then tap **Remote resources**. 
2. Enter the **Feed URL** provided by your admin and tap **Find feeds**.
3. When prompted, provide the credentials to use to subscribe to the feed.

The remote resources will be displayed in the Connection Center.


To delete remote resources:

1. In the Connection Center, tap the overflow menu (**...**) next to the remote resource.
2. Tap **Remove**.

### Pin a saved desktop to your Start menu

To pin a connection to your Start menu, tap the overflow menu (**...**) next to the name of the desktop, and then tap **Pin to Start**.

Now you can start the remote desktop connection directly from your Start menu by tapping it.

## Connect to an RD Gateway to access internal assets

A Remote Desktop Gateway (RD Gateway) lets you connect to a remote computer on a corporate network from anywhere on the Internet. You can create and manage your gateways using the Remote Desktop client.

To set up a new gateway:

1. In the Connection Center, tap **Settings**.
2. Next to Gateway, tap **+** to add a new gateway. Note: A gateway can also be added when adding a new connection.
3. Enter the following information:
   - **Server name** – The name of the computer you want to use as a gateway. This can be a Windows computer name, an Internet domain name, or an IP address. You can also add port information to the server name (for example: **RDGateway:443** or **10.0.0.1:443**).
   - **User account** - Select or add a user account to use with the Remote Desktop Gateway you are connecting to. You can also select **Use desktop user account** to use the same credentials as those used for the remote desktop connection.
4. Tap **Save**.  

## Global app settings

You can set the following global settings in your client by tapping **Settings**:

MANAGED ITEMS
- **User account** - Allows you to Add, edit and delete user accounts saved in the client. This is a good way to update the password for an account after it has changed.
- **Gateway** - Allows you to Add, edit and delete gateway servers saved in the client.
- **Group** - Allows you to Add, edit and delete groups saved in the client. These allow you to easily group connections.

SESSION SETTINGS
- **Start connections in full screen** - When enabled, anytime a connection is launched, the client will use the entire screen of the current monitor.
- **Start each connection in a new window** - When enabled, each connection is launched in a separate window, allowing you to place them on different monitors and switch between them using the taskbar.
- **When resizing the app:** - Allows you control over what happens when the client window is resized. Defaults to **Stretch the content, preserving aspect ratio**.
- **Use keyboard commands with:** - Let's you specify where keyboard commands like *WIN* or *ALT+TAB* are used. The default is to only send them to the session when the connection is in full scren.
- **Prevent the screen from timing out** - Allows you to keep the screen from timing out when a session is active. This is helpful when the connection does not require any interaction for long periods of time.

APP SETTINGS
- **Show Desktop Previews** - Lets you see a preview of a desktop in the Connection Center before you connect to it. By default, this is set to **on**.
- **Help improve Remote Desktop** - Sends anonymous data to Microsoft. We use this data to improve the client. To learn more about how we treat this anonymous, private data, see the [Microsoft Privacy Statement](https://privacy.microsoft.com/en-us/privacystatement). By default, this setting is **on**.

### Manage your user accounts

When you connect to a desktop or remote resources, you can save the user accounts to select from again. You can also define user accounts in the client itself, as opposed to saving the user data when you connect to a desktop.

To create a new user account:

1. In the Connection Center, tap **Settings**.
2. Next to User account, tap **+** to add a new user account.
3. Enter the following information:
   - **Username** - The name of the user to save for use with a remote connection. You can enter the user name in any of the following formats: user_name, domain\user_name, or user_name@domain.com.
   - **Password** - The password for the user you specified. This can be left blank to be prompted for a password during the connection.
4. Tap **Save**.

To delete a user account:

1. In the Connection Center, tap **Settings**.
2. Select the account to delete from the list under User account.
3. Next to User account, tap the edit icon.
4. Tap **Remove this account** at the bottom to delete the user account.
5. You can also edit the user account and tap **Save**.

## Navigate the Remote Desktop session
When you start a remote desktop connection, there are tools available that you can use to navigate the session.

### Start a Remote Desktop connection

1. Tap the Remote Desktop connection to start the session.
2. If you haven't saved credentials for the connection, you will be prompted to provide a **Username** and **Password**.
3. If you are asked to verify the certificate for the remote desktop, review the information and ensure this is a PC you trust before tapping **Connect**. You can also select **Don’t ask about this certificate again** to always accept this certificate.

### Connection Bar

The connection bar gives you access to additional navigation controls. By default, the connection bar is placed in the middle at the top of the screen. Tap and drag the bar to the left or right to move it.

- **Pan Control** - The pan control enables the screen to be enlarged and moved around. Note that pan control is only available on touch-enabled devices and using the direct touch mode.
   - Enable / Disable the pan control: Tap the pan icon in the connection bar to display the pan control and zoom the screen. Tap the pan icon in the connection bar again to hide the control and return the screen to its original resolution.
   - Use the pan control - Tap and hold the pan control and then drag in the direction you want to move the screen.
   - Move the pan control - Double tap and hold the pan control to move the control on the screen.
- **Additional options** - Tap the additional options icon to display the session selection bar and command bar (see below).
- **Keyboard** - Tap the keyboard icon to display or hide the on-screen keyboard. The pan control is displayed automatically when the keyboard is displayed.

### Command bar

Tap the **...** on the connection bar to display the command bar on the right-hand side of the screen.

- **Home** - Use the Home button to return to the connection center from the command bar.
  - Alternatively you can use the back button for the same action.
  - Your active session will not be disconnected.
  - This allows you to launch additional connections.
- **Disconnect** - Use the Disconnect button to terminate the connection.
  - Your apps will remain active as long as the session is not terminated on the remote PC.
- **Full-screen** - Enters or exits full screen mode.
- **Touch / Mouse** -  You can switch between the mouse modes (Direct Touch and Mouse Pointer).

### Use direct touch gestures and mouse modes in a remote session

Two mouse modes are available to interact with the session.
- **Direct touch**: Passes all of the touch contacts to the session to be interpreted remotely.
  - Used in the same way you would use Windows with a touch screen.
- **Mouse pointer**: Transforms your local touch screen into a large touchpad allowing to move a mouse pointer in the session.
  - Used in the same way you would use Winodws with a touchpad.

> [!NOTE]
> Interacting with Windows 8 or newer the native touch gestures are supported in Direct Touch mode. 

| Mouse mode    | Mouse operation      | Gesture                                                               |
|---------------|----------------------|-----------------------------------------------------------------------|
| Direct touch  | Left click           | 1 finger tap                                                          |
| Direct touch  | Right click          | 1 finger tap and hold                                                 |
| Mouse pointer | Left click           | 1 finger tap                                                          |
| Mouse pointer | Left click and drag  | 1 finger double tap and hold, then drag                               |
| Mouse pointer | Right click          | 2 finger tap                                                          |
| Mouse pointer | Right click and drag | 2 finger double tap and hold, then drag                               |
| Mouse pointer | Mouse wheel          | 2 finger tap and hold, then drag up or down                           |
| Mouse pointer | Zoom                 | Use 2 fingers and pinch to zoom in or move fingers apart to zoom out. |

> [!TIP]
> Questions and comments are always welcome. However, please do NOT post a request for troubleshooting help by using the comment feature at the end of this article. Instead, go to the [Remote Desktop client forum](https://social.technet.microsoft.com/forums/windowsserver/en-us/home?forum=winrdc) and start a new thread. Have a feature suggestion? Tell us using the [Feedback Hub](feedback-hub://?tabid=2&contextid=605).
