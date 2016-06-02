---
title: Manage the Local Server and the Server Manager Console
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eeb32f65-d588-4ed5-82ba-1ca37f517139
author: coreyp
---
# Manage the Local Server and the Server Manager Console
In [!INCLUDE[winthreshold_server_1](includes/winthreshold_server_1_md.md)], [!INCLUDE[sm](includes/sm_md.md)] lets you manage both the local server \(if you are running [!INCLUDE[sm](includes/sm_md.md)] on Windows Server, and not on a Windows\-based client operating system\) and remote servers that are running [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)] and newer releases of the Windows Server operating system.  
  
The **Local Server** page in [!INCLUDE[sm](includes/sm_md.md)] displays server properties, events, service and performance counter data, and [!INCLUDE[bpa](includes/bpa_md.md)] \(BPA\) results for the local server. Event, service, BPA, and performance tiles function as they do on role and server group pages. For more information about configuring the data that is displayed in these tiles, see [View and Configure Performance, Event, and Service Data_1](View-and-Configure-Performance,-Event,-and-Service-Data_1.md) and [Run Best Practices Analyzer Scans and Manage Scan Results](Run-Best-Practices-Analyzer-Scans-and-Manage-Scan-Results.md).  
  
Menu commands and settings in the [!INCLUDE[sm](includes/sm_md.md)] console heading bars apply globally to all servers in your server pool, and let you use [!INCLUDE[sm](includes/sm_md.md)] to manage the entire server pool.  
  
This topic contains the following sections.  
  
