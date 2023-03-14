---
title: License Remote Desktop session hosts
description: Learn how to install licenses for Remote Desktop session hosts.
ms.topic: article
author: Heidilohr
ms.author: helohr
ms.date: 02/22/2023
manager: femila
---
# License Remote Desktop session hosts

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

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

## Next steps

Learn how to create reports to track RDS per-user CALs issued by a Remote Desktop license server at [Track your Remote Desktop Services client access licenses (RDS CALs)](rds-track-cals.md).
