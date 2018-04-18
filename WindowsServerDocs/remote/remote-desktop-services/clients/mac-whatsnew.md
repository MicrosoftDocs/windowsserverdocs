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
ms.date: 04/17/2018
ms.localizationpriority: medium
---
# What's new for the Remote Desktop client on macOS?

We regularly update the [Remote Desktop client for macOS](remote-desktop-mac.md), adding new features and fixing issues. Check out the latest updates below.

## Updates for version 10.1.7

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

- Fixed an issue where RemoteApp windows would reorder themselves.
- Resolved a bug that caused some RemoteApp windows to get stuck behind their parent window.
- Addressed a mouse pointer offset issue that affected some RemoteApp programs.
- Fixed an issue where starting a new connection gave focus to an existing session, instead of opening a new session window.
- We fixed an error with an error message - you'll see the correct message now if we can't find your gateway.
- The Quit shortcut (⌘ + Q) is now consistently shown in the UI.
- Improved the image quality when stretching in "fit to window" mode.
- Fixed a regression that caused multiple instances of the home folder to show up in the remote session.
- Updated the default icon for desktop tiles.
