---
title: Edit Quota Template Properties
description: This article describes how to edit quota template properties to extend changes to quotas created from the original quota template
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Edit Quota Template Properties

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

When you make changes to a quota template, you have the option of extending those changes to quotas that were created from the original quota template. You can choose to modify only those quotas that still match the original template or all quotas that were derived from the original template, regardless of any modifications that were made to the quotas since they were created. This feature simplifies the process of updating the properties of your quotas by providing one central point where you can make all the changes.

> [!Note]
> If you choose to apply the changes to all quotas that were derived from the original template, you will overwrite any custom quota properties that you created.

## To edit Quota Template Properties

1.  In **Quota Templates**, select the template that you want to modify.

2.  Right-click the quota template, and then click **Edit Template Properties** (or in the **Actions** pane, under **Selected Quota Templates,** select **Edit Template Properties**). This opens the **Quota Template Properties** dialog box.

3.  Perform all necessary changes. The settings and notification options are identical to those that you can set when you create a quota template. Optionally, you can copy the properties from a different template and modify them for this one.

4.  When you are finished editing the template properties, click **OK**. This will open the **Update Quotas Derived from Template** dialog box.

5.  Select the type of update that you want to apply:

    -   If you have quotas that have been modified since they were created with the original template, and you do not want to change them, select **Apply template only to derived quotas that match the original template**. This option will update only those quotas that have not been edited since they were created with the original template.
    -   If you want to modify all existing quotas that were created from the original template, select **Apply template to all derived quotas**.
    -   If you want to keep the existing quotas unchanged, select **Do not apply template to derived quotas**.

6.  Click **OK**.

## See also

-   [Quota Management](quota-management.md)
-   [Create a Quota Template](create-quota-template.md)


