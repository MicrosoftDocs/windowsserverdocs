---
title: Remote Desktop clients feature comparison
description: Learn how the different Remote Desktop clients compare when it comes to features.
ms.topic: article
author: heidilohr
manager: femila
ms.author: helohr
ms.date: 06/02/2021
---

# Compare the clients: features

We're often asked how the different Remote Desktop clients compare to each other when connecting to Remote Desktop Services or remote PCs. The following table lists the features currently available in each of our clients.

## Client features

The following table compares the features of each client.

| Feature                                      | Windows (MSTSC)  | Remote Desktop app | Android      | iOS | macOS            | Web | Description                                                                                                                                                                                                         |
|----------------------------------------------|------------------|-----------------|--------------|-----|------------------|-----|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Remote Desktop sessions                      | X                | X               | X            | X   | X                | X   | Desktop of a remote computer presented in a full screen or windowed mode.                                                                                                                                           |
| Integrated RemoteApp sessions                | X                |                 |              |     | X                |     | Individual remote apps integrated into the local desktop as if they are running locally.                                                                                                                            |
| Immersive RemoteApp sessions                 |                  | X               | X            | X   |                  | X   | Individual remote apps presented in a window or maximized to a full screen.                                                                                                                                         |
| Multiple monitors                            | 16 monitor limit |                 |              |     | 16 monitor limit |     | Lets the user run Remote Desktop or remote apps on all local monitors.                                                                                                                                              |
| Dynamic resolution                           | X                | X               |              |     | X                | X   | Resolution and orientation of local monitors is dynamically reflected in the remote session. If the client is running in windowed mode, the remote desktop is resized dynamically to the size of the client window. |
| Smart sizing                                 | X                | X               |              |     | X                |     | Remote Desktop in Windowed mode is dynamically scaled to the window's size.                                                                                                                                         |
| Localization                                 | X                | X               | English only | X   |                  | X   | Client user interface is available in multiple languages.                                                                                                                                                           |
| Multi-factor authentication                  |                  | X               | X            | X   | X                | X   | Supports multi-factor authentication for remote connections.                                                                                                                                                        |

## Other resources

If you're looking for information about device redirections, check out [Compare the clients: redirections](remote-desktop-app-compare.md).
