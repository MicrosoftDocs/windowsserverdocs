---
title: "Use Remote Web Access in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 47ea21a0-5e05-4b4b-8fa4-338c82601276
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Use Remote Web Access in Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials
  
  Remote Web Access is a feature of Windows Servers Essentials that enables you to access file/folders and computers on your network via a web browser from anywhere with Internet connectivity. 
  
  Remote Web Access helps you stay connected to your Windows Server Essentials network when you are away. When you log on to Remote Web Access, you can connect to the computers on your Windows Server Essentials network, open the Dashboard to manage your Windows Server Essentials network, and access all of the shared folders and media files on the server.  
  
 This topic includes the following sections:  
  

-   [Connect to Remote Web Access](Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_Connect)  
  
-   [Share files and folders](Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_SharedFolders)  
  
-   [Connect from a mobile device](Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_ConnectMobile)  
  
##  <a name="BKMK_Connect"></a> Connect to Remote Web Access  
  
-   [Log on to Remote Web Access](Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_1)  
  
-   [Remotely access your computer](Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_1.5)  

-   [Connect to Remote Web Access](../use/Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_Connect)  
  
-   [Share files and folders](../use/Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_SharedFolders)  
  
-   [Connect from a mobile device](../use/Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_ConnectMobile)  
  
##  <a name="BKMK_Connect"></a> Connect to Remote Web Access  
  
-   [Log on to Remote Web Access](../use/Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_1)  
  
-   [Remotely access your computer](../use/Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_1.5)  

  
###  <a name="BKMK_1"></a> Log on to Remote Web Access  
 When you log on to  Remote Web Access from a local or remote computer, you can access resources on your server running Windows Server Essentials and computers on your network.  
  
##### To log on to Remote Web Access from a network computer  
  
1.  Open a Web browser, type **https://***<YourServerName\>***/remote** in the address bar, and then press Enter.  
  
    > [!NOTE]
    >  Make sure that you include the s in https.  
  
2.  On the  Remote Web Access logon page, type your user name and password in the text boxes, and then click the arrow.  
  
##### To log on to Remote Web Access from a remote computer  
  
1.  Open a Web browser, type **https://***<YourDomainName\>***/remote** in the address bar, and then press Enter.  
  
    > [!NOTE]
    >  You can get your domain name information from your network administrator. Make sure that you include the s in https.  
  
2.  On the  Remote Web Access logon page, type your user name and password in the text boxes, and then click the arrow.  
  
###  <a name="BKMK_1.5"></a> Remotely access your computer  
 When you are away from your office, you can use your Web browser to log on to the  Remote Web Access site to remotely access your Windows Server Essentials Dashboard, shared folders, and computers on your network.  
  
 When you connect to the Dashboard, you can manage Windows Server Essentials just like you would if you were at the office. You can perform all of the usual administrative tasks, such as adding user accounts, adding shared folders, setting shared folder access, and so on. When you connect to computers on your network, you can access their desktops as if you were sitting in front of them at the office.  
  
 The **Status** column shows you if you can connect to a computer on your network, and can include the following values:  
  
-   **Available**  
  
     The computer is turned on and is available for a remote connection. Even if you see this status, you still may not be able to connect to this computer if a third-party firewall blocks the connection.  
  
-   **Offline or Sleeping**  
  
     The computer is turned off or is in Sleep or Hibernate mode. If a computer is offline or sleeping, the status is updated in real time so that you can know when the computer becomes available.  
  
-   **Unsupported operating system**  
  
     The operating system on the computer does not support Remote Desktop. It may take up to 6 hours for this status to be updated on the server if there is a change.  
  
-   **Connection is disabled**  
  
     The computer connection is either blocked by a firewall, or the remote desktop is disabled on the computer or by Group Policy. It may take up to 6 hours for this status to be updated on the server if there is a change.  
  
#### To connect to a computer on your network  
 On the **DEVICES** tab, click the name of the computer. You can select only computers with an **Available** status.  
  
#### To connect to the server Dashboard  
 On the **DEVICES** tab, click the name of your server. You can select only computers with an **Available** status. You must be able to provide an administrator user account and password on your server to use the Dashboard.  
  
