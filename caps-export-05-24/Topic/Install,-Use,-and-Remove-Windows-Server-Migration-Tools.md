---
title: Install, Use, and Remove Windows Server Migration Tools
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7265c927-1855-41f5-9145-b690348ab1e3
author: jpjofre
---
# Install, Use, and Remove Windows Server Migration Tools
[!INCLUDE[wsmt](../Token/wsmt_md.md)] Installation, Access, and Removal describes how to locate, install, use, and remove [!INCLUDE[wsmt](../Token/wsmt_md.md)]. Administrators can use [!INCLUDE[wsmt](../Token/wsmt_md.md)] to migrate server roles, features, operating system settings, and other data and shares to computers that are running [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] or [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)].  
  
This topic supports migrations in which the migration destination servers are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. For information about how to prepare to use [!INCLUDE[wsmt](../Token/wsmt_md.md)] for migrations to servers that are running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], see [Windows Server Migration Tools Installation, Access, and Removal](http://technet.microsoft.com/library/dd379545.aspx).  
  
[!INCLUDE[wsmt](../Token/wsmt_md.md)] installation and preparation can be divided into the following stages.  
  
1.  Installing [!INCLUDE[wsmt](../Token/wsmt_md.md)] on destination servers that run [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
2.  Creating deployment folders on migration destination servers, for copying to source servers.  
  
3.  Copying deployment folders from destination servers to source servers.  
  
4.  Registering [!INCLUDE[wsmt](../Token/wsmt_md.md)] on source servers.  
  
## In this guide  
  
-   [Supported operating systems](#BKMK_supported)  
  
-   [Permissions required to perform steps in this guide](#BKMK_permissions)  
  
-   [Prepare for installation](#BKMK_prep)  
  
-   [Install Windows Server Migration Tools](#BKMK_installing)  
  
-   [Use Windows Server Migration Tools](#BKMK_using)  
  
-   [Remove Windows Server Migration Tools](#BKMK_remove)  
  
## <a name="BKMK_supported"></a>Supported operating systems  
The following table indicates the Windows Server operating systems that [!INCLUDE[wsmt](../Token/wsmt_md.md)] supports.  
  
|Source server processor|Source server operating system|Destination server operating system|Destination server processor|  
|---------------------------|----------------------------------|---------------------------------------|--------------------------------|  
|x86\- or x64\-based|Windows Server 2003 with Service Pack 2|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], both full and Server Core installation options|x64\-based|  
|x86\- or x64\-based|Windows Server 2003 R2|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], both full and Server Core installation options|x64\-based|  
|x86\- or x64\-based|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], full installation option|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|Server Core installation option of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|Server Core installation option of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], both full and Server Core installation options|x64\-based|  
|x64\-based|Server Core installation option of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], both full and Server Core installation options|x64\-based|  
  
The versions of operating systems shown in the previous table are the oldest combinations of operating systems and service packs that are supported. If available, newer service packs are supported.  
  
Migrations between physical operating systems and virtual operating systems are supported. Migrations that use [!INCLUDE[wsmt](../Token/wsmt_md.md)] to migrate to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] support cross\-subnet migrations.  
  
Migration from a source server to a destination server that is running an operating system in a different system UI language \(that is, the installed language\) than the source server is not supported. For example, you cannot use [!INCLUDE[wsmt](../Token/wsmt_md.md)] to migrate roles, operating system settings, data, or shares from a computer that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] in the French system UI language to a computer that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] in the German system UI language.  
  
> [!NOTE]  
> The system UI language is the language of the localized installation package that was used to set up the Windows operating system.  
  
Both x86\- and x64\-based migrations are supported for Windows Server 2003 and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. All editions of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] are x64\-based.  
  
Roles that are running on the Server Core installation option of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] cannot be migrated, because the Microsoft .NET Framework is not available in the Server Core installation option of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
## <a name="BKMK_permissions"></a>Permission requirements  
At minimum, you must be a member of the **Administrators** group on both source and destination servers to install, remove, or set up [!INCLUDE[wsmt](../Token/wsmt_md.md)].  
  
## <a name="BKMK_prep"></a>Prepare for installation  
Follow the steps in this section if you are registering [!INCLUDE[wsmt](../Token/wsmt_md.md)] on migration source servers that are running Windows Server 2003, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and if the source server is running an older release of Windows Server than the migration destination server. For example, if the source server is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], but the destination server is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Otherwise, see [Install Windows Server Migration Tools](#BKMK_installing).  
  
> [!NOTE]  
> All commands in this guide are case\-insensitive unless specifically noted.  
  
### Windows Server 2012 source server  
Complete the following tasks to prepare a source server that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] for migration in which the destination server is running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
-   Verify that the source server has sufficient disk space \(at least 23 MB\) to store the [!INCLUDE[wsmt](../Token/wsmt_md.md)] deployment folder.  
  
