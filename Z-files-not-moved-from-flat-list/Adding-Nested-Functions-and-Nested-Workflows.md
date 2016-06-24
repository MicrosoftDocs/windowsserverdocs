---
title: Adding Nested Functions and Nested Workflows
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7c71dba4-272b-4698-8f2b-db0f4b343a4b
author: jpjofre
---
# Adding Nested Functions and Nested Workflows
In [!INCLUDE[wps_1](includes/wps_1_md.md)] Workflow, you can include functions and nested workflows to reuse and organize the commands in a script workflow. This topic explains the rules for creating and calling nested functions and workflows.  
  
## Adding Nested Functions and Nested Workflows  
You can include functions and nested workflows to organize the commands in a script workflow. There are no syntactic limits to nesting depth. For example, the following workflow includes nested workflows and nested functions.  
  
```  
workflow One   
{  
    "One"  
    Two  
    workflow Two  
    {  
        "Two"  
        Three  
        Function Three  
        {  
            "Three"  
            function Five {"Five"}  
            Workflow Four {"Four"; Five}  
            Four              
        }      
    }       
}  
```  
  
## Using Parameters and Variables in Nested Functions and Workflows  
In general, child scopes inherit from the parent scope. Nested functions and workflows in a workflow can get the values of workflow parameters and the values of variables created in the top-level workflow scope. However, the values of variables created and changed in the child scope are not available in the parent scope.  
  
> [!NOTE]  
> TROUBLESHOOTING NOTE: The values of variables created in the workflows scope might not be available to nested functions. The values of workflow parameters and of variables created in the workflow scope might not be available to nested workflows.  
>   
> Workflows that are nested three levels deep do not support any common parameters, including workflow common parameters.  
  
To assure that nested workflows and functions have access to the values of workflow parameters and the values of variables created in workflow scope, define the parameter on the nested function or workflow. Then, when calling the nested function or workflow, pass the parameter value.  
  
For example, the following sample workflow includes the Get-ModuleAlias nested workflow. To assure that the nested workflow has access to the value of the ModuleName parameter of the workflow, define a similar parameter on the nested workflow and pass the ModuleName parameter value when calling the nested workflow.  
  
```  
Workflow Get-ModuleProperties  
{  
    Param  
    (  
         [parameter(Mandatory=$true)]  
         [String]  
         $ModuleName  
    )  
  
    workflow Get-ModuleAlias  
    {  
      Param  
      (  
         [parameter(Mandatory=$true)]  
         [String]  
         $ModuleNameForAlias,  
  
       )  
       ((Get-Module -Name $ModuleNameForAlias -ListAvailable).ExportedAliases).Keys  
    }   
    Get-ModuleAlias -ModuleName $ModuleNameForAlias  
}  
```  
  
## Calling Nested Workflows and Functions  
This section explains the rules for calling nested functions and workflows in a workflow that differ from the rules for nested elements in standard functions and scripts.  
  
-   The order in which the nested workflows and functions are defined in the workflow is not important. You can call a function or nested workflow before it is defined in the workflow, as shown in the following example.  
  
    ```  
    Workflow Test-Workflow  
    {  
        param ($ModuleName)  
  
        function Initialize-Files  
        { ... }  
  
        workflow Get-Metadta  
        {   
            ...  
            Initialize-Files  
            Get-Configuration  
            Get-DataSource  
            Get-Module -ModuleName $ModuleName          
            function Get-DataSource   
            {  
               ...  
            }  
        }  
  
        function Get-Configuration  
        {  
           ...  
        }   
    }  
    ```  
  
-   Nested workflows can call workflows and functions in the current scope and any parent scope, as shown in the following example.  
  
    ```  
    # In Test-Nested.ps1  
    function Zero {"Zero"}  
    workflow One   
    {  
        "One"  
        Two  
        Three  
        Four  
        workflow Four   
        {  
            "Four"; Two; Three; Five;   
            workflow Five {"Five"; Two; Three; Zero}  
        }  
    }   
    function Two {"Two"}  
    workflow Three {"Three"}  
    One  
    ```  
  
    The output of the Test-Nested.ps1 script is as follows.  
  
    ```  
    PS C:\Test-Nested.ps1  
    One  
    Two  
    Three  
    Four  
    Two  
    Three  
    Five  
    Two  
    Three  
    Zero  
    ```  
  
-   Recursive calling, as shown in the following example, is not permitted in workflows.  
  
    ```  
    workflow one  
    {  
        "One"  
        Two  
    }  
  
    workflow two  
    {  
        "Two"  
        One      
    }  
    ```  
  
    Recursive calls are permitted in scripts and functions.  
  
-   Workflow and function names can be used only once in each workflow. Name conflicts generate errors, as shown in the following example.  
  
    ```  
    workflow Test-Workflow  
    {  
        workflow Test1 {"Test1"}  
        function Test1 {"Hello, Test1"}  
    }  
  
    At line:4 char:5  
    +     function Test1 {"Hello, Test1"}  
    +     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
    The function or workflow 'Test1' cannot be redefined.  
        + CategoryInfo          : ParserError: (:) [], ParseException  
        + FullyQualifiedErrorId : FunctionRedefinitionNotAllowed  
    ```  
  
-   If the name of a nested workflow or function is the same as the name of a workflow or function in a parent scope, calls to that name will call the workflow or function in the current (workflow) scope.  
  
    In the following example, the call to "Test-Nested" calls the Test-Nested workflow. If the Test-Nested workflow had a different name, the call to "Test-Nested" would call the Test-Nested function.  
  
    ```  
    function Test-Nested {"Test-Nested Function"}  
    workflow Test-Workflow  
    {  
        Workflow Test-Nested {"Test-Nested Workflow"}  
        Test-Nested          
    }   
    PS C:\>Test-Workflow   
    Test-Nested Workflow  
    ```  
  
    In a standard [!INCLUDE[wps_2](includes/wps_2_md.md)] script or function, names of nested functions can be reused. Calls invoke the last function defined with the specific name before the call.  
  

