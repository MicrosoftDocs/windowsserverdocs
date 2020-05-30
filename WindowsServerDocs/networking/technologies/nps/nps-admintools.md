---
title: Network Policy Server Management with Administration Tools
description: You can use this topic to learn about the tools that you can use to manage Network Policy Server in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 5de80dc0-53be-42b7-8e5b-24d213bf2b25
ms.author: lizross 
author: eross-msft
---
# Network Policy Server Management with Administration Tools

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn about the tools that you can use to manage your NPSs.

After you install NPS, you can administer NPSs:

- Locally, by using the NPS Microsoft Management Console \(MMC\) snap-in, the static NPS console in Administrative Tools, Windows PowerShell commands, or the Network Shell \(Netsh\) commands for NPS.
- From a remote NPS, by using the NPS MMC snap-in, the Netsh commands for NPS, the Windows PowerShell commands for NPS, or Remote Desktop Connection.
- From a remote workstation, by using Remote Desktop Connection in combination with other tools, such as the NPS MMC or Windows PowerShell.

>[!NOTE]
>In Windows Server 2016, you can manage the local NPS by using the NPS console. To manage both remote and local NPSs, you must use the NPS MMC snap\-in.

The following sections provide instructions on how to manage your local and remote NPSs.

## Configure the Local NPS by Using the NPS Console

After you have installed NPS, you can use this procedure to manage the local NPS by using the NPS MMC.

**Administrative Credentials** 

To complete this procedure, you must be a member of the Administrators group.

### To configure the local NPS by using the NPS console

1. In Server Manager, click **Tools**, and then click **Network Policy Server**. The NPS console opens.

2. In the NPS console, click NPS \(Local\). In the details pane, choose either **Standard Configuration** or **Advanced Configuration**, and then do one of the following based upon your selection:
	- If you choose **Standard Configuration**, select a scenario from the list, and then follow the instructions to start a configuration wizard.
	- If you choose **Advanced Configuration**, click the arrow to expand **Advanced Configuration options**, and then review and configure the available options based on the NPS functionality that you want - RADIUS server, RADIUS proxy, or both.

## Manage Multiple NPSs by Using the NPS MMC Snap\-in

You can use this procedure to manage the local NPS and multiple remote NPSs by using the NPS MMC snap\-in.

Before performing the procedure below, you must install NPS on the local computer and on remote computers.

Depending on network conditions and the number of NPSs you manage by using the NPS MMC snap\-in, response of the MMC snap\-in might be slow. In addition, NPS configuration traffic is sent over the network during a remote administration session by using the NPS snap\-in. Ensure that your network is physically secure and that malicious users do not have access to this network traffic.

**Administrative Credentials** 

To complete this procedure, you must be a member of the Administrators group.

### To manage multiple NPSs by using the NPS snap\-in

1. To open the MMC, run Windows PowerShell as an Administrator. In Windows PowerShell, type **mmc**, and then press ENTER. The Microsoft Management Console opens.
2. In the MMC, on the **File** menu, click **Add/Remove Snap\-in**. The **Add or Remove Snap\-ins** dialog box opens.
3. In **Add or Remove Snap\-ins**, in **Available snap\-ins**, scroll down the list, click **Network Policy Server**, and then click **Add**. The **Select Computer** dialog box opens.
4. In **Select Computer**, verify that **Local computer \(the computer on which this console is running\)** is selected, and then click **OK**. The snap\-in for the local NPS is added to the list in **Selected snap\-ins**.
5. In **Add or Remove Snap\-ins**, in **Available snap\-ins**, ensure that **Network Policy Server** is still selected, and then click **Add**. The **Select Computer** dialog box opens again.
6. In **Select Computer**, click **Another computer**, and then type the IP address or fully qualified domain name \(FQDN\) of the remote NPS that you want to manage by using the NPS snap\-in. Optionally, you can click **Browse** to peruse the directory for the computer that you want to add. Click **OK**.
7. Repeat steps 5 and 6 to add more NPSs to the NPS snap\-in. When you have added all the NPSs you want to manage, click **OK**.
8. To save the NPS snap-in for later use, click **File**, and then click **Save**. In the **Save As** dialog box, browse to the hard disk location where you want to save the file, type a name for your Microsoft Management Console \(.msc\) file, and then click **Save**. 

## Manage an NPS by Using Remote Desktop Connection

You can use this procedure to manage a remote NPS by using Remote Desktop Connection.

By using Remote Desktop Connection, you can remotely manage your NPSs running Windows Server 2016. You can also remotely manage NPSs from a computer running Windows 10 or earlier Windows client operating systems.

You can use Remote Desktop connection to manage multiple NPSs by using one of two methods.

