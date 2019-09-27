---
title: View and Configure Performance Event and Service Data
description: "Server Manager"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-server-manager
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ccd59c35-4dbf-48e7-88a4-c519c00184d1
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# View and Configure Performance, Event, and Service Data

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic describes how to view and configure the event log entries, performance counters, and service alerts that are displayed for local and remote servers in Server Manager.  

Event, service, and performance log data is displayed in two places in the Server Manager console in Windows Server.  

-   On the dashboard, you can click the **Events**, **Performance**, and **Services** rows of thumbnails to configure event, performance, and service log data that you want to see for roles, the entire Server Manager server pool, user-created groups of servers, and the local server. Clicking the hypertext rows opens **detail View** dialog boxes that let you specify the data about which you want to be alerted in the dashboard. After you configure event, service, and performance log data that you want to be highlighted in the dashboard thumbnails, log entries that match the criteria you have specified are listed at the bottom of the **detail View** dialog boxes.  

-   **Events**, **Services**, and **Performance** tiles are part of role and group home pages. Commands on the **Tasks** menu of these tiles let you specify the data that you want collected from managed servers. The tiles include filters and queries to further limit the log entries that are displayed in the tile, if desired.  

This topic contains the following sections.  

-   [What are thumbnails?](#BKMK_thumb)  

-   [View and configure events](#BKMK_events)  

-   [View and configure performance counters](#BKMK_perf)  

-   [Manage services and configure service alerts](#BKMK_services)  

-   [View and copy event or performance entries](#BKMK_copy)  

## <a name="BKMK_thumb"></a>What are thumbnails?  
*Thumbnails* are displayed on the Server Manager dashboard for each role (a role's thumbnail reflects data collected about all of the servers in the Server Manager pool that are running the role), for each server group, for the **All Servers** group (all of the servers in the Server Manager pool), and for the local server. After Server Manager gets data from managed servers, thumbnails are automatically created for roles that are running on servers in the server pool.  

if the Server Manager console is running on a client computer as part of Remote Server Administration Tools, there is no **Local Server** thumbnail.  

The thumbnail displays a quick view of the status and manageability of roles, servers, and server groups. The thumbnail heading row changes color (and highlighted numbers are displayed in the left margin) when events, performance counters, Best Practices Analyzer results, services, or general manageability issues meet criteria that you configure in the **detail View** dialog boxes opened by clicking thumbnail rows. The following table describes the data displayed in thumbnails.  

|Thumbnail Row|Description|  
|---------|--------|  
|Manageability|The manageability of a server includes several measures: whether the server is online or offline, whether it is accessible and reporting data to Server Manager, whether the user who is logged on to the local computer has adequate user rights to access or manage the remote server, whether the remote server is running all of the software that is required to manage it remotely, or whether the server is configured in a way that allows it to be queried and managed by using Server Manager. The only manageability data that Server Manager can collect from a server that is running Windows Server 2003 is whether the server is online or offline. For detailed information about manageability status errors and how to resolve them, see the [Server Manager Troubleshooting Guide](https://social.technet.microsoft.com/wiki/contents/articles/13443.windows-server-2012-server-manager-troubleshooting-guide-part-i-overview.aspx).|  
|Events|You can configure the **Events** row of a thumbnail to display alerts when events are logged that match severity levels, sources, time periods, servers, or event IDs that you specify. View details about events, and change the alerts you want to see by clicking the **Events** row, and opening the **Events detail View** dialog box for the role or server group.|  
|Services|You can configure the **Services** row to display alerts when services are found in a role or server group that match startup types, service status, service names, and servers that you specify in the **Services detail View** dialog box.<br /><br />After a server has been added to the Server Manager server pool, service alerts about the Shell Hardware Detection service can be displayed if there are no users logged on to the managed server. This occurs because the Shell Hardware Detection service runs only when users are logged on to the managed server, or connected to a Remote Desktop session on the managed server. To avoid seeing Shell Hardware Detection service alerts for this case, click **Services** in the thumbnails for server groups, including the **All Servers** group. In the **Services detail View** dialog box, on the **Services** drop-down list, clear the check box for **Shell Hardware Detection**, and then click **OK**.|  
|Performance|You can configure the **Performance** row to display alerts for a role or server group when performance alerts occur that match resource types, servers, or time periods that you specify in the **Performance detail View** dialog box.<br /><br />By default, performance counters are turned off. Managed servers that are running operating systems newer than Windows Server 2003, and for which performance counters have not been started, typically show manageability status errors of **online - Performance counters not started** in the **Servers** tile of role or group pages. To turn performance counters on for managed servers, on the **All Servers** page, right-click entries in the **Performance** tile that show a **Counter Status** value of **Off**, and then click **start Performance Counters**. You can also start performance counters by right-clicking entries for servers in the **Servers** tile of role or group pages, and then clicking **start Performance Counters**.|  
|BPA results|You can configure the **BPA results** row to display alerts for a role or server group when BPA scan results are found that match severity levels, servers, or BPA categories that you specify in the **BPA Results detail View** dialog box.|  

## <a name="BKMK_events"></a>View and configure events  
In this section, learn how to configure what event log data is collected from servers in the Server Manager server pool, and which events you want highlighted in thumbnails.  

> [!NOTE]  
> The events about which you are alerted in thumbnails are a subset of the total events that you instruct Server Manager to collect from managed servers. Although changing event criteria in the **Configure Event Data** dialog box in **Events** tiles can change the numbers of alerts you see on the Server Manager dashboard, changing the event alert criteria in thumbnails has no effect on the event log data that is collected from managed servers.  

#### To configure the events collected from managed servers  

1.  In the Server Manager console, open any page except the dashboard. You can configure the events that you want collected from managed servers in the **Events** tile on role, server group, or local server pages.  

2.  On the **Tasks** menu of the **Events** tile, click **Configure Event Data**.  

3.  select the event severity levels that you want to be collected from the servers in the selected group. By default, **Critical**, **Error**, and **Warning** severity levels are selected.  

4.  Specify a time period during which the events occur. The default age for events is 24 hours.  

5.  select the event log files from which you want events to be collected. The defaults are **Application**, **Setup**, and **System**.  

6.  To save your changes, click **OK** to close the **Configure Event Data** dialog box. Event data automatically refreshes when your changes are saved.  

#### To configure the events highlighted in thumbnails  

1.  if Server Manager is already open, go on to the next step. If Server Manager is not already open, open it by doing one of the following.  

    -   On the Windows desktop, start Server Manager by clicking **Server Manager** in the Windows taskbar.  

    -   On the Windows **start** screen, click the Server Manager tile.  

2.  On the dashboard page, in a thumbnail in the **Roles and Server Groups** tile, click the **Events** row.  

3.  In the **Events detail View** dialog box, add a severity level to the events that you want displayed. By default, thumbnails only display alert highlighting for critical events. Note that the number of events displayed in the **detail View** dialog box increases when you add a severity level about which you want to be alerted.  

4.  In the **Event sources** field, select the event sources about which you want to be alerted. The default is **All**.  

5.  if this thumbnail is for a role that is installed on multiple servers, or a group of multiple servers, you can select the servers for which you want event alerts in the **Servers** drop-down list.  

6.  In the **time period** field, specify a time period up to 1440 minutes, 24 hours, or 1 day.  

7.  In the **Event IDs** field, type the event ID numbers of specific events about which you want to be alerted. You can type a range of event IDs separated by a dash (**-**), and exclude event IDs from the range by typing the dash before the event ID or range of event IDs that you want to exclude. For example, the value **1,3,5-99,-76** means that alerts are raised for event IDs 1 and 3, and all events with IDs between 5 and 99 except for event ID 76.  

8.  As you change the criteria for which alerts are displayed, the number of event alerts that are displayed in the results pane at the bottom of the dialog box might change. select entries in the list and click **Hide Alerts** to prevent them from affecting the alert count that is displayed in the source thumbnail. Press and hold **Ctrl** as you select alerts to select multiple alerts at one time. You can do this for alerts that match your event alerting criteria, but that you do not need to see.  

9. Click **Show All** to return hidden alerts to the list.  

10. Click **OK** to save your changes, close the **detail View** dialog box, and view the event alert changes in the source thumbnail.  

## <a name="BKMK_perf"></a>View and configure performance log data  
In this section, learn how to configure what performance log data is collected from servers in the Server Manager server pool, and which performance counter alerts you want highlighted in thumbnails.  

By default, performance counters are turned off. Managed servers that are running operating systems newer than Windows Server 2003, and for which performance counters have not been started, typically show manageability status errors of **online - Performance counters not started** in the **Servers** tile of role or group pages. To turn performance counters on for managed servers, on the **All Servers** page, right-click entries in the **Performance** tile that show a **Counter Status** value of **Off**, and then click **start Performance Counters**. You can also start performance counters by right-clicking entries for servers in the **Servers** tile of role or group pages, and then clicking **start Performance Counters**.  

> [!NOTE]  
> The performance alerts you view in thumbnails are a subset of the total performance counter data that you instruct Server Manager to collect from managed servers. Although changing performance alert criteria in the **Configure Performance Alerts** dialog box in **Performance** tiles can change the numbers of alerts you see on the Server Manager dashboard, changing the performance alert criteria in thumbnails has no effect on the performance log data that is collected from managed servers.  
>   
> Because of this, the maximum age of performance data that you can display in thumbnails cannot be greater than the maximum graph display period that is configured in the **Configure Performance Alerts** dialog box. For example, if the **Graph display period** value in **Configure Performance Alerts** is **1 day**, the maximum value for the **time period** field in a **Performance detail View** dialog box that you have opened from the Server Manager dashboard can be **1 day**, **24 hours**, or **1,440 minutes**.  

#### To configure the performance log data collected from managed servers  

1.  In the Server Manager console, open any page except the dashboard. You can configure the performance data that you want collected from managed servers in the **Performance** tile on role, server group, or local server pages.  

2.  To collect performance log data from managed servers, performance counters must be turned on. If performance counters are turned off, right-click an entry in the **Performance** tile list, and then click **start Performance Counters**. Performance counter data collection can require some time, depending on the number of servers from which data is collected, and available network bandwidth. View the status in the **Counter Status** column.  

3.  On the **Tasks** menu of the **Performance** tile, click **Configure Performance Alerts**.  

4.  for the servers in the selected group, or that are running the selected role, specify at what percent of CPU usage you want performance counter alerts collected by Server Manager. The default is 85%.  

5.  Specify the remaining available memory, in megabytes, that servers must have before you want performance counter alerts collected. The default is 2 MB.  

6.  Specify a time period that is displayed by the graphs for the resources **CPU Usage** and **Available Memory** in the **Performance** tile on the selected page. The default period is one day. Click **Save**.  

    Note that the number of performance alerts in the **Performance** tile, and the mapping of the alerts over time as displayed by the graph, can change after you click **Save**.  

    > [!NOTE]  
    > for virtual machines that have [Dynamic Memory](https://technet.microsoft.com/library/ff817651.aspx) turned on, increasing the performance alerts threshold can result in false positive alerts.  

7.  To refresh the list of performance alerts that are collected from your servers, on the **Tasks** menu, click **Refresh**.  

#### To configure the performance alerts highlighted in thumbnails  

1.  On the dashboard page, in a thumbnail in the **Roles and Server Groups** tile, click the **Performance** row.  

2.  In the **Performance detail View** dialog box, select or clear check boxes for resource performance thresholds about which you want to be alerted in the **Resource type** field. Note that the number of performance alerts displayed in the **detail View** dialog box can increase when you add a resource performance threshold about which you want to be alerted.  

3.  if this thumbnail is for a role that is installed on multiple servers, or a group of multiple servers, you can select the servers for which you want performance alerts in the **Servers** drop-down list.  

4.  In the **time period** field, specify a time period up to 1440 minutes, 24 hours, or 1 day.  

5.  As you change the criteria for which alerts are displayed, the number of alerts that are displayed in the results pane at the bottom of the dialog box might change. Click **Hide Alerts** to hide all alerts older than the current time, and prevent them from affecting the alert count that is displayed in the source thumbnail.  

6.  Click **Show All** to return hidden alerts to the list.  

7.  Click **OK** to save your changes, close the **detail View** dialog box, and view the performance alert changes in the source thumbnail.  

#### To view the properties of performance alerts  

1.  Do one of the following.  

    -   On the dashboard page, in a thumbnail in the **Roles and Server Groups** tile, click the **Performance** row.  

    -   Open a role or group home page, and locate the **Performance** tile for the role or group.  

2.  Double-click a performance alert in the list to view its properties. Alternatively, you can right-click a performance alert, and then click **View Properties**.  

3.  In the **Performance Alert Properties** dialog box, select log entries to view information about the processes that are associated with the entry in the **Processes** area.  

4.  When you are finished viewing performance alert properties, close the dialog box.  

### Analyze performance data and solve problems  
for more information about analyzing performance counter data that you view in Server Manager, and solving performance problems on managed servers, see the following resources.  

-   [Analyzing performance data](https://go.microsoft.com/fwlink/?LinkId=239829)  

-   [Solving performance problems](https://go.microsoft.com/fwlink/?LinkId=239831)  

for more information about advanced performance monitoring and analysis tools that are available for  Windows Server 2012  and later releases of Windows Server, including Server Performance Advisor 3.0, see [Performance](https://msdn.microsoft.com/windows/hardware/gg463374.aspx) on MSDN.  

## <a name="BKMK_services"></a>Manage services and configure service alerts  
In this section, learn how to start, stop, restart, pause, or resume services that are displayed in the **Services** tile on role and server group pages in Server Manager. You can also configure the services about which you are alerted in thumbnails on the Server Manager dashboard.  

> [!NOTE]  
> You cannot change the start type for services, service dependencies, recovery options, or other service properties in the Services tile in Server Manager. To change service properties other than the service status, open the **Services** snap-in. A shortcut to open the **Services** snap-in is available on the **Tools** menu in Server Manager.  

#### To start, stop, restart, pause, or resume a service  

1.  In the Server Manager console, open any page except the dashboard (in other words, any role or group home page).  

2.  In the **Services** tile for the role or group, right-click a service.  

3.  In the context menu, click the action that you want to perform on the service. If the service is stopped, the only action you can perform is to start the service. Similarly, if the service is paused, the only action you can perform is to resume the service.  

4.  Note that when you start, stop, restart, pause, or resume a service, the value of the **Status** column changes for the service in the **Services** tile.  

#### To configure service alerts highlighted in thumbnails  

1.  On the dashboard page, in a thumbnail in the **Roles and Server Groups** tile, click the **Services** row.  

2.  In the **Services detail View** dialog box, select the startup types for services about which you want to be alerted. By default, **Automatic (delayed start)** and **Automatic** are selected.  

3.  select the service statuses about which you want to be alerted. By default, **All** is selected.  

4.  select services about which you want to be alerted. By default, **All** is selected.  

5.  select the servers associated with the role or group for which you want to receive alerts about services. By default, **All** is selected.  

6.  As you change the criteria for which alerts are displayed, the number of alerts that are displayed in the results pane at the bottom of the dialog box might change. Click **Hide Alerts** to hide all alerts older than the current time, and prevent them from affecting the alert count that is displayed in the source thumbnail.  

7.  Click **Show All** to return hidden alerts to the list.  

8.  Click **OK** to save your changes, close the **detail View** dialog box, and view the service alert changes in the source thumbnail.  

## <a name="BKMK_copy"></a>View and copy event, service, or performance entries  
You can copy event, service, or performance entry properties in both the **detail View** dialog boxes and the **Events** and **Performance** tiles for a role or group. Right-click an event or performance entry, and then click **copy**.  

The **Events** tile also lets you preview event properties in the bottom half of the tile by selecting an event in the list. To copy the properties shown in the preview, right click the preview pane, and then click **copy**.  

## See Also  
[Server Manager](server-manager.md)  
[Filter, sort, and query Data in Server Manager Tiles](filter-sort-and-query-data-in-server-manager-tiles.md)  
