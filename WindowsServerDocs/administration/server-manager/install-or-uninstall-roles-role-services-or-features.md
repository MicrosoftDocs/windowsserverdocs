---
title: Install or Uninstall Roles, Role Services, or Features
description: "Server Manager"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-server-manager
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 04f16d84-45c2-4771-84c1-1cc973d0ee02
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Install or Uninstall Roles, Role Services, or Features

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

In Windows Server, the Server Manager console and Windows PowerShell cmdlets for Server Manager allow installation of roles and features to local or remote servers, or offline virtual hard disks (VHDs). You can install multiple roles and features on a single remote server or offline VHD in a single add Roles and Features Wizard or Windows PowerShell session.  
  
> [!IMPORTANT]  
> Server Manager cannot be used to manage a newer release of the Windows Server operating system. Server Manager running on  Windows Server 2012 R2 or Windows 8.1 cannot be used to install roles, role services, and features on servers that are running Windows Server 2016.  
  
You must be logged on to a server as an administrator to install or uninstall roles, role services, and features. If you are logged on to the local computer with an account that does not have administrator rights on your target server, right-click the target server in the **Servers** tile, and then click **Manage As** to provide an account that has administrator rights. The server on which you want to mount an offline VHD must be added to Server Manager, and you must have Administrator rights on that server.  
  
