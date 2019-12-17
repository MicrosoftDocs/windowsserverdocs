---
title: "Manage Digital Media in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9378bffa-487c-43ca-9ec3-7e7864d2dd9a
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Manage Digital Media in Windows Server Essentials

>Applies To: Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

The following topics discuss the media streaming features of your server, and explain how to set up and use media streaming on your network.  
  
> [!NOTE]
>  By default, the media streaming functionality is unavailable in  Windows Server Essentials and  Windows Server 2012 R2 with the  Windows Server Essentials Experience role installed. To add the media streaming functionality in these versions, [download and install the Windows Server Essentials Media Pack](https://www.microsoft.com/download/details.aspx?id=40837) from the Microsoft Download Center.  
  
-   [Digital media overview](Manage-Digital-Media-in-Windows-Server-Essentials.md#BKMK_1)  
  
-   [Manage media server using the Dashboard](Manage-Digital-Media-in-Windows-Server-Essentials.md#BKMK_2)  
  
-   [How media streaming works](Manage-Digital-Media-in-Windows-Server-Essentials.md#BKMK_3)  
  
-   [Turn media streaming on or off](Manage-Digital-Media-in-Windows-Server-Essentials.md#BKMK_4)  
  
-   [Add digital media files to the server](Manage-Digital-Media-in-Windows-Server-Essentials.md#BKMK_5)  
  
-   [Allow or restrict access to a media library on the server](Manage-Digital-Media-in-Windows-Server-Essentials.md#BKMK_6)  
  
-   [Rename the media library](Manage-Digital-Media-in-Windows-Server-Essentials.md#BKMK_8)  
  
-   [Stop sharing digital media](Manage-Digital-Media-in-Windows-Server-Essentials.md#BKMK_9)  
  
-   [Enable media devices that use the Server Message Block (SMB) protocol to access shared files on the server](Manage-Digital-Media-in-Windows-Server-Essentials.md#BKMK_10)  
  
-   [Common processors and the video profiles they support](Manage-Digital-Media-in-Windows-Server-Essentials.md#BKMK_CommonProcessors)  
  
-   [Known issues with media file types](Manage-Digital-Media-in-Windows-Server-Essentials.md#BKMK_KnownIssues)  
  
##  <a name="BKMK_1"></a> Digital media overview  
 Digital media refers to audio, video, and photo content that has been encoded (digitally compressed). Encoding content involves converting audio and video input to a digital media file such as a Windows Media file. After digital media is encoded, it can be easily manipulated, distributed, and played by computers, and it is easily transmitted over computer networks.  
  
 Examples of digital media types include: Windows Media Audio (WMA), Windows Media Video (WMV), MP3, JPEG, and AVI. For information about the digital media types that are supported by Windows Media Player, see [File types supported by Windows Media Player](https://support.microsoft.com/kb/316992).  
  
### Why would I want to stream my digital media?  
 Many people store music, video, and pictures in shared folders in  Windows Server Essentials. There may be times when you want to do the following:  
  
-   **Watch videos**. Your server can be used to store and stream large collections of videos and recorded TV shows to your computers or other playback devices on your network. You can stream videos to an Xbox 360 or to a computer by using Windows Media Player.  
  
-   **Play music**. When you turn on Media Sharing for the **Music** shared folder, you can access your music from devices that support Windows Media Connect. You do not need to enable or configure any user accounts to stream from the **Music** shared folder after sharing is turned on.  
  
-   **Present photo slide shows**. You can store your digital photos in the **Photos** shared folder on your server and then access them from any computer or from an Xbox 360 that is connected to a TV in your home or office. You can watch photo slide shows, which is like turning your TV into a large picture frame.  
  
###  <a name="BKMK_1.5"></a> Sharing copy-protected media  
  Windows Server Essentials does not support sharing copy-protected media. This includes music that is purchased through an online music store.  
  
 Copy-protected media can be played back only on the computer or device that you used to purchase it. Copy protection prevents you from playing media on more than one computer or device, even if you copy the media to your server and play it from there. However, you can store the copy-protected media on  Windows Server Essentials and continue to play back the media on the computer or device that you used to purchase it.  
  
##  <a name="BKMK_2"></a> Manage media server using the Dashboard  
  Windows Server Essentials makes it possible to perform common administrative tasks by using the  Windows Server Essentials Dashboard. The **Media** tab of the server **Settings** page of the Dashboard provides the following:  
  
|Section|Functionality|  
|-------------|-------------------|  
|Media server|The **Turn on/Turn off** button enables you to turn media streaming on or off.|  
|Video streaming quality|The drop-down arrow enables you to choose the video streaming quality of the videos that are played from the server.|  
|Media library|Displays the name of the media library. The default name of the library is called **Digital Media Library**, which is created when you turn on media streaming. To change the media library name, see [Rename the media library](Manage-Digital-Media-in-Windows-Server-Essentials.md#BKMK_8). You can click **Customize** to customize the folders that are shared into the media library.|  
  
 For more information, see [Allow or restrict access to a media library on the server](Manage-Digital-Media-in-Windows-Server-Essentials.md#BKMK_6) and [Sharing copy-protected media](Manage-Digital-Media-in-Windows-Server-Essentials.md#BKMK_1.5).  
  
##  <a name="BKMK_3"></a> How media streaming works  
 The media streaming feature in  Windows Server Essentials makes it possible for networked computers and some networked digital media devices to play digital media files that are stored on the server.  
  
 When you turn the media server on, content that you share in the media libraries will be available for play on devices on your network that are capable of receiving streaming media from your server. You can stream most types of digital media files. Some of the more common types of files that you can stream include:  
  
- Windows Media formats (.asf, .wma, .wmv, .wm)  
  
- Audio Visual Interleave (.avi)  
  
- Moving Pictures Experts Group (.mpeg, .mpg, .mp3)  
  
- Audio for Windows (.wav)  
  
- CD Audio Track (.cda)  
  
  To play a file, simply locate a song, video, or picture in a shared folder, double-click the file, and the content will stream from the server to your computer and play. For information about how to find and play the digital media files that are stored on the server, see [Play Digital Media](../use/Play-Digital-Media-in-Windows-Server-Essentials.md).  
  
  To stream your media, you need the following hardware:  
  
- A wired or wireless private network  
  
- Either another computer on your network or a device known as a digital media receiver (sometimes called a networked digital media player). Digital media receivers are hardware devices connected to your wired or wireless network that you can control by using your computer ?even if your computer is in another room.  
  
  For more information, see [Turn media streaming on or off](Manage-Digital-Media-in-Windows-Server-Essentials.md#BKMK_4).  
  
##  <a name="BKMK_4"></a> Turn media streaming on or off  
 You can share music, videos, and pictures from  Windows Server Essentials by streaming files to any supported digital media receiver (DMR) such as computers, mobile phones, televisions, digital media receivers, extenders for Windows Media Center (including Xbox 360), and other personal electronic devices.  
  
 For a current list of digital media devices that are compatible with  Windows Server Essentials, see the [Windows Compatibility Center](https://www.microsoft.com/windows/compatibility/CompatCenter/Home).  
  
### Enabling media sharing  
 To share the media that is stored in  Windows Server Essentials, you need to turn on media streaming. Media streaming is turned off by default.  
  
####  <a name="BKMK_2.5"></a> To turn media streaming on or off  
  
1. Open the  Windows Server Essentials Dashboard.  
  
2. Click **Settings**, click **Media**, and then do one of the following:  
  
   -   Click **Turn on** to start sharing all of the files that are stored in the Media Library of the server.  
  
   -   Click **Turn off** to stop sharing all of the files that are stored in the Media Library of the server.  
  
3. If you want share additional folders in the Media Library, click **Customize**, and then select **Yes** for each shared folder that you want to include in the Media Library.  
  
4. Click **OK** to save your changes.  
  
   For information about the digital media types supported by Windows Media Player, see [File types supported by Windows Media Player](https://support.microsoft.com/kb/316992).  
  
   For more information, see [Allow or restrict access to a media library on the server](Manage-Digital-Media-in-Windows-Server-Essentials.md#BKMK_6).  
  
##  <a name="BKMK_5"></a> Add digital media files to the server  
 The server administrator can add digital media to shared folders in the media library by accessing the server directly, or by using the  Remote Web Access site to sign in to the Dashboard. Other users can add media files to the server by using the **Shared Folders** connection on the Launchpad, by using the  Remote Web Access site, or by using the My Server app for Windows Phone. For information about playing media, see [Play Digital Media](../use/Play-Digital-Media-in-Windows-Server-Essentials.md).  
  
> [!NOTE]
>  You can also upload media files to the server by using the My Server app for Windows Phone. You can download the My Server app from the [Windows Phone store](http://www.windowsphone.com/store/app/my-server/6c2f98d5-6fcf-4e1d-b8b1-cde62ea1a94a). For more information about the My Server app for Windows phone, see the blog post [My Server phone app for Windows Server Essentials](http://blogs.technet.com/b/sbs/archive/2012/09/18/my-server-phone-app-for-windows-server-2012-essentials.aspx).  
  
#### To add digital media files to shared folders on the server  
  
1.  Use one of the following methods to sign in to the server:  
  
    1.  For information about logging on to Remote Web Access, see [Log on to Remote Web Access](../use/Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_1).  
  
    2.  For information about signing in with Launchpad, see [Launchpad Overview](Overview-of-the-Launchpad-in-Windows-Server-Essentials.md).  
  
2.  Search for and click the folder for the media that you are adding.  
  
3.  Copy and paste, or drag-and-drop the media files that you want add to the appropriate shared folder on the server.  
  
##  <a name="BKMK_6"></a> Allow or restrict access to a media library on the server  
  
-   When you turn on media sharing, it creates four predefined folders: Music, Pictures, Videos, and Recorded TV. If any of these folders preexists on the server, the existing folder is reused as a shared folder for media sharing. All the existing folder's media content and user permissions are preserved, and they are shared with all network users.  
  
-   Before you turn on Media Library Sharing for a shared folder, you should know that Media Library Sharing bypasses any type of user-account access that you set for the shared folder. For example, let's say that you turn on Media Library Sharing for the **Photos** shared folder, and you set the **Photos** shared folder to **No Access** for a user account named Bobby. Bobby can still stream any digital media from the **Videos** shared folder to any supported digital media player or DMR. If you have digital media that you do not want to stream in this manner, store the files in a folder that does not have Media Library Sharing turned on.  
  
-   If you turn on Media Library Sharing for a shared folder, any supported digital media player or DMR that can access your  Windows Server Essentials network can also access your digital media in that shared folder. For example, if you have a wireless network and you have not secured it, anybody within range of your wireless network can potentially access your digital media in that folder. Before you turn on Media Library Sharing, make sure that you secure your wireless network. For more information, see the documentation for your wireless access point.  
  
##  <a name="BKMK_8"></a> Rename the media library  
 The default name of the media library is **Digital Media Server**. It is created when you turn on media streaming in  Windows Server Essentials. For more information about turning on media streaming, see [To turn media streaming on or off](Manage-Digital-Media-in-Windows-Server-Essentials.md#BKMK_2.5). You can modify the media library name at any time by using the server Dashboard.  
  
#### To rename the media library  
  
1.  Open the server Dashboard. To open the Dashboard from the Launchpad, click **Dashboard**, type the server password, and then click the arrow to sign in.  
  
2.  On the server Dashboard, click **Settings**.  
  
3.  On the **Settings** page, click the **Media** tab.  
  
4.  In the **Media library** section of the **Media settings** page, click the name of your media library.  
  
5.  In the **Change the Media Library Name** dialog box, type a new name for the media library, and then click **OK**.  
  
##  <a name="BKMK_9"></a> Stop sharing digital media  
 The server administrator can stop sharing digital media that is stored in shared folders on a server running  Windows Server Essentials.  
  
#### To stop sharing media in shared folders  
  
1.  Open the server Dashboard.  
  
2.  On the Dashboard **Home** page, click **Setup**, click **Set up Media Server**, and then click **Click to Set up Media Server**.  
  
3.  On the **Media** settings page, you can choose one of the following options:  
  
    -   Click **Turn off** to stop sharing all of the files that are stored on the server.  
  
    -   Click **Customize**, and then select **No** for specific folders that you want to stop sharing.  
  
4.  Click **Apply** or **OK** to save your changes.  
  
##  <a name="BKMK_10"></a> Enable media devices that use the Server Message Block (SMB) protocol to access shared files on the server  
 Devices that use Server Message Block (SMB) for network file and share access instead of DLNA (for media streaming) require that the Guest account be activated. This allows any device or user on the network to view the contents of shared folders without authentication.  
  
> [!CAUTION]
>  When you enable the Guest account, anyone can access the shared resources on the server by default.  
  
##  <a name="BKMK_CommonProcessors"></a> Common processors and the video profiles they support  
 To stream media from your  Windows Server Essentials server, you can use a computer that is running the Windows 7 or Windows 8 operating system or other networked devices (such as digital media players), or Media Center extenders (such as Xbox 360). When you are away from your network, use Remote Web Access Media Player to play files that are stored on your server.  
  
 You need a data transfer rate between 200 KBps and 10 MBps. You need to use media formats that your computer and devices can recognize and play. Not all devices support the same media formats, so there must be a way for your computer and devices to play the media files that you have.  
  
  Windows Server Essentials contains transcoding support that determines the capability of the computer or device, and then dynamically converts an unsupported video file into a supported one. In general, if Windows Media Player 12 can play the content on a computer that is running Windows 7 or Windows 8, the content on the server will play on the network-connected device.  
  
 The format and bit rate chosen for transcoding is highly dependent on the performance of the server processor. The processor performance is identified as part of the Windows Experience Index. To determine the performance score of your server, do one of the following:  
  
- On a network computer running Windows 7 or Windows 8 that has the same processor as your server, go to the **Control Panel**, click **Performance Information and Tools**, and then review the information on the **Rate and improve your computer's performance** page.  
  
- Contact the manufacturer of the processor.  
  
  For the best user experience, choose a video streaming resolution quality that is appropriate for your server processor. The server will automatically adjust the bit rate to one of these settings:  
  
- **Low** if the processor score is less than 3.6.  
  
- **Medium** if the processor score is greater than 3.6 and less than 4.2.  
  
- **High** if the processor score is greater than 4.2 and less than 6.0.  
  
- **Best** if the processor score is greater than 6.0.  
  
  If you choose a video streaming resolution that requires more processing power than your server has, you may experience buffers and stops while streaming media from the server.  
  
> [!NOTE]
>  To stream high-definition video through Remote Web Access, you need a processor with a score of at least 6.0.  
  
##  <a name="BKMK_KnownIssues"></a> Known issues with media file types  
 The media streaming feature in Remote Web Access uses the Windows Media Player 12 Network Sharing Service. Remote Web Access media streaming supports the audio, video, and picture file types that are supported by Windows Media Player 12 and Silverlight 4.  
  
 The following table lists the file types (formats) that are supported by Remote Web Access media streaming. If there are media file types on your server that are not included in the table, you cannot stream them through Remote Web Access media streaming.  
  
|File Type|File Name Extension|  
|---------------|-------------------------|  
|3GPP files|.3gp, .3gpp, .3g2, and .3gp2|  
|Audio Data Transport Stream (ADTS) audio files|.adts and .adt|  
|AU audio files|.au and .snd|  
|Audio Interchange File Format (AIFF) audio files|.aif, .aifc, and .aiff|  
|AVCHD files|.m2ts, .m2t, and .mts|  
|CD audio disk|.cda|  
|DVD-Video disk|.vob|  
|JPEG picture files|.jpg|  
|MP3 audio files|.mp3 and .m3u|  
|MPEG video files|.mpeg, .mpg, .m1v, .mpa, .mpe, .mp4, .mp4v, .m4v, .m4a, and .mov|  
|Windows audio and video files|.avi and .wav|  
|Windows Media audio and video files|.asf, .asx, .wax, .wm, .wma, .wmd, .wmp, .wmv, .wmx, .wpl, and .wvx|  
  
> [!NOTE]
>  If you cannot use a file type that is listed in this table, the file may also be encoded with a codec that is not supported by Windows Media Player.  
  
 For additional information about supported file formats, see [File types supported by Windows Media Player](https://go.microsoft.com/fwlink/p/?LinkID=196118) and [Supported media formats, protocols, and log fields](https://go.microsoft.com/fwlink/p/?LinkId=203339) for Silverlight.  
  
## See also  
  
-   [Play Digital Media](../use/Play-Digital-Media-in-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](Manage-Windows-Server-Essentials.md)
