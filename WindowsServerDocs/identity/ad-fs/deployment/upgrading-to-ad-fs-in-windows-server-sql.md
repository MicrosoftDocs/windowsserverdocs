---
title: Upgrade to AD FS on Windows Server 2016 with SQL Server
description: Upgrade to AD FS on Windows Server 2016 with SQL Server, including joining a farm and raising the FBL level.
ms.date: 05/24/2024
ms.topic: upgrade-and-migration-article
ms.custom: sfi-image-nochange
---

# Upgrade to AD FS in Windows Server 2016 with SQL Server

[!INCLUDE [Migrate to Azure AD](../../../../includes/adfs-to-azure-ad-upgrade.md)]

> [!NOTE]
> Only begin an upgrade with a definitive time frame planned for completion. It isn't recommended to keep AD FS in a mixed mode state for an extended period of time, as leaving AD FS in a mixed mode state may cause issues with the farm.

## Move Windows Server 2012 R2 AD FS farm to Windows Server 2016 AD FS farm

This article describes how to upgrade your AD FS Windows Server 2012 R2 farm to AD FS in Windows Server 2016. The steps apply when you use a SQL Server for the AD FS database.

### Upgrade AD FS to Windows Server 2016 FBL

New in AD FS for Windows Server 2016 is the farm behavior level feature (FBL). This feature is farm wide and determines the features that the AD FS farm can use. By default, the FBL in a Windows Server 2012 R2 AD FS farm is at the Windows Server 2012 R2 FBL.

A Windows Server 2016 AD FS server can be added to a Windows Server 2012 R2 farm and it operates at the same FBL as a Windows Server 2012 R2. For a Windows Server 2016 AD FS server operating in this fashion, your farm is said to be "mixed." However, the new Windows Server 2016 features aren't available until the FBL is raised to Windows Server 2016. 

Here are some of the significant features of working with a mixed farm:

- Administrators can add new Windows Server 2016 federation servers to an existing Windows Server 2012 R2 farm. As a result, the farm is in "mixed mode" and operates the Windows Server 2012 R2 farm behavior level. To ensure consistent behavior across the farm, new Windows Server 2016 features can't be configured or used in this mode.

- Administrators can remove all Windows Server 2012 R2 federation servers from the mixed mode farm. In this scenario, one of the new Windows Serve 2016 federation servers is promoted to the role of primary node. The administrator can then raise the FBL from Windows Server 2012 R2 to Windows Server 2016. As a result, any new AD FS Windows Server 2016 features can then be configured and used.

- AD FS Windows Server 2012 R2 organizations that want to upgrade to Windows Server 2016 don't have to deploy an entirely new farm or export and import configuration data. Instead, they can add Windows Server 2016 nodes to an existing farm while it's online and only incur the relatively brief downtime involved in the FBL raise.

In mixed farm mode, the AD FS farm isn't capable of any new features or functionality introduced in AD FS in Windows Server 2016. Organizations that want to try out new features can do so after the FBL is raised. If your organization is looking to test the new features before raising the FBL, you need to deploy a separate farm.

The remainder of the article provides the steps for adding a Windows Server 2016 federation server to a Windows Server 2012 R2 environment. These steps were performed in a test environment outlined by the following architectural diagram.

> [!NOTE]
> Before you can move to AD FS in Windows Server 2016 FBL, you must remove all of the Windows 2012 R2 nodes. You can't upgrade a Windows Server 2012 R2 OS to Windows Server 2016 and have it automatically become a 2016 node. You need to remove it and replace it with a new 2016 node.
>
> If AlwaysOnAvailability groups or merge replication are configured in AD FS, remove all replication of any AD FS databases before you upgrade and point all nodes to the Primary SQL database. After you complete these tasks, perform the farm upgrade as described. After you complete the upgrade, add AlwaysOnAvailability groups or merge replication to the new databases.

The following architectural diagram shows the setup that was used to validate and record the following steps.

:::image type="content" source="media/Upgrading-to-AD-FS-in-Windows-Server-2016-SQL/arch.png" alt-text="Diagram that shows the architecture set up for the procedure described in this article.":::

#### Join Windows 2016 AD FS Server to AD FS farm

1. In **Server Manager**, install the Active Directory Federation Services Role on the Windows Server 2016.

1. In the **AD FS Configuration wizard**, join the new Windows Server 2016 server to the existing AD FS farm.

1. On the **Welcome** screen, select **Add a federation server to a federation server farm**, then select **Next**.


1. On the **Connect to Active Directory Domain Services** screen, **specify an administrator account** with permissions to perform the federation services configuration, and select **Next**.

1. On the **Specify Farm** screen, enter the name of the SQL server and instance and then select **Next**.

   :::image type="content" source="media/Upgrading-to-AD-FS-in-Windows-Server-2016-SQL/configure3.png" alt-text="Screenshot that shows the Specify Farm screen in the AD FS Configuration wizard.":::

