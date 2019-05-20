---
title: What's new for Remote Desktop on Mac?
description: Learn about recent changes to the Remote Desktop client for Mac
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 04/29/2019
ms.localizationpriority: medium
---
# What's new for the Remote Desktop client on macOS?

We regularly update the [Remote Desktop client for macOS](remote-desktop-mac.md), adding new features and fixing issues. Check out the latest updates below.

If you encounter any issues, you can always contact us via **Help > Report an Issue**.

## Updates for version 10.2.13
*Published date: 5/8/2019*

- Fixed a hang that occurred when connecting via an RD Gateway.
- Added a privacy notice to the "Add Feed" dialog.

## Updates for version 10.2.12
*Published date: 4/16/2019* 

- Resolved random disconnects (with error code 0x904) that took place when connecting via an RD Gateway.
- Fixed a bug that caused the resolutions list in application preferences to be empty after installation.
- Fixed a bug that caused the client to crash if certain resolutions were added to the resolutions list.
- Addressed an ADAL authentication prompt loop when connecting to Windows Virtual Desktop deployments.

## Updates for version 10.2.10
*Published date: 3/30/2019*

- In this release we addressed instability caused by the recent macOS 10.14.4 update. We also fixed mispaints that appeared when decoding AVC codec data encoded by a server using NVIDIA hardware.

## Updates for version 10.2.9
*Published date: 3/6/2019*

- In this release we fixed an RD gateway connectivity issue that can occur when server redirection takes place.
- We also addressed an RD gateway regression caused by the 10.2.8 update.

## Updates for version 10.2.8
*Published date: 3/1/2019*

- Resolved connectivity issues that surfaced when using an RD Gateway.
- Fixed incorrect certificate warnings that were displayed when connecting.
- Addressed some cases where the menu bar and dock would needlessly hide when launching remote apps.
- Reworked the clipboard redirection code to address crashes and hangs that have been plaguing some users.
- Fixed a bug that caused the Connection Center to needlessly scroll when launching a connection.

## Updates for version 10.2.7
*Published date: 2/6/2019*

- In this release we addressed graphics mispaints (caused by a server encoding bug) that appeared when using AVC444 mode.

## Updates for version 10.2.6
*Published date: 1/28/2019*

- Added support for the AVC (420 and 444) codec, available when connecting to current versions of Windows 10.
- In Fit to Window mode, a window refresh now occurs immediately after a resize to ensure that content is rendered at the correct interpolation level.
- Fixed a layout bug that caused feed headers to overlap for some users.
- Cleaned up the Application Preferences UI.
- Polished the Add/Edit Desktop UI.
- Made lots of fit and finish adjustments to the Connection Center tile and list views for desktops and feeds.

>[!NOTE]
>There is a bug in macOS 10.14.0 and 10.14.1 that can cause the ".com.microsoft.rdc.application-data_SUPPORT/_EXTERNAL_DATA" folder (nested deep inside the ~/Library folder) to consume a large amount of disk space. To resolve this issue, delete the folder content and upgrade to macOS 10.14.2. Note that a side-effect of deleting the folder contents is that snapshot images assigned to bookmarks will be deleted. These images will be regenerated when reconnecting to the remote PC.

## Updates for version 10.2.4
*Published date: 12/18/2018*

- Added dark mode support for macOS Mojave 10.14.
- An option to import from Microsoft Remote Desktop 8 now appears in the Connection Center if it is empty.
- Addressed folder redirection compatibility with some third-party enterprise applications.
- Resolved issues where users were getting a 0x30000069 Remote Desktop Gateway error due to security protocol fallback issues.
- Fixed progressive rendering issues some users were experiencing with fit to window mode.
- Fixed a bug that prevented file copy and paste from copying the latest version of a file.
- Improved mouse-based scrolling for small scroll deltas.

## Updates for version 10.2.3
*Published date: 11/06/2018*

- Added support for the "remoteapplicationcmdline" RDP file setting for remote app scenarios.
- The title of the session window now includes the name of the RDP file (and server name) when launched from an RDP file.
- Fixed reported RD gateway performance issues.
- Fixed reported RD gateway crashes.
- Fixed issues where the connection would hang when connecting through an RD gateway.
- Better handling of full-screen remote apps by intelligently hiding the menu bar and dock.
- Fixed scenarios where remote apps remained hidden after being launched.
- Addressed slow rendering updates when using "Fit to Window" with hardware acceleration disabled.
- Handled database creation errors caused by incorrect permissions when the client starts up. 
- Fixed an issue where the client was consistently crashing at launch and not starting for some users.
- Fixed a scenario where connections were incorrectly imported as full-screen from Remote Desktop 8.

## Updates for version 10.2.2
*Published date: 10/09/2018*

