---
title: Syntactic Differences Between Script Workflows and Scripts_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7449f965-9adf-4308-85ef-1f5d538e2c21
author: jpjofre
---
# Syntactic Differences Between Script Workflows and Scripts_1
This topic lists and explains the primary syntactic differences between [!INCLUDE[wps_2](../Token/wps_2_md.md)] scripts and script workflows, including commands and syntax that are valid in a workflow.  
  
Review this topic in advance and use it as a reference. However, the best way to learn the syntax differences in workflows is to write workflows in a script editor that enforces valid workflow syntax, such as [!INCLUDE[ise_1](../Token/ise_1_md.md)]. If you type a syntax error, [!INCLUDE[ise_2](../Token/ise_2_md.md)] recognizes and explains the error.  
  
## Scripts and Script Workflows  
A *script workflow* is a workflow written in the [!INCLUDE[wps_2](../Token/wps_2_md.md)] scripting language. You can save and share your workflows in [!INCLUDE[wps_2](../Token/wps_2_md.md)] scripts \(.ps1 files\) and script modules \(.psm1 files\).  
  
For more information about scripts and modules, see [about\_Scripts](http://go.microsoft.com/fwlink/?LinkID=144310) and [Writing a Windows PowerShell Module](http://go.microsoft.com/fwlink/?LinkID=144916) in the MSDN Library.  
  
## The Workflow Keyword  
Workflows begin with the **workflow** keyword, followed by a workflow name in verb\-noun format. The commands and expressions in the workflow are enclosed in the workflow script block.  
  
```  
workflow <Verb-Noun>  
{  
    ...  
}  
  
```  
  
The [Get\-Command](http://go.microsoft.com/fwlink/?LinkID=113309) cmdlet recognizes all workflows in a session. The command type is Workflow.  
  
```  
workflow Test-Workflow  
{  
    "Hello, World"  
}  
  
PS C:\>Get-Command Test-Workflow  
  
CommandType     Name                 ModuleName  
-----------     ----                 ----------  
Workflow        Test-Workflow  
  
```  
  
## Workflow Names  
Workflows have names with the verb\-noun format. Use approved verbs for the verb in the workflow name.  
  
For a list of approved verbs, use the [Get\-Verb](http://go.microsoft.com/fwlink/?LinkID=160712) cmdlet. For more information, see [Approved Verbs for Windows PowerShell Commands](http://msdn.microsoft.com/library/windows/desktop/ms714428.aspx) in the MSDN library.  
  
The noun names in a workflow can include only letters, numbers, and the hyphen \(\-\) and underscore \( \_ \) characters. Avoid names with hyphen and underscore characters, because they might be confusing to users.  
  
## CmdletBinding Attribute  
The **CmdletBinding** attribute is optional and valid in a workflow. Use it to add attributes to the workflow command. In workflows, the **CmdletBinding** attribute supports the following parameters.  
  
-   ConfirmImpact  
  
-   DefaultParameterSetName  
  
-   HelpUri  
  
-   PositionalBinding  
  
For more information about the **CmdletBinding** attribute and its parameters, see [about\_Functions\_CmdletBindingAttribute](http://go.microsoft.com/fwlink/?LinkID=135174).  
  
## Workflow Parameters  
The parameters in a workflow are almost exactly like the parameters in a function or script. However, parameter names in a workflow can include only letters, numbers, and the hyphen \(\-\) and underscore \( \_ \) characters. Avoid names with hyphen characters, because they must be enclosed in braces to be interpreted correctly.  
  
You can have one or many parameter sets. You can use a simple **Param** statement or the optional **Parameter** attribute. Parameter attributes and parameter validation are supported in workflows, but not in nested workflows.  
  
## Workflow Common Parameters  
[!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow adds the [!INCLUDE[wps_2](../Token/wps_2_md.md)] common parameters and workflow common parameters to all workflows, including simple workflows that do not use the **CmdletBinding** attribute or the **Parameter** attribute.  
  
[!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow also adds the some of the workflow common parameters to activities in a workflow. This feature lets you create exceptions to the workflow common parameters for specific activities.  
  
The values of common parameters and workflow common parameters are available within a workflow as variables. For more information, see [Using Variables in Script Workflows_1](../Topic/Using-Variables-in-Script-Workflows_1.md).  
  
For more information, see [about\_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216) and [about\_WorkflowCommonParameters](http://go.microsoft.com/fwlink/?LinkID=222527).  
  
> [!NOTE]  
> Troubleshooting Note: Because all workflow common parameters are available on workflows, there is no need to define these parameters on any workflow. If you redefine the **PSComputerName** parameter on a workflow, the parameter name is case\-sensitive. Incorrect capitalization results in unintended fan\-out behavior.  
  
## Activity Parameters  
When calling a cmdlet or activity in a workflow, explicit parameter names are required, even for positional parameters. You can use a parameter alias or the first few characters of a parameter name, just so they are sufficient to distinguish the parameter name from the names of other parameters in the parameter set. However, you may not omit the parameter name.  
  
Splatting is not permitted in workflow activities or in calls to workflows.  
  
Dynamic parameters, which are parameters that are added to a command by a provider, module or another cmdlet, are not valid in workflows. To use a dynamic parameter, run the command in an InlineScript activity, as shown in the example below.  
  
```  
workflow Test-Workflow  
{  
    InlineScript  
    {  
        $Signing = dir cert:\CurrentUser -CodeSigningCert  
    }      
}  
```  
  
## Activity Common Parameters  
[!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow adds a set of activity common parameters to the InlineScript activity and to cmdlets that are implemented as activities. For a list of the activity common parameters, see [Using Activities in Script Workflows_1](../Topic/Using-Activities-in-Script-Workflows_1.md).  
  
Some of the workflow common parameters are also activity common parameters. This feature lets you create activity\-specific exceptions to the values of the workflow common parameter values.  
  
The activity common parameters are not valid on the **Suspend\-Workflow** and **Checkpoint\-Workflow** activities. Also, the activity common parameters are not valid on cmdlets or expressions that [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow automatically runs in an activity. The activity common parameters are available on the **InlineScript** activity, but not on commands in the **InlineScript** script block.  
  
## Commands Run in Independent Sessions  
Each command in a workflow runs in its own session or "runspace" in the workflow process. [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow handles the processing; you do not need to manage these sessions.  
  
Typically, commands that run in different sessions cannot share data, such as the values of variables created in the session. However, [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow adds all workflow variables \(variables in the top\-level workflow scope\) to every command session. For information about getting other variables values, see [Using Variables in Script Workflows_1](../Topic/Using-Variables-in-Script-Workflows_1.md).  
  
However, if you run commands in a workflow that change the current session, such as a command that imports a module into the current session, that command does not affect the sessions in which subsequent workflow commands run. To import a module that a command requires \(and one that is not imported automatically\), use the **PSRequiredModules** activity parameter.  
  
The commands in an **InlineScript** script block are an exception to the independent session rule. By default, these commands run in a single session in their own Windows PowerShell process. For more information about the **InlineScript** activity, see [Running Windows PowerShell Commands in a Workflow_1](../Topic/Running-Windows-PowerShell-Commands-in-a-Workflow_1.md).  
  
## No Method Calls  
You cannot invoke methods in a workflow. The activities in workflows are converted to XAML and they return serialized \(XML\-formatted\) representations of objects. These objects have properties and property values, but the methods are not available.  
  
To call a method, place the command in an **InlineScript** activity.  
  
```  
workflow Get-PSModulePath  
{  
    InlineScript  
    {  
        [System.Environment]::GetEnvironmentVariable("PSModulePath")  
    }  
}   
```  
  
## Statements in a Workflow  
Most statements that are valid in scripts and functions are also valid in workflows. The following list describes statements that work differently in workflows than they work in scripts or functions.  
  
-   **Begin**, **Process**, and **End** statements are not valid in workflows.  
  
-   Dot\-sourcing is not valid in workflows.  
  
-   The Invocation \(or Call\) operator \(&\) is not valid in workflows.  
  
-   **Switch** statements must use the **CaseSensitive** parameter. Switch clauses must be case\-sensitive. Switch clauses must include only constants. They cannot include comparison statements, regular expressions, file references, or script blocks. All Switch clauses must be of the same type or be strongly typed.  
  
-   Trap statements are not valid in workflows. Instead, use **Try\-catch\-finally** statements, which are valid.  
  
-   The **\#Requires** statement has an **Assembly** parameter that adds the activities defined in an assembly to the workflow. The **Assembly** parameter is valid only in workflows.  
  
    To specify an assembly, enter a fully qualified module description or an absolute or relative path. If the assembly is in the global assembly cache \(GAC\), enter only the assembly name. The following formats are valid.  
  
    ```  
    #requires -Assembly MyWorkflow.dll  
    #requires -Assembly C:\Users\User01\MyWorkflow.dll  
    #requires -Assembly C:\Windows\Microsoft.NET\assembly\GAC_MSIL\Accessibility\v4.0_4.0.0.0__12a3b4e5adc7\MyWorkflow.dll  
    #requires -Assembly "MyWorkflow.dll, Version=1.1.0.0, Culture=neutral, PublicKeyToken=123a324b243c2"  
  
    ```  
  
## Control Statements in a Workflow  
Use the following rules to write valid control statements in a workflow.  
  
-   You cannot change variable values in loop conditions. To change a variable value, place the change statement in the loop body.  
  
    The following statement is not valid in a workflow.  
  
    ```  
    while($i++ -lt 100){if ($i -gt 10) Write-Host $i}  
    ```  
  
    Instead, change the variable value in the process block of the loop, as shown in the following example.  
  
    ```  
    while($i -lt  99){if ($i++ -gt 10) Write-Host $i}  
    ```  
  
-   **Break** and **Continue** statements are not valid in workflows. Instead, use an **If** statement to control loop execution.  
  
-   Loop labels are not valid in workflows.  
  
## Reserved Words in Workflows  
Reserved words for workflows are words that cannot be used as the names of workflows or of workflow variables or parameters, because they are used by [!INCLUDE[wps_2](../Token/wps_2_md.md)] or [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow.  
  
In addition to the reserved words for [!INCLUDE[wps_2](../Token/wps_2_md.md)] functions and scripts, the following categories of words are reserved in workflows.  
  
1.  Workflow keywords: **workflow**, **parallel**, and **sequence**.  
  
2.  The names of workflow runtime variables. For a complete list, see [PSWorkflowRuntimeVariable Enumeration](http://go.microsoft.com/fwlink/?LinkID=260473).  
  
    The names of workflow common parameters. For a complete list, see [about\_WorkflowCommonParameters](http://go.microsoft.com/fwlink/?LinkID=222527).  
  
3.  The names of activity common parameters. For a complete list, see "Activity Common Parameters" in [Using Activities in Script Workflows_1](../Topic/Using-Activities-in-Script-Workflows_1.md).  
  
4.  The names of [!INCLUDE[wps_2](../Token/wps_2_md.md)] common parameters. For a complete list, see [about\_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).  
  
The names of commands, including cmdlets, functions, CIM commands, workflows, and activities, are not reserved. However, workflow and function names can be used only once in each workflow.  
  
If two commands in the session have the same name but different command types, the command precedence rules determine which command runs when the command name is called. If two commands in the session have the same name and the same command type, the command added to the session last runs when the command name is called. To distinguish between commands with the same name, or to run a command that is hidden by a command with higher precedence, use the module\-qualified name of the command \(<ModuleName\\CommandName>, such as PSScheduledJob\\New\-JobTrigger.  
  
For more information about command precedence rules, see [about\_Command\_Precedence](http://go.microsoft.com/fwlink/?LinkID=113214).  
  
## Using Provider Drives in Workflows  
All drives added by [!INCLUDE[wps_2](../Token/wps_2_md.md)] included providers are valid in workflows. The core providers are Alias, Certificate, Environment, FileSystem, Function, Registry, Variable, and WS\-Management.  
  
To use a drive added by provider in an installed module, use the **PSRequiredModules** activity parameter or use an [Import\-Module](http://go.microsoft.com/fwlink/?LinkID=141553) command in an **InlineScript** activity.  
  
For example, the following commands use both techniques to access the IIS: drive in a workflow. The IIS: drive is added by the IIS provider in the WebAdministration module.  
  
```  
workflow Get-IIS { dir -Path IIS: -PSRequiredModules WebAdministration }  
  
workflow Get-IIS { InlineScript { Import-Module WebAdministration; dir IIS: } }  
  
```  
  
