---
title: Change a drive letter
description: Learn how to change or assign a Windows drive letter by using the Change Drive Letter and Paths feature in Disk Management.
ms.date: 08/21/2024
ms.topic: how-to
author: jasongerend
manager: brianlic
ms.author: jgerend
---

# Change a drive letter

> **

If you want to change a drive letter assigned to a drive, or you have a drive that doesn't yet have a drive letter, use Disk Management to change it. You can also mount the drive in an empty folder so that it appears as a folder. For more information, see [Mount a drive in a folder](assign-a-mount-point-folder-path-to-a-drive.md).

> [!IMPORTANT]
> If you change the drive letter of a drive that already contains Windows or apps, apps might have trouble running or finding the drive. We suggest not changing the drive letter of a drive that already contains Windows or apps.

The following steps show how to change the drive letter.

1. Open Disk Management with administrator permissions.
1. In Disk Management, select and hold (or right-click) the volume on which you want to change or add a drive letter, and then select **Change Drive Letter and Paths**.

    :::image type="content" source="media/change-drive-letter.png" alt-text="Screenshot showing the Disk Management window with the Change Drive Letter and Paths feature selected.":::

    > [!TIP]
    > If you don't see the **Change Drive Letter and Paths** option or it's grayed out, the volume either isn't ready to receive a drive letter or it's unallocated and needs to be [initialized](initialize-new-disks.md). It might also be that the drive isn't accessible, which is the case with EFI system partitions and recovery partitions. If you've confirmed that your volume is formatted with a drive letter that you can access but you're still unable to change it, that's beyond the scope of this article. We suggest [contacting Microsoft Support](https://support.microsoft.com/contactus/) or the manufacturer of your PC for more help.

1. To change the drive letter, select **Change**. To add a drive letter if the drive doesn't already have one, select **Add**.

    :::image type="content" source="media/change-drive-letter2.png" alt-text="Screenshot of the Change Drive Letter and Paths dialog.":::

1. Select the new drive letter and choose **OK**. Then select **Yes** when prompted about how programs that rely on the drive letter might not run correctly.

    :::image type="content" source="media/change-drive-letter3.png" alt-text="Screenshot of the Change Drive Letter or Path dialog that shows how to assign a new drive letter.":::
