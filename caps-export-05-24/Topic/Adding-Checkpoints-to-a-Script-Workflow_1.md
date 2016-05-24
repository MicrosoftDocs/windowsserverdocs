---
title: Adding Checkpoints to a Script Workflow_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3ab873b6-c3c4-4922-8887-89a2e5506b03
author: jpjofre
---
# Adding Checkpoints to a Script Workflow_1
This topic explains how to add commands to a [!INCLUDE[wps_2](../Token/wps_2_md.md)] workflow that "take a checkpoint," that is, they save workflow state and data to disk while the workflow runs. If the workflow is interrupted, it does not have be restarted; only resumed from the last checkpoint. This saving process is also known as *persistence* or *checkpointing*.  
  
[!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow is designed for the real world, where network interruptions, reboots, delays, and power outages are part of the job. Any long\-running task that affects multiple, heterogeneous machines in a distributed architecture must anticipate, respond, recover, continue, and complete after intentional and unintentional interruptions. Checkpointing is a critical part of this strategy.  
  
For more information about support for robust and recoverable workflows, see [Getting Started with Windows PowerShell Workflow](../Topic/Getting-Started-with-Windows-PowerShell-Workflow.md).  
  
## What is a checkpoint?  
A *checkpoint* is a snapshot of the current state of the workflow, including the current values of variables, and any output generated up to that point, and it saves it to disk. You can add multiple checkpoints to a workflow by using different checkpoint techniques. [!INCLUDE[wps_2](../Token/wps_2_md.md)] automatically uses the data in newest checkpoint for the workflow to recover and resume the workflow if the workflow is interrupted, intentionally or unintentionally.  
  
The checkpoint data \(or *persisted data*\) for a workflow is saved in the user profile on the hard drive of the computer that is hosting the workflow session.  
  
When you run the workflow as a job, such as by using the **AsJob** workflow common parameter, the workflow checkpoints are retained until you delete the job, such as by using the [Remove\-Job](http://go.microsoft.com/fwlink/?LinkID=113377) cmdlet. Otherwise, the workflow checkpoints are deleted when the workflow completes.  
  
## Where to place checkpoints  
You can place checkpoints anywhere in a workflow, including before and after each command or expression, or after each activity in a workflow. [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow allows you to do so.  
  
However, you probably will not add checkpoints wherever you are permitted, because the advantages of checkpoints are balanced by a performance cost. Every time you take a checkpoint, data is collected and written to disk on the workflow server computer. In a long workflow that runs on multiple computers, this delay is perceptible and affects the time it takes the workflow to complete.  
  
When planning checkpoints, consider the process of resuming a workflow. Be sure that the time it takes to rerun a section of the workflow if it is interrupted is greater than the time it takes to write the checkpoint state and data to disk. Remember that the checkpoint is taken every time the workflow runs on each target computer; as though the entire workflow was enclosed in a **ForEach** statement.  
  
Add a checkpoint after each significant part of the workflow completes; a part that you do not want to repeat if the workflow is interrupted. This could be a part of the workflow that takes a long time to complete, such as gathering input for a complex calculation or a complex element of output. It could be a section that requires resources that are not always available, or requires the coordination of multiple computers, connections, and resources.  
  
When the workflow definitions is complete, use the testing process to  refine your checkpoints. Add and remove \(comment out\) checkpoints to achieve both a reasonable running time and a reasonable recovery time.  
  
## How to add a checkpoint  
The following techniques checkpoint \(save state and data to disk\) a workflow so that it can recover and resume without being restarted. All of the techniques described below save state and data to the same place on disk and enable the same resuming options.  
  
### PSPersist workflow common parameter  
This **PSPersist** workflow common parameter adds checkpoints to the workflow. It is used when running the workflow command. **PSPersist** cannot cancel, ignore, or suppress explicit checkpoints in the workflow. It is valid on all workflows.  
  
By default, [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow adds a checkpoint at the beginning and end of the workflow, in addition to any checkpoints that are specified in the workflow.  
  
$True  
Adds a checkpoint at the beginning and end of the workflow and after each activity, in addition to checkpoints that are specified in the workflow.  
  
$False  
No checkpoints at the beginning or end of the workflow. Takes a checkpoint only when a checkpoint is specified in the workflow.  
  
The following examples run the Test\-Workflow workflow with the PSPersist workflow common parameter.  
  
```  
PS C:\>Test-Workflow -PSPersist $True  
PS C:\>Test-Workflow -PSPersist $False  
```  
  
### PSPersist activity common parameter  
The **PSPersist** activity common parameter with a value of $True takes a checkpoint after the activity completes. It is valid on all activities in a workflow. It is not valid on expressions or on the commands in an InlineScript script block.  
  
This parameter takes a Boolean value. The following are valid values.  
  
$True  
Takes a checkpoint after the activity completes.  
  
$False  
Does not add any checkpoints. This value has no effect.  
  
The following workflow uses the **PSPersist** activity common parameter to take a checkpoint after an activity completes.  
  
```  
Workflow Test-Workflow  
{  
    Get-Process -Name wsmprovhost -PSPersist $True  
}  
```  
  
### Checkpoint\-Workflow Activity  
The **Checkpoint\-Workflow** activity takes a checkpoint immediately. You can use a **Checkpoint\-Workflow** activity multiple times in a workflow and place it in after any command or expression in a workflow, except that it cannot appear in an **InlineScript** script block. The Checkpoint\-Workflow activity does not take any parameters, including common parameters and workflow common parameters.  
  
```  
Workflow Test-Workflow  
{  
    $p = Get-Process  
    $s = Get-Service  
    Checkpoint-Workflow  
}  
  
```  
  
### $PSPersistPreference Preference Variable  
The **$PSPersistPreference** preference variable with a value of $True takes a checkpoint after every activity that follows the variable definition. It is equivalent to setting the value of the **PSPersist** activity parameter to $true for all subsequent activities. To stop adding checkpoints, set the value of the **$PSPersistPreference** preference variable to $False.  
  
Unlike other preference variables, this variable is effective only in a workflow; not in a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session. You can define it in a session or in a [!INCLUDE[wps_2](../Token/wps_2_md.md)] profile, but it has no effect on workflows run in the session.  
  
This parameter takes a Boolean value. The following are valid values.  
  
$True  
Takes a checkpoint after each activity, in addition to checkpoints that are specified in the workflow. This value affects all subsequent activities in the workflow.  
  
$False  
Stops adding additional checkpoints. Takes a checkpoint only when the checkpoint is specified in the workflow.  
  
The following workflow uses the $PSPersistPreference variable to add checkpoints to a workflow. It adds checkpoints to all activities between `$PSPersistPreference=$True` and `$PSPersistPreference=$False`.  
  
```  
  
Workflow Test-Workflow  
{  
    $WinRm = Get-Service Winrm  
  
    $PSPersistPreference = $true  
    $Assets = InlineScript {\\Server\Share\Get-AssetData.ps1}  
    ...  
    $PSPersistPreference = $false  
  
    Parallel  
    {  
        ...          
}  
```  
  
## Checkpoints in Pipeline and Parallel Script Blocks  
When checkpoints are set on activities in a pipeline, the checkpoint is not taken until the pipeline completes.  
  
When checkpoints are set on activities in a **Parallel** script block, the checkpoints is not taken until the **Parallel** script block has run on all target computers. However, when checkpoints are set on activities in a **Sequence** script block, checkpoints are taken after each activity completes on each target computer.  
  