### Windows Server 2008 R2 source server  
Complete the following tasks to prepare a source server that is running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] for [!INCLUDE[wsmt](../Token/wsmt_md.md)].  
  
-   Verify that the source server has sufficient disk space \(at least 23 MB\) to store the [!INCLUDE[wsmt](../Token/wsmt_md.md)] deployment folder.  
  
### Windows Server 2008 source server  
Complete the following tasks to prepare a source server that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] for [!INCLUDE[wsmt](../Token/wsmt_md.md)].  
  
-   Verify that the source server has sufficient disk space \(at least 23 MB\) to store the [!INCLUDE[wsmt](../Token/wsmt_md.md)] deployment folder.  
  
-   Install [!INCLUDE[wps_2](../Token/wps_2_md.md)] by using [!INCLUDE[sm](../Token/sm_md.md)] or by running the [!INCLUDE[sm](../Token/sm_md.md)] command prompt tool, **ServerManagerCmd.exe**. For more information about how to add features to the server by using **ServerManagerCmd.exe**, see [Overview of Server Manager Commands](http://go.microsoft.com/fwlink/?LinkId=253074) in the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)][!INCLUDE[sm](../Token/sm_md.md)] Help.  
  
### Windows Server 2003 or Windows Server 2003 R2 source server  
Complete the following tasks to prepare a source server that is running Windows Server 2003 or Windows Server 2003 R2 for [!INCLUDE[wsmt](../Token/wsmt_md.md)].  
  
-   Verify that the source server has sufficient disk space \(at least 25 MB\) to store the [!INCLUDE[wsmt](../Token/wsmt_md.md)] deployment folder.  
  
-   Download and install Microsoft .NET Framework  2.0. Microsoft .NET Framework  2.0 is available for download from the [Microsoft Web site](http://go.microsoft.com/fwlink/?LinkId=272306).  
  
-   Download and install [!INCLUDE[wps_2](../Token/wps_2_md.md)] 1.0, or a later version. [!INCLUDE[wps_2](../Token/wps_2_md.md)] 1.0 is available for download from the [Microsoft Web site](http://go.microsoft.com/fwlink/?LinkId=133160).  
  
> [!NOTE]  
> [!INCLUDE[wps_2](../Token/wps_2_md.md)] 2.0 and 3.0 are available in a graphically\-oriented version, [!INCLUDE[ise_2](../Token/ise_2_md.md)]. For more information about [!INCLUDE[ise_2](../Token/ise_2_md.md)], see [Windows PowerShell 3.0 Integrated Scripting Environment \(ISE\)](http://go.microsoft.com/fwlink/?LinkId=253076).  
  
### Other computers in your enterprise  
Because you might have to restart the server after you install [!INCLUDE[wsmt](../Token/wsmt_md.md)], notify users in advance that they might experience downtime while the server operating system loads. To minimize downtime, and reduce its effect on users in your enterprise, install [!INCLUDE[wsmt](../Token/wsmt_md.md)] during off\-peak hours.  
  
## <a name="BKMK_installing"></a>Install Windows Server Migration Tools  
This section describes how to install [!INCLUDE[wsmt](../Token/wsmt_md.md)] on both source and destination servers. If both source and destination computers are running the same operating system on which [!INCLUDE[wsmt](../Token/wsmt_md.md)] is available for installation \(if both servers are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], or both servers are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]\), install [!INCLUDE[wsmt](../Token/wsmt_md.md)] on both computers by following installation steps in either [Full installation option of Windows Server 2012 R2 or Windows Server 2012](#BKMK_ws2012full) or [Server Core installation option of Windows Server 2012 R2 or Windows Server 2012](#BKMK_ws2012core).  
  
If you plan to migrate roles, features, or other data from computers that are running older releases of Windows Server than your destination server—that is, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or Windows Server 2003—you must complete the following additional tasks after you install [!INCLUDE[wsmt](../Token/wsmt_md.md)] on destination servers.  
  
1.  Create a [!INCLUDE[wsmt](../Token/wsmt_md.md)] deployment folder on destination servers. For more information, see [Creating a deployment folder on destination computers](#BKMK_creating).  
  
2.  Register [!INCLUDE[wsmt](../Token/wsmt_md.md)] on source computers that are running older releases of Windows Server than your destination server; that is, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or Windows Server 2003. For more information, see [Registering Windows Server Migration Tools on source computers](#BKMK_registering).  
  
For more detailed information, see [Windows Server 2008 or Windows Server 2003 source computers](#BKMK_install2003).  
  
### <a name="BKMK_ws2012full"></a>Full installation option of Windows Server 2012 R2 or Windows Server 2012  
  
##### To install Windows Server Migration Tools  
  
1.  Do one of the following to open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session with elevated user rights.  
  
    > [!NOTE]  
    > If you are installing [!INCLUDE[wsmt](../Token/wsmt_md.md)] from a remote server, you do not need to run [!INCLUDE[wps_2](../Token/wps_2_md.md)] with elevated user rights.  
  
    -   On the Windows desktop, right\-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.  
  
    -   On the Windows **Start** screen, right\-click the [!INCLUDE[wps_2](../Token/wps_2_md.md)] tile, and then on the app bar, click **Run as Administrator**.  
  
2.  Type the following, and then press **Enter**. If you are installing the feature on the local server, omit the `ComputerName` parameter.  
  
    ```  
    Install-WindowsFeature Migration –ComputerName <computer_name>  
    ```  
  
    > [!NOTE]  
    > You can also install [!INCLUDE[wsmt](../Token/wsmt_md.md)] on a full installation of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] by using the [!INCLUDE[arfw](../Token/arfw_md.md)] in [!INCLUDE[sm](../Token/sm_md.md)]. For more information about how to use the [!INCLUDE[arfw](../Token/arfw_md.md)], see [Install or uninstall roles, role services, or features](http://go.microsoft.com/fwlink/?LinkID=239563).  
  
### <a name="BKMK_ws2012core"></a>Server Core installation option of Windows Server 2012 R2 or Windows Server 2012  
[!INCLUDE[wps_2](../Token/wps_2_md.md)] is installed by default on the Server Core installation option of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. By default, programs on the Server Core installation option run as Administrator, so there is no need to start [!INCLUDE[wps_2](../Token/wps_2_md.md)] with elevated user rights.  
  
##### To install Windows Server Migration Tools on a Server Core installation of Windows Server 2012  
  
1.  Open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session by typing the following in the current command prompt session, and then press **Enter**.  
  
    ```  
    powershell.exe  
    ```  
  
2.  In the [!INCLUDE[wps_2](../Token/wps_2_md.md)] session, install [!INCLUDE[wsmt](../Token/wsmt_md.md)] by using the [!INCLUDE[wps_2](../Token/wps_2_md.md)]**Install\-WindowsFeature** cmdlet for [!INCLUDE[sm](../Token/sm_md.md)]. In the [!INCLUDE[wps_2](../Token/wps_2_md.md)] session, type the following, and then press **Enter**. Omit the `ComputerName` parameter if you are installing [!INCLUDE[wsmt](../Token/wsmt_md.md)] on the local server.  
  
    ```  
    Install-WindowsFeature Migration –ComputerName <computer_name>  
    ```  
  
### <a name="BKMK_install2003"></a>Windows Server 2012, Windows Server 2008 R2, Windows Server 2008, or Windows Server 2003 source computers  
Complete the following two tasks to install [!INCLUDE[wsmt](../Token/wsmt_md.md)].  
  
1.  Create deployment folders for source computers by running the **smigdeploy.exe** tool \(included with [!INCLUDE[wsmt](../Token/wsmt_md.md)]\) on your destination server. For more information, see [Creating a deployment folder on destination computers](#BKMK_creating).  
  
2.  Register [!INCLUDE[wsmt](../Token/wsmt_md.md)] on source computers that are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or Windows Server 2003 by using **SmigDeploy.exe**. For more information, see [Registering Windows Server Migration Tools on source computers](#BKMK_registering).  
  
#### <a name="BKMK_creating"></a>Creating a deployment folder on destination computers  
This procedure describes how to create the deployment folder on your destination server that is running [!INCLUDE[wsmt](../Token/wsmt_md.md)]. After you create the deployment folder, copy it to the local drive of a migration source server that is running an older release of Windows Server; that is, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or Windows Server 2003.  
  
###### To create a deployment folder on destination computers  
  
1.  If you have not already installed [!INCLUDE[wsmt](../Token/wsmt_md.md)] on the destination server, see [Installing Windows Server Migration Tools](#BKMK_installing) in this topic.  
  
2.  Open a Command Prompt window with elevated user rights. On the Server Core installation option of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], an elevated command prompt is already opened by default. On the full installation option, type **cmd** on the **Start** screen, right\-click the **Command Prompt** tile, and then click **Run as administrator**.  
  
3.  At the command prompt, change to the directory in which the **smigdeploy.exe** tool is stored. Type the following, and then press **Enter**.  
  
    ```  
    cd %Windir%\System32\ServerMigrationTools\  
    ```  
  
4.  Do one of the following to create a [!INCLUDE[wsmt](../Token/wsmt_md.md)] deployment folder.  
  
    -   To create a folder to copy to an x64\-based computer that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], where [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is running on the destination server, type the following, in which *deployment folder path* represents the path of the deployment folder on the source computer, and then press **Enter**.  
  
        ```  
        SmigDeploy.exe /package /architecture amd64 /os WS12 /path <deployment folder path>  
        ```  
  
    -   To create a folder to copy to an x64\-based computer that is running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], type the following, in which *deployment folder path* represents the path of the deployment folder on the source computer, and then press **Enter**.  
  
        ```  
        SmigDeploy.exe /package /architecture amd64 /os WS08R2 /path <deployment folder path>  
        ```  
  
    -   To create a folder to copy to an x64\-based source computer that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], type the following, in which *deployment folder path* represents the path of the deployment folder on the source computer, and then press **Enter**.  
  
        ```  
        SmigDeploy.exe /package /architecture amd64 /os WS08 /path <deployment folder path>  
        ```  
  
    -   To create a folder to copy to an x64\-based source computer that is running Windows Server 2003, type the following, in which *deployment folder path* represents the path of the deployment folder on the source computer, and then press **Enter**.  
  
        ```  
        SmigDeploy.exe /package /architecture amd64 /os WS03 /path <deployment folder path>  
        ```  
  
    -   To create a folder to copy to an x86\-based source computer that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], type the following, in which *deployment folder path* represents the path of the deployment folder on the source computer, and then press **Enter**.  
  
        ```  
        SmigDeploy.exe /package /architecture X86 /os WS08 /path <deployment folder path>  
        ```  
  
    -   To create a folder to copy to an x86\-based source computer that is running Windows Server 2003, type the following, in which *deployment folder path* represents the path of the deployment folder on the source computer, and then press **Enter**.  
  
        ```  
        SmigDeploy.exe /package /architecture X86 /os WS03 /path <deployment folder path>  
        ```  
  
> [!NOTE]  
> Each of these commands creates a deployment folder named in the format SMT\_<*Operating System*>\_<*Architecture*> and stores it in the specified deployment folder path.  
  
You can also specify a network path as the path for the deployment folder. Verify that you have access to the network path before you create the deployment folder.  
  
For more information about **SmigDeploy.exe**, at a command prompt, type **SmigDeploy.exe \/?**, and then press **Enter**.  
  
#### <a name="BKMK_registering"></a>Registering Windows Server Migration Tools on source computers  
Before you can run the [!INCLUDE[wsmt](../Token/wsmt_md.md)] snap\-in for the first time on a source server that is running an older release of Windows Server than your destination server, it must be registered with [!INCLUDE[wps_2](../Token/wps_2_md.md)]. Use **SmigDeploy.exe** to register the [!INCLUDE[wsmt](../Token/wsmt_md.md)] snap\-in on a migration source server that is running an older release of Windows Server than your destination server \(that is, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or Windows Server 2003\).  
  
Before you start the procedure in this section, verify the following.  
  
-   Microsoft .NET Framework 2.0 is installed on computers that are running Windows Server 2003.  
  
-   [!INCLUDE[wps_2](../Token/wps_2_md.md)] 1.0 or a later version is installed on source computers that are running either [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or Windows Server 2003. \([!INCLUDE[wps_2](../Token/wps_2_md.md)] is already installed on computers that are running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].\)  
  
###### To register Windows Server Migration Tools  
  
1.  Copy the [!INCLUDE[wsmt](../Token/wsmt_md.md)] deployment folder that was created by using the procedure in [Creating a deployment folder on destination computers](#BKMK_creating) to a local drive on the source computer that is running an older release of Windows Server than your destination server. Be sure that the operating system architecture of the deployment folder matches that of the source computer to which you are copying the folder.  
  
    For example, the **SMT\_WS08\_amd64** folder should only be copied to the local drive of an AMD64 source computer that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
2.  On the source computer, open a Command Prompt window.  
  
    -   On computers that are running Windows Server 2003 or the Server Core installation option of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you do not have to run a Command Prompt window with elevated user rights. Click **Start**, click **Run**, type **cmd**, and then click **OK**.  
  
    -   On computers that are running the full installation options of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you must open a Command Prompt window with elevated user rights. To do this, right\-click the shortcut for Command Prompt, and then click **Run as Administrator**.  
  
3.  At the command prompt, change to the directory to which you copied the [!INCLUDE[wsmt](../Token/wsmt_md.md)] deployment folder in step 1.  
  
    > [!NOTE]  
    > You can register and run [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets from a removable drive, CD\-ROM, or DVD\-ROM. However, to increase the reliability of registering the cmdlets, we recommend that you copy the deployment folder to a local drive of the source computer. You cannot register or run [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets from a network location.  
  
4.  In the deployment folder directory, type the following command to register [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets, and then press **Enter**.  
  
    ```  
    .\Smigdeploy.exe  
    ```  
  
> [!NOTE]  
> When registration is finished, a status message is displayed that indicates that the registration finished successfully, and a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session opens. You can run [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets in this [!INCLUDE[wps_2](../Token/wps_2_md.md)] session. If you close the [!INCLUDE[wps_2](../Token/wps_2_md.md)] session, see [Windows Server 2003 or Windows Server 2008 source computers](#BKMK_runws03) for information about how to access and use [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets.  
  
## <a name="BKMK_using"></a>Use Windows Server Migration Tools  
This section describes how to run [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets.  
  
-   [Full installation option of Windows Server 2012 R2](#BKMK_w12r2full)  
  
-   [Server Core installation option of Windows Server 2012 R2](#BKMK_w12r2core)  
  
-   [Full installation option of Windows Server 2012](#BKMK_w8full)  
  
-   [Server Core installation option of Windows Server 2012](#BKMK_w8core)  
  
-   [Full installation option of Windows Server 2008 R2](#BKMK_ws08r2full)  
  
-   [Server Core installation option of Windows Server 2008 R2](#BKMK_scows08r2)  
  
-   [Windows Server 2003 or Windows Server 2008 source computers](#BKMK_runws03)  
  
### <a name="BKMK_w12r2full"></a>Full installation option of Windows Server 2012 R2  
Start [!INCLUDE[wps_2](../Token/wps_2_md.md)] and run [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets by using either of the following procedures. These can apply to either source or destination servers.  
  
##### To run Windows Server Migration Tools from the Start screen  
  
-   To open a [!INCLUDE[wsmt](../Token/wsmt_md.md)] custom [!INCLUDE[wps_2](../Token/wps_2_md.md)] session, right\-click the **Windows Server Migration Tools** tile, and then on the app bar, click **Run as administrator**.  
  
##### To run Windows Server Migration Tools in a new Windows PowerShell session  
  
1.  Do one of the following to open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session with elevated user rights.  
  
    -   On the Windows desktop, right\-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.  
  
    -   On the Windows **Start** screen, right\-click the [!INCLUDE[wps_2](../Token/wps_2_md.md)] tile, and then on the app bar, click **Run as Administrator**.  
  
2.  Load [!INCLUDE[wsmt](../Token/wsmt_md.md)] into your [!INCLUDE[wps_2](../Token/wps_2_md.md)] session. To load [!INCLUDE[wsmt](../Token/wsmt_md.md)], type the following, and then press **Enter**.  
  
    ```  
    Add-PSSnapin Microsoft.Windows.ServerManager.Migration  
    ```  
  
### <a name="BKMK_w12r2core"></a>Server Core installation option of Windows Server 2012 R2  
This procedure applies to either source or destination servers.  
  
##### To run Windows Server Migration Tools cmdlets  
  
1.  Type **powershell** into a command prompt, and then press **Enter**.  
  
2.  Load [!INCLUDE[wsmt](../Token/wsmt_md.md)] into your [!INCLUDE[wps_2](../Token/wps_2_md.md)] session. To load [!INCLUDE[wsmt](../Token/wsmt_md.md)], type the following, and then press **Enter**.  
  
    ```  
    Add-PSSnapin Microsoft.Windows.ServerManager.Migration  
    ```  
  
### <a name="BKMK_w8full"></a>Full installation option of Windows Server 2012  
Start [!INCLUDE[wps_2](../Token/wps_2_md.md)] and run [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets by using either of the following procedures. These can apply to either source or destination servers.  
  
##### To run Windows Server Migration Tools from the Start screen  
  
-   To open a [!INCLUDE[wsmt](../Token/wsmt_md.md)] custom [!INCLUDE[wps_2](../Token/wps_2_md.md)] session, right\-click the **Windows Server Migration Tools** tile, and then on the app bar, click **Run as administrator**.  
  
##### To run Windows Server Migration Tools in a new Windows PowerShell session  
  
1.  Do one of the following to open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session with elevated user rights.  
  
    -   On the Windows desktop, right\-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.  
  
    -   On the Windows **Start** screen, right\-click the [!INCLUDE[wps_2](../Token/wps_2_md.md)] tile, and then on the app bar, click **Run as Administrator**.  
  
2.  Load [!INCLUDE[wsmt](../Token/wsmt_md.md)] into your [!INCLUDE[wps_2](../Token/wps_2_md.md)] session. To load [!INCLUDE[wsmt](../Token/wsmt_md.md)], type the following, and then press **Enter**.  
  
    ```  
    Add-PSSnapin Microsoft.Windows.ServerManager.Migration  
    ```  
  
### <a name="BKMK_w8core"></a>Server Core installation option of Windows Server 2012  
This procedure applies to either source or destination servers.  
  
##### To run Windows Server Migration Tools cmdlets  
  
1.  Type **powershell** into a command prompt, and then press **Enter**.  
  
2.  Load [!INCLUDE[wsmt](../Token/wsmt_md.md)] into your [!INCLUDE[wps_2](../Token/wps_2_md.md)] session. To load [!INCLUDE[wsmt](../Token/wsmt_md.md)], type the following, and then press **Enter**.  
  
    ```  
    Add-PSSnapin Microsoft.Windows.ServerManager.Migration  
    ```  
  
### <a name="BKMK_ws08r2full"></a>Source computer running full installation option of Windows Server 2008 R2  
If you close the [!INCLUDE[wps_2](../Token/wps_2_md.md)] session that is opened automatically when **SmigDeploy.exe** finishes registering the [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets, you can run [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets by using any of the following procedures.  
  
##### To run Windows Server Migration Tools from the Start menu  
  
-   To open a [!INCLUDE[wsmt](../Token/wsmt_md.md)] custom [!INCLUDE[wps_2](../Token/wps_2_md.md)] session, click **Start**, point to **Administrative Tools**, open the **Windows Server Migration Tools** folder, right\-click **Windows Server Migration Tools**, and then click **Run as administrator**.  
  
##### To run Windows Server Migration Tools in a new Windows PowerShell session  
  
1.  Open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session with elevated user rights. To do this, click **Start**, click **All Programs**, click **Accessories**, click **Windows PowerShell**, right\-click the [!INCLUDE[wps_2](../Token/wps_2_md.md)] shortcut, and then click **Run as administrator**.  
  
2.  Load [!INCLUDE[wsmt](../Token/wsmt_md.md)] into your [!INCLUDE[wps_2](../Token/wps_2_md.md)] session. To load [!INCLUDE[wsmt](../Token/wsmt_md.md)], type the following, and then press **Enter**.  
  
    ```  
    Add-PSSnapin Microsoft.Windows.ServerManager.Migration  
    ```  
  
### <a name="BKMK_scows08r2"></a>Source computer running Server Core installation option of Windows Server 2008 R2  
Start [!INCLUDE[wps_2](../Token/wps_2_md.md)] and use [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets by using any of the following procedures.  
  
##### To open Windows PowerShell together with Windows Server Migration Tools  
  
-   At a command prompt on a computer that is running the Server Core installation option of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], type the following, and then press **Enter**.  
  
    ```  
    powershell.exe -PSConsoleFile %SystemRoot%\system32\ServerMigrationTools\ServerMigration.psc1  
    ```  
  
##### To open Windows PowerShell and load Windows Server Migration Tools separately  
  
1.  At a command prompt, type the following, and then press **Enter**.  
  
    ```  
    powershell  
    ```  
  
2.  Load [!INCLUDE[wsmt](../Token/wsmt_md.md)] into the [!INCLUDE[wps_2](../Token/wps_2_md.md)] session. To load [!INCLUDE[wsmt](../Token/wsmt_md.md)], type the following, and then press **Enter**.  
  
    ```  
    Add-PSSnapin Microsoft.Windows.ServerManager.Migration  
    ```  
  
### <a name="BKMK_runws03"></a>Windows Server 2003 or Windows Server 2008 source computers  
If you close the [!INCLUDE[wps_2](../Token/wps_2_md.md)] session that is opened automatically when **SmigDeploy.exe** finishes registering the [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets, you can run [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets by using any of the following procedures.  
  
##### To open Windows Server Migration Tools from the Start menu  
  
-   Do one of the following:  
  
    -   On computers that are running Windows Server 2003, click **Start**, point to **Administrative Tools**, open the **Windows Server Migration Tools** folder, and then click **Windows Server Migration Tools**.  
  
    -   On computers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], click **Start**, point to **Administrative Tools**, open the **Windows Server Migration Tools** folder, right\-click **Windows Server Migration Tools**, and then click **Run as administrator**.  
  
##### To open Windows PowerShell and load Windows Server Migration Tools separately  
  
1.  Do one of the following:  
  
    -   On computers that are running Windows Server 2003, open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session by clicking **Start**, clicking **All Programs**, opening the **Windows PowerShell** folder, and clicking the **Windows PowerShell** shortcut.  
  
    -   On computers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session with elevated user rights. To do this, click **Start**, click **All Programs**, open the **Windows PowerShell** folder, right\-click the **Windows PowerShell** shortcut, and then click **Run as administrator**.  
  
2.  In the [!INCLUDE[wps_2](../Token/wps_2_md.md)] session, type the following to load the [!INCLUDE[wsmt](../Token/wsmt_md.md)] snap\-in, and then press **Enter**.  
  
    ```  
    Add-PSSnapin Microsoft.Windows.ServerManager.Migration  
    ```  
  
##### To open Windows PowerShell together with Windows Server Migration Tools from a Command Prompt window  
  
1.  Do one of the following.  
  
    -   On computers that are running Windows Server 2003, open a Command Prompt window by clicking **Start**, clicking **Run**, typing **cmd**, and then pressing **Enter**.  
  
    -   On computers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], open a Command Prompt window with elevated user rights. To do this, click **Start**, click **All Programs**, click **Accessories**, right\-click the **Command Prompt** shortcut, and then click **Run as administrator**.  
  
2.  At the command prompt, change directories to the location of the [!INCLUDE[wsmt](../Token/wsmt_md.md)] deployment folder.  
  
3.  In the deployment directory, type the following to open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session with preloaded [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets, and then press **Enter**.  
  
    ```  
    PowerShell.exe -PSConsoleFile ServerMigration.psc1  
    ```  
  
### Additional resources and next steps for using Windows Server Migration Tools  
For more information about [!INCLUDE[wsmt](../Token/wsmt_md.md)] and [!INCLUDE[wps_2](../Token/wps_2_md.md)], see the following resources.  
  
-   For detailed, step\-by\-step information about how to migrate specific roles or data, see the [Windows Server Migration Portal](http://technet.microsoft.com/windowsserver/jj554790.aspx) on the Windows Server TechCenter.  
  
-   In a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session, type the following, and then press **Enter** to view detailed information about how to use a specific [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlet.  
  
    ```  
    Get-Help <cmdlet_name> -full  
    ```  
  
-   See the [Windows PowerShell](http://go.microsoft.com/fwlink/?LinkID=238561) page on the Microsoft Web site.  
  
## <a name="BKMK_remove"></a>Remove Windows Server Migration Tools  
Follow the procedures in this section to remove [!INCLUDE[wsmt](../Token/wsmt_md.md)] from computers.  
  
### Full installation option of Windows Server 2012 R2 or Windows Server 2012  
You can use either [!INCLUDE[sm](../Token/sm_md.md)] deployment cmdlets, or the [!INCLUDE[arfw](../Token/arfw_md.md)] in [!INCLUDE[sm](../Token/sm_md.md)] to remove [!INCLUDE[wsmt](../Token/wsmt_md.md)]. If [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] was a source computer for a migration to a server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], unregister [!INCLUDE[wsmt](../Token/wsmt_md.md)] on the source computer instead of uninstalling [!INCLUDE[wsmt](../Token/wsmt_md.md)]. For more information, see [Source computers running full and Server Core installation options of Windows Server 2012](#BKMK_unreg2012).  
  
##### To uninstall Windows Server Migration Tools from the full installation option  
  
1.  Do one of the following to open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session with elevated user rights.  
  
    > [!NOTE]  
    > If you are uninstalling [!INCLUDE[wsmt](../Token/wsmt_md.md)] from a remote server, you do not need to run [!INCLUDE[wps_2](../Token/wps_2_md.md)] with elevated user rights.  
  
    -   On the Windows desktop, right\-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.  
  
    -   On the Windows **Start** screen, right\-click the [!INCLUDE[wps_2](../Token/wps_2_md.md)] tile, and then on the app bar, click **Run as Administrator**.  
  
2.  Type the following, and then press **Enter**. If you are uninstalling the feature from the local server, omit the `ComputerName` parameter.  
  
    ```  
    Uninstall-WindowsFeature Migration –ComputerName <computer_name>  
    ```  
  
    > [!NOTE]  
    > You can also uninstall [!INCLUDE[wsmt](../Token/wsmt_md.md)] from a full installation of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] by using the [!INCLUDE[arfw](../Token/arfw_md.md)] in [!INCLUDE[sm](../Token/sm_md.md)]. For more information about how to use the [!INCLUDE[arfw](../Token/arfw_md.md)], see [Install or uninstall roles, role services, or features](http://go.microsoft.com/fwlink/?LinkID=239563).  
  
### Server Core installation option of Windows Server 2012 R2 or Windows Server 2012  
[!INCLUDE[wps_2](../Token/wps_2_md.md)] is installed by default on the Server Core installation option of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. By default, programs on the Server Core installation option run as Administrator, so there is no need to start [!INCLUDE[wps_2](../Token/wps_2_md.md)] with elevated user rights.  
  
##### To uninstall Windows Server Migration Tools from the Server Core installation option  
  
1.  Open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session by typing the following in the current command prompt session, and then press **Enter**.  
  
    ```  
    powershell.exe  
    ```  
  
2.  In the [!INCLUDE[wps_2](../Token/wps_2_md.md)] session, uninstall [!INCLUDE[wsmt](../Token/wsmt_md.md)] by using the [!INCLUDE[wps_2](../Token/wps_2_md.md)]**Uninstall\-WindowsFeature** cmdlet for [!INCLUDE[sm](../Token/sm_md.md)]. In the [!INCLUDE[wps_2](../Token/wps_2_md.md)] session, type the following, and then press **Enter**. Omit the `ComputerName` parameter if you are uninstalling [!INCLUDE[wsmt](../Token/wsmt_md.md)] from the local server.  
  
    ```  
    Uninstall-WindowsFeature Migration –ComputerName <computer_name>  
    ```  
  
### <a name="BKMK_unreg2012"></a>Source computers running full and Server Core installation options of Windows Server 2012  
To remove [!INCLUDE[wsmt](../Token/wsmt_md.md)] from a source computer that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and on which [!INCLUDE[wsmt](../Token/wsmt_md.md)] was registered for migrating to a destination server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you must first reverse the registration of [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets, and then remove the deployment folder.  
  
##### To remove Windows Server Migration Tools from Windows Server 2012  
  
1.  Do one of the following.  
  
    -   On computers that are running the full installation option of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], open a Command Prompt window with elevated user rights. To do this, on the **Start** screen, type **cmd**. Right\-click the **Command Prompt** tile, and then click **Run as Administrator**.  
  
    -   On computers that are running the Server Core installation option of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], select the Command Prompt window to bring it in focus. You do not need to open a command prompt with elevated user rights on Server Core installations.  
  
2.  Change directories to the location of the [!INCLUDE[wsmt](../Token/wsmt_md.md)] deployment folder.  
  
3.  Type the following to reverse the registration of [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets, and then press **Enter**.  
  
    ```  
    SmigDeploy.exe /unregister  
    ```  
  
4.  When **SmigDeploy.exe** has finished, delete the [!INCLUDE[wsmt](../Token/wsmt_md.md)] deployment folder and its contents.  
  
### Source computers running full and Server Core installation options of Windows Server 2008 R2  
To remove [!INCLUDE[wsmt](../Token/wsmt_md.md)], you must first reverse the registration of [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets, and then remove the deployment folder.  
  
##### To remove Windows Server Migration Tools from Windows Server 2008 R2  
  
1.  Do one of the following.  
  
    -   On computers that are running the full installation option of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], open a Command Prompt window with elevated user rights. To do this, click **Start**, click **All Programs**, click **Accessories**, right\-click **Command Prompt**, and then click **Run as administrator**.  
  
    -   On computers that are running the Server Core installation option of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], select the Command Prompt window to bring it in focus. You do not need to open a command prompt with elevated user rights on Server Core installations.  
  
2.  Change directories to the location of the [!INCLUDE[wsmt](../Token/wsmt_md.md)] deployment folder.  
  
3.  Type the following to reverse the registration of [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets, and then press **Enter**.  
  
    ```  
    SmigDeploy.exe /unregister  
    ```  
  
4.  When **SmigDeploy.exe** has finished, delete the [!INCLUDE[wsmt](../Token/wsmt_md.md)] deployment folder and its contents.  
  
### Windows Server 2003 or Windows Server 2008 source computers  
To remove [!INCLUDE[wsmt](../Token/wsmt_md.md)], you must first reverse the registration of [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets, and then remove the deployment folder.  
  
##### To remove Windows Server Migration Tools from Windows Server 2003 or Windows Server 2008  
  
1.  Do one of the following.  
  
    -   On computers that are running Windows Server 2003, open a Command Prompt window by clicking **Start**, clicking **Run**, typing **cmd**, and then pressing **Enter**.  
  
    -   On computers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], open a Command Prompt window with elevated user rights. To do this, click **Start**, click **All Programs**, click **Accessories**, right\-click **Command Prompt**, and then click **Run as administrator**.  
  
2.  At a command prompt, change directories to the location of the [!INCLUDE[wsmt](../Token/wsmt_md.md)] deployment folder.  
  
3.  Type the following to reverse the registration of [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets, and then press **Enter**.  
  
    ```  
    SmigDeploy.exe /unregister  
    ```  
  
4.  When **SmigDeploy.exe** has finished, delete the [!INCLUDE[wsmt](../Token/wsmt_md.md)] deployment folder and its contents.  
  
## See Also  
[Windows Server Migration Portal](http://technet.microsoft.com/windowsserver/jj554790.aspx)  
[Windows PowerShell](http://go.microsoft.com/fwlink/?LinkID=238561)  
[Install or uninstall roles, role services, or features](http://go.microsoft.com/fwlink/?LinkID=239563)  
[Adding Server Roles and Features](http://go.microsoft.com/fwlink/?LinkId=133158)  
  
