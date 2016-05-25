---
title: Configure File Management Tasks
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2d4a6ef1-61bf-49aa-9339-44a56d2781ca
author: JasonGerend
---
# Configure File Management Tasks
The following procedure guides you through the process of creating a file management task for expiring files, often referred to as a file expiration task. File expiration tasks are used to automatically move all files that match certain criteria to a specified expiration directory. An administrator can then back those files up and delete them. You can also use the procedure to create a file management task that applies Rights Management Services \(RMS\) encryption or performs a custom action.  
  
When a file expiration task is run, a new directory is created within the expiration directory. The directory is grouped by the server name on which the task was run. The new directory name is based on the name of the file management task and the time it was run. When an expired file is found it is moved into the new directory, while preserving its original directory structure.  
  
#### To create a file management task  
  
1.  Click the **File Management Tasks** node.  
  
2.  Right\-click **File Management Tasks**, and then click **Create File Management Task**. This opens the **Create File Management Task** dialog box.  
  
3.  On the **General** tab, enter the following information:  
  
    -   **Name**. Enter a name for the new task.  
  
    -   **Description**. Enter an optional descriptive label for this task.  
  
4.  On the **Scope** tab, specify what folders you want to classify by entering the following information:  
  
    -   Optionally, click **Set Folder Management Properties** to assign Folder Usage property values to folders and then click **Close** when you are finished. The Folder Usage property specifies the purpose of a folder and the kind of files that are stored in it. File management tasks and classification rules can use the value of the Folder Usage property that is assigned to a folder to determine whether to include the folder in a file management task or classification rule.  
  
    -   In the first box, specify the folders to include based on the Folder Usage property values that are assigned to the folders. When you select a Folder Usage property, all folders with that property assigned are listed as part of the scope.  
  
    -   Click **Add** to manually specify folders to include—independent of their assigned Folder Usage values.  
  
5.  On the **Action** tab, enter the following information:  
  
    -   **Type**. Select **File Expiration** from the drop\-down list \(unless you want to apply RMS Encryption or perform a custom action instead\).  
  
    -   **Expiration Directory**. Select a directory or file share where the files will expire to. To use a file share, the computer account of the file server must have **Modify** permissions on the folder and **Full Control** share permissions.  
  
        > [!WARNING]  
        > Do not select a directory that is within the scope of the task, as specified on the **Scope** tab. Doing so could cause an iterative loop that could lead to system instability and data loss.  
  
6.  Optionally, on the **Notification** tab, click **Add** to send email notifications, to log an event, or to run a command or script a specified number of days in advance of when the task performs an action on a file.  
  
7.  Optionally, use the **Report** tab to generate one or more logs or storage reports.  
  
    > [!NOTE]  
    > The report is saved in the default location for incident reports, which you can modify in the **File Server Resource Manager Options** dialog box.  
  
8.  Optionally, use the **Condition** tab to run this task only on files that match a defined set of conditions.  
  
    Use the **Property conditions** section to add, edit, or remove conditions based on the file’s classification. Use the remaining fields on the tab to specify time\-related conditions and file name pattern conditions.  
  
9. On the **Schedule** tab, specify when the task should run, and then click **OK**.  
  
