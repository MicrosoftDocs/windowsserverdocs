---
title: Remote Desktop - compare the client apps
description: Learn how the different RD apps compare when it comes to supported features and functions.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 12efe858-6b76-4e08-9f72-b9603aceb0fc
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 04/26/2019
ms.localizationpriority: medium
---

# Compare the client apps

>Applies to: Windows 10, Windows 8.1, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

We're often asked how the different Remote Desktop client apps compare to each other. Do they all do the same thing? Here are the answers to those questions.

## Redirection support

The following tables compare support for device and other redirections on the Remote Desktop Connection app, Universal app, Android app, iOS app, macOS app and web client. These tables cover the redirections that you can access once in a remote session. 

If you remote into your personal desktop, there are additional redirections that you can configure in the **Additional Settings** for the session. If your remote desktop or apps are managed by your organization, your admin can enable or disable redirections through Group Policy settings.

### Input redirection

| Redirection | Remote Desktop<br> Connection | Universal | Android | iOS | macOS | web client |
|-------------|-------------------------------|-----------|---------|-----|-------|------------|
| Keyboard    | X                             | X         | X       | X   | X     | X          |
| Mouse       | X                             | X         | X       | X*    | X     | X          |
| Touch       | X                             | X         | X       | X   |       | X (Edge and IE not supported) |
| Other       | Pen                           |           |         |     |       |            |
*View the [list of supported input devices for the Remote Desktop iOS Beta client](remote-desktop-ios.md#supported-input-devices).

### Port redirection   

| Redirection | Remote Desktop <br>Connection | Universal | Android | iOS | macOS | Web client |
|-------------|-------------------------------|-----------|---------|-----|-------|------------|
| Serial port | X                             |           |         |     |       |            |
| USB         | X                             |           |         |     |       |            |

When you enable USB port redirection, any USB devices attached to the USB port are automatically recognized in the remote session.

### Other redirection (devices, etc)



| Redirection         | Remote Desktop Connection | Universal   | Android | iOS         | macOS                                    | Web client    |
|---------------------|---------------------------|-------------|---------|-------------|------------------------------------------|---------------|
| Cameras             | X                         |             |         |             |                                          |               |
| Clipboard           | X                         | text, image | text    | text, image | X                                        | text          |
| Local drive/storage | X                         |             | X       |             | x                                        |               |
| Location            | X                         |             |         |             |                                          |               |
| Microphones         | X                         |X            |         |             | X                                        |               |
| Printers            | X                         |             |         |             | X (CUPS only)                            | PDF print     |
| Scanners            | X                         |             |         |             |                                          |               |
| Smart Cards         | X                         |             |         |             | X (Windows authentication not supported) |               |
| Speakers            | X                         | X           | X       | X           | X                                        | X (except IE) |

*For printer redirection - the macOS app supports the Publisher Imagesetter printer driver by default. They do not support redirecting native printer drivers.

## Supported RDP Settings
This table includes list of supported RDP file settings that may be used with the Windows and HTML clients. An “x” in the platform column indicates that the setting is supported. Please note that this is not an exhaustive list of supported settings for the Windows and HTML5 clients. We will continue to update this table to include more supported RDP settings for the Windows and HTML5 clients as well as the macOS, iOS, and Android clients.

| RDP Setting                        | Description            | Values                 | Default Value          | Windows Virtual Desktop | Windows | HTML5   |
|------------------------------------|------------------------|------------------------|:----------------------:|:-----------------------:|:-------:|:-------:|
| alternate full address:s:value | Specifies an alternate name or IP address of the remote computer. | Any valid name or IP address of the remote computer, e.g., "10.10.15.15" | | x | x | x |
| alternate shell:s:value        | Determines whether a program starts automatically when you connect with RDP. This setting corresponds to the Program path and file name box on the Programs tab of the Remote Desktop Connection client. To specify an alternate shell, enter a valid path to an executable file for the value, for example ""C:\ProgramFiles\Office\word.exe"". This setting also determines the path or the alias of the Remote Application to be started at connection time if RemoteApplicationMode is enabled. | e.g., "C:\ProgramFiles\Office\word.exe" || x | x | x |
| audiocapturemode:i:value | Indicates whether audio input/output redirection is enabled. This setting corresponds to the Remote Audio box of Remote Desktop connection client. | (0) Disable audio capture from the local device; (1) Enable audio capture from the local device and redirection to an audio application in the remote session | 0 | x | x | |
| audiomode:i:value | Determines which machine (i.e., local or remote) plays audio. | (0) Play sounds on local computer (Play on this computer); (1) Play sounds on remote computer (Play on remote computer); (2) Do not play sounds (Do not play) | 0 | x | x | x |
| authentication level:i:value | Defines the server authentication level settings. | (0) If server authentication fails, connect to the computer without warning (Connect and don’t warn me); (1) If server authentication fails, do not establish a connection (Do not connect); (2) If server authentication fails, show a warning and allow me to connect or refuse the connection (Warn me); (3) No authentication requirement is specified. | 3 | x | x ||
| autoreconnection enabled:i:value | This setting determines whether the client computer will automatically try to reconnect to the remote computer if the connection is dropped; for example, when there is an interruption of network connectivity. This setting corresponds to the Reconnect if the connection is dropped check box on the Experience tab under Options in Remote Desktop Connection (RDC).| (0) Client computer does not automatically try to reconnect; (1) Client computer automatically tries to reconnect| 1 | x | x | x |
| bandwidthautodetect:i:value | Determines whether automatic network type detection is enabled | (0) Disable automatic network type detection; (1) Enable automatic network type detection | 1 | x | x | x |
| compression:i:value | This setting determines whether bulk compression is enabled when it is transmitted by RDP to the local computer.|(0) Disable RDP bulk compression; (1) Enable RDP bulk compression | 1 | x | x | x |
| desktop size id:i:value | Specifies dimensions of the remote session desktop from a set of pre-defined options. This setting is overridden if either desktopheight or desktopwidth are specified.| (0) 640x480; (1) 800x600; (2) 1024x768; (3) 1280x1024; (4) 1600x1200 | 0 | x | x | x |
| desktopheight:i:value | This setting determines the resolution height (in pixels) on the remote computer when you connect by using Remote Desktop Connection (RDC). This setting corresponds to the selection in the Display configuration slider on the Display tab under Options in RDC. | Numerical value from 200 to 2048 | The default value is set to the resolution on the local computer | x | x | x |
| desktopwidth:i:value | This setting determines the resolution width (in pixels) on the remote computer when you connect by using Remote Desktop Connection (RDC). This setting corresponds to the selection in the Display configuration slider on the Display tab under Options in RDC. | Numerical value from 200 to 4096 | The default value is set to the resolution on the local computer | x | x | x |
| disableclipboardredirection:i:value | This setting determines whether Clipboard redirection is enabled when connecting to the remote computer. | (0) Clipboard redirection is enabled; (1) Clipboard redirection is not enabled | x | x | x |
| disableconnectionsharing:i:value | Determines whether the remote desktop client reconnects to any existing open connections or initiate a new connection when a RemoteApp or desktop is launched | (0) Reconnect to any existing session; (1) Initiate new connection | 0 | x | x | x |
| disableprinterredirection:i:value | This setting determines whether Easy Print printer redirection is enabled when connecting to the remote computer. | (0) Easy Print printer redirection is enabled; (1) Easy Print printer redirection is disabled | x | x | x |
| domain:s:value | This setting specifies the name of the domain in which the user account that will be used to log on to the remote computer by using Remote Desktop Connection (RDC) is located. The value of this setting, along with the value of the username setting, will appear in the User name text box on the General tab under Options in RDC. | A valid domain name, e.g., "CONTOSO" | No Default Value | x | x | x |
| drivestoredirect:s:value | Determines which local disk drives on the client computer will be redirected and available in the remote session. | No value specified - Do not redirect any drives; * - Redirect all disk drives, including drives that are connected later; DynamicDrives - redirect any drives that are connected later; The drive and labels for one or more drives - Redirect the specified drive(s).| No value specified - Do not redirect any drives | x | x	| |
| enablecredsspsupport:i:value | This setting determines whether RDP will use the Credential Security Support Provider (CredSSP) for authentication if it is available. | (0) RDP will not use CredSSP, even if the operating system supports CredSSP; (1) RDP will use CredSSP if the operating system support CredSSP | 1 | x | x | |
| full address:s:value | This setting specifies the name or IP address of the remote computer that you want to connect to | A valid computer name, IPv4 address, or IPv6 address - Specifies the remote computer to which you want to connect. | | x | x | x |
| gatewaycredentialssource:i:value | Specifies or retrieves the RD Gateway authentication method. | (0) Ask for password (NTLM); (1) Use smart card; (4) Allow user to select later | 0 | x | x | x |
| gatewayhostname:s:value | Specifies the RD Gateway host name. | Valid gateway server address. ||x|x|x|
| gatewayprofileusagemethod:i:value | Specifies whether to use default RD Gateway settings | (0) Use the default profile mode, as specified by the administrator; (1) Use explicit settings, as specified by the user. | 0 | x | x | x |
| gatewayusagemethod:i:value | Specifies when to use the RD Gateway server | (0) Do not use an RD Gateway server; (1) Always use an RD Gateway server; (2) Use an RD Gateway server if a direct connection cannot be made to the RD Session Host; (3) Use the default RD Gateway server settings; (4) Do not use an RD Gateway, bypass server for local addresses; Setting this property value to 0 or 4 are is effectively equivalent, but setting this property to 4 enabled the option to bypass local addresses. | | x | x | x |
| networkautodetect:i:value | Determines whether to use automatic network bandwidth detection or not. Requires the option bandwidthautodetect to be set and correlates with connection type 7. | (0)  Do not use automatic network bandwidth detection; (1) Use automatic network bandwidth detection | 1 | x ||x|
| promptcredentialonce:i:value | Determines whether a user's credentials are saved and used for both the RD Gateway and the remote computer.|(0) Remote session will not use the same credentials; (1) Remote session will use the same credentials|1|x|x||
| redirectclipboard:i:value | This setting determines whether the clipboard on the local computer will be redirected and available in the remote session. This setting corresponds to the Clipboard check box on the Local Resources tab under Options in RDC. | (0) Clipboard on local computer is not available in remote session; (1) Clipboard on local computer is available in remote session|1|x|x|x|
| redirectdrives:i:value | This setting determines whether drives on the client computer will be redirected and available in the remote session. This setting corresponds to the selections for Drives under More on the Local Resources tab under Options in RDC.|(0) The drives on the local computer are not available in the remote session; (1) The drives on the local computer are available in the remote session|0|x|x| |
| redirectprinters:i:value | This setting determines whether printers configured on the client computer will be redirected and available in the remote session when you connect to a remote computer by using Remote Desktop Connection (RDC). This setting corresponds to the selection in the Printers check box on the Local Resources tab under Options in RDC. | (0) The printers on the local computer are not available in the remote session; (1) The printers on the local computer are available in the remote session|1|x|x|x|
| redirectsmartcards:i:value | This setting determines whether smart card devices on the client computer will be redirected and available in the remote session when you connect to a remote computer by using Remote Desktop Connection (RDC). This setting corresponds to the selection in the Smart cards check box under More on the Local Resources tab under Options in RDC.|(0) The smart card device on the local computer is not available in the remote session; (1) The smart card device on the local computer is available in the remote session|1|x|x||
| remoteapplicationcmdline:s:value | Optional command line parameters for the RemoteApp.||x|x|x|
| remoteapplicationexpandcmdline:i:value| Determines whether environment variables contained in the RemoteApp command line parameter should be expanded locally or remotely.|(0) Environment variables should be expanded to the values of the local computer; (1) Environment variables should be expanded on the remote computer to the values of the remote computer||x|x|x|
| remoteapplicationexpandworkingdir | Determines whether environment variables contained in the RemoteApp working directory parameter should be expanded locally or remotely. | (0) Environment variables should be expanded to the values of the local computer; (1) Environment variables should be expanded on the remote computer to the values of the remote computer. NOTE: The RemoteApp working directory is specified through the shell working directory parameter.||x|x|x|
|remoteapplicationfile:s:value | Specifies a file to be opened on the remote computer by the RemoteApp. NOTE: For local files to be opened, you must also enable drive redirection for the source drive.||x|x|x|
|remoteapplicationicon:s:value | Specifies the icon file to be displayed in the client UI while launching a RemoteApp. If no file name is specified, the client will use the standard Remote Desktop icon. Only ".ico" files are supported.||x|x|x|
|remoteapplicationmode:i:value | Determines whether a RemoteApp connection is launched as a RemoteApp session.| (0) Do not launch a RemoteApp session; (1) Launch a RemoteApp session|1|x|x|x|
|remoteapplicationname:s:value | Specifies the name of the RemoteApp in the client interface while starting the RemoteApp.| e.g., "Excel 2016"|x|x|x|
|remoteapplicationprogram:s:value | Specifies the alias or executable name of the RemoteApp. | e.g., "EXCEL" |x|x|x|
|screen mode id:i:value | This setting determines whether the remote session window appears full screen when you connect to the remote computer by using Remote Desktop Connection (RDC). This setting corresponds to the selection in the Display configuration slider on the Display tab under Options in RDC.|(1) The remote session will appear in a window; (2) The remote session will appear full screen|2|x|x|x|
|smart sizing:i:value | This setting determines whether or not the client computer can scale the content on the remote computer to fit the window size of the client computer.|(0) The client window display will not be scaled when resized; (1) The client window display will be scaled when resized|0|x|x||
| use multimon:i:value | This setting configures multiple monitor support when you connect to the remote computer by using Remote Desktop Connection (RDC).|(0) Do not enable multiple monitor support; (1) Enable multiple monitor support|0|x|x||
| username:s:value | This setting specifies the name of the user account that will be used to log on to the remote computer by using Remote Desktop Connection (RDC). The value of this setting, along with the value of the domain setting, will appear in the User name box on the General tab under Options in RDC.| Any valid username. ||x|x|x|
| videoplaybackmode:i:value| This setting determines if Remote Desktop Connection (RDC) will use RDP efficient multimedia streaming for video playback.|(0) Do not use RDP efficient multimedia streaming for video playback; (1) Use RDP efficient multimedia streaming for video playback when possible|1|x|x||
| workspaceid:s:value | This setting defines the RemoteApp and Desktop ID associated with the RDP file that contains this setting. | A valid RemoteApp and Desktop Connection ID|x|x||