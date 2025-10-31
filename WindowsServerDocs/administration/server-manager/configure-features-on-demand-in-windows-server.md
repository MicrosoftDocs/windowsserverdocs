---
title: Configure Features on Demand in Windows Server
description: Learn how to remove feature files in a Features on Demand configuration by using the Uninstall-WindowsFeature cmdlet.
ms.topic: how-to
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---
# Configure Features on Demand in Windows Server

This topic describes how to remove feature files in a Features on Demand configuration by using the Uninstall-WindowsFeature cmdlet.

Features on Demand is a feature, introduced in Windows 8 and  Windows Server 2012 , that allows you to remove role and feature files (sometimes called feature *payload*) from the operating system to conserve disk space, and install roles and features from remote locations or installation media instead of from local computers. You can remove feature files from running physical or virtual computers. You can also add feature files to or remove feature files from Windows image (WIM) files or offline virtual hard disks (VHDs) to create a reproducible copy of Features on Demand configurations.

In a Features on Demand configuration, when feature files are not available on a computer, if an installation requires those feature files,  Windows Server 2012 R2  or  Windows Server 2012  can be directed to get the files from a side-by-side feature store (a shared folder that contains feature files, and is available to the computer on the network), from Windows Update, or from installation media. By default, when feature files are not available on the target server, Features on Demand searches for missing feature files by performing the following tasks, in the order shown.

1.  Searching in a location that has been specified by users of the add Roles and Features Wizard or DISM installation commands

2.  Evaluating the configuration of the Group Policy setting, **computer Configuration\Administrative Templates\System\Specify settings for optional component installation and component repair**

3.  Searching Windows Update

You can override default Features on Demand behavior by doing any of the following.

-   Specifying an alternate source path as part of the `Install-WindowsFeature` cmdlet, by adding the `Source` parameter

-   Specifying an alternate source path on the **Confirm installation options** page while you are installing features by using the add Roles and Features Wizard

-   Configuring the Group Policy setting, **Specify settings for optional component installation and component repair**

This topic contains the following sections.

