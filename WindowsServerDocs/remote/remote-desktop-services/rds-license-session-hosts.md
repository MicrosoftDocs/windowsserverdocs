---
title: License Remote Desktop session hosts
description: Learn how to install licenses for Remote Desktop session hosts.
ms.topic: article
author: Heidilohr
ms.author: helohr
ms.date: 06/26/2024
manager: femila
---
# License Remote Desktop session hosts

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

You can use the information in this article to configure licensing for session hosts on your Remote Desktop Services (RDS) deployments. The process will be slightly different depending on which roles you've assigned to the session host you're licensing.

## Prerequisites

In order to install licenses for your session hosts, you'll need a Remote Desktop license server with per-user or per-device client access licenses (CALs) activated.

## Configure licensing for an RDS deployment that includes the RD Connection Broker role

If you need to license session hosts where your RDS deployment doesn't include the connection broker role, you'll need to specify a license server by using group policy either centrally from your Active Directory domain or locally on each session host. You'll also need to do specify a license server when using Windows Server with Azure Virtual Desktop.

To specify a license server:

1. On the RD Connection Broker computer, open Server Manager.
2. In Server Manager, select **Remote Desktop Services** > **Overview** > **Edit Deployment Properties** > **RD Licensing**.

   :::image type="content" source="media/rds-license-session-hosts/server-manager-rd-config.png" alt-text="A screenshot of the set up remote desktop services deployment page. The user selects the tasks drop-down menu and selects Edit Deployment Properties.":::

3. Select the Remote Desktop licensing mode (either **Per User** or **Per Device**, as appropriate for your deployment).

   > [!NOTE]  
   > If you use domain-joined servers for your RDS deployment, you can use both Per User and Per Device CALs. If you use workgroup servers for your RDS deployment, you have to use Per Device CALs In that case, Per User CALs are not permitted.

4. Specify a license server, and then select **Add**.

   :::image type="content" source="media/rds-license-session-hosts/rd-licensing-configure.png" alt-text="A screenshot of the configure the deployment page. Two red borders surround the two radio buttons that say per device and per user, and a field for the file path for the license server.":::

## Configure licensing for an RDS deployment that includes only the RD Session Host role and the RD Licensing role

1. Depending on whether you want to configure Group Policy centrally from your domain or locally on each session host:

   - Open the **Group Policy Management Console** (GPMC) and create or edit a policy that targets your session hosts.

   - Open the **Local Group Policy Editor** on the session host.

1. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Licensing**.

   :::image type="content" source="media/rds-license-session-hosts/local-gp-editor-licensing-config.png" alt-text="A screenshot of the list of policies for Remote Desktop licensing. Use the specified Remote Desktop license servers and Set the Remote Desktop licensing mode are highlighted with red borders.":::

1. In the policy list, right-click **Use the specified Remote Desktop license servers**, and then select **Properties**.

1. Select **Enabled**, and then enter the name of the license server under **License servers to use**. If you have more than one license server, use commas to separate their names.

   :::image type="content" source="media/rds-license-session-hosts/local-gp-specify-license-server.png" alt-text="A screenshot of the Use the specified Remote Desktop license servers window. The field labeled License servers to use is highlighted with a red border.":::

1. Select **OK**.  

1. In the policy list, right-click **Set the Remote Desktop licensing mode**, and then select **Properties**.

1. Select **Enabled**.

1. Under **Specify the licensing mode for the Remote Desktop Session Host server**, select **Per Device** or **Per User**, as appropriate for your deployment.

   :::image type="content" source="media/rds-license-session-hosts/local-gp-specify-licensing-mode.png" alt-text="A screenshot of the Set the Remote Desktop licensing mode window. The drop-down menu for specifying the licensing mode for the RD Session Host server is highlighted with a red border.":::

## Ensure an RD Session Host can access an RD licensing server in the same work group 

This section only applies to work groups. Skip this section if your RD Session Host and RD licensing server are joined to a domain in Active Directory. You can also skip this section if the RD licensing server and RD Session Host server are the same machine. 

After the security update known as [CVE-2024-38099](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2024-38099), RD licensing servers enforce that RD Session Host servers present non anonymous credentials when requesting or querying licenses. To enforce , ensure that the _NT AUTHORITY\NETWORK SERVICE_ account under which the Remote Desktop Service runs on the RD Session Host has access to such credentials. Configure the machines in a work group using the following. 

First, we recommend creating a dedicated user on the RD licensing server: 

1. Connect to the RD licensing server. If doing so remotely, you may need to start the Remote Desktop Connection application using the `mstsc.exe /admin` command if the target machine cannot contact any RD licensing server. 

1. Once connected, select Start, Run, type lusrmgr.msc, and then press ENTER. 

1. Select Users in the left pane. 

1. Open the Action menu and select New User… 

1. Choose a username and a unique strong password for the user. 

1. Uncheck the "User must change password at next logon" checkbox. 

1. Select Create. 

Then, on each RD Session Host servers that need to connect to the RD licensing server: 

1. Connect to the RD Session Host machine. If doing so remotely, one may need to start the Remote Desktop Connection application using the mstsc.exe /admin command if the target machine cannot contact any RD licensing server. 

1. Start a Command Prompt as _NT AUTHORITY\NETWORK SERVICE_. For example, using PsExec from the Sysinternals Utilities, this can be achieved as follows: psexec.exe -I -u "NT AUTHORITY\NETWORK SERVICE" cmd.exe. 

1. Then, run cmdkey /add:< NAME-OF-THE-LICENSING-SERVER> /user:< NAME-OF-THE-LICENSING-SERVER>\<USERNAME-SELECTED-ABOVE> /pass. 

1. When prompted for the password, enter the password previously selected and press ENTER. 

The RD Session Host should now be able to connect to the RD licensing server. 

Alternatively, the requirement for proper authentication can be disabled on the licensing server. 
 
> [!WARNING]
> Disabling the enforcement of authentication on the RD licensing server is not recommended and can result in increased security risks. Use it at your own risk. 

If you still would like to disable the enforcement of authentication on your RD licensing server despite the risk, you can set the following registry key and value on the RD licensing server. 

- Key: HKLM\ SYSTEM\CurrentControlSet\Services\TermServLicensing\Parameters 

- Type: REG_DWORD 

- Name: DisableWorkgroupAuthEnforcement 

- Data: 1 

> [!WARNING]
> Future versions of Windows may stop honoring this setting. 

## Next steps

Learn how to create reports to track RDS per-user CALs issued by a Remote Desktop license server at [Track your Remote Desktop Services client access licenses (RDS CALs)](rds-track-cals.md).
