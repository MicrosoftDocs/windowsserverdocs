---
title: Create a Quota
description: This article describes how to create a quota based on a template
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Create a Quota

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

Quotas can be created from a template or with custom properties. The following procedure describes how to create a quota that is based on a template (recommended). If you need to create a quota with custom properties, you can save these properties as a template to re-use at a later date.

When you create a quota, you choose a quota path, which is a volume or folder that the storage limit applies to. On a given quota path, you can use a template to create one of the following types of quota:

-   A single quota that limits the space for an entire volume or folder.
-   An auto apply quota, which assigns the quota template to a folder or volume. Quotas based on this template are automatically generated and applied to all subfolders. For more information about creating auto apply quotas, see [Create an Auto Apply Quota](create-auto-apply-quota.md).


> [!Note]
> By creating quotas exclusively from templates, you can centrally manage your quotas by updating the templates instead of the individual quotas. Then, you can apply changes to all quotas based on the modified template. This feature simplifies the implementation of storage policy changes by providing one central point where all updates can be made.

## To create a quota that is based on a template

1.  In **Quota Management**, click the **Quota Templates** node.

2.  In the Results pane, select the template on which you will base your new quota.

3.  Right-click the template and click **Create Quota from Template** (or select **Create Quota from Template** from the **Actions** pane). This opens the **Create Quota** dialog box with the summary properties of the quota template displayed.

4.  Under **Quota path**, type or browse to the folder that the quota will apply to.

5.  Click the **Create quota on path** option. Note that the quota properties will apply to the entire folder.

     > [!Note]
     > To create an auto apply quota, click the **Auto apply template and create quotas on existing and new subfolders** option. For more information about auto apply quotas, see [Create an Auto Apply Quota](create-auto-apply-quota.md)

6.  Under **Derive properties from this quota template**, the template you used in step 2 to create your new quota is pre-selected (or you can select another template from the list). Note that the template's properties are displayed under **Summary of quota properties**.

7.  Click **Create**.

## See also

-   [Quota Management](quota-management.md)
-   [Create an Auto Apply Quota](create-auto-apply-quota.md)
-   [Create a Quota Template](create-quota-template.md)


