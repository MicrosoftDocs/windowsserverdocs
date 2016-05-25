---
title: Using Activities in Script Workflows
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 729838ee-e626-41d7-8a69-26790be6e710
author: jpjofre
---
# Using Activities in Script Workflows
This topic lists the [!INCLUDE[wps_2](includes/wps_2_md.md)] Workflow activities and workflow activity parameters. It lists the [!INCLUDE[wps_2](includes/wps_2_md.md)] cmdlets that are implemented as activities for [!INCLUDE[wps_2](includes/wps_2_md.md)] Workflow and those that are excluded.  
  
## Script Workflow Activities  
The following table lists activities that are add to [!INCLUDE[wps_2](includes/wps_2_md.md)] for [!INCLUDE[wps_2](includes/wps_2_md.md)] Workflow. They are valid only in workflows.  
  
||||  
|-|-|-|  
|**Activity**|**Description**|**Topic Reference**|  
|CheckPoint\-Workflow \(alias \= PSPersist\)|Takes a checkpoint. Saves the state and data of a workflow in progress. If the workflow is interrupted or rerun, it can restart from any checkpoint.<br /><br />Use the Checkpoint\-Workflow activity along with the PSPersist workflow common parameter and the PSPersistPreference variable to make your workflow robust and recoverable.|about\_Checkpoint\-Workflow, [Adding Checkpoints to a Script Workflow](Adding-Checkpoints-to-a-Script-Workflow.md)|  
|ForEach \-Parallel|Runs the statements in the script block once for each item in a collection. The items are processed in parallel. The statements in the script block run sequentially.|about\_Foreach\-Parallel|  
|Parallel|All statements in the script block can run at the same time. The order of execution is undefined.|about\_Parallel|  
|Sequence|Creates a block of sequential statements within a parallel script block. The **Sequence** script block runs in parallel with other activities in the **Parallel** script block. However, the statements in the **Sequence** script block run in the order in which they appear. Valid only within a **Parallel** script block.|about\_Sequence|  
|Suspend\-Workflow|Stops a workflow temporarily. To resume the workflow, use the [Resume-Job](http://go.microsoft.com/fwlink/?LinkID=210611) cmdlet.|about\_Suspend\-Workflow|  
  
## Cmdlet Activities  
All cmdlets in the following [!INCLUDE[wps_2](includes/wps_2_md.md)] included modules are available as activities, except for those listed in the [Excluded Cmdlets](Using-Activities-in-Script-Workflows.md#BKMK_Excluded) section. All other cmdlets and functions in **Microsoft.PowerShell.\*** modules are implemented as activities for use in a workflow.  
  
-   Microsoft.PowerShell.Core  
  
-   Microsoft.PowerShell.Host  
  
-   Microsoft.PowerShell.Diagnostics  
  
-   Microsoft.PowerShell.Management  
  
-   Microsoft.PowerShell.Security  
  
-   Microsoft.PowerShell.Utility  
  
-   Microsoft.Wsman.Management  
  
If a cmdlet is not in a [!INCLUDE[wps_2](includes/wps_2_md.md)] Core module, but it is not specifically excluded, [!INCLUDE[wps_2](includes/wps_2_md.md)] Workflow automatically runs the cmdlet in an **InlineScript** activity and returns the output to the workflow.  
  
## Activities that Differ from Cmdlets  
The following [!INCLUDE[wps_2](includes/wps_2_md.md)] Core cmdlets are implemented as activities for use in [!INCLUDE[wps_2](includes/wps_2_md.md)] Workflow. However, the behavior of the activity differs somewhat from the behavior of the cmdlet.  
  
-   **Invoke\-Expression**  
  
    You can use the [Invoke-Expression](http://go.microsoft.com/fwlink/?LinkID=113343) cmdlet to include inline XAML in a script workflow. In workflows, the **Invoke\-Expression** cmdlet has a **Language** parameter that takes a value of "XAML". Use the **Command** parameter to specify the path to the XAML file, as shown in the following example.  
  
    ```  
    Workflow Test-Workflow  
    {  
        Invoke-Expression -Language XAML -Command C:\ps-test\Get-AssetData.xaml  
    }  
    ```  
  
    For more information about the **Invoke\-Expression** cmdlet, see [Invoke-Expression](http://go.microsoft.com/fwlink/?LinkID=113343).  
  
-   **New\-Object**  
  
    In workflows, only the **Typename** and **Argument** parameters are valid.  
  
    For more information about the New\-Object cmdlet, see [New-Object](http://go.microsoft.com/fwlink/?LinkID=113355).  
  
-   **Restart\-Computer**  
  
    In workflows, the **Wait** parameter is valid when restarting the local computer, as well as remote computers.  
  
## <a name="BKMK_Excluded"></a>Excluded Cmdlets  
The following [!INCLUDE[wps_2](includes/wps_2_md.md)] cmdlets have not been implemented as workflow activities. Because they are excluded, [!INCLUDE[wps_2](includes/wps_2_md.md)] Workflow does not automatically run these cmdlets in an **InlineScript** activity automatically. Typically, these cmdlets are not well suited to workflow tasks.  
  
To run these cmdlets, include them in an **inlineScript** activity. The following example shows a call to the [Get-Variable](http://go.microsoft.com/fwlink/?LinkID=113336) cmdlet in an **inlineScript** activity.  
  
```  
Workflow Test-Workflow  
{  
     InlineScript { Get-Variable}  
}  
```  
  
### Excluded Cmdlets  
  
|||  
|-|-|  
|Add\-History|Invoke\-History|  
|Add\-PSSnapin|New\-Alias|  
|Clear\-History|New\-Variable|  
|Clear\-Variable|Out\-GridView|  
|Complete\-Transaction|Remove\-PSBreakpoint|  
|Debug\-Process|Remove\-PSSnapin|  
|Disable\-PSBreakpoint|Remove\-Variable|  
|Enable\-PSBreakpoint|Set\-Alias|  
|Enter\-PSSession|Set\-PSBreakpoint|  
|Exit\-PSSession|Set\-PSDebug|  
|Export\-Alias|Set\-StrictMode|  
|Export\-Console|Set\-TraceMode|  
|Get\-Alias|Set\-Variable|  
|Get\-History|Start\-Transaction|  
|Get\-PSBreakpoint|Start\-Transcript|  
|Get\-PSCallStack|Stop\-Transcript|  
|Get\-PSSnapin|Trace\-Command|  
|Get\-Transaction|Undo\-Transaction|  
|Get\-Variable|Use\-Transaction|  
|Import\-Alias||  
  
## <a name="BKMK_ActivityCommonP"></a>Activity Common Parameters  
[!INCLUDE[wps_2](includes/wps_2_md.md)] Workflow adds the activity common parameters to activities that are derived from the **PSActivity** base class. This category includes the **InlineScript** activity and [!INCLUDE[wps_2](includes/wps_2_md.md)] cmdlets that are implemented as activities, such as [Get-Process](http://go.microsoft.com/fwlink/?LinkID=113324) and [Get-WinEvent](http://go.microsoft.com/fwlink/?LinkID=138336).  
  
The activity common parameters are not valid on the **Suspend\-Workflow** and **Checkpoint\-Workflow** activities and they are not added to cmdlets or expressions that [!INCLUDE[wps_2](includes/wps_2_md.md)] Workflow automatically runs in an **InlineScript** or similar activity. The activity common parameters are available on the **InlineScript** activity, but not on commands in the **InlineScript** script block.  
  
The following table lists the activity common parameters, showing the parameters that are shared with the workflow common parameters and with the [!INCLUDE[wps_2](includes/wps_2_md.md)] common parameters, as well as the parameters that are unique to activities.  
  
For information about the workflow common parameters, see [about_WorkflowCommonParameters](http://go.microsoft.com/fwlink/?LinkID=222527). For information about the [!INCLUDE[wps_2](includes/wps_2_md.md)] common parameters, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216). The parameters that are unique to activities are described in this topic.  
  
The activity common parameters are extremely useful. For example, you can use the **PSComputerName** parameter to run particular activities on only a subset of the target computers. Or, you might use the **PSConnectionRetryCount** and **PSConnectionRetryIntervalSec** parameters to adjust the retry values for particular activities.  
  
The following example shows how to use the workflow common parameters as variables in the workflow and as parameters at the activity level. This command runs the **Get\-Eventlog** cmdlet only on computers in the User01 domain.  
  
```  
Workflow Test-Workflow  
{  
     $User01Domain = Get-Content -Path .\User01Computers.txt  
     $Log = (Get-EventLog -LogName "Windows PowerShell" -PSComputerName $UserDomain}  
     if ($Log) ...  
}  
```  
  
||  
|-|  
|**Workflow Common Parameters**|  
|PSAllowRedirection|  
|PSApplicationName|  
|PSAuthentication|  
|PSCertificateThumbprint|  
|PSComputerName|  
|PSConfigurationName|  
|PSConnectionRetryCount|  
|PSConnectionRetryIntervalSec|  
|PSConnectionURI|  
|PSCredential|  
|PSPersist|  
|PSPort|  
|PSSessionOption|  
|PSUseSSL|  
||  
|**Windows PowerShell Common Parameters**|  
|Debug|  
|ErrorAction|  
|Verbose|  
|WarningAction|  
  
### Activity\-Specific Common Parameters  
  
|||  
|-|-|  
|**Name**|**Definition**|  
|AppendOutput <SwitchParameter>|Adds the output of the activity to the value of the variable. By default, assigning a value to a variable replaces the variable value.<br /><br />For example, the following commands add a process object to the service object in the $x variable.<br /><br />`workflow Test-Workflow { $x = Get-Service; $x = Get-Process -AppendOutput }`|  
|DisplayName <String>|Specifies a friendly name for the activity. The **DisplayName** value appears in the progress bar while the workflow runs and in the value of the Progress property of the workflow job. When the **PSProgressMessage** parameter is also included in the command, the progress bar content appears in `<DisplayName>:<PSProgressMessage>` format.|  
|Input <Object\[\]>|Submits a collection of objects to an activity. This is an alternative to piping objects to the activity one at a time.|  
|MergeErrorToOutput <SwitchParameter>|Adds errors to the output stream. Use this parameter with **Parallel** and **ForEach \-Parallel** keywords to collect errors and output from multiple parallel commands in a single collection.|  
|PSActionRetryCount <Int32>|Tries repeatedly to run the activity if the first attempt fails. The default value, 0, does not retry.|  
|PSActionRetryIntervalSec <Int32>|Determines the interval between action retries in seconds. The default value, 0, retries the action immediately. This parameter is valid only when the **PSActionRetryCount** parameter is also used in the command.|  
|PSActionRunningTimeoutSec <Int32>|Determines how long the activity can run on each target computer. If the activity does not complete before the timeout expires, [!INCLUDE[wps_2](includes/wps_2_md.md)] Workflow generates a terminating error and stops processing the workflow on the affected target computer.|  
|PSDebug <PSDataCollection\[DebugRecord\]>|Adds debug messages from the activity to the specified debug record collection, instead of writing the debug messages to the console or to the value of the **Debug** property of the workflow job. You can add debug messages from multiple activities to the same debug record collection object.<br /><br />To use this activity common parameter, use the [New-Object](http://go.microsoft.com/fwlink/?LinkID=113355) cmdlet to create a **PSDataCollection** object with a type of **DebugRecord** and save the object in a variable. Then, use the variable as the value of the **PSDebug** parameter of one or more activities, as shown in the following example:<br /><br />workflow Test\-Workflow <br />{    <br />     $debugCollection \= New\-Object \-Type System.Management.Automation.PSDataCollection\[System.Management.Automation.DebugRecord\]<br />     InlineScript {\\\\Server01\\Share01\\Get\-AssetData.ps1} \-PSDebug $debugCollection \-Debug $True<br />     InlineScript {\\\\Server01\\Share01\\Set\-AssetData.ps1} \-PSDebug $debugCollection \-Debug $True<br />     if \($debugCollection \-like "\*Missing\*"\) { ...}<br />}|  
|PSDisableSerialization <Boolean>|Directs the activity to return "live" \(not serialized\) objects to the workflow. The resulting objects have methods, as well as properties, but they cannot be saved when a checkpoint is taken.|  
|PSDisableSerializationPreference <Boolean>|Applies the equivalent of the **PSDisableSerialization** parameter to all activities in a workflow, not just one activity. Adding this parameter is generally not recommended, because a workflow that doesn’t serialize its objects cannot be resumed or persisted. Valid values are **True** or **False**.|  
|PSError <PSDataCollection\[ErrorRecord\]>|Adds error messages from the activity to the specified error record collection, instead of writing the error messages to the console or to the value of the **Error** property of the workflow job. You can add error messages from multiple activities to the same error record collection object.<br /><br />To use this activity common parameter, use the [New-Object](http://go.microsoft.com/fwlink/?LinkID=113355) cmdlet to create a **PSDataCollection** object with a type of **ErrorRecord** and save the object in a variable. Then, use the variable as the value of the **PSError** parameter of one or more activities, as shown in the following example:<br /><br />workflow Test\-Workflow <br />{    <br />     $errorCollection \= New\-Object \-Type System.Management.Automation.PSDataCollection\[System.Management.Automation.ErrorRecord\]<br />     InlineScript {\\\\Server01\\Share01\\Get\-AssetData.ps1} \-PSError $errorCollection<br />     InlineScript {\\\\Server01\\Share01\\Set\-AssetData.ps1} \-PSError $errorCollection<br />     if \($errorCollection.Count \-gt 2\) { ...}<br />}|  
|PSProgress <PSDataCollection\[ProgressRecord\]>|Adds progress messages from the activity to the specified progress record collection, instead of writing the progress messages to the console or to the value of the **Progress**  property of the workflow job. You can add progress messages from multiple activities to the same progress record collection object.|  
|PSProgressMessage <String>|Specifies a friendly description of the activity.  The **PSProgressMessage** value appears in the progress bar while the workflow runs. When the **DisplayName** is also included in the command, the progress bar content appears in `<DisplayName>:<PSProgressMessage>` format.<br /><br />This parameter is particularly useful for identifying activities in a **ForEach \-Parallel** script block. Without this message, activities in all parallel branches are identified by the same name.|  
|PSRemotingBehavior <RemotingBehavior>|Specifies how remoting is managed when the activity is run on target computers. **PowerShell** is the default value.<br /><br />Valid values are:<br /><br />**None**:  The activity is not run on remote computers.<br /><br />**PowerShell**: [!INCLUDE[wps_2](includes/wps_2_md.md)] remoting is used to run the activity on target computers.<br /><br />**Custom**: The activity supports its own type of remoting. This value is valid when the cmdlet that is being implemented as an activity sets the value of the **RemotingCapability** attribute to **SupportedByCommand** and the command includes the **ComputerName** parameter.|  
|PSRequiredModules <String\[\]>|Imports the specified modules before running the command. Enter the module names. The modules must be installed on the computer that is running the workflow.<br /><br />Modules that are installed in a path specified in the **PSModulePath** environment variable are automatically imported on first use of any command in the module. Use this parameter to import modules that are not in a **PSModulePath** location.<br /><br />Because each activity in a workflow runs in its own session, an [Import-Module](http://go.microsoft.com/fwlink/?LinkID=141553) command imports a module only into the session in which it runs. It does not import the module into sessions in which other activities run.|  
|PSVerbose <PSDataCollection\[VerboseRecord\]>|Adds verbose messages from the activity to the specified verbose record collection, instead of writing the verbose messages to the console or to the value of the **Verbose**  property of the workflow job. You can add verbose messages from multiple activities to the same verbose record collection object.|  
|PSWarning <PSDataCollection\[WarningRecord\]>|Adds warning messages from the activity to the specified warning record collection, instead of writing the warning messages to the console or to the value of the **Warning**  property of the workflow job. You can add warning messages from multiple activities to the same warning record collection object.|  
|Result|This parameter is valid only in XAML workflows.|  
|UseDefaultInput <Boolean>|Accepts all workflow input as input to the activity by value.<br /><br />For example, the Get\-Process activity in the following sample workflow uses the UseDefaultInput activity common parameter to get input that is passed to the workflow. When you run the workflow with input, that input is used by the activity:<br /><br />workflow Test\-Workflow <br />{<br />    Get\-Service \-UseDefaultInput $True<br />}<br />PS C:\\>Test\-Workflow \-InputObject WinRm<br />Status   Name               DisplayName                            PSComputerName<br />\-\-\-\-\-\-   \-\-\-\-               \-\-\-\-\-\-\-\-\-\-\-                            \-\-\-\-\-\-\-\-\-\-\-\-\-\-<br />Running  winrm              Windows Remote Management \(WS\-Manag... localhost|  
  

