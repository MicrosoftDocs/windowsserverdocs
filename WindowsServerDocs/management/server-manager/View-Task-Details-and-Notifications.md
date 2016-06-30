---
title: View Task Details and Notifications
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 95117407-2dd3-4f9a-841f-4331be3544c3
author:coreyp-at-msft
---
# View Task Details and Notifications

>Applies To: Windows Server 2016 Technical Preview

In Server Manager in Windows Server 2012 R2 or Windows Server 2012, when you perform management tasks such as adding roles and features, starting services, refreshing data that is displayed in the Server Manager console, or creating a custom group of servers, a notification is displayed in the **Notifications** area of the Server Manager console header. Notifications, and the **Task Details** dialog box that you can open from the **Notifications** menu by clicking the flag icon, display the status of user tasks or requests, show you if a task failed, and help you troubleshoot problems by pointing to detailed error messages about task failures.

## The Notifications area
The **Notifications** area in the Server Manager menu bar, marked by a flag icon, displays the results of tasks that you start in Server Manager. Notifications inform you whether tasks that you started in Server Manager were successful or failed. When notifications are available for you to view, the number of available notifications is displayed next to the flag icon. If a task failed, could only be partially completed (for example, if it could not be completed on all of the remote servers on which you wanted to perform the task), or completed with warnings, the **Notifications** flag becomes red. Tasks for which notifications are displayed include the following.

-   Manually refreshing the data displayed in Server Manager (notifications are displayed for automatic refreshes only if the refreshes fail)

-   Starting or stopping services

-   Installing or uninstalling roles, role services, and features

-   Starting a Best Practices Analyzer (BPA) scan

-   Adding remote servers to manage (notifications are displayed for failures to contact or refresh the data displayed for remote servers)

Items in the **Notifications** menu show a progress bar, a brief description of the task, the name of the target server for the task (or one of the target servers, if multiple target servers were selected), a link to a related control or dialog box if applicable, and a **Tasks** menu. The **Tasks** menu shows commands that apply to the active notification (the notification over which your mouse cursor is hovered). For example, if you stop a service, you can click **Restart** on the **Tasks** menu in the notification to restart the service.

Notifications are particularly useful for installing or uninstalling roles, role services, and features. For example, if you start a feature installation on a remote server, you can close the Add Roles and Features Wizard while the installation is still in progress, but the active task remains in the **Notifications** list. The **Notifications** item shows a progress bar for the installation, and lets you reopen the Add Roles and Features Wizard, if needed, by clicking **Add Roles and Features Wizard**. The items in this list notify you if an installation failed, or if additional configuration steps are required to finish deploying the feature.

Notifications also play an important part in troubleshooting problems with tasks or processes in Server Manager. For more information about how to use messages in the **Notifications** area and **Task Details** dialog box to troubleshoot unsuccessful tasks or processes, see the [Server Manager Troubleshooting Guide](http://social.technet.microsoft.com/wiki/contents/articles/13443.windows-server-2012-server-manager-troubleshooting-guide-part-i-overview.aspx).

To delete a notification that you no longer want to see from the **Notifications** list, hover your mouse cursor over the notification, and then click **Remove Task** (**X**).

## Viewing and troubleshooting tasks by using Task Details
The **Task Details** command at the bottom of the **Notifications** menu opens the **Task Details** dialog box, which provides full descriptions of task events (starting, stopping, warnings, successes, or failures). Like other list controls in Server Manager, such as **Events**, **Services**, and **Best Practices Analyzer** tiles, you can filter and create queries to run on the tasks that are displayed in the **Task Details** dialog box. (For more information about filtering and creating queries on list controls, see [Filter, Sort, and Query Data in Server Manager Tiles](Filter-Sort-and-Query-Data-in-Server-Manager-Tiles.md).) In the top pane, you can review notifications as they have been displayed in the **Notifications** menu, and see how many notifications have been generated about the same task. Selecting a notification in the top pane displays full details about the notification in the bottom pane.

The bottom pane is particularly useful for troubleshooting failed tasks. If Server Manager cannot connect to or get data for a server that is a member of the server pool, entries in this pane often contain detailed messages, including the full text of underlying Windows Remote Management (WinRM), networking, or security problems that prevent Server Manager from communicating with a target server.

## See Also
[Filter, Sort, and Query Data in Server Manager Tiles](Filter-Sort-and-Query-Data-in-Server-Manager-Tiles.md)
[Server Manager Troubleshooting Guide](http://social.technet.microsoft.com/wiki/contents/articles/13443.windows-server-2012-server-manager-troubleshooting-guide-part-i-overview.aspx)


