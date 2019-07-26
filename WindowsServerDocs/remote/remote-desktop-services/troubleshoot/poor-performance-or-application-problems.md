---
title: Poor performance or application problems during remote desktop connection
description: Troubleshooting poor performance or application problems during remote desktop connection.
audience: itpro ​
ms.custom: na
ms.reviewer: rklemen
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: troubleshooting
ms.assetid: 
author: kaushika-msft
manager: 
ms.author: delhan
ms.date: 07/24/2019
ms.localizationpriority: medium
---

# Poor performance or application problems during remote desktop connection

This article addresses several common issues that users can experience when they use remote desktop functionality.

### Intermittent problems with new Microsoft Azure virtual machines

This issue affects virtual machines that have been recently provisioned. After the user connects to the virtual machine, the remote desktop session does not load all the user’s settings correctly.

To work around this issue, disconnect from the virtual machine, wait for at least 20 minutes, and then connect again.

To resolve this issue, apply the following updates to the virtual machines, as appropriate:

  - Windows 10 and Windows Server 2016: KB 4343884, [August 30, 2018—KB4343884 (OS Build 14393.2457)](https://support.microsoft.com/help/4343884/windows-10-update-kb4343884)
  - Windows Server 2012 R2: KB 4343891, [August 30, 2018—KB4343891 (Preview of Monthly Rollup)](https://support.microsoft.com/help/4343891/windows-81-update-kb4343891)

### Video playback issues on Windows 10 version 1709

This issue occurs when users connect to remote computers that are running Windows 10, version 1709. When these users play video using the VMR9 (Video Mixing Renderer 9) codec, the player shows only a black window.

This is a known issue in Windows 10, version 1709. The issue doesn't occur in Windows 10, version 1703.

### Desktop sharing issues on Windows 10

This issue occurs when the user has a read-only user profile (and associated registry hive), such as in a kiosk scenario. When such a user connects to a remote computer that is running Windows 10, version 1803, they can't share their desktop.

To fix this issue, apply the Windows 10 update 4340917, [July 24, 2018—KB4340917 (OS Build 17134.191)](https://support.microsoft.com/help/4340917/windows-10-update-kb4340917).

### Performance issues when mixing versions of Windows 10 if NLA is disabled

This issue occurs when Remote Desktop client computers running Windows 10 connect to remote desktops that run different versions of Windows 10 while NLA is disabled. Users of Remote Desktop clients on computers running Windows 10, version 1709 or earlier experience poor performance when they connect to remote desktops running Windows 10, version 1803 or later.

This occurs because, when NLA is disabled, the older client computers use a slower protocol when they connect to Windows 10, version 1803 or a later version.

To resolve this issue, apply KB 4340917, [July 24, 2018—KB4340917 (OS Build 17134.191)](https://support.microsoft.com/help/4340917/windows-10-update-kb4340917).

### Black screen issue

This issue occurs in Windows 8.0, Windows 8.1, Windows 10 RTM, and Windows Server 2012 R2. A user launches multiple applications in a remote desktop, then disconnects from the session. Periodically, the user reconnects to the remote desktop to interact with the applications, and then disconnects again. At some point, when the user reconnects, the remote desktop session only shows a black screen. To get the session to display properly again, the user then has to end their session from either the remote computer's console or the RDSH server console and stop their session's applications.

To resolve this issue, apply the following updates as appropriate:

  - Windows 8 and Windows Server 2012: KB4103719, [May 17, 2018—KB4103719 (Preview of Monthly Rollup)](https://support.microsoft.com/help/4103719/windows-server-2012-update-kb4103719)
  - Windows 8.1 and Windows Server 2012 R2: KB4103724, [May 17, 2018—KB4103724 (Preview of Monthly Rollup)](https://support.microsoft.com/help/4103724/windows-81-update-kb4103724) and KB 4284863, [June 21, 2018—KB4284863 (Preview of Monthly Rollup)](https://support.microsoft.com/help/4284863/windows-81-update-kb4284863)
  - Windows 10: Fixed in KB4284860, [June 12, 2018—KB4284860 (OS Build 10240.17889)](https://support.microsoft.com/help/4284860/windows-10-update-kb4284860)
