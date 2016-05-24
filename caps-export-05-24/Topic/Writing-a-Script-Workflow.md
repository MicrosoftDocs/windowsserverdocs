---
title: Writing a Script Workflow
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 956ed71b-23eb-42e8-9c71-91dc22ca4df2
author: jpjofre
---
# Writing a Script Workflow
The topics in this section explain how to write a workflow in the [!INCLUDE[wps_1](../Token/wps_1_md.md)] scripting language; the same language you use to write functions and scripts in [!INCLUDE[wps_2](../Token/wps_2_md.md)]. You can run the workflows that you write at the command line, include them in scripts, and include them in script modules.  
  
For information about writing workflows in XAML, the native language of Windows Workflow Foundation, see [Writing a Windows PowerShell Workflow](http://go.microsoft.com/fwlink/?LinkID=246399) in the MSDN Library.  
  
## Planning a Workflow  
[!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow is a powerful solution that can gather data from and make changes to hundreds of computers every time it runs. Plan the workflow design for simplicity and efficiency. Keep in mind that the workflow can suspend itself or be suspended by users, that it can be controlled from numerous PSSessions that connect to a single server\-side process, that it can survive restarts, include commands and functions that run in parallel, and that each command runs its own session.  
  
Use the following planning guidelines  
  
-   If you are new to workflows, review the reference topics in this section, including [Syntactic Differences Between Script Workflows and Scripts_1](../Topic/Syntactic-Differences-Between-Script-Workflows-and-Scripts_1.md).  
  
-   Begin by enumerating the tasks that the workflow will perform. Mark the sections that can run concurrently or do not need to run in a predetermined order. Within those sections, mark any that must run in sequential order.  
  
-   Organize tasks into functions within the workflow. For each task, use an existing [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlet or create a new command and add a checkpoint after each critical step.  
  
-   Workflows are designed to run on multiple target computers. You do not need to create remote sessions or use remote commands, such as those that use the Invoke\-Command cmdlet, in the workflow.  
  
-   As with any script that runs on multiple computers, consider variations among the computers that might affect the operation of the script, including varying operating systems, devices, file system organization, environment variables, and [!INCLUDE[wps_2](../Token/wps_2_md.md)] versions.  
  
-   Plan the help topics for the workflow in advance. Keep a record of information that you need to communicate to users, including a preferred workflow architecture, preferred session configuration characteristics, and permissions.  
  
To write the workflow, use a script editor, such as [Windows PowerShell Integrated Scripting Environment \(ISE\)](http://go.microsoft.com/fwlink/?LinkID=135178), that enforces workflow syntax and highlights syntax errors. The syntactic differences between scripts and workflows are significant, so a tool that knows workflows, as well as scripts, will save you significant coding and testing time.  
  
For more information about tasks that are well\-suited to workflows, see "How Workflows and [!INCLUDE[wps_2](../Token/wps_2_md.md)] Scripts Differ" in [Getting Started with Windows PowerShell Workflow](../Topic/Getting-Started-with-Windows-PowerShell-Workflow.md).  
  
## The Workflow Keyword  
Begin with the **workflow** keyword, which identifies a workflow command to [!INCLUDE[wps_2](../Token/wps_2_md.md)]. The **workflow** keyword is required in a script workflow. The name of the workflow follows the **workflow** keyword. The body of the workflow is enclosed in braces.  
  
The following is the syntax diagram for the **Workflow** keyword.  
  
```  
workflow Test-Workflow  
{  
    ...  
}  
```  
  
For more information about keywords in the [!INCLUDE[wps_2](../Token/wps_2_md.md)] scripting language, see [about\_Language\_Keywords](http://go.microsoft.com/fwlink/?LinkID=136588).  
  
## Naming Workflows and Workflow Elements  
A workflow is a [!INCLUDE[wps_2](../Token/wps_2_md.md)] command type. Select a name with a verb\-noun format. Use the [Get\-Verb](http://go.microsoft.com/fwlink/?LinkID=160712) cmdlet and the [Approved Verbs for Windows PowerShell Commands](http://msdn.microsoft.com/library/windows/desktop/ms714428.aspx) help topic to select an approved verb for the name. [!INCLUDE[wps_2](../Token/wps_2_md.md)] generates a warning when commands that do not include approved verbs are imported from a module. Use a descriptive noun and a noun prefix, if necessary, to prevent command name conflicts when the workflow is imported into a session.  
  
Parameter names and variable names in workflows can include only letters, numbers, and the  hyphen \(\-\) and underscore \( \_ \) characters. Avoid using the hyphen character in parameter names, because each use of a hyphenated parameter name in the workflow and in calls to the workflow must be enclosed in braces. Do not use the names of the [workflow common parameters](http://go.microsoft.com/fwlink/?LinkID=222527), workflow runtime variables, or other reserved words, such as "workflow" and "parallel".  
  
For more information about workflow runtime parameters, see the [PSWorkflowRuntimeVariable Enumeration](http://msdn.microsoft.com/library/windows/desktop/microsoft.powershell.activities.psworkflowruntimevariable.aspx) help topic in the MSDN Library.  
  
For more information about reserved words, see "Reserved Words in Workflows" in [Syntactic Differences Between Script Workflows and Scripts_1](../Topic/Syntactic-Differences-Between-Script-Workflows-and-Scripts_1.md) and [about\_Reserved\_Words](http://go.microsoft.com/fwlink/?LinkID=113258).  
  
## How to Add Parameters to a Workflow  
To add parameters to a workflow, use the **Param** keyword with the optional **Parameter** attribute. These are the same techniques that you use to add parameters to a function.  
  
The following code blocks show the syntax of the **Param** keyword and the **Parameter** attribute in a script workflow.  
  
```  
workflow Test-Workflow  
{  
param ([Type]$<ParameterName>)  
}  
```  
  
```  
workflow Test-Workflow  
{  
    Param  
    (  
        [Parameter(Mandatory=<$True | $False>)]  
        [<Type>]  
        $<ParameterName>  
    )  
}  
```  
  
You can also use the **CmdletBinding** attribute to specify the **ConfirmImpact**, **DefaultParameterSetName**, **HelpUri**, and **SupportsShouldProcess** attributes.  
  
The following code block shows the syntax of a sample workflow that uses the **CmdletBinding** attribute.  
  
```  
workflow Test-Workflow  
{     
    [CmdletBinding(ConfirmImpact=<String>,  
        DefaultParameterSetName=<String>,  
        HelpURI=<URI>,  
        PositionalBinding=<Boolean>)]  
  
    Param  
    (  
        [parameter(Mandatory=$true)]  
        [String[]]  
        $<ParameterName>  
    )  
}  
```  
  
You do not need to add workflow common parameters to the workflow. [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow adds the common parameters and workflow common parameters to all workflows, including simple workflows that do not have the **CmdletBinding** attribute or the **Parameter** attribute.  
  
For more information about parameters in functions and workflows, see the following help topics.  
  
-   [about\_Functions\_CmdletBindingAttribute](http://go.microsoft.com/fwlink/?LinkID=135174)  
  
-   [about\_Functions\_Advanced\_Parameters](http://go.microsoft.com/fwlink/?LinkID=135173)  
  
-   [about\_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216)  
  
-   [about\_WorkflowCommonParameters](http://go.microsoft.com/fwlink/?LinkID=222527)  
  
## How to Add Activities to a Workflow  
An *activity* is the basic unit of work in a workflow. Every command and expression that you use in a workflow runs as an activity. In [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow, an activity is very much like a cmdlet. You run an activity by typing the activity name followed by its parameters. [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow converts many of the [!INCLUDE[wps_2](../Token/wps_2_md.md)] included cmdlets to activities. There are only a small set of excluded cmdlets. For a list of excluded cmdlets, see "Excluded Cmdlets" in [Using Activities in Script Workflows_1](../Topic/Using-Activities-in-Script-Workflows_1.md).  
  
Most of the [!INCLUDE[wps_2](../Token/wps_2_md.md)] Core cmdlets have been implemented as activities. To use them in workflow, just type the cmdlet name or the cmdlet alias.  
  
For example, the following workflow includes the [Get\-Process](http://go.microsoft.com/fwlink/?LinkID=113324) activity.  
  
```  
workflow Test-Workflow  
{  
    Get-Process -Name PowerShell  
    gps -Name Winword  
}  
```  
  
When a cmdlet does not have an matching activity and it is not explicitly excluded, [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow automatically runs the cmdlet in the **inlineScript** activity and returns the output to the workflow.  
  
For example, the following workflow uses the [Get\-WindowsFeature cmdlet](http://technet.microsoft.com/library/jj205469.aspx), which runs implicitly in an **inlineScript** activity.  
  
```  
workflow Test-Workflow  
{  
    Get-Process -Name PowerShell  
    Get-WindowsFeature -Name PowerShell, PowerShell-v2  
}  
  
```  
  
You can even run cmdlets that are excluded because they are not implemented as activities, but you must run them in an **inlineScript** activity. For example, the following workflow uses an **inlineScript** activity to run the [Get\-Variable](http://go.microsoft.com/fwlink/?LinkID=113336) cmdlet, which is excluded.  
  
```  
workflow Test-Workflow  
{  
    Get-Process -Name PowerShell  
    Get-WindowsFeature -Name PowerShell, PowerShell-v2  
    InlineScript { Get-Variable -Name PSHome }  
}  
  
```  
  
You can also use expressions in a workflow, including arithmetic expressions and comparison statements. [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow automatically runs expressions in a special activity that is designed for the purpose.  
  
For example, the following workflow includes an expression. Like all expressions, it is run in an activity.  
  
```  
workflow Test-Workflow  
{  
    Get-Process -Name PowerShell  
    Get-WindowsFeature -Name PowerShell, PowerShell-v2  
    InlineScript { Get-Variable PSHome }  
  
    320GB / 3MB  
}  
```  
  
For more information about activities, see [Using Activities in Script Workflows_1](../Topic/Using-Activities-in-Script-Workflows_1.md).  
  
## How to Use the Parameters of Activities  
Activities are commands that have parameters, just like cmdlets. When a cmdlet is converted to an activity, the syntax and parameters remain the same. There are a few exceptions, which are listed in the "Activities in Script Workflows" help topic.  
  
However, positional parameters are not valid in activities, so all parameter names are required. Parameter aliases and abbreviations are permitted. For example, in the following sample workflow, the **Name** parameters of the [Get\-Process](http://go.microsoft.com/fwlink/?LinkID=113324), [Get\-WindowsFeature](http://go.microsoft.com/fwlink/?LinkId=261418), and [Get\-Variable](http://go.microsoft.com/fwlink/?LinkID=113336) cmdlets appears in the commands.  
  
```  
workflow Test-Workflow  
{  
    Get-Process -Name PowerShell  
    Get-WindowsFeature -Name PowerShell, PowerShell-v2  
    InlineScript { Get-Variable -Name PSHome }  
}  
```  
  
Dynamic parameters are also not valid in activities. To call a dynamic parameter, enclose the command in an **InlineScript** activity.For example, the following workflow includes an **inlineScript** activity that uses the **CodeSigningCert** dynamic parameter of the [Get\-ChildItem](http://go.microsoft.com/fwlink/?LinkId=261616) cmdlet. The **CodeSigningCert** parameter is added by the [Certificate provider](http://go.microsoft.com/fwlink/?LinkID=113433) and works only in the Cert: drive.  
  
```  
workflow Test-Workflow  
{  
   InlineScript {Get-ChildItem -Path Cert:\CurrentUser -CodeSigningCert}  
}  
  
```  
  
For more information about the **inlineScript** activity, see [Running Windows PowerShell Commands in a Workflow_1](../Topic/Running-Windows-PowerShell-Commands-in-a-Workflow_1.md).  
  
## How to Use Activity Common Parameters  
[!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow adds a set of activity common parameters to activities. These parameters allow you to set options that are critical in a multi\-computer environment.  
  
Some of the workflow common parameters are also activity common parameters. This feature lets you create activity\-specific exceptions to the values of the workflow common parameter values. For example, you can use the **PSComputerName** parameter of an activity to run an activity only on selected computers, or the **PSCredential** parameter to run an activity with alternate credentials.  
  
The activity common parameters are valid on most, but not all, activities. For example, the activity common parameters are not valid on the **Suspend\-Workflow** and **Checkpoint\-Workflow** activities. Also, the activity common parameters are not available on cmdlets or expressions that [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow automatically runs in an activity. The activity common parameters are available on the **InlineScript** activity, but not on commands in the **InlineScript** script block.  
  
The activities in the following workflow use the activity common parameters where they are valid.  
  
```  
workflow Test-Workflow  
{  
    Get-Process -Name PowerShell -PSComputerName Server01, Server 12  
    InlineScript { Get-Variable -Name PSHome } -PSRunningTimeoutSec 3600  
  
    #No activity common parameters.  
    Get-WindowsFeature -Name PowerShell, PowerShell-v2    
  
    #No activity common parameters.  
    320GB / 3MB  
}  
```  
  
For more information about the activity common parameters, see [Using Activities in Script Workflows_1](../Topic/Using-Activities-in-Script-Workflows_1.md).  
  
## How to Get Common Parameter Values  
[!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow adds the workflow runtime variables to all workflows. The workflow runtime variables include the values of the common parameters, workflow common parameters, and other values that are critical to the workflows.  
  
The variable values are extremely useful. Take the time to review them and use them in your workflows. For example, when you run a workflow, the **PSComputerName** parameter takes the names of the target computers, but when you access the $PSComputerName variable in a workflow, it contains the name of the computer on which the workflow is currently running.  
  
For information about the workflow runtime variables, see [PSWorkflowRuntimeVariable Enumeration](http://msdn.microsoft.com/library/windows/desktop/microsoft.powershell.activities.psworkflowruntimevariable(v=vs.85).aspx).  
  
To access the parameter values from within the workflow, use the variable name. You do not need to define the variable.  
  
For example, the following workflow uses the value of the **PSConnectionRetryCount** common parameter by referring to it as the **$PSConnectionRetryCount** variable.  
  
```  
workflow Test-Workflow  
{  
    "Retry count is $PSConnectionRetryCount."  
}  
```  
  
The following example shows that when you use the **PSConnectionRetryCount** parameter when running the workflow, the parameter value is visible in the workflow.  
  
```  
PS C:\>Test-Workflow -PSConnectionRetryCount 4  
Retry count is 4.  
```  
  
To change the values of the runtime and common parameters in a workflow, use the **Set\-PSWorkflowData** activity.  
  
For example, the following workflow includes a command that changes the **PSConnectionRetryCount** value.  
  
```  
workflow Test-Workflow  
{  
    "Retry count is $PSConnectionRetryCount."  
    Set-PSWorkflowData -PSConnectionRetryCount 5  
    "Retry count is $PSConnectionRetryCount."  
}  
  
PS C:\>Test-Workflow -PSConnectionRetryCount 4  
Retry count is 4.  
Retry count is 5.  
```  
  
For more information about variables in [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow, see the following help topics.  
  
-   [Using Variables in Script Workflows_1](../Topic/Using-Variables-in-Script-Workflows_1.md)  
  
-   [PSWorkflowRuntimeVariable Enumeration](http://msdn.microsoft.com/library/windows/desktop/microsoft.powershell.activities.psworkflowruntimevariable(v=vs.85).aspx)  
  
-   about\_Get\-PSWorkflowData  
  
-   about\_Set\-PSWorkflowData  
  
## How to Get Runtime Variables and Common Parameter Values  
[!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow adds the workflow runtime variables to all workflows. The workflow runtime variables include the values of the common parameters, workflow common parameters, and other values that are critical to the workflows.  
  
The variable values are extremely useful. Take the time to review them and use them in your workflows. For example, when you run a workflow, the **PSComputerName** parameter takes the names of the target computers, but when you access the $PSComputerName variable in a workflow, it contains the name of the computer on which the workflow is currently running.  
  
For information about the workflow runtime variables, see [PSWorkflowRuntimeVariable Enumeration](http://msdn.microsoft.com/library/windows/desktop/microsoft.powershell.activities.psworkflowruntimevariable(v=vs.85).aspx).  
  
To access the parameter values from within the workflow, use the variable name. You do not need to define the variable.  
  
For example, the following workflow uses the value of the **PSConnectionRetryCount** common parameter by referring to it as the **$PSConnectionRetryCount** variable.  
  
```  
workflow Test-Workflow  
{  
    "Retry count is $PSConnectionRetryCount."  
}  
```  
  
The following example shows that when you use the **PSConnectionRetryCount** parameter when running the workflow, the parameter value is visible in the workflow.  
  
```  
PS C:\>Test-Workflow -PSConnectionRetryCount 4  
Retry count is 4.  
```  
  
To change the values of the runtime and common parameters in a workflow, use the **Set\-PSWorkflowData** activity.  
  
For example, the following workflow includes a command that changes the **PSConnectionRetryCount** value.  
  
```  
workflow Test-Workflow  
{  
    "Retry count is $PSConnectionRetryCount."  
    Set-PSWorkflowData -PSConnectionRetryCount 5  
    "Retry count is $PSConnectionRetryCount."  
}  
  
PS C:\>Test-Workflow -PSConnectionRetryCount 4  
Retry count is 4.  
Retry count is 5.  
```  
  
For more information about variables in [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow, see the following help topics.  
  
-   [Using Variables in Script Workflows_1](../Topic/Using-Variables-in-Script-Workflows_1.md)  
  
-   [PSWorkflowRuntimeVariable Enumeration](http://msdn.microsoft.com/library/windows/desktop/microsoft.powershell.activities.psworkflowruntimevariable.aspx)  
  
## How to Run a Script in a Workflow  
To run a script \(a .ps1 file\) in a workflow, enclose the call to the script in an **InlineScript** activity. Like other commands and activities, the script runs on all workflow target computers and the output is returned to the workflow  
  
For example, the following workflow includes an InlineScript activity that runs a script. The script is stored in a shared directory. The workflow uses the PSPersist activity parameter to take a checkpoint when the script completes.  
  
```  
workflow Test-Workflow  
{  
   $AssetData =InlineScript {\\Server01\Share01\Get-AssetData.ps1 -All} -PSPersist  
   ...  
}  
  
```  
  
Because workflows are designed to run on multiple computers, use an absolute path to the script file, rather than a relative path.  
  
## How to Run Commands in Parallel  
The **Parallel** and **ForEach \-Parallel** keywords optimize your workflow by running commands concurrently and in indeterminate order. The **Sequence** keyword runs selected commands sequentially within a **Parallel** script block. These keywords are valid only in a workflow. They are valid in nested workflows, but not valid in nested functions in a workflow. By default, commands run in sequence in which each command completes before the next command begins.  
  
Because parallel execution can provide significant performance improvements, especially when the workflow targets numerous computers, use it whenever possible.  
  
The following types of commands and activities are good candidates for parallel execution.  
  
-   Commands that do not share data, such as [Get\-Process](http://go.microsoft.com/fwlink/?LinkID=113324) and a [Get\-Service](http://go.microsoft.com/fwlink/?LinkID=113332) commands.  
  
-   Commands that run on a collection of like items. Most **ForEach** statements are good candidates for **ForEach \-Parallel** execution.  
  
### Parallel  
The commands in a **Parallel** script block can run concurrently. The order in which they run is not determined.  
  
The following diagram shows the syntax of a workflow with the **Parallel** keyword and script block.  
  
```  
workflow Test-Workflow  
{  
    Parallel  
    {  
         <Activity>  
         <Activity>  
...  
    }  
}  
```  
  
For example, the following workflow includes a Parallel script block that runs activities that get processes and services on the computer. Because the calls to Get\-Process and Get\-Service are independent, they can run concurrently and in any order.  
  
```  
workflow Test-Workflow  
{  
    Parallel  
    {  
         Get-Process  
         Get-Service  
    }  
}  
```  
  
### ForEach \-Parallel  
The **Parallel** parameter of the **ForEach** keyword runs the commands in a **ForEach** script block once for each item in the specified collection. The items in the collection are processed in parallel. The commands in the script block run sequentially.  
  
Like the **ForEach** statement in [!INCLUDE[wps_2](../Token/wps_2_md.md)], the variable that contains collection \($<Collection>\) must be defined before the **ForEach \-Parallel** statement, but the variable that represents the current item \($<item>\) is defined in the **ForEach \-Parallel** statement.  
  
The following diagram shows the command syntax.  
  
```  
workflow Test-Workflow  
{  
    ForEach -Parallel ($<item> in $<collection>)  
    {  
       <Activity1>  
       <Activity2>  
 ...  
    }  
}  
```  
  
For example, the following workflow contains a **Foreach \-Parallel** statement that processes the disks that the **Get\-Disk** activity gets. The commands in the script block run sequentially, but they are run on the disks in parallel.  
  
```  
workflow Test-Workflow  
{  
    $Disks = Get-Disk  
    ForEach -Parallel ($Disk in $Disks)  
    {  
        $DiskPath = $Disk.Path     
        $Disk | Initialize-Disk  
        Set-Disk -Path $DiskPath  
    }  
}  
```  
  
### Sequence  
The **Sequence** keyword runs commands in sequence within a **Parallel** script block. The **Sequence** script block runs in parallel with other commands, but the commands within the sequence script block run sequentially and in the specified order.  
  
The following code block show the syntax of a **Sequence** script block. Activity 3 might run before or at the same time as Activity 1 and Activity 2, but Activity 4 does not run until Activity 3 is complete.  
  
```  
workflow Test-Workflow  
{  
    parallel  
    {  
       <Activity1>  
       <Activity2>  
  
       sequence   
       {  
           <Activity3>  
           <Activity4>  
           ...  
       }  
        ...  
    }  
}  
```  
  