##  <a name="BKMK_SharedFolders"></a> Share files and folders  
  

-   [Upload and download files in Remote Web Access](Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_UploadRWA)  
  
-   [Create, rename, move, delete, or copy files and folders in Remote Web Access](Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_2)  

-   [Upload and download files in Remote Web Access](../use/Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_UploadRWA)  
  
-   [Create, rename, move, delete, or copy files and folders in Remote Web Access](../use/Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_2)  

  
###  <a name="BKMK_UploadRWA"></a> Upload and download files in Remote Web Access  
 On the Remote Web Access **Shared Folders** tab, you can do the following:  
  
-   Upload (send) files from your computer to Windows Server Essentials.  
  
    > [!NOTE]
    >  You can upload only files and not folders to Remote Web Access. If you want to have the same file and folder hierarchy in the **Shared Folders** on the server as on your computer, you must create the folders on the server in Remote Web Access, and then upload the files to the folder that you created. For information about creating server folders, see [Add or move a server folder](../manage/Manage-Server-Folders-in-Windows-Server-Essentials.md#BKMK_5).  
  
-   Download (receive) files and folders from Windows Server Essentials to your computer.  
  
-   Create a folder within a shared folder on Windows Server Essentials.  
  

-   Move, delete, and rename files and folders on Windows Server Essentials. For more information, see [Create, rename, move, delete, or copy files and folders in Remote Web Access](Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_2).  

-   Move, delete, and rename files and folders on Windows Server Essentials. For more information, see [Create, rename, move, delete, or copy files and folders in Remote Web Access](../use/Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_2).  

  
#### Upload files  
  
###### To upload files  
  
1. In Remote Web Access, click the **Shared Folders** tab, and then click a shared-folder link. A list of the files and folders in that shared folder is displayed.  
  
2. From the shared-folder list of files and folders, click the folder where you want to upload the file to, and then click **Upload**.  
  
3. If the standard upload tool is not already loaded, click **Use the standard upload method**.  
  
4. Click **Browse**  to find a file on your computer.  
  
5. Navigate through the folders on your computer to find the file that you want to upload, and then click **Open**.  
  
6. Repeat Steps 2 and 3 for each file that you want to upload.  
  
7. When you have added all of the files that you want to upload, click **Upload**.  
  
   The Easy File Upload tool streamlines the process of uploading files on your server running Windows Server Essentials. You can add as many files as you want to the Easy File Upload tool by using the drag-and-drop feature, and then upload them to the shared folders on the server.  
  
> [!NOTE]
>  Uploading of multiple files is natively supported in web browsers that are compatible with HTML5. This tool is only necessary when the web browser does not support HTML5.  
  
###### To upload files using the Easy File Upload tool  
  
1.  In Remote Web Access, click the **Shared Folders** tab, and then click a shared-folder link. A list of the files and folders in that shared folder is displayed.  
  
2.  From the shared-folder list of files and folders, click the folder where you want to upload the files to, and then click **Upload**. If the folder that you want to upload to does not exist, click **New folder**, type the name of the new folder in the dialog box, and then click **OK**.  
  
3.  You may need to run the Windows Server Solutions add-on. If so, click in the yellow strip at the top of the screen, click run **Add-on**, and then click **Run** in the dialog box.  
  
4.  If the Easy File Upload tool is not already loaded, click **Use the Easy File Upload tool**.  
  
5.  You can drag-and-drop files from Windows Explorer to the Easy File Upload tool, or click **browse to select files**.  
  
6.  When you finish adding the files that you want to upload to the selected folder, click **Upload**.  
  
7.  When the files are uploaded successfully, click **Close**.  
  
#### Download files or folders  
  
###### To download a single file  
  
1. In Remote Web Access, click the **Shared Folders** tab, and then click a shared-folder link. A list of the files and folders in that shared folder is displayed.  
  
2. From the shared-folder file list, click the check box next to the file that you want to download to your home computer.  
  
3. Click **Download** to begin the download.  
  
4. On the **File Download** dialog box, click **Save** to save the file to your computer.  
  
5. In the **Save As** dialog box, select the location to save the file, and then click **Save**. A single file is not compressed before it is downloaded.  
  
   There are two options for downloading multiple files or folders. Choose the option that fits your needs:  
  
> [!NOTE]
>  These options are available only when you are downloading multiple files or folders to your computer.  
  
- **Self-extracting executable file (.exe)**  
  
  > [!NOTE]
  >   This section applies to a server running Windows Server Essentials.  
  
   A self-extracting executable file is a file that you can download that combines the decompression (executable) program with the compressed files. When you run the executable program, it automatically decompresses the compressed files (self-extracting). This is a common way to distribute compressed data without worrying about whether the recipient has the right decompression utility.  
  
  > [!NOTE]
  >  This option supports Unicode characters.  
  
- **Windows Compressed folder (.zip)**  
  
   Zipping a file creates a compressed version of the file that is smaller than the original file. The zipped version of the file has a .zip file name extension. File types that are reduced the most by zipping are text-oriented file types, such as .txt, .doc, .xls, and graphics files that use non-compressed file types such as .bmp. Some graphic files, such as .jpg and .gif files, already use compression, and the file size is reduced very little by zipping. Also, a Word document that contains a lot of graphics is not reduced as much as a document that is mostly text.  
  
  > [!NOTE]
  >  This option provides limited support for international file names in  Windows Server Essentials.  
  
  Before the actual download begins, the exe or zip file is created. Depending on the number of files and the total size of the files to be downloaded, this may take several minutes. After the download file is created, downloading the file occurs in the background. This allows you to continue working while the download process completes.  
  
###### To download multiple files or folders  
  
1.  In Remote Web Access, click the **Shared Folders** tab, and then click a shared-folder link. A list of the files and folders in that shared folder is displayed.  
  
2.  From the shared-folder file list, click the check box next to the files or folders that you want to download to your home computer.  
  
3.  Click **Download** to begin the download.  
  
4.  In the **Choose a Download Format** dialog box, click to select the download format option that you prefer, and then click **OK**. The compressed file is prepared in the format option that you selected.  
  
5.  In the **File Download** dialog box, click **Save** to save the file to your computer.  
  
6.  In the **Save As** dialog box, select the location to save the file, and then click **Save**.  
  
#### Retrieve compressed files downloaded to your computer  
  
> [!NOTE]
>   This section applies to a server running Windows Server Essentials.  
  
 If you select multiple files or folders to download, you can receive a self-extracting compressed executable file (.exe) or a compressed (.zip) file.  
  
###### To retrieve a file from the compressed (.exe) file  
  
1.  On your computer, double-click the compressed file to open it.  
  
2.  Follow the instructions to extract the files to a folder on your computer.  
  
###### To retrieve a file from the compressed (.zip) file  
  
1.  On your computer, double-click the compressed file to open it.  
  
2.  Select the files that you want to retrieve, and then drag the files to a folder on your computer where you want to store them.  
  
    > [!NOTE]
    >  If you use a third-party file compression program, follow the procedures for that program to extract your files from the compressed file.  
  
###  <a name="BKMK_2"></a> Create, rename, move, delete, or copy files and folders in Remote Web Access  
 You can use Remote Web Access to create new folders in an existing shared folder, to rename files and folders, to move and copy files and folders, and to delete files and folders on your server.  
  
> [!NOTE]
>  To add new shared folders on a server that is running Windows Server Essentials, you must use the Dashboard. To connect to the server console from Remote Web Access, on the **Computers** tab, click the server name, click **Connect**, and then follow the instructions for logging on to the server. For information about how to create shared folders, see [Add or move a server folder](../manage/Manage-Server-Folders-in-Windows-Server-Essentials.md#BKMK_5).  
  
##### To create a new folder  
  
1.  In Remote Web Access, click the **Shared Folders** tab, and then click a shared folder link. A list of the files and folders in that shared folder is displayed.  
  
2.  On the task bar, click **New Folder**.  
  
3.  Type a name for the folder, and then click **OK**.  
  
##### To rename a file or folder  
  
1.  In Remote Web Access, click the **Shared Folders** tab, and then click a shared folder link. A list of the files and folders in that shared folder is displayed.  
  
2.  Right-click the file or folder that you want to rename, and then click **Rename**.  
  
3.  Type a new name in the text box, and then click **OK**.  
  
##### To move files or folders  
  
1.  In Remote Web Access, click the **Shared Folders** tab, and then click a shared folder link. A list of the files and folders in that shared folder is displayed.  
  
2.  Select the check box next to the files or folders that you want to move, right-click one of the selected files or folders, and then click **Cut**.  
  
3.  Right-click the folder that you want to move the files or folders to, and then click **Paste**.  
  
##### To delete a file or folder  
  
1.  In Remote Web Access, click the **Shared Folders** tab, and then click a shared folder link. A list of the files and folders in that shared folder is displayed.  
  
2.  Select the check box next to the files or folders that you want to delete, right-click one of the selected files or folders, and then click **Delete**.  
  
3.  To confirm that you want to delete the selected files and folders, click **Yes**.  
  
##### To copy files or folders  
  
1.  In Remote Web Access, click the **Shared Folders** tab, and then click a shared folder link. A list of the files and folders in that shared folder is displayed.  
  
2.  Select the check box next to the files or folders that you want to copy, right-click one of the selected files or folders, and then click **Copy**.  
  
3.  Right-click the folder that you want to copy the files or folders to, and then click **Paste**.  
  
##  <a name="BKMK_ConnectMobile"></a> Connect from a mobile device  
  

-   [Use Remote Web Access from a mobile device](Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_8)  
  
-   [Supported Web browsers for mobile devices](Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_9)  

-   [Use Remote Web Access from a mobile device](../use/Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_8)  
  
-   [Supported Web browsers for mobile devices](../use/Use-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_9)  

  
###  <a name="BKMK_8"></a> Use Remote Web Access from a mobile device  
 You can log on to Remote Web Access from your smart phone to view the files and folders in the shared folders on the server.  
  
> [!NOTE]
>  You can also download and use the My Server app for Windows Server Essentials from the [Windows Phone Marketplace](http://www.windowsphone.com/apps/6c2f98d5-6fcf-4e1d-b8b1-cde62ea1a94a) to access your shared folders and media files that are stored on the server.  
  
##### To log on to Remote Web Access from a mobile device  
  
1.  Open a Web browser and type **https://***<YourDomainName\>***/remote** in the address bar.  Make sure that you include the s in https.  
  
2.  On the  Remote Web Access logon page, type your user name and password in the text boxes, and then click the arrow. You are logged on to the mobile version of Remote Web Access.  
  
##### To switch to the desktop version of Remote Web Access  
  
1.  Open a Web browser and type **https://***<YourDomainName\>***/remote** in the address bar.  Make sure that you include the s in https.  
  
2.  On the  Remote Web Access logon page, type your user name and password in the text boxes, click **View desktop version**, and then click the arrow. You are logged on to the desktop version of Remote Web Access.  
  
##### To return to the mobile version of Remote Web Access  
  
1. Log off.  
  
2. Open a Web browser and type **https://***<YourDomainName\>***/remote/m** in the address bar. Make sure that you include the s in https.  
  
3. The mobile version of  Remote Web Access is displayed. On the  Remote Web Access logon page, type your user name and password in the text boxes, and then click the arrow. You are logged on to the mobile version of  Remote Web Access.  
  
   You can search for files and folders in the shared folders on the server.  
  
###  <a name="BKMK_9"></a> Supported Web browsers for mobile devices  
 Supported web browsers for mobile devices include:  
  
-   Internet Explorer Mobile 6.0 or later  
  
-   Safari  
  
-   Blackberry  
  
-   Symbian 6.0 or later  
  
-   Android  
  
-   Google Chrome  
  
-   Firefox  
  
## See also  
  
-   [Manage Remote Web Access](../manage/Manage-Remote-Web-Access-in-Windows-Server-Essentials.md)  
  

-   [Work Remotely](Work-Remotely-in-Windows-Server-Essentials.md)  
  
-   [Use Windows Server Essentials](Use-Windows-Server-Essentials.md)

-   [Work Remotely](../use/Work-Remotely-in-Windows-Server-Essentials.md)  
  
-   [Use Windows Server Essentials](../use/Use-Windows-Server-Essentials.md)

