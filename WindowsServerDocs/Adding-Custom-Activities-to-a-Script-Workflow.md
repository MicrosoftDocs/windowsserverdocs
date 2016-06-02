---
title: Adding Custom Activities to a Script Workflow
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d47377c9-d73f-4b8d-a6d5-4cdc1755b6bb
author: jpjofre
---
# Adding Custom Activities to a Script Workflow
You can use built\-in activities and custom activities in a [!INCLUDE[wps_1](includes/wps_1_md.md)] workflow. The library of built\-in activities, including cmdlets that are implemented as activities, becomes available when you use the **workflow** keyword. In addition, developers can write custom activities in C\# and include them in XAML workflows and script workflows.  
  
To add a custom activity to a script workflow, use the **Assembly** parameter of the **\#Requires** statement. The **Assembly** parameter identifies the assembly in which the custom activities are defined. When [!INCLUDE[wps_2](includes/wps_2_md.md)] Workflow encounters the **Assembly** parameter, it loads the specified assembly and then processes the custom activities defined in the assembly so that they are available for use in the workflow. The **Assembly** parameter is valid only in workflows.  
  
Valid value formats for the **Assembly** parameter of the **\#Requires** statement are as follows:  
  
-   Fully qualified assembly description  
  
    ```  
    #requires -Assembly MyCommand.Activities.dll Version=1.1.0.0, Culture=neutral, PublicKeyToken=11cd3656ab363bc4"  
    ```  
  
-   Fully qualified path to an assembly  
  
    ```  
    #requires -Assembly C:\Users\Admin01\MyCommand.Activities.dll  
    ```  
  
-   Relative path to an assembly in the local directory or in the global assembly cache  
  
    ```  
    #requires -Assembly MyCommand.Activities.dll  
    ```  
  
To use custom activities from multiple assemblies, enter multiple \#Requires statements. The following sample workflow gets custom activities from two assemblies and uses them in the workflow.  
  
```  
workflow Test-Workflow  
{  
    #requires -Assembly C:\Users\Admin01\MyCommand.Activities.dll.dll  
    #requires -Assembly MyFunction.Activities.dll.dll  
    Get-CustomData -All  
    Set-CustomDataLegacy -PSComputerName ...  
}  
```  
  
For information about writing a custom activity, see "[Creating a Workflow Activity from a Windows PowerShell Cmdlet](http://msdn.microsoft.com/library/hh852743)" in the MSDN Library.  
  

