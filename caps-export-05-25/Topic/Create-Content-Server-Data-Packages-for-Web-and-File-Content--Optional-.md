---
title: Create Content Server Data Packages for Web and File Content (Optional)
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 176855f3-06ef-421a-9056-308f9f1347ba
author: vhorne
---
# Create Content Server Data Packages for Web and File Content (Optional)
You can use this procedure to prehash content on Web and file servers, and then create data packages to import on your hosted cache server. This procedure is optional because you do not have to prehash and preload content on your hosted cache servers. If you do not pre\-load content, data is added to the hosted cache automatically as clients download it over the WAN connection.  
  
This procedure provides instructions for prehashing content on both file servers and Web servers. If you do not have one of those types of content servers, you do not have to perform the instructions for that content server type.  
  
> [!IMPORTANT]  
> Before you perform this procedure, you must install and configure BranchCache on your content servers. In addition, if you plan on changing the server secret on a content server, do so before pre\-hashing content – modifying the server secret invalidates previously\-generated hashes. For more information about configuring content servers, see [Additional Resources](assetId:///9f69a6e5-d757-4a25-af95-197f5b4896c1).  
  
To perform this procedure, you must be a member of the Administrators group.  
  
### To create content server data packages  
  
1.  On each content server, locate the folders and files that you want to prehash and add to a data package. Identify or create a folder where you want to save your data package later in this procedure.  
  
2.  On the server computer desktop, in the Taskbar, right\-click the Windows PowerShell icon, right\-click the words **Windows PowerShell**, and then click **Run as Administrator**.  
  
    > [!NOTE]  
    > If you have previously run Windows PowerShell as an Administrator on this computer, you do not need to right\-click the words **Windows PowerShell**, because **Run as Administrator** is present as a right\-click menu option.  
  
3.  Windows PowerShell opens. Do one or both of the following, depending on the types of content servers that you have:  
  
    > [!NOTE]  
    > The value for the –Path parameter is the folder where your content is located. You must replace the example values in the commands below with a valid folder location on your content server that contains data that you want to prehash and add to a package.  
  
    -   If the content that you want to prehash is on a file server, type the following command, and then press ENTER.  
  
        ```  
        Publish-BCFileContent -Path D:\share -StageData  
        ```  
  
    -   If the content that you want to prehash is on a Web server, type the following command, and then press ENTER.  
  
        ```  
        Publish-BCWebContent –Path D:\inetpub\wwwroot -StageData  
  
        ```  
  
4.  Create the data package by running the following command on each of your content servers. Replace the example value \(D:\\temp\) for the –Destination parameter with the location that you identified or created at the beginning of this procedure.  
  
    ```  
    Export-BCDataPackage –Destination D:\temp  
    ```  
  
5.  From the content server, access the share on your hosted cache servers where you want to preload content, and copy the data packages to the shares on the hosted cache servers.  
  
