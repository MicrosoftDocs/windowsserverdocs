---
title: Making a Workflow Suspend Itself
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e906f08e-3aba-4009-a872-58c7fef7b6e1
author: jpjofre
---
# Making a Workflow Suspend Itself
One of the many benefits of running [!INCLUDE[wps_1](../Token/wps_1_md.md)] workflows is that you can suspend and resume them as needed. This is crucial to some scenarios, in which parts of a workflow might be managed by different administrators or require manual intervention.  
  
To suspend a workflow that you are running, use the [Suspend-Job](http://go.microsoft.com/fwlink/?LinkID=210613) cmdlet. But you can also use **Suspend\-Workflow** activity to suspend a workflow from within the workflow.  
  
## The Suspend\-Workflow Activity  
The **Suspend\-Workflow** activity stops workflow processing temporarily. Before suspending, [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow takes a checkpoint so the state and data are preserved when the workflow is resumed.  
  
To resume the workflow, the user running the workflow uses the [Resume-Job](http://go.microsoft.com/fwlink/?LinkID=210611) cmdlet. You cannot resume a workflow from within the workflow.  
  
After the workflow is resumed, use the [!INCLUDE[wps_2](../Token/wps_2_md.md)] Job cmdlets to manage the workflow job and get its output, even if you were running the workflow interactively before it was suspended.  
  
Use the [Get-Job](http://go.microsoft.com/fwlink/?LinkID=113328) cmdlet to get the workflow job. To get the output of the workflow job, use the [Receive-Job](http://go.microsoft.com/fwlink/?LinkID=113372) cmdlet.  
  
## Suspending a Workflow  
The **Suspend\-Workflow** activity returns a job object that represents the suspended job, even if you did not explicitly run the workflow as a job, such as by using the **AsJob** parameter.  
  
The job object that **Suspend\-Workflow** returns includes the job ID and job state. When the **Suspend\-Workflow** activity is successful, the resulting job state is **Suspended**, as shown in the following example.  
  
```  
Workflow Test-Suspend  
{  
    $a = Get-Date  
    Suspend-Workflow  
    (Get-Date)- $a  
}  
  
PS C:\>Test-Suspend  
  
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command                    
--     ----            -------------   -----         -----------     --------             -------                    
8      Job8            PSWorkflowJob   Suspended     True            localhost            Test-Suspend  
```  
  
## Resuming a Workflow Job  
To resume the workflow job, use the [Resume-Job](http://go.microsoft.com/fwlink/?LinkID=210611) cmdlet. The **Resume\-Job** cmdlet returns the workflow job object immediately, even though it might not yet be resumed. To get the current state of the workflow job, use the [Get-Job](http://go.microsoft.com/fwlink/?LinkID=113328) cmdlet, as shown in the following example.  
  
```  
PS C:\>Resume-Job -Name Job8  
  
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command                    
--     ----            -------------   -----         -----------     --------             -------                    
8      Job8            PSWorkflowJob   Suspended     True            localhost            Test-Suspend        
  
PS C:\>Get-Job -Name Job8  
  
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command                    
--     ----            -------------   -----         -----------     --------             -------                    
8      Job8            PSWorkflowJob   Completed     True            localhost            Test-Suspend  
```  
  
## Getting the Output of a Workflow Job  
To get the output of a workflow job, use the [Receive-Job](http://go.microsoft.com/fwlink/?LinkID=113372) cmdlet. The output shows that the value of the $a variable, which was defined before the workflow was suspended, is available when the workflow is resumed.  
  
```  
PS C:\>Get-Job -Name Job8 | Receive-Job  
  
Days              : 0  
Hours             : 0  
Minutes           : 0  
Seconds           : 19  
Milliseconds      : 823  
Ticks             : 198230041  
TotalDays         : 0.000229432917824074  
TotalHours        : 0.00550639002777778  
TotalMinutes      : 0.330383401666667  
TotalSeconds      : 19.8230041  
TotalMilliseconds : 19823.0041  
PSComputerName    : localhost  
```  
  
