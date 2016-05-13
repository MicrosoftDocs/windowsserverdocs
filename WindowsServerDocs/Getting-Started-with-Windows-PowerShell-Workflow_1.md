---
title: Getting Started with Windows PowerShell Workflow_1
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: e8f7b144-513d-4191-9d46-1f986b0fb698
---
# Getting Started with Windows PowerShell Workflow_1
IT Pros often automate the management of their multi\-device environments by running sequences of long\-running tasks, or *workflows*, that can affect multiple managed computers or devices at the same time. [!INCLUDE[wps_2](includes/wps_2_md.md)] Workflow lets IT Pros and developers leverage the benefits of [Windows Workflow Foundation](http://go.microsoft.com/fwlink/?LinkID=251922) with the automation capabilities and ease of [!INCLUDE[wps_2](includes/wps_2_md.md)]. [!INCLUDE[wps_2](includes/wps_2_md.md)] Workflow functionality was introduced in [!INCLUDE[win8_server_1](includes/win8_server_1_md.md)] and [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], and is part of [!INCLUDE[wps_2](includes/wps_2_md.md)] 3.0 and newer releases of [!INCLUDE[wps_2](includes/wps_2_md.md)]. [!INCLUDE[wps_2](includes/wps_2_md.md)] Workflow helps automate the distribution, orchestration, and completion of multi\-device tasks, freeing users and administrators to focus on higher\-level tasks.

[!INCLUDE[wps_2](includes/wps_2_md.md)], first introduced with the release of [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)] and [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], is a distributed automation engine, command\-line shell, and scripting language that is constructed on the Microsoft® .NET Framework. It is designed especially for automating Windows management.

