---
title: "Manage Server Folders in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 090cf1b8-7b9b-48b9-ae85-b98477b8d7cc
author: nnamuhcs
ms.author: coreyp
manager: dongill
---



# Manage Server Folders in Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials
  
 As a server administrator, you can manage access to any server folders (known as shared folders when accessed from the Launchpad, Remote Web Access, My Server app for Windows Phone, or My Server app for Windows 8) on the server by using the tasks on the **Server Folders** tab of the Dashboard, allowing users varying levels of access to a variety of files.  
  
 The following topics provide information that will help you understand, create, and manage server folders:  
  
-   [Manage server folders using the Dashboard](Manage-Server-Folders-in-Windows-Server-Essentials.md#BKMK_2)  
  
-   [Manage access to server folders](Manage-Server-Folders-in-Windows-Server-Essentials.md#BKMK_1)  
  
-   [Add or move a server folder](Manage-Server-Folders-in-Windows-Server-Essentials.md#BKMK_5)  
  
-   [Add a missing server folder](Manage-Server-Folders-in-Windows-Server-Essentials.md#BKMK_9)  
  
-   [Understand shared folders](Manage-Server-Folders-in-Windows-Server-Essentials.md#BKMK_11)  
  
-   [Understand shadow copies](Manage-Server-Folders-in-Windows-Server-Essentials.md#BKMK_Shadow)  
  
##  <a name="BKMK_2"></a> Manage server folders using the Dashboard  
 Windows Server Essentials makes it possible to perform common administrative tasks by using the Dashboard. The **Server Folders** page of the Dashboard provides the following:  
  
- A list of server folders, which displays:  
  
  -   The name of the folder  
  
  -   A description of the folder  
  
  -   The location of the folder  
  
  -   The amount of free space that is available at the folder location  
  
  -   Brief status information about any tasks that are being performed on the folder; the **Status** field is blank if the folder is healthy, and if no tasks are running  
  
- A details pane that may provide additional information about a selected folder  
  
- A tasks pane that includes a set of folder-related administrative tasks  
  
  The following table describes the various server folder tasks that are available on the Windows Server Essentials Dashboard. Most of the tasks are folder-specific, and they are only visible when you select a folder in the list.  
  
### Server folder tasks on the Dashboard  
  
|Task name|Description|  
|---------------|-----------------|  
|Open the folder|Displays the contents of the selected folder in File Explorer (called Windows Explorer in previous versions of Windows).|  
|Delete the folder|Enables you to delete a user-created folder. This task is not available for the default folders that server installation creates.|  
|Move the folder|Opens a wizard that helps you move a server folder to a new location.|  
|Stop sharing the folder|Stops sharing the selected folder but does not delete it. When the folder is no longer shared, it does not appear in the Dashboard. This task is not available for the default folders that server installation creates.|  
|View the folder properties|Displays the properties for a selected folder, and enables you to:<br /><br /> - Change the name of user-created folders.<br /><br /> - Change the description for a selected folder.<br /><br /> - View the size of the folder.<br /><br /> - Open the selected folder in File Explorer.<br /><br /> - Specify user account access permissions for a selected folder.<br /><br /> - Hide a selected folder from Remote Web Access and Web Service applications.<br /><br /> - Specify folder quota.|  
|Add a folder|Helps you create a new server folder and assign the level of access allowed for each user account.|  
|Understanding Server Folders|Opens a Help topic on the Internet that describes the use and functionality of server folders.|  
  
##  <a name="BKMK_1"></a> Manage access to server folders  
 Windows Server Essentials enables you to store files that are located on your client computers to a central location by using server folders. Storing your files in server folders ensures that your files are in a place that is always accessible in a secure manner from each client.  
  
 Using server folders to store your files enables you to:  
  
- Back up the server folder by using Server Backup and Restore to help protect against total server failure.  
  
- Access files that are stored on the server folder from any location by using an Internet Browser via Remote Web Access, or via the My Server apps for Windows Phone and Windows 8.  
  
- Access the new server folder from any client computer.  
  
  You can manage access to any server folders on the server by using the tasks on the **Server Folders** tab of the Dashboard. The following table lists the server folders that are created by default when you install Windows Server Essentials or turn on media streaming on your server.  
  
|Server Folder Name|Description|  
|------------------------|-----------------|  
|Client Computer Backups|By default, Windows Server Essentials creates client computer backups that are stored in this folder. The settings for Client Computer Backups can be modified by the network administrator.|  
|Company|Used to store and access documents related to your organization by network users.|  
|File History Backups|By default, Windows Server Essentials uses File History to create file backups that are stored in this folder. These File History settings can be modified by network administrators.|  
|Folder Redirection|Used to store and access folders that are set up for folder redirection by network users.|  
|Users|Used to store and access files by network users. A user-specific folder is automatically generated in the **Users** server folder for every network user account that you create.|  
|Music|Used to store and access music files by network users. This folder is available when you turn on media sharing.|  
|Pictures|Used to store and access picture files by network users. This folder is available when you turn on media sharing.|  
|Recorded TV|Used to store and access recorded TV programs by network users. This folder is available when you turn on media sharing.|  
|Videos|Used to store and access video files by network users. This folder is available when you turn on media sharing.|  
  
 To hide or set permissions for server folders, or to modify server folder properties, see the following procedures:  
  
-   [Hide server folders](Manage-Server-Folders-in-Windows-Server-Essentials.md#BKMK_Hide)  
  
-   [Set permissions to server folders](Manage-Server-Folders-in-Windows-Server-Essentials.md#BKMK_Perms)  
  
-   [View or modify server folder properties](Manage-Server-Folders-in-Windows-Server-Essentials.md#BKMK_10)  
  
###  <a name="BKMK_Hide"></a> Hide server folders  
 As a network administrator, you can choose to hide any of these server folders and prevent them from being displayed on the Remote Web Access website or Web Services applications (such as My Server).  
  
> [!NOTE]
>  You must be a network administrator to perform this procedure.  
  
##### To hide server folders from being displayed in Remote Web Access  
  
1.  Open the Windows Server Essentials Dashboard.  
  
2.  Click **STORAGE**, and then click **Server Folders**.  
  
3.  In the list view, select the server folder whose properties you want to view or modify.  
  
4.  In the **<ServerFolder\> Tasks** pane, click **View folder properties**.  
  
5.  In **<FolderName\> Properties**, click **Sharing**, select **Hide this folder from Remote Web Access and Web Service applications**, and then click **Apply**.  
  
###  <a name="BKMK_Perms"></a> Set permissions to server folders  
 For any additional server folder that you add on the server by using the Dashboard, you can choose three different access settings for it:  
  
-   **Read/Write**  
  
     Choose this setting if you want to allow this person to create, change, and delete any files in the server folder.  
  
-   **Read-only**  
  
     Choose this setting if you want to allow this person to only read the files in the server folder. Users with read-only access cannot create, change, or delete any files in the server folder.  
  
-   **No access**  
  
     Choose this setting if you do not want this person to access any files in the server folder.  
  
> [!IMPORTANT]
>  The permissions that are displayed in the folder properties represent only the users that are managed by the Dashboard. They do not include user permissions such as groups or service accounts, or include any permission that may be set on the folder by using other native tools, or include users that were not added through the Dashboard.  
  
> [!NOTE]
>  You must be a network administrator to perform this procedure.  
  
##### To set permissions to server folders on the server  
  
1.  Open the Windows Server Essentials Dashboard.  
  
2.  Click **STORAGE**, and then click **Server Folders**.  
  
3.  In the list view, select the server folder whose properties you want to view or modify.  
  
4.  In the **<ServerFolder\> Tasks** pane, click **View folder properties**.  
  
5.  In **<FolderName\> Properties**, click **Sharing**, and select the appropriate user access level for the listed user accounts, and then click **Apply**.  
  
> [!NOTE]
>  By default, when you add a user account to your network, a subfolder is created for the user under the **Users** folder on the server. The subfolder can be accessed from a network computer by only the user or the administrator. The permissions are set for each subfolder under **Users**, so there are no general access permissions for the top-level **Users** folder.  
  
> [!NOTE]
>  You cannot modify the sharing permissions for the **File History Backups**, **Folder Redirection**, and **Users** server folders. Hence, the folder properties of these server folders do not include a **Sharing** tab.  
  
###  <a name="BKMK_10"></a> View or modify server folder properties  
 You can modify the server folder name, its description, and define which user accounts have access to a server folder through the **View the folder properties** task on the **Server Folders** tab of the Dashboard.  
  
> [!NOTE]
>  In  Windows Server Essentials and  Windows Server 2012 R2 with the  Windows Server Essentials Experience role installed, you can also modify folder quota.  
  
##### To view or modify folder properties  
  
1.  Open the Windows Server Essentials Dashboard.  
  
2.  Click **STORAGE**, and then click **Server Folders**.  
  
3.  In the list view, select the server folder whose properties you want to view or modify.  
  
4.  In the **<ServerFolder\> Tasks** pane, click **View folder properties**.  
  
5.  In **<Foldername\> Properties**, on the **General** tab, view or modify the name and description of the server folder.  
  
    > [!NOTE]
    >  In  Windows Server Essentials and  Windows Server 2012 R2 with the  Windows Server Essentials Experience role installed, you can also modify folder quota that gives a warning message when a server folder reaches its specified size.  
  
##  <a name="BKMK_5"></a> Add or move a server folder  
 You can **add more server folders** to store your files on the server in addition to the default server folders that are created during setup. You can add server folders on either the primary server or a member server running Windows Server Essentials.  
  
 You can **move a server folder** that is located on the primary server running Windows Server Essentials and is displayed on the **Server Folders** tab of the Dashboard to another hard drive when needed by using the Move a Folder Wizard. You can move a server folder to another hard drive location address if:  
  
- The data hard drive no longer has enough space to store data.  
  
- You want to change the default storage location. For a faster move, consider moving the server folder while it does not include any data.  
  
- You want to remove the existing hard drive without losing the server folders that are located on it.  
  
  Before moving the folder, ensure the following:  
  
- Ensure that you have backed up your server.  
  
- Ensure that all client backups are stopped and not in progress if you plan on moving the Client Computer Backup folder. While moving the Client Computer Backup folder, the server will be unable to back up any client computers until the folder move is completed.  
  
- Ensure that the server is not performing any critical system operations. It is recommended that you complete any updates or backups that are in progress before you start a folder move or the process may take longer to complete.  
  
- None of the files in the folder to be moved are in use. You will be unable to access the server folder while it is being moved.  
  
  Moving a folder from NTFS to ReFS is not supported if the files in the server folders implement the following technologies:  
  
- Alternate Data Streams  
  
- Object IDs  
  
- Short names (8.3 names)  
  
- Compression  
  
- EFS encryption  
  
- Transactional NTFS, TxF (introduced with Windows Vista)  
  
- Sparse files  
  
- Hard links  
  
- Extended Attributes  
  
- Quotas  
  
###  <a name="BKMK_6"></a> Where to add or move a server folder  
 Typically, you should add or move server folders onto hard drives that have the maximum amount of free space. If possible, avoid adding or moving a shared folder to the system drive (such as C:) as it may take away the necessary drive space that is required for the operating system and its updates. Also, avoid adding or moving server folders to an external hard drive because they can be easily disconnected, and as a result, you may not be able to access your files. Instead, we recommend that you create the folder on an internal drive.  
  
 A server folder cannot be added or moved to the following locations and will result in an error if any of these locations is selected for additions or moves:  
  
-   A hard drive that is not formatted with the NTFS or ReFS file system  
  
-   The %windir% folder  
  
-   A mapped network drive  
  
-   A folder that contains a shared folder  
  
-   A hard drive that is located under **Device with Removable Storage**  
  
-   A root directory of a hard drive (such as C:\\, D:\\,  E:\\)  
  
-   A sub-folder of an existing shared folder  
  
-   A member server running  Windows Server Essentials or  Windows Server 2012 R2 with the  Windows Server Essentials Experience role installed  
  
### Steps to add or move a server folder  
  
> [!NOTE]
>  You must be a server administrator to complete these procedures.  
  
##### To add a server folder  
  
1. Open the Dashboard.  
  
2. Click **STORAGE**, and then click **Server Folders**.  
  
3. In **Server Folder Tasks**, click **Add a folder**. This launches the Add a Folder Wizard.  
  
4. Follow the instructions to complete the wizard.  
  
   > [!NOTE]
   > - If you browse for a specific folder by using the Browse button to specify the server folder location, the folder that you have navigated to is added as a server folder.  
   >   -   You can define which server folders can be accessed via Remote Web Access. For more information, see [Manage access to server folders](Manage-Server-Folders-in-Windows-Server-Essentials.md#BKMK_1).  
  
##### To move a server folder  
  
1.  Open the Dashboard.  
  
2.  Click **STORAGE**, and then click **Server Folders**.  
  
3.  From the list of server folders, select the folder that you want to move.  
  
4.  In the Tasks pane, click **Move the folder**.  
  
5.  Follow the instructions to complete the wizard.  
  
##  <a name="BKMK_9"></a> Add a missing server folder  
 When the server detects that a pre-defined server folder ?Company, Users, Client Computer Backups, File History Backup, or Folder Redirection ?is no longer shared (for some reason or another), an alert is generated to guide the user to resolve this issue. It is recommended that you try and restore the folder from server backup. However, if the server has not been backed up, select the missing folder and then click **Recreate the missing folder** to reconfigure the location of the server folder.  
  
> [!NOTE]
>  Only pre-defined folders ?Company, Users, Client Computer Backups, File History Backup, or Folder Redirection ?can be recreated. User-created server folders and media server folders cannot be recreated.  
  
 After you restore or recreate the missing folder, it should no longer be listed as **Missing**.  
  
 For information about restoring files from server backups, see the section Learn more about restoring files and folders in the topic [Manage Backup and Restore](Manage-Backup-and-Restore-in-Windows-Server-Essentials.md).  
  
##  <a name="BKMK_11"></a> Understand shared folders  
 There are several different ways that you can access your shared folders on Windows Server Essentials from a device that is connected to the server. For more information, see the topic [Use Shared Folders](../use/Use-Shared-Folders-in-Windows-Server-Essentials.md).  
  
##  <a name="BKMK_Shadow"></a> Understand shadow copies  
 With server Shadow Copies, users can view shared files and folders as they existed at points of time in the past. Accessing previous versions of files, or shadow copies, is useful because users can:  
  
1. **Recover files that were accidentally deleted**. If you accidentally delete a file, you can open a previous version and copy it to a safe location.  
  
2. **Recover from accidentally overwriting a file**. If you accidentally overwrite a file, you can recover a previous version of the file. (The number of versions depends on how many snapshots you have created.)  
  
3. **Compare versions of a file while working**. You can use previous versions when you want to check what has changed between versions of a file.  
  
   To use Shadow Copies, from a client computer, right-click a server shared folder and select **Restore Previous Version**.  
  
## See also  
  
-   [Manage Server Storage](Manage-Server-Storage-in-Windows-Server-Essentials.md)  
  
-   [Use Shared Folders](../use/Use-Shared-Folders-in-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](Manage-Windows-Server-Essentials.md)
