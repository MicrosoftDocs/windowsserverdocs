---
title: "Change Media Streaming Settings"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dec690d2-f80c-4b09-99d6-3bba41331972
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Change Media Streaming Settings

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

Multiple options are available for you to change media streaming settings. The following options are available:  
  
-   [Hide remote media streaming add-in](Change-Media-Streaming-Settings.md#BKMK_DisableRemote)  
  
-   [Set the media library name](Change-Media-Streaming-Settings.md#BKMK_LibraryName)  
  
-   [Set video streaming quality](Change-Media-Streaming-Settings.md#BKMK_StreamingQuality)  
  
-   [Programmatically enable or disable media streaming](Change-Media-Streaming-Settings.md#BKMK_Program)  
  
##  <a name="BKMK_DisableRemote"></a> Hide remote media streaming add-in  
 You can hide the remote media streaming add-in by adding an entry in the registry.  
  
#### To hide the remote media streaming add-in  
  
1.  On the server, move your mouse to the upper right corner of the screen, and click **Search**.  
  
2.  In the **Search** box, type **regedit**, and then click the **Regedit** application.  
  
3.  In the left pane, expand down to the following registry entry:  
  
     **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Server\RemoteAccess\DisabledAddIns**  
  
4.  Right-click **DisabledAddIns**, point to **New**, and then click **DWORD Value**.  
  
5.  For the new value, type **497796c6-9cc7-43be-aa26-4e6b5695370d**, which is the identifier for the remote media streaming add-in, and then press **Enter**.  
  
6.  Right click the value, and then click **Modify**.  
  
7.  Type **1** for the value data, and then click **OK**.  
  
##  <a name="BKMK_LibraryName"></a> Set the media library name  
 You can use a class in the Windows Server Solutions SDK to set the name of the media library. To set the name of the media library, you can use the **SetMediaLibraryName** method of the **MediaStreamingManager** class in the **Microsoft.WindowsServerSolutions.MediaStreaming** namespace. The following example shows how to set the name of the media library:  
  
```c#  
  
MediaStreamingManager mediaStreamingManager = new MediaStreamingManager();  
string mediaLibraryName = Guid.NewGuid().ToString("B");   
mediaStreamingManager.SetMediaLibraryName(mediaLibraryName);  
  
```  
  
 For more information, see [Windows Server Solutions SDK](https://go.microsoft.com/fwlink/?LinkID=248648).  
  
##  <a name="BKMK_StreamingQuality"></a> Set video streaming quality  
 You set the video streaming quality by obtaining the WinSAT CPU score and then creating and installing the .xml file that contains the WinSAT score information. If the .xml file that contains the WinSAT score information is installed before Initial Configuration runs, the user interface for setting video quality will not appear to the customer. For more information, see [Set the WinSAT Score on the Server](Set-the-WinSAT-Score-on-the-Server.md).  
  
##  <a name="BKMK_Program"></a> Programmatically enable or disable media streaming  
 You can use a class in the Windows Server Solutions SDK to programmatically enable or disable media streaming. To enable or disable media streaming, you can use the **SetMediaStreamingEnabled** method of the **MediaStreamingManager** class in the **Microsoft.WindowsServerSolutions.MediaStreaming** namespace. The following code example shows how to enable media streaming:  
  
```c#  
  
MediaStreamingManager mediaStreamingManager = new MediaStreamingManager();  
mediaStreamingManager.SetMediaStreamingEnabled(true);  
  
```  
  
 The following code example shows how to disable media streaming:  
  
```c#  
  
MediaStreamingManager mediaStreamingManager = new MediaStreamingManager();  
mediaStreamingManager.SetMediaStreamingEnabled(false);  
```  
  
## See Also  
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)