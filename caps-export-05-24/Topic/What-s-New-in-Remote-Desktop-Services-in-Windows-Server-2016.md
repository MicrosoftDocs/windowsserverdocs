---
title: What&#39;s New in Remote Desktop Services in Windows Server 2016
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5c9b04a5-3dea-4b42-a525-abcc48a177bc
author: lizap
---
# What&#39;s New in Remote Desktop Services in Windows Server 2016
The following features have been added to Remote Desktop as part of Windows Server 2016. Most items include a link for more information \- be sure to check out those links.  
  
After you install the latest version of Windows Server 2016 and have had a chance to try out some of these great new features, drop by the [Remote Desktop Service user voice forum](https://remotedesktop.uservoice.com/forums/266795-remote-desktop-services-for-enterprises) to let us know what you think.  
  
## Personal session desktops  
Administrators can now deploy server\-based personal desktops in Windows Server 2016. With personal session desktops, each user gets an assigned RD Session Host \(RDSH\) VM \- the admin can optionally enable administrative rights for users. See [Introducing Personal Session Desktops](http://social.technet.microsoft.com/wiki/contents/articles/31780.windows-server-2016-remote-desktop-services-introducing-personal-session-desktops.aspx) by Clark Nicholson for more information.  
  
## Support for Gen 2 VMs  
You can now use Gen 2 VMs \(virtual machines\) with Remote Desktop. You can use Gen 2 VMs as template images for pooled\/personal VM collections and personal session desktop collections. There's no additional configuration required, so deploy at will.  
  
## Pen remoting support  
Pen devices \- like those available with Surface Pro 3 devices \- are now supported for use through Remote Desktop connections. Technically, you always could use the pens, but it was treated like a mouse. Now we treat pen devices as equal to your mouse, fingertip, and keyboard. David Bélanger has a [great post  covering how to use pen remoting](http://blogs.msdn.com/b/rds/archive/2015/07/22/introducing-pen-remoting-for-windows-10-and-windows-server-2016.aspx).  
  
## Edge support in RDSH  
You may have heard that we released a new Web browser \- [Microsoft Edge](http://www.microsoft.com/en-us/windows/microsoft-edge). Test Edge in Remote Desktop to see how it handles your apps and meets your needs.  
  
## OpenGL applications and guest VMs in Remote Desktop  
RemoteFX vGPU support in Windows Server 2016 adds support for OpenGL applications and Windows Server 2016 guest VMs.  Check out the [RemoteFX vGPU information in the RDS blog](http://blogs.msdn.com/b/rds/archive/2014/11/05/remotefx-vgpu-updates-in-windows-server-next.aspx) to get more details and step\-by\-step instructions on how to test this support.  
  
## Windows Multipoint Services  
Multipoint services is a low\-cost, single\-server multi\-user solution that is easy to deploy and easy to manage. Multipoint is now part of Windows Server 2016 as an optional role, instead of a separate product. When you enable the Multipoint services role, we also install RDSH.  
  
For more details on this new feature, particularly an FAQ, see Tanmay Bhagwat's post on [MultiPoint Services](http://blogs.msdn.com/b/rds/archive/2014/10/27/announcing-the-multipoint-services-role-in-window-server-vnext-technical-preview.aspx) on the RDS blog.  
  
## Client updates  
We regularly update our Remote Desktop clients \- see [Microsoft Remote Desktop Clients](https://technet.microsoft.com/library/dn473009.aspx) for the latest details.  
  
But, in particular, you should check out these:  
  
-   [Remote Desktop preview app for Windows 10](http://blogs.msdn.com/b/rds/archive/2015/07/10/test-drive-the-new-microsoft-remote-desktop-preview-app-for-windows-10.aspx) \- You can get it from the Microsoft store on any device running Windows 10 or Windows Server 2016 Technical Preview.  
  
-   [Remote Desktop preview app for Mac](http://blogs.msdn.com/b/rds/archive/2015/08/11/introducing-the-new-microsoft-remote-desktop-preview-app-for-mac.aspx) \- You can get it from iTunes.  
  
