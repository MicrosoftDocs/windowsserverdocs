---
title: Running a Windows PowerShell Workflow
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0ff6eb3d-064a-431b-a147-d5c0ac57877b
author: jpjofre
---
# Running a Windows PowerShell Workflow
After setting up your [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow environment as described in [Configuring Your Workflow Environment](../Topic/Configuring-Your-Workflow-Environment.md), and authoring or finding a workflow, you are ready to start running your workflow.  
  
Running a workflow is like running any [!INCLUDE[wps_2](../Token/wps_2_md.md)] command. You can run the `Get-Command` cmdlet to discover workflows, and run `Get-Help` to get available help about workflows. Running a workflow is as simple as entering the *verb*\-*noun* name of the workflow \(or *verb*\-*noun*`–PsComputerName`*managednode1*, *managednode2*\).  
  
This topic contains the following sections.  
  
-   [Create a session to the computer that runs your workflow](#BKMK_start)  
  
-   [Connect or reconnect to a running workflow](#BKMK_knect)  
  
-   [Run the workflow](#BKMK_run)  
  
-   [Run workflows as jobs](#BKMK_asjob)  
  
-   [View data about workflows](#BKMK_data)  
  
-   [Add checkpoints to a workflow](#BKMK_check)  
  
-   [Get help for your workflow](#BKMK_help)  
  
-   [Find error logs for workflows](#BKMK_error)  
  
## <a name="BKMK_start"></a>Create a session to the computer that runs your workflow  
You create a new session to connect to the computer that is running your workflow if you are starting the workflow from the beginning, or if you have closed \(and not merely disconnected from\) an earlier session that is connected to the workflow computer. If you are reconnecting to a workflow that is already in progress, you do not need to create a new session to connect to the computer that is running the workflow; you can connect to the existing session. The following procedure is an example of how to create a new session on a local or remote computer.  
  
### <a name="BKMK_startserver"></a>To create a new workflow session  
  
1.  Start [!INCLUDE[wps_2](../Token/wps_2_md.md)] with the **Run as administrator** option as described in [Starting Windows PowerShell](http://go.microsoft.com/fwlink/?LinkId=253646). You do not need to run [!INCLUDE[wps_2](../Token/wps_2_md.md)] with elevated user rights \(Run as Administrator\) if you are connecting from a remote computer.  
  
2.  Start a remote [!INCLUDE[wps_2](../Token/wps_2_md.md)] session that is connected to the computer that you want to run your workflow, and save the session in a variable. This session can be on your local computer \(**localhost**\) or on a remote computer. For example, the following commands start a remote session on the local computer, and save the session in the `$WFServer` variable. The session is configured to use the default workflow session configuration that is described in [Configuring Your Workflow Environment](../Topic/Configuring-Your-Workflow-Environment.md).  
  
    In the following example, the command starts a workflow session on the local computer, and saves the session in the **$WFServer** variable. By using the `New-PSWorkflowSession` cmdlet, the session is configured to use the default workflow session configuration.  
  
    **$WFServer \= New\-PSWorkflowSession**  
  
    In the following example, the command starts the workflow session on a different computer, *Server01*, and saves the session in the **$WFServer** variable.  
  
    **$WFServer \= New\-PSWorkflowSession \-ComputerName Server01 \-credential***DomainName*\\*UserName*  
  
    Because the workflow server session runs on a remote computer in the preceding example, the user must provide explicit credentials. Explicit credentials are not required if the session configuration includes **RunAs** functionality, where all users share a set of credentials that are defined in the session configuration.  
  
3.  Alternatively, you can create a new [!INCLUDE[wps_2](../Token/wps_2_md.md)] session by running the `New-PSSession` cmdlet, as described in [New\-PSSession](http://technet.microsoft.com/library/hh849717.aspx). When you run `New-PSSession` instead of `New-PSWorkflowSession`, you can add the `ConfigurationName` parameter to specify a session configuration other than the default [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow session configuration. To specify the default [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow session configuration, add `–ConfigurationName Microsoft.PowerShell.Workflow` to the command.  
  
You can now run workflows in this session, either from a module, or by starting a standalone XAML or [!INCLUDE[wps_2](../Token/wps_2_md.md)] script\-based workflow.  
  
## <a name="BKMK_knect"></a>Connect or reconnect to a running workflow  
If you are reconnecting to a workflow that you have already started, you can specify the job ID or name of the workflow to reconnect. You can also run the [Connect\-PSSession](http://technet.microsoft.com/library/hh849728.aspx) cmdlet to reconnect to a disconnected session that was connected to the computer that is running your workflow.  
  
#### To connect or reconnect to a running workflow  
  
1.  Start a new session that is connected to the computer that is running your workflow. Save the session connection in a variable, as shown in the following example.  
  
    **$WFServer\=New\-PSWorkflowSession \-ComputerName Server01**  
  
2.  Get the list of jobs that are running on the computer that you specified in step 1.  
  
    **Invoke\-Command $WFServer {Get\-Job}**  
  
3.  In the results, locate the workflow to which you want to reconnect.  
  
4.  If the workflow is not suspended, go on to the next step. To resume a suspended workflow, run the following command, where *$WFServer* represents the variable into which your session connection is saved.  
  
    **Invoke\-Command $WFServer {Resume\-Job <Job name or ID>}**  
  
5.  To get information about the progress and status of a workflow, run `Receive-Job` as shown in the following example.  
  
    **Invoke\-Command $WFServer {Receive\-Job <Job name or ID>}**  
  
## <a name="BKMK_run"></a>Run the workflow  
The following procedure shows how to run a workflow that is packaged in a module. This step is required only if you did not specify a root module or a nested module key in the module manifest.  
  
#### To import and run a workflow in a module  
  
1.  If you do not have an existing active session to the computer on which you want to run the workflow, create a new session as described in [To connect a new workflow session to a computer that is running a workflow](#BKMK_startserver).  
  
2.  Copy the module directory that you created in [Saving Your Workflow in a Module](../Topic/Saving-Your-Workflow-in-a-Module.md) to the computer on which you are running the workflow. For convenience, copy it to the **Modules** directory \(for example, `$env:C:\Users\<user_name>\Documents\WindowsPowerShell\Modules`\) on that computer.  
  
3.  Optionally, import the module into the session that is connected to the computer running the workflow by using either of the following two commands. In [!INCLUDE[wps_2](../Token/wps_2_md.md)] 3.0, modules are imported into a session automatically the first time a user runs a cmdlet that is part of the module. Add **Invoke\-Command** to run an **Import\-Module** command in the workflow server session. The optional **Verbose** parameter displays the functions that the module adds to the session.  
  
    **Invoke\-Command \-Session $<name of session variable> \-ScriptBlock {Import\-Module <ModuleName> \-Verbose}**  
  
    For example, the following command imports the **RoleManager** module into the workflow server session.  
  
    **Invoke\-Command $WFServer {Import\-Module RoleManager \-Verbose}**  
  
    The **Import\-Module** cmdlet imports workflows into your session as functions. You can now run the workflows in the session that is connected to the computer on which you want to run your workflow.  
  
4.  Type the workflow name, and press **Enter** to start the workflow. For example, to start the workflow that was saved in a module in [Saving Your Workflow in a Module](../Topic/Saving-Your-Workflow-in-a-Module.md), type **Install\-Role \-PSComputerName <managed\_node\_names>**, and then press **Enter**.  
  
The following procedure explains how to run a XAML\-based workflow that is not in a module in the session that is connected to the computer on which you want to run your workflow. After you import the workflow XAML files, you can use the workflows in your workflow server session. For more information about XAML\-based workflows that you can use with [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow, see “Creating and importing workflows using the Visual Studio Workflow Designer” in [Getting Started with Windows PowerShell Workflow](../Topic/Getting-Started-with-Windows-PowerShell-Workflow.md).  
  
#### To import and run a workflow from a XAML workflow file  
  
1.  Start a workflow server session, as described in [To start a workflow server session](#BKMK_startserver).  
  
2.  Run the following command to import the workflow XAML file into your workflow server session.  
  
    **Invoke\-Command \-Session $<name of session variable> \-Scriptblock {Import\-Module <Path\_To\_Xaml\_File>}**  
  
    For example, the following command imports the **Install\-Role** and **Set\-Role** workflows into the workflow server session.  
  
    **Invoke\-Command $WFServer {Import\-Module \-Path D:\\Temp\\Install\-Role.xaml, D:\\Temp\\Set\-Role.xaml}**  
  
## <a name="BKMK_asjob"></a>Run workflows as jobs  
You can use the **AsJob** workflow common parameter that is added to all workflows in [!INCLUDE[wps_2](../Token/wps_2_md.md)] to run a workflow as a [!INCLUDE[wps_2](../Token/wps_2_md.md)] job. For more information about jobs, see [about\_Jobs](http://go.microsoft.com/fwlink/?LinkID=113251). You can use `Job` cmdlets to start, stop, suspend, or resume workflows. To run a workflow as a job, enter a command in the following format.  
  
*Verb\-Noun* \-PSComputerName *ManagedNode01*, *ManagedNode02* \-AsJob  
  
> [!NOTE]  
> `Invoke-Command` and the variable in which your workflow session is stored \(in this example, **$WFServer**\) are necessary in the following commands only if you have not already created a session that is connected to the computer running your workflow. If you are already in that session, you need only to run the commands that are inside braces.  
  
#### To run workflows as jobs  
  
-   The following are examples of running and managing workflows by using `Job` cmdlets.  
  
    -   Use the **AsJob** parameter to run the **Install\-Role** workflow as a job. The **PSComputerName** parameter specifies the computers on which the roles are installed. In the following example, a workflow is run as a job.  
  
        **Invoke\-Command $WFServer {Install\-Role \-PSComputerName Server01, Server02 \-AsJob}**  
  
    -   Get all the jobs that are running in the workflow server session. Each workflow instance is run as a separate job. The jobs are shown as running on the local computer \(**localhost**\), because the job object is created locally in the workflow server session, even though the job is running on two different remote computers.  
  
        **Invoke\-Command $WFServer {Get\-Job}**  
  
        The results are similar to the following.  
  
        ```  
        Id  Name  State      HasMoreData  Location   Command  
        --  ----  -----      -----------  --------   -------  
        1   Job1  Running    True         Server01  install-role  
        2   Job2  Running    True         Server02  install-role  
  
        ```  
  
    -   Get the workflow jobs that affect a specific managed node, by adding the `Filter` parameter.  
  
        **Invoke\-Command $WFServer {Get\-Job \-Filter {PSComputerName \= "Server01"}**  
  
    -   Get the status of a job.  
  
        **Invoke\-Command $WFServer { \(get\-job \-name Job1\).state}**  
  
    -   Wait for a job to finish.  
  
        **Invoke\-Command $WFServer {wait\-job \-name Job1}**  
  
    -   Get the results of a job.  
  
        **Invoke\-Command $WFServer {receive\-job \-name Job1}**  
  
    -   Delete or remove a job.  
  
        **Invoke\-Command $WFServer {remove\-job \-name Job1}**  
  
#### To suspend and resume workflows as jobs  
  
-   The following are examples of suspending and resuming workflows by using `Job` cmdlets.  
  
    -   Suspend a workflow as a job.  
  
        **Invoke\-Command $WFServer {suspend\-job \-name Job1}**  
  
    -   Resume a suspended workflow as a job.  
  
        **Invoke\-Command $WFServer {resume\-job \-name Job1}**  
  
## <a name="BKMK_data"></a>View data about workflows  
Workflows are added to a session as functions. You can use the same commands that you would use to examine functions to examine your workflows.  
  
> [!NOTE]  
> If you are already in the session that is connected to the computer on which your workflow is running, you do not need to add `Invoke-Command $variable`. Run only the commands that are inside braces.  
  
#### To view information about workflows in your session  
  
-   The following commands are examples of information that you can get about your workflow.  
  
    -   Find functions that a workflow module added to your session.  
  
        **Invoke\-Command $WFServer {get\-command \-module RoleManager}**  
  
    -   Examine a workflow or function.  
  
        **Invoke\-Command $WFServer {ls function:\\Install\-Role}**  
  
    -   Use the `Get-Command` cmdlet to display the properties of a workflow function.  
  
        **Invoke\-Command $WFServer {get\-command Install\-Role }**  
  
    -   Use the `Get-Command` cmdlet to get the syntax of a workflow function.  
  
        **Invoke\-Command $WFServer {get\-command install\-role \-syntax}**  
  
    -   Examine the objects that a workflow function returns.  
  
        **Invoke\-Command $WFServer {install\-role | get\-member}**  
  
## <a name="BKMK_check"></a>Add checkpoints to a workflow  
You can add checkpoints to the workflows that you run and suppress its default checkpoints. You cannot remove or suppress explicit checkpoints in a workflow.  
  
A *checkpoint* is a snapshot of the workflow state and data that is taken while the workflow runs. The checkpoint is saved to disk on the computer on which the workflow runs or to a SQL database. If the workflow is suspended or interrupted, it can be resumed from the most recent checkpoint, rather than restarting.  
  
Most workflows have explicit checkpoints. Additional checkpoints are useful when the network is not stable, the workflow is frequently interrupted, or the workflow is running on a very large number of devices, However, adding too many checkpoints can make the workflow run very slowly. Be sure that the time it takes to write the checkpoint data to disk is less than the time it would take to rerun the workflow if it is interrupted.  
  
To adjust the checkpoints in a workflow, use the **PSPersist** workflow common parameter. The following are the valid values.  
  
$True  
Adds a checkpoint after each activity. These checkpoint are additions to the default checkpoints taken at the beginning and end of the workflow and any checkpoints that are explicitly specified in the workflow.  
  
$False  
Suppresses the default checkpoints that are taken at the beginning and end of the workflow. This value does not affect explicit checkpoints.  
  
The following examples run the Set\-WorkflowState workflow with the PSPersist parameter set to $True and $False.  
  
```  
PS C:\>Set-WorkflowState -PSPersist $True  
```  
  
```  
PS C:\>Set-WorkflowState -PSPersist $False  
```  
  
## <a name="BKMK_help"></a>Get help for your workflow  
If Help is available for a workflow that you are running, you can get help about what the workflow does, and how to run it, by typing the following, and then pressing **Enter**.  
  
**Get\-Help** <*WorkflowVerb\-WorkflowNoun*>  
  
For more information about how to write help for a workflow, see [Writing Help for a Script Workflow](../Topic/Writing-Help-for-a-Script-Workflow.md).  
  
## <a name="BKMK_error"></a>Find error logs for workflows  
Error logs for workflows are stored on the computer that is running the workflow \(sometimes called the workflow server\). You can find them in the following Event Tracing for Windows \(ETW\) channel, or path in the Event Viewer snap\-in. Event ID 45079 shows each activity that is run.  
  
**Applications and Services Logs\\Microsoft\\Windows\\PowerShell**  
  
## See Also  
[Getting Started with Windows PowerShell Workflow](../Topic/Getting-Started-with-Windows-PowerShell-Workflow.md)  
[Configuring Your Workflow Environment](../Topic/Configuring-Your-Workflow-Environment.md)  
[Writing a Script Workflow](../Topic/Writing-a-Script-Workflow.md)  
[about\_Jobs](http://go.microsoft.com/fwlink/?LinkID=113251)  
  
