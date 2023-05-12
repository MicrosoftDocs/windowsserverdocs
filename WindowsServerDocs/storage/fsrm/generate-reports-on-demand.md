---
title: Generate reports on demand in Windows Server
description: This article describes how to generate reports on demand to analyze disk usage in the Windows Server environment.
ms.date: 05/11/2023
ms.topic: how-to
author: xelu86
ms.author: wscontent
---

# Generate reports on demand

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

You can generate reports on demand using the **File Server Resource Manager**. With these reports, you can analyze the different aspects of current disk usage on the server. Current data is gathered before the reports are generated.

When you generate reports on demand, the reports are saved in a default location that you specify in the **File Server Resource Manager Option** dialog box, but no report task is created for later use. You can view the reports immediately after they're generated or e-mail the reports to a group of administrators.

> [!NOTE]
> If you choose to open the reports immediately, you must wait while the reports are generated. Processing time varies depending on the types of reports and the scope of the data.

## Prerequisites

The following must be installed to use this feature:

- A Windows Server with the **File and Storage Services** role service installed. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).
- An account with Administrative privileges.

## How to generate reports

1. Click **Start** > **Windows Administrative Tools** > select **File Server Resource Management**.
<br>_Alternatively, click **Start** > type **fsrm.msc** > hit_ <kbd>Enter</kbd>.
1. Select **Storage Reports Management**, right-click **Storage Reports Management**, then select **Generate Reports Now** (or select **Generate Reports Now** from the **Actions** pane).
1. In the **Storage Reports Task Properties** dialog box, select the data you want to include from the **Report data** selection box.
1. Click the **Scope** tab > click **Add** > browse to the volume or folder that you want to generate the reports from and click **OK** to add it to your report scope.
   - You can add as many volumes or folders as you want to include in the reports.
   - To remove a volume or folder, select it from the list > click **Remove**.
   - You can also include the following data types by selecting them within the **Scope** tab:
      - Application Files
      - Backup and Archival Files
      - Group Files
      - User Files
1. Click **OK** to generate your report.

The following animation demonstrates the steps to generate a report using the **Generate Reports Now** feature.

![A video demonstrating how to generate a report from the File Server Resource Management in Windows Server.](media/generate-reports-now-gif.gif)

## Generate custom reports

To customize your reports, perform the following:

1. In the **Storage Reports Task Properties** dialog box, select the data you want to include from the **Report data** selection box.

   To edit the parameters of a report:

   -   Click the report label, and then click **Edit Parameters**.
   -   In the **Report Parameters** dialog box, edit the parameters as needed, and then click **OK**.
   -  To see a list of parameters for all the selected reports, click **Review Selected Reports** and then click **Close**.

5. To specify the formats for saving the reports:

   -  Under **Report formats**, select one or more formats for the scheduled reports. By default, reports are generated in Dynamic HTML (DHTML). You can also select HTML, XML, CSV, and text formats. The reports are saved to the default location for on-demand reports.

6. To deliver copies of the reports to administrators by e-mail:

   - On the **Delivery** tab, select the **Send reports to the following administrators** check box, and then enter the names of the administrative accounts that receive reports.
   - Use the format <em>account@domain</em>, and use semicolons to separate multiple accounts.

7. To gather the data and generate the reports, click **OK**. This opens the **Generate Storage Reports** dialog box.

8. Select how you want to generate the on-demand reports:

   -   If you want to view the reports immediately after they're generated, click **Wait for reports to be generated and then display them**. Each report opens in its own window.
   -   To view the reports later, click **Generate reports in the background**.

   Both options save the reports, and if you enabled delivery by e-mail, send the reports to administrators in the formats that you selected.

## Additional references

- [Storage Reports Management](storage-reports-management.md)
- [Setting File Server Resource Manager Options](setting-file-server-resource-manager-options.md)
