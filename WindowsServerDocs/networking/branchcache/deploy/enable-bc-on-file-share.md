---
title: Enable BranchCache on a File Share (Optional)
description: Learn how to enable BranchCache on a file share.
manager: brianlic
ms.topic: how-to
ms.assetid: 9c465a9e-c504-44ec-9ebc-4e06ba54db30
ms.author: jgerend
author: JasonGerend
ms.date: 01/05/2021
---
# Enable BranchCache on a File Share (Optional)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to enable BranchCache on a file share.

> [!IMPORTANT]
> You do not need to perform this procedure if you configure the hash publication setting with the value **Allow hash publication for all shared folders**.

Membership in **Administrators**, or equivalent is the minimum required to perform this procedure.

### To enable BranchCache on a file share

1.  Open Windows PowerShell, type **mmc**, and then press ENTER. The Microsoft Management Console (MMC) opens.

2.  In the MMC, on the **File** menu, click **Add/Remove Snap-in**. The **Add or Remove Snap-ins** dialog box opens.

3.  In **Add or Remove Snap-ins**, in **Available snap-ins**, double-click **Shared Folders**. The Shared Folders Wizard opens with the Local Computer object selected. Configure the View that you prefer, click **Finish**, and then click **OK**.

4.  Double-click **Shared Folders (Local)**, and then click **Shares**.

5.  In the details pane, right-click a share, and then click **Properties**. The share's **Properties** dialog box opens.

6.  In the **Properties** dialog box, on the **General** tab, click **Offline Settings**. The **Offline Settings** dialog box opens.

7.  Ensure that **Only the files and programs that users specify are available offline** is selected, and then click **Enable BranchCache**.

8.  Click **OK** twice.


