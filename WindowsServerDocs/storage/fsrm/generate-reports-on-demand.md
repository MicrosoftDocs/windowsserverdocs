---
title: Generate reports on demand in Windows Server
description: This article describes how to generate reports on demand to analyze disk usage in the Windows Server environment using FSRM (File Server Resource Manager).
ms.date: 12/10/2024
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
---

# Generate reports on demand

You can generate reports on demand using the **File Server Resource Manager** (FSRM). With these reports, you can analyze the different aspects of current disk usage on the server. Current data is gathered before the reports are generated.

When you generate reports on demand, reports are saved to a default location unless otherwise specified in **FSRM > Action > Configure Options > Report Locations**. No report task is created for later use. You can view the reports immediately after they're generated or e-mail the reports to a group of administrators. If an administrator decides to change the default locations where reports are generated, they must also secure any new Universal Naming Convention (UNC) path with access limited to authorized users. Secured access ensures you can configure paths to prevent exploitation.

> [!NOTE]
> If you choose to open the reports immediately, you must wait while the reports are generated. Processing time varies depending on the types of reports and the scope of the data.

## Prerequisites

The following must be installed to use this feature:

- A Windows Server with the **File and Storage Services** role service installed. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).

- An account with Administrative privileges.

## How to generate reports

1. Select **Start**

1. select **Windows Administrative Tools** and then select **File Server Resource Management**.

1. Select **Storage Reports Management**, right-select **Storage Reports Management**, and then select **Generate Reports Now**.

1. In the **Storage Reports Task Properties** dialog box, select the data you want to include from the **Report data** selection box.

1. Under **Report formats**, select one or more formats for your report. The default is set to _Dynamic HTML (DHTML)_. Other available formats are HTML, XML, CSV, and Text. The default save location for the reports are stored in **C:\StorageReports** unless changed.

1. Select the **Scope** tab, select **Add**, and then navigate to the volume or folder that you want to generate the reports from. Finally, select **OK** to add it to your report scope.
   - You can add as many volumes or folders as you want to include in the reports.
   - To remove a volume or folder, select its name in the list, then select **Remove**.
   - You can also include the following data types by selecting them within the **Scope** tab:
      - Application Files
      - Backup and Archival Files
      - Group Files
      - User Files

1. When you're finished, select **OK**.

1. Select one of the following two available options:
   - Generate reports in the background
   - Wait for reports to be generated and then display them
1. When you're finished, select **OK**.

The following animation demonstrates the steps to generate a report using the **Generate Reports Now** feature.

![A video demonstrating how to generate a report using the generate reports now feature in the File Server Resource Manager for Windows Server.](../media/generate-reports-now-gif.gif)

## Generate custom reports

To customize your reports, perform the following:

1. In the **Storage Reports Task Properties** dialog box, select the data you want to include from the **Report data** selection box.

1. Select **Edit Parameters**. In the **Report Parameters** dialog box, edit the parameters as needed, then select **OK**.

   > [!TIP]
   > Each report data label has its own set of parameters. When customizing reports, it's recommended to select one report label at a time in making modifications.
   >
   > To see a list of parameters set for all the selected reports, select **Review Selected Reports**, then select **Close** when complete.

1. After customizing your report, select the report output type from **Report format**, select **OK**, select how you want your report generated, and then select **OK**.

## Deliver reports via email

To deliver copies of the reports to administrators by e-mail:

1. In the **Storage Reports Task Properties** dialog box, complete your selection of the report data you want to generate along with the **Report format** of choice.

1. Select the **Delivery** tab, select the **Send reports to the following administrators** check box, then enter the names of the administrative accounts that receive reports in _account@domain_ formatting using the semicolon (**;**) to indicate multiple accounts.

1. Select **OK**, select how you want your report generated, and then select **OK**.

   > [!NOTE]
   > In order to use this feature, an SMTP server must be configured to prevent e-mail delivery failure.

## Additional references

- [Storage Reports Management](storage-reports-management.md)
- [Setting File Server Resource Manager Options](setting-file-server-resource-manager-options.md)