For more information about what roles, role services, and features are, see [Roles, Role Services, and Features](https://go.microsoft.com/fwlink/p/?LinkId=239558).  
  
This topic contains the following sections.  
  
-   [Install roles, role services, and features by using the add Roles and Features Wizard](#install-roles-role-services-and-features-by-using-the-add-roles-and-features-wizard)  
  
-   [Install roles, role services, and features by using Windows PowerShell cmdlets](#install-roles-role-services-and-features-by-using-windows-powershell-cmdlets)  
  
-   [Remove roles, role services, and features by using the remove Roles and Features Wizard](#remove-roles-role-services-and-features-by-using-the-remove-roles-and-features-wizard)  
  
-   [Remove roles, role services, and features by using Windows PowerShell cmdlets](#remove-roles-role-services-and-features-by-using-windows-powershell-cmdlets)  
  
-   [Install roles and features on multiple servers by running a Windows PowerShell script](#install-roles-and-features-on-multiple-servers-by-running-a-windows-powershell-script)  
  
-   [Install .NET Framework 3.5 and other features on-demand](#install-net-framework-35-and-other-features-on-demand)  
  
## Install roles, role services, and features by using the add Roles and Features Wizard  
In a single session in the add Roles and Features Wizard, you can install roles, role services, and features on the local server, a remote server that has been added to Server Manager, or an offline VHD. For more information about how to add a server to Server Manager to manage, see [Add Servers to Server Manager](add-servers-to-server-manager.md).  
  
> [!NOTE]  
> If you are running Server Manager on Windows Server 2016  or Windows 10, you can use the add Roles and Features Wizard to install roles and features only on servers and offline VHDs that are running Windows Server 2016.  
  
#### To install roles and features by using the add Roles and Features Wizard  
  
1.  If Server Manager is already open, go on to the next step. If Server Manager is not already open, open it by doing one of the following.  
  
    -   On the Windows desktop, start Server Manager by clicking **Server Manager** in the Windows taskbar.  
  
    -   On the Windows **start** screen, click the **Server Manager** tile.  
  
2.  On the **Manage** menu, click **add Roles and Features**.  
  
3.  On the **Before you begin** page, verify that your destination server and network environment are prepared for the role and feature you want to install. Click **Next**.  
  
4.  On the **Select installation type** page, select **Role-based or feature-based installation** to install all parts of roles or features on a single server, or **Remote Desktop Services installation** to install either a virtual machine-based desktop infrastructure or a session-based desktop infrastructure for Remote Desktop Services. The **Remote Desktop Services installation** option distributes logical parts of the Remote Desktop Services role across different servers as needed by administrators. Click **Next**.  
  
5.  On the **Select destination server** page, select a server from the server pool, or select an offline VHD. To select an offline VHD as your destination server, first select the server on which to mount the VHD, and then select the VHD file. For information about how to add servers to your server pool, see [Add Servers to Server Manager](add-servers-to-server-manager.md). After you have selected the destination server, click **Next**.  
  
    > [!NOTE]  
    > To install roles and features on offline VHDs, target VHDs must meet the following requirements.  
    >   
    > -   VHDs must be running the release of Windows Server that matches the version of Server Manager you are running. See the note at the start of [Install roles, role services, and features by using the add Roles and Features Wizard](#install-roles-role-services-and-features-by-using-the-add-roles-and-features-wizard).  
    > -   VHDs cannot have more than one system volume or partition.  
    > -   The network shared folder in which the VHD file is stored must grant the following access rights to the computer (or local system) account of server that you have selected to mount the VHD. User-only account access is not sufficient. The share can grant **Read** and **Write** permissions to the **Everyone** group to allow access to the VHD, but for security reasons, this is not recommended.  
    >   
    >     -   **Read/Write** access on the **File Sharing** dialog box.  
    >     -   **Full Control** access on the **Security** tab, file or folder **Properties** dialog box.  
  
6.  Select roles, select role services for the role if applicable, and then click **Next** to select features.  
  
    As you proceed, the add Roles and Features Wizard automatically informs you if conflicts were found on the destination server that can prevent selected roles or features from installation or normal operation. You are also prompted to add any roles, role services, or features that are required by the roles or features that you have selected.  
  
    Additionally, if you plan to manage the role remotely, either from another server, or from a Windows client-based computer that is running Remote Server Administration Tools, you can opt not to install management tools and snap-ins for roles on the destination server. By default, in the add Roles and Features Wizard, management tools are selected for installation.  
  
7.  On the **Confirm installation selections** page, review your role, feature, and server selections. If you are ready to install, click **Install**.  
  
    You can also export your selections to an XML-based configuration file that you can use for unattended installations with Windows PowerShell. To export the configuration you specified in this add Roles and Features Wizard session, click **Export configuration settings**, and then save the XML file to a convenient location.  
  
    The **Specify an alternate source path** command on the **Confirm installation selections** page lets you specify an alternate source path for the files that are required to install roles and features on the selected server. In  Windows Server 2012  and later releases of Windows Server, [Features on Demand](https://go.microsoft.com/fwlink/p/?LinkID=241573) lets you reduce the amount of disk space used by the operating system, by removing role and feature files from servers that are exclusively managed remotely. If you have removed role and feature files from a server by using the `Uninstall-WindowsFeature -remove` cmdlet, you can install roles and features on the server in the future by specifying an alternate source path, or a share on which required role and feature files are stored. The source path or file share must grant **Read** permissions either to the **Everyone** group (not recommended for security reasons), or to the computer account (*DOMAIN*\\*SERverNAME*$) of the destination server; granting user account access is not sufficient. For more information about Features on Demand, see [Windows Server Installation Options](https://go.microsoft.com/fwlink/p/?LinkId=241573).  
  
    You can specify a WIM file as an alternate feature file source when you are installing roles, role services, and features on a running, physical server. The source path for a WIM file should be in the following format, with **WIM** as a prefix, and the index in which the feature files are located as a suffix: **WIM:e:\sources\install.wim:4**. However, you cannot use a WIM file directly as a source for installing roles, role services, and features to an offline VHD; you must either mount the offline VHD and point to its mount path for source files, or you must point to a folder that contains a copy of the contents of the WIM file.  
  
8.  After you click **Install**, the **Installation Progress** page displays installation progress, results, and messages such as warnings, failures, or post-installation configuration steps that are required for the roles or features that you installed. In  Windows Server 2012 and later releases of Windows Server, you can close the add Roles and Features Wizard while installation is still in progress, and view installation results or other messages in the **Notifications** area at the top of the Server Manager console. Click the **Notifications** flag icon to see more details about installations or other tasks that you are performing in Server Manager.  
  
## Install roles, role services, and features by using Windows PowerShell cmdlets  
The Server Manager deployment cmdlets for Windows PowerShell function similarly to the GUI-based add Roles and Features Wizard and remove Roles and Features Wizard, with an IMPORTANT difference. In Windows PowerShell, unlike in the add Roles and Features Wizard, management tools and snap-ins for a role are not included by default. To include management tools as part of a role installation, add the `IncludeManagementTools` parameter to the cmdlet. If you are installing roles and features on a server that is running the Server Core installation option of  Windows Server 2012  or later releases, you can add a role's management tools to an installation, but GUI-based management tools and snap-ins cannot be installed on servers that are running the Server Core installation option of Windows Server. Only command-line and Windows PowerShell management tools can be installed on the Server Core installation option.  
  
#### To install roles and features by using the Install-WindowsFeature cmdlet  
  
1. Do one of the following to open a Windows PowerShell session with elevated user rights.  
  
   > [!NOTE]  
   > If you are installing roles and features on a remote server, you do not need to run Windows PowerShell with elevated user rights.  
  
   -   On the Windows desktop, right-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.  
  
   -   On the Windows **Start** screen, right-click the tile for Windows PowerShell, and then on the app bar, click **Run as Administrator**.  
  
2. Type **Get-WindowsFeature** and then press **Enter** to view a list of available and installed roles and features on the local server. If the local computer is not a server, or if you want information about a remote server, run **Get-WindowsFeature -computerName <**<em>computer_name</em>**>**, in which *computer_name* represents the name of a remote computer that is running Windows Server 2016. The results of the cmdlet contain the command names of roles and features that you add to your cmdlet in step 4.  
  
   > [!NOTE]  
   > In Windows PowerShell 3.0 and later releases of Windows PowerShell, there is no need to import the Server Manager cmdlet module into the Windows PowerShell session before running cmdlets that are part of the module. A module is automatically imported the first time you run a cmdlet that is part of the module. Also, neither Windows PowerShell cmdlets nor the feature names used with the cmdlets are case-sensitive.  
  
3. type **Get-help Install-WindowsFeature**, and then press **Enter** to view the syntax and accepted parameters for the `Install-WindowsFeature` cmdlet.  
  
4. type the following, and then press **Enter**, where *feature_name* represents the command name of a role or feature that you want to install (obtained in step 2), and *computer_name* represents a remote computer on which you want to install roles and features. Separate multiple values for *feature_name* by using commas. The `Restart` parameter automatically restarts the destination server if required by the role or feature installation.  
  
   ```  
   Install-WindowsFeature -Name <feature_name> -computerName <computer_name> -Restart  
   ```  
  
   To install roles and features on an offline VHD, add both the `computerName` parameter and the `VHD` parameter. If you do not add the `computerName` parameter, the cmdlet assumes that the local computer is mounted to access the VHD. The `computerName` parameter contains the name of the server on which to mount the VHD, and the `VHD` parameter contains the path to the VHD file on the specified server.  
  
   > [!NOTE]  
   > You must add the `computerName` parameter if you are running the cmdlet from a computer that is running a Windows client operating system.  
   >   
   > To install roles and features on offline VHDs, target VHDs must meet the following requirements.  
   >   
   > -   VHDs must be running the release of Windows Server that matches the version of Server Manager you are running. See the note at the start of [Install roles, role services, and features by using the add Roles and Features Wizard](#install-roles-role-services-and-features-by-using-the-add-roles-and-features-wizard).  
   > -   VHDs cannot have more than one system volume or partition.  
   > -   The network shared folder in which the VHD file is stored must grant the following access rights to the computer (or local system) account of server that you have selected to mount the VHD. User-only account access is not sufficient. The share can grant **Read** and **Write** permissions to the **Everyone** group to allow access to the VHD, but for security reasons, this is not recommended.  
   >   
   >     -   **Read/Write** access on the **File Sharing** dialog box.  
   >     -   **Full Control** access on the **Security** tab, file or folder **Properties** dialog box.  
  
   ```  
   Install-WindowsFeature -Name <feature_name> -VHD <path> -computerName <computer_name> -Restart  
   ```  
  
   **Example:** The following cmdlet installs the active directory Domain Services role and the Group Policy Management feature on a remote server, ContosoDC1. Management tools and snap-ins are added by using the `IncludeManagementTools` parameter, and the destination server is to be restarted automatically, if installation requires that the servers be restarted.  
  
   ```  
   Install-WindowsFeature -Name AD-Domain-Services,GPMC -computerName ContosoDC1 -IncludeManagementTools -Restart  
   ```  
  
5. When installation is finished, verify installation by opening the **All Servers** page in Server Manager, selecting a server on which you installed roles and features, and viewing the **Roles and Features** tile on the page for the selected server. You can also run the `Get-WindowsFeature` cmdlet targeted at the selected server (Get-WindowsFeature -computerName <*computer_name*>) to view a list of roles and features that are installed on the server.  
  
## Remove roles, role services, and features by using the remove Roles and Features Wizard  
You must be logged on to a server as an administrator to uninstall roles, role services, and features. If you are logged on to the local computer with an account that does not have administrator rights on your uninstallation target server, right-click the target server in the **Servers** tile, and then click **Manage As** to provide an account that has administrator rights. The server on which you want to mount an offline VHD must be added to Server Manager, and you must have Administrator rights on that server.  
  
#### To remove roles and features by using the remove Roles and Features Wizard  
  
1.  If Server Manager is already open, go on to the next step. If Server Manager is not already open, open it by doing one of the following.  
  
    -   On the Windows desktop, start Server Manager by clicking **Server Manager** in the Windows taskbar.  
  
    -   On the Windows **Start** screen, click the **Server Manager** tile.  
  
2.  On the **Manage** menu, click **Remove Roles and Features**.  
  
3.  On the **Before you begin** page, verify that you have prepared for removing roles or features from a server. Click **Next**.  
  
4.  On the **Select Destination Server** page, select a server from the server pool, or select an offline VHD. To select an offline VHD, first select the server on which to mount the VHD, and then select the VHD file.  
  
    > [!NOTE]  
    > The network shared folder in which the VHD file is stored must grant the following access rights to the computer (or local system) account of server that you have selected to mount the VHD. User-only account access is not sufficient. The share can grant **Read** and **Write** permissions to the **Everyone** group to allow access to the VHD, but for security reasons, this is not recommended.  
    >   
    > -   **Read/Write** access on the **File Sharing** dialog box.  
    > -   **Full Control** access on the **Security** tab , file or folder **Properties** dialog box.  
  
    For information about how to add servers to your server pool, see [add Servers to Server Manager](add-servers-to-server-manager.md). After you have selected the destination server, click **Next**.  
  
    > [!NOTE]  
    > You can use the remove Roles and Features Wizard to remove roles and features from servers that are running the same release of Windows Server that supports the version of Server Manager that you are using. You cannot remove roles, role services, or features from servers that are running Windows Server 2016, if you are running Server Manager on  Windows Server 2012 R2,  Windows Server 2012, or Windows 8. You cannot use the remove Roles and Features Wizard to remove roles and features from servers that are running  Windows Server 2008 or Windows Server 2008 R2.  
  
5.  Select roles, select role services for the role if applicable, and then click **Next** to select features.  
  
    As you proceed, the remove Roles and Features Wizard automatically prompts you to remove any roles, role services, or features that cannot run without the roles or features that you are removing.  
  
    additionally, you can opt to remove management tools and snap-ins for roles on the destination server. By default, in the remove Roles and Features Wizard, management tools are selected for removal. You can leave management tools and snap-ins if you plan to use the selected server to manage the role on other remote servers.  
  
6.  On the **Confirm removal selections** page, review your role, feature, and server selections. If you are ready to remove the roles or features, click **remove**.  
  
7.  After you click **remove**, the **removal progress** page displays removal progress, results, and messages such as warnings, failures, or post-removal configuration steps that are required, such as restarting the destination server. In  Windows Server 2012  and later releases of Windows Server, you can close the remove Roles and Features Wizard while removal is still in progress, and view removal results or other messages in the **Notifications** area at the top of the Server Manager console. Click the **Notifications** flag to see more details about removals or other tasks that you are performing in Server Manager.  
  
## Remove roles, role services, and features by using Windows PowerShell cmdlets  
The Server Manager deployment cmdlets for Windows PowerShell function similarly to the GUI-based remove Roles and Features Wizard, with an IMPORTANT difference. In Windows PowerShell, unlike in the remove Roles and Features Wizard, management tools and snap-ins for a role are not removed by default. To remove management tools as part of a role removal, add the `IncludeManagementTools` parameter to the cmdlet. If you are uninstalling roles and features from a server that is running the Server Core installation option of  Windows Server 2012  or a later release of Windows Server, this parameter removes command-line and Windows PowerShell management tools for the specified roles and features.  
  
#### To remove roles and features by using the Uninstall-WindowsFeature cmdlet  
  
1. Do one of the following to open a Windows PowerShell session with elevated user rights.  
  
   > [!NOTE]  
   > If you are uninstalling roles and features from a remote server, you do not need to run Windows PowerShell with elevated user rights.  
  
   -   On the Windows desktop, right-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.  
  
   -   On the Windows **start** screen, right-click the Windows PowerShell tile, and then on the app bar, click **Run as Administrator**.  
  
2. Type **Get-WindowsFeature** and then press **Enter** to view a list of available and installed roles and features on the local server. If the local computer is not a server, or if you want information about a remote server, run **Get-WindowsFeature -computerName <**<em>computer_name</em>**>**, in which *computer_name* represents the name of a remote computer that is running Windows Server 2016. The results of the cmdlet contain the command names of roles and features that you add to your cmdlet in step 4.  
  
   > [!NOTE]  
   > In Windows PowerShell 3.0 and later releases of Windows PowerShell, there is no need to import the Server Manager cmdlet module into the Windows PowerShell session before running cmdlets that are part of the module. A module is automatically imported the first time you run a cmdlet that is part of the module. Also, neither Windows PowerShell cmdlets nor the feature names used with the cmdlets are case-sensitive.  
  
3. type **Get-help Uninstall-WindowsFeature**, and then press **Enter** to view the syntax and accepted parameters for the `Uninstall-WindowsFeature` cmdlet.  
  
4. Type the following, and then press **Enter**, where *feature_name* represents the command name of a role or feature that you want to remove (obtained in step 2), and *computer_name* represents a remote computer from which you want to remove roles and features. Separate multiple values for *feature_name* by using commas. The `Restart` parameter automatically restarts destination servers if required by the role or feature removal.  
  
   ```  
   Uninstall-WindowsFeature -Name <feature_name> -computerName <computer_name> -Restart  
   ```  
  
   To remove roles and features from an offline VHD, add both the `computerName` parameter and the `VHD` parameter. If you do not add the `computerName` parameter, the cmdlet assumes that the local computer is mounted to access the VHD. The `computerName` parameter contains the name of the server on which to mount the VHD, and the `VHD` parameter contains the path to the VHD file on the specified server.  
  
   > [!NOTE]  
   > You must add the `computerName` parameter if you are running the cmdlet from a computer that is running a Windows client operating system.  
   >   
   > The network shared folder in which the VHD file is stored must grant the following access rights to the computer (or local system) account of server that you have selected to mount the VHD. User-only account access is not sufficient. The share can grant **Read** and **Write** permissions to the **Everyone** group to allow access to the VHD, but for security reasons, this is not recommended.  
   >   
   > -   **Read/Write** access on the **File Sharing** dialog box.  
   > -   **Full Control** access on the **Security** tab, file or folder **Properties** dialog box.  
  
   ```  
   Uninstall-WindowsFeature -Name <feature_name> -VHD <path> -computerName <computer_name> -Restart  
   ```  
  
   **Example:** The following cmdlet removes the active directory Domain Services role and the Group Policy Management feature from a remote server, ContosoDC1. Management tools and snap-ins are also removed, and the destination server is to be restarted automatically, if removal requires that the servers be restarted.  
  
   ```  
   Uninstall-WindowsFeature -Name AD-Domain-Services,GPMC -computerName ContosoDC1 -IncludeManagementTools -Restart  
   ```  
  
5. When removal is finished, verify that the roles and features are removed by opening the **All Servers** page in Server Manager, selecting the server from which you removed roles and features, and viewing the **Roles and Features** tile on the page for the selected server. You can also run the `Get-WindowsFeature` cmdlet targeted at the selected server (Get-WindowsFeature -computerName <*computer_name*>) to view a list of roles and features that are installed on the server.  
  
## Install roles and features on multiple servers by running a Windows PowerShell script  
Although you cannot use the add Roles and Features Wizard to install roles, role services, and features on more than one target server in a single wizard session, you can use a Windows PowerShell script to install roles, role services, and features on multiple target servers that you are managing by using Server Manager. The script that you use to perform batch deployment, as this process is called, points to an XML configuration file that you can create easily by using the add Roles and Features Wizard, and clicking **Export configuration settings** after advancing through the wizard to the **Confirm installation selections** page of the add Roles and Features Wizard.  
  
> [!IMPORTANT]  
> All target servers that are specified in your script must be running the release of Windows Server that matches the version of Server Manager you are running on the local computer. For example, if you are running Server Manager on Windows 10, you can install roles, role services, and features on servers that are running Windows Server 2016. If GUI-based management tools are added to the installation, the installation process automatically converts target servers that are running the Server Core installation option of Windows Server to the full installation option (server with a full GUI, also known as running Server Graphical Shell).  
>   
> The script provided in this section is an example of how batch deployment can be performed by using the `Install-WindowsFeature` cmdlet and a Windows PowerShell script. There are other possible scripts and methods of performing batch deployment to multiple servers. To search for or provide other scripts for deploying roles and features, search the [Script Center Repository](https://gallery.technet.microsoft.com/ScriptCenter).  
  
#### To install roles and features on multiple servers  
  
1.  If you have not already done so, create an XML configuration file that contains the roles, role services, and features that you want installed on multiple servers. You can create this configuration file by running the add Roles and Features Wizard, selecting roles, role services, and features that you want, and clicking **Export configuration settings** after advancing through the wizard to the **Confirm installation selections** page. Save the configuration file to a convenient location. You do not need to click **Install** or complete the wizard if you are running it only to create a configuration file.  
  
2.  Do one of the following to open a Windows PowerShell session with elevated user rights.  
  
    -   On the Windows desktop, right-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.  
  
    -   On the Windows **start** screen, right-click the Windows PowerShell tile, and then on the app bar, click **Run as Administrator**.  
  
3.  Copy and paste the following script into your Windows PowerShell session.  
  
    ```  
    function Invoke-WindowsFeatureBatchDeployment {  
        param (  
            [parameter(mandatory)]  
            [string[]] $computerNames,  
            [parameter(mandatory)]  
            [string] $ConfigurationFilepath  
        )  
  
        # Deploy the features on multiple computers simultaneously.  
        $jobs = @()  
        foreach($computerName in $computerNames) {  
            $jobs += start-Job -Command {  
                Install-WindowsFeature -ConfigurationFilepath $using:ConfigurationFilepath -computerName $using:computerName -Restart  
            }   
        }  
  
        Receive-Job -Job $jobs -Wait | select-Object Success, RestartNeeded, exitCode, FeatureResult  
    }  
    ```  
  
    Target servers are automatically restarted if required by the roles and features that you select.  
  
4.  Run the function by doing the following.  
  
    1.  Create a variable in which to store the names of your target computers, separated by commas. In the following example, the variable `$ServerNames` stores the names of target servers *Contoso_01* and *Contoso_02*. Press **Enter**.  
  
        ```  
        # Sample Invocation  
        $ServerNames = 'Contoso_01','Contoso_02'  
        Invoke-WindowsFeatureBatchDeployment -computerNames $ServerNames -ConfigurationFilepath C:\Users\sampleuser\Desktop\DeploymentConfigTemplate.xml  
        ```  
  
    2.  To run the function, type the following, and then press **Enter**, where `$ServerNames` is an example of the variable that you created in the preceding step, and *C:\Users\Sampleuser\Desktop\DeploymentConfigTemplate.xml* is an example of a path to the configuration file that you created in step 1.  
  
        **Invoke-WindowsFeatureBatchDeployment -computerNames $ServerNames -ConfigurationFilepath C:\Users\Sampleuser\Desktop\DeploymentConfigTemplate.xml**  
  
5.  When installation is finished, verify installation by opening the **All Servers** page in Server Manager, selecting a server on which you installed roles and features, and viewing the **Roles and Features** tile on the page for the selected server. You can also run the `Get-WindowsFeature` cmdlet targeted at a specific server (`Get-WindowsFeature -computerName` <*computer_name*>) to view a list of roles and features that are installed on the server.  
  
## Install .NET Framework 3.5 and other features on-demand  
starting with  Windows Server 2012  and Windows 8, the feature files for .NET Framework 3.5 (which includes .NET Framework 2.0 and .NET Framework 3.0) are not available on the local computer by default. The files have been removed. Files for features that have been removed in a Features on Demand configuration, along with feature files for .NET Framework 3.5, are available through Windows Update. By default, if feature files are not available on the destination server that is running  Windows Server 2012  or later releases, the installation process searches for the missing files by connecting to Windows Update. You can override the default behavior by configuring a Group Policy setting or specifying an alternate source path during installation, whether you are installing by using the add Roles and Features Wizard GUI or a command line.  
  
You can install .NET Framework 3.5 by doing one of the following.  
  
-   Use [To install .NET Framework 3.5 by running the Install-WindowsFeature cmdlet](#to-install-net-framework-35-by-running-the-install-windowsfeature-cmdlet) to add the `Source` parameter, and specify a source from which to get .NET Framework 3.5 feature files. If you do not add the `Source` parameter, the installation process first determines if a path to feature files has been specified by Group Policy settings, and if no such path is found, searches for missing feature files by using Windows Update.  
  
-   Use [To install .NET Framework 3.5 by using the add Roles and Features Wizard](#to-install-net-framework-35-by-using-the-add-roles-and-features-wizard) to specify an alternate source file location on the **Confirm installation options** page of the add Roles and Features Wizard.  
  
-   Use [To install .NET Framework 3.5 by using DISM](#to-install-net-framework-35-by-using-dism) to get files from Windows Update by default, or by specifying a source path to installation media.  
  
[Configure alternate sources for feature files in Group Policy](#configure-alternate-sources-for-feature-files-in-group-policy) for .NET Framework 3.5 or other features, if feature files are not found on the local computer.  
  
> [!IMPORTANT]  
> When you are installing feature files from a remote source, the source path or file share must grant **Read** permissions either to the **Everyone** group (not recommended for security reasons), or to the computer (local system) account of the destination server; granting user account access is not sufficient.  
>   
> Servers that are in workgroups cannot access external file shares, even if the computer account for the workgroup server has **Read** permissions on the external share. Alternate source locations that work for workgroup servers include installation media, Windows Update, and VHD or WIM files that are stored on the local workgroup server.  
>   
> You can specify a WIM file as an alternate feature file source when you are installing roles, role services, and features on a running, physical server. The source path for a WIM file should be in the following format, with **WIM** as a prefix, and the index in which the feature files are located as a suffix: **WIM:e:\sources\install.wim:4**. However, you cannot use a WIM file directly as a source for installing roles, role services, and features to an offline VHD; you must either mount the offline VHD and point to its mount path for source files, or you must point to a folder that contains a copy of the contents of the WIM file.  
  
### To install .NET Framework 3.5 by running the Install-WindowsFeature cmdlet  
  
1.  Do one of the following to open a Windows PowerShell session with elevated user rights.  
  
    > [!NOTE]  
    > if you are installing roles and features from a remote server, you do not need to run Windows PowerShell with elevated user rights.  
  
    -   On the Windows desktop, right-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.  
  
    -   On the Windows **start** screen, right-click the Windows PowerShell tile, and then on the app bar, click **Run as Administrator**.  
  
    -   On a server that is running the Server Core installation option of  Windows Server 2012 R2  or  Windows Server 2012 , type **PowerShell** into a command prompt, and then press **Enter**.  
  
2.  type the following command, and then press **Enter**. In the following example, the source files are located in a side-by-side store (abbreviated to as **SxS**) in installation media on drive D.  
  
    ```  
    Install-WindowsFeature NET-Framework-Core -Source D:\Sources\SxS  
    ```  
  
    If you want the command to use Windows Update as a source for missing feature files, or if a default source has already been configured by using Group Policy, you do not need to add the `Source` parameter unless you want to specify a different source.  
  
### To install .NET Framework 3.5 by using the add Roles and Features Wizard  
  
1. On the **Manage** menu in Server Manager, click **add Roles and Features**.  
  
2. Select a destination server that is running Windows Server 2016.  
  
3. On the **select features** page of the add Roles and Features Wizard, select **.NET Framework 3.5**.  
  
4. If the local computer is allowed to do so by Group Policy settings, the installation process attempts to get missing feature files by using Windows Update. Click **Install**; you do not need to go on to the next step.  
  
   if Group Policy settings do not allow this, or you want to use another source for the .NET Framework 3.5 feature files, on the **Confirm installation selections** page of the wizard, click **Specify an alternate source path**.  
  
5. Provide a path to a side-by-side store (referred to as **SxS**) in installation media, or to a WIM file. In the following example, installation media is located on drive D.  
  
   **D:\Sources\SxS\\**  
  
   To specify a WIM file, add a **WIM:** prefix, and add the index of the image to use in the WIM file as a suffix, as shown in the following example.  
  
   **WIM:\\\\**<em>server_name</em>**\share\install.wim:3**  
  
6. Click **OK**, and then click **Install**.  
  
### To install .NET Framework 3.5 by using DISM  
  
1.  Do one of the following to open a Windows PowerShell session with elevated user rights.  
  
    > [!NOTE]  
    > if you are installing roles and features from a remote server, you do not need to run Windows PowerShell with elevated user rights.  
  
    -   On the Windows desktop, right-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.  
  
    -   On the Windows **Start** screen, right-click the Windows PowerShell tile, and then on the app bar, click **Run as Administrator**.  
  
    -   On a server that is running the Server Core installation option, type **PowerShell** into a command prompt, and then press **Enter**.  
  
2.  Run one of the following DISM commands.  
  
    -   if the computer has access to Windows Update, or a default source file location has already been configured in Group Policy, run the following command.  
  
        ```  
        DISM /online /Enable-Feature /Featurename:NetFx3 /All  
        ```  
  
    -   if the computer has access to installation media, run a command similar to the following. In the following example, the operating system installation media is located on drive D. The `LimitAccess` parameter prevents the command from attempting to contact Windows Update or a server that is running WSUS.  
  
        ```  
        DISM /online /Enable-Feature /Featurename:NetFx3 /All /LimitAccess /Source:d:\sources\sxs  
        ```  
  
    > [!NOTE]  
    > The DISM command is case-sensitive.  
  
### Configure alternate sources for feature files in Group Policy  
The Group Policy setting described in this section specifies authorized source locations for .NET Framework 3.5 files, and other feature files that have been removed as part of a Features on Demand configuration. The policy setting **Specify settings for optional component installation and component repair** is located in the **computer Configuration\Administrative Templates\System** folder in the Group Policy Management Console or Local Group Policy editor.  
  
> [!NOTE]  
> You must be a member of the Administrators group to change Group Policy settings on the local computer. If Group Policy settings for the computer you want to manage are controlled at the domain level, you must be a member of the Domain Administrators group to change Group Policy settings.  
  
##### To configure a default alternate source path in Group Policy  
  
1. In Local Group Policy editor or Group Policy Management Console, open the following policy setting.  
  
   **computer Configuration\Administrative Templates\System\Specify settings for optional component installation and component repair**  
  
2. Sselect **Enabled** to enable the policy setting, if it is not already enabled.  
  
3. In the **Alternate source file path** text box in the **Options** area, specify a fully qualified path to a shared folder or a WIM file. To specify a WIM file as an alternate source file location, add the prefix **WIM:** to the path, and add the index of the image to use in the WIM file as a suffix. The following are examples of values that you can specify.  
  
   - path to a shared folder:  **\\\\**<em>server_name</em>**\share\\**<em>folder_name</em>  
  
   - path to a WIM file, in which **3** represents the index of the image in which the feature files are found:  **WIM:\\\\**<em>server_name</em>**\share\install.wim:3**  
  
4. if you do not want computers that are controlled by this policy setting to search for missing feature files in Windows Update, select **Never attempt to download payload from Windows Update**.  
  
5. If the computers that are controlled by this policy setting typically receive updates through WSUS, but you prefer to go through Windows Update and not WSUS to find missing feature files, select **Contact Windows Update directly to download repair content instead of Windows Server Update Services (WSUS)**.  
  
6. Click **OK** when you are finished changing this policy setting, and then close the Group Policy editor.  
  
## See Also  
[Windows Server Installation Options](https://go.microsoft.com/fwlink/p/?LinkId=241573)  
[Microsoft .NET Framework 3.5 Deployment Considerations](https://go.microsoft.com/fwlink/p/?LinkId=248869)  
[How to Enable or Disable Windows Features](https://go.microsoft.com/fwlink/p/?LinkId=246552)  
  


