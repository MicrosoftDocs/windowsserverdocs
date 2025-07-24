---
title: Add or Remove Roles and Features in Windows Server
description: Learn how to add or remove roles and features in Windows Server on local, remote servers, or offline virtual hard disks (VHDs), including to multiple servers concurrently. Get step-by-step guidance.
ms.topic: install-set-up-deploy
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 06/09/2025
---

# Add or remove roles and features in Windows Server

In Windows Server, the Server Manager console and Windows PowerShell cmdlets for Server Manager enable you to add roles and features to a local or remote server, or offline virtual hard disk (VHD). You can add multiple roles and features at the same time. This article describes how to add or remove roles and features in Windows Server, including multiple servers concurrently.

For more information about what roles and features are available in Windows Server, see [Comparison of Windows Server editions](../../get-started/editions-comparison.md).

## Prerequisites

Before you add or remove roles, role services, and features, ensure that you meet the following prerequisites:

- Use a user account that's an administrator. You also need to be an administrator on any remote servers that you're managing by using Server Manager, or offline VHDs that you're mounting.

- Review and understand any dependencies or prerequisites specific to the roles or features you plan to add, as some roles might require extra configuration or services to function correctly. For more information, see [Configure Features on Demand in Windows Server](configure-features-on-demand-in-windows-server.md).

- Provide the installation media or an alternate source path for the files that are required to add certain features, such as .NET Framework 3.5.

- To add roles and features on remote servers, add them to Server Manager. For more information about how to add servers to Server Manager, see [Add Servers to Server Manager](add-servers-to-server-manager.md).

- To add roles and features to an offline VHD, the target VHD must meet the following requirements:

  - The VHD must be running the release of Windows Server that matches the version of the server the VHD are mounted to.
  - Ensure the VHD files aren't in use by other processes or mounted elsewhere.
  - The VHD can't have more than one system volume or partition.
  - For a VHD stored on a network shared folder, you must grant **Read** and **Write** permissions to the computer (or local system) account of server that you select to mount the VHD. User-only account access isn't sufficient.

> [!NOTE]
>
> - You can add roles and features on remote servers with Server Manager on same version of Windows Server or earlier. This requirement includes using the equivalent Windows client version with Remote Server Administration Tools (RSAT). For example, Windows Server 2025 can also add roles and features on Windows Server 2022, but Windows Server 2022 can't add roles and features on Windows Server 2025.
>
> - This article doesn't cover adding Remote Desktop Services (RDS) roles, which has a different installation process in Server Manager. For more information about adding RDS roles, see [Deploy a Remote Desktop Services environment](../../remote/remote-desktop-services/rds-deploy-infrastructure.md).

## Add roles and features to Windows Server

You can add roles and features on a local server, a remote server that is added to Server Manager, or an offline VHD, using the **Add Roles and Features Wizard** in Server Manager, or by using Windows PowerShell cmdlets.

Select the relevant tab.

### [Roles and Features Wizard](#tab/gui)

To add roles and features using the Roles and Features Wizard in Server Manager, follow these steps:

1. Open the Start menu, type **Server Manager**, then open **Server Manager**.

1. Select **Manage** in the top-right corner, then select **Add Roles and Features**. The **Add Roles and Features Wizard** opens.

1. For **Before You Begin**, review the information, then select **Next**.

1. For **Installation Type**, select **Role-based or feature-based installation**, then select **Next**. Use this option to add all roles and feature except Remote Desktop Services. For more information about adding RDS roles, see [Deploy a Remote Desktop Services environment](../../remote/remote-desktop-services/rds-deploy-infrastructure.md).

1. For **Server Selection**, select the server you want to add roles and features on. You can choose the local server or a remote server that is added to Server Manager. If you want to add roles and features on an offline VHD, select **Select a virtual hard disk**, select the server on which to mount the VHD, then browse or enter its file path. Select **Next**.

1. For **Server Roles**, select the roles you want to add. You don't have to select any roles if you only want to add a feature. Once you made your role selections, select **Next**.

   As you proceed, the wizard automatically informs you if conflicts are found on the destination server that can prevent adding selected roles or features or normal operation. You're also prompted to add any other roles and features that the roles or features that you select require.

   If you plan to manage the role remotely, either from another server, or from a Windows client-based computer that is running Remote Server Administration Tools (RSAT), you can opt not to install management tools and snap-ins for roles on the destination server. By default, management tools are added.

1. For **Features**, select the roles you want to add. You don't have to select any features if you only want to add a role. Once you made your feature selections, select **Next**.

