---
title: Install licenses for Remote Desktop session hosts
description: Learn how to install licenses for Remote Desktop session hosts.
ms.topic: article
author: Heidilohr
ms.author: helohr
ms.date: 09/20/2016
manager: femila
---
# Install licenses for Remote Desktop session hosts

>Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can use the information in this article to configure licensing for session hosts on your Remote Desktop Services (RDS) deployments. The process will be slightly different depending on which roles you've assigned to the session host you're licensing.

## Configure licensing for an RDS deployment that includes the RD Connection Broker role

1. On the RD Connection Broker computer, open Server Manager.
1. In Server Manager, select **Remote Desktop Services** > **Overview** > **Edit Deployment Properties** > **RD Licensing**.

   :::image type="content" source="media/rds-license-session-hosts/server-manager-rd-config.png" alt-text="Select the Edit Deployment Properties option to open the Remote Desktop licensing settings in Server Manager.":::

1. Select the Remote Desktop licensing mode (either **Per User** or **Per Device**, as appropriate for your deployment).

   > [!NOTE]  
   > If you use domain-joined servers for your RDS deployment, you can use both Per User and Per Device CALs. If you use workgroup servers for your RDS deployment, you have to use Per Device CALs In that case, Per User CALs are not permitted.

1. Specify a license server, and then select **Add**.

   :::image type="content" source="media/rds-license-session-hosts/rdlicensing-configure.png" alt-text="Configure the deployment of the RD Licensing.":::

## Configure licensing for an RDS deployment that includes only the RD Session Host role and the RD Licensing role

1. On the RD Session Host computer, select **Start**, and then enter **gpedit.msc** to open Local Group Policy Editor.

1. Go to **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Licensing**.

   :::image type="content" source="media/rds-license-session-hosts/local-gp-editor-licensing-config.png" alt-text="List of policies for Remote Desktop licensing.":::

1. In the policy list, right-click **Use the specified Remote Desktop license servers**, and then select **Properties**.

1. Select **Enabled**, and then enter the name of the license server under **License servers to use**. If you have more than one license server, use commas to separate their names.

   :::image type="content" source="media/rds-license-session-hosts/local-gp-specify-license-server.png" alt-text="Set the license servers to use in the Use the specified Remote Desktop license servers dialog box.":::

1. Select **OK**.  

1. In the policy list, right-click **Set the Remote Desktop licensing mode**, and then select **Properties**.

1. Select **Enabled**.

1. Under **Specify the licensing mode for the Remote Desktop Session Host server**, select **Per Device** or **Per User**, as appropriate for your deployment.

   :::image type="content" source="media/rds-license-session-hosts/local-gp-specify-licensing-mode.png" alt-text="Specify the licensing mode for the Remote Desktop Session Host server in the Set the Remote Desktop licensing mode dialog box.":::