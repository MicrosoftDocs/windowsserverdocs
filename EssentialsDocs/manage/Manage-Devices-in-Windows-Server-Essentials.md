---
title: "Manage Devices in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f5fe1088-ebe7-4799-a47d-075b0048dea1
author: nnamuhcs
ms.author: coreyp
manager: dongill
---



# Manage Devices in Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials
 
 The following sections discuss the device management features of a server, and explain how to set up and use devices on your network:  
  
-   [Manage devices by using the Dashboard](Manage-Devices-in-Windows-Server-Essentials.md#BKMK_1)  
  
-   [Assign user accounts permission to log on to specific network computers](Manage-Devices-in-Windows-Server-Essentials.md#BKMK_2)  
  
-   [Remove a computer from the server](Manage-Devices-in-Windows-Server-Essentials.md#BKMK_3)  
  
-   [Configure Group Policy settings for folder redirection and security](Manage-Devices-in-Windows-Server-Essentials.md#BKMK_5)  
  
-   [Connect to a network computer by using a Remote Desktop session](Manage-Devices-in-Windows-Server-Essentials.md#BKMK_7)  
  
-   [View computer properties](Manage-Devices-in-Windows-Server-Essentials.md#BKMK_8)  
  
##  <a name="BKMK_1"></a> Manage devices by using the Dashboard  
 Windows Server Essentials makes it possible to perform common administrative tasks by using the Windows Server Essentials Dashboard. The **Devices** page of the Dashboard provides the following:  
  
-   A list of network computers, which displays:  
  
    -   The name of the computer  
  
    -   The status of the computer, either **Online** or **Offline**  
  
    -   The computer description  
  
    -   The backup status of the computer  
  
    -   The update status of the computer  
  
    -   The security status of the computer  
  
    -   The alerts status of the computer  
  
    -   Group Policy information for the computer  
  
-   A details pane with additional information about a selected computer  
  
-   A tasks pane that includes a set of device administrative tasks such as viewing computer properties and alerts, setting up computer backup, and restoring files and folders from a backup  
  
#### To view the status of network computers  
  
1. Open the Windows Server Essentials Dashboard.  
  
2. On the navigation bar, click **Devices**.  
  
3. View the status of all the computers in the network in the list pane.  
  
   The following table describes the various computer and backup tasks that are available in the Windows Server Essentials Dashboard. Some of the tasks are computer-specific, and they are only visible when you select a computer in the list.  
  
### Computer tasks in the Dashboard  
  
|Task name|Description|  
|---------------|-----------------|  
|View the computer properties|Displays general information for a selected computer, and enables you to view details for the computer backups.|  
|Set up backup for this computer|Runs the Set up Backup Wizard.|  
|Customize backup for the computer|Opens the backup properties, from which you can make changes to the backup settings for the selected computer.|  
|Start a backup for the computer|Starts a backup for a selected computer.|  
|Stop backup for the computer|Stops the backup for a selected computer.|  
|Restore files or folders for the computer|Runs the Restore Files and Folders Wizard, which enables you to restore specific files, folders, or drives.|  
|View alerts for the computer|Displays critical and other informational alerts and enables you to take corrective action where possible.|  
|Remote Desktop to the computer|Opens Remote Desktop Connection to the selected computer.|  
|Remove the computer|Runs the Remove a Computer Wizard, which detaches the computer from the Windows Server Essentials Dashboard.|  
|Customize computer backup and File History settings|Opens the backup settings page, from which you can make changes to the backup schedule and File History settings for client computers.|  
|How do I connect computers to the server?|Opens a Help topic that describes the steps to perform in order to join a computer to the network.|  
|Implement Group Policy|Applies policy settings to Windows 8 and Windows 7 computers that are joined to the domain.|  
  
##  <a name="BKMK_2"></a> Assign user accounts permission to log on to specific network computers  
 You can assign permissions to user accounts so that users can log on to only specific network computers when accessing the Windows Server Essentials network from a remote location.  
  
#### To change the computer access for a user account  
  
1.  Open the Windows Server Essentials Dashboard.  
  
2.  On the navigation bar, click **Users**.  
  
3.  In the list of user accounts, select the user account that you want to change.  
  
4.  In the **<User Account\> Tasks** pane, click **View the account properties**. The **Properties** page for the user account appears.  
  
5.  On the **Computer access** tab, select the computer that this user can access remotely, and then click **OK**.  
  
##  <a name="BKMK_3"></a> Remove a computer from the server  
 When you remove a computer from a server that is running Windows Server Essentials by using the Dashboard, it is no longer managed by the server. As a result, the server will stop creating computer backups or monitor its health after its removal from the network.  
  
> [!NOTE]
>  Removal of a computer from the server does not disconnect the computer from the network. The computer can still access resources on the network in the same way it could before being connected to the server. To prevent the computer from accessing server resources and to disconnect it from the server, you must remove the computer from the domain. In addition, removal of the computer from the server does not automatically uninstall the Connector software or the Launchpad from the computer that is being removed. You must manually remove the Connector software from the computer. For more information, see the section Uninstall the Connector software in [Get Connected](../use/Get-Connected-in-Windows-Server-Essentials.md).  
  
#### To remove a computer from the network by using the Dashboard  
  
1.  Open the Windows Server Essentials Dashboard.  
  
2.  On the navigation bar, click the **Devices** tab.  
  
3.  In the list of computers, right-click the computer that you want to remove from the network, and then click **Remove the computer**.  
  
##  <a name="BKMK_5"></a> Configure Group Policy settings for folder redirection and security  
 You can configure Group Policy and deploy it to computers in the Windows Server Essentials network by using the Windows Server Essentials Dashboard. Group Policy in Windows Server Essentials includes settings for folder redirection and security that impact Windows Update, Windows Defender, and the network firewall.  
  
#### To configure Group Policy in Windows Server Essentials  
  
1.  Open the Windows Server Essentials Dashboard.  
  
2.  On the navigation bar, click **DEVICES**.  
  
3.  For  Windows Server Essentials: In the global **Users Tasks** pane, click **Implement Group Policy**.  
  
     For  Windows Server Essentials: In the global **Devices Tasks** pane, click **Implement Group Policy**.  
  
4.  The Implement Group Policy Wizard opens.  
  
5.  On the **Enable Folder Redirection Group Policy** page of the wizard, you can choose the user folders that you want to redirect.  
  
6.  On the **Enable Security Policy Settings** page of the wizard, you can choose to enable Group Policy settings for **Windows Update**, **Windows Defender**, and the **Network Firewall**.  
  
7.  Click **Finish** to implement the Group Policy settings.  
  
##  <a name="BKMK_7"></a> Connect to a network computer by using a Remote Desktop session  
 To remotely access your Windows Server Essentials network computer when you are away from your office, use your Web browser to log on to your organization ��s Remote Web Access website, and on the **Computers** tab, click the name of the computer.  
  
 The **Status** column shows you if you can connect to a computer on your network, and can contain the following values:  
  
-   **Available**  
  
     The computer is turned on and is available for a remote connection. Even if you see this status, you still may not be able to connect to this computer if a third-party firewall blocks the connection.  
  
-   **Offline or Sleeping**  
  
     The computer is turned off or is in Sleep or Hibernate mode. If a computer is offline or sleeping, the status is updated in real time so that you can know when the computer becomes available.  
  
-   **Unsupported operating system**  
  
     The operating system on the computer does not support remote desktop. It may take up to 6 hours for this status to be updated on the server if there is a change.  
  
-   **Connection is disabled**  
  
     The computer connection is either blocked by a firewall, or the remote desktop is disabled on the computer or by Group Policy. It may take up to 6 hours for this status to be updated on the server if there is a change.  
  
##  <a name="BKMK_8"></a> View computer properties  
 The **Devices** section of the Windows Server Essentials Dashboard displays a list of network computers. The list also provides additional information about each computer.  
  
#### To view a list of computers  
  
1.  Open the Windows Server Essentials Dashboard.  
  
2.  On the main navigation bar, click **Devices**.  
  
3.  The Dashboard displays a current list of computers.  
  
#### To view or change properties for a computer  
  
1.  In the list of computers, select the account for which you want to view or change properties.  
  
2.  In the **<Computername\> Tasks** pane, click **View the computer properties**. The **Properties** page for the computers appears.  
  
3.  Click a tab to display the properties for that computer.  
  
4.  To save any changes that you make to the computer properties, click **Apply**.  
  
## See also  
  
-   [Manage Remote Web Access](Manage-Remote-Web-Access-in-Windows-Server-Essentials.md)  
  
-   [Use Remote Web Access](../use/Use-Remote-Web-Access-in-Windows-Server-Essentials.md)  
  
-   [Manage user accounts using the Dashboard](Manage-User-Accounts-in-Windows-Server-Essentials.md#BKMK_Manage8)  
  
-   [Manage Windows Server Essentials](Manage-Windows-Server-Essentials.md)  
  
-   [Use Windows Server Essentials](../use/Use-Windows-Server-Essentials.md)
