---
title: What's new in the web client
description: Learn about recent changes to the Remote Desktop web client.
ms.topic: whats-new
author: sipastak
ms.author: sipastak
ms.date: 01/28/2025
---
# What's new in the web client

Here's where you can find the latest updates for the [Remote Desktop web client](remote-desktop-web-client.md) Updates add new features and fix issues.

## Updates for version 2.1.62.1

*Date published: January 30, 2025*

- Endpoint that delivers client packages changed to `*.cdn.office.net`.
- Bug fixes and security updates.

## Updates for version 2.1.0.0

*Date published: March 21, 2024*

- New client now generally available.
- UX improvements added.
- New key features added to this client version.
- Now available for on-prem download.

## Updates for version 1.0.28.0

*Date published: December 19, 2022*

- You can now redirect cameras.
- Updated third-party libraries.
- Accessibility improvements.
- Bug fixes.

## Updates for version 1.0.27.0

*Date published: March 24, 2022*

- Added Web client keyboard shortcuts for switching between programs. For more information, see [Keyboard shortcuts](remote-desktop-web-client.md#web-client-keyboard-shortcuts).
- The client now supports native resolution on high-DPI devices. For more information, see [Enable native display resolution in remote sessions](remote-desktop-web-client.md#enable-native-display-resolution-in-remote-sessions).
- Updated full screen mode icon behavior to disable the icon when you press the F11 key to enter full screen mode.  
- Removed support for Internet Explorer and other deprecated browsers.  
- Fixed an issue where some keys weren’t working correctly on the Japanese keyboard layout.
- Bug fixes and security improvements for file transfer.

## Updates for version 1.0.26.0

*Date published: December 12, 2021*

- Bug fixes.
- Version 1.0.26.0 is the final version of the client that supports Internet Explorer 11 and WinXP.

## Updates for version 1.0.25.0

*Date published: July 22, 2021*

- Client now has web assembly on supported browsers.
- Added file transfer support.
- Bug fixes.

## Updates for 1.0.24.0

*Date published: January 6, 2021*

>[!IMPORTANT]
> Version 1.0.24.0 includes an important security fix. We have removed earlier versions of the web client containing this bug.

- Added support for redirecting local microphone input to the remote session.
- Fixed issues with **AltGr** and several other keyboard bugs.
- Accessibility improvements.

## Updates for 1.0.22.0

*Date published: September 2, 2020*

- Users can now move the minimized menu.
- Improved support for 4K and ultra-wide monitors and fixed an issue where copying large amounts of data caused sessions to crash.
- Improved support for using an Input Method Editor in the remote session. To learn more about using an Input Method Editor with the web client, check out [Connect to Azure Virtual Desktop with the web client](/azure/virtual-desktop/connect-web).
- Changed the **All Resources** page UI.
- Fixed several connection sequence failures where web client returned a *General Protocol Error*.
- Fixed keyboard input issues where specific key sequences weren't handled appropriately.
- Accessibility improvements.

## Updates for version 1.0.21.0

*Date published: November 15, 2019*

- Added support for using an Input Method Editor (IME) in the remote session to input complex characters.
- Fixed a regression where users couldn't copy and paste into the remote session on macOS devices.
- Fixed a regression where local Windows Key was sent to the remote session on Firefox.
- Added link to RDWeb password change when enabled by your administrator.

## Updates for version 1.0.20.0

*Date published: October 18, 2019*

- Added support for connections to Windows 7 and Windows Server 2008 R2 hosts.
- Fixed an issue where certain app icons were shown as transparent tiles.
- Fixed connection issues for Internet Explorer browser on Windows 7.
- Fixed unexpected disconnects that happened when the browser was resized.
- Accessibility improvements.
- Updated third-party libraries.

## Updates for version 1.0.18.0

*Date published: May 14, 2019*

- Added Resource Launch Method configuration in the Settings tab, enabling users to either open resources in the browser or download an .rdp file to handle with another client. This setting may be configured by your admin. Details regarding admin configurations for this feature can be found in the [web client setup documentation](remote-desktop-web-client-admin.md).
- Fixed color rendering issues, enabling more vivid colors in your remote session.
- Revised error messages related to remote resource feed errors.
- Added support for more office shortcuts, such as paste special (Ctrl+Alt+V).
- Added keyboard shortcut for users to invoke the Windows Key in the remote session (Alt+F3)
- Updated error message for users attempting to authenticate using an expired password.
- Refreshed feed UI on the All Resources page.
- Resolved overlapping dialogues that occurred during session reconnect.
- Fixed remote resource icon sizing in the resource taskbar.

## Updates for version 1.0.11

*Date published: February 22, 2019*

- Enabled connection to RD Broker without an RD Gateway in Windows Server 2019.
- Sorted feeds alphabetically (i.e., RemoteApps first, Desktops second).
- Fixed multiple accessibility bugs improving screen reader compatibility.
- Updated our build tools.
- Various bug fixes.

## Updates for version 1.0.7

*Date published: January 24, 2019*

- Offline use on internal networks is now supported.
- Improved rendering on non-Microsoft Edge browsers.
- Implemented limit for feed retrieval retry attempts to prevent DoS.
- Fixed accessibility bugs, enabling users with visual disabilities to use the web client.
- Improved error messages displayed to the user for feed errors.
- Added Ctrl + Alt + End (Windows) and fn + control + option + delete (Mac) shortcuts to invoke Ctrl + Alt + Del in remote machine.
- Improved telemetry for crash events.
- Improved our build pipeline and build tools.
- Various bug fixes.

## Updates for version 1.0.1

*Date published: October 29, 2018*

- Added an option to **Capture support information** on the About page to diagnose issues.
- InPrivate mode is now supported.
- Improved support for non-English keyboards.
- Fixed an issue where tooltips with non-English characters showed incorrectly.
- Fixed graphics rendering issue that affected Chrome users.
- Updated time zone redirection with full DST support.
- Improved the error message for out-of-memory error.
- Various bug fixes.

## Updates for version 1.0.0

*Date published: July 16, 2018*

- Remote Desktop web client is now generally available.
- Admins can globally turn off telemetry for the web client.
- Various bug fixes.

## Updates for version 0.9.0

*Date published: July 5, 2018*

- New sign in experience within the web client.
- No longer prompted for credentials when launching a desktop or app connection (Single sign on).
- Added time zone redirection.
- Various bug fixes.

## Updates for version 0.8.1

*Date published: May 17, 2018*

- Updates to address CredSSP encryption oracle remediation described in CVE-2018-0886.
- Fixed connection failures for some languages when printing is enabled.
- Improved error message when a gateway isn't part of the deployment.
- **Help** and **Feedback** options were added.

## Updates for version 0.8.0

*Date published: March 28, 2018*

- Initial public preview release of the web client.
- Copy/paste text through the clipboard with **CTRL+C** and **CTRL+V**.
- Print to a PDF file.
- Localized in 18 languages.
