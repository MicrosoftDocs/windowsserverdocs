---
title: Schedule a Set of Reports
description: This article describes how to generate a set of reports on a regular schedule
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---

# Schedule a Set of Reports

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

To generate a set of reports on a regular schedule, you schedule a *report task.* The report task specifies which reports to generate and what parameters to use; which volumes and folders to report on; how often to generate the reports and which file formats to save them in.

Scheduled reports are saved in a default location, which you can specify in the **File Server Resource Manager Options** dialog box. You also have the option of delivering the reports by e-mail to a group of administrators.

> [!Note]
> To minimize the impact of report processing on performance, generate multiple reports on the same schedule so that the data is only gathered once. To quickly add reports to existing report tasks, you can use the **Add or Remove Reports for a Report Task** action. This allows you to add or remove reports from multiple report tasks and to edit the report parameters. To change schedules or delivery addresses, you must edit individual report tasks.

## To schedule a Report Task

1. Click the **Storage Reports Management** node.

2. Right-click **Storage Reports Management**, and then click **Schedule a New Report Task** (or select **Schedule a New Report Task** from the **Actions** pane). This opens the **Storage Reports Task Properties** dialog box.

3. To select volumes or folders on which to generate reports:

   -   Under **Scope**, click **Add**.
   -   Browse to the volume or folder on which you want to generate the reports, select it, and then click **OK** to add the path to the list.
   -   Add as many volumes or folders as you want to include in the reports. (To remove a volume or folder, click the path and then click **Remove**).

4. To specify which reports to generate:

   -  Under **Report data**, select each report that you want to include. By default, all reports are generated for a scheduled report task.

   To edit the parameters of a report:

   -   Click the report label, and then click **Edit Parameters**.
   -   In the **Report Parameters** dialog box, edit the parameters as needed, and then click **OK**.

   -   To see a list of parameters for all the selected reports, click **Review Selected Reports**. Then click **Close**.

5. To specify the formats for saving the reports:

   -  Under **Report formats**, select one or more formats for the scheduled reports. By default, reports are generated in Dynamic HTML (DHTML). You can also select HTML, XML, CSV, and text formats. The reports are saved to the default location for scheduled reports.

6. To deliver copies of the reports to administrators by e-mail:

   - On the **Delivery** tab, select the **Send reports to the following administrators** check box, and then enter the names of the administrative accounts that will receive reports. 
   - Use the format <em>account@domain</em>, and use semicolons to separate multiple accounts.

7. To schedule the reports:

   On the **Schedule** tab, click **Create Schedule**, and then in the **Schedule** dialog box, click **New**. This displays a default schedule set for 9:00 A.M. daily, but you can modify the default schedule.

   -   To specify a frequency for generating the reports, select an interval from the **Schedule Task** drop-down list.
       You can schedule daily, weekly, or monthly reports, or generate the reports only once. You can also generate reports at system startup or logon, or when the computer has been idle for a specified time.
   -   To provide additional scheduling information for the chosen interval, modify or set the values in the **Schedule Task** options.
       These options change based on the interval that you choose. For example, for a weekly report, you can specify the number of weeks between reports and on which days of the week to generate reports.
   -   To specify the time of day when you want to generate the report, type or select the value in the **Start time** box.
   -   To access additional scheduling options (including a start date and end date for the task), click **Advanced**.
   -   To save the schedule, click **OK**.
   -  To create an additional schedule for a task (or modify an existing schedule), on the **Schedule** tab, click **Edit Schedule**.

8. To save the report task, click **OK**.

The report task is added to the **Storage Reports Management** node. Tasks are identified by the reports to be generated, the namespace to be reported on, and the report schedule.

In addition, you can view the current status of the report (whether or not the report is running), the last run time and the result of that run, and the next scheduled run time.

## See also

-   [Storage Reports Management](storage-reports-management.md)
-   [Setting File Server Resource Manager Options](setting-file-server-resource-manager-options.md)


