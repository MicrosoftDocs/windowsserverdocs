---
title: Create a File Expiration Task
description: This article describes the process of creating a file management task for files about to expire
ms.date: 7/7/2017
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Create a File Expiration Task

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

The following procedure guides you through the process of creating a file management task for expiring files. File expiration tasks are used to automatically move all files that match certain criteria to a specified expiration directory, where an administrator can then back those files up and delete them.

When a file expiration task is run, a new directory is created within the expiration directory, grouped by the server name on which the task was run.

The new directory name is based on the name of the file management task and the time it was run. When an expired file is found it is moved into the new directory, while preserving its original directory structure.

## To create a file expiration task

1. Click the **File Management Tasks** node.

2. Right-click **File Management Tasks**, and then click **Create File Management Task** (or click **Create File Management Task** in the **Actions** pane). This opens the **Create File Management Task** dialog box.

3. On the **General** tab, enter the following information:

   -   **Name**. Enter a name for the new task.  

   -   **Description**. Enter an optional descriptive label for this task.  
    
   -   **Scope**. Add the directories that this task should operate on by using the **Add** button. Optionally, directories can be removed from the list using the **Remove** button. The file management task will apply to all folders and their subfolders in this list.

4. On the **Action** tab, enter the following information:

   - **Type**. Select **File Expiration** from the drop-down box.

   - **Expiration Directory**. Select a directory where files will be expired to.

     > [!Warning]
     > Do not select a directory that is within the scope of the task, as defined in the previous step. Doing so could cause an iterative loop that could lead to system instability and data loss.

5. Optionally, on the **Notification** tab, click **Add** to send e-mail notifications, log an event, or run a command or script a specified minimum number of days before the task performs an action on a file.

   - In the **Number of days before task is executed to send notification** combo box, type or select a value to specify the minimum number of days prior to a file being acted on that a notification will be sent.

     > [!Note]
     > Notifications are sent only when a task is run. If the specified minimum number of days to send a notification does not coincide with a scheduled task, the notification will be sent on the day of the previous scheduled task.

   - To configure e-mail notifications, click the **E-mail Message** tab and enter the following information:

     - To notify administrators when a threshold is reached, select the **Send e-mail to the following administrators** check box, and then enter the names of the administrative accounts that will receive the notifications. Use the format <em>account@domain</em>, and use semicolons to separate multiple accounts.  

     - To send e-mail to the person whose files are about to expire, select the **Send e-mail to the user whose files are about to expire** check box.

     - To configure the message, edit the default subject line and message body that are provided. The text that is in brackets inserts variable information about the quota event that caused the notification. For example, the **\[Source File Owner\]** variable inserts the name of the user whose file is about to expire. To insert additional variables in the text, click **Insert Variable**.

     - To attach a list of the files that are about to expire, click **Attach to the e-mail list of files on which action will be performed**, and type or select a value for **Maximum number of files in the list**.

     - To configure additional headers (including From, Cc, Bcc, and Reply-to), click **Additional E-mail Headers**.  

   - To log an event, click the **Event Log** tab and select the **Send warning to event log** check box, and then edit the default log entry.  

   - To run a command or script, click the **Command** tab and select the **Run this command or script** check box. Then type the command, or click **Browse** to search for the location where the script is stored. You can also enter command arguments, select a working directory for the command or script, or modify the command security setting.

6. Optionally, use the **Report** tab to generate one or more logs or storage reports.

   - To generate logs, select the **Generate log** check box and then select one or more available logs.  

   - To generate reports, select the **Generate a report** check box and then select one or more available report formats.  

   - To create e-mail generated logs or storage reports, select the **Send reports to the following administrators** check box and type one or more administrative e-mail recipients using the format <em>account@domain</em>. Use a semicolon to separate multiple addresses.

     > [!Note]
     > The report is saved in the default location for incident reports, which you can modify in the **File Server Resource Manager Options** dialog box.
        
7. Optionally, use the **Condition** tab to run this task only on files that match a defined set of conditions. The following settings are available:

    -   **Property conditions**. Click **Add** to create a new condition based on the file's classification. This will open the **Property Condition** dialog box, which allows you to select a property, an operator to perform on the property, and the value to compare the property against. After clicking **OK**, you can then create additional conditions, or edit or remove an existing condition.

    -   **Days since file was last modified**. Click the check box and then enter a number of days into the spin box. This will result in the file management task only being applied to files that have not been modified for more than the specified number of days.

    -   **Days since file was last accessed**. Click the check box and then enter a number of days into the spin box. If the server is configured to track timestamps for when files were last accessed, this will result in the file management task only being applied to files that have not been accessed for more than the specified number of days. If the server is not configured to track accessed times, this condition will be ineffective.

    -   **Days since file was created**. Click the check box and then enter a number of days into the spin box. This will result in the task only being applied to files that were created at least the specified number of days ago.  

    -   **Effective starting**. Set a date when this file management task should start processing files. This option is useful for delaying the task until you have had a chance to notify users or make other preparations in advance.

8. On the **Schedule** tab, click **Create Schedule**, and then in the **Schedule** dialog box, click **New**. This displays a default schedule set for 9:00 A.M. daily, but you can modify the default schedule. When you have finished configuring the schedule, click **OK** and then click **OK** again.

## See also

-   [Classification Management](classification-management.md)
-   [File Management Tasks](file-management-tasks.md)