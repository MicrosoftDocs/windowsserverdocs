---
title: WSUS 3.0 SP2 Reports
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b78c9652-a5de-4c5a-9668-ad4157720a9d
author: britw
---
# WSUS 3.0 SP2 Reports
You can use Reports in [!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] 3.0 SP2 to monitor the WSUS network, including updates, client computers, and downstream servers. If a WSUS server has replica servers, you can roll up client status information for   the replica servers to the upstream server.  
  
You can generate update reports from the following areas of the WSUS administration console:  
  
1.  General reports on the Reports page.  
  
2.  Reports about specific updates. \(Right\-click the update \(or go to the **Actions** pane\) and click **Status Report**.\)  
  
3.  Reports on specific computers. \(Right\-click the computer \(or go to the **Actions** pane\) and click **Status Report**.\)  
  
> [!NOTE]  
> Generating detailed reports for large numbers of computers and\/or updates can be memory intensive. Detailed reports are most effective for subsets of computers or updates. If you must create a very large report, and you are concerned about CPU and memory resources on the WSUS server, you can generate the report on a non\-WSUS server that has the WSUS administration console installed.  
  
In this topic:  
  
-   [The Reports page](../Topic/WSUS-3.0-SP2-Reports.md#reportspage)  
  
-   [Enable reporting rollup from replica servers](../Topic/WSUS-3.0-SP2-Reports.md#rollup)  
  
## <a name="reportspage"></a>The Reports page  
You can generate of the following reports in WSUS:  
  
|Report name|Function|  
|---------------|------------|  
|Update Reports|View update status|  
|Computer Reports|View computer status|  
|Synchronization Reports|View the results of the last synchronization|  
  
### Update reports  
Update reports provide the status of the updates. You can run update reports in the following ways: summary, detailed, tabular, and tabular for approved updates. You can filter an update report by update classification, product, target computer group, and update installation status.  
  
An update report displays information about the most recent contact between client computers and the WSUS server. We recommend that you generate this report the day after you approve updates, so that it reflects the latest approvals.  
  
> [!NOTE]  
> To immediately connect a client computer to a WSUS server, you can run the **wuauclt \/detectnow** command. This command is mainly used to update the status for a particular computer. After you issue this command on the client computer, you can get the computer status by running an update status report. For more information about **wuauclt**, see[Manage WSUS 3.0 SP2 from the Command Line](../Topic/Manage-WSUS-3.0-SP2-from-the-Command-Line.md).  
  
##### To run an update report  
  
1.  In the WSUS administration console, select the **Reports** node.  
  
2.  In the **Reports** pane, click one of the options in the **Update Reports** section: **Update Status Summary**, **Update Detailed Status**, **Update Tabular Status**, or **Update Tabular Status for Approved Updates**.  
  
3.  In the **Updates Report** window, you can select the updates that you want to see by classification, product, computer group, and update installation status.  
  
4.  Click **Run Report**.  
  
    > [!NOTE]  
    > See the [Update Status Report Terminology for WSUS 3.0 SP2](../Topic/Update-Status-Report-Terminology-for-WSUS-3.0-SP2.md) section for information about the status values that are shown on the report.  
  
5.  To change the view of an Update report to a detail, summary, or tabular view,  click **Report View** in the **Updates Report** toolbar.  
  
#### <a name="sumview"></a>Update Status Summary View  
The Update Status Summary view contains the elements that are listed in the following table.  
  
### Elements displayed in the Update Status Summary view  
  
|Column name|Description|  
|---------------|---------------|  
|Updates Report tree view|The tree that lists all the updates in the report.|  
|Title|The title of the update.|  
|Description|The description of the update.|  
|Classification|The classification of the update.|  
|Products|The products to which the update applies.|  
|MSRC Severity Rating|Microsoft Security Response Center rating.|  
|MSRC Number|Microsoft Security Response Center identification number.|  
|More information|Redirection to the relevant website.|  
|Approval Summary for Computer Group|The list of groups and approvals.|  
|Group|The computer group.|  
|Approval|Approval status \(Approved, Not approved, Declined\).|  
|Deadline|The date by which the update must be installed.|  
|Administrator|The administrative action.|  
  
### <a name="rollup"></a>Enable reporting rollup from replica servers  
You can roll up the computer and update status from replica servers to their upstream server.  
  
##### To enable reporting rollup from replica servers  
  
1.  In the WSUS administration console on the upstream server, click **Options**, and then **Reporting Rollup**.  
  
2.  Select the **Roll up status from replica downstream servers** check box, and then click **OK**.  
  
> [!NOTE]  
> During the client scan, if the server detects that the client computer changed group membership \(or name, IP address, or operating system version\), it marks the client computer as needing a full rollup. The downstream server will roll up these changes to the upstream server during the next rollup after scan on the client computer.  
  
### Computer reports  
Computer reports show you the status of computers. You can run computer reports in four ways: summary, detailed, tabular, and tabular for approved updates. You can also filter a computer report by update classification, product, target computer group, and update installation status.  
  
##### To run a status report for computers  
  
1.  In the WSUS administrative console, select the **Reports** node.  
  
2.  In the **Reports** pane, click one of the options in the **Computer Reports** section: **Computer Status Summary**, **Computer Detailed Status**, **Computer Tabular Status**, or **Computer Tabular Status for Approved Updates**.  
  
3.  In the **Computers Report** window, you can select the updates that you want to see by classification, product, computer group, and update installation status.  
  
    Note that for the **Computer Tabular Status for Approved Updates** report, the scope of the update approvals and the set of computers that are considered for the report is based on the selected target group.  
  
    -   The updates that are considered for the report are those for which the selected target group has direct or inherited approval for installation.  
  
    -   The computers that are considered for the report are those that are direct members of the selected target group, and optionally, its child target groups.  
  
4.  Click **Run Report**.  
  
5.  You can change the view of a Computer report to a detail, summary, or tabular view by clicking **Report View** in the **Updates Report** toolbar.  
  
### Synchronization Results report  
The Synchronization Results report enables you to see synchronization information for the WSUS server for a given time period, including errors that occurred during synchronization and a list of new updates. In addition, you can get general, status, and revision information for each new update.  
  
##### To run a Synchronization Results report  
  
1.  In the WSUS administrative console, click **Reports**.  
  
2.  In the **Reports** pane, click **Synchronization Results**. By default, the report shows any synchronization that was done today.  
  
3.  To change the synchronization period for the report, in the **Synchronization Report** window, click **Between these dates** and specify the dates that you want included in the report.  
  
4.  Click **Run Report**.  
  
The report has four components, which are described in the following table.  
  
### Components of the Synchronization Results report  
  
|Component name|Purpose|  
|------------------|-----------|  
|Report Options|Shows the start and end dates of the period that is shown in the report, the date of the report, and the server for which the report was made.|  
|Synchronization Summary|Displays summary information for the numbers of new, revised, and expired updates in each synchronization.|  
|New Updates|Displays the new updates that have been synchronized to the WSUS server during the report's time period.<br /><br />You can view the properties for each update by clicking the update. An update status report will be generated for that individual report.|  
|Revised Updates|Displays the revised updates that have been synchronized to the WSUS server during the report's time period.<br /><br />You can view the properties for each update by clicking the update. An update status report will be generated for that individual report.|  
|Expired Updates|Displays the updates that have been expired during the report's time period.|  
  
#### Printing a report  
You can print the report in update summary, detailed, or tabular views, depending on how you have formatted the update status report.  
  
#### Exporting a report  
You can print a report in its original format, or you can export it to Microsoft Excel® or to a PDF format.  
  
> [!IMPORTANT]  
> Exporting a large report can be extremely time consuming and may exceed your computer's memory resources. If you are planning to export a report, consider limiting the size of the report to 200 pages or fewer. You can use different filters to reduce the size of the report, or you can choose the tabular format rather than the detailed format to reduce the number of pages to export.  
  
###### To export a report to Excel or PDF format  
  
1.  Run the report you want to export.  
  
2.  On the report toolbar, click the down arrow associated with the **Save** icon.  
  
3.  You will see two options: **Excel** and **Acrobat \(PDF\) file**. Click one of the options.  
  
## Extending reports  
You can customize WSUS reports as follows:  
  
1.  Use the WSUS APIs to create a custom report.  
  
2.  Use WSUS public views to create and extend custom reports.  
  
#### Use WSUS APIs to create custom reports  
For more information about WSUS APIs, see the [Windows Server Update Services SDK](http://go.microsoft.com/fwlink/?LinkId=85713) on MSDN. You can use these APIs to create reports for updates, approvals, installation information, and such.  
  
#### Use WSUS public views to create custom reports  
For more information about public views, in addition to sample queries, see the [WSUS SDK conceptual documentation](http://go.microsoft.com/fwlink/?LinkId=85715) on MSDN. If you are using SQL Server as the WSUS database, you can use the SQL Server Report Builder to generate custom reports by using these views, or you can access the views from the command line.  
  
If you are using [!INCLUDE[nextref_wyukon](../Token/nextref_wyukon_md.md)] as the WSUS database, you can access it through the command line if you download the Microsoft SQL Server Command Line Query Utility and the SQL Server Native Client. To download and install packages, seethe [Feature Pack for Microsoft SQL Server 2005](http://go.microsoft.com/fwlink/?LinkId=70728) in the Microsoft Download Center.  
  
