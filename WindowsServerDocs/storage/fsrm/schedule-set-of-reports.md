---
title: Schedule a Set of Reports
description: This article describes how to generate a set of reports on a regular schedule
ms.date: 12/10/2024
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
---

# Schedule a Set of Reports

To generate a set of reports on a regular schedule, you schedule a *report task.* The report task specifies which reports to generate and what parameters to use; which volumes and folders to report on; how often to generate the reports and which file formats to save them in.

Scheduled reports are saved in a default location, which you can specify in the **File Server Resource Manager Options** dialog box. If an administrator decides to change the default locations where reports are generated, it's crucial to secure any new Universal Naming Convention (UNC) path with access limited to authorized users. Secured access helps to ensure paths are configured to prevent exploitation.

> [!Note]
> To minimize the impact of report processing on performance, generate multiple reports on the same schedule so that the data is only gathered once. To quickly add reports to existing report tasks, you can use the **Add or Remove Reports for a Report Task** action. This allows you to add or remove reports from multiple report tasks and to edit the report parameters. To change schedules or delivery addresses, you must edit individual report tasks.

## To schedule a Report Task

1. Select the **Storage Reports Management** node.

1. Either right-select **Storage Reports Management** and select **Schedule a New Report Task** or select **Schedule a New Report Task** from the **Actions** pane to open the **Storage Reports Task Properties** dialog box.

1. To select volumes or folders on which to generate reports:

   - Under **Scope**, select **Add**.

   - Navigate to the volume or folder where you want to generate the reports, select it, and then select **OK** to add the path to the list.

   - Add as many volumes or folders as you want to include in the reports. (To remove a volume or folder, select the path and then select **Remove**).

1. To specify which reports to generate:

   -Under **Report data**, select each report that you want to include. By default, all reports are generated for a scheduled report task.

   To edit the parameters of a report:

   - Select the report label, and then select **Edit Parameters**.

   - In the **Report Parameters** dialog box, edit the parameters as needed, and then select **OK**.

   - To see a list of parameters for all the selected reports, select **Review Selected Reports**. Then select **Close**.

1. To specify the formats for saving the reports:

   - Under **Report formats**, select one or more formats for the scheduled reports. By default, reports are generated in Dynamic HTML (DHTML). You can also select HTML, XML, CSV, and text formats. The reports are saved to the default location for scheduled reports.

1. To deliver copies of the reports to administrators by e-mail:

   - On the **Delivery** tab, select the **Send reports to the following administrators** check box, and then enter the names of the administrative accounts that will receive reports.
   - Use the format <em>account@domain</em>, and use semicolons to separate multiple accounts.

1. To schedule the reports:

   On the **Schedule** tab, select **Create Schedule**, and then in the **Schedule** dialog box, select **New**. This displays a default schedule set for 9:00 A.M. daily, but you can modify the default schedule.

   - To specify a frequency for generating the reports, select an interval from the **Schedule Task** drop-down list.
       You can schedule daily, weekly, or monthly reports, or generate the reports only once. You can also generate reports at system startup or logon, or when the computer has been idle for a specified time.

   - To provide additional scheduling information for the chosen interval, modify or set the values in the **Schedule Task** options.
       These options change based on the interval that you choose. For example, for a weekly report, you can specify the number of weeks between reports and on which days of the week to generate reports.

   - To specify the time of day when you want to generate the report, type or select the value in the **Start time** box.

   - To access additional scheduling options (including a start date and end date for the task), select **Advanced**.

   - To save the schedule, select **OK**.

   - To create an additional schedule for a task (or modify an existing schedule), on the **Schedule** tab, select **Edit Schedule**.

1. To save the report task, select **OK**.

The report task is added to the **Storage Reports Management** node. Tasks are identified by the reports to be generated, the namespace to be reported on, and the report schedule.

In addition, you can view the current status of the report (whether or not the report is running), the last run time and the result of that run, and the next scheduled run time.

## Additional References

- [Storage Reports Management](storage-reports-management.md)
- [Setting File Server Resource Manager Options](setting-file-server-resource-manager-options.md)

