---
title: Configure Storage Reports
description: This article describes how to configure the default parameters for storage reports
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Configure Storage Reports

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

You can configure the default parameters for storage reports. These default parameters are used for the incident reports that are generated when a quota or file screening event occurs. They are also used for scheduled and on-demand reports, and you can override the default parameters when you define the specific properties of these reports.

> [!Important]
> When you change the default parameters for a type of report, changes affect all incident reports and any existing scheduled report tasks that use the defaults.

## To configure the default parameters for Storage Reports

1. In the console tree, right-click **File Server Resource Manager**, and then click **Configure Options**. The **File Server Resource Manager Options** dialog box opens.

2. On the **Storage Reports** tab, under **Configure default parameters**, select the type of report that you want to modify.

3. Click **Edit Parameters**.

4. Depending on the type of report that you select, different report parameters will be available for editing. Perform all necessary modifications, and then click **OK** to save them as the default parameters for that type of report.

5.  Repeat steps 2 through 4 for each type of report that you want to edit.

6. To see a list of the default parameters for all reports, click **Review Reports**. Then click **Close**.

7.  Click **OK**.

## See also

-   [Setting File Server Resource Manager Options](setting-file-server-resource-manager-options.md)
-   [Storage Reports Management](storage-reports-management.md)