---
title: Use the My Server App to Connect to Windows Server Essentials
description: Describes how to use Windows Server Essentials
ms.date: 10/03/2016
ms.prod: windows-server
ms.topic: article
ms.assetid: 4e40b57f-6917-43ef-92e0-030baa9d2b99
author: nnamuhcs
ms.author: daveba
---

# Use the My Server App to Connect to Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

The My Server apps for  Windows Server Essentials let you connect to resources and perform light administrative tasks on your  Windows Server Essentials server from your laptop, PC, or Surface device. In My Server, you can manage users, devices, and alerts, and work with shared files on the server. When you are offline, you can continue to work with files recently accessed in My Server; your offline changes are automatically synchronized with the server the next time you connect.  
  
 If your server is running the  Windows Server Essentials operating system, use the original My Server app. If your server is running the  Windows Server Essentials operating system, you must use the updated My Server 2012 R2 app. Both apps can be downloaded from [Apps for Windows](https://windows.microsoft.com/windows-8/apps).  
  
> [!TIP]
> 
>  To access resources in  Windows Server Essentials from your Windows Phone, use the My Server phone app (for  Windows Server Essentials) or the My Server 2012 R2 phone app (for  Windows Server Essentials). For information about the My Server phone app, see [Use the My Server app for Windows Phone](Work-Remotely-in-Windows-Server-Essentials.md#BKMK_2). For information about the My Server 2012 R2 phone app, see the blog entry [My Server 2012 R2 Windows and Windows Phone apps](https://blogs.technet.com/b/sbs/archive/2013/11/19/my-server-2012-r2-windows-and-windows-phone-apps.aspx).  
  
## In this topic  
  
-   [What's new in My Server 2012 R2](Use-the-My-Server-App-to-Connect-to-Windows-Server-Essentials.md#BKMK_WhatsNew)  
  
-   [Operating system requirements](Use-the-My-Server-App-to-Connect-to-Windows-Server-Essentials.md#BKMK_OS)  
  
-   [Install My Server](Use-the-My-Server-App-to-Connect-to-Windows-Server-Essentials.md#BKMK_Install)  
  
-   [Use My Server](Use-the-My-Server-App-to-Connect-to-Windows-Server-Essentials.md#BKMK_UseServer)  
  
-   [Features of My Server](Use-the-My-Server-App-to-Connect-to-Windows-Server-Essentials.md#BKMK_Features)  
  
-   [How to connect to your server from your local network](Use-the-My-Server-App-to-Connect-to-Windows-Server-Essentials.md#BKMK_ConnectServer)  

>  To access resources in  Windows Server Essentials from your Windows Phone, use the My Server phone app (for  Windows Server Essentials) or the My Server 2012 R2 phone app (for  Windows Server Essentials). For information about the My Server phone app, see [Use the My Server app for Windows Phone](../use/Work-Remotely-in-Windows-Server-Essentials.md#BKMK_2). For information about the My Server 2012 R2 phone app, see the blog entry [My Server 2012 R2 Windows and Windows Phone apps](https://blogs.technet.com/b/sbs/archive/2013/11/19/my-server-2012-r2-windows-and-windows-phone-apps.aspx).  
  
## In this topic  
  
-   [What's new in My Server 2012 R2](../use/Use-the-My-Server-App-to-Connect-to-Windows-Server-Essentials.md#BKMK_WhatsNew)  
  
-   [Operating system requirements](../use/Use-the-My-Server-App-to-Connect-to-Windows-Server-Essentials.md#BKMK_OS)  
  
-   [Install My Server](../use/Use-the-My-Server-App-to-Connect-to-Windows-Server-Essentials.md#BKMK_Install)  
  
-   [Use My Server](../use/Use-the-My-Server-App-to-Connect-to-Windows-Server-Essentials.md#BKMK_UseServer)  
  
-   [Features of My Server](../use/Use-the-My-Server-App-to-Connect-to-Windows-Server-Essentials.md#BKMK_Features)  
  
-   [How to connect to your server from your local network](../use/Use-the-My-Server-App-to-Connect-to-Windows-Server-Essentials.md#BKMK_ConnectServer)  

  
##  <a name="BKMK_WhatsNew"></a> What's new in My Server 2012 R2  
 In addition to the features available in My Server, My Server 2012 R2 offers the following new features for customers with  Windows Server Essentials:  
  
-   **Access to SharePoint Online team sites and libraries** - Leverage Microsoft Office 365 integration with  Windows Server Essentials to access SharePoint Online team sites and open documents in your SharePoint Online libraries in My Server 2012 R2.  
  
-   **Remote Desktop connections to the server and client computers** - Use **Remote Connect** in My Server 2012 R2 to connect to your  Windows Server Essentials server and client computers by using Remote Desktop.  
  
##  <a name="BKMK_OS"></a> Operating system requirements  
 To use My Server or My Server 2012 R2 on your laptop, PC, or Surface device, the computer must have one of the following operating systems:  Windows 8.1,  Windows RT 8.1,  Windows 8, or  Windows RT.  
  
##  <a name="BKMK_Install"></a> Install My Server  
 You can download the appropriate My Server app from the [Apps for Windows](https://windows.microsoft.com/windows-8/apps) store. If your computer has the  Windows 8 or  Windows RT operating system, and you want to connect to the server on your intranet by using the server name, you also need to install a certificate from the server.  
  
#### To install My Server or My Server 2012 R2 on your Windows-based laptop, PC, or Surface device  
  
1.  Install the appropriate My Server app from [Apps for Windows](https://windows.microsoft.com/windows-8/apps) onto your Windows-based laptop, PC, or Surface device.  
  
    |Server operating system|Download|  
    |-----------------------------|--------------|  
    | Windows Server Essentials|[My Server](https://apps.microsoft.com/webpdp/app/19d94f81-db21-4234-8b49-806694dbbaea)|  
    | Windows Server Essentials|[My Server 2012 R2](https://apps.microsoft.com/webpdp/app/67e86695-bda3-4f32-96c4-2e20e56f1cf3)|  
  
2.  If you want to be able to use the server name to connect to your  Windows Server Essentials server over an intranet, and your device has the  Windows 8 or  Windows RT operating system, install the default CAROOT.cer certificate on your computer by performing the following procedure. Manual installation of a certificate is not needed in  Windows 8.1 and  Windows RT 8.1.  
  
###  <a name="BKMK_InstallCert"></a> To install a certificate for My Server on your Windows 8, Windows 8.1, or Windows RT device  
  
1.  Open a web browser on your computer, and download the default certificate, CAROOT.cer, from the server. To do this, type the following, substituting the name of your server (for example, **marketing.contoso.com**) for <*servername*>:  
  
     **http://<servername\>/connect/default.aspx?get=caroot.cer**  
  
2.  Install the certificate:  
  
    1.  On the **Start** page, open **File Explorer**.  
  
    2.  Ensure that hidden items and file name extensions are displayed: On the **View** tab, in the **Show/hide** group, select the **Hidden items** and **File name extensions** check boxes.  
  
    3.  Navigate to the folder that contains the CAROOT.cer file that you just downloaded.  
  
    4.  Right-click the CAROOT.cer file, and then click **Open**.  
  
    5.  In the **Certificate** dialog box, click **Install Certificate**.  
  
    6.  Select **Local Machine** as the installation location, and then click **Next**.  
  
    7.  On the **Certificate store** wizard page, select **Place all certificates in the following store**, and use **Browse** to choose the **Trusted Root Certification Authorities** store. Then click **Finish**.  
  
##  <a name="BKMK_UseServer"></a> Use My Server  
 To get started using the My Server or My Server 2012 R2 app, open the app and take a quick tour of its features.  
  
#### To open My Server or My Server 2012 R2  
  
1.  Open My Server (for  Windows Server Essentials) or My Server 2012 R2 (for  Windows Server Essentials) from the **Start** page of your Windows device.  
  
2.  Sign in to the  Windows Server Essentials server using your account on the server. To identify the server:  
  
    -   In an off-premises environment, use the server's domain name - for example, **marketing.contoso.com**.  
  
    -   If you are connecting on-premises over an intranet, use the server name - in the previous example, the server name is **marketing**. (If you are using a  Windows 8 or  Windows RT computer to connect on-premises, and you want to use this method, you must install a CAROOT.cer certificate from the server. For more information, see [To install a certificate for My Server on your Windows 8, Windows 8.1, or Windows RT device](#BKMK_InstallCert).)  
  
###  <a name="BKMK_Features"></a> Features of My Server  
 The following table describes the features of the My Server and My Server 2012 R2 apps. Your account type on the server determines what you can see and do. All users can work with shared resources, customize their **Recent** displays, decide how long to cache recently used files for offline access, and turn on or off downloads over paid connections. Administrators on the  Windows Server Essentials server also can manage alerts, devices, and users. Standard user accounts have more limited capabilities for viewing alerts and connecting to devices, determined by properties in the user account; requirements for individual features are noted in the following table.  
  
### Features of the My Server and My Server 2012 R2 apps for Windows Server Essentials  
  
|Feature set|Description|  
|-----------------|-----------------|  
|Manage alerts|-   (Administrators only) Resolve alerts on the server, or ignore alerts that don't require action. Turn notifications on or off (**Permissions** settings, **Notifications** option)<br />-   (Standard User accounts) View network health alerts.<br />     **Note:** For a user to view alerts in My Server, the **User can view network health alerts** setting must be selected in **General** settings of the user account. For more information, see [Manage user accounts using the Dashboard](../manage/Manage-User-Accounts-in-Windows-Server-Essentials.md#BKMK_Manage8).|  
|Manage devices|(Administrators only)<br /><br /> -   When you are connected to the  Windows Server Essentials server, view details about each connected computer in **Devices** view. Offline devices are shaded.<br />-   Start and stop backups of connected computers.<br />-   Turn notifications on or off in My Server. (**Permissions** settings, **Notifications** option)<br /><br /> All users:<br /><br /> -   View client computers that your user account has access to. (**Devices** display)<br />-   Monitor alerts for those computers. (**Alerts** display)<br />-   (In My Server 2012 R2 only) Connect to those computers using Remote Web Access. (**Device** display, **Remote Connect** button)|  
|Connect to computers by using Remote Desktop|(My Server 2012 R2 only) Open a Remote Desktop session with your  Windows Server Essentials server or a client computer. (**Device** display, **Remote Connect** button)<br /><br /> **Note:** To enable this feature, download and install the [Remote Desktop app](https://apps.microsoft.com/webpdp/app/051f560e-5e9b-4dad-8b2e-fa5e0b05a480) from Apps for Windows on your computer. Standard User accounts can connect to devices that they have permission to sign on to. To enable a user to sign on to a computer, add the computer to the **Computer access** tab of the user account. For more information, see [Assign user accounts permission to log on to specific network computers](../manage/Manage-Devices-in-Windows-Server-Essentials.md#BKMK_2).|  
|Manage users|(Administrators only) Change the password for a user account. End a user's session on the server. (**Users** settings)|  
|Work with shared files|<ul><li>Upload and download files from Shared Files (shared folders you have access to on the server), your private share, or, from a  Windows 8.1 device, SkyDrive or network storage. Create folders. Add (upload), edit, and delete files from the server.</li><li>View the transfer status while uploading or downloading a file. Cancel a transfer. Resolve file conflicts.</li><li>Work seamlessly with files and folders on your local computer, the server, SkyDrive, or network storage. File lists show folders that you have used recently on your computer, in SkyDrive, or in network storage, along with shared folders on the server, and let you browse through folders in any of these locations.</li><li>Search for folders and files on the server; click a file to download it and open it in the default app. In offline mode, search for offline files only.</li><li>Share pictures, music, and videos. Click a file to open it in a  Windows 8 picture, music, or video player. Or use **Open** or **Open with** to open the file in another app. As usual, you can make the app that you choose the default app for that media type.<br /><br />     **Note:** By default, the media streaming functionality is unavailable in  Windows Server Essentials and  Windows Server 2012 R2 with the Windows Server Essentials Experience role installed. For more information, see [Manage Digital Media](../manage/Manage-Digital-Media-in-Windows-Server-Essentials.md).<br /><br /> <ul><li>**Pictures** - In **Pictures** view, tap a picture to open it. Tap the picture again to return to the thumbnail view in My Server.</li><li>**Music** - In **Music** view, view albums or songs shared on the server. Tap an item to open it in the music player.</li><li>**Videos** - Click a thumbnail in **Videos** view to open the video player.</li></ul></li></ul>|  
|Use SharePoint Online libraries|(My Server 2012 R2 only) Work with files in your team's SharePoint Online libraries. Open team sites. (SharePoint Online section: open the team site, and drill down to the document library or file that you want to open. When you open a file, you must sign in to Office 365 with the Microsoft online account associated with your network account.)<br /><br /> **Note:** To use this feature, the server must be integrated with Office 365, the Office 365 subscription must include SharePoint Online, and your user account on the server must have a Microsoft Online Services account associated with it. For information about integrating Office 365 and SharePoint Online with  Windows Server Essentials, see [Services Integration Overview for Windows Server Essentials - Part 1](https://blogs.technet.com/b/sbs/archive/2013/11/06/services-integration-overview-for-windows-server-2012-r2-essentials-part-1.aspx) and [Services Integration Overview for Windows Server Essentials - Part 2](https://blogs.technet.com/b/sbs/archive/2013/11/06/services-integration-overview-for-windows-server-2012-r2-essentials-part-2.aspx).|  
|Customize your **Recent** display|The **Recent** list gives you quick access to the files that you are working on now. You can make the following changes:<br /><br /> -   Set the number of days of recent file history to display. (**Recent** settings: **Days to keep in Recent**; default = 7 days)<br />-   Clear the **Recent** display, if you no longer need to work the files you have been working with. This does not affect the cache; the files still are available offline. (**Recent** settings: **Clear** button)<br />     **Tip:** If you don't need offline access to the files, use **Clear all** in **Offline** settings to remove the files from the cache.|  
|Work offline|By default, files that you have accessed during the past 7 days are available offline. Your offline changes are synchronized with the server whenever you connect to it.<br /><br /> You can make the following changes to your offline configuration:<br /><br /> -   Change the number of days of work to cache. (**Offline** settings in My Server, **Files** settings in My Server 2012 R2: **Caching period**; default = 7 days)<br />-   Allow file transfers over paid networks, or turn off that feature. This feature is turned off by default to prevent expensive file transfers over paid networks. (**Offline** or **Files** settings: **Turn on or off auto-transfer of files over paid networks**; default = **Off**)<br />-   You might occasionally want to clear the cache. Check the size of the cache in **Recent** or **Files** settings; then use **Clear** or **Clear all** to clear the cache.<br /><br /> **Tip:** To find out which files will be available offline, in any shared folder, select the **offline cached** filter instead of **all**.<br /><br /> **Note:** By default, the cache stores the same file history that the **Recent** list displays. Be aware that if you clear the cache, or your settings for the cache and the **Recent** display do not match, some files in the **Recent** list might not be available offline.|  
|Background synchronization|Your files are synchronized with the server each time you log on to My Server and when you make changes while connected to the server. To preserve performance, resource-intensive background synchronizations are not performed automatically on most folders. To avoid expensive transfers, background synchronization is not performed on 3 Gigabyte networks.<br /><br /> -   Resolve file conflicts, displayed in the **Conflicting** area of the **Transfer Status** page. When file transfers are being performed, the main screen displays **Transfer Status** and **Alerts** charms.|  
  
##  <a name="BKMK_ConnectServer"></a> How to connect to your server from your local network  
 To successfully use the My Server app in Windows Server Essentials for Windows Phone, Windows 8, and Windows 8.1, you must first install the server certificate on your device. This connects the device to your server running Windows Server Essentials in your local network. Use the following procedures to connect to your server in your local network and install the server certificate on your Windows Phone or a computer that is running Windows 8 or Windows 8.1.  
  
#### To connect to your server from your Windows Phone  
  
1.  On your Windows Phone that is running Windows 8 or Windows 8.1, open Internet Explorer.  
  
2.  In the address bar, type **http://<yourservername\>/connect/default.aspx?get=caroot.cer**, and then press Enter.  
  
3.  When you are prompted to install the caroot.cer certificate, click **Install**.  
  
4.  Wait for the certificate installation to complete.  
  
    > [!NOTE]
    >  After the installation of the certificate is complete, you can sign in to the My Server app for Windows Phone by using your server name and your network credentials.  
  
#### To connect to your server in your local network from a computer running Windows 8 or Windows 8.1  
  
1.  On a computer that is running Windows 8 or Windows 8.1, open Internet Explorer.  
  
2.  In the address bar, type **http://<yourservername\>/connect/default.aspx?get=caroot.cer**, and then press Enter.  
  
3.  When you are prompted to install the caroot.cer certificate, click **Open**.  
  
4.  In the **Certificate** dialog box, click **Install certificate**.  
  
5.  In the Certificate Import Wizard, select **Local Machine** as the store location.  
  
6.  Select **Place all certificates in the following store**, and then browse to the **Trusted Root Certification Authorities** location.  
  
7.  Follow instructions to complete the wizard.  
  
    > [!NOTE]
    >  After the installation of the certificate is complete, you can sign in to the My Server app for Windows 8 or Windows 8.1 by using your server name and your network credentials.  
  
## See also  
  
-   [Services Integration Overview for Windows Server Essentials - Part 1](https://blogs.technet.com/b/sbs/archive/2013/11/06/services-integration-overview-for-windows-server-2012-r2-essentials-part-1.aspx)  
  
-   [Services Integration Overview for Windows Server Essentials - Part 2](https://blogs.technet.com/b/sbs/archive/2013/11/06/services-integration-overview-for-windows-server-2012-r2-essentials-part-2.aspx)  
  
-   [Manage Anywhere Access](../manage/Manage-Anywhere-Access-in-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](../manage/Manage-Windows-Server-Essentials.md)  
  

-   [Work Remotely](Work-Remotely-in-Windows-Server-Essentials.md)  
  
-   [Use Windows Server Essentials](Use-Windows-Server-Essentials.md)

-   [Work Remotely](../use/Work-Remotely-in-Windows-Server-Essentials.md)  
  
-   [Use Windows Server Essentials](../use/Use-Windows-Server-Essentials.md)

