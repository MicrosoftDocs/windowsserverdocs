---
title: Automatic Reconnection in RDS Lock Screen Security
description: The article discusses Microsoft Remote Desktop Services and its Automatic Reconnection feature and emphasizes that the lock screen of the Remote Desktop session is not a security boundary as reconnection does not require re-authentication.
author: tyadon
ms.author: riyadon
ms.reviewer: spatnaik
ms.topic: article
ms.date: 06/06/2023
---
# Automatic Reconnection in RDS: Lock Screen Security
Microsoft Remote Desktop Services offers a wide range of features designed to enhance your remote working experience. One such feature is Automatic Reconnection. 

Automatic Reconnection allows the client to seamlessly reconnect to their existing sessions, giving a smooth, uninterrupted user experience in case of temporary network disruptions. This behavior and protocol can be understood by visiting: [Automatic Reconnection | Microsoft Learn](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-rdpbcgr/e729948a-3f4e-4568-9aef-d355e30b5389)

When using Automatic Reconnection, it is crucial to note that the lock screen of the Remote Desktop session is not designed to function as a security boundary. When a policy or the user locks the remote session and the network connection is lost or disrupted, the Remote Desktop Services retains the session state and connection information, and the client will reconnect without needing to re-authenticate. If the automatic reconnection of locked sessions raises concerns for your specific use case, we recommend implementing additional security measures. This could include disabling automatic reconnection on either the RDS Host or the client: [Supported RDP properties with Remote Desktop Services | Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/rdp-files#session-behavior).
