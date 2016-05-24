---
title: Getting Started with Remote Desktop Client on Android
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 96d2ec5b-db4c-4844-aec5-1611f25caa51
author: lizap
---
# Getting Started with Remote Desktop Client on Android
Devices running Android version 4.0.3 and newer are supported.  
  
Microsoft Remote Desktop Client lets you get work done from almost anywhere by providing an easy way to use your mobile device to:  
  
-   Connect to a remote PC to access all of your apps, files, and network resources  
  
-   Access published Windows apps hosted on Microsoft Azure  
  
You can run the client on Android 4.0.3 and newer devices.  
  
## To get started with the Remote Desktop client on your Android device:  
To get started, download the client from [Google Play](https://play.google.com/store/apps/details?id=com.microsoft.rdc.android). Next you need to [configure the remote PC that you want to accept remote connections](https://social.technet.microsoft.com/Forums/en-US/169da213-5173-4552-9005-c7a355c0d12a/connect-to-your-pc-using-microsoft-rdp-apps?forum=winRDc).  
  
Finally, create a Remote Desktop connection to that remote PC or add remote resources. \(Remote resources are RemoteApp programs, session\-based desktops, or virtual desktops.\)  
  
## <a name="BKMK_GTK"></a>Using the Connection Center  
The Connection Center, which you’ll see the first time you run the Remote Desktop app, is where you create and manage your connections. You can use the Connection Center to:  
  
-   Connect to a Windows PC or server  
  
-   Access on\-premises work resources published using RemoteApp and Desktop Connections  
  
-   Access apps in the cloud through Azure RemoteApp  
  
-   Manage remote desktops  
  
-   Modify settings  
  
### <a name="bkmk_createremotedesktop"></a>Create and manage a Remote Desktop connection  
A Remote Desktop connection saves all of the settings for the remote computer that you want to connect to.  
  
1.  In the Connection Center tap **\+**, and then tap **Desktop**.  
  
2.  Enter the following information for the computer you want to connect to:  
  
    -   **PC name** – the name of the computer. This can be a Windows computer name, an Internet domain name, or an IP address. You can also append port information to the PC name \(for example, **MyDesktop:3389** or **10.0.0.1:3389**\).  
  
    -   **User name** – The user name to use to access the remote PC. You can use the following formats: user\_name, domain\\user\_name, or user\_name@domain.com. You can also specify whether to prompt for a user name and password.  
  
3.  You can also set the following additional options:  
  
    -   **Friendly name** – An easy\-to\-remember name for the PC you are connecting to. You can use any string, but if you do not specify a friendly name, the PC name is displayed.  
  
    -   **Gateway** – The Remote Desktop gateway that you want to use to connect to virtual desktops, RemoteApp programs, and session\-based desktops on an internal corporate network. Get the information about the gateway from your system administrator.  
  
        Need to configure a Remote Desktop [Gateway](../Topic/Getting-Started-with-Remote-Desktop-Client-on-Android.md#Android_GW)?  
  
    -   **Sound** – Select the device to use for audio during your remote session. You can choose to play sound on the local devices, the remote device, or not at all.  
  
    -   **Swap mouse buttons** – Use this option to swap the left mouse button functions for the right mouse button. \(This is especially useful if the remote PC is configured for a left\-handed user but you use a right\-handed mouse.\)  
  
    -   **Connect to admin session** \- Use this option to connect to an administration session on a server running Windows Server 2003 or later.  
  
    -   **Redirect to local storage** – Mounts your local storage as a remote file system on the remote PC.  
  
4.  Tap **Save**.  
  
Need to edit these settings? Tap the overflow menu \(**…**\) next to the name of the desktop, and then tap **edit**.  
  
Want to delete the connection? Again, tap the overflow menu \(**…**\), and then tap **remove**.  
  
## <a name="Android_GW"></a>Gateway  
A Remote Desktop Gateway \(RD Gateway\) lets authorized users connect to a remote computer on a corporate network from anywhere on the Internet. You can create and manage your gateways using the Remote Desktop client.  
  
To set up a new gateway:  
  
1.  In the Connection Center, tap **Settings > Gateways**. Tap **\+** to add a new gateway.  
  
2.  Enter the following information:  
  
    -   **Server name** – The name of the computer you want to use as a gateway. This can be a Windows computer name, an Internet domain name, or an IP address. You can also add port information to the server name \(for example: **RDGateway:443** or **10.0.0.1:443**\).  
  
    -   **User name** \-  The user name and password to be used for the Remote Desktop Gateway you are connecting to. You can also select **Use desktop user account** to use the same credentials as those used for the remote desktop connection.  
  
To delete a gateway:  
  
1.  In the Connection Center, tap **Settings > Gateways**.  
  
2.  Tap and hold a gateway in the list to select it.  
  
    You can select multiple gateways.  
  
3.  Tap the trash can to delete the selected gateway.  
  
## User management  
When you connect to a desktop or remote resources, you can save the user accounts to select from again. You can also define user accounts in the client itself, as opposed to saving the user data when you connect to a desktop.  
  
To create a new user account:  
  
1.  In the Connection Center, tap **Settings**, and then tap **User accounts**.  
  
2.  Tap **\+** to add a new user account.  
  
3.  Enter the following information:  
  
    -   **User Name** \- The name of the user to save for use with a remote connection. You can enter the user name in any of the following formats: user\_name, domain\\user\_name, or user\_name@domain.com.  
  
    -   **Password** \- The password for the user you specified. Every user account that you want to save to use for remote connections needs to have a password associated with it.  
  
4.  Tap **Save**.  
  
To delete a user account:  
  
1.  In the Connection Center, tap **Settings > User accounts**.  
  
2.  Tap and hold a user account in the list to select it.  
  
    You can select multiple users.  
  
3.  Tap the trash can to delete the selected user.  
  
## <a name="bkmk-RemRes1"></a>Remote Resources  
Remote Resources are RemoteApp programs, session\-based desktops, and virtual desktops published using RemoteApp and Desktop Connections.  
  
To add Remote Resources:  
  
1.  On the Connection Center screen, tap **\+**, and then tap **Remote Resources Feed**.  
  
2.  Enter information for the Remote Resource:  
  
    -   **Email or URL** \- The URL of the RD Web Access server. You can also enter your corporate email account in this field – this tells the client to search for the RD Web Access Server associated with your email address.  
  
    -   **User name** \- The user name to use for the RD Web Access server you are connecting to.  
  
    -   **Password** \- The password to use for the RD Web Access server you are connecting to.  
  
3.  Tap **Save**.  
  
    The remote resources will be displayed in the Connection Center.  
  
To delete Remote Resources:  
  
1.  In the Connection Center, tap the overflow menu \(**…**\) next to the remote resource.  
  
2.  Tap **Remove**.  
  
3.  Confirm the deletion.  
  
## Widgets – Pin a saved desktop to your home screen  
The Remote Desktop applications support pinning connections to your home screen by using the Android widget feature. The way that you add a widget depends on the type of Android device you are using and its operating system. Here is the most common way to add a widget:  
  
1.  Tap **apps** to launch the apps menu.  
  
2.  Tap **widgets**.  
  
3.  Swipe through the widgets and look for the remote desktop icon with the description, “Pin Remote Desktop.”  
  
4.  Tap and hold that Remote Desktop widget and move it to the home screen.  
  
5.  When you release the icon, you’ll see the saved remote desktops. Choose the connection that you want to save to your home screen.  
  
Now you can start the remote desktop connection directly from your home screen by tapping it.  
  
> [!NOTE]  
> If you rename the desktop connection in the Remote Desktop application, the label of this pinned remote desktop will not update.  
  
## Navigating the Remote Desktop Session  
When you start a remote desktop connection, there are tools available that you can use to navigate the session.  
  
**Start a Remote Desktop Connection**  
  
1.  Tap the remote desktop connection to start the remote desktop session.  
  
2.  If you are asked to verify the certificate for the remote desktop, tap **Connect**. You can also select **Don’t ask me again for connections to this computer** to always accept the certificate.  
  
**Connection Bar**  
  
The connection bar gives you access to additional navigation controls. By default, the connection bar is placed in the middle at the top of the screen. Double\-tap and drag the bar to the left or right to move it.  
  
-   Pan Control: The pan control enables the screen to be enlarged and moved around.  
  
    > [!NOTE]  
    > The pan control is available using direct touch only.  
  
    -   Enable \/ Disable the pan control: Tap the pan icon in the connection bar to display the pan control and zoom the screen. Tap the pan icon in the connection bar again to hide the control and return the screen to its original resolution.  
  
    -   Use the pan control: Tap and hold the pan control and then drag in the direction you want to move the screen.  
  
    -   Move the pan control: Double tap and hold the pan control to move the control on the screen.  
  
-   Connection name: The current connection name is displayed. Tap the connection name to display the session selection bar and command bar \(see below\).  
  
-   Keyboard: Tap the keyboard icon to display or hide the keyboard. The pan control is displayed automatically when the keyboard is displayed.  
  
-   Move the connection bar: Tap and hold the connection bar, and then drag and drop to a new location at the top of the screen.  
  
**Session selection**  
  
Tap the connection bar to display the session selection bar on the left\-hand side of the screen. The session selection bar enables you to view your open connections and switch between them.  
  
You can also launch new session or apps from your connection center.  
  
-   Switch between apps in an open remote resource session  
  
    When you are connected to remote resources, you can switch between open applications within that session by tapping the expander menu and choosing from the list of available items.  
  
-   Start a new session  
  
    You can start new applications or desktop sessions from within your current connection: tap **Start New**, and then choose from the list of available items.  
  
-   Disconnection a session  
  
    To disconnect a session tap **X** in the left\-hand side of the session tile.  
  
**Command bar**  
  
Tap the connection bar to display the command bar on the right\-hand side of the screen. You can switch between the mouse modes \(Direct Touch and Mouse Pointer\). Use the home button to return to the connection center from the command bar. Alternatively you can use the back button for the same action. Your active session will not be disconnected.  
  
You can get to the command bar by a tap on the session bar.  
  
**Direct touch gestures and mouse modes**  
  
The client uses standard touch gestures. You can also use touch gestures to replicate mouse actions on the remote desktop. The mouse modes available are defined in the table below.  
  
> [!NOTE]  
> Interacting with Windows 8 or newer the native touch gestures are supported in Direct Touch mode. For more information on Windows 8 gestures see [Touch: Swipe, tap, and beyond](http://windows.microsoft.com/windows-8/touch-swipe-tap-beyond).  
  
|Mouse mode|Mouse operation|Gesture|  
|--------------|-------------------|-----------|  
|Direct touch|Left click|1 finger tap|  
|Direct touch|Right click|1 finger tap and hold|  
|Mouse pointer|Zoom|Use two fingers and pinch to zoom in or move fingers apart to zoom out.|  
|Mouse pointer|Left click|1 finger tap|  
|Mouse pointer|Left click and drag|1 finger double tap and hold, then drag|  
|Mouse pointer|Right click|2 finger tap|  
|Mouse pointer|Right click and drag|2 finger double tap and hold, then drag|  
|Mouse pointer|Mouse wheel|2 finger tap and hold, then drag up or down|  
  
## <a name="BKMK_LINKS"></a>See also  
The following list provides additional resources for using Remote Desktop mobile clients.  
  
-   **Android:** [Remote Desktop Client on Android: FAQ](assetId:///71de3651-276b-4f90-b025-3b0ad5bf9f62)  
  
-   **iPad or iOS:** [Remote Desktop Client on iOS: FAQ](assetId:///ac7f2646-695d-48c6-8892-479c1f824225)  
  
-   **Mac:** [Remote Desktop Client on Mac: FAQ](../Topic/Remote-Desktop-Client-on-Mac--FAQ.md)  
  
-   **Windows 8:** [Remote Desktop Connection: FAQ](http://windows.microsoft.com/windows-8/remote-desktop-connection-frequently-asked-questions)  
  
> [!TIP]  
> **Questions and comments are always welcome. However, please do NOT post a request for troubleshooting help by using the comment feature at the end of this article. Instead, go to the**[Remote Desktop client forum](http://social.technet.microsoft.com/Forums/windowsserver/en-US/home?forum=winRDc)**and start a new thread. Have a feature suggestion? Tell us in the**[client user voice forum](https://remotedesktop.uservoice.com/forums/272085-remote-desktop-for-android).  
  
