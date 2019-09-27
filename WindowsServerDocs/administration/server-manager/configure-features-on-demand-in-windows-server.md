---
title: Configure Features on Demand in Windows Server
description: "Server Manager"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-server-manager
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e663bbea-d025-41fa-b16c-c2bff00a88e8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Configure Features on Demand in Windows Server

>Applies To: Windows Server 2016

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

## <a name="BKMK_store"></a>Create a feature file or side-by-side store
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

## <a name="BKMK_methods"></a>Methods of removing feature files
Two methods are available for removing feature files from Windows Server in a Features on Demand configuration.

-   The `remove` parameter of the `Uninstall-WindowsFeature` cmdlet lets you delete feature files from a server or offline virtual hard disk (VHD) that is running  Windows Server 2012 R2  or  Windows Server 2012 . Valid values for the `remove` parameter are the names of roles, role services, and features.

-   Deployment Image Servicing and Management (DISM) commands let you create custom WIM files that conserve disk space by omitting feature files that are either not needed, or can be obtained from other, remote sources. For more information about using DISM to prepare custom images, see [How to Enable or Disable Windows Features](https://technet.microsoft.com/library/hh824822.aspx).

## <a name="BKMK_remove"></a>Remove feature files by using Uninstall-WindowsFeature
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
[Windows Server Installation Options](https://technet.microsoft.com/library/hh831786.aspx)
[How to Enable or Disable Windows Features](https://technet.microsoft.com/library/hh824822.aspx)
[Deployment Image Servicing and Management (DISM) Overview](https://technet.microsoft.com/library/hh825236.aspx)


