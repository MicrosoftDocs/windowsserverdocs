---
title: Remote Desktop clients URI scheme
description: Learn about the Uniform Resource Identifier scheme for Remote Desktop clients
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0c3f1eb6-835c-4522-99ff-56c6ee4bb911
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 06/11/2018
ms.localizationpriority: medium
---
# Remote Desktop client Universal Resource Identifier (URI) scheme support

>Applies to: Windows Server, version 1803, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

Enabling a Uniform Resource Identifier (URI) scheme gives IT professionals and developers a way to integrate features of the Remote Desktop clients across platforms and enriches the user experience by allowing: 

- Third-party applications to launch Microsoft Remote Desktop and start remote sessions with predefined settings (provided as part of the URI string).
- End users to start remote connections using pre-configured URLs.

>[!NOTE]
> Using a URI to connect to the RD client is NOT supported for Windows operating systems - use the URI with MacOS, iOS, and Android devices.

Microsoft Remote Desktop uses the URI scheme rdp://query_string to store pre-configured attribute settings that are used when launching the client. The query strings represent a single or set of RDP attributes provided in the URL. 

The RDP attributes are separated by the ampersand symbol (&). For example, when connecting to a PC, the string is:

```
rdp://full%20address=s:mypc:3389&audiomode=i:2&disable%20themes=i:1
```

This table gives a complete list of supported attributes that may be used with the iOS, Mac, and Android Remote Desktop clients. (An “x” in the platform column indicates the attribute is supported. The values denoted by chevrons (<>) represent the values that are supported by the Remote Desktop clients.)

| **RDP attribute**                                           | **Android** | **Mac** | **iOS** |
|---------------------------------------------------------|---------|-----|-----|
| allow desktop composition=i:&lt;0 or 1&gt;                    | x       | x   | x   |
| allow font smoothing=i:<0 or 1&gt;                         | x       | x   | x   |
| alternate shell=s:&lt;string&gt;                              | x       | x   | x   |
| [audiomode=i:&lt;0, 1, or 2&gt;](https://technet.microsoft.com/library/ff393707.aspx)                                | x       | x   | x   |
| [authentication level=i:&lt;0 or 1&gt;](https://technet.microsoft.com/library/ff393709.aspx)                         | x       | x   | x   |
| connect to console=i:&lt;0 or 1&gt;                           | x       | x   | x   |
| disable cursor settings=i:&lt;0 or 1&gt;                      | x       | x   | x   |
| disable full window drag=i:&lt;0 or 1&gt;                     | x       | x   | x   |
| disable menu anims=i:&lt;0 or 1&gt;                           | x       | x   | x   |
| disable themes=i:&lt;0 or 1&gt;                               | x       | x   | x   |
| disable wallpaper=i:&lt;0 or 1&gt;                            | x       | x   | x   |
| [drivestoredirect=s:*](https://technet.microsoft.com/library/ff393728(v=ws.10).aspx) (this is the only supported value) | x       | x   |     |
| [desktopheight=i:&lt;value in pixels&gt;](https://technet.microsoft.com/library/ff393702.aspx)                       |         | x   |     |
| [desktopwidth=i:&lt;value in pixels&gt;](https://technet.microsoft.com/library/ff393697.aspx)                        |         | x   |     |
| [domain=s:&lt;string&gt;](https://technet.microsoft.com/library/ff393673.aspx)                           | x | x | x |
| [full address=s:&lt;string&gt;](https://technet.microsoft.com/library/ff393661.aspx)                     | x | x | x |
| gatewayhostname=s:&lt;string&gt;                  | x | x | x |
| [gatewayusagemethod=i:&lt;1 or 2&gt;](https://msdn.microsoft.com/aa381329.aspx)               | x | x | x |
| [prompt for credentials on client=i:&lt;0 or 1&gt;](https://technet.microsoft.com/library/ff393660(v=ws.10).aspx) |   | x |   |
| [loadbalanceinfo=s:&lt;string&gt;](https://technet.microsoft.com/library/ff393684.aspx)                  | x | x | x |
| [redirectprinters=i:&lt;0 or 1&gt;](https://technet.microsoft.com/library/ff393671(v=ws.10).aspx)                 |   | x |   |
| remoteapplicationcmdline=s:&lt;string&gt;         | x | x | x |
| remoteapplicationmode=i:&lt;0 or 1&gt;            | x | x | x |
| remoteapplicationprogram=s:&lt;string&gt;         | x | x | x |
| shell working directory=s:&lt;string&gt;          | x | x | x |
| Use redirection server name=i:&lt;0 or 1&gt;      | x | x | x |
| [username=s:&lt;string&gt;](https://technet.microsoft.com/library/ff393678.aspx)                         | x | x | x |
| [screen mode id=i:&lt;1 or 2&gt;](https://technet.microsoft.com/library/ff393692.aspx)                   |   | x |   |
| [session bpp=i:&lt;8, 15, 16, 24, or 32&gt;](https://technet.microsoft.com/library/ff393680.aspx)        |   | x |   |
| [use multimon=i:&lt;0 or 1&gt;](https://technet.microsoft.com/library/ff393695(v=ws.10).aspx)          |   | x |   |