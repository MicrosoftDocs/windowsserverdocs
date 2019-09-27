---
title: Edit Auto Apply Quota Properties 
description: This article describes how to edit auto apply quota properties
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Edit Auto Apply Quota Properties

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

When you make changes to an auto apply quota, you have the option of extending those changes to existing quotas in the auto apply quota path. You can choose to modify only those quotas that still match the original auto apply quota or all quotas in the auto apply quota path, regardless of any modifications that were made to the quotas since they were created. This feature simplifies the process of updating the properties of quotas that were derived from an auto apply quota by providing one central point where you can make all the changes.

> [!Note]
> If you choose to apply the changes to all quotas in the auto apply quota path, you will overwrite any custom quota properties that you have created.

## To edit an Auto Apply Quota

1.  In **Quotas**, select the auto apply quota that you want to modify. You can filter the quotas to show only auto apply quotas.

2.  Right-click the quota entry, and then click **Edit Quota Properties** (or in the **Actions** pane, under **Selected Quotas,** select **Edit Quota Properties**). This opens the **Edit Auto Apply Quota** dialog box.

3.  Under **Derive properties from this quota template**, select the quota template that you want to apply. You can review the properties of each quota template in the summary list box.

4.  Click **OK**. This will open the **Update Quotas Derived from Auto Apply Quota** dialog box.

5.  Select the type of update that you want to apply:

    -   If you have quotas that have been modified since they were automatically generated, and you do not want to change them, select **Apply auto apply quota only to derived quotas that match the original auto apply quota**. This option will update only those quotas in the auto apply quota path that have not been edited since they were automatically generated.
    -   If you want to modify all existing quotas in the auto apply quota path, select **Apply auto apply quota to all derived quotas**.
    -   If you want to keep the existing quotas unchanged but make the modified auto apply quota effective for new subfolders in the auto apply quota path, select **Do not apply auto apply quota to derived quotas**.

6.  Click **OK**.

## See also

-   [Quota Management](quota-management.md)
-   [Create an Auto Apply Quota](create-auto-apply-quota.md)


