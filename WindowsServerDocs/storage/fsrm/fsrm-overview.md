---
title: File Server Resource Manager (FSRM) overview
ms.prod: windows-server-threshold
ms.author: jgerend
ms.manager: brianlic
ms.technology: storage
ms.topic: article
author: jasongerend
ms.date: 5/14/2018
description: File Server Resource Manager (FSRM) is a tool that enables you to manage and classify data on a Windows Server file server.
---
# File Server Resource Manager (FSRM) overview

> Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server (Semi-Annual Channel), 

File Server Resource Manager (FSRM) is a role service in Windows Server that enables you to manage and classify data stored on file servers. You can use File Server Resource Manager to automatically classify files, perform tasks based on these classifications, set quotas on folders, and create reports monitoring storage usage.

It's a small point, but we also [added the ability to disable change journals](#whats-new) in Windows Server, version 1803.

## Features

File Server Resource Manager includes the following features:

-   [Quota management](quota-management.md) allows you to limit the space that is allowed for a volume or folder, and they can be automatically applied to new folders that are created on a volume. You can also define quota templates that can be applied to new volumes or folders.  
-   [File Classification Infrastructure](classification-management.md)  provides insight into your data by automating classification processes so that you can manage your data more effectively. You can classify files and apply policies based on this classification. Example policies include dynamic access control for restricting access to files, file encryption, and file expiration. Files can be classified automatically by using file classification rules or manually by modifying the properties of a selected file or folder.
-   [File Management Tasks](file-management-tasks.md) enables you to apply a conditional policy or action to files based on their classification. The conditions of a file management task include the file location, the classification properties, the date the file was created, the last modified date of the file, or the last time the file was accessed. The actions that a file management task can take include the ability to expire files, encrypt files, or run a custom command.
-   [File screening management](file-screening-management.md) helps you control the types of files that user can store on a file server. You can limit the extension that can be stored on your shared files. For example, you can create a file screen that does not allow files with an MP3 extension to be stored in personal shared folders on a file server.
-   [Storage reports](storage-reports-management.md) help you identify trends in disk usage and how your data is classified. You can also monitor a selected group of users for attempts to save unauthorized files.  
  
The features included with File Server Resource Manager can be configured and managed by using the File Server Resource Manager app or by using Windows PowerShell.
  
> [!IMPORTANT]
>  File Server Resource Manager supports volumes formatted with the NTFS file system only. The Resilient File System isn't supported.  
  
## Practical applications  
 Some practical applications for File Server Resource Manager include:  
  
-   Use File Classification Infrastructure with the Dynamic Access Control scenario to create a policy that grants access to files and folders based on the way files are classified on the file server.  
  
-   Create a file classification rule that tags any file that contains at least 10 social security numbers as having personally identifiable information.  
  
-   Expire any file that has not been modified in the last 10 years.  
  
-   Create a 200 megabyte quota for each user’s home directory and notify them when they are using 180 megabytes.  
  
-   Do not allow any music files to be stored in personal shared folders.  
  
-   Schedule a report that runs every Sunday night at midnight that generates a list of the most recently accessed files from the previous two days. This can help you determine the weekend storage activity and plan your server downtime accordingly.  

## <a name="whats-new"></a>What's new - prevent FSRM from creating change journals

Starting with Windows Server, version 1803, you can now prevent the File Server Resource Manager service from creating a change journal (also known as a USN journal) on volumes when the service starts. This can conserve a little bit of space on each volume, but will disable real-time file classification.

For older new features, see [What's New in File Server Resource Manager](https://technet.microsoft.com/library/dn383587.aspx).

To prevent File Server Resource Manager from creating a change journal on some or all volumes when the service starts, use the following steps: 

1. Stop the SRMSVC service. For example, open a PowerShell session as an administrator and enter `Stop-Service SrmSvc`.
2. Delete the USN journal for the volumes you want to conserve space on by using the fsutil command: 

      ```
      fsutil usn deletejournal /d <VolumeName>
      ```
    For example: `fsutil usn deletejournal /d c:`

3. Open Registry Editor, for example, by typing `regedit` in the same PowerShell session.
4. Navigate to the following key: **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SrmSvc\Settings**
5. To optionally skip change journal creation for the entire server (skip this step if you want to disable it only on specific volumes):
    1. Right-click the **Settings** key and then select **New** > **DWORD (32-bit) Value**. 
    1. Name the value `SkipUSNCreationForSystem`.
    1. Set the value to  **1** (in hexidecimal).
6. To optionally skip change journal creation for specific volumes:
    1. Get the volume paths you want to skip by using the `fsutil volume list` command or the following PowerShell command:
        ```PowerShell
        Get-Volume | Format-Table DriveLetter,FileSystemLabel,Path
        ```
       Here's an example output:

       ```
        DriveLetter FileSystemLabel Path
        ----------- --------------- ----
                    System Reserved \\?\Volume{8d3c9e8a-0000-0000-0000-100000000000}\
        C                           \\?\Volume{8d3c9e8a-0000-0000-0000-501f00000000}\
       ```
    2. Back in Registry Editor, right-click the **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SrmSvc\Settings** key and then select **New** > **Multi-String Value**.
    3. Name the value `SkipUSNCreationForVolumes`.
    4. Enter the path of each volume on which you skip creating a change journal, placing each path on a separate line. For example:

        ```
        \\?\Volume{8d3c9e8a-0000-0000-0000-100000000000}\
        \\?\Volume{8d3c9e8a-0000-0000-0000-501f00000000}\
        ```

        > [!NOTE] 
        > Registry Editor might tell you that it removed empty strings, displaying this warning that you can safely disregard: *Data of type REG_MULTI_SZ cannot contain empty strings. Registry Editor will remove all empty strings found.*

7. Start the SRMSVC service. For example, in a PowerShell session enter `Start-Service SrmSvc`.



## See also

- [Dynamic Access Control](https://technet.microsoft.com/library/dn408191(v=ws.11).aspx) 