1. For **Confirmation**, review the roles and features you selected. Once you're ready, select **Install**. Some roles and features require you to restart the server after installation. Check the box **Restart the destination server automatically if required** if you want the server to restart automatically after installation.

   > [!TIP]
   > If you need to specify the installation source files, select **Specify an alternate source path**. You can also specify a Windows Imaging (WIM) file in the following format, with `WIM` as a prefix, and the index in which the feature files are located as a suffix, for example `WIM:e:\sources\install.wim:4`. However, you can't use a WIM file directly as a source for adding roles and features to an offline VHD. You must either mount the offline VHD and point to its mount path for source files, or you must point to a folder that contains a copy of the contents of the WIM file. The source path or file share must grant **Read** permissions to the computer account of the destination server; granting user account access isn't sufficient. For more information on listing the indexes in a WIM file, see [List images that are contained in a WIM or VHD file](/windows-hardware/manufacture/desktop/take-inventory-of-an-image-or-component-using-dism#list-images-that-are-contained-in-a-wim-or-vhd-file).
   >
   > You can also export your selections to an XML-based configuration file that you can use for unattended installations with Windows PowerShell. To export the configuration you specified, select **Export configuration settings**, then save the XML file to a convenient location. You can find the steps to use this configuration file in the section [Add roles and features on multiple servers](#add-roles-and-features-on-multiple-servers).

1. Once the installation is complete, select **Close**.

### [Windows PowerShell](#tab/powershell)

To add roles and features using the [Windows PowerShell module for Server Manager](/powershell/module/servermanager/), follow these steps. Be sure to replace any `<placeholder>` values with your own.

1. Open a PowerShell session as an administrator.

1. Run the following command to get a list of all the roles and features available in Windows Server:

   ```powershell
   Get-WindowsFeature
   ```

   If you want to check roles and features on a remote server, use the `-ComputerName` parameter. You can use this parameter even if the remote server isn't added to Server Manager.

   ```powershell
   Get-WindowsFeature -ComputerName <ComputerName>
   ```

1. Run the following commands to add a role or feature with the `Install-WindowsFeature` cmdlet. You need to specify the name of one or more roles or features you want to add, as shown in the following examples. You can find the complete documentation for the cmdlet at [Install-WindowsFeature](/powershell/module/servermanager/install-windowsfeature).

   > [!TIP]
   >
   > - Management tools and snap-ins for a role aren't included by default. To include management tools as part of a role installation, add the `-IncludeManagementTools` parameter to the cmdlet. If you're adding roles and features on a server that is running the Server Core installation option of Windows Server, you can add a role's management tools to an installation, but GUI-based management tools and snap-ins aren't installed. Only command-line and Windows PowerShell management tools are installed.
   >
   > - If the role or feature you add needs the server to be restarted to complete the installation, add the `-Restart` parameter to restart automatically without prompting.

   - To add DNS and DHCP roles on the local server, including management tools, run the following command:

     ```powershell
     Install-WindowsFeature -Name DNS,DHCP -IncludeManagementTools
     ```

   - To add DNS and DHCP roles and features on an offline VHD, add the `-Vhd` parameter. The cmdlet assumes you want to mount the VHD to the local computer. Alternatively, also add the `-ComputerName` parameter and with the name of the server on which to mount the VHD. You must add the `-ComputerName` parameter if you're running the cmdlet from a computer that is running a Windows client operating system.

     ```powershell
     Install-WindowsFeature -Name DNS,DHCP -Vhd <Path> -ComputerName <ComputerName>
     ```

   The output of the cmdlet shows the result of the installation, as shown in the following example. If the value for the parameter `Restart Needed` is `Yes`, restart the server to complete the installation.

   ```output
   Success Restart Needed Exit Code      Feature Result
   ------- -------------- ---------      --------------
   True    No             Success        {DHCP Server, DNS Server}
   ```

1. You can get a list of all the installed roles and features by running the following command:

   ```powershell
   Get-WindowsFeature | ? Installed -eq $true
   ```

### Add roles and features on multiple servers

You can't use the **Add Roles and Features Wizard** on more than one target server in a single wizard session. However, you can use Windows PowerShell add roles and features on multiple target servers concurrently. You must already add these servers to Server Manager.

Using the Install-WindowsFeature cmdlet, you can specify an XML configuration file that contains the roles and features that you want installed on multiple servers. This configuration file is created using the **Add Roles and Features Wizard**

> [!IMPORTANT]
> All target servers that you specify must be running the same version of Windows Server or related Windows client operating system on which you run Server Manager.

To add roles and features on multiple servers:

1. Create an XML configuration file that contains the roles and features that you want installed on multiple servers, as shown in the tab for the [Roles and Features Wizard](#add-roles-and-features-to-windows-server). Follow the guidance in step 8 to export your selections to an XML-based configuration file.

1. Open a PowerShell session as an administrator.

1. Run the following commands in the following example to add roles and features on the servers you specify, use your configuration file, and restart each server if necessary. Be sure to replace any `<placeholder>` values with your own. This example runs each command in a separate job, so that the commands run concurrently on each server. For more information about running commands in jobs, see [Start-Job](/powershell/module/microsoft.powershell.core/start-job).

   ```powershell
   $serverNames = '<server01>','<server02>','<server03>'
   $configurationFilepath = '<filePath to DeploymentConfigTemplate.xml>'
   
   $jobs = @()
   foreach($serverName in $serverNames) {
       $jobs += Start-Job -Command {
           Install-WindowsFeature -ConfigurationFilepath $configurationFilepath -ComputerName $serverName -Restart
       }
   }

   Receive-Job -Job $jobs -Wait | Select-Object Success, RestartNeeded, exitCode, FeatureResult
   ```

   If the value for the parameter `Restart Needed` is `Yes`, restart the server to complete the installation.

1. Verify the roles and features you specified in your configuration completed in the output from each job.

---

## Remove roles and features from Windows Server

You can remove roles and features on a local server, a remote server that is added to Server Manager, or an offline VHD, using the **Remove Roles and Features Wizard** in Server Manager, or by using Windows PowerShell cmdlets.

Select the relevant tab.

### [Roles and Features Wizard](#tab/gui)

To remove roles and features using the Roles and Features Wizard in Server Manager, follow these steps:

1. Open the Start menu, type **Server Manager**, then open **Server Manager**.

1. Select **Manage** in the top-right corner, then select **Remove Roles and Features**. The **Remove Roles and Features Wizard** opens.

1. For **Before You Begin**, review the information, then select **Next**.

1. For **Server Selection**, select the server you want to remove roles and features on. You can choose the local server or a remote server that is added to Server Manager. If you want to remove roles and features on an offline VHD, select **Select a virtual hard disk**, select the server on which to mount the VHD, then browse or enter its file path. Select **Next**.

1. For **Server Roles**, select the roles you want to remove. You don't have to select any roles if you only want to remove a feature. Once you made your role selections, select **Next**.

   As you proceed, the wizard automatically prompts you to remove any other roles and features that the roles or features that you select require.

1. For **Features**, select the roles you want to remove. You don't have to select any features if you only want to remove a role. Once you made your feature selections, select **Next**.

1. For **Confirmation**, review the roles and features you selected. Once you're ready, select **Remove**. Some roles and features require you to restart the server after removal. Check the box **Restart the destination server automatically if required** if you want the server to restart automatically after removal.

1. Once the removal is complete, select **Close**.

### [Windows PowerShell](#tab/powershell)

To remove roles and features using the [Windows PowerShell module for Server Manager](/powershell/module/servermanager/), follow these steps. Be sure to replace any `<placeholder>` values with your own.

1. Open a PowerShell session as an administrator.

1. Get a list of all the roles and features installed on the server by running the following command:

   ```powershell
   Get-WindowsFeature | ? Installed -eq $true
   ```

   If you want to check roles and features on a remote server, use the `-ComputerName` parameter. You can use this parameter even if the remote server isn't added to Server Manager.

   ```powershell
   Get-WindowsFeature -ComputerName <ComputerName> | ? Installed -eq $true
   ```

1. Remove a role or feature with the `Unnstall-WindowsFeature` cmdlet and specify the name of one or more roles or features you want to add, as shown in the following examples. You can find the complete documentation for the cmdlet at [Uninstall-WindowsFeature](/powershell/module/servermanager/uninstall-windowsfeature).

   > [!TIP]
   >
   > - Management tools and snap-ins for a role aren't by default. To include management tools as part of a role removal, add the `-IncludeManagementTools` parameter to the cmdlet.
   >
   > - If the role or feature you add needs the server to be restarted to complete the removal, add the `-Restart` parameter to restart automatically without prompting.

   - To remove DNS and DHCP roles on the local server, including management tools, run the following command:

     ```powershell
     Uninstall-WindowsFeature -Name DNS,DHCP -IncludeManagementTools
     ```

   - To remove DNS and DHCP roles and features on an offline VHD, add the `-Vhd` parameter. The cmdlet assumes you want to mount the VHD to the local computer. Alternatively, also add the `-ComputerName` parameter and with the name of the server on which to mount the VHD. You must add the `-ComputerName` parameter if you're running the cmdlet from a computer that is running a Windows client operating system.

     ```powershell
     Uninstall-WindowsFeature -Name DNS,DHCP -Vhd <Path> -ComputerName <ComputerName>
     ```

   The output of the cmdlet shows the result of the removal, as shown in the following example. If the value for the parameter `Restart Needed` is `Yes`, restart the server to complete the installation.

   ```output
   Success Restart Needed Exit Code      Feature Result
   ------- -------------- ---------      --------------
   True    Yes            SuccessRestart {DHCP Server, DNS Server}
   ```

1. You can get a list of all the remaining installed roles and features by running the following command:

   ```powershell
   Get-WindowsFeature | ? Installed -eq $true
   ```

---

## Virtual Agent

If you're having trouble installing or removing roles and features, you can try our Virtual Agent. It can help you quickly identify and fix issues related to roles and features.

> [!div class="nextstepaction"]
>
> [Try our Virtual Agent](https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806294)

## Related content

[Configure Features on Demand](configure-features-on-demand-in-windows-server.md)