1. Create a Remote Desktop connection to each of your NPSs individually.
2. Use Remote Desktop to connect to one NPS, and then use the NPS MMC on that server to manage other remote servers. For more information, see the previous section **Manage Multiple NPSs by Using the NPS MMC Snap\-in**.

**Administrative Credentials** 

To complete this procedure, you must be a member of the Administrators group on the NPS.

### To manage an NPS by using Remote Desktop Connection

1. On each NPS that you want to manage remotely, in Server Manager, select **Local Server**. In the Server Manager details pane, view the **Remote Desktop** setting, and do one of the following. 
	1. If the value of the **Remote Desktop** setting is **Enabled**, you do not need to perform some of the steps in this procedure. Skip down to Step 4 to start configuring Remote Desktop User permissions.
	2. If the **Remote Desktop** setting is **Disabled**, click the word **Disabled**. The **System Properties** dialog box opens on the **Remote** tab.
2. In **Remote Desktop**, click **Allow remote connections to this computer**. The **Remote Desktop Connection** dialog box opens. Do one of the following.
	1. To customize the network connections that are allowed, click **Windows Firewall with Advanced Security**, and then configure the settings that you want to allow. 
	2. To enable Remote Desktop Connection for all network connections on the computer, click **OK**.
3. In **System Properties**, in **Remote Desktop**, decide whether to enable **Allow connections only from computers running Remote Desktop with Network Level Authentication**, and make your selection.
4. Click **Select Users**. The **Remote Desktop Users** dialog box opens.
5. In **Remote Desktop Users**, to grant permission to a user to connect remotely to the NPS, click **Add**, and then type the user name for the user's account. Click **OK**.
6. Repeat step 5 for each user for whom you want to grant remote access permission to the NPS. When you're done adding users, click **OK** to close the **Remote Desktop Users** dialog box and **OK** again to close the **System Properties** dialog box.
7. To connect to a remote NPS that you have configured by using the previous steps, click **Start**, scroll down the alphabetical list and then click **Windows Accessories**, and click **Remote Desktop Connection**. The **Remote Desktop Connection** dialog box opens.
8. In the **Remote Desktop Connection** dialog box, in **Computer**, type the NPS name or IP address. If you prefer, click **Options**, configure additional connection options, and then click **Save** to save the connection for repeated use.
9. Click **Connect**, and when prompted provide user account credentials for an account that has permissions to log on to and configure the NPS.

## Use Netsh NPS commands to manage an NPS

You can use commands in the Netsh NPS context to show and set the configuration of the authentication, authorization, accounting, and auditing database used both by NPS and the Remote Access service. Use commands in the Netsh NPS context to:

- Configure or reconfigure an NPS, including all aspects of NPS that are also available for configuration by using the NPS console in the Windows interface.
- Export the configuration of one NPS (the source server), including registry keys and the NPS configuration store, as a Netsh script.
- Import the configuration to another NPS by using a Netsh script and the exported configuration file from the source NPS.

You can run these commands from the Windows Server 2016 Command Prompt or from Windows PowerShell. You can also run netsh nps commands in scripts and batch files.

**Administrative Credentials** 

To perform this procedure, you must be a member of the Administrators group on the local computer.

### To enter the Netsh NPS context on an NPS

1. Open Command Prompt or Windows PowerShell.
2. Type **netsh**, and then press ENTER.
3. Type **nps**, and then press ENTER.
4. To view a list of available commands, type a question mark \(?\) and press ENTER.


For more information about Netsh NPS commands, see [Netsh Commands for Network Policy Server in Windows Server 2008](https://technet.microsoft.com/library/cc754428(v=ws.10).aspx), or download the entire [Netsh Technical Reference](https://gallery.technet.microsoft.com/Netsh-Technical-Reference-c46523dc?redir=0) from TechNet Gallery. This download is the full Network Shell Technical Reference for Windows Server 2008 and Windows Server 2008 R2. The format is Windows Help \(*.chm\) in a zip file. These commands are still present in Windows Server 2016 and Windows 10, so you can use netsh in these environments, although using Windows PowerShell is recommended.

## Use Windows PowerShell to manage NPSs

You can use Windows PowerShell commands to manage NPSs. For more information, see the following Windows PowerShell command reference topics.

- [Network Policy Server (NPS) Cmdlets in Windows PowerShell](https://technet.microsoft.com/library/jj872739(v=wps.630).aspx). You can use these netsh commands in Windows Server 2012 R2 or later operating systems.
- [NPS Module](https://technet.microsoft.com/itpro/powershell/windows/nps/index). You can use these netsh commands in Windows Server 2016.

For more information about NPS administration, see [Manage Network Policy Server (NPS)](nps-manage-top.md).
