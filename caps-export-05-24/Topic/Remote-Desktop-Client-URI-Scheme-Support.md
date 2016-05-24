---
title: Remote Desktop Client URI Scheme Support
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cdd88ac2-5414-4d7b-82d8-825b89cd3d63
author: lizap
---
# Remote Desktop Client URI Scheme Support
Enabling a Uniform Resource Identifier \(URI\) scheme gives IT professionals and developers a way to integrate features of the Remote Desktop clients across platforms and enriches the user experience by allowing:  
  
1.  Third\-party applications to launch Microsoft Remote Desktop and start remote sessions with predefined settings \(provided as part of the URI string\).  
  
2.  End users to start remote connections using pre\-configured URLs.  
  
Microsoft Remote Desktop uses the URI scheme *rdp:\/\/query\_string* to store pre\-configured attribute settings that are used when launching the client. The query strings represent a single or set of RDP attributes provided in the URL. The RDP attributes are separated by the ampersand symbol \(&\).  
  
For example, when connecting to a PC, the string is:  
  
*rdp:\/\/full%20address\=s:mypc:3389&audiomode\=i:2&disable%20themes\=i:1*  
  
This table gives a complete list of supported attributes that may be used with the iOS, Mac, and Android Remote Desktop clients. \(An “x” in the platform column indicates the attribute is supported. The values denoted by chevrons \(<>\) represent the values that are supported by the Remote Desktop clients.\)  
  
## RDP Attribute Table  
  
|RDP Attribute|Android|Mac|iOS|  
|-----------------|-----------|-------|-------|  
|allow desktop composition\=i:<0 or 1>|x|x|x|  
|allow font smoothing\=i:<0 or 1>|x|x|x|  
|alternate shell\=s:<string>|x|x|x|  
|[audiomode\=i:<0, 1, or 2>](http://technet.microsoft.com/library/ff393707.aspx)|x|x|x|  
|[authentication level\=i:<0, 1, or 2>](http://technet.microsoft.com/library/ff393709.aspx)|x|x|x|  
|connect to console\=i:<0 or 1>|x|x|x|  
|disable cursor settings\=i:<0 or1>|x|x|x|  
|disable full window drag\=i:<0 or 1>|x|x|x|  
|disable menu anims\=i:<0 or 1>|x|x|x|  
|disable themes\=i:<0 or 1>|x|x|x|  
|disable wallpaper\=i:<0 or 1>|x|x|x|  
|[drivestoredirect\=s:\*](https://technet.microsoft.com/library/ff393728(v=ws.10).aspx) \(this is the only supported value\)|x|x||  
|[desktopheight\=i:<value in pixels>](http://technet.microsoft.com/library/ff393702.aspx)||x||  
|[desktopwidth\=i:<value in pixels>](http://technet.microsoft.com/library/ff393697.aspx)||x||  
|[domain\=s:<string>](http://technet.microsoft.com/library/ff393673.aspx)|x|x|x|  
|[full address\=s:<string>](http://technet.microsoft.com/library/ff393661.aspx)|x|x|x|  
|gatewayhostname\=s:<string>|x|x|x|  
|[gatewayusagemethod\=i:<1 or 2>](http://msdn.microsoft.com/aa381329.aspx)|x|x|x|  
|[prompt for credentials on client\=i:<0 or 1>](https://technet.microsoft.com/library/ff393660(v=ws.10).aspx)||x||  
|[loadbalanceinfo\=s:<string>](http://technet.microsoft.com/library/ff393684.aspx)|x|x|x|  
|[redirectprinters\=i:<0 or 1>](http://technet.microsoft.com/library/ff393671(v=WS.10).aspx)||x||  
|remoteapplicationcmdline\=s:<string>|x|x|x|  
|remoteapplicationmode\=i:<0 or 1>|x|x|x|  
|remoteapplicationprogram\=s:<string>|x|x|x|  
|shell working directory\=s:<string>|x|x|x|  
|Use redirection server name\=i:<0 or 1>|x|x|x|  
|[username\=s:<string>](http://technet.microsoft.com/library/ff393678.aspx)|x|x|x|  
|[screen mode id\=i:<1 or 2>](http://technet.microsoft.com/library/ff393692.aspx)||x||  
|[session bpp\=i:<8, 15, 16, 24, or 32>](http://technet.microsoft.com/library/ff393680.aspx)||x||  
|[use multimon\=i:<0 or 1>](http://technet.microsoft.com/library/ff393695(v=ws.10).aspx)||x||  
  
