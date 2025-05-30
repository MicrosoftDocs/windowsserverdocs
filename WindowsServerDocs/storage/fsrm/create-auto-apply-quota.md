---
title: Create an Auto Apply Quota
description: This article describes how to create auto apply quotas based on a quota template
ms.date: 7/7/2017
ms.topic: how-to
author: robinharwood
manager: brianlic
ms.author: roharwoo
---
# Create an Auto Apply Quota

By using auto apply quotas, you can assign a quota template to a parent volume or folder. Then File Server Resource Manager automatically generates quotas that are based on that template. Quotas are generated for each of the existing subfolders and for subfolders that you create in the future.

For example, you can define an auto apply quota for subfolders that are created on demand, for roaming profile users, or for new users. Every time a subfolder is created, a new quota entry is automatically generated by using the template from the parent folder. These automatically generated quota entries can then be viewed as individual quotas under the **Quotas** node. Each quota entry can be maintained separately.

## To create an Auto Apply Quota

1.  In **Quota Management**, click the **Quotas** node.

2.  Right-click **Quotas**, and then click **Create Quota** (or select **Create Quota** from the **Actions** pane). This opens the **Create Quota** dialog box.

3.  Under **Quota path**, type the name of or browse to the parent folder that the quota profile will apply to. The auto apply quota will be applied to each of the subfolders (current and future) in this folder.

4.  Click **Auto apply template and create quotas on existing and new subfolders**.

5.  Under **Derive properties from this quota template**, select the quota template that you want to apply from the drop-down list. Note that each template's properties are displayed under **Summary of quota properties**.

6.  Click **Create**.

> [!Note]
> You can verify all automatically generated quotas by selecting the **Quotas** node and then selecting **Refresh**. An individual quota for each subfolder and the auto apply quota profile in the parent volume or folder are listed.

## Additional References

-   [Quota Management](quota-management.md)
-   [Edit Auto Apply Quota Properties](edit-auto-apply-quota-properties.md)
