---
title: Create a File Screen Exception
description: This article describes how to create a file screen exception
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Create a File Screen Exception

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

Occasionally, you need to allow exceptions to file screening. For example, you might want to block video files from a file server, but you need to allow your training group to save the video files for their computer-based training. To allow files that other file screens are blocking, create a *file screen exception*.

A file screen exception is a special type of file screen that over-rides any file screening that would otherwise apply to a folder and all its subfolders in a designated exception path. That is, it creates an exception to any rules derived from a parent folder.

> [!Note]
> You cannot create a file screen exception on a parent folder where a file screen is already defined. You must assign the exception to a subfolder or make changes to the existing file screen.

<br />
You assign file groups to determine which file types will be allowed in the file screen exception.

## To create a File Screen Exception

1.  In **File Screening Management**, click the **File Screens** node.

2.  Right-click **File Screens**, and click **Create File Screen Exception** (or select **Create File Screen Exception** from the **Actions** pane). This opens the **Create File Screen Exception** dialog box.

3.  In the **Exception path** text box, type or select the path that the exception will apply to. The exception will apply to the selected folder and all of its subfolders.

4.  To specify which files to exclude from file screening:

    -   Under **File groups**, select each file group that you want to exclude from file screening. (To select the check box for the file group, double-click the file group label.)
    -   If you want to view the file types that a file group includes and excludes, click the file group label, and click **Edit**.
    -   To create a new file group, click **Create**.

5.  Click **OK**.

## See also

-   [File Screening Management](file-screening-management.md)
-   [Define File Groups for Screening](define-file-groups-for-screening.md)


