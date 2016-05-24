---
title: Saving Your Workflow in a Module
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 86ca3fab-b670-4ec9-8019-018883a1baa2
author: jpjofre
---
# Saving Your Workflow in a Module
After authoring a [!INCLUDE[wps_2](../Token/wps_2_md.md)] script workflow as described in [Writing a Script Workflow](../Topic/Writing-a-Script-Workflow.md), or [authoring a XAML workflow](http://msdn.microsoft.com/library/dd489396.aspx), you can save the workflow as a module. Storing workflows in a module makes it easier for you to package, distribute, describe, and install them easily.  
  
## <a name="BKMK_save"></a>Prepare your workflow by saving it in a module  
The example workflow in the following procedure, `Install-Role.ps1`, is a [!INCLUDE[wps_2](../Token/wps_2_md.md)] script workflow.  
  
### <a name="BKMK_module"></a>To save a workflow in a module  
  
1.  Create a module directory. The following example command creates a module directory called **ManagedRoles** in the user's **Modules** directory.  
  
    **mkdir C:\\Users\\CoolDev\\WindowsPowerShell\\Modules\\ManagedRoles**  
  
    > [!IMPORTANT]  
    > Do not name a module the same name as any other modules that are located in your module path.  
  
2.  Copy at least one [!INCLUDE[wps_2](../Token/wps_2_md.md)] script\-based or XAML workflow file into the module directory, as shown in the following example command.  
  
    **copy\-item .\\Install\-Role.ps1 \-dest C:\\Users\\CoolDev\\WindowsPowerShell\\Modules\\ManagedRoles**  
  
## See Also  
[Getting Started with Windows PowerShell Workflow](../Topic/Getting-Started-with-Windows-PowerShell-Workflow.md)  
[Writing a Script Workflow](../Topic/Writing-a-Script-Workflow.md)  
[Configuring Your Workflow Environment](../Topic/Configuring-Your-Workflow-Environment.md)  
[Running a Windows PowerShell Workflow](../Topic/Running-a-Windows-PowerShell-Workflow.md)  
[about\_Modules](http://technet.microsoft.com/library/hh847804.aspx)  
  
