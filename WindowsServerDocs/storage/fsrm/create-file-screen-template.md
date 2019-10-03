---
title: Create a File Screen Template
description: This article describes how to create a file screen template
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Create a File Screen Template

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

A *file screen template* defines a set of file groups to screen, the type of screening to perform (active or passive), and optionally, a set of notifications that will be generated automatically when a user saves, or attempts to save, an unauthorized file.

File Server Resource Manager can send e-mail messages to administrators or specific users, log an event, execute a command or a script, or generate reports. You can configure more than one type of notification for a file screen event.

By creating file screens exclusively from templates, you can centrally manage your file screens by updating the templates instead of replicating changes in each file screen. This feature simplifies the implementation of storage policy changes by providing one central point where you can make all updates.

> [!Important]
> To send e-mail notifications and to configure the storage reports with parameters that are appropriate for your server environment, you must first set the general File Server Resource Manager options. For more information, see [Setting File Server Resource Manager Options](setting-file-server-resource-manager-options.md).

## To create a File Screen Template

1.  In **File Screening Management**, click the **File Screen Templates** node.

2.  Right-click **File Screen Templates**, and then click **Create File Screen Template** (or select **Create File Screen Template** from the **Actions** pane). This opens the **Create File Screen Template** dialog box.

3.  If you want to copy the properties of an existing template to use as a base for your new template, select a template from the **Copy properties from template** drop-down list and then click **Copy**.

    Whether you have chosen to use the properties of an existing template or you are creating a new template, modify or set the following values on the **Settings** tab:

4.  In the **Template name** text box, enter a name for the new template.

5.  Under **Screening type**, click the **Active screening** or **Passive screening** option. (Active screening prevents users from saving files that are members of blocked file groups and generates notifications when users try to save unauthorized files. Passive screening sends configured notifications, but it does not prevent users from saving files).

6.  To specify which file groups to screen:

    Under **File groups**, select each file group that you want to include. (To select the check box for the file group, double-click the file group label.)

    If you want to view the file types that a file group includes and excludes, click the file group label, and then click **Edit**. To create a new file group, click **Create**.

    Additionally, you can configure File Server Resource Manager to generate one or more notifications by setting the following options on the **E-mail Message**, **Event Log**, **Command**, and **Report** tabs.

7.  To configure e-mail notifications:

    On the **E-mail Message** tab, set the following options:

    -   To notify administrators when a user or application attempts to save an unauthorized file, select the **Send e-mail to the following administrators** check box, and then enter the names of the administrative accounts that will receive the notifications. Use the format *account*@*domain*, and use semicolons to separate multiple accounts.
    -   To send e-mail to the user who attempted to save the file, select the **Send e-mail to the user who attempted to save an unauthorized file** check box.
    -   To configure the message, edit the default subject line and message body that are provided. The text that is in brackets inserts variable information about the file screen event that caused the notification. For example, the \[**Source Io Owner**\] variable inserts the name of the user who attempted to save an unauthorized file. To insert additional variables in the text, click **Insert Variable**.
    -   To configure additional headers (including From, Cc, Bcc, and Reply-to), click **Additional E-mail Headers**.

8.  To log an error to the event log when a user tries to save an unauthorized file:

    On the **Event Log** tab, select the **Send warning to event log** check box, and edit the default log entry.

9.  To run a command or script when a user tries to save an unauthorized file:

    On the **Command** tab, select the **Run this command or script** check box. Then type the command, or click **Browse** to search for the location where the script is stored. You can also enter command arguments, select a working directory for the command or script, or modify the command security setting.

10. To generate one or more storage reports when a user tries to save an unauthorized file:

    On the **Report** tab, select the **Generate reports** check box, and then select which reports to generate. (You can choose one or more administrative e-mail recipients for the report or e-mail the report to the user who attempted to save the file.)

    The report is saved in the default location for incident reports, which you can modify in the **File Server Resource Manager Options** dialog box.

11. After you have selected all the file template properties that you want to use, click **OK** to save the template.

## See also

-   [File Screening Management](file-screening-management.md)
-   [Setting File Server Resource Manager Options](setting-file-server-resource-manager-options.md)
-   [Edit File Screen Template Properties](edit-file-screen-template-properties.md)

