---
title: On connecting, user receives Remote Desktop Service is currently busy message
description: Troubleshooting the Remote Desktop Service is currently busy error when users start a remote desktop connection.
ms.reviewer: rklemen
ms.topic: troubleshooting
author: kaushika-msft
manager: dcscontentpm
ms.author: delhan
ms.date: 07/24/2019
ms.localizationpriority: medium
---

# On connecting, user receives "Remote Desktop Service is currently busy" message

To determine an appropriate response to this issue, see the following:

- Does the Remote Desktop Services service becomes unresponsive (for example, the remote desktop client appears to "hang" at the Welcome screen).  
   - If the service becomes unresponsive, see [RDSH server memory issue](#rdsh-server-memory-issue).
   - If the client appears to be interacting with the service normally, continue to the next step.
- If one or more users disconnect their remote desktop sessions, can users connect again?  
   - If the service continues to deny connections no matter how many users disconnect their sessions, see [RD listener issue](#rd-listener-issue).
   - If the service begins accepting connections again after a number of users have disconnected their sessions, [check the connection limit policy](#check-the-connection-limit-policy).

## RDSH server memory issue

A memory leak has been found on some Windows Server 2012 R2 RDSH servers. Over time, these servers begin to refuse both remote desktop connections and local console sign-ins with messages like the following:

> The task you are trying to do can't be completed because Remote Desktop Service is currently busy. Please try again in a few minutes. Other users should still be able to sign in.

Remote Desktop clients attempting to connect also become unresponsive.

To work around this issue, restart the RDSH server.

To resolve this issue, apply KB 4093114, [April 10, 2018—KB4093114 (Monthly Rollup)](https://support.microsoft.com/help/4093114/), to the RDSH servers.

## RD listener issue

An issue has been noted on some RDSH servers that have been upgraded directly from Windows Server 2008 R2 to Windows Server 2012 R2 or Windows Server 2016. When a Remote Desktop client connects to the RDSH server, the RDSH server creates an RD listener for the user session. The affected servers keep a count of the RD listeners that increases as users connect, but never decreases.

You can work around this issue with the following methods:

  - Restart the RDSH server to reset the count of RD listeners
  - Modify the connection limit policy, setting it to a very large value. For more information about managing the connection limit policy, see [Check the connection limit policy](#check-the-connection-limit-policy).

To resolve this issue, apply the following updates to the RDSH servers:

  - Windows Server 2012 R2: KB 4343891, [August 30, 2018—KB4343891 (Preview of Monthly Rollup)](https://support.microsoft.com/help/4343891/windows-81-update-kb4343891)
  - Windows Server 2016: KB 4343884, [August 30, 2018—KB4343884 (OS Build 14393.2457)](https://support.microsoft.com/help/4343884/windows-10-update-kb4343884)


  
