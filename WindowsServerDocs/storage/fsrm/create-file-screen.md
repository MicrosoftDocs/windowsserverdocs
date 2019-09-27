---
title: Create a File Screen
description: This article describes how to create a file screen
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Create a File Screen

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

When creating a new file screen, you can choose to save a file screen template that is based on the custom file screen properties that you define. The advantage of this is that a link is maintained between file screens and the template that is used to create them, so that in the future, changes to the template can be applied to all file screens that derive from it. This is a feature that simplifies the implementation of storage policy changes by providing one central point where you can make all updates.

## To create a File Screen with custom properties

1.  In **File Screening Management**, click the **File Screens** node.

2.  Right-click **File Screens,** and click **Create File Screen** (or select **Create File Screen** from the **Actions** pane). This opens the **Create File Screen** dialog box.

3.  Under **File screen path**, type the name of or browse to the folder that the file screen will apply to. The file screen will apply to the selected folder and all of its subfolders.

4.  Under **How do you want to configure file screen properties**, click **Define custom file screen properties**, and then click **Custom Properties**. This opens the **File Screen Properties** dialog box.

5.  If you want to copy the properties of an existing template to use as a base for your file screen, select a template from the **Copy properties from template** drop-down list. Then click **Copy**.

    In the **File Screen Properties** dialog box, modify or set the following values on the **Settings** tab:

6.  Under **Screening type**, click the **Active screening** or **Passive screening** option. (Active screening prevents users from saving files that are members of blocked file groups and generates notifications when users try to save unauthorized files. Passive screening sends configured notifications, but it does not prevent users from saving files.)

7.  Under **File groups**, select each file group that you want to include in your file screen. (To select the check box for the file group, double-click the file group label.)

    If you want to view the file types that a file group includes and excludes, click the file group label, and then click **Edit**. To create a new file group, click **Create**.

8.  Additionally, you can configure **File Server Resource Manager** to generate one or more notifications by setting options on the **E-mail Message**, **Event Log**, **Command**, and **Report** tabs. For more information about file screen notification options, see [Create a File Screen Template](create-file-screen-template.md).

9.  After you have selected all the file screen properties that you want to use, click **OK** to close the **File Screen Properties** dialog box.

10. In the **Create File Screen** dialog box, click **Create** to save the file screen. This opens the **Save Custom Properties as a Template** dialog box.

11. Select the type of custom file screen you want to create:

    -   To save a template that is based on these customized properties (recommended), click **Save the custom properties as a template** and enter a name for the template. This option will apply the template to the new file screen, and you can use the template to create additional file screens in the future. This will enable you to later update the file screens automatically by updating the template.
    -   If you do not want to save a template when you save the file screen, click **Save the custom file screen without creating a template**.

12. Click **OK**.

## See also

-   [File Screening Management](file-screening-management.md)
-   [Define File Groups for Screening](define-file-groups-for-screening.md)
-   [Create a File Screen Template](create-file-screen-template.md)
-   [Edit File Screen Template Properties](edit-file-screen-template-properties.md)


