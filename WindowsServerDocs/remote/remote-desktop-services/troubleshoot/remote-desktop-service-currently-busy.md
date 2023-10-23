---
title: On connecting, user receives Remote Desktop Service is currently busy message
description: Troubleshooting the Remote Desktop Service is currently busy error when users start a remote desktop connection.
ms.reviewer: rklemen
ms.topic: troubleshooting
author: kaushika-msft
manager: dcscontentpm
ms.author: delhan
ms.date: 07/24/2019
---

# On connecting, user receives "Remote Desktop Service is currently busy" message

To determine an appropriate response to this issue, see the following:

- Does the Remote Desktop Services service becomes unresponsive (for example, the remote desktop client appears to "hang" at the Welcome screen).  
   - If the service becomes unresponsive, see [RDSH server memory issue](#rdsh-server-memory-issue).
   - If the client appears to be interacting with the service normally, continue to the next step.
- If one or more users disconnect their remote desktop sessions, can users connect again?  
   - If the service continues to deny connections no matter how many users disconnect their sessions, see [RD listener issue](#rd-listener-issue).
   - If the service begins accepting connections again after a number of users have disconnected their sessions, [check the connection limit policy](#check-the-connection-limit-policy).

## RD listener issue

An issue has been noted on some RDSH servers that have been upgraded directly to Windows Server 2016. When a Remote Desktop client connects to the RDSH server, the RDSH server creates an RD listener for the user session. The affected servers keep a count of the RD listeners that increases as users connect, but never decreases.

You can work around this issue with the following methods:

  - Restart the RDSH server to reset the count of RD listeners
  - Modify the connection limit policy, setting it to a very large value. For more information about managing the connection limit policy, see [Check the connection limit policy](#check-the-connection-limit-policy).

To resolve this issue, apply the [KB 4343884](https://support.microsoft.com/help/4343884/windows-10-update-kb4343884) update to the RDSH servers.

## Check the connection limit policy

You can set the limit on the number of simultaneous remote desktop connections at the individual computer level or by configuring a group policy object (GPO). By default, the limit is not set.

To check the current settings and identify any existing GPOs on the RDSH server, open a command prompt window as an administrator and enter the following command:
  
```cmd
gpresult /H c:\gpresult.html
```
   
After this command finishes, open **gpresult.html**. In **Computer Configuration\\Administrative Templates\\Windows Components\\Remote Desktop Services\\Remote Desktop Session Host\\Connections**, find the **Limit number of connections** policy.

  - If the setting for this policy is **Disabled**, then group policy is not limiting RDP connections.
  - If the setting for this policy is **Enabled**, then check **Winning GPO**. If you need to remove or change the connection limit, edit this GPO.

To enforce policy changes, open a command prompt window on the affected computer, and enter the following command:
  
```cmd
gpupdate /force
```
  
