---
title: add Servers to Server manager
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: aab895f2-fe4d-4408-b66b-cdeadbd8969e
---
# add Servers to Server manager
In Windows Server® 2016 Technical Preview, you can manage multiple remote servers by using a single Server manager console. Servers that you want to manage by using Server manager can be running Windows Server 2016 Technical Preview,  Windows Server 2012 R2 ,  Windows Server 2012 ,  Windows Server 2008 R2 , or  Windows Server 2008 . Note that you cannot manage a newer release of Windows Server with an older release of Server manager.

This topic describes how to add servers to the Server manager server pool.

> [!NOTE]
> In our tests, Server manager in  Windows Server 2012  and later releases of Windows Server can be used to manage up to 100 servers that are configured with a typical workload. The number of servers that you can manage by using a single Server manager console can vary depending on the amount of data that you request from managed servers, and hardware and network resources available to the computer running Server manager. As the amount of data you want to display approaches that computer’s resource capacity, you can experience slow responses from Server manager, and delays in the completion of refreshes. To help increase the number of servers that you can manage by using Server manager, we recommend limiting the event data that Server manager gets from your managed servers, by using settings in the **Configure Event Data** dialog box. Configure Event Data can be opened from the **Tasks** menu in the **Events** tile. if you need to manage an enterprise\-level number of servers in your organization, we recommend evaluating products in the [Microsoft® System Center suite](http://go.microsoft.com/fwlink/p/?LinkId=239437).
> 
> Server manager can receive only online or offline status from servers that are running Windows Server 2003. Although you can use Server manager to perform management tasks on servers that are running  Windows Server 2008 R2  or  Windows Server 2008 , you cannot add roles and features to servers that are running  Windows Server 2008 R2 ,  Windows Server 2008  or Windows Server 2003.
> 
> Server manager cannot be used to manage a newer release of the Windows Server operating system. Server manager running on  Windows Server 2012 R2 ,  Windows Server 2012 , Windows 8.1, or Windows 8 cannot be used to manage servers that are running Windows Server 2016 Technical Preview.

This topic contains the following sections.

-   [add servers to manage](#BKMK_add)

-   [Provide credentials with the manage As command](#BKMK_creds)

## <a name="BKMK_creds"></a>Provide credentials with the manage As command
As you add remote servers to Server manager, some of the servers that you add might require different user account credentials to access or manage them. To specify credentials for a managed server that are different from those you use to log on to the computer on which you are running Server manager, use the **manage As** command after you add a server to Server manager, which is accessible by right\-clicking the entry for a managed server in the **Servers** tile of a role or group home page. Clicking **manage As** opens the **Windows Security** dialog box, in which you can provide a user name that has access rights on the managed server, in one of the following formats.

-   *User name*

-   *User name*@example.domain.com

-   *Domain*\\*User name*

The **Windows Security** dialog box that is opened by the **manage As** command cannot accept smart card credentials; providing smart card credentials through Server manager is not supported. Credentials that you provide for a managed server by using the **manage As** command are cached, and persist as long as you are managing the server by using the same computer on which you are currently running Server manager, or as long as you do not overwrite them by specifying blank or different credentials for the same server. if you export your Server manager settings to other computers, or configure your domain profile to be roaming to allow Server manager settings to be used on other computers, **manage As** credentials for servers in your server pool are not stored in the roaming profile. Server manager users must add them on each computer from which they want to manage.

After you add servers to manage by following procedures in this topic, but before you use the **manage As** command to specify alternate credentials that might be required to manage a server that you have added, the following manageability status errors can be displayed for the server:

-   Kerberos target resolution error

-   Kerberos authentication error

-   online \- Access denied

> [!NOTE]
> Roles and features that do not support the **manage As** command include remote Desktop Services \(rdS\) and IP address management \(IPAM\) Server. if you cannot manage the remote rdS or IPAM server by using the same credentials you are using on the computer on which you are running Server manager, try adding the account you typically use to manage these remote servers to the Administrators group on the computer that is running Server manager. Then, log on to the computer that is running Server manager with the account you use to manage the remote server that is running rdS or IPAM.

## <a name="BKMK_add"></a>add servers to manage
You can add servers to Server manager to manage by using any of three methods in the **add Servers** dialog box.

-   **active directory® Domain Services** add servers to manage that active directory finds in the same domain as the local computer.

-   **Domain Name System \(DNS\) entry** Search for servers to manage by computer name or IP address.

-   **import multiple servers** Specify multiple servers to import in a file that contains servers listed by computer name or IP address.

#### To add servers to the server pool

1.  if Server manager is already open, go on to the next step. if Server manager is not already open, open it by doing one of the following.

    -   On the Windows desktop, start Server manager by clicking **Server manager** in the Windows taskbar.

    -   On the Windows **start** screen, click the Server manager tile.

2.  On the **manage** menu, click **add Servers**.

3.  Do one of the following.

    -   On the **active directory** tab, select servers that are in the current domain. Press **Ctrl** while selecting to select multiple servers. Click the right\-arrow button to move selected servers to the **selected** list.

    -   On the **DNS** tab, type the first few characters of a computer name or IP address, and then press **Enter** or click **Search**. select servers that you want to add, and then click the right\-arrow button.

    -   On the **import** tab, browse for a text file that contains the DNS names or IP addresses of computers that you want to add, one name or IP address per line.

4.  When you are finished adding servers, click **OK**.

### add and manage servers in workgroups
Although adding servers that are in workgroups to Server manager might be successful, after they are added, the **manageability** column of the **Servers** tile—on a role or group page that includes a workgroup server—can display **Credentials not valid** errors that occur while trying to connect to or collect data from the remote, workgroup server.

These or similar errors can occur in the following conditions.

-   The managed server is in the same workgroup as the computer that is running Server manager.

-   The managed server is in a different workgroup from the computer that is running Server manager.

-   One of the computers is in a workgroup, while the other is in a domain.

-   The computer that is running Server manager is in a workgroup, and remote, managed servers are on a different subnet.

-   Both computers are in domains, but there is no trust relationship between the two domains.

-   Both computers are in domains, but there is only a one\-way trust relationship between the two domains.

-   The server you want to manage has been added by using its IP address.

##### To add remote workgroup servers to Server manager

1.  On the computer that is running Server manager, add the workgroup server name to the **TrustedHosts** list. This is a requirement of NTLM authentication. To add a computer name to an existing list of trusted hosts, add the `Concatenate` parameter to the command. for example, to add the `Server01` computer to an existing list of trusted hosts, use the following command.

    ```
    Set-Item wsman:\localhost\Client\TrustedHosts Server01 -Concatenate -force
    ```

2.  Determine whether the workgroup server that you want to manage is in the same subnet as the computer on which you are running Server manager.

    if the two computers are in the same subnet, or if the workgroup server’s network profile is set to **Private** in the **Network and Sharing Center**, go on to the next step.

    if they are not in the same subnet, or if the workgroup server’s network profile is not set to **Private**, on the workgroup server, change the inbound **Windows remote management \(HTTP\-In\)** setting in Windows Firewall to explicitly allow connections from remote computers by adding the computer names on the **computers** tab of the setting’s **Properties** dialog box.

3.  > [!importANT]
    > Running the cmdlet in this step overrides User Account Control \(UAC\) measures that prevent elevated processes from running on workgroup computers unless the built\-in Administrator or the System account is running the processes. The cmdlet lets members of the Administrators group manage the workgroup server without logging on as the built\-in Administrator. Allowing additional users to manage the workgroup server can reduce its security; however, this is more secure than providing built\-in Administrator account credentials to what might be multiple people who are managing the workgroup server.

    To override UAC restrictions on running elevated processes on workgroup computers, create a registry entry called **LocalAccountTokenFilterPolicy** on the workgroup server by running the following cmdlet.

    ```
    New-ItemProperty -Name LocalAccountTokenFilterPolicy -path HKLM:\SOFTWARE\Microsoft\Windows\Currentversion\Policies\System -propertytype DWord -value 1
    ```

4.  On the computer on which you are running Server manager, open the **All Servers** page.

5.  if the computer that is running Server manager and the target workgroup server are in the same workgroup, skip to the last step. if the two computers are not in the same workgroup, right\-click the target workgroup server in the **Servers** tile, and then click **manage as**.

6.  Log on to the workgroup server by using the built\-in Administrator account for the workgroup server.

7.  verify that Server manager is able to connect to and collect data from the workgroup server by refreshing the **All Servers** page, and then viewing the manageability status for the workgroup server.

##### To add remote servers when Server manager is running on a workgroup computer

1.  On the computer that is running Server manager, add remote servers to the local computer’s **TrustedHosts** list in a Windows powershell session. To add a computer name to an existing list of trusted hosts, add the `Concatenate` parameter to the command. for example, to add the `Server01` computer to an existing list of trusted hosts, use the following command.

    ```
    Set-Item wsman:\localhost\Client\TrustedHosts Server01 -Concatenate -force
    ```

2.  Determine whether the server that you want to manage is in the same subnet as the workgroup computer on which you are running Server manager.

    if the two computers are in the same subnet, or if the workgroup computer’s network profile is set to **Private** in the **Network and Sharing Center**, go on to the next step.

    if they are not in the same subnet, or if the workgroup computer’s network profile is not set to **Private**, on the workgroup computer that is running Server manager, change the inbound **Windows remote management \(HTTP\-In\)** setting in Windows Firewall to explicitly allow connections from remote computers by adding the computer names on the **computers** tab of the setting’s **Properties** dialog box.

3.  On the computer on which you are running Server manager, open the **All Servers** page.

4.  verify that Server manager is able to connect to and collect data from the remote server by refreshing the **All Servers** page, and then viewing the manageability status for the remote server. if the **Servers** tile still displays a manageability error for the remote server, go on to the next step.

5.  Log off of the computer on which you are running Server manager, and then log on again by using the built\-in Administrator account. Repeat the preceding step, to verify that Server manager is able to connect to and collect data from the remote server.

if you have followed the procedures in this section, and you continue to have problems managing workgroup computers, or managing other computers from workgroup computers, see [about_remote_Troubleshooting](http://technet.microsoft.com/library/dd347642.aspx) on the Microsoft website.

### add and manage servers in clusters
You can use Server manager to manage servers that are in failover clusters \(also called server clusters or MSCS\). Servers that are in failover clusters—whether the cluster nodes are physical or virtual—have some unique behaviors and management limitations in Server manager.

-   Both physical and virtual servers in clusters are automatically added to Server manager when one server in the cluster is added to Server manager. Similarly, when you remove a clustered server from Server manager, you are prompted to remove other servers in the cluster.

-   Server manager does not display data for clustered virtual servers, because the data is dynamic, and is identical to data for the server on which the virtual clustered node is hosted. You can select the server that is hosting the virtual server to view its data.

-   if you add a server to Server manager by using the server’s virtual cluster object name, the virtual object name is displayed in Server manager instead of the physical server name \(expected\).

-   You cannot install roles and features on a clustered virtual server.

## See Also
[Server manager_1](server-manager_1.md)
[create and manage Server Groups](create-manage-server-groups.md)


