---
title: Create a Custom File Management Task
description: This article describes how to create a custom file management task and custom tasks.
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Create a Custom File Management Task

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

Expiration is not always a desired action to be performed on files. File management tasks allow you to run custom commands as well.

> [!Note]
> This procedure assumes that you are familiar with file management tasks, and therefore only covers the **Action** tab where custom settings are configured.

## To create a custom task

1.  Click the **File Management Tasks** node.

2.  Right-click **File Management Tasks**, and then click **Create File Management Task** (or click **Create File Management Task** in the **Actions** pane). This opens the **Create File Management Task** dialog box.

3.  On the **Action** tab, enter the following information:

    -   **Type**. Select **Custom** from the drop-down menu.
    -   **Executable**. Type or browse to a command to run when the file management task processes files. This executable must be set to be writable by Administrators and System only. If any other users have write access to the executable, it will not run correctly.
    -   **Command settings**. To configure the arguments passed to the executable when a file management job processes files, edit the text box labeled **Arguments**. To insert additional variables in the text, place the cursor in the location in the text box where you want to insert the variable, select the variable that you want to insert, and then click **Insert Variable**. The text that is in brackets inserts variable information that the executable can receive. For example, the \[Source File Path\] variable inserts the name of the file that should be processed by the executable. Optionally, click the **Working directory** button to specify the location of the custom executable.
    -   **Command Security**. Configure the security settings for this executable. By default, the command is run as Local Service, which is the most restrictive account available.

4.  Click **OK**.

## See also

-   [Classification Management](classification-management.md)
-   [File Management Tasks](file-management-tasks.md)