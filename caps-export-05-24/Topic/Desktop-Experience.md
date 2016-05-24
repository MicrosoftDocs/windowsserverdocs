---
title: Desktop Experience
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 36c98a41-36fe-4c1d-8582-3d7709be0882
author: jaimeo
---
# Desktop Experience
The Desktop Experience feature allows you to install a variety of applications and features that are not normally installed on a server. . If you are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the following [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] features are installed when you install Desktop Experience:  
  
-   Windows Media Player  
  
-   Video for Windows \(AVI support\)  
  
-   Windows SideShow  
  
-   Disk Cleanup  
  
-   Sync Center  
  
-   Sound Recorder  
  
-   Character Map  
  
-   Snipping Tool  
  
-   Support for desktop apps  
  
-   Windows Store  
  
If you are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], the following [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] features are installed when you install Desktop Experience:  
  
-   Windows Media Player  
  
-   Video for Windows \(AVI support\)  
  
-   Windows SideShow  
  
-   Disk Cleanup  
  
-   Sync Center  
  
-   Sound Recorder  
  
-   Character Map  
  
-   Snipping Tool  
  
-   Support for desktop apps  
  
-   Windows Store  
  
-   PC settings \(adds **Change PC settings** to the Settings charm\)  
  
-   The ability to play a slide show on your lock screen  
  
-   Integrated search \(searches through the Search charm integrate results from the local computer and the Internet through Bing\)  
  
> [!IMPORTANT]  
> When you install Desktop Experience in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], the integrated search is on by default. This feature sends information to Microsoft. You can turn off the integrated search feature with the following steps:  
  
### To turn off integrated search  
  
1.  Open the Windows charm bar \(WINDOWS\+C\)  
  
2.  Click **Settings**, click **Change PC Settings**, and then click **Search & Apps**.  
  
3.  In the **Use Bing to search online** section, move the slider to **Off**. Alternately, in the **Your Search Experience** section, select **Don’t get personalized results from Bing**.  
  
> [!NOTE]  
> The Desktop Experience feature requires that you also install the Graphical Management Tools and Infrastructure and Server Graphical Shell features.  
  
Media Foundation, which includes Windows Media Foundation, the Windows Media Format SDK, and a server subset of DirectShow, provides the infrastructure required for applications and services to transcode, analyze, and generate thumbnails for media files. You can install Media Foundation separately with Server Manager—but if you install the Desktop Experience feature, you must install the Media Foundation feature as well.  
  