-   [Create a feature file or side-by-side store](#BKMK_store)

-   [Methods of removing feature files](#BKMK_methods)

-   [Remove feature files by using Uninstall-WindowsFeature](#BKMK_remove)

## <a name=BKMK_store></a>Create a feature file or side-by-side store
This section describes how to set up a remote feature file shared folder (also called a side-by-side store) that stores the files required to install roles, role services, and features on servers that run  Windows Server 2012 R2  or  Windows Server 2012 . After you have set up a feature store, you can install roles, role services, and features on servers that are running those operating systems, and specify the feature store as the location of installation source files.

#### To create a feature file store

1.  Create a shared folder on a server on your network. For example, *\\\network\share\sxs*.

2.  Verify that you have the correct permissions assigned to the feature store. The source path or file share must grant **Read** permissions either to the **Everyone** group (not recommended for security reasons), or to the computer accounts (*DOMAIN*\\*SERverNAME*$) of servers on which you plan to install features by using this feature store; granting user account access is not sufficient.

    You can access file sharing and permissions settings by doing either of the following on the Windows desktop.

    -   Right-click the shared folder, click **Properties**, and then change allowed users and their access rights to the folder on the **Security** tab.

    -   Right-click the shared folder, point to **Share with**, and then click **Specific people**.

    > [!NOTE]
    > Servers that are in workgroups cannot access external file shares, even if the computer account for the workgroup server has **Read** permissions on the external share. Alternate source locations that work for workgroup servers include installation media, Windows Update, and VHD or WIM files that are stored on the local workgroup server.

3.  Copy the **Sources\SxS** folder from your Windows Server installation media to the shared folder that you created in step 1.

### Install .NET Framework 3.5 and other features on-demand

Starting with  Windows Server 2012  and Windows 8, the feature files for .NET Framework 3.5 (which includes .NET Framework 2.0 and .NET Framework 3.0) are not available on the local computer by default. The files have been removed. Files for features that have been removed in a Features on Demand configuration, along with feature files for .NET Framework 3.5, are available through Windows Update. By default, if feature files are not available on the destination server that is running  Windows Server 2012  or later releases, the installation process searches for the missing files by connecting to Windows Update. You can override the default behavior by configuring a Group Policy setting or specifying an alternate source path during installation, whether you are installing by using the add Roles and Features Wizard GUI or a command line.

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

2. Select **Enabled** to enable the policy setting, if it is not already enabled.

3. In the **Alternate source file path** text box in the **Options** area, specify a fully qualified path to a shared folder or a WIM file. To specify a WIM file as an alternate source file location, add the prefix **WIM:** to the path, and add the index of the image to use in the WIM file as a suffix. The following are examples of values that you can specify.

   - path to a shared folder:  **\\\\**<em>server_name</em>**\share\\**<em>folder_name</em>

   - path to a WIM file, in which **3** represents the index of the image in which the feature files are found:  **WIM:\\\\**<em>server_name</em>**\share\install.wim:3**

4. if you do not want computers that are controlled by this policy setting to search for missing feature files in Windows Update, select **Never attempt to download payload from Windows Update**.

5. If the computers that are controlled by this policy setting typically receive updates through WSUS, but you prefer to go through Windows Update and not WSUS to find missing feature files, select **Contact Windows Update directly to download repair content instead of Windows Server Update Services (WSUS)**.

6. Click **OK** when you are finished changing this policy setting, and then close the Group Policy editor.

## <a name=BKMK_methods></a>Methods of removing feature files
Two methods are available for removing feature files from Windows Server in a Features on Demand configuration.

-   The `remove` parameter of the `Uninstall-WindowsFeature` cmdlet lets you delete feature files from a server or offline virtual hard disk (VHD) that is running  Windows Server 2012 R2  or  Windows Server 2012 . Valid values for the `remove` parameter are the names of roles, role services, and features.

-   Deployment Image Servicing and Management (DISM) commands let you create custom WIM files that conserve disk space by omitting feature files that are either not needed, or can be obtained from other, remote sources. For more information about using DISM to prepare custom images, see [How to Enable or Disable Windows Features](/previous-versions/windows/it-pro/windows-8.1-and-8/hh824822(v=win.10)).

## <a name=BKMK_remove></a>Remove feature files by using Uninstall-WindowsFeature
You can use the Uninstall-WindowsFeature cmdlet both to uninstall roles, role services, and features from servers and offline VHDs that are running  Windows Server 2012 R2  or  Windows Server 2012 , and to delete feature files. You can both uninstall and delete the same roles, role services, and features in the same command if desired.

> [!IMPORTANT]
> When you delete feature files for a role, role service, or feature, roles, role services, and features that depend upon the files you are removing are also deleted. If you are deleting feature files for a role service or subfeature, and no other role services or subfeatures for the parent role or feature remain installed, then files for the entire parent role or feature are deleted. To view all feature files that would be deleted by the `Uninstall-WindowsFeature -remove` command, add the `whatif` parameter to the command to run it and view results without actually deleting feature files.

#### To remove role and feature files by using Uninstall-WindowsFeature

1.  Do one of the following to open a Windows PowerShell session with elevated user rights.

    > [!NOTE]
    > if you are uninstalling roles and features from a remote server, you do not need to run Windows PowerShell with elevated user rights.

    -   On the Windows desktop, right-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.

    -   On the Windows **start** screen, right-click the Windows PowerShell tile, and then on the app bar, click **Run as Administrator**.

    -   On a server that is running the Server Core installation option, type **PowerShell** into a command prompt, and then press **Enter**.

2.  Type the following, and then press **Enter**.

    ```
    Uninstall-WindowsFeature -Name <feature_name> -computerName <computer_name> -remove
    ```

    **Example:** Remote Desktop Licensing is the last remaining role service of Remote Desktop Services that is installed. The command uninstalls Remote Desktop Licensing, and then deletes feature files for the entire Remote Desktop Services role from the specified server, *contoso_1*.

    ```
    Uninstall-WindowsFeature -Name rdS-Licensing -computerName contoso_1 -remove
    ```

    **Example:** In the following example, the command removes active directory Domain Services and Group Policy Management from an offline VHD. The role and feature are first uninstalled, then their feature files removed entirely from the offline VHD, *Contoso.vhd*.

    > [!NOTE]
    > You must add the `computerName` parameter if you are running the cmdlet from a computer that is running Windows 8.1 or Windows 8.
    >
    > if you enter the name of a VHD file from a network share, that share must grant **Read** and **Write** permissions to the computer account of the server that you selected to mount the VHD. User-only account access is not sufficient. The share can grant **Read** and **Write** permissions to the **Everyone** group to allow access to the VHD, but for security reasons, this is not recommended.

    ```
    Uninstall-WindowsFeature -Name AD-Domain-Services,GPMC -VHD C:\WS2012VHDs\Contoso.vhd -computerName ContosoDC1
    ```

## See Also
[Install or Uninstall Roles, Role Services, or Features](install-or-uninstall-roles-role-services-or-features.md)
[Windows Server Installation Options](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831786(v=ws.11))
[How to Enable or Disable Windows Features](/previous-versions/windows/it-pro/windows-8.1-and-8/hh824822(v=win.10))
[Deployment Image Servicing and Management (DISM) Overview](/previous-versions/windows/it-pro/windows-8.1-and-8/hh825236(v=win.10))