[!INCLUDE[wps_2](includes/wps_2_md.md)] Workflow is a key feature of [!INCLUDE[wps_2](includes/wps_2_md.md)] 3.0, [!INCLUDE[wps_2](includes/wps_2_md.md)] 4.0, and [!INCLUDE[wps_2](includes/wps_2_md.md)] 5.0. For more information about [!INCLUDE[wps_2](includes/wps_2_md.md)], see [What’s New in Windows PowerShell](http://go.microsoft.com/fwlink/?LinkID=307123).

This topic includes the following sections.

-   [Overview of Windows PowerShell Workflow](#BKMK_over)

-   [How workflows and Windows PowerShell scripts differ](#BKMK_when)

-   [Creating and importing workflows by using the Visual Studio Workflow Designer](#BKMK_XAML)

## <a name="BKMK_over"></a>Overview of Windows PowerShell Workflow
A workflow is a sequence of programmed, connected steps that perform long\-running tasks or require the coordination of multiple steps across multiple devices or managed nodes. [!INCLUDE[wps_2](includes/wps_2_md.md)] Workflow lets IT pros and developers author sequences of multi\-device management *activities*, or single tasks within a workflow, as workflows. By design, workflows can be long\-running, repeatable, frequent, parallelizable, interruptible, stoppable, and restartable. They can be suspended and resumed; they can also continue after an unexpected interruption, such as a network outage or computer restart.

[!INCLUDE[wps_2](includes/wps_2_md.md)] workflows can be authored or defined by using [!INCLUDE[wps_2](includes/wps_2_md.md)] syntax, or XAML files. For more information about authoring a [!INCLUDE[wps_2](includes/wps_2_md.md)] script\-based workflow, see [Writing a Script Workflow_1](Writing-a-Script-Workflow_1.md). For more information about XAML\-based workflows, see [Importing and creating workflows by using the Visual Studio Workflow Designer](#BKMK_XAML) in this topic.

By using the `RunAs` functionality of [!INCLUDE[wps_2](includes/wps_2_md.md)], custom session configurations let delegated or subordinate IT Pros run workflows or activities within a workflow.

### Activities
An *activity* is a specific task that you want a workflow to perform. Just as a script is composed of one or more commands, a workflow is composed of one or more activities that are carried out in a sequence. A script can also be used as a single command in another script, and a workflow can be used as an activity within another workflow.

### Benefits of Windows PowerShell Workflow
The following list describes many of the benefits of [!INCLUDE[wps_2](includes/wps_2_md.md)] Workflow.

-   **Use [!INCLUDE[wps_2](includes/wps_2_md.md)] scripting syntax**

    IT Pros can use [!INCLUDE[wps_2](includes/wps_2_md.md)] scripting skills to author script\-based workflows by using the extensible [!INCLUDE[wps_2](includes/wps_2_md.md)] language. [!INCLUDE[wps_2](includes/wps_2_md.md)] script\-based workflows are easy to write, and can be shared easily by pasting them into an email, or publishing them on webpages.

-   **Multi\-device management**

    You can simultaneously apply workflow tasks to hundreds of managed nodes. [!INCLUDE[wps_2](includes/wps_2_md.md)] Workflow adds common parameters to workflows automatically, such as `PSComputerName`, to enable multi\-device management scenarios. For more information about parameters that are reserved for workflows, see “Reserved Words in Workflows” in [Workflow Authoring Reference Topics_1](Workflow-Authoring-Reference-Topics_1.md).

-   **Running a single task to manage complex, end\-to\-end processes**

    You can combine related scripts or commands that act on an entire scenario into a single workflow. Status and progress of activities within the workflow are visible at any time.

-   **Automated failure recovery**

    Workflows survive both planned and unplanned interruptions, such as computer restarts. You can suspend workflow operation, then restart or resume the workflow from the point at which it was suspended. You can author checkpoints as part of your workflow, so that you can resume the workflow from the last persisted task \(or checkpoint\), instead of restarting the workflow from the beginning.

-   **Connection and activity retries**

    By using workflow common parameters, workflow users can retry connections to managed nodes if network connection failures occur. Workflow authors can also specify activities that must run again if the activity cannot be completed on one or more managed nodes \(for example, if a target computer was offline while the activity was running\).

-   **Connect and disconnect**

    Users can connect and disconnect from the computer that is running the workflow, but the workflow remains running. For example, if you are running the workflow and managing the workflow on two different computers, you can log off of or restart the computer from which you are managing the workflow, and monitor workflow operations from another computer \(such as a home computer\) without interrupting the workflow.

-   **Task scheduling**

    Workflow tasks can be scheduled, and started when specific conditions are met, as with any other [!INCLUDE[wps_2](includes/wps_2_md.md)] cmdlet or script.

## <a name="BKMK_when"></a>How Windows PowerShell Workflow and Windows PowerShell scripts differ
In a script, the entire script runs in the same *runspace*, the operating environment that defines which commands, variables, and other elements are available. In a workflow, each activity within the workflow can run in a different runspace. Variables that are created at the top level of the entire workflow are available throughout the workflow; if they are created at the script or command level, they are available for the command or script, but not available to the entire workflow.

In general, you should consider using a workflow instead of a cmdlet or script when you must meet any of the following requirements.

-   You need to perform a long\-running task that combines multiple steps in a sequence.

-   You need to perform a task that runs on multiple devices.

-   You need to perform a task that requires checkpointing or persistence.

-   You need to perform a long\-running task that is asynchronous, restartable, parallelizable, or interruptible.

-   You need to run a task on a large scale, or in high availability environments, potentially requiring throttling and connection pooling.

## <a name="BKMK_XAML"></a>Creating and importing workflows by using the Visual Studio Workflow Designer
In addition to authoring workflows that use [!INCLUDE[wps_2](includes/wps_2_md.md)] scripts, you can author workflows by using the Visual Studio Workflow Designer. Workflows that you author in Visual Studio Workflow Designer have a XAML file name extension. You can invoke and import workflows in [!INCLUDE[wps_2](includes/wps_2_md.md)] Workflow that are authored in Workflow Designer, and expose [!INCLUDE[wps_2](includes/wps_2_md.md)] cmdlets as activities within the Workflow Designer.

For more information about authoring workflows in the Visual Studio Workflow Designer, see [Using the Workflow Designer](http://msdn.microsoft.com/library/dd489402.aspx) in the Visual Studio documentation on MSDN.

### Windows PowerShell Workflow activities in the Visual Studio Workflow Designer
[!INCLUDE[wps_2](includes/wps_2_md.md)] includes built\-in activities for most [!INCLUDE[wps_2](includes/wps_2_md.md)] cmdlets. These activities are packaged in assemblies with names that match the name of the [!INCLUDE[wps_2](includes/wps_2_md.md)] module that contains the cmdlets. The following is the list of [!INCLUDE[wps_2](includes/wps_2_md.md)] activity assemblies that are installed in the Global Assembly Cache \(GAC\).

-   Microsoft.PowerShell.Activities

-   Microsoft.PowerShell.Core.Activities

-   Microsoft.PowerShell.Diagnostics.Activities

-   Microsoft.PowerShell.Management.Activities

-   Microsoft.PowerShell.Security.Activities

-   Microsoft.PowerShell.Utility.Activities

-   Microsoft.WSMan.Management.Activities

For more information about adding an activity to the Toolbox from an assembly, see [How to: Add Activities to the Toolbox](http://go.microsoft.com/fwlink/?LinkId=251930).

## See Also
[Configuring Your Workflow Environment_1](Configuring-Your-Workflow-Environment_1.md)
[Running a Windows PowerShell Workflow_1](Running-a-Windows-PowerShell-Workflow_1.md)
[Writing a Script Workflow_1](Writing-a-Script-Workflow_1.md)
[What's New in Windows Workflow Foundation 4.0](http://go.microsoft.com/fwlink/?LinkID=251922)
[about_Jobs](http://go.microsoft.com/fwlink/?LinkID=113251)
[about_Workflow_Common_Parameters](http://go.microsoft.com/fwlink/?LinkID=222527)
[about_Workflows](http://go.microsoft.com/fwlink/?LinkID=253422)


