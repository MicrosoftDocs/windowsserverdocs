---
title: Configure File Screen Audit
description: This article describes how to configure File Screen Audit to generate the File Screening Audit report
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Configure File Screen Audit

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

By using File Server Resource Manager, you can record file screening activity in an auditing database. The information saved in this database is used to generate the File Screening Audit report.

> [!Important]
> If the **Record file screening activity in the auditing database** check box is cleared, the File Screening Audit Reports will not contain any information.

## To configure file screen audit

1.  In the console tree, right-click **File Server Resource Manager**, and then click **Configure Options**. The **File Server Resource Manager Options** dialog box opens.

2.  On the **File Screen Audit** tab, select the **Record file screening activity in the auditing database** check box.

3.  Click **OK**. All file screening activity will now be stored in the auditing database, and it can be viewed by running a File Screening Audit report.

## See also

-   [Setting File Server Resource Manager Options](setting-file-server-resource-manager-options.md)
-   [Storage Reports Management](storage-reports-management.md)