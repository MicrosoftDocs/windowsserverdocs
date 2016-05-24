---
title: Restarting the Computer in a Workflow
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fd325373-5a71-45e8-b512-b1cda304fb4d
author: jpjofre
---
# Restarting the Computer in a Workflow
[!INCLUDE[wps_1](../Token/wps_1_md.md)] Workflow is designed to be robust and recoverable. The features that are built into [!INCLUDE[wps_2](../Token/wps_2_md.md)] allow you to restart the target computers and, if the workflow is not yet complete, to reconnect to the target computers automatically and continue with the workflow commands. You can even restart the computer that is running workflow, which allows you to run the workflow on the local computer or include the local computer in the list of target computers.  
  
Restarting closes the connection to the target computers, but when you use the **Wait** parameter of the [Restart-Computer](http://go.microsoft.com/fwlink/?LinkID=135253) cmdlet to wait for the restart to complete, [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow automatically reconnects to the target computer and handles all disconnection and reconnection details for you.  
  
If the connection to a target computer cannot be re\-established, the workflow throws a non\-terminating error and continues running on the remaining target computers.  
  
## Restart\-Computer  
To restart the target computers in a workflow, use the [Restart-Computer](http://go.microsoft.com/fwlink/?LinkID=135253) cmdlet, which is implemented as an activity.  
  
To continue running workflow commands after restarting the target computers, use the **Wait** parameter of the **Restart\-Computer** activity. The **Wait** parameter waits for the target computer to restart and then reconnects to the target computer before running the next workflow command. You can use a command like this one anywhere in a workflow without disrupting workflow processing. In workflows, the **Wait** parameter is valid on the local computer, as well as on remote computers.  
  
For example, the following workflow renames the computer and then restarts the computer to make the name change effective before configuring the disks. The command includes the **Wait** parameter of **Restart\-Computer**, which waits for [!INCLUDE[wps_2](../Token/wps_2_md.md)] to restart on the target computer before running the next \(Get\-Disk\) command.  
  
Note that the workflow does not include any [Disconnect-PSSession](http://go.microsoft.com/fwlink/?LinkID=210605) or [Connect-PSSession](http://go.microsoft.com/fwlink/?LinkID=210604) commands, and it does not include any explicit checkpoints.  
  
```  
workflow New-ComputerSetup  
{  
   ...  
   $cn =  Get-CimInstance -ClassName Win32_ComputerSystem  
   if ($cn.SystemType -like "64*")   
   {  
       $NewCnName = $PSComputerName + "64"  
       Rename-Computer -ComputerName $PSComputerName -NewName $NewCnName  
   }  
   Restart-Computer -Wait  
   $disks = Get-Disk  
   ...  
}  
```  
  
## Restarting the Workflow Computer  
The commands in a workflow can restart the computer that is running the workflow, such as when the workflow is running on the local computer or the workflow computer is one of the target computers. If you use the **Wait** parameter of the [Restart-Computer](http://go.microsoft.com/fwlink/?LinkID=135253) activity to continue the workflow after the restart, [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow automatically takes a checkpoint and suspends the workflow before restarting the workflow computer.  
  
This section describes two procedures that resume a workflow after the workflow computer is restarted. The first procedure is manual. The second uses a scheduled job.  
  
### Manually Resuming the Workflow  
To resume a workflow manually after restarting the workflow computer, use the following procedure.  
  
-   Use the [Import-Module](http://go.microsoft.com/fwlink/?LinkID=141553) command to import the **PSWorkflow** module.  
  
    Without this module, the Job cmdlets do not recognize workflow jobs.  
  
-   Use the [Get-Job](http://go.microsoft.com/fwlink/?LinkID=113328) cmdlet to get the suspended workflow job and the [Resume-Job](http://go.microsoft.com/fwlink/?LinkID=210611) cmdlet to resume the workflow job. To wait for the workflow job to resume, use the **Wait** parameter of **Resume\-Job**.  
  
-   You can use the job cmdlets to manage a suspended workflow job even if you didn't start the workflow with the **AsJob** parameter.  
  
For more information about cmdlets that behave differently as activities, see the "Activities that Differ from Cmdlets" section of [Using Activities in Script Workflows](../Topic/Using-Activities-in-Script-Workflows.md).  
  
For example, the following commands run a workflow that restarts the local computer. When the workflow is suspended to perform the restart, the commands in the example resume it.  
  
```  
PS C:\>New-ComputerSetup  
  
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command                    
--     ----            -------------   -----         -----------     --------             -------                    
8      Job8            PSWorkflowJob   Suspended     True            localhost            New-ComputerSetup  
  
# Resume the suspended workflow job  
PS C:\>Import-Module PSWorkflow  
PS C:\>Get-Job -Name Job8 | Resume-Job -Wait  
  
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command                    
--     ----            -------------   -----         -----------     --------             -------                    
8      Job8            PSWorkflowJob   Running       True            localhost            New-ComputerSetup  
```  
  
### Automate Resuming the Workflow  
You can create a scheduled job that resumes a workflow after the workflow computer restarts. Be sure to create the scheduled job on the computer that is running the workflow. When the workflow completes, disable or unregister the scheduled job so that it does not run every time the workflow computer starts.  
  
Use the following procedure to resume a suspended workflow when the workflow computer starts.  
  
1.  Use the [New-JobTrigger](http://go.microsoft.com/fwlink/?LinkID=223912) cmdlet to create an **AtStartup** trigger for the scheduled job.  
  
    An **AtStartup** trigger runs a scheduled job every time the computer starts.  
  
2.  Use the [Register-ScheduledJob](http://go.microsoft.com/fwlink/?LinkID=223922) cmdlet to create a scheduled job on the computer that is running the workflow. The commands in the scheduled job resume the suspended workflow job.  
  
3.  When running the workflow, use the **JobName** workflow common parameter. The scheduled job uses the job name to identify the workflow job.  
  
For example, the following commands create the "ResumeWorkflow" scheduled job, which resumes the "ComputerSetup" workflow job as soon as the computer restarts. When you run the New\-ComputerSetup workflow on the local computer in a job named "ComputerSetup," the workflow is suspended just before the computer is restarted. When the computer restarts, the ResumeWorkflow scheduled job resumes the workflow job.  
  
The Get\-Job command verifies that the workflow completed and the final Unregister\-ScheduledJob deletes the scheduled job.  
  
```  
PS C:\>$AtStartup = New-JobTrigger -AtStartup  
  
PS C:\>Register-ScheduledJob -Name ResumeWorkflow -Trigger $AtStartup -ScriptBlock {Import-Module PSWorkflow; Get-Job ComputerSetup -State Suspended | Resume-Job}  
  
Id         Name                JobTriggers     Command                                  Enabled  
--         ----                -----------     -------                                  -------  
1          ResumeWorkflowJob   1               Import-Module PSWorkflow; Get-Job CnS... True  
  
# Run the workflow. It is suspended when the computer restarts.  
PS C:\>New-ComputerSetup -JobName ComputerSetup  
  
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command                    
--     ----            -------------   -----         -----------     --------             -------                    
9      ComputerSetup   PSWorkflowJob   Suspended     True            localhost            New-ComputerSetup  
  
# Verify that the workflow was resumed and completed successfully  
PS C:\>Import-Module PSWorkflow  
PS C:\>Get-Job ComputerSetup  
  
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command                    
--     ----            -------------   -----         -----------     --------             -------                    
9      ComputerSetup   PSWorkflowJob   Completed     True            localhost            New-ComputerSetup  
  
# Delete the scheduled job  
PS C:\>Unregister-ScheduledJob -Name ComputerSetup  
```  
  
## See Also  
[Using Activities in Script Workflows](../Topic/Using-Activities-in-Script-Workflows.md)  
  
