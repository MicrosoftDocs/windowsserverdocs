---
title: "Troubleshoot File History in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ed062945-27e9-4572-b1bb-6c8cf1b9c2f4
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Troubleshoot File History in Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials 
  
## Troubleshoot issues with user File History backups  
 The following issues might occur while managing File History backups for a user or a computer that has been added to a server running Windows Server Essentials.  
  
### File History data is not automatically deleted  
 The File History data may not get deleted automatically if:  
  
- When deleting a user account, you choose to not delete the user account ��s File History data, and opt to delete the data manually.  
  
- When you try to delete the File History data, the File History data is in use by other process.  
  
  To resolve this issue, you must manually delete the File History using the following procedure:  
  
####  <a name="BKMK_manuallyDelete"></a> To manually delete File History backups for a user or a computer  
  
1.  Log on to the server as an administrator.  
  
2.  Run File Explorer as an administrator.  
  
3.  Navigate to the File History Backups folder. The default location is C:\ServerFolders\File History Backups.  
  
4.  Delete the shared folder that stores the File History backup:  
  
    -   To delete file history for a user, delete the File History backup child folder that has the user ��s name.  
  
    -   To delete file history for a computer, delete the File History backup child folder that has the computer name. For example, if a user retired <MyComputer01\> after she began working on her new laptop, <MyComputer02\>, you would delete C:\ServerFolders\File History Backups\\<MyAccount\>\\<MyComputer01\> after you verify with the user that she has transferred all files and folders to her new laptop and has no need for the file history in the future.  
  
### Cannot apply File History setting to a new user  
 If you add a new user whose user name is identical to the user name of a user that has been deleted from Windows Server Essentials, the File History configuration for the new user might fail because of a naming conflict when Windows Server Essentials attempts to create a folder to store the new user's file history. To resolve this issue, you can rename the File History folder for the deleted user.  
  
##### To locate user file history on the server  
  
1.  Log on to the server as an administrator.  
  
2.  On the Windows Server Essentials Dashboard, click **Storage**.  
  
3.  On the **Server Folders** tab, note the location of the File History Backups folder. The default location is %SystemDrive%\ServerFolders\File History Backups\\.  
  
##### To resolve file history issues for a new user with a name conflict  
  
1.  Log on to the server as an administrator.  
  
2.  Run File Explorer as an administrator.  
  
3.  Navigate to the File History Backups folder. The default location is C:\ServerFolders\File History Backups.  
  
     The File History Backups folder has a subfolder for each user account that has been added to Windows Server Essentials. For example, the file history for the user John Smith would be stored in the subfolder File History Backups\JohnSmith.  
  
4.  Rename the subfolder for the user that you deleted, for example, **<*UserName*>_Deleted**. If you no longer need the user's file history, you can delete the folder.  
  

5.  You can now add the new user. For instructions, see Add a user account? in [Manage User Accounts](../manage/Manage-User-Accounts-in-Windows-Server-Essentials.md).  
  
### A user account was removed, but the user's file history remains  
 In some cases the network administrator might choose to remove a user or computer from the server, but to keep the File History backup for future use. When you no longer need the file history, remove the File History Backups folder for the user or the computer from shared folders on the server. To do this, see [To manually delete File History backups for a user or a computer](Troubleshoot-File-History-in-Windows-Server-Essentials.md#BKMK_manuallyDelete).  

5. You can now add the new user. For instructions, see Add a user account? in [Manage User Accounts](../manage/Manage-User-Accounts-in-Windows-Server-Essentials.md).  
  
### A user account was removed, but the user's file history remains  
 In some cases the network administrator might choose to remove a user or computer from the server, but to keep the File History backup for future use. When you no longer need the file history, remove the File History Backups folder for the user or the computer from shared folders on the server. To do this, see [To manually delete File History backups for a user or a computer](../support/Troubleshoot-File-History-in-Windows-Server-Essentials.md#BKMK_manuallyDelete).  

  
## See also  
  
-   [Manage Client Backup](../manage/Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md)  
  

-   [Support Windows Server Essentials](Support-Windows-Server-Essentials.md)

-   [Support Windows Server Essentials](../support/Support-Windows-Server-Essentials.md)

