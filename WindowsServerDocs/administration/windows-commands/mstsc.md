---
title: mstsc
description: Reference article for the mstsc command, which creates connections to Remote Desktop Session Host servers or other remote computers and edits an existing Remote Desktop Connection (.rdp) configuration file
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/19/2022
ai-usage: ai-assisted
---

# mstsc

Creates connections to Remote Desktop Session Host servers or other remote computers and edits an existing Remote Desktop Connection (.rdp) configuration file.

## Syntax

```
mstsc.exe [<connectionfile>] [/v:<server>[:<port>]] [/g:<gateway>] [/admin] [/f[ullscreen]] [/w:<width> /h:<height>] [/public] [/span] [/multimon] [/l] [/restrictedAdmin] [/remoteGuard] [/prompt] [/shadow:<sessionID> [/control] [/noConsentPrompt]]
mstsc.exe /edit <connectionfile>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<connectionfile>` | Specifies the name of an **.rdp** file for the connection. |
| /v:`<server>[:<port>]` | Specifies the remote computer and, optionally, the port number to which you want to connect. |
| /g:`<gateway>` | Specifies the RD Gateway server to use for the connection. The command only reads this parameter when you specify the endpoint PC with `/v`. |
| /admin | Connects you to a session for administering the server. |
| /f[ullscreen] | Starts Remote Desktop Connection in full-screen mode. `/f` and `/fullscreen` are equivalent. |
| /w:`<width>` | Specifies the width of the Remote Desktop window. |
| /h:`<height>` | Specifies the height of the Remote Desktop window. |
| /public | Runs Remote Desktop in public mode. In public mode, Remote Desktop doesn't cache passwords and bitmaps. |
| /span | Matches the Remote Desktop width and height to the local virtual desktop and spans the Remote Desktop session across multiple monitors. The monitors must have the same resolution and be aligned horizontally (side by side). This parameter differs from `/multimon`, which mirrors the client-side monitor layout instead of spanning a single desktop. |
| /multimon | Configures the Remote Desktop Services session monitor layout to be identical to the current client-side configuration. |
| /l | Enumerates the monitors attached to the local PC and the ID associated with each monitor. You can use the monitor IDs to populate the `selectedmonitors` RDP file setting. |
| /edit `<connectionfile>` | Opens the specified **.rdp** file for editing. |
| /restrictedAdmin | This mode won't send your credentials to the remote PC, which can protect you if you connect to a compromised device. Other PCs might not authenticate connections from the remote PC, which affects application functionality and compatibility. This mode implies the `/admin` parameter. |
| /remoteGuard | This mode prevents the command from sending your credentials to the remote PC, which can help protect your credentials if you connect to a compromised device. Unlike Restricted Administrator mode, Remote Guard also supports connections from the remote PC by redirecting all requests back to your device. |
| /prompt | Prompts you for your credentials when you connect to the remote PC. |
| /shadow:`<sessionID>` | Specifies the ID of the session to shadow. |
| /control | Allows control of the session when shadowing. |
| /noConsentPrompt | Allows shadowing without user consent. |
| /? | Shows the Remote Desktop Connection Usage dialog box. |

### Remarks

- Each user has a hidden Default.rdp file in the **Documents** folder.

- By default, Windows saves user-created **.rdp** files in the user's **Documents** folder, but you can save them anywhere.

- To span across monitors, the monitors must use the same resolution and must align horizontally (that is, side-by-side). There's currently no support for spanning multiple monitors vertically on the client system.

### Examples

To connect to a session in full-screen mode, type:

```
mstsc /f
```

Use the equivalent `/fullscreen` parameter:

```
mstsc /v:computer1 /fullscreen
```

To span a session across horizontally aligned monitors of the same resolution, type:

```
mstsc /v:computer1 /span
```

To assign width/height, type:

```
mstsc /v:computer1 /w:1920 /h:1080
```

To open a file called `filename.rdp` for editing, type:

```
mstsc /edit filename.rdp
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