1. On the **Specify SSL Certificate** screen, specify the certificate, and select **Next**.

   :::image type="content" source="media/Upgrading-to-AD-FS-in-Windows-Server-2016-SQL/configure4.png" alt-text="Screenshot that shows how to specify the certificate to join the farm.":::

1. On the **Specify Service Account** screen, specify the service account, and select **Next**.

1. On the **Review Options** screen, review the options and select **Next**.

1. On the **Pre-requisites Checks** screen, ensure all prerequisite checks passed, and then select **Configure**.

1. On the **Results** screen, ensure the server is successfully configured, and then select **Close**.

#### Remove Windows Server 2012 R2 AD FS server

The following steps remove the Windows Server 2012 R2 AD FS server.

> [!NOTE]
> You don't need to set the primary AD FS server with the `Set-AdfsSyncProperties -Role` command when you use SQL as the database. All of the nodes are considered primary in this configuration.

1. In **Server Manager**, go to the Windows Server 2012 R2 AD FS server. Under **Manage**, select **Remove Roles and Features**:

   :::image type="content" source="media/Upgrading-to-AD-FS-in-Windows-Server-2016-SQL/remove1.png" alt-text="Screenshot that shows how to remove roles and features.":::

1. On the **Before you Begin** screen, select **Next**, and on the **Server Selection** Screen, select **Next**.

1. On the **Server Roles** screen, uncheck the **Active Directory Federation Services** option, and select **Next**.

   :::image type="content" source="media/Upgrading-to-AD-FS-in-Windows-Server-2016-SQL/remove2.png" alt-text="Screenshot that shows how to remove the server by deselecting the Active Directory Federation Services option.":::

1. On the **Features** Screen, select **Next**.

1. On the **Confirmation** Screen, select **Remove**.

1. After feature removal is complete, restart the server.

#### Raise Farm Behavior Level (FBL)

The following steps raise the FBL for the server.

> [!IMPORTANT]
> Before you continue with the process in this section, review the following prerequisites:
>
> - Ensure the preparation processes for the forest and domain are complete on your Active Directory environment and that Active Directory has the Windows Server 2016 schema. The procedure described in this article is based on an architecture that started with a Windows 2016 domain controller. The example architecture doesn't require the steps in this section because the tasks are included with the AD installation process.
>
> - Ensure Windows Server 2016 is current by running **Windows Update from Settings**. Continue the update process until no further updates are needed.
> 
> - Ensure your AD FS service account account has the administrative permissions on the SQL server and each server in the ADFS farm.

1. On the Windows Server 2016 Server, open PowerShell and run the following command:

   ```powershell
   $cred = Get-Credential
   ```

1. Enter credentials with admin privileges on the SQL Server.

1. In PowerShell, enter the following command:

   ```powershell
   Invoke-AdfsFarmBehaviorLevelRaise -Credential $cred
   ```

1. At the prompt, select **Y** (yes) to begin raising the level. After the operation completes, you successfully raised the FBL.

   :::image type="content" source="media/Upgrading-to-AD-FS-in-Windows-Server-2016-SQL/finish1.png" alt-text="Screenshot that shows how to begin raising the FBL level and finish the update process.":::

   If you go to AD FS Management, you see the new nodes.

1. You can use the PowerShell cmdlet `Get-AdfsFarmInformation` to show you the current FBL:

   :::image type="content" source="media/Upgrading-to-AD-FS-in-Windows-Server-2016-SQL/finish2.png" alt-text="Screenshot that shows how to use the Get-AdfsFarmInformation cmdlet to show your current FBL.":::

#### Upgrade configuration version of existing WAP servers

1. On each Web Application Proxy, reconfigure the WAP by executing the following PowerShell command in an elevated window:

   ```powershell
   $trustcred = Get-Credential -Message "Enter Domain Administrator credentials"
   Install-WebApplicationProxy -CertificateThumbprint {SSLCert} -fsname fsname -FederationServiceTrustCredential $trustcred
   ```

1. Run the following command to remove old servers from the cluster and keep only the WAP servers running the latest server version (reconfigured earlier):

   ```powershell
   Set-WebApplicationProxyConfiguration -ConnectedServersName WAPServerName1, WAPServerName2
   ```

1. Run the following command to check the WAP configuration. The `ConnectedServersName` value reflects the server run from the prior command:

   ```powershell
   Get-WebApplicationProxyConfiguration
   ```

1. To upgrade the `ConfigurationVersion` of the WAP servers, run the following PowerShell command:

   ```powershell
   Set-WebApplicationProxyConfiguration -UpgradeConfigurationVersion
   ```

1. Run the `Get-WebApplicationProxyConfiguration` command again and verify the `ConfigurationVersion` is upgraded.
