---
title: Installing and Getting Started with Remote Desktop Client on iOS
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4df6bc7a-1a2d-42f3-9b7c-1486a9e57ac0
author: lizap
---
# Installing and Getting Started with Remote Desktop Client on iOS
Devices running iOS 6.X or newer are supported.  
  
> [!TIP]  
> Remote Desktop Client on iOS is enhanced in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Download the free [Windows Server 2012 R2 trial](http://www.microsoft.com/click/services/Redirect2.ashx?CR_CC=200357983), learn about the [benefits of Windows Server 2012 R2](http://www.microsoft.com/server-cloud/products/windows-server-2012-r2/default.aspx#fbid=FmmGaZKPvKd), and get free [Windows Server online technical training](http://www.microsoft.com/click/services/Redirect2.ashx?CR_CC=200357978).  
  
## Microsoft Remote Desktop Client on iPad and iPhone  
You can use the Remote Desktop Client on your iPad and iPhone to connect to remote resources such as:  
  
-   A remote PC  
  
-   RemoteApp resources published by your organization  
  
-   Cloud\-based Microsoft RemoteApp resources  
  
You can access all of your apps, files, and network resources as if you were sitting in front of your PC.  
  
## To get started with Remote Desktop Client on your iOS device:  
  
1.  Download the Microsoft Remote Desktop Client from [iTunes](https://itunes.apple.com/us/app/microsoft-remote-desktop/id714464092?mt=8).  
  
2.  After the app installs, the license agreement is displayed. Accept the license agreement to use the app. The **Connection Center** screen will open as shown here:  
  
A remote desktop connection summarizes all the settings for the remote desktop you want to connect to.  
  
Remote Resources enables access to RemoteApp programs, session\-based desktops, and virtual desktops published on\-premises using RemoteApp and Desktop Connections. This feature is typically available in corporate environments.  
  
Microsoft RemoteApp is also available as a cloud\-based service that provides access to published applications on Microsoft Azure. For more information, visit the RemoteApp [landing page](http://go.microsoft.com/fwlink/p/?LinkId=396715).  
  
> [!IMPORTANT]  
> For a list of supported Windows versions, see [Remote Desktop Client on iOS: FAQ](assetId:///ac7f2646-695d-48c6-8892-479c1f824225)  
  
## <a name="BKMK_GTK"></a>Using the Connection Center  
The **Connection Center** is where you configure your remote connections and the RDS client general configuration settings. These include:  
  
-   **Add a Remote Desktop** – Use these settings to connect to a remote Windows PC or server.  
  
-   **Add a Remote Resource** – Use these settings to connect to RemoteApp programs, session\-based desktops, and virtual desktops published by your administrator using [RemoteApp and Desktop Connections](http://technet.microsoft.com/library/ee216745.aspx).  
  
-   **Add a Microsoft RemoteApp connection** – Use these settings to connect to the cloud\-based Microsoft RemoteApp service. For more information about RemoteApp on Azure, visit the [RemoteApp landing page](http://go.microsoft.com/fwlink/p/?linkid=396715).  
  
-   **Manage remote desktops**  
  
-   **Modify other Remote Desktop Client settings**  
  
-   **Access your remote desktops and resources**  
  
### Manage General Remote Desktop Client Settings  
Before you can connect to a remote desktop, you will need to configure the RDS client to connect to the remote desktop and configure the remote PC to accept remote connections.  
  
**To add a Remote Desktop to your RDS client**  
  
1.  On the Connection Center screen, tap **New Remote Desktop**.  
  
2.  In the **Remote Desktop** window, there are options in the **Remote PC** and **Settings** sections of the window that you will need to configure.  
  
3.  Enter information about the remote PC:  
  
    **REMOTE PC**  
  
    -   **Connection name** \(Optional\): The name of the remote desktop in the connection center. This can be any string. If this is field is empty, the PC name will be displayed.  
  
    -   **PC name**: The name of the PC you want to connect to. This can be a Windows computer name, an Internet domain name, or an IP address. You can also append port information to the PC name, for example: MyDesktop:3389 or 10.0.0.1:3389.  
  
    -   **User name**: The user name to be used for the remote PC. The user name can be entered in the following formats: user\_name, domain\\user\_name, and user\_name@domain.com.  
  
    -   **Gateway** \(Optional\): The Remote Desktop Gateway enables authorized users to connect to virtual desktops, RemoteApp programs, and session\-based desktops on an internal corporate network from any Internet\-connected device. How to configure a gateway is explained in the section on the Remote Desktop Gateway. Ask your network administrator for the name of your Remote Desktop Gateway.  
  
    > [!NOTE]  
    > For a list of supported Windows versions the RDS client can connect to, see the [Remote Desktop Client on iOS: FAQ](http://technet.microsoft.com/library/dn473015.aspx).  
  
4.  Change the RDS client default settings as needed.  
  
    **Settings:**  
  
    -   **Connect to admin session**: Connect to an admin session on a server running Windows Server 2003 or newer.  
  
    -   **Sound**: Select if audio should be played on the local device, the remote PC, or not at all during your remote desktop session.  
  
    -   **Swap mouse buttons**: If the remote PC is configured for left\-handed mouse mode, you will need to enable this setting so the correct mouse gesture is sent during your remote desktop session.  
  
5.  Tap **Save**.  
  
**To configure your PC to allow remote connections**  
  
-   Configure your computer running [Windows Vista](http://windows.microsoft.com/windows/connect-using-remote-desktop-connection#connect-using-remote-desktop-connection=windows-vista).  
  
-   Configure your computer running [Windows 7](http://windows.microsoft.com/windows/connect-using-remote-desktop-connection#connect-using-remote-desktop-connection=windows-7).  
  
-   Configure your computer running [Windows 8](http://windows.microsoft.com/windows/remote-desktop-app-faq#1TC=windows-8).  
  
### Editing, deleting, and rearranging Remote Desktops  
After you have created remote desktop connections in the RDS client, you can edit, delete, or rearrange them as needed.  
  
**To edit a Remote Desktop connection**  
  
To change the settings of a specific remote desktop, tap the information icon to the right of the remote desktop name and update the settings as needed. **To delete a Remote Desktop connection**  
  
1.  On the **Connection Center** screen, swipe a row from right to left to delete the remote desktop.  
  
2.  Tap **Delete** to delete the remote desktop.  
  
**To rearrange Remote Desktop connections**  
  
1.  On the Connection Center screen, tap the rearrange icon.  
  
2.  Tap and hold on the re\-arrange section of a remote desktop connection table cell, and then drag to a spot on the list.  
  
3.  Tap the rearrange icon when finished.  
  
### <a name="bkmk-RemRes1"></a>Create or Edit Remote Resources  
Remote Resources enables access to RemoteApp programs, session\-based desktops, and virtual desktops published using RemoteApp and Desktop Connections. You will need the URL of the RD Web Access server that provides access to your organization’s RemoteApp programs before you begin. You can get this information from your system administrator.  
  
**To add a Remote Resource**  
  
1.  On the **Connection Center** screen, tap **Add Remote Resource**.  
  
2.  In the **Remote Resources** window, enter information for the Remote Resource:  
  
    -   **URL**: The URL of the RD Web Access server.  
  
    -   **User name**: The user name to be used for the RD Web Access server you are connecting to.  
  
    -   **Password**: The password to be used for the RD Web Access server you are connecting to.  
  
3.  Tap **Save**. The remote resources will be displayed in the Connection Center.  
  
**To refresh Remote Resources**  
  
On the **Connection Center** screen, tap the <refresh> icon to the right of the remote resource.  
  
**To delete Remote Resources**  
  
1.  On the **Connection Center** screen, under **Configuration** tap **Remote Resources**.  
  
2.  In the **Remote Resources** window, tap **URL**.  
  
3.  In the URL window, tap the **x** button, and then tap **Save**.  
  
4.  Tap **Save**, to finalize deleting the Remote Resources.  
  
### Connect to Microsoft RemoteApp  
If your organization uses Azure RemoteApp to host Windows apps in the cloud, you can access them through the remote desktop client on your iPad or iPhone. Before connecting to Microsoft RemoteApp, you will need to create or have access to a Microsoft RemoteApp account. Visit the RemoteApp landing page to create an account or get the account information from your administrator. Once you have the account information \(user name and password\), you can connect to your Microsoft RemoteApp account through the RDS client.  
  
**To connect to Microsoft RemoteApp**  
  
1.  On the **Connection Center** screen, tap **Microsoft RemoteApp**.  
  
2.  In the **Account** window, enter your Microsoft RemoteApp account name. This is the email address used for the Microsoft RemoteApp services account.  
  
3.  The RDS client will connect to Microsoft RemoteApp and you will be prompted to enter the password for the account.  
  
> [!NOTE]  
> If you have no apps configured, you will be given the option to connect to the free trial demo apps.  
  
### Manage General Configuration Settings  
  
-   Settings  
  
    Tap **Settings** to manage the session settings.  
  
    -   Certificates: The Remote Desktop Client will try to validate the certificate when connecting to a remote PC. If the remote PC certificate cannot be validated, you will be given the choice of not connecting, or allowing the connection. If the remote PC certificate is permanently accepted, it is stored in the Certificate list, so a user can view the certificate.  
  
        > [!NOTE]  
        > This feature is not available in release 8.0.6.  
  
    -   Gateway: Display the list of available Remote Desktop Gateways. Configure, or add an RD Gateway.  
  
    -   Remote Desktop Licensing: Display the list of client licenses that are used by the remote desktop client.  
  
        > [!NOTE]  
        > This feature is not available in release 8.0.6.  
  
    -   Send log via email:  
  
        Tap **Send log via email** to open the standard email client on your device and create an email that contains log details. To email a copy of the log, enter the address for the recipient and send the email.  
  
        > [!WARNING]  
        > Do not send this log to untrusted people.  
  
-   Remote Resources  
  
    Tap **Remote Resources** to configure Remote Resources.  
  
    Remote Resources enables access to RemoteApp programs, session\-based desktops, and virtual desktops published using RemoteApp and Desktop Connections.  
  
-   Help  
  
    Tap **Help** to view web\-based help.  
  
-   About  
  
    Tap **About** to display information about the Remote Desktop Client.  
  
## Certificates  
  
> [!NOTE]  
> This feature is not available in release 8.0.6.  
  
The Remote Desktop Client will try to validate the certificate when connecting to a remote PC. If the remote PC certificate cannot be validated, you will be given the choice of not connecting, or allowing the connection. If the remote PC certificate is permanently accepted, it is stored in the Certificate list, so a user can view the certificate.  
  
**View Details of a Certificate**  
  
1.  On the Connection Center screen, under **Configuration** tap **Settings**, and then tap **Certificates**.  
  
2.  In the **Certificates** window, tap the certificate to view details.  
  
**Delete a Certificate**  
  
1.  On the Connection Center screen, under **Configuration** tap **Settings**, and then tap **Certificates**.  
  
2.  In the **Certificates** window, swipe a row from right to left to delete the certificate.  
  
3.  Tap **Delete** to delete the certificate.  
  
Lower security PCs are displayed. Lower security PCs are remote PCs that could not be connected to using a secure channel. Swipe a remote PC, and then tap delete to delete a trusted host from this list. If you delete a host, you will be asked if you would like to trust this connection next time.  
  
## Gateway  
A Remote Desktop Gateway \(RD Gateway\) enables authorized users to connect to a remote computer on a corporate network from anywhere on the Internet. You can create and manage your gateways using the Remote Desktop Client.  
  
**Set up a New Gateway**  
  
1.  On the Connection Center screen, under **Configuration** tap **Settings**,  tap **Gateway**.  
  
2.  In the **Gateway** window tap **Add gateway**, and then tap **No gateway configured**.  
  
3.  In the **No gateway configured** window, enter information for the Remote Desktop Gateway:  
  
    -   Gateway name \(Optional\): The name of the gateway to be displayed. This can be any string. If this is field is empty, the server will be displayed.  
  
    -   Server: The name of the computer you want to use as the gateway. This can be a Windows computer name, an Internet domain name or an IP address. You can also add port information to the server name, for example: RDGateway:443 or 10.0.0.1:443.  
  
    -   Credentials: The user name and password to be used for the Remote Desktop Gateway you are connecting to. If credentials are not entered, the credentials for the remote desktop connection will be used.  
  
4.  In the **No gateway configured** window tap **Gateway**, and then tap **Settings** to return to the Settings window.  
  
5.  In the **Settings** window tap **Done** to save the new configuration.  
  
**Delete a Gateway**  
  
1.  On the Connection Center screen, under **Configuration** tap **Settings**, tap **Gateway**.  
  
2.  In the **Gateway** window, swipe a row from right to left to delete the RD Gateway.  
  
3.  Tap **Delete** to delete the gateway.  
  
## Remote Desktop licensing  
  
> [!NOTE]  
> This feature is not available in release 8.0.6.  
  
A Remote Desktop Session Host server determines if a Remote Desktop Services client access licenses \(RDS CALs\) is required. If an RDS CAL is required, a list of the licenses currently issued to the Remote Desktop Client will be displayed.  
  
**View Details of a License**  
  
1.  On the Connection Center screen, under **Configuration** tap **Settings**, tap **Remote Desktop licensing**.  
  
2.  In the **Remote Desktop licensing** window, tap the license to view details.  
  
**Delete a License**  
  
1.  On the Connection Center screen, under **Configuration** tap **Settings**, tap **Remote Desktop licensing**.  
  
2.  In the **Remote Desktop licensing** window, swipe a row from right to left to delete the license.  
  
3.  Tap **Delete** to delete the license.  
  
## Navigating the Remote Desktop Session  
Once you start a remote desktop connection there are tools available that you can use to navigate the session.  
  
**Start a Remote Desktop Connection**  
  
1.  Tap the remote desktop connection, to start the remote desktop session.  
  
2.  If you are asked to verify the certificate for the remote PC, tap **Connect once** or **Connect always** \(if you trust this remote PC\).  
  
**Connection Bar**  
  
-   Pan Control: The pan control enables the screen to be enlarged and moved around.  
  
    > [!NOTE]  
    > The pan control is available using direct touch only.  
  
    -   Enable \/ Disable the pan control: Tap the pan icon in the connection bar to display the pan control and zoom the screen. Tap the pan icon in the connection bar again to hide the control and return the screen to its original resolution.  
  
    -   Use the pan control: Tap and hold the pan control and then drag in the direction you want to move the screen.  
  
    -   Move the pan control: Double tap and hold the pan control to move the control on the screen.  
  
-   Connection name \/ Application name: The current connection name is displayed. Tap the connection name to display the utility bar.  
  
-   Keyboard: The keyboard can be displayed, or hidden by tapping the keyboard icon. The pan control is displayed automatically when the keyboard is displayed.  
  
-   Move the connection bar: Tap and hold the connection bar, and then drag and drop to a new location at the top of the screen.  
  
**Utility Bar**  
  
Tap the connection bar to display the utility bar at the top of the screen. The utility bar enables switching between mouse modes, and disconnects the session. There are additional buttons for switching between active applications or starting a new application when connected to remote resources.  
  
**Direct touch gestures and mouse modes**  
  
Standard touch gestures are available when using the client. Touch gestures can also be used to replicate mouse actions on the remote desktop. The mouse modes available are defined in the table below.  
  
> [!NOTE]  
> When interacting with Windows 8 or newer, the native touch gestures are supported in Direct Touch mode. For more information on Windows 8 gestures see [Touch: Swipe, tap, and beyond](http://windows.microsoft.com/windows-8/touch-swipe-tap-beyond).  
  
|Mouse mode|Mouse operation|Gesture||  
|--------------|-------------------|-----------|-|  
|Direct Touch|Left click|1 finger tap||  
|Direct Touch|Right click|1 finger tap and hold||  
|Mouse Pointer|Left click|1 finger tap||  
|Mouse Pointer|Left click and drag|1 finger double tap and hold, then drag||  
|Mouse Pointer|Right click|2 finger tap||  
|Mouse Pointer|Right click and drag|2 finger double tap and hold, then drag||  
|Mouse Pointer|Mouse wheel|2 finger tap and hold, then drag up\/down||  
|Direct Touch|Zoom|Pinch two fingers to zoom in or spread two fingers to zoom out||  
  
**On\-screen Keyboards**  
  
On the iPad you can use the buttons on the edges of the bar above the keyboard to switch between the standard and additional keyboard.  
  
On iPhone and iPod touch devices you can switch between four different keyboard types depending on the keys that are needed.  
  
-   Letter keyboard  
  
-   Numeric keypad  
  
-   Special keys  
  
-   Function keys  
  
**Bluetooth Keyboard**  
  
If Bluetooth is enabled, a Bluetooth keyboard should be automatically detected.  
  
Due to limitations on the iPhone OS special keys such as Ctrl, Option, and Function will not work as expected. The following keys currently work:  
  
-   Alphanumeric keys  
  
-   Cursor keys  
  
-   Tab: Tab works, but Shift\+Tab does not work  
  
-   Home \/ Pos1: Alt\+Left \= Home  
  
-   End: Alt\+Right \= End  
  
-   Page Up: Alt\+Up \= Page Up  
  
-   Page Down: Alt\+Down \= Page Down  
  
-   Select All: Command\+A \= Ctrl\+A \(Select all in most programs\)  
  
-   Cut: Command\+X \= Ctrl\+X \(Cut in most programs\)  
  
-   Copy: Command\+C \= Ctrl\+C \(Copy in most programs\)  
  
-   Paste: Command\+V \= Ctrl\+V \(Paste in most programs\)  
  
-   Symbols: Alt\+Alphanumeric keys will produce different symbols depending on the language configured  
  
## <a name="BKMK_LINKS"></a>See also  
The following list provides additional resources for using Remote Desktop Clients.  
  
-   **Android:** [Remote Desktop Client on Android: FAQ](assetId:///71de3651-276b-4f90-b025-3b0ad5bf9f62)  
  
-   **iPad or iOS:** [Remote Desktop Client on iOS: FAQ](assetId:///ac7f2646-695d-48c6-8892-479c1f824225)  
  
-   **Mac:** [Remote Desktop Client on Mac: FAQ](../Topic/Remote-Desktop-Client-on-Mac--FAQ.md)  
  
-   **Windows 8:** [Remote Desktop Connection: FAQ](http://windows.microsoft.com/windows-8/remote-desktop-connection-frequently-asked-questions)  
  
