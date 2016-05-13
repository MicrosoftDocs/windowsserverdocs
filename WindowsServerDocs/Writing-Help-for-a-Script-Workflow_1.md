---
title: Writing Help for a Script Workflow_1
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 45b77706-ac31-4b89-a097-ebe9b2f6d87a
---
# Writing Help for a Script Workflow_1
This topic explains how to provide help topics for the script workflows that you author. For general information about writing help for commands in a module, see [How to Write Help for Windows PowerShell Modules](http://msdn.microsoft.com/library/dd878343) in the MSDN Library.

## Supporting the Get\-Help Cmdlet
The [Get-Help](http://go.microsoft.com/fwlink/?LinkID=113316) cmdlet gets help for commands in modules, including the script workflows in modules. To write help topics for the script workflows that you author, use the following procedure.

1.  Include the script workflow in a script module \(.psm1\).

2.  Use the XML\-based cmdlet help topic format to write a help topic for the script workflow.

3.  Add an **.ExternalHelp** comment that specifies the name of the XML\-based cmdlet help topic for the workflow.

Comment\-based help is not supported in workflows, except for the **.ExternalHelp** comment that identifies the help file for the workflow.

There are no requirements for the file names of help topics for script modules. The recommended name format is as follows:

```
<Script-module-base-name>.psm1-help.xml
```

For example, the recommended help file for the DeploymentWorkflow.psm1 script module is as follows.

```
DeploymentWorkflow.psm1-help.xml
```

To enable the **Get\-Help** cmdlet to locate the help topic for the script workflow, use an **.ExternalHelp** comment. The follow example shows an .ExternalHelp comment for in a script workflow in the DeploymentWorkflow.psm1 script module.

```
#.ExternalHelp DeploymentWorkflow.psm1-help.xml
Workflow New-Package
{
     ...
}
Workflow Set-Package
{
     ...
}
```

For more information about using the .ExternalHelp comment, see [about_Comment_Based_Help](http://go.microsoft.com/fwlink/?LinkID=144309).

## Supporting Online Help
The **Online** parameter of the [Get-Help](http://go.microsoft.com/fwlink/?LinkID=113316) cmdlet opens the online version of the help topic for a command in the user's default Internet browser. The **Online** parameter gets the Uniform Resource Identifier \(URI\) for the online help topic from the **HelpUri** property of the command.

To supply a value for the **HelpUri** property of a script workflow, add the **HelpUri** attribute of the **CmdletBinding** attribute, as shown in the following example. This is the same technique that is used to add the HelpUri attribute to an advanced function.

```
#.ExternalHelp DeploymentWorkflow.psm1-help.xml
Workflow New-Package
{
    [CmdletBinding(HelpURI="http://www.fabrikam.com/?TopicID=NewPackage")]

    Param ([Parameter]$ServerName)
     ...
}
```

To verify that the HelpUri property value is effective, use the [Get-Command](http://go.microsoft.com/fwlink/?LinkID=113309) cmdlet to get the HelpUri property of the script workflow.

```
Workflow New-Package
{
    [CmdletBinding(HelpURI="http://www.fabrikam.com/?LinkID=242132")]

    Param ([Parameter]$ServerName)          
}

PS C:\> (Get-Command Deploy-Update).HelpUri
http://www.fabrikam.com/?TopicID=NewPackage
```

For more information about supporting online help for the commands in a module, see [Supporting Online Help](http://go.microsoft.com/fwlink/?LinkID=242132) in the MSDN Library.

## Supporting Updatable Help
The [Update-Help](http://go.microsoft.com/fwlink/?LinkID=210614) and [Save-Help](http://go.microsoft.com/fwlink/?LinkID=210612) cmdlets download the newest help files for a module from the Internet or a file share and install them on the local computer. You can provide updated help topics for the workflows in a script module by using the same procedure you use for types of command in the module.

For more information about supporting Updatable Help for the commands in a module, see [Supporting Online Help](http://go.microsoft.com/fwlink/?LinkID=242132) in the MSDN Library.

## See Also
[about_Comment_Based_Help](http://go.microsoft.com/fwlink/?LinkID=144309)
[Get-Help](http://go.microsoft.com/fwlink/?LinkID=113316)
[Supporting Online Help](http://go.microsoft.com/fwlink/?LinkID=242132)
[Supporting Online Help](http://go.microsoft.com/fwlink/?LinkID=242132)
[Update-Help](http://go.microsoft.com/fwlink/?LinkID=210614)
[Save-Help](http://go.microsoft.com/fwlink/?LinkID=210612)


