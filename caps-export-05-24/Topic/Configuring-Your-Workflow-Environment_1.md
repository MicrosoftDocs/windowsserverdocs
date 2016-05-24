---
title: Configuring Your Workflow Environment_1
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e9387ff8-db1f-4fa6-ba75-328488d3bd54
author: jpjofre
---
# Configuring Your Workflow Environment_1
Now that you understand the definition and benefits of workflows in [!INCLUDE[wps_2](../Token/wps_2_md.md)], as described in [Getting Started with Windows PowerShell Workflow_1](../Topic/Getting-Started-with-Windows-PowerShell-Workflow_1.md), you are ready to set up your environment to run workflows.  
  
This topic contains the following sections.  
  
-   [Supported operating systems and architectures](#BKMK_os)  
  
-   [Workflow configurations](#BKMK_configs)  
  
-   [Prepare computers to run workflows](#BKMK_prepare)  
  
## <a name="BKMK_os"></a>Supported operating systems and architectures  
[!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow runs on any system on which [!INCLUDE[wps_2](../Token/wps_2_md.md)] 3.0 or newer releases of [!INCLUDE[wps_2](../Token/wps_2_md.md)] are available. For a complete list of [!INCLUDE[wps_2](../Token/wps_2_md.md)] requirements, see [Windows PowerShell System Requirements](http://go.microsoft.com/fwlink/?LinkId=253659).  
  
Download and install [Windows Management Framework 3.0](http://go.microsoft.com/fwlink/?LinkID=229019), [Windows Management Framework 4.0](http://go.microsoft.com/fwlink/?LinkId=293881), or [Windows Management Framework 5.0](http://go.microsoft.com/fwlink/?LinkID=395058) on managed nodes if your workflows contain Common Information model \(CIM\) activities. CIM is an extensible, object\-oriented data model that contains information about different parts of an enterprise. For more information about CIM, see [Common Information Model](http://go.microsoft.com/fwlink/?LinkId=253631) on MSDN. You can also install Windows Management Framework \(WMF\) on managed nodes that are running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] with Service Pack 1, [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] with Service Pack 1, or Windows Management Framework 3.0 on [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] with Service Pack 2 to run workflows on those computers, but this is not required unless your workflows contain CIM activities.  
  
## <a name="BKMK_configs"></a>Workflow configurations  
Workflow operations involve the following three nodes. The nodes can all be located on the same computer, or distributed across multiple computers.  
  
-   The node on which the workflow is running, sometimes called the workflow server.  
  
-   The node on which an administrator is managing the workflow or viewing workflow status. This is sometimes called the *client*.  
  
-   Roles, features, settings, or physical or virtual devices on which the workflow actions are carried out. These are called managed nodes.  
  
Computers that are running any of the supported operating systems and architectures can function as any part of a workflow configuration. The following diagram shows the possible setup configurations for workflows.  
  
![](../Image/Workflows.jpg)  
  
-   **Configuration 1:** The server, client, and managed nodes are running on separate computers. Note that the command flow is from client, through server, to managed nodes. In this scenario, the client node must be running [!INCLUDE[wps_2](../Token/wps_2_md.md)] 2.0 to communicate with the computer that is running the workflow, but [!INCLUDE[wps_2](../Token/wps_2_md.md)] 3.0 or [!INCLUDE[wps_2](../Token/wps_2_md.md)] 4.0 is not required on the client.  
  
-   **Configuration 2:** The workflow server and client nodes are both running on the same computer. The versions of [!INCLUDE[wps_2](../Token/wps_2_md.md)] and .NET Framework that are running on that computer satisfy the highest requirements, those for the computer that is running the workflow. Managed nodes are running on one or more remote devices.  
  
-   **Configuration 3:** The workflow server, client, and managed nodes are running on the same computer or device. The versions of [!INCLUDE[wps_2](../Token/wps_2_md.md)] and .NET Framework that are running on that computer satisfy the highest requirements, those for the workflow server.  
  
### <a name="bkmk_downloadloc"></a>Download locations for .NET Framework and Windows PowerShell  
For information about download locations for required versions of .NET Framework and [!INCLUDE[wps_2](../Token/wps_2_md.md)], see [Windows PowerShell System Requirements](http://technet.microsoft.com/library/hh847769).  
  
## <a name="BKMK_prepare"></a>Prepare computers to run workflows  
Procedures for setting up your computers to run workflows are available in this section.  
  
### <a name="BKMK_prep"></a>To prepare for remote management  
  
1.  On the computer from which you are running and managing the workflow, start [!INCLUDE[wps_2](../Token/wps_2_md.md)] with the **Run as administrator** option as described in [Starting Windows PowerShell](http://go.microsoft.com/fwlink/?LinkId=253646). Alternatively, you can run a new [!INCLUDE[wps_2](../Token/wps_2_md.md)] session as administrator by running the following command in a session that is already open.  
  
    **Start\-Process PowerShell \-Verb RunAs**  
  
2.  Do one of the following to enable [!INCLUDE[wps_2](../Token/wps_2_md.md)] remote management on participating computers, such as the workflow server and managed nodes.  
  
    > [!NOTE]  
    > While [!INCLUDE[wps_2](../Token/wps_2_md.md)] remote management must be enabled on the server node, you do not need to enable it on managed nodes unless your workflow requires it. Neither [!INCLUDE[wps_2](../Token/wps_2_md.md)] nor WMF is required on managed nodes, unless your workflow contains CIM activities.  
  
    -   On a workflow server that is running [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)], [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[wps_2](../Token/wps_2_md.md)] remote management is enabled by default. Go on to the next step.  
  
    -   On a workflow server that is running [!INCLUDE[winthreshold_client_2](../Token/winthreshold_client_2_md.md)], [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], or [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], right\-click the **Windows PowerShell** tile, and then click **Run as administrator**. Type **Enable\-PSRemoting**, and then press **Enter**. Press **Y** to confirm that you want to enable remote management.  
  
    -   On a workflow server that is running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], [Windows Management Framework 4.0](http://go.microsoft.com/fwlink/?LinkId=293881) or [Windows Management Framework 3.0](http://go.microsoft.com/fwlink/?LinkID=229019) must be installed first. After WMF is installed, click **Start**, point to **All Programs**, click **Accessories**, click **Windows PowerShell**, right\-click the **Windows PowerShell** shortcut, and then click **Run as Administrator**. Type **Enable\-PSRemoting**, and then press **Enter**. Press **Y** to confirm that you want to enable remote management.  
  
    -   On a workflow server that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], [Windows Management Framework 3.0](http://go.microsoft.com/fwlink/?LinkID=229019) must be installed first. After WMF 3.0 is installed, open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session with elevated user rights. To do this, click **Start**, click **All Programs**, open the **Windows PowerShell** folder, right\-click the **Windows PowerShell** shortcut, and then click **Run as administrator**. Type **Enable\-PSRemoting**, and then press **Enter**. Press **Y** to confirm that you want to enable remote management.  
  
### Workflow session configurations  
A session configuration is a group of settings on the local computer that define the access rights and commands that are available for the [!INCLUDE[wps_2](../Token/wps_2_md.md)] sessions that are created when remote or local users connect to [!INCLUDE[wps_2](../Token/wps_2_md.md)] on a computer.  
  
The **Enable\-PSRemoting** command that you run on the workflow server in the preceding section creates default session configurations, including the recommended and default session configuration for workflows. We recommend using the default session configuration because it provides the following benefits to your workflows automatically.  
  
-   **Performance optimization.** Default settings of the [New-PSWorkflowExecutionOption](http://technet.microsoft.com/library/hh849862.aspx) cmdlet, such as activity time\-out periods and maximum allowed processes per activity, are designed to help constrain resource usage and improve workflow performance.  
  
-   **SharedHost mode.** SharedHost mode allows users to start a workflow on one computer, log off, log on to another computer, and reconnect to the workflow. The workflow session configuration uses the same process for a user across different computers, as long as the user is connecting to the same session configuration, and is logged on to the new computer with the same access rights as the user had on the first computer.  
  
-   **Automatic multi\-device support.** The workflow session configuration is optimized for running workflows on multiple devices, offering the following benefits.  
  
    -   Workflow jobs are automatically created for each target device.  
  
    -   [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow automatically throttles the number of simultaneous workflows and remote operations that can run on a target device.  
  
    -   Manages lifecycle of remote connections – creation, reuse, and deletion  
  
You can create a custom session configuration for your organization’s needs, which might differ from the workflow session configuration. You can add your workflows to your custom session configuration, so they are available automatically when a user connects to the session configuration.  
  
For more information about session configurations, see [about_Session_Configurations](http://go.microsoft.com/fwlink/?LinkID=145152).  
  
The following procedure shows how to create a custom session configuration named **Microsoft.PowerShell.MySession**.  
  
##### To create custom session configurations  
  
1.  Start a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session with elevated user rights \(Run as Administrator\). The procedure [To prepare for remote management](#BKMK_prep) in this topic describes how to do this.  
  
2.  We recommend increasing the default Windows Remote Management \(WinRM\) memory quota to 1 GB in sessions that are using the session configuration for workflows. To do this, run the following command to create a session configuration option object, and then save the object in the **$MoreMemory** variable. The variable is used in the next step.  
  
    **$MoreMemory \= New\-PSSessionConfigurationOption \-MaxMemoryPerShellMB 1000**  
  
    > [!NOTE]  
    > The value shown in the preceding command is an example. You can use lower values; the minimum requirement is 400 MB.  
  
3.  To add the new session configuration, run the **Register\-PSSessionConfiguration** cmdlet as shown in the following script sample.  
  
    1.  Set the value of the **SessionConfigurationType** parameter to **Workflow**.  
  
    2.  Set the value of the **ModulePath** parameter to the location of the modules that contain your workflows.  
  
    3.  Set the value of the **SessionConfigurationOption** parameter to the **$MoreMemory** variable that you created in the preceding step.  
  
    ```  
    Register-PSSessionConfiguration -Name Microsoft.PowerShell.MySession `  
    -SessionConfigurationType Workflow `  
    -ModulePath $pshome\modules\MyModule`  
    -SessionConfigurationOption $MoreMemory  
    ```  
  
## See Also  
[Getting Started with Windows PowerShell Workflow_1](../Topic/Getting-Started-with-Windows-PowerShell-Workflow_1.md)  
[Running a Windows PowerShell Workflow_1](../Topic/Running-a-Windows-PowerShell-Workflow_1.md)  
[Writing a Script Workflow_1](../Topic/Writing-a-Script-Workflow_1.md)  
  
