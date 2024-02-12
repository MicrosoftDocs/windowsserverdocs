---
title: File Server Resource Manager (FSRM) overview
ms.author: jgerend
manager: brianlic
ms.topic: article
author: jasongerend
ms.date: 03/15/2023
description: Learn about File Server Resource Manager (FSRM), which is a tool that enables you to manage and classify data on a Windows Server file server.
---

# File Server Resource Manager (FSRM) overview

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

File Server Resource Manager (FSRM) is a role service in Windows Server that enables you to manage and classify data stored on file servers. You can use FSRM to automatically classify files, perform tasks based on these classifications, set quotas on folders, and create reports monitoring storage usage. In Windows Server version 1803, FSRM adds the ability to [prevent the creation of change journals](#whats-new).

> [!NOTE]
> For new features on older versions of Windows Server, see [What's New in File Server Resource Manager](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn383587(v=ws.11)).

## Features

FSRM includes the following features:

- [Quota management](quota-management.md): Limit the space that is allowed for a volume or folder. These limits can be automatically applied to new folders that are created on a volume. You can also define quota templates that can be applied to new volumes or folders.
- [File Classification Infrastructure](classification-management.md): Gain insight into your data by automating classification processes so that you can manage your data more effectively. You can classify files and apply policies based on this classification. Example policies include dynamic access control for restricting access to files, file encryption, and file expiration. Files can be classified automatically by using file classification rules or manually by modifying the properties of a selected file or folder.
- [File Management Tasks](file-management-tasks.md): Gain the ability to apply a conditional policy or action to files based on their classification. The conditions of a file management task include the file location, the classification properties, the date the file was created, the last modified date of the file, or the last time the file was accessed. The actions that a file management task can take include the ability to expire files, encrypt files, or run a custom command.
- [File screening management](file-screening-management.md): Control the types of files that the user can store on a file server. You can limit the extension that can be stored on your shared files. For example, you can create a file screen that doesn't allow files with an MP3 extension to be stored in personal shared folders on a file server.
- [Storage reports](storage-reports-management.md): Use these reports to help you identify trends in disk usage and how your data is classified. You can also monitor a selected group of users for attempts to save unauthorized files.

You can configure and manage the FSRM features by using the FSRM app or by using Windows PowerShell.

> [!IMPORTANT]
> FSRM supports volumes formatted with the NTFS file system only. The Resilient File System isn't supported.

## Practical applications

The following list outlines some practical applications for FSRM:

- Use File Classification Infrastructure with the Dynamic Access Control scenario. Create a policy that grants access to files and folders based on the way files are classified on the file server.

- Create a file classification rule that tags any file that contains at least 10 social security numbers as having customer content.

- Expire any file that hasn't been modified in the last 10 years.

- Create a 200-MB quota for each user's home directory and notify them when they're using 180 MB.

- Disallow any music files to be stored in personal shared folders.

- Schedule a report that runs every Sunday night at midnight that generates a list of the most recently accessed files from the previous two days. This report can help you determine the weekend storage activity and plan your server downtime accordingly.

## <a name="whats-new"></a>What's new - prevent FSRM from creating change journals

Starting with Windows Server, version 1803, you can now prevent the FSRM service from creating a change journal (also known as a USN journal) on volumes when the service starts. This feature can conserve some space on each volume, but disables real-time file classification.

To prevent FSRM from creating a change journal on some or all volumes when the service starts, complete the following steps:

1. Stop the SRMSVC service. Open a PowerShell session as an administrator and enter `Stop-Service SrmSvc`.
1. Delete the USN journal for the volumes you want to conserve space on by using the `fsutil` command:

   ```powershell
   fsutil usn deletejournal /d <VolumeName>
   ```

   For example: `fsutil usn deletejournal /d c:`

1. Open Registry Editor by typing `regedit` in the same PowerShell session.
1. Go to the following key: **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SrmSvc\Settings**.
1. To prevent change journal creation for the entire server, complete the following steps:

   > [!Important]
   > If you want to disable journal creation for specific volumes only, continue to the next step.

   1. Right-click the **Settings** key, and then select **New** > **DWORD (32-bit) Value**.
   1. Name the value `SkipUSNCreationForSystem`.
   1. Set the value to  **1** (in hexadecimal).

1. To prevent change journal creation for specific volumes, complete the following steps:

   1. Identify the volume paths you want to skip. You can use the `fsutil volume list` command or the following PowerShell command:

      ```powershell
      Get-Volume | Format-Table DriveLetter,FileSystemLabel,Path
      ```

      Here's an example output:

      ```console
      DriveLetter FileSystemLabel Path
      ----------- --------------- ----
                   System Reserved \\?\Volume{8d3c9e8a-0000-0000-0000-100000000000}\
      C                           \\?\Volume{8d3c9e8a-0000-0000-0000-501f00000000}\
      ```

   1. Return to your Registry Editor session. Right-click the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SrmSvc\Settings` key, and then select **New** > **Multi-String Value**.
   1. Name the value `SkipUSNCreationForVolumes`.
   1. Enter the path for each volume that you want to skip. Place each path on a separate line. For example:

      ```powershell
      \\?\Volume{8d3c9e8a-0000-0000-0000-100000000000}\
      \\?\Volume{8d3c9e8a-0000-0000-0000-501f00000000}\
      ```

      > [!NOTE]
      > If Registry Editor displays a warning about removed empty strings, you can safely disregard the message. Here’s an example of the message you might see: *Data of type REG_MULTI_SZ cannot contain empty strings. Registry Editor will remove all empty strings found.*

1. Start the SRMSVC service. For example, in a PowerShell session enter `Start-Service SrmSvc`.

## Related links

- [Dynamic Access Control overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn408191(v=ws.11))
