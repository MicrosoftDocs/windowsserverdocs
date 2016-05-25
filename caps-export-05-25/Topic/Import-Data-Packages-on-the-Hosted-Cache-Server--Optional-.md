---
title: Import Data Packages on the Hosted Cache Server (Optional)
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b134ac83-226f-481a-8154-cc163b9b1cb6
author: vhorne
---
# Import Data Packages on the Hosted Cache Server (Optional)
You can use this procedure to import data packages and preload content on your hosted cache servers. This procedure is optional because you do not have to prehash and preload content on your hosted cache servers. If you do not pre\-load content, data is added to the hosted cache automatically as clients download it over the WAN connection.  
  
You must be a member of the Administrators group to perform this procedure.  
  
### To import data packages on the hosted cache server  
  
1.  On the server computer desktop, in the Taskbar, right\-click the Windows PowerShell icon, right\-click the words **Windows PowerShell**, and then click **Run as Administrator**.  
  
    > [!NOTE]  
    > If you have previously run Windows PowerShell as an Administrator on this computer, you do not need to right\-click the words **Windows PowerShell**, because **Run as Administrator** is present as a right\-click menu option.  
  
2.  Windows PowerShell opens. Type the following command, replacing the value for the –Path parameter with the folder location where you have stored your data packages, and then press ENTER.  
  
    ```  
    Import-BCCachePackage –Path D:\temp\PeerDistPackage.zip  
  
    ```  
  
3.  If you have more than one hosted cache server where you want to preload content, perform this procedure on each hosted cache server.  
  
