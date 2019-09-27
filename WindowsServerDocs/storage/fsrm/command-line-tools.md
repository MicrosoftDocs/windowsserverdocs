---
title: File Server Resource Manager Command-Line Tools
description: This article describes Windows Server 2016 command-line tools
ms.date: 7/7/2017
ms.prod: windows-server
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# File Server Resource Manager command-line tools

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

File Server Resource Manager installs the [FileServerResourceManager](https://technet.microsoft.com/itpro/powershell/windows/fileserverresourcemanager/fileserverresourcemanager)
PowerShell cmdlets as well as the following command-line tools:

-   **Dirquota.exe**. Use to create and manage quotas, auto apply quotas, and quota templates.
-   **Filescrn.exe**. Use to create and manage file screens, file screen templates, file screen exceptions, and file groups.
-   **Storrept.exe**. Use to configure report parameters and generate storage reports on demand. Also use to create report tasks, which you can schedule by using **schtasks.exe**.

You can use these tools to manage storage resources on a local computer or a remote computer. For more information about these command-line tools, see the following references:

-   **Dirquota**: <https://go.microsoft.com/fwlink/?LinkId=92741>
-   **Filescrn**: <https://go.microsoft.com/fwlink/?LinkId=92742>
-   **Storrept**: <https://go.microsoft.com/fwlink/?LinkId=92743>


> [!Note]
> To see command syntax and the available parameters for a command, run the command with the <strong>/?</strong> parameter.


## Remote management using the command-line tools

Each tool has several options for performing actions similar to those that are available in the File Server Resource Manager MMC snap-in. To have a command perform an action on a remote computer instead of the local computer, use the **/remote**:*ComputerName* parameter.

For example,**Dirquota.exe** includes a **template export** parameter to write quota template settings to an XML file, and a **template import** parameter to import template settings from the XML file. Adding the **/remote**:*ComputerName* parameter to the **Dirquota.exe template import** command will import the templates from the XML file on the local computer to the remote computer.

> [!Note]
> When you run the command-line tools with the **/remote**:<em>ComputerName</em> parameter to perform a template export (or import) on a remote computer, the templates are written to (or copied from) an XML file on the local computer.

<br />

## Additional considerations 

To manage remote resources with the command-line tools:

-   You must be logged on with a domain account that is a member of the **Administrators** group on the local computer and on the remote computer.
-   You must run the command-line tools from an elevated Command Prompt window. To open an elevated Command Prompt window, click **Start**, point to **All Programs**, click **Accessories**, right-click **Command Prompt**, and then click **Run as administrator**.
-   The remote computer must be running Windows Server, and File Server Resource Manager must be installed.
-   The **Remote File Server Resource Manager Management** exception on the remote computer must be enabled. Enable this exception by using Windows Firewall in Control Panel.


## See also

-   [Managing Remote Storage Resources](managing-remote-storage-resources.md)