---
title: "Troubleshoot connecting computers to the server in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e45b3d89-c057-4c70-a627-86fb06dd22aa
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Troubleshoot connecting computers to the server in Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials 
  
 This topic contains troubleshooting guidance for issues that you might encounter when you connect a computer to the server that is running  Windows Server Essentials or  Windows Server Essentials.  
  
> [!NOTE]
>  For the most current troubleshooting information from the  Windows Server Essentials and  Windows Server Essentials community, we suggest that you visit the [Windows Server Essentials Forum](https://social.technet.microsoft.com/Forums/windowsserver/home?forum=winserveressentials). The Windows Server Essentials Forum is a great place to search for help, or to ask a question.  
  
 This topic provides solutions for the following issues:  
  

-   Issue 1: [Issue 1](Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BMRK_Package)  
  
-   Issue 2: [Issue 2](Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_ConnectorIssue2)  
  
-   Issue 3: [Issue 3](Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_ConnectorIssue2a)  
  
-   Issue 4: [Issue 4](Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_ConnectorIssueNetFramework)  
  
-   Issue 5: [Issue 5](Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_Time)  
  
-   Issue 6: [Issue 6](Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_ServiceStopped)  
  
-   Issue 7: [Issue 7](Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_ConnectorIssueReconnect)  
  
-   Issue 8: [Issue 8](Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_JoinWin7)  
  
-   Issue 9: [Issue 9](Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_ConnectorIssueAutologon)  
  
-   Issue 10: [Issue 10](Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_ConnectorIssueOldLogs)  
  
-   Issue 11: [Issue 11](Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_UpgradeClientOS)  

-   Issue 1: [Issue 1](../support/Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BMRK_Package)  
  
-   Issue 2: [Issue 2](../support/Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_ConnectorIssue2)  
  
-   Issue 3: [Issue 3](../support/Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_ConnectorIssue2a)  
  
-   Issue 4: [Issue 4](../support/Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_ConnectorIssueNetFramework)  
  
-   Issue 5: [Issue 5](../support/Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_Time)  
  
-   Issue 6: [Issue 6](../support/Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_ServiceStopped)  
  
-   Issue 7: [Issue 7](../support/Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_ConnectorIssueReconnect)  
  
-   Issue 8: [Issue 8](../support/Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_JoinWin7)  
  
-   Issue 9: [Issue 9](../support/Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_ConnectorIssueAutologon)  
  
-   Issue 10: [Issue 10](../support/Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_ConnectorIssueOldLogs)  
  
-   Issue 11: [Issue 11](../support/Troubleshoot-connecting-computers-to-the-server-in-Windows-Server-Essentials.md#BKMK_UpgradeClientOS)  

  
##  <a name="BMRK_Package"></a> Issue 1  
 **Issue**  
  
 I get a Package installation did not succeed. Try to install the Windows Server Essentials Connector again. If the issue persists, contact your network administrator error when connecting a computer to the server  
  
 **Description**  
  
 This issue may occur if you connect a computer to a server that is running  Windows Server Essentials while other Windows updates or application installations are pending and the Connector installation is canceled.  
  
 **Solution**  
  
 Complete all other updates or application installations. Restart the computers if prompted.  
  
##  <a name="BKMK_ConnectorIssue2"></a> Issue 2  
 **Issue**  
  
 Cannot join a computer to  Windows Server Essentials  
  
 **Description**  
  
 Computers that have non-ASCII characters in the computer name cannot be joined to  Windows Server Essentials. If the computer name includes non-ASCII characters, you receive the error message "An unexpected error has occurred."  
  
 **Solution**  
  
 Rename your client computer with a name that contains ASCII characters only, and try to add the computer to Windows Server Essentials again.  
  
##  <a name="BKMK_ConnectorIssue2a"></a> Issue 3  
 **Issue**  
  
 I get a The Connector software installation is canceled error when connecting a computer to the server  
  
 **Description**  
  
 To be able to connect a computer to the server, the SYSTEM account must have Full Control permissions on server folders displayed on the  Windows Server Essentials Dashboard. If the required permissions have not been granted, you receive the "The Connector software installation is canceled" error message.  
  
 **Solution**  
  
 Grant the SYSTEM account **Full control** permissions on each server folder.  
  
#### To grant the SYSTEM account Full control permissions on a server folder  
  
1.  Open the  Windows Server Essentials Dashboard.  
  
2.  Click **Storage**, and then click **Server Folders**.  
  
3.  Right-click the server folder, and then click **Open the folder**. (If you do not see the **Open the folder** option, you do not need to set permissions on the folder.)  
  
4.  In the network path at the top of Windows Explorer, click the server share to display shared folders on the server. For example, if the path is **Network > Server01 > File History Backups**, click **Server01**.  
  
5.  Right-click a server folder, and then click **Properties**.  
  
6.  Click the **Security** tab.  
  
7.  If **Full control** is not allowed for the SYSTEM account, click **Edit**, and then click **SYSTEM**. Under **Permissions for System**, select the **Allow** check box beside **Full control**.  
  
8.  Click **OK** twice to update the permissions and close **Properties**.  
  
##  <a name="BKMK_ConnectorIssueNetFramework"></a> Issue 4  
 **Issue**  
  
 I get a To run this application, you must install one of the following versions of the .NET Framework: V4.5.50709" error when connecting a computer to the server  
  
 **Description**  
  
 When you connect a computer to a server that is running Windows Server Essentials or  Windows Server Essentials, the wizard attempts to install .NET Framework version 4.5.50709 on the computer. However, if an earlier release of .NET Framework version 4.5 is present, the updated release cannot be installed, and the connection attempt fails with this error message: To run this application, you must install one of the following versions of the .NET Framework: V4.5.50709. Contact your allocation publisher for instructions about obtaining the appropriate version of the .NET Framework.  
  
 **Solution**  
  
 Uninstall .NET Framework 4.5 from the computer, and then connect the computer to the server.  
  
#### To uninstall .NET Framework 4.5  
  
1.  On the **Start** page of the client computer, open **Control Panel**.  
  
2.  In Control Panel, under **Programs**, click **Uninstall a program**.  
  
3.  Right-click **Microsoft .NET Framework 4.5**, and then click **Uninstall**.  
  
4.  After .NET Framework 4.5 is uninstalled successfully, connect the computer to the server. The correct release of .NET Framework 4.5 is installed along with the connector software.  
  
##  <a name="BKMK_Time"></a> Issue 5  
 **Issue**  
  
 I get a The server is not available. To resolve this issue, contact the person responsible for your network. error when connecting a computer to the server  
  
 **Description**  
  
 This can happen if the date and time on the connected computer are not synchronized with the date and time on the server.  Windows Server Essentials and  Windows Server Essentials use the time synchronization service to synchronize the date and time of computers running in a  Windows Server Essentials or  Windows Server Essentials network. Synchronized time is critical because the default authentication protocol uses server time as part of the authentication process. For example, if the clock on a client computer is not synchronized to the correct date and time,  Windows Server Essentials or  Windows Server Essentials authentication might falsely interpret a logon request as an intrusion attempt and deny access to the user.  
  
 This can happen if the server's free memory is less than 5 percent.  
  
 This can happen if you already have a VPN connection to the Windows Essentials Server and you try to configure the Connector software off-premise by using a domain address.  
  
 **Solution**  
  
1.  Synchronize the date and time on the client computer with those on the server. Then connect the computer to the server.  
  
2.  Close some applications on the server side, and then connect the computer to the server.  
  
3.  Close the VPN connection, and then connect the computer to the server.  
  
#### To change the date and time on the client computer  
  
1. On the Start page of the client computer, open **Control Panel**.  
  
2. In Control Panel, click **Clock, Language, and Region**, and then click **Date and Time**.  
  
3. Click **Change date and time**, set the date and time to the correct date and time, and then click **OK**.  
  
4. Click **OK**, and then close Control Panel.  
  
5. Try again to connect the client computer to the server. For instructions, see Connect computers to the server.  
  
   If you still cannot connect the client computer to the server, make sure that the date and time on the server are correct. If the date and time are not correct, change them.  
  
#### To change the date and time on the server  
  
1.  Log on to the server using the password that you set up during  Windows Server Essentials or  Windows Server Essentials installation and configuration.  
  
    > [!NOTE]
    >  If you are managing the server remotely, you must log on to the server using Remote Desktop Connection.  
  
2.  On the **Start** page, open **Control Panel**.  
  
3.  In Control Panel, click **Clock, Language, and Region**, and then click **Date and Time**.  
  
4.  Click **Change date and time**, set the date and time to the correct date and time, and then click **OK**.  
  
5.  Click **OK**, and then close Control Panel.  
  
6.  On the client computer, try again to connect the client computer to the server. For instructions, see Connect computers to the server.  
  
##  <a name="BKMK_ServiceStopped"></a> Issue 6  
 **Issue**  
  
 I get an An unexpected error has occurred. To resolve this issue, contact the person responsible for your network. error when connecting a computer to the server  
  
 **Description**  
  
 If you receive this error message, the WSS Certificate Web Service might not be running.  
  
 **Solution**  
  
 Start the WSS Certificate Web Service.  
  
#### To start the WSS Certificate Web Service  
  
1.  On the server's **Start** page, open **Administrative Tools**.  
  
     In **Administrative Tools**, right-click **Internet Information Services (IIS) Manager**, and then click **Open**.  
  
2.  In the navigation pane, click **WSS Certificate Web Service**.  
  
3.  In the **Actions** pane, click **Start**.  
  
##  <a name="BKMK_ConnectorIssueReconnect"></a> Issue 7  
 **Issue**  
  
 When I try to connect a computer to the server again after an unsuccessful connection attempt, I receive the warning A computer with this name is already connected to the server  
  
 **Description**  
  
 If an earlier attempt to connect a computer to the server was canceled or interrupted, you might receive the following warning when you try to connect again: A computer with this name is already connected to the server. This happens because a certificate was issued when you tried to connect to the server the first time.  
  
 **Solution** If you are sure that no other computer with the same name is already connected to the server, click **Next**, and then follow instructions to complete the **Connect my computer to the server** wizard.  
  
##  <a name="BKMK_JoinWin7"></a> Issue 8  
 **Issue**  
  
 When I attempt to connect a client computer that is running Windows 7 Home to the server, the web page for running the connector software opens, but the client computer cannot connect to the server  
  
 **Description**  
  
 If the router on your network has multicast enabled, communications between the server and a client computer running Windows 7 Home Basic or Windows 7 Home Premium do not work correctly.  
  
 **Solution**  
  
 Disable multicast on your router. On some routers, that might include disabling the RIP-2M routing protocol. For more information, refer to the documentation provided by the router manufacturer.  
  
##  <a name="BKMK_ConnectorIssueAutologon"></a> Issue 9  
 **Issue**  
  
 Auto logon stopped working after I connected the computer to the server  
  
 **Description**  
  
 If auto logon is set for the user account when you connect the computer to  Windows Server Essentials, the setting is overwritten when the connector software is installed on the computer.  
  
 **Solution** To resolve this issue, when you connect the computer to the server, note the password that is used for the user account. After the connector software is installed, configure auto logon to use that account.  
  
> [!NOTE]
>  The  Windows Server Essentials domain account requires a password that meets the default password policy requirements.  
  
##  <a name="BKMK_ConnectorIssueOldLogs"></a> Issue 10  
 **Issue**  
  
 Uninstalling a prerelease version of the connector software does not remove existing logs  
  
 **Description**  
  
 After you update from a pre-release (Beta or RC) version of Windows Server Essentials to the released version, you must remove the connector software from each computer that was connected to the server, and then connect the computer again to install the released version of the connector software.  
  
 However, when you remove the connector software from a network computer, the existing log files in the %ProgramData%\Microsoft\Windows Server\Logs\ folder on that computer are not deleted. If you do not delete the Logs folder, the log files can become corrupt when you connect the computer to the released version of Windows Server Essentials.  
  
 **Solution** To avoid corruption of the log files, manually delete the Logs folder before you reconnect the client computer to the updated server.  
  
#### To reconnect a computer after a server update without corrupting the log files  
  
1.  Uninstall the Connector software from the client computer.  
  
2.  Delete the Logs folder from the %ProgramData%\Microsoft\Windows Server\ folder.  
  
3.  Connect the computer to the server again. That installs the released version of the connector software, creating a new Logs folder and log files.  
  
##  <a name="BKMK_UpgradeClientOS"></a> Issue 11  
 **Issue**  
  
 I want to upgrade the operating system on a client computer  
  
 **Description**  
  
 During the installation of the connector software, numerous checks are performed against the client operating system to ensure the client meets all the connector prerequisites. If you upgrade the client operating system after you install the connector software, some of the prerequisites might not be present, and the client connector might fail.  
  
 **Solution**  
  
 Before you upgrade your client operating system to a different version (for example, you upgrade Windows XP to Windows Vista or Windows Vista to Windows 7), you should uninstall the connector software. Use **Add or remove programs** in Control Panel. After the client operating system upgrade is complete, you can reinstall the client connector by opening http://<*server*>/connect in a Web browser, where <*server*> is the name of the  Windows Server Essentials server.  
  
 If you have already upgraded the client with the connector software installed, use **Add/Remove Programs** or **Programs and Features** to uninstall the connector software. Then install the connector software again.  
  
## See also  
  
-   [Manage Windows Server Essentials](../manage/Manage-Windows-Server-Essentials.md)  
  
-   [Windows 2012 Server Essentials ConnectComputer Troubleshooting (TechNet Wiki)](https://social.technet.microsoft.com/wiki/contents/articles/14370.windows-2012-server-essentials-connectcomputer-troubleshooting.aspx)
