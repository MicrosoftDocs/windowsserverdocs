---
title: File Server Resource Manager (FSRM) overview
ms.prod: windows-server-threshold
ms.author: jgerend
ms.manager: brianlic
ms.technology: storage
ms.topic: article
author: jasongerend
ms.date: 5/10/2018
description: File Server Resource Manager (FSRM) is a tool that enables you to manage and classify data on a Windows Server file server.
---
# File Server Resource Manager (FSRM) overview

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

File Server Resource Manager (FSRM) is a role service in Windows Server that enables you to manage and classify data stored on file servers. File Server Resource Manager includes the following features:
  
-   **File Classification Infrastructure** File Classification Infrastructure provides insight into your data by automating classification processes so that you can manage your data more effectively. You can classify files and apply policies based on this classification. Example policies include dynamic access control for restricting access to files, file encryption, and file expiration. Files can be classified automatically by using file classification rules or manually by modifying the properties of a selected file or folder.  
  
-   **File Management Tasks** File Management Tasks enables you to apply a conditional policy or action to files based on their classification. The conditions of a file management task include the file location, the classification properties, the date the file was created, the last modified date of the file, or the last time the file was accessed. The actions that a file management task can take include the ability to expire files, encrypt files, or run a custom command.  
  
-   **Quota management** Quotas allow you to limit the space that is allowed for a volume or folder, and they can be automatically applied to new folders that are created on a volume. You can also define quota templates that can be applied to new volumes or folders.  
  
-   **File screening management** File screens help you control the types of files that user can store on a file server. You can limit the extension that can be stored on your shared files. For example, you can create a file screen that does not allow files with an MP3 extension to be stored in personal shared folders on a file server.  
  
-   **Storage reports** Storage reports are used to help you identify trends in disk usage and how your data is classified. You can also monitor a selected group of users for attempts to save unauthorized files.  
  
-   **Turn off change journals on all volumes** Starting with Windows Server 2106, version 1803, you can now prevent the File Server Resource Manager service from creating a change journal (also known as a USN journal) on all volumes when the service starts. This can conserve a little bit of space on each volume, but will disable real-time file classification. 
- To prevent File Server Resource Manager from creating a change journal on all volumes when the service starts, use the following steps:

    1. Stop the SRMSVC service.
    2. Delete the USN journal for volumes by using the fsutil command: 

      ```
      fsutil usn deletejournal /d <VolumeName>
      ```

      For example: `fsutil usn deletejournal /d c:`

    3. To skip USN journal creation for the entire server, set this registry key value to **1**:
       Key name: **SkipUSNCreationForSystem** (DWORD)
       Full path: **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SrmSvc\Settings**

       To skip USN creation for certain specified volumes, use a new regkey to specify volume paths (comma separated)
       Key name: **SkipUSNCreationForVolumes** (REG_MULTI_SZ): This will contain the volume paths
       Full Path: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SrmSvc\Settings
       
       Users can obtain volume paths using `fsutil volume list` command. Volume path comparisons aren't sensitive to case.

    4. Start the SRMSVC service.
    
 The features included with File Server Resource Manager can be configured and managed by using the File Server Resource Manager Microsoft Management Console (MMC) or by using Windows PowerShell.  
  
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

## See also

- [What's New in File Server Resource Manager](https://technet.microsoft.com/library/dn383587.aspx)
- [Dynamic Access Control](https://technet.microsoft.com/library/dn408191(v=ws.11).aspx) 