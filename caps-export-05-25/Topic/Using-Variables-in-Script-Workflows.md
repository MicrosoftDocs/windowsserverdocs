---
title: Using Variables in Script Workflows
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5f6e828e-8f80-4109-835b-2749ba8dbefc
author: jpjofre
---
# Using Variables in Script Workflows
This topic explains the rules for using variables in [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow.  
  
## Automatic Variables in Workflows  
All [!INCLUDE[wps_2](../Token/wps_2_md.md)] automatic variables are valid in workflows, except for the automatic variables in the following list. For a complete list of automatic variables, see [about_Automatic_Variables](http://go.microsoft.com/fwlink/?LinkID=113212).  
  
-   $Args  
  
-   $Error  
  
-   $MyInvocation  
  
-   $PID  
  
-   $PSBoundParameters  
  
-   $PsCmdlet  
  
-   $PSCommandPath  
  
-   $PSScriptRoot  
  
-   $StackTrace  
  
In addition, [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow adds the Workflow Runtime Variables to every workflow. For more information, see the [PSWorkflowRunTimeVariable Enumeration](http://msdn.microsoft.com/library/windows/desktop/microsoft.powershell.activities.psworkflowruntimevariable.aspx) help topic in the MSDN Library.  
  
## Windows PowerShell Preference Variables  
All [!INCLUDE[wps_2](../Token/wps_2_md.md)] preference variables are valid in workflows. For a complete list of preference variables, see [about_Preference_Variables](http://go.microsoft.com/fwlink/?LinkID=113248).  
  
## Workflow Preference Variables  
Workflow preference variables are valid only in a workflow. Unlike [!INCLUDE[wps_2](../Token/wps_2_md.md)] preference variables that are set in a session and affect all commands that are run in the session, workflow preference variables are set in a workflow and affect only that workflow.  
  
The following sections list and explain the workflow preference variables.  
  
### $PSDisableSerializationPreference <Boolean>  
Applies the equivalent of the **PSDisableSerialization** parameter to the entire workflow, not just an activity. Adding this variable \(and setting its value to $True\) is generally not recommended, because a workflow that doesn’t serialize its objects cannot be resumed or persisted. The following are valid values for this variable.  
  
-   **$True**: Directs all activities within a workflow to return "live" \(not serialized\) objects. The resulting objects have methods, as well as properties, but they cannot be saved when a checkpoint is taken.  
  
-   **$False**: Workflow objects are serialized.  
  
In the following example, the $PSDisableSerializationPreference variable setting prevents all activities from within the workflow from returning serialized objects.  
  
```  
Workflow Test-Workflow  
{  
    $PSDisableSerializationPreference = $true  
    Activity1  
    Activity2  
    Activity3  
    Activity4  
    Activity5  
}  
```  
  
### $PSParentActivityId <string>  
Establishes an identifier for activities in the current scope and all child scopes. The identifier appears in the progress records for activities in the affected scopes.  
  
For example, in the following workflow, the Get\-Data nested workflow includes the PSParentActivityID preference variable with a value of "GetData\_Section". That ID will appear on all progress records of all activities run in the Get\-Data nested workflow and in any nested workflows or functions in that workflow, such as the Get\-SourceData workflow.  
  
```  
Workflow Test-Workflow  
{  
    Workflow Get-Data  
    {  
        $PSParentActivityId = "GetData_Section"  
        ...  
  
        Workflow Get-SourceData  
        {  
          ...  
        }  
    }  
  
    Get-Data      
}  
```  
  
### $PSPersistPreference <Boolean>  
Adds a checkpoint to a group of activities. A value of $True takes a checkpoint after every activity that follows the variable definition. This value is equivalent to setting the value of the PSPersist activity parameter to $true for all affected activities. To turn off the behavior, set the value of the variable to $False.  
  
In the following workflow, the $PSPersistPreference variable takes a checkpoint after Activity 2, 3, and 4.  
  
```  
Workflow Test-Workflow  
{  
    Activity1  
    $PSPersistPreference = $true      
    Activity2  
    Activity3  
    Activity4  
    $PSPersistPreference = $false      
    Activity5  
}  
```  
  
This variable takes a Boolean value. Valid values are:  
  
1.  **$True**: Adds a checkpoint after each activity, in addition to checkpoints that are specified in the workflow. It affects only activities that follow the variable definition.  
  
2.  **$False**: Stops adding checkpoints. Checkpoints are taken when specified in the workflow  
  
### $PSRunInProcessPreference  
The workflow variable that controls whether activities are run in the process. If this variable is specified, all activities in the enclosing scope are run in the workflow process.  
  
## Workflow Runtime Variables and Common Parameter Variables  
[!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow adds the workflow runtime variables to every workflow. The runtime variables include the workflow common parameters and their values, so you do not have to redefine those variables in your workflow. For more information about the Workflow Runtime Variables, see [PSWorkflowRuntimeVariable Enumeration](http://go.microsoft.com/fwlink/?LinkID=260473). For more information about the workflow common parameters, see [about_WorkflowCommonParameters](http://go.microsoft.com/fwlink/?LinkID=222527).  
  
For example, the following workflow uses the $PSComputerName, $ParentJobName, and $JobName variables. The values of these variables are passed to the workflow and are available for use in the workflow.  
  
```  
Workflow Test-Workflow  
{  
    $PSComputerName  
    $ParentJobName  
    $JobName  
}  
  
PS C:\>Test-Workflow -PSComputerName Server01, Server12 -JobName TestWFJob -AsJob  
Id     Name            PSJobTypeName   State         HasMoreData     Location  
--     ----            -------------   -----         -----------     --------  
83     TestWFJob       PSWorkflowJob   Completed     True            Server01,.  
  
PS C:\> Receive-Job -Keep -ID 83  
Server01  
TestWFJob  
Job84  
Server12  
TestWFJob  
Job85  
```  
  
The workflow runtime variables include other very useful variables. For example, the following workflow uses a few of the runtime variables to get information about the values of session options and the version of [!INCLUDE[wps_2](../Token/wps_2_md.md)] running on the target computer.  
  
```  
Workflow Get-SessionOptions  
{  
    "Computer: $PSComputerName"  
    "Parent Command Name: $ParentCommandName"  
    $p = $PSVersionTable.PSVersion.Major  
    "PSVersion: $p"  
    "Session Options:"  
    $PSSessionOption  
}  
  
PS C:\ps-test> Get-SessionOptions -PSComputerName Server01  
Computer: Server01  
Parent Command Name: Test-Workflow  
PSVersion: 4  
Session Options:  
PSComputerName                    : localhost  
PSSourceJobInstanceId             : b8ecbf21-a49e-4326-a0f1-4829fcdff4a8  
MaximumConnectionRedirectionCount : 5  
NoCompression                     : False  
NoMachineProfile                  : False  
ProxyAccessType                   : None  
ProxyAuthentication               : Negotiate  
ProxyCredential                   :   
SkipCACheck                       : False  
SkipCNCheck                       : False  
SkipRevocationCheck               : False  
OperationTimeout                  : 00:03:00  
NoEncryption                      : False  
UseUTF16                          : False  
IncludePortInSPN                  : False  
OutputBufferingMode               : None  
Culture                           :   
UICulture                         :   
MaximumReceivedDataSizePerCommand :   
MaximumReceivedObjectSize         : 209715200  
ApplicationArguments              :   
OpenTimeout                       : 00:03:00  
CancelTimeout                     : 00:01:00  
IdleTimeout                       : -00:00:00.0010000  
```  
  
To change the values of workflow runtime variables within a workflow, use the Set\-PSWorkflowData activity.  
  
For example, the following workflow includes Set\-PSWorkflowData commands that increment the value of the PSConnectionRetryCount workflow common parameter and reverse the value of the Verbose common parameter from within the workflow.  
  
```  
workflow Test-Workflow  
{  
    "Before: PSConnectionRetryCount is $PSConnectionRetryCount."  
     Set-PSWorkflowData -PSConnectionRetryCount ($PSConnectionRetryCount + 1)  
    "After: PSConnectionRetryCount is $PSConnectionRetryCount."  
  
    "Before: Verbose is $verbose."  
    if ($Verbose) {Set-PSWorkflowData -OtherVariableName Verbose -Value $False}  
    else {Set-PSWorkflowData -OtherVariableName Verbose -Value $True}  
    "After: Verbose is $Verbose."  
}  
PS C:\> Test-Workflow -PSConnectionRetryCount 4 -Verbose  
Before: PSConnectionRetryCount is 4.  
After: PSConnectionRetryCount is 5.  
Before: Verbose is True.  
After: Verbose is False.  
```  
  
## Rules for Variables in Workflows  
This section explains the general rules for using variables in workflows. The sections that follow explain the rules that are specific to activities, loops, and other control statements.  
  
-   Keywords that are reserved in Visual Basic .NET cannot be used as variable names in workflows. For a complete list of reserved keywords, see [Keywords (Visual Basic)](http://msdn.microsoft.com/library/dd409611.aspx).  
  
    ```  
    #Incorrect; date is a reserved keyword  
    workflow Test-Workflow { $date = Get-Date }  
  
    #Correct:  
    workflow Test-Workflow { $currentdate = Get-Date }  
    ```  
  
-   You cannot store the results of sub\-expressions in a variable, because sub\-expressions cannot be persisted.  
  
    ```  
    #Incorrect:   
    $a = $(Get-Process | foreach {$_.Name)   
  
    #Correct:  
    $a = (Get-Process | foreach {$_.Name)  
    ```  
  
-   You cannot assign a variable value to another variable in the same statement.  
  
    ```  
    #Incorrect:   
    $a = $b = 23  
  
    #Correct:  
    $b = 23  
    $a = $b  
    ```  
  
-   You cannot assign a value to an environment variable.  
  
    ```  
    #Incorrect:   
    $env:Temp = "C:\Tmp"  
  
    #Correct:  
    InlineScript {[System.Environment]::SetEnvironmentVariable("C:\Tmp")}  
    ```  
  
-   You cannot use variable references to change property values.  
  
    ```  
    #Incorrect:   
    $o = New-PSSessionOption  
    $o.SkipCACheck = $true  
  
    #Correct:  
    $o = New-PSSessionOption -SkipCACheck  
    ```  
  
## Rules for Variables in Loops, Inline Scripts, and Parallel statements  
Variables that you create in the top\-level scope of a [!INCLUDE[wps_2](../Token/wps_2_md.md)] workflow are called *workflow variables*. Like the variables in a script or function, the commands and expressions in the top\-level scope of a workflow can view and change the value of variables that other commands and expressions create, as shown in the following example.  
  
```  
Workflow Test-Workflow  
{  
$a = 23  
$a++  
$a  
}  
  
PS C:\>Test-Workflow  
24  
```  
  
However, nested scopes, such as loops, inline scripts, and Parallel and Sequence statements, have slightly different rules.  
  
> [!NOTE]  
> Each command in a workflow runs in its own session \("runspace"\). Therefore, without intervention, the command would not be able to view or change the variables created by other commands. However, [!INCLUDE[wps_2](../Token/wps_2_md.md)] Workflow adds all workflow variables to all of the sessions in which top\-level commands run. This feature allows the commands to share variables and view and change their values.  
  
The following table shows the variable rules for different types of nested statements in workflows.  
  
|||||  
|-|-|-|-|  
|Rules for Nested Statements in Workflows|**View workflow variable values**|**Change workflow variable values**|**Internal variables are visible in workflow scope**|  
|**Loops\/Control Statements**|Yes|Yes|Yes|  
|**Parallel \/ Sequence**|Yes|No. Use $Workflow.|No, return the variable.|  
|**InlineScript**|No. Use $Using.|No. Return the variable.  $Workflow is invalid.|No, return the variable.|  
  
### Variables in Loops and Control Statements  
Loop statements, such as those that use the **For**, **While**, and **Do** keywords, and control statements, such as those that use the **If** and **ForEach** keywords, share workflow variables. These statements can view and change workflow variables and the top\-level commands and expressions in a workflow can view and change the variables that are created in the statements.  
  
The following example shows that the **ForEach** statement can access the $a workflow variable and the top\-level commands in the workflow can access the $i variable that is defined in the **ForEach** statement.  
  
```  
Workflow Test-Workflow  
{  
$a = 1,2,3  
  
foreach ($number in $a)   
       {  
         "A = $number"  
         $i++  
       }  
$i  
}  
  
PS C:\>Test-Workflow  
A = 1  
A = 2  
A = 3  
3  
```  
  
### Variables in Parallel and Sequence Statements  
The statements in **Parallel** and **Sequence** script blocks can view the values of workflow variables. However, by default, the statements in **Parallel** and **Sequence** script blocks cannot change the values of workflow variables and cannot create variables that have the same name as workflow variables.  
  
To change the value of a workflow variable in a **Parallel** or **Sequence** block, use the **$Workflow** scope modifier. When you do, the value that is assigned in the **Parallel** or **Sequence** block is available in the workflow scope.  
  
The following example shows how to use the **$Workflow** scope modifier to change the value of a workflow variable and to make the new variable value available in workflow scope.  
  
```  
Workflow Test-Workflow  
{  
    #Workflow (top-level) variable  
    $w = 4  
  
    Parallel  
    {  
        Sequence  
        {  
            # You can get the values of workflow variables.  
            "InSequenceW = $w"  
  
            # To change the value of a workflow variable,   
            # use the $Workflow scope modifier.  
            $Workflow:w = 5  
            "InSequenceWNew = $w"             
        }  
    }  
    # The change is visible in workflow scope.   
    "WorkflowW = $w"      
}  
  
PS C:\>Test-Workflow  
InSequenceW = 4  
InSequenceWNew = 5  
WorkflowW = 5  
```  
  
Variables that are defined in a child scope, such as a Parallel or Sequence block, are not visible in any parent scope. To make them visible, return the value to the parent scope, as shown in the following example.  
  
```  
Workflow Test-Workflow  
{         
    Parallel  
    {  
        Sequence  
        {  
            #Variables defined in parallel/sequence ...  
            $s = 3              
        }          
    }  
    # ... are not available in workflow scope.      
    "S = $s"  
  
    $TFromSequence = Parallel  
    {  
        Sequence  
        {  
            #To export variable values from   
            # parallel/sequence, return the value.  
            $t = 3  
            $t     
        }          
    }     
    "T = $TFromSequence"  
}  
  
PS C:\>Test-Workflow  
S =   
T = 3  
```  
  
### Variables in an InlineScript Activity  
The **InlineScript** activity runs commands and expressions in a standard [!INCLUDE[wps_2](../Token/wps_2_md.md)] session and returns the results to the workflow.  
  
By default, the variables that are defined in a workflow are not visible to the commands in an **InlineScript** script block. To make workflow variables visible in **InlineScript**, use the **$Using** scope modifier. The **$Using** scope modifier is required only once for each variable in the **InlineScript** script block, as shown in the following example.  
  
```  
workflow Test-Workflow  
{  
    $a = 3  
  
    # Without $Using, the $a workflow variable is not visible  
    # in inline script.  
    InlineScript {"Inline A0 = $a"}  
  
    # Using imports the variable and its current value.  
    InlineScript {"Inline A1 = $Using:a"}  
}  
  
PS C:\> Test-Workflow  
Inline A0 =   
Inline A1 = 3  
```  
  
Commands in an InlineScript script block can change the value of variables that were imported from workflow scope, but the changes are not visible in workflow scope. To make them visible, return the changed value to the workflow scope, as shown in the following example.  
  
```  
workflow Test-Workflow  
{  
    $a = 3  
  
    # Changes to variable value in an InlineScript do not affect  
    # the value of the workflow variable.  
    InlineScript {$a = $Using:a + 1; "Inline A = $a"}  
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
  
> [!NOTE]  
> Troubleshooting Note:  A statement with the **$Using** scope modifier and the imported variable should appear before any use of the variable in the **InlineScript** script block. In [!INCLUDE[wps_2](../Token/wps_2_md.md)] 3.0 and newer releases of [!INCLUDE[wps_2](../Token/wps_2_md.md)], the **$Using** scope modifier can appear anywhere in the **InlineScript** script block.  
  
