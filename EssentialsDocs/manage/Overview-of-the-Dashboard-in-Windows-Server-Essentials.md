---
title: "Overview of the Dashboard in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f70a79de-9c56-4496-89b5-20a1bff2293e
author: nnamuhcs
ms.author: coreyp
manager: dongill
---



# Overview of the Dashboard in Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials
 
 Windows Server Essentials and Windows Server 2012 R2 Standard with the Windows Server Essentials Experience role enabled include an administrative dashboard, which simplifies the tasks that you perform to manage your Windows Server Essentials network and server. By using the Windows Server Essentials Dashboard, you can:  
  
- Finish setting up your server  
  
- Access and perform common administrative tasks  
  
- View server alerts and take action on them  
  
- Set up and change server settings  
  
- Access or search for Help topics on the web  
  
- Access Community resources on the web  
  
- Manage user accounts  
  
- Manage devices and backups  
  
- Manage access and settings for server folders and hard drives  
  
- View and manage add-in applications  
  
- Integrate with Microsoft online services  
  
  This topic includes:  
  
- [Basic features of the Dashboard](#BKMK_Design)  
  
- [Features of the Dashboard Home page](#BKMK_Home)  
  
- [Administrative sections of the Dashboard](#BKMK_Features)  
  
- [Access the Windows Server Essentials Dashboard](#BKMK_AccessDb)  
  
- [Use the Safe mode](#BKMK_UseSafeMode)  
  
##  <a name="BKMK_Design"></a> Basic features of the Dashboard  
 The Windows Server Essentials Dashboard helps you to quickly access the key information and management features of your server. The Dashboard includes several sections. The table that follows describes the sections.  
  
 
  
|Item|Dashboard Feature|Description|  
|----------|-----------------------|-----------------|  
|1|Navigation bar|Click a section on the Navigation Bar to access the information and tasks that are associated with that section. Each time you open the Dashboard, the **Home** page appears by default.|  
|2|Subsection tabs|The subsection tabs provide access to a second layer of Windows Server Essentials administrative tasks.|  
|3|List pane|The list view displays the objects that you can manage, and includes basic information about each object.|  
|4|Details pane|The details pane displays additional information about an object that you select in the list view.|  
|5|Tasks pane|The Tasks pane contains links to tools and to information that help you manage the properties for either a specific object (such as a user account or a computer), or for global settings for the object category. The Tasks pane is divided into these two sections:<br /><br /> **Object tasks**  œ Contains links to tools and information that help you manage the properties for an object that you select in the list view (such as a user account or a computer).<br /><br /> **Global tasks**  œ Contains links to tools and information that help you manage global tasks for a feature area. Global tasks include tasks to add new objects, set policy, and so on.|  
|6|Information and Settings|This section provides direct access to the server settings, and a Help link to information about the dashboard page that you are viewing.|  
|7|Alerts status|The alerts status provides a quick visual indication about the health of the server. Click the alert image to view critical and important alerts.<br /><br /> **Note:** In Windows Server Essentials and Windows Server 2012 R2 Standard with the Windows Server Essentials Experience role installed, the Alerts status is available on the **Information and Settings** tab.|  
|8|Status bar|The status bar displays the number of objects that appear in the list view. Add-in applications may also display other status.|  
  
##  <a name="BKMK_Home"></a> Features of the Dashboard Home page  
 When you open the Dashboard, the **Home** page appears by default with the **SETUP** category displayed. The **Home** page of the Windows Server Essentials Dashboard provides quick access to tasks and information that help you customize your server and configure key features. The Home page is comprised of four functional areas, which expose information and configuration tasks for the options that you select. The table that follows describes the features.  
  
|Item|Feature|Description|  
|----------|-------------|-----------------|  
|1|Navigation Bar|Click a section on the Navigation Bar to access the information and tasks that are associated with that section. Each time you open the Dashboard, the **Home** page displays by default.|  
|2|Category pane|This pane displays feature areas that provide quick access to information and configuration tools that help you set up and customize the server. Click a category to display tasks and resources that are associated with that category.|  
|3|Tasks pane|This pane displays links to tasks and information that apply to a selected category. Click a task or resource to display additional information.|  
|4|Action pane|This pane provides a brief description of a feature or task, and provides links that open configuration wizards and information pages. Click a link to take further action.|  
  
##  <a name="BKMK_Features"></a> Administrative sections of the Dashboard  
 The Windows Server Essentials Dashboard organizes network information and administrative tasks into functional areas. The management page for each functional area provides information about the objects associated with that area, for example **Users**, or **Devices**. The management page also includes tasks that you can use to view or change settings, or to run programs that automate tasks that require multiple steps.  
  
 The following table describes the administrative sections of the Dashboard that are available by default after installation. The table also lists the tasks that are available within each section.  
  
|Section|Description|  
|-------------|-----------------|  
|Home|The **Home** page appears by default each time that you open the Dashboard. It includes tasks and information in the following categories:<br /><br /> **SETUP**  œ Complete the tasks in this category to configure your server for the first time. For information about these tasks, see [Install and Configure Windows Server Essentials](../install/Install-and-Configure-Windows-Server-Essentials.md).<br /><br /> **EMAIL**  œ Choose an option in this category to integrate an email service with the server.<br /><br /> **Note:** This category is only available in Windows Server Essentials.<br /><br /> **SERVICES**  œ Choose a task in this category to integrate Microsoft online services with the server.<br /><br /> **Note:** This category is only available in Windows Server Essentials and Windows Server 2012 R2 Standard with the Windows Server Essentials Experience role enabled.<br /><br /> **ADD-INS**  œ Click this category to install valuable add-ins for your business.<br /><br /> **QUICK STATUS**  œ Displays high-level server status. Click a status to view information and configuration options for that feature. If you complete all of the tasks in the SETUP category, this category appears at the top of the Category pane.<br /><br /> **HELP**  œ Use the Search box to search for help on the Web. Click a link to visit the website for the selected support option.|  
|Users|For users to access the resources that Windows Server Essentials provides, you need to create user accounts by using the Windows Server Essentials Dashboard. After creating user accounts, you can manage the accounts by using the tasks that are available on the **Users** page of the Dashboard. Tasks that you can perform on this page include:<br /><br /> - View a list of user accounts.<br /><br /> - View and manage user account properties.<br /><br /> - Activate or deactivate user accounts.<br /><br /> - Add or remove user accounts.<br /><br /> - Assign local network accounts to Microsoft online services accounts if your server is integrated with Office 365.<br /><br /> - Change user account passwords and manage the password policy.<br /><br /> For information about managing user accounts, see [Manage User Accounts](Manage-User-Accounts-in-Windows-Server-Essentials.md).|  
|User groups|**Note:** This feature is available only in Windows Server Essentials and Windows Server 2012 R2 Standard with the Windows Server Essentials Experience role enabled.<br /><br /> Tasks that you can perform on this page include:<br /><br /> - View a list of user groups.<br /><br /> - View and manage user groups.<br /><br /> - Add or remove user groups.|  
|Distribution groups|**Note:** This feature is available only in Windows Server Essentials and Windows Server 2012 R2 Standard with the Windows Server Essentials Experience role enabled. This tab is only displayed when Windows Server Essentials is integrated with Office 365.<br /><br /> Tasks that you can perform on this page include:<br /><br /> - View a list of distribution groups.<br /><br /> - Add or remove distribution groups.|  
|Devices|After you connect computers to the Windows Server Essentials network, you can manage the computers from the **Devices** page of the Dashboard. Tasks that you can perform on this page include:<br /><br /> - View a list of computers that are joined to your network.<br /><br /> - Manage mobile devices by leveraging the Office 365 Mobile Device Management capability.<br /><br /> **Note:** This feature is only available in Windows Server Essentials and Windows Server 2012 R2 Standard with the Windows Server Essentials Experience role enabled.<br /><br /> - View the computer properties and health alerts for each computer.<br /><br /> - Set up and manage computer backups.<br /><br /> - Restore files and folders to computers.<br /><br /> - Establish a Remote Desktop connection to a computer<br /><br /> - Customize Computer Backup and File History settings<br /><br /> For information about managing computers and backups, see [Manage Devices](Manage-Devices-in-Windows-Server-Essentials.md).|  
|Storage|Depending on the version of Windows Server Essentials you are running, the **Storage** section of the Dashboard contains the following sections by default.<br /><br /> - The **Server Folders** subsection includes tasks that help you view and manage the properties for server folders. The page also includes tasks to open and add server folders.<br /><br /> - The **Hard Drives** page includes tasks that help you view and check the health of the drives that are attached to the server.<br /><br /> - In Windows Server Essentials and Windows Server 2012 R2 Standard with the Windows Server Essentials Experience role enabled, the **SharePoint Libraries** page includes tasks that help you manage the SharePoint Libraries in Office 365 service.<br /><br /> For information about managing server folders, see [Manage Server Folders](Manage-Server-Folders-in-Windows-Server-Essentials.md).<br /><br /> For information about managing hard drives, see [Manage Server Storage](Manage-Server-Storage-in-Windows-Server-Essentials.md).|  
|Applications|- The **Applications** section of the Windows Server Essentials Dashboard contains two subsections by default.<br /><br /> For information about managing add-in applications, see [Manage Applications](Manage-Applications-in-Windows-Server-Essentials.md).<br /><br /> - The **Add-ins** subsection displays a list of installed add-ins, and provides tasks that enable you to remove an add-in, and to access additional information about a selected add-in.<br /><br /> - The **Microsoft Pinpoint** subsection displays a list of applications that are available from Microsoft Pinpoint.|  
|Office 365|The **Office 365** tab displays only when Windows Server Essentials is integrated with Microsoft Office 365. This section contains Office 365 subscription and administrator account information.|  
  
> [!NOTE]
>  If you install an add-in for the Windows Server Essentials Dashboard, the add-in may create additional administrative sections. These sections may appear on the main navigation bar, or on a subsection tab.  
  
##  <a name="BKMK_AccessDb"></a> Access the Windows Server Essentials Dashboard  
 You can access the Dashboard by using of one of following methods. The method you choose depends on whether you are accessing the dashboard from the server, from a computer that is connected to the Windows Server Essentials network, or from a remote computer.  
  
 To help maintain a secure network, only users with administrative permissions can access the Windows Server Essentials Dashboard. Additionally, you cannot use the built-in Administrator account to sign in to the Windows Server Essentials Dashboard from the Launchpad.  
  
###  <a name="BKMK_Server"></a> Access the Dashboard from the server  
 When you install Windows Server Essentials, the setup process creates a shortcut to the Dashboard on the **Start** screen, and also on the Desktop. If the shortcut is missing from these locations, you can use the **Search** pane to find and run the Dashboard program.  
  
##### To access the Dashboard from the server  
  
-   Sign in to the server as an administrator, and then do any of the following:  
  
    -   On the **Start** screen, click **Dashboard**.  
  
    -   On the Desktop, double-click **Dashboard**.  
  
    -   In the **Search** pane, type **dashboard**, and then click **Dashboard** in the search results.  
  
###  <a name="BKMK_Network"></a> Access the Dashboard from a computer that is connected to the network  
 In Windows Server Essentials, after you join a computer to the network, administrators can use the Launchpad to access the server Dashboard from the computer.  
  
> [!WARNING]
>  In  Windows Server Essentials, to connect to the Dashboard from the client computer, right-click the tray icon, and then open the Dashboard from the context menu.  
  
##### To access the Dashboard by using the Launchpad  
  
1.  From a computer that is joined to the network, open the **Launchpad**.  
  
2.  On the Launchpad menu, click **Dashboard**.  
  
3.  On the Dashboard **Sign in** page, type your network administrator credentials, and then press ENTER.  
  
     A remote connection to the Windows Server Essentials Dashboard opens.  
  
###  <a name="BKMK_Remote"></a> Access the Dashboard from a remote computer  
 When you are working from a remote computer, you can access the Windows Server Essentials Dashboard by using the  Remote Web Access site.  
  
##### To access the Dashboard by using Remote Web Access  
  
1.  From the remote computer, open an Internet browser, such as Internet Explorer.  
  
2.  In the Internet browser address bar, type the following:**https://<DomainName\>/remote**, where *DomainName* is the external domain name of your organization (such as contoso.com).  
  
3.  Type your username and password to sign in to the  Remote Web Access site.  
  
4.  In the **Computers** section of the  Remote Web Access**Home** page; locate your server and click **Connect**.  
  
     A remote connection to the Dashboard opens.  
  
    > [!NOTE]
    >  If your server does not appear in the **Computers** section of the Home page, click **Connect to more computers**, find your server in the list, and then click the server to connect to it.  
    >   
    >  To give a user permission to access the Dashboard from  Remote Web Access, open the Properties page for the user account, and then select the **Server Dashboard** option on the **Anywhere Access** tab.  
  
##  <a name="BKMK_UseSafeMode"></a> Use the Safe mode  
 The Safe mode feature of Windows Server Essentials monitors the add-ins that are installed on the server. If the Dashboard becomes unstable or unresponsive, Safe mode detects and isolates add-ins that might be causing the issue, and displays them on the **Safe Mode Settings** page the next time you open the Dashboard. From the **Safe Mode Settings** page, you can disable and enable add-ins one-by-one to determine which add-in is causing the issue. You can then choose to leave the add-in disabled for future startups, or you can uninstall the add-in.  
  
 You can view a list of all add-ins that are installed on the server at any time. You can also open the Dashboard in Safe mode, which automatically disables all non-Microsoft add-ins. Windows Server Essentials also allows you to access the Dashboard in Safe mode from another computer on the network.  
  
#### To view a list of installed add-ins  
  
-   From the Dashboard, click **Help**, and then click **Safe mode settings**.  
  
#### To open the Dashboard in Safe mode  
  
-   In the **Search** pane, type **safe**, and then click **Dashboard (Safe mode)** in the search results.  
  
#### To open the Dashboard in Safe mode from another computer on the network  
  
1.  From a computer that is connected to the network, open the Windows Server Essentials Launchpad, and then click **Dashboard**.  
  
2.  On the Dashboard sign-in page, type the user name and password for an account that has permission to sign in to the server, select the **Allow me to select which add-ins to load** check box, and then click the arrow to sign in.  
  
## See also  
  
-   [Manage Applications](Manage-Applications-in-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](Manage-Windows-Server-Essentials.md)