-   [Shut down the local server](#BKMK_shutdown)  
  
-   [Configure Server Manager properties](#BKMK_props)  
  
-   [Manage the Server Manager console](#BKMK_managesm)  
  
-   [Customize tools that are displayed in the Tools menu](#BKMK_tools)  
  
-   [Manage roles on role home pages](#BKMK_roles)  
  
## <a name="BKMK_shutdown"></a>Shut down the local server  
The **Tasks** menu in the local server **Properties** tile lets you start a [!INCLUDE[wps_2](includes/wps_2_md.md)] session on the local server, open the **Computer Management** MMC snap\-in, or open MMC snap\-ins for roles or features that are installed on the local server. You can also shut down the local server by using the **Shut Down Local Server** command in this **Tasks** menu. The **Shut Down Local Server** command is also available for the local server in the **Servers** tile on the **All Servers** page, or on any role or group page in which the local server is represented.  
  
Shutting down the local server by using this method, unlike shutting down [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] from the **Start** screen, opens the **Shut Down Windows** dialog box, which lets you specify reasons for shutdown in the **Shutdown Event Tracker** area.  
  
> [!NOTE]  
> Only members of the Administrators group can shut down or restart a server. Standard users cannot shut down or restart a server. Clicking the **Shut Down Local Server** command logs standard users off server sessions. This matches the experience of a standard user running the **Alt\+F4** shutdown command from the server desktop.  
  
## <a name="BKMK_props"></a>Configure Server Manager properties  
You can view or change the following settings in the **Properties** tile on the **Local Server** page. To change a setting’s value, click the hypertext value of the setting.  
  
> [!NOTE]  
> Typically, the properties displayed in the Local Server **Properties** tile can only be changed on the local server. You cannot change the local server properties from a remote computer by using [!INCLUDE[sm](includes/sm_md.md)] because the **Properties** tile can only get information about the local computer, not remote computers.  
>   
> Because many properties displayed in the **Properties** tile are controlled by tools that are not part of [!INCLUDE[sm](includes/sm_md.md)] \(Control Panel, for example\), changes to **Properties** settings are not always displayed in the **Properties** tile immediately. By default, data in the **Properties** tile is refreshed every two minutes. To refresh **Properties** tile data immediately, click **Refresh** in the [!INCLUDE[sm](includes/sm_md.md)] address bar.  
  
|Setting|Description|  
|-----------|---------------|  
|Computer name|Displays the computer friendly name, and opens the **System Properties** dialog box, which lets you change the server’s name, domain membership, and other system settings such as user profiles.|  
|Domain \(or Workgroup, if the server is not joined to a domain\)|Displays the domain or workgroup of which the server is a member. Opens the **System Properties** dialog box, which lets you change the server’s name, domain membership, and other system settings such as user profiles.|  
|Windows Firewall|Displays Windows Firewall status for the local server. Opens **Control Panel\\System and Security\\Windows Firewall**. For more information about configuring Windows Firewall, see [Windows Firewall with Advanced Security and IPsec](http://go.microsoft.com/fwlink/?LinkId=253465).|  
|Remote management|Displays [!INCLUDE[sm](includes/sm_md.md)] and [!INCLUDE[wps_2](includes/wps_2_md.md)] remote management status. Opens the **Configure Remote Management** dialog box. For more information about remote management, see [Configure Remote Management in Server Manager](Configure-Remote-Management-in-Server-Manager.md).|  
|Remote Desktop|Shows whether users can connect to the server remotely by using Remote Desktop sessions. Opens the **Remote** tab of the **System Properties** dialog box.|  
|NIC Teaming|Shows whether the local server is participating in NIC teaming. Opens the **NIC Teaming** dialog box, and lets you join the local server to a NIC team if desired. For more information about NIC Teaming, see the [NIC Teaming white paper](http://go.microsoft.com/fwlink/?LinkID=253449).|  
|Ethernet|Displays the networking status of the server. Opens **Control Panel\\Network and Internet\\Network Connections**.|  
|Operating system version|This read\-only field displays the version number of the Windows operating system that the local server is running.|  
|Hardware information|This read\-only field displays the manufacturer and model name and number of the server hardware.|  
|Last installed updates|Displays the day and time that Windows updates were last installed. Opens **Control Panel\\System and Security\\Windows Update**.|  
|Windows Update|Displays Windows Update settings for the local server. Opens **Control Panel\\System and Security\\Windows Update**.|  
|Last checked for updates|Displays the day and time that the server last checked for available Windows updates. Opens **Control Panel\\System and Security\\Windows Update**.|  
|Windows Error Reporting|Displays Windows Error Reporting opt\-in status. Opens the **Windows Error Reporting Configuration** dialog box. For more information about Windows Error Reporting, its benefits, privacy statements, and opt\-in settings, see [Windows Error Reporting](http://go.microsoft.com/fwlink/?LinkID=245991).|  
|Customer Experience Improvement Program|Displays Windows Customer Experience Improvement Program opt\-in status. Opens the **Customer Experience Improvement Program Configuration** dialog box. For more information about Windows Customer Experience Improvement Program, its benefits, and opt\-in settings, see [Windows Customer Experience Improvement Program](http://go.microsoft.com/fwlink/?LinkID=245992).|  
|Internet Explorer \(IE\) Enhanced Security Configuration|Shows whether IE Enhanced Security Configuration \(also known as IE hardening or IE ESC\) is turned on or off. Opens the **Internet Explorer Enhanced Security Configuration** dialog box. IE Enhanced Security Configuration is a security measure for servers that prevents web pages from opening in Internet Explorer. For more information about IE Enhanced Security Configuration, its benefits, and settings, see [Internet Explorer: Enhanced Security Configuration](http://go.microsoft.com/fwlink/?LinkId=253461).|  
|Time zone|Displays the local server’s time zone. Opens the **Date and Time** dialog box.|  
|Product ID|Displays the Windows activation status and product ID number \(if Windows has been activated\) of the [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] operating system. This is not the same number as the Windows product key. Opens the **Windows Activation** dialog box.|  
|Processors|This read\-only field displays manufacturer, model name, and speed information about the local server’s processors.|  
|Installed memory \(RAM\)|This read\-only field displays the amount of available RAM, in gigabytes.|  
|Total disk space|This read\-only field displays the amount of available disk space, in gigabytes.|  
  
## <a name="BKMK_managesm"></a>Manage the Server Manager console  
Global settings that apply to the entire [!INCLUDE[sm](includes/sm_md.md)] console, and to all remote servers that have been added to the [!INCLUDE[sm](includes/sm_md.md)] server pool, are found in the heading bars at the top of the [!INCLUDE[sm](includes/sm_md.md)] console window.  
  
### Add servers to Server Manager  
The command that opens the **Add Servers** dialog box, and lets you add remote physical or virtual servers to the [!INCLUDE[sm](includes/sm_md.md)] server pool, is in the **Manage** menu of the [!INCLUDE[sm](includes/sm_md.md)] console. For detailed information about how to add servers, see [Add Servers to Server Manager_1](Add-Servers-to-Server-Manager_1.md).  
  
### Refresh data that is displayed in Server Manager  
You can configure the refresh interval for data that is displayed in [!INCLUDE[sm](includes/sm_md.md)] on the **Server Manager Properties** dialog box, which you open from the **Manage** menu.  
  
##### To configure the refresh interval in Server Manager  
  
1.  On the **Manage** menu in the [!INCLUDE[sm](includes/sm_md.md)] console, click **Server Manager Properties**.  
  
2.  In the **Server Manager Properties** dialog box, specify a time period, in minutes, for the amount of elapsed time you want between refreshes of the data that is displayed in [!INCLUDE[sm](includes/sm_md.md)]. The default is 10 minutes. Click OK when you are finished.  
  
#### Refresh limitations  
Refresh applies globally to data from all servers that you have added to the [!INCLUDE[sm](includes/sm_md.md)] server pool. You cannot refresh data or configure different refresh intervals for individual servers, roles, or groups.  
  
When servers that are in a cluster are added to [!INCLUDE[sm](includes/sm_md.md)], whether they are physical computers or virtual machines, the first refresh of data can fail, or display data only for the host server for clustered objects. Subsequent refreshes show accurate data for physical or virtual servers in a server cluster.  
  
Data that is displayed in role home pages in [!INCLUDE[sm](includes/sm_md.md)] for Remote Desktop Services, IP Address Management, and File and Storage Services does not refresh automatically. Refresh data that is displayed in these pages manually, by pressing **F5** or clicking **Refresh** in the [!INCLUDE[sm](includes/sm_md.md)] console heading while you are on those pages.  
  
### Add or remove roles or features  
The commands that open the [!INCLUDE[arfw](includes/arfw_md.md)] and [!INCLUDE[rrfw](includes/rrfw_md.md)], and let you add or remove [!INCLUDE[rrsandf_plural](includes/rrsandf_plural_md.md)] to servers in your server pool, are in the **Manage** menu of the [!INCLUDE[sm](includes/sm_md.md)] console, and the **Tasks** menu of the **Roles and Features** tile on role or group pages. For detailed information about how to add or remove roles or features, see [Install or Uninstall Roles, Role Services, or Features](Install-or-Uninstall-Roles,-Role-Services,-or-Features.md).  
  
In [!INCLUDE[sm](includes/sm_md.md)], role and feature data is displayed in the base language of the system, also called the system default GUI language, or the language selected during installation of the operating system.  
  
### Create server groups  
The command that opens the **Create Server Group** dialog box, and lets you create custom groups of servers, is in the **Manage** menu of the [!INCLUDE[sm](includes/sm_md.md)] console. For detailed information about how to create server groups, see [Create and Manage Server Groups](Create-and-Manage-Server-Groups.md).  
  
### Prevent Server Manager from opening automatically at logon  
The **Do not start Server Manager automatically at logon** check box in the **Server Manager Properties** dialog box controls whether [!INCLUDE[sm](includes/sm_md.md)] opens automatically at logon for members of the Administrators group on a local server. This setting does not affect [!INCLUDE[sm](includes/sm_md.md)] behavior when it is running on [!INCLUDE[winthreshold_client_2](includes/winthreshold_client_2_md.md)] as part of Remote Server Administration Tools. For more information about configuring this setting, see [Server Manager_1](Server-Manager_1.md).  
  
### Zoom in or out  
To zoom in or out on your view of the [!INCLUDE[sm](includes/sm_md.md)] console, you can either use the **Zoom** commands on the **View** menu, or press **Ctrl\+Plus \(\+\)** to zoom in and **Ctrl\+Minus \(\-\)** to zoom out.  
  
## <a name="BKMK_tools"></a>Customize tools that are displayed in the Tools menu  
The **Tools** menu in [!INCLUDE[sm](includes/sm_md.md)] includes soft links to shortcuts in the **Administrative Tools** folder in **Control Panel\/System and Security**. The **Administrative Tools** folder contains a list of shortcuts or LNK files to available management tools, such as MMC snap\-ins. [!INCLUDE[sm](includes/sm_md.md)] populates the **Tools** menu with links to those shortcuts, and copies the folder structure of the **Administrative Tools** folder to the **Tools** menu. By default, tools in the Administrative Tools folder are arranged in a flat list, sorted by type and by name. In the [!INCLUDE[sm](includes/sm_md.md)]**Tools** menu, items are sorted only by name, not by type.  
  
To customize the **Tools** menu, copy tool or script shortcuts that you want to use to the **Administrative Tools** folder. You can also organize your shortcuts in folders, which create cascading menus in the **Tools** menu. Additionally, if you want to restrict access to the custom tools on the **Tools** menu, you can set user access rights on both your custom tool folders in Administrative Tools, or directly on the original tool or script files.  
  
We recommend against reorganizing system and administrative tools, and any management tools associated with roles and features that are installed on the local server. Moving role and feature management tools can prevent successful uninstallation of those management tools, when necessary. After uninstallation of a role or feature, a nonfunctional link to a tool whose shortcut has been moved might remain in the **Tools** menu. If you reinstall the role, a duplicate link to the same tool is created in the **Tools** menu, but one of the links will not work.  
  
Role and feature tools that are installed as part of Remote Server Administration Tools on a Windows client\-based computer can be organized into custom folders, however. Uninstalling the parent role or feature has no effect on the tool shortcuts that are available on a remote computer that is running [!INCLUDE[winthreshold_client_2](includes/winthreshold_client_2_md.md)].  
  
The following procedure describes how to create an example folder called *MyTools*, and move shortcuts for two [!INCLUDE[wps_2](includes/wps_2_md.md)] scripts into the folder that are then accessible from the [!INCLUDE[sm](includes/sm_md.md)] Tools menu.  
  
#### To customize the Tools menu by adding shortcuts in Administrative Tools  
  
1.  Create a new folder called *MyTools* in a convenient location.  
  
    > [!NOTE]  
    > Because of restrictive access rights on the **Administrative Tools** folder, you are not allowed to create a new folder directly in the **Administrative Tools** folder; you must create a new folder elsewhere \(such as on the Desktop\), and then copy the new folder to the **Administrative Tools** folder.  
  
2.  Move or copy *MyTools* to **Control Panel\/System and Security\/Administrative Tools**. By default, you must be a member of the Administrators group on the computer to make changes to the **Administrative Tools** folder.  
  
3.  If you do not need to restrict user access rights to your custom tool shortcuts, go on to step 6. Otherwise, right\-click either the tool file \(or the *MyTools* folder\), and then click **Properties**.  
  
4.  On the **Security** tab of the file’s **Properties** dialog box, click **Edit**.  
  
5.  For users for whom you want to restrict tool access, clear check boxes for **Read & execute**, **Read**, and **Write** permissions. These permissions are inherited by the tool shortcut n the **Administrative Tools** folder.  
  
    If you edit access rights for a user while the user is using [!INCLUDE[sm](includes/sm_md.md)] \(or while [!INCLUDE[sm](includes/sm_md.md)] is open\), then your changes are not shown in the **Tools** menu until the user restarts [!INCLUDE[sm](includes/sm_md.md)].  
  
    > [!NOTE]  
    > If you restrict access to an entire folder that you have copied to Administrative Tools, restricted users can see neither the folder nor its contents in the [!INCLUDE[sm](includes/sm_md.md)]**Tools** menu.  
    >   
    > Edit permissions for the folder in the **Administrative Tools** folder. Because hidden files and folders in Administrative Tools are always displayed in the [!INCLUDE[sm](includes/sm_md.md)]**Tools** menu, do not use the **Hidden** setting on a file or folder’s **Properties** dialog box to restrict user access to your custom tool shortcuts.  
    >   
    > **Deny** permissions always overwrite **Allow** permissions.  
  
6.  Right\-click the original tool, script, or executable file for which you want to add entries on the **Tools** menu, and then click **Create shortcut**.  
  
7.  Move the shortcut to the *MyTools* folder in Administrative Tools.  
  
8.  Refresh or restart [!INCLUDE[sm](includes/sm_md.md)], if necessary, to see your custom tool shortcut in the **Tools** menu.  
  
## <a name="BKMK_roles"></a>Manage roles on role home pages  
After you add servers to the [!INCLUDE[sm](includes/sm_md.md)] server pool, and [!INCLUDE[sm](includes/sm_md.md)] collects inventory data about servers in your pool, [!INCLUDE[sm](includes/sm_md.md)] adds pages to the navigation pane for roles that are discovered on managed servers. The **Servers** tile on role pages lists managed servers that are running the role. By default, **Events**, **Best Practices Analyzer**, **Services**, and **Performance** tiles display data for all servers that are running the role; selecting specific servers in the **Servers** tile limits the scope of events, services, performance counters, and BPA results to selected servers only. Management tools are typically available in the [!INCLUDE[sm](includes/sm_md.md)] console **Tools** menu, after a role or feature has been installed or discovered on a managed server. You can also right\-click server entries in the **Servers** tile for a role or group, and then start the management tool that you want to use.  
  
In [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], the following roles and feature have management tools that are integrated into [!INCLUDE[sm](includes/sm_md.md)] console as pages.  
  
-   **File and Storage Services.** File and Storage Services pages include custom tiles and commands for managing volumes, shares, iSCSI virtual disks, and storage pools. When you open the File and Storage Services role home page in [!INCLUDE[sm](includes/sm_md.md)], a retracting pane opens that displays custom management pages for File and Storage Services. For more information about deploying and managing File and Storage Services, see [File and Storage Services](http://go.microsoft.com/fwlink/p/?LinkId=241530).  
  
-   **Remote Desktop Services.** Remote Desktop Services pages include custom tiles and commands for managing sessions, licenses, gateways, and virtual desktops. For more information about deploying and managing Remote Desktop Services, see [Remote Desktop Services (RDS)](http://go.microsoft.com/fwlink/p/?LinkId=241532).  
  
-   **IP Address Management \(IPAM\).** The IPAM role page includes a custom **Welcome** tile containing links to common IPAM configuration and management tasks, including a wizard for provisioning an IPAM server. The IPAM home page also includes tiles for viewing the managed network, configuration summary, and scheduled tasks.  
  
    There are some limitations to IPAM management in [!INCLUDE[sm](includes/sm_md.md)]. Unlike typical role and group pages, IPAM has no **Servers**, **Events**, **Performance**, **Best Practices Analyzer**, or **Services** tiles. There is no [!INCLUDE[bpa](includes/bpa_md.md)] model available for IPAM; [!INCLUDE[bpa](includes/bpa_md.md)] scans on IPAM are not supported. To access servers in your server pool that are running IPAM, create a custom group of those servers that are running IPAM, and access the server list from the **Servers** tile on the custom group page. Alternatively, access IPAM servers from the **Servers** tile on the **All Servers** group page.  
  
    Dashboard thumbnails also display limited rows for IPAM, compared to thumbnails for other roles and groups. By clicking the IPAM thumbnail rows, you can view events, performance data, and manageability status alerts for servers that are running IPAM. IPAM\-related services can be managed from pages for server groups that contain IPAM servers, such as the page for the **All Servers** group.  
  
    For more information about deploying and managing IPAM, see [IP Address Management (IPAM)](http://go.microsoft.com/fwlink/p/?LinkId=241533).  
  
## See Also  
[Server Manager_1](Server-Manager_1.md)  
[Add Servers to Server Manager_1](Add-Servers-to-Server-Manager_1.md)  
[Create and Manage Server Groups](Create-and-Manage-Server-Groups.md)  
[View and Configure Performance, Event, and Service Data_1](View-and-Configure-Performance,-Event,-and-Service-Data_1.md)  
[File and Storage Services](http://go.microsoft.com/fwlink/p/?LinkId=241530)  
[Remote Desktop Services (RDS)](http://go.microsoft.com/fwlink/p/?LinkId=241532)  
[IP Address Management (IPAM)](http://go.microsoft.com/fwlink/p/?LinkId=241533)  
  

