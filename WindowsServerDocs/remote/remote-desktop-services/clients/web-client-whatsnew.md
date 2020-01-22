---
title: What's new in the web client
description: Learn about recent changes to the Remote Desktop web client
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
author: heidilohr
manager: lizross
ms.author: helohr
ms.date: 11/15/2019
ms.localizationpriority: medium
---
# What's new in the web client

We regularly update the [Remote Desktop web client](remote-desktop-web-client.md), adding new features and fixing issues. Here's where you'll find the latest updates.

> [!NOTE]
> We've changed the versioning system for the web client. Starting with version 1.0.18.0, all web client release versions will contain numbers (in the format of "W.X.Y.Z"). Release numbers for the Remote Desktop web client will always end with a 0 (for example, W.X.Y.0). Each Windows Virtual Desktop web client release will change the last digit until the next Remote Desktop web client release (for example, 1.0.18.1).

## Updates for version 1.0.21.0
*Date published: 11/15/2019*

- Added support for using an Input Method Editor (IME) in the remote session to input complex characters.
- Fixed a regression where users could not copy and paste into the remote session on macOS devices.
- Fixed a regression where local Windows Key was sent to the remote session on Firefox.
- Added link to RDWeb password change when enabled by your administrator.

## Updates for version 1.0.20.0
*Date published: 10/18/2019*

- Added support for connections to Windows 7 and Windows Server 2008 R2 hosts.
- Fixed an issue where certain app icons were shown as transparent tiles.
- Fixed connection issues for Internet Explorer browser on Windows 7.
- Fixed unexpected disconnects that happened when the browser was resized.
- Accessibility improvements.
- Updated third-party libraries.

## Updates for version 1.0.18.0
*Date published: 5/14/2019*

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
*Date published: 2/22/2019*

- Enabled connection to RD Broker without an RD Gateway in Windows Server 2019.
- Sorted feeds alphabetically (i.e., RemoteApps first, Desktops second).
- Fixed multiple accessibility bugs improving screen reader compatibility.
- Updated our build tools.
- Various bug fixes.

## Updates for version 1.0.7
*Date published: 1/24/2019*

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
*Date published: 10/29/2018*

- Added an option to **Capture support information** on the About page to diagnose issues.
- InPrivate mode is now supported.
- Improved support for non-English keyboards.
- Fixed an issue where tooltips with non-English characters showed incorrectly.
- Fixed graphics rendering issue which affected Chrome users.
- Updated time zone redirection with full DST support.
- Improved the error message for out-of-memory error.
- Various bug fixes.

## Updates for version 1.0.0
*Date published: 07/16/2018*

- Remote Desktop web client is now generally available.
- Admins can globally turn off telemetry for the web client.
- Various bug fixes.

## Updates for version 0.9.0
*Date published: 07/05/2018*

- New sign in experience within the web client.
- No longer prompted for credentials when launching a desktop or app connection (Single sign on).
- Moved the web client to a new URL: <https://server_FQDN/RDWeb/webclient/index.html>
- Added time zone redirection.
- Various bug fixes.

## Updates for version 0.8.1
*Date published: 05/17/2018*

- Updates to address CredSSP encryption oracle remediation described in CVE-2018-0886.
- Fixed connection failures for some languages when printing is enabled.
- Improved error message when a gateway is not part of the deployment.
- **Help** and **Feedback** options were added.

## Updates for version 0.8.0
*Date published: 03/28/2018*

- Initial public preview release of the web client.
- Copy/paste text through the clipboard with **CTRL+C** and **CTRL+V**.
- Print to a PDF file.
- Localized in 18 languages.
