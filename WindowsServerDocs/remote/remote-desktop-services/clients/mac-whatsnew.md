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
ms.date: 08/06/2018
ms.localizationpriority: medium
---
# What's new for the Remote Desktop client on macOS?

We regularly update the [Remote Desktop client for macOS](remote-desktop-mac.md), adding new features and fixing issues. Check out the latest updates below.

If you encounter any issues, you can always contact us via Help > Report an Issue.

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
- Fixed a problem that occured when you edit local resources after importing from Remote Desktop 8.
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
