---
title: Define File Groups for Screening
description: This article describes how to define file groups to create a namespace for file screen, file screen exception, or files by file group storage reports
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Define File Groups for Screening

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

A *file group* is used to define a namespace for a file screen, file screen exception, or **Files by File Group** storage report. It consists of a set of file name patterns, which are grouped by the following:

-   **Files to include**: files that belong in the group
-   **Files to exclude**: files that do not belong in the group

> [!Note]
> For convenience, you can create and edit file groups while you edit the properties of file screens, file screen exceptions, file screen templates, and **Files by File Group** reports. Any file group changes that you make from these property sheets are not limited to the current item that you are working on.

## To create a File Group

1.  In **File Screening Management**, click the **File Groups** node.

2.  On the **Actions** pane, click **Create File Group**. This opens the **Create File Group Properties** dialog box.

    (Alternatively, while you edit the properties of a file screen, file screen exception, file screen template, or **Files by File Group** report, under **Maintain file groups**, click **Create**.)

3.  In the **Create File Group Properties** dialog box, type a name for the file group.

4.  Add files to include and files to exclude:

    -   For each set of files that you want to include in the file group, in the **Files to include** box, enter a file name pattern, and then click **Add**.
    -   For each set of files that you want to exclude from the file group, in the **Files to exclude** box, enter a file name pattern, and then click **Add**.
        Note that standard wildcard rules apply, for example, **\*.exe** selects all executable files.

5.  Click **OK**.

## See also

-   [File Screening Management](file-screening-management.md)
-   [Create a File Screen](create-file-screen.md)
-   [Create a File Screen Exception](create-file-screen-exception.md)
-   [Create a File Screen Template](create-file-screen-template.md)
-   [Storage Reports Management](storage-reports-management.md)


