---
title: Supported Remote Desktop RDP file settings
description: Learn about the RDP file settings for Remote Desktop
ms.topic: article
author: heidilohr
manager: lizross
ms.author: helohr
ms.date: 09/14/2020
ms.localizationpriority: medium
---

# Supported Remote Desktop RDP file settings

The following table includes the list of supported RDP file settings that you can use with the Remote Desktop clients. When configuring settings, check [Client comparisons](./remote-desktop-app-compare.md) to see which redirections each client supports.

The table also highlights which settings are supported as custom properties with Windows Virtual Desktop. You can refer to [this documentation](/azure/virtual-desktop/customize-rdp-properties/) detailing how to use PowerShell to customize RDP properties for Windows Virtual Desktop host pools.

## Connection information

| RDP setting                        | Description            | Values                 | Default value          | Windows Virtual Desktop support |
|------------------------------------|------------------------|------------------------|:----------------------:|:-----------------------:|
| full address:s:value | PC Name:</br>This setting specifies the name or IP address of the remote computer that you want to connect to.</br></br>This is the only required setting in an RDP file. | A valid name, IPv4 address, or IPv6 address. | | No |
| alternate full address:s:value | Specifies an alternate name or IP address of the remote computer. | A valid name, IPv4 address, or IPv6 address. | | No |
| username:s:value | Specifies the name of the user account that will be used to sign in to the remote computer. | Any valid username. | | No |
| domain:s:value | Specifies the name of the domain in which the user account that will be used to sign in to the remote computer is located. | A valid domain name, such as "CONTOSO". | | No |
| gatewayhostname:s:value | Specifies the RD Gateway host name. | A valid name, IPv4 address, or IPv6 address. | | No |
| gatewaycredentialssource:i:value | Specifies the RD Gateway authentication method. | - 0: Ask for password (NTLM)</br>- 1: Use smart card</br>- 2: Use the credentials for the currently logged on user.</br>- 3: Prompt the user for their credentials and use basic authentication</br>- 4: Allow user to select later</br>- 5: Use cookie-based authentication | 0 | No |
| gatewayprofileusagemethod:i:value | Specifies whether to use default RD Gateway settings. | - 0: Use the default profile mode, as specified by the administrator</br>- 1: Use explicit settings, as specified by the user | 0 | No |
| gatewayusagemethod:i:value | Specifies when to use an RD Gateway for the connection. | - 0: Don't use an RD Gateway</br>- 1: Always use an RD Gateway</br>- 2: Use an RD Gateway if a direct connection cannot be made to the RD Session Host</br>- 3: Use the default RD Gateway settings</br>- 4: Don't use an RD Gateway, bypass gateway for local addresses</br>Setting this property value to 0 or 4 are effectively equivalent, but setting this property to 4 enables the option to bypass local addresses. | 0 | No |
| promptcredentialonce:i:value | Determines whether a user's credentials are saved and used for both the RD Gateway and the remote computer. | - 0: Remote session will not use the same credentials</br>- 1: Remote session will use the same credentials | 1 | No |
| authentication level:i:value | Defines the server authentication level settings. | - 0: If server authentication fails, connect to the computer without warning (Connect and don't warn me)</br>- 1: If server authentication fails, don't establish a connection (Don't connect)</br>- 2: If server authentication fails, show a warning and allow me to connect or refuse the connection (Warn me)</br>- 3: No authentication requirement specified. | 3 | No |
| enablecredsspsupport:i:value | Determines whether the client will use the Credential Security Support Provider (CredSSP) for authentication if it is available. | - 0: RDP will not use CredSSP, even if the operating system supports CredSSP</br>- 1: RDP will use CredSSP if the operating system supports CredSSP | 1 | Yes |
| disableconnectionsharing:i:value | Determines whether the client reconnects to any existing disconnected session or initiate a new connection when a new connection is launched. | - 0: Reconnect to any existing session</br>- 1: Initiate new connection | 0 | Yes |
| alternate shell:s:value | Specifies a program to be started automatically in the remote session as the shell instead of explorer. | Valid path to an executable file, such as "C:\ProgramFiles\Office\word.exe" | | Yes |

## Session behavior

| RDP setting                        | Description            | Values                 | Default value          | Windows Virtual Desktop support |
|------------------------------------|------------------------|------------------------|:----------------------:|:-----------------------:|
| autoreconnection enabled:i:value | Determines whether the client will automatically try to reconnect to the remote computer if the connection is dropped, such as when there's a network connectivity interruption. | - 0: Client does not automatically try to reconnect</br>- 1: Client automatically tries to reconnect | 1 | Yes |
| bandwidthautodetect:i:value | Determines whether automatic network type detection is enabled | - 0: Disable automatic network type detection</br>- 1: Enable automatic network type detection | 1 | Yes |
| networkautodetect:i:value | Determines whether or not to use automatic network bandwidth detection. Requires bandwidthautodetect to be set to 1. | - 0: Don't use automatic network bandwidth detection</br> - 1: Use automatic network bandwidth detection | 1 | Yes |
| compression:i:value | Determines whether bulk compression is enabled when it is transmitted by RDP to the local computer.|- 0: Disable RDP bulk compression</br>- 1: Enable RDP bulk compression | 1 | Yes |
| videoplaybackmode:i:value| Determines if the connection will use RDP-efficient multimedia streaming for video playback.|- 0: Don't use RDP efficient multimedia streaming for video playback</br>- 1: Use RDP-efficient multimedia streaming for video playback when possible | 1 | Yes |

## Device redirection

| RDP setting                        | Description            | Values                 | Default value          | Windows Virtual Desktop support |
|------------------------------------|------------------------|------------------------|:----------------------:|:-----------------------:|
| audiocapturemode:i:value | Microphone redirection:</br>Indicates whether audio input redirection is enabled. | - 0: Disable audio capture from the local device</br>- 1: Enable audio capture from the local device and redirection to an audio application in the remote session | 0 | Yes |
| encode redirected video capture:i:value | Enables or disables encoding of redirected video. | - 0: Disable encoding of redirected video</br>- 1: Enable encoding of redirected video | 1 | Yes |
| redirected video capture encoding quality:i:value | Controls the quality of encoded video. | - 0: High compression video. Quality may suffer when there is a lot of motion. </br>- 1: Medium compression.</br>- 2: Low compression video with high picture quality. | 0 | Yes |
| audiomode:i:value | Audio output location:</br>Determines whether the local or remote machine plays audio. | - 0: Play sounds on the local computer (Play on this computer)</br>- 1: Play sounds on the remote computer (Play on remote computer)</br>- 2: Do not play sounds (Do not play) | 0 | Yes |
| camerastoredirect:s:value | Camera redirection:</br>Configures which cameras to redirect. This setting uses a semicolon-delimited list of KSCATEGORY_VIDEO_CAMERA interfaces of cameras enabled for redirection. | - * : Redirect all cameras</br> - List of cameras, such as camerastoredirect:s:\\?\usb#vid_0bda&pid_58b0&mi</br>- One can exclude a specific camera by prepending the symbolic link string with "-" | Don't redirect any cameras | Yes |
| devicestoredirect:s:value | Plug and play device redirection:</br>Determines which devices on the local computer will be redirected and available in the remote session. | - *: Redirect all supported devices, including ones that are connected later</br> - Valid hardware ID for one or more devices</br> - DynamicDevices: Redirect all supported devices that are connected later | Don't redirect any devices | Yes |
| drivestoredirect:s:value | Drive/storage redirection:</br>Determines which disk drives on the local computer will be redirected and available in the remote session. | - No value specified: don't redirect any drives</br>- * : Redirect all disk drives, including drives that are connected later</br>- DynamicDrives: redirect any drives that are connected later</br>- The drive and labels for one or more drives, such as "drivestoredirect:s:C\:;E\:;": redirect the specified drive(s) | Don't redirect any drives | Yes |
| keyboardhook:i:value | Determines when Windows key combinations (WIN key, ALT+TAB) are applied to the remote session for desktop connections. | - 0: Windows key combinations are applied on the local computer</br>- 1: Windows key combinations are applied on the remote computer when in focus</br>- 2: Windows key combinations are applied on the remote computer in full screen mode only | 2 | Yes |
| redirectclipboard:i:value | Clipboard redirection:</br>Determines whether clipboard redirection is enabled. | - 0: Clipboard on local computer isn't available in remote session</br>- 1: Clipboard on local computer is available in remote session | 1 | Yes |
| redirectcomports:i:value | COM ports redirection:</br>Determines whether COM (serial) ports on the local computer will be redirected and available in the remote session. | - 0: COM ports on the local computer are not available in the remote session</br>- 1: COM ports on the local computer are available in the remote session | 0 | Yes |
| redirectprinters:i:value | Printer redirection:</br>Determines whether printers configured on the local computer will be redirected and available in the remote session | - 0: The printers on the local computer are not available in the remote session</br>- 1: The printers on the local computer are available in the remote session | 1 | Yes |
| redirectsmartcards:i:value | Smart card redirection:</br>Determines whether smart card devices on the local computer will be redirected and available in the remote session. |- 0: The smart card device on the local computer is not available in the remote session</br>- 1: The smart card device on the local computer is available in the remote session | 1 | Yes |
| usbdevicestoredirect:s:value | USB redirection | - *: Redirect all USB devices that are not already redirected by another high-level redirection</br> - {Device Setup Class GUID}: Redirect all devices that are members of the specified [device setup class](/windows-hardware/drivers/install/system-defined-device-setup-classes-available-to-vendors/)</br> - USBInstanceID: Redirect a specific USB device identified by the instance ID| Don't redirect any USB devices | Yes |

## Display settings

| RDP setting                        | Description            | Values                 | Default value          | Windows Virtual Desktop support |
|------------------------------------|------------------------|------------------------|:----------------------:|:-----------------------:|
| use multimon:i:value | Determines whether the remote session will use one or multiple displays from the local computer. | - 0: Don't enable multiple display support</br>- 1: Enable multiple display support | 1 | Yes |
| selectedmonitors:s:value | Specifies which local displays to use from the remote session. The selected displays must be contiguous. Requires use multimon to be set to 1.</br></br>Only available on the Windows Inbox (MSTSC) and Windows Desktop (MSRDC) clients. | Coma separated list of machine-specific display IDs. IDs can be retrieved by calling mstsc.exe /l. The first ID listed will be set as the primary display in the session. | All displays | Yes |
| maximizetocurrentdisplays:i:value | Determines which display the remote session goes full screen on when maximizing. Requires use multimon to be set to 1.</br></br>Only available on the Windows Desktop (MSRDC) client. | - 0: Session goes full screen on the displays initially selected when maximizing</br>- 1: Session dynamically goes full screen on the displays touched by the session window when maximizing | 0 | Yes |
| singlemoninwindowedmode:i:value | Determines whether a multi display remote session automatically switches to single display when exiting full screen. Requires use multimon to be set to 1.</br></br>Only available on the Windows Desktop (MSRDC) client. | - 0: Session retains all displays when exiting full screen</br>- 1: Session switches to single display when exiting full screen | 0 | Yes |
| screen mode id:i:value | Determines whether the remote session window appears full screen when you launch the connection. | - 1: The remote session will appear in a window</br>- 2: The remote session will appear full screen | 2 | Yes |
| smart sizing:i:value | Determines whether or not the local computer scales the content of the remote session to fit the window size. | - 0: The local window content won't scale when resized</br>- 1: The local window content will scale when resized | 0 | Yes |
| dynamic resolution:i:value | Determines whether the resolution of the remote session is automatically updated when the local window is resized. | - 0: Session resolution remains static for the duration of the session</br>- 1: Session resolution updates as the local window resizes | 1 | Yes |
| desktop size id:i:value | Specifies the dimensions of the remote session desktop from a set of pre-defined options. This setting is overridden if desktopheight and desktopwidth are specified.| -0: 640×480</br>- 1: 800×600</br>- 2: 1024×768</br>- 3: 1280×1024</br>- 4: 1600×1200 | 1 | Yes |
| desktopheight:i:value | Specifies the resolution height (in pixels) of the remote session. | Numerical value between 200 and 8192 | Match the local computer | Yes |
| desktopwidth:i:value | Specifies the resolution width (in pixels) of the remote session. | Numerical value between 200 and 8192 | Match the local computer | Yes |
| desktopscalefactor:i:value | Specifies the scale factor of the remote session to make the content appear larger. | Numerical value from the following list: 100, 125, 150, 175, 200, 250, 300, 400, 500 | 100 | Yes |

## RemoteApp

| RDP setting                        | Description            | Values                 | Default value          | Windows Virtual Desktop support |
|------------------------------------|------------------------|------------------------|:----------------------:|:-----------------------:|
| remoteapplicationcmdline:s:value | Optional command-line parameters for the RemoteApp. | Valid command-line parameters. | | No |
| remoteapplicationexpandcmdline:i:value | Determines whether environment variables contained in the RemoteApp command-line parameter should be expanded locally or remotely. | - 0: Environment variables should be expanded to the values of the local computer</br>- 1: Environment variables should be expanded to the values of the remote computer | 1 | No |
| remoteapplicationexpandworkingdir:i:value | Determines whether environment variables contained in the RemoteApp working directory parameter should be expanded locally or remotely. | - 0: Environment variables should be expanded to the values of the local computer</br> - 1: Environment variables should be expanded to the values of the remote computer.</br>The RemoteApp working directory is specified through the shell working directory parameter. | 1 | No |
| remoteapplicationfile:s:value | Specifies a file to be opened on the remote computer by the RemoteApp.</br>For local files to be opened, you must also enable drive redirection for the source drive. | Valid file path. | | No |
| remoteapplicationicon:s:value | Specifies the icon file to be displayed in the client UI while launching a RemoteApp. If no file name is specified, the client will use the standard Remote Desktop icon. Only ".ico" files are supported. | Valid file path. | | No |
| remoteapplicationmode:i:value | Determines whether a connection is launched as a RemoteApp session. | - 0: Don't launch a RemoteApp session</br>- 1: Launch a RemoteApp session | 1 | No |
| remoteapplicationname:s:value | Specifies the name of the RemoteApp in the client interface while starting the RemoteApp.| App display name. For example, "Excel 2016." | | No |
| remoteapplicationprogram:s:value | Specifies the alias or executable name of the RemoteApp. | Valid alias or name. For example, "EXCEL." | | No |
