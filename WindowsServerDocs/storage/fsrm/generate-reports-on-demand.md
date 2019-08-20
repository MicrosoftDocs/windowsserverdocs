---
title: Generate Reports on Demand
description: This article describes how to generate reports on demand to analyze disk usage on the server
ms.date: 7/7/2017
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---

# Generate Reports on Demand

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

During daily operations, you can use the **Generate Reports Now** option to generate one or more reports on demand. With these reports, you can analyze the different aspects of current disk usage on the server. Current data is gathered before the reports are generated.

When you generate reports on demand, the reports are saved in a default location that you specify in the **File Server Resource Manager Option** dialog box, but no report task is created for later use. You can view the reports immediately after they are generated or e-mail the reports to a group of administrators.

> [!Note]
> If you choose to open the reports immediately, you must wait while the reports are generated. Processing time varies, depending on the types of reports and the scope of the data.

## To generate Reports immediately

1. Click the **Storage Reports Management** node.

2. Right-click **Storage Reports Management**, and then click **Generate Reports Now** (or select **Generate Reports Now** from the **Actions** pane). This opens the **Storage Reports Task Properties** dialog box.

3. To select volumes or folders on which to generate reports:

   -   Under **Scope**, click **Add**.
   -   Browse to the volume or folder on which you want to generate the reports, select it, and then click **OK** to add the path to the list.
   -   Add as many volumes or folders as you want to include in the reports. (To remove a volume or folder, click the path and then click **Remove**).

4. To specify which reports to generate:

    -   Under **Report data**, select each report that you want to include.

   To edit the parameters of a report:

   -   Click the report label, and then click **Edit Parameters**.
   -   In the **Report Parameters** dialog box, edit the parameters as needed, and then click **OK**.
   -  To see a list of parameters for all the selected reports, click **Review Selected Reports** and then click **Close**.
 
5. To specify the formats for saving the reports:

   -  Under **Report formats**, select one or more formats for the scheduled reports. By default, reports are generated in Dynamic HTML (DHTML). You can also select HTML, XML, CSV, and text formats. The reports are saved to the default location for on-demand reports.

6. To deliver copies of the reports to administrators by e-mail:

   - On the **Delivery** tab, select the **Send reports to the following administrators** check box, and then enter the names of the administrative accounts that will receive reports. 
   - Use the format <em>account@domain</em>, and use semicolons to separate multiple accounts.

7. To gather the data and generate the reports, click **OK**. This opens the **Generate Storage Reports** dialog box.

8. Select how you want to generate the on-demand reports:

   -   If you want to view the reports immediately after they are generated, click **Wait for reports to be generated and then display them**. Each report opens in its own window.
   -   To view the reports later, click **Generate reports in the background**.

   Both options save the reports, and if you enabled delivery by e-mail, send the reports to administrators in the formats that you selected.

## See also

-   [Storage Reports Management](storage-reports-management.md)
-   [Setting File Server Resource Manager Options](setting-file-server-resource-manager-options.md)

