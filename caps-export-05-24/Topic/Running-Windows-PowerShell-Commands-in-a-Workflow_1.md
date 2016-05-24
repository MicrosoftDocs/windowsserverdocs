---
title: Running Windows PowerShell Commands in a Workflow_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d4683e91-5828-40db-83d1-8eab97fe3bb9
author: jpjofre
---
# Running Windows PowerShell Commands in a Workflow_1
To run commands or expressions in a workflow that are valid in Windows PowerShell, but not valid in workflows, run the commands in an **inlineScript** activity. You can use also an **inlineScript** activity to run Windows PowerShell scripts \(.ps1 files\) in a workflow.  
  
## The InlineScript activity  
The **inlineScript** activity runs commands in a standard, non\-workflow Windows PowerShell session and then returns the output to the workflow. It is valid only in workflows.  
  
The commands in an **inlineScript** script block run in a single session and can share data, such as the values of variables. By default, the InlineScript session runs "out\-of\-process," that is, it runs in its own process, not in the workflow process. However, you can change this default by changing the value of the **OutOfProcessActivity** property of the session configuration.  
  
The following diagram shows the syntax of the **inlineScript** activity.  
  
```  
inlineScript {<script block>} <WorkflowCommonParameters>  
```  
  
Because it is an activity, but not a cmdlet, the **inlineScript** activity has the activity common parameters, but it does not have the Windows PowerShell common parameters.  
  
When creating **inlineScript** commands, remember that the commands in an InlineScript script block do not have the features of a workflow, such as automatic multi\-computer management. To run the commands in **inlinescript** activity on remote computers, you need to establish and manage connections to the remote computer from within the **inlinescript** block and then run the commands remotely.  
  
## Rules for Using the InlineScript Activity  
An **inlineScript** script block can include all valid Windows PowerShell commands and expressions, including commands, expressions, and syntax that are not otherwise valid in a workflow. The commands and expressions in the script block share all state and data, including the values of variables.  
  
You can place an **inlineScript** activity anywhere in a workflow or nested workflow, including inside a loop or control statement or a **Parallel** or **Sequence** script block.  
  
The **inlineScript** activity has the activity common parameters, including PSPersist. However, the commands and expressions in an **inlineScript** script block do not have the features of workflows, such as checkpointing \("persistence"\) or the activity common parameters.  
  
## Variables in InlineScript  
By default, the variables that are defined in a workflow are not visible to the commands in the InlineScript script block. To make workflow variables visible to the InlineScript, use the **$Using** scope modifier.  
  
The following example shows how to make the values of top\-level workflow variables available to the commands in an **inlineScript** script block.  
  
```  
workflow Test-Workflow  
{  
    $a = 3  
  
    # Without $Using, the $a workflow variable is not visible  
    # in inline script.  
    InlineScript {"Inline A0 = $a"}  
  
    # $Using imports the variable and its current value.  
    InlineScript {"Inline A1 = $Using:a"}  
}  
  
PS C:\> Test-Workflow  
Inline A0 =   
Inline A1 = 3  
```  
  
InlineScript commands can change the value of the variable that was imported from workflow scope, but the changes are not visible in workflow scope. To make them visible, return the changed value to the workflow scope, as shown in the following example.  
  
```  
workflow Test-Workflow  
{  
    $a = 3  
  
    # Changes to an InlineScript variable do not affect  
    # the workflow variable.  
    InlineScript {$a = $using:a+1; "Inline A = $a"}  
    "Workflow A = $a"  
  
    # To change the value in workflow scope, return the new value.  
     $a = InlineScript {$a = $Using:a+1; $a}  
     "Workflow New A = $a"  
}     
  
PS C:\> Test-Workflow  
Inline A = 4  
Workflow A = 3  
Workflow New A = 4  
  
```  
  
> [!IMPORTANT]  
> Troubleshooting Note:  A statement with the $Using scope modifier should appear before any use of the variable in the InlineScript script block. In Windows PowerShell 3.0, the $Using scope modifier can appear anywhere in the InlineScript script block, but this behavior might change in future versions of Windows PowerShell.  
  
## Running InlineScript in the Workflow Process  
To improve reliability,  the commands in an **InlineScript** script block run in their own process, outside of the  process in which the workflow runs, and then return their output to the workflow process. To direct Windows PowerShell to run the **InlineScript** activity in the workflow process, remove the **InlineScript** value from the **OutOfProcessActivity** property of the session configuration, such as by using the **OutOfProcessActivity** parameter of the [New\-PSWorkflowExecutionOption](http://go.microsoft.com/fwlink/?LinkID=210609) cmdlet.  
  
The following command sequence shows how to remove the InlineScript value from the **OutOfProcessActivity** property and then to restore the value to the Microsoft.PowerShell.Workflow session configuration by deleting the session configuration, and then running the [Enable\-PSRemoting](http://go.microsoft.com/fwlink/?LinkID=144300) cmdlet to recreate it.  
  
```  
#To run InlineScript in the workflow process  
[ADMIN]: PS C:\> (Get-PSSessionConfiguration Microsoft.PowerShell.Workflow).OutOfProcessActivity  
InlineScript  
[ADMIN]: PS C:\> $o = New-PSWorkflowExecutionOption -OutOfProcessActivity ""  
[ADMIN]: PS C:\> Set-PSSessionConfiguration Microsoft.PowerShell.Workflow -SessionTypeOption $o -Force  
[ADMIN]: PS C:\> (Get-PSSessionConfiguration Microsoft.PowerShell.Workflow).OutOfProcessActivity  
[ADMIN]: PS C:\>   
  
#To restore the default setting and run InlineScript out of process  
[ADMIN]: PS C:\> (Get-PSSessionConfiguration Microsoft.PowerShell.Workflow) | Unregister-PSSessionConfiguration -Force  
[ADMIN]: PS C:\> Enable-PSRemoting -Force  
WinRM is already set up to receive requests on this computer.  
WinRM is already set up for remote management on this computer.  
[ADMIN]: PS C:\> (Get-PSSessionConfiguration Microsoft.PowerShell.Workflow).OutOfProcessActivity  
InlineScript  
  
```  
  
## Examples  
The following workflow uses an InlineScript activity to run a Windows PowerShell script \(.ps1 file\)  in a workflow.  
  
```  
Workflow Test-Workflow  
{  
    InlineScript   
    {  
        \\Server01\Share01\Get-AssetData.ps1 -All  
    }      
}   
```  
  
The InlineScript in the following workflow includes commands that are valid in Windows PowerShell, but not in workflows, including the use of the New\-Object cmdlet with the ComObject parameter. The results are returned to the workflow so they can be used in workflow activities.  
  
```  
workflow Test-Workflow  
{  
    $ie = InlineScript   
    {  
New-Object -ComObject InternetExplorer.Application   
-property @{navigate2="www.microsoft.com"}  
    }  
    $ie.LocationName      
}   
  
PS C:>Test-Workflow  
Microsoft Corporation: Software, Smartphones, Online, Games, Cloud Computing, IT Business Technology, Downloads  
```  
  
