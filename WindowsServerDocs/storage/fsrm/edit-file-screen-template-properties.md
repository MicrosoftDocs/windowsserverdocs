---
title: Edit File Screen Template Properties
description: This article describes how to edit file screen template properties 
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Edit File Screen Template Properties

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

When you make changes to a file screen template, you have the option of extending those changes to file screens that were created with the original file screen template. You can choose to modify only those file screens that match the original template or all file screens that derive from the original template, regardless of any modifications that you made to the file screens since they were created. This feature simplifies the process of updating the properties of file screens by providing one central point where you make all the changes.

> [!Note]
> If you apply the changes to all file screens that derive from the original template, you will overwrite any custom file screen properties that you created.

## To edit File Screen Template Properties

1.  In **File Screen Templates**, select the template that you want to modify.

2.  Right-click the file screen template and click **Edit Template Properties** (or in the **Actions** pane, under **Selected File Screen Templates**, select **Edit Template Properties**.) This opens the **File Screen Template Properties** dialog box.

3.  If you want to copy the properties of another template as a base for your modified template, select a template from the **Copy properties from template** drop-down list. Then click **Copy**.

4.  Perform all necessary changes. The settings and notification options are identical to those that are available when you create a file screen template.

5.  When you are finished editing the template properties, click **OK**. This will open the **Update File Screens Derived from Template** dialog box.

6.  Select the type of update that you want to apply:

    -   If you have file screens that have been modified since they were created using the original template, and you do not want to change them, click **Apply template only to derived file screens that match the original template**. This option will update only those file screens that have not been edited since they were created with the original template properties.
    -   If you want to modify all existing file screens that were created using the original template, click **Apply template to all derived file screens**.
    -   If you want to keep the existing file screens unchanged, click **Do not apply template to derived file screens**.

7.  Click **OK**.

## See also

-   [File Screening Management](file-screening-management.md)
-   [Create a File Screen Template](create-file-screen-template.md)