- A brand new Connection Center that supports drag and drop, manual arrangement of desktops, resizable columns in list view mode, column-based sorting, and simpler group management.
- The Connection Center now remembers the last active pivot (Desktops or Feeds) when closing the app.
- The credential prompting UI and flows have been overhauled.
- RD Gateway feedback is now part of the connecting status UI.
- Settings import from the version 8 client has been improved.
- RDP files pointing to RemoteApp endpoints can now be imported into the Connection Center.
- Retina display optimizations for single monitor Remote Desktop scenarios.
- Support for specifying the graphics interpolation level (which affects blurriness) when not using Retina optimizations.
- 256-color support to enable connectivity to Windows 2000.
- Fixed clipping of the right and bottom edges of the screen when connecting to Windows 7, Windows Server 2008 R2 and earlier.
- Copying a local file into Outlook (running in a remote session) now adds the file as an attachment.
- Fixed an issue that was slowing down pasteboard-based file transfers if the files originated from a network share.
- Addressed a bug that was causing to Excel (running in a remote session) to hang when saving to a file on a redirected folder.
- Fixed an issue that was causing no free space to be reported for redirected folders.
- Fixed a bug that caused thumbnails to consume too much disk storage on macOS 10.14.
- Added support for enforcing RD Gateway device redirection policies.
- Fixed an issue that prevented session windows from closing when disconnecting from a connection using RD Gateway.
- If Network Level Authentication (NLA) is not enforced by the server, you will now be routed to the login screen if your password has expired.
- Fixed performance issues that surfaced when lots of data was being transferred over the network.
- Smart card redirection fixes.
- Support for all possible values of the "EnableCredSspSupport" and "Authentication Level" RDP file settings if the ClientSettings.EnforceCredSSPSupport user default key (in the com.microsoft.rdc.macos domain) is set to 0.
- Support for the "Prompt for Credentials on Client" RDP file setting when NLA is not negotiated.
- Support for smart card-based login via smart card redirection at the Winlogon prompt when NLA is not negotiated.
- Fixed an issue that prevented downloading feed resources that have spaces in the URL.

## Updates for version 10.2.1
*Published date: 08/06/2018*

- Enabled connectivity to Azure Active Directory (AAD) joined PCs. To connect to an AAD joined PC, your username must be in one of the following formats: “AzureAD\user” or “AzureAD\user@domain”.
- Addressed some bugs affecting the usage of smart cards in a remote session.

## Updates for version 10.2.0
*Published date: 07/24/2018*

- Incorporated updates for GDPR compliance.
- MicrosoftAccount\username@domain is now accepted as a valid username.
- Clipboard sharing has been rewritten to be faster and support more formats.
- Copy and pasting text, images or files between sessions now bypasses the local machine’s clipboard.
- You can now connect via an RD Gateway server with an untrusted certificate (if you accept the warning prompts).
- Metal hardware acceleration is now used (where supported) to speed up rendering and optimize battery usage.
- When using Metal hardware acceleration we try to work some magic to make the session graphics appear sharper.
- Got rid of some instances where windows would hang around after being closed.
- Fixed bugs that were preventing the launch of RemoteApp programs in some scenarios.
- Fixed an RD Gateway channel synchronization error that was resulting in 0x204 errors.
- The mouse cursor shape now updates correctly when moving out of a session or RemoteApp window.
- Fixed a folder redirection bug that was causing data loss when copy and pasting folders.
- Fixed a folder redirection issue that caused incorrect reporting of folder sizes.
- Fixed a regression that was preventing logging into an AAD-joined machine using a local account.
- Fixed bugs that were causing the session window contents to be clipped.
- Added support for RD endpoint certificates that contain elliptic-curve asymmetric keys.
- Fixed a bug that was preventing the download of managed resources in some scenarios.
- Addressed a clipping issue with the pinned connection center.
- Fixed the checkboxes in the Display property sheet to work better together.
- Aspect ratio locking is now disabled when dynamic display change is in effect.
- Addressed compatibility issues with F5 infrastructure.
- Updated handling of blank passwords to ensure the correct messages are shown at connect-time.
- Fixed mouse scrolling compatibility issues with MapInfra Pro.
- Fixed some alignment issues in the Connection Center when running on Mojave.

## Updates for version 10.1.8
*Published date: 05/04/2018*

- Added support for changing the remote resolution by resizing the session window!
- Fixed scenarios where remote resource feed download would take an excessively long time.
- Resolved the 0x207 error that could occur when connecting to servers not patched with the CredSSP encryption oracle remediation update (CVE-2018-0886).

## Updates for version 10.1.7
*Published date: 04/05/2018*

- Made security fixes to incorporate CredSSP encryption oracle remediation updates as described in CVE-2018-0886.
- Improved RemoteApp icon and mouse cursor rendering to address reported mispaints.
- Addressed issues where RemoteApp windows appeared behind the Connection Center.
- Fixed a problem that occurred when you edit local resources after importing from Remote Desktop 8.
- You can now start a connection by pressing ENTER on a desktop tile.
- When you're in full screen view, CMD+M now correctly maps to WIN+M.
- The Connection Center, Preferences, and About windows now respond to CMD+M.
- You can now start discovering feeds by pressing ENTER on the **Adding Remote Resources** page.
- Fixed an issue where a new remote resources feed showed up empty in the Connection Center until after you refreshed.
 
## Updates for version 10.1.6
*Published date: 03/26/2018*

- Fixed an issue where RemoteApp windows would reorder themselves.
- Resolved a bug that caused some RemoteApp windows to get stuck behind their parent window.
- Addressed a mouse pointer offset issue that affected some RemoteApp programs.
- Fixed an issue where starting a new connection gave focus to an existing session, instead of opening a new session window.
- We fixed an error with an error message - you'll see the correct message now if we can't find your gateway.
- The Quit shortcut (⌘ + Q) is now consistently shown in the UI.
- Improved the image quality when stretching in "fit to window" mode.
- Fixed a regression that caused multiple instances of the home folder to show up in the remote session.
- Updated the default icon for desktop tiles.